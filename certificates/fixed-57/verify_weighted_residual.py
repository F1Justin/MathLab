#!/usr/bin/env python3
"""Verify the weighted obstruction for the fixed 57-runner seed."""

from bisect import bisect_right
from collections import defaultdict
from fractions import Fraction
import json
from pathlib import Path

from hashlib import sha256

SEED_SHA256 = "c13ff152619c2dfeca4aef794c2ee9e677db8850897072485dd7cffef8790bdd"

def load_seed():
    records = [json.loads((Path(__file__).with_name("upstream-seed-57.json")).read_text())]
    rows = [row for row in records if row["n"] == 57]
    require(len(rows) == 1, "Expected exactly one 57-runner record")
    row = rows[0]
    encoded = json.dumps(row, sort_keys=True, separators=(",", ":")).encode("ascii")
    require(sha256(encoded).hexdigest() == SEED_SHA256, "The published 57-runner seed has changed")
    tracks = list(zip(row["speeds"], (Fraction(n, row["shift_den"]) for n in row["shift_num"]),
                      strict=True))
    require(len({v for v, _ in tracks}) == len(tracks) == 57, "The seed speeds must be distinct")
    require(all(v > 0 and 0 <= s < 1 for v, s in tracks), "Invalid seed speed or shift")
    return tracks, Fraction(row["gamma"])




CERTIFICATE = Path(__file__).with_name("weighted_residual.json")


def require(condition, message):
    if not condition:
        raise ValueError(message)


def phase_peak(support, speed, period, width):
    """Maximum scaled weight by sweeping a piecewise constant phase density."""
    events = defaultdict(int, {0: 0, period: 0})
    full_period_mass = 0
    for a, b, weight in support:
        full_periods, remainder = divmod(speed * (b - a), period)
        full_period_mass += full_periods * width * weight
        if not remainder:
            continue
        start = speed * a % period
        end = start + remainder
        events[start] += weight
        if end > period:
            events[period] -= weight
            events[0] += weight
            end -= period
        events[end] -= weight

    points = sorted(events)
    densities = []
    prefix = [0]
    density = 0
    for left, right in zip(points, points[1:]):
        density += events[left]
        densities.append(density)
        prefix.append(prefix[-1] + (right - left) * density)

    def primitive(end):
        turns, residue = divmod(end, period)
        i = bisect_right(points, residue) - 1
        return turns * prefix[-1] + prefix[i] + (residue - points[i]) * densities[i]

    # The window integral is affine between the events and their shifts.
    cuts = set(points[:-1]) | {(point - width) % period for point in points[:-1]}
    return full_period_mass + max(primitive(cut + width) - primitive(cut) for cut in cuts)


def window_mass(support, speed, start, period, width):
    """Check a claimed maximizing window by direct endpoint differences."""
    def primitive(x):
        periods, residue = divmod(x, period)
        return periods * width + min(residue, width)

    return sum(weight * (primitive(speed * b - start) - primitive(speed * a - start))
               for a, b, weight in support)


def verify():
    data = json.loads(CERTIFICATE.read_text(encoding="utf-8"))
    tracks, _ = load_seed()
    require(data["seed_sha256"] == SEED_SHA256, "Certificate cites a different seed")
    period, width = data["period"], data["width"]
    require(type(period) is int and type(width) is int and period > 0 and 59 * width == 2 * period,
            "The window must have radius 1/59")
    support = data["support"]
    require(len(support) == 121, "Expected 121 positive-weight intervals")
    previous = 0
    for a, b, weight in support:
        require(all(type(x) is int for x in (a, b, weight))
                and previous <= a < b <= period and weight > 0, "Invalid support interval")
        previous = b
        for speed, phase in tracks:
            left = phase + Fraction(speed * a, period)
            right = phase + Fraction(speed * b, period)
            winding = left.numerator // left.denominator
            require(winding + Fraction(1, 59) <= left and right <= winding + 1 - Fraction(1, 59),
                    f"Seed covers an interior point of [{a}, {b}]")

    total = sum((b - a) * weight for a, b, weight in support)
    weight_sum = sum(weight for _, _, weight in support)
    require(total == data["total_mass"] and weight_sum == data["total_weight"],
            "The reported support totals disagree")
    cutoff = data["speed_cutoff"]
    require(type(cutoff) is int and cutoff > 0, "Invalid finite speed cutoff")
    claimed = Fraction(data["maximum"])
    require(0 < claimed < Fraction(1, 7), "The claimed cap does not exclude seven runners")
    for speed in range(1, cutoff + 1):
        mass = phase_peak(support, speed, period, width)
        require(mass * claimed.denominator <= claimed.numerator * speed * total,
                f"Claimed cap is exceeded at speed {speed}")

    witness_speed = data["maximizing_speed"]
    witness_start = data["maximizing_window_start"]
    require(type(witness_speed) is int and 1 <= witness_speed <= cutoff
            and type(witness_start) is int and 0 <= witness_start < period,
            "Invalid maximizing window")
    witness_mass = window_mass(support, witness_speed, witness_start, period, width)
    require(Fraction(witness_mass, witness_speed * total) == claimed,
            "The stated window does not attain the cap")
    tail = Fraction(width, period) + Fraction(width * weight_sum, (cutoff + 1) * total)
    require(tail < claimed, "The high-speed tail exceeds the stated global cap")

    return {
        "intervals": len(support),
        "weighted_length": total,
        "finite_speeds_checked": cutoff,
        "maximizing_speed": witness_speed,
        "maximizing_window_start": witness_start,
        "global_capacity": str(claimed),
        "high_speed_upper_bound": str(tail),
        "seven_runner_upper_bound": str(7 * claimed),
    }


if __name__ == "__main__":
    print(json.dumps(verify(), indent=2))
