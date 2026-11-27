"""Check the weighted primitive-row obstruction, using integer windows only."""
from collections import defaultdict
from fractions import Fraction
import json
from math import gcd, lcm
from pathlib import Path

HERE = Path(__file__).resolve().parent


def atoms(data):
    points = []
    for q, d, magnitude, weight in data["rows"]:
        z, w = Fraction(magnitude), Fraction(weight)
        assert 2 <= q <= data["L"] and q % 2 == 0 and w > 0
        assert d == q or (q % 4 == 2 and d == q // 2)
        assert Fraction(1, 1 + data["L"] // q) < z <= 1
        units = [k for k in range(d) if gcd(k, d) == 1]
        for k in units:
            assert gcd(k * (q // d), q // 2) == 1
            for sign in (-1, 1):
                points.append((Fraction(k, d), sign * z / q, w / (2 * len(units))))
    return points


def max_window(points, speed, scale):
    """Largest mass in a closed window of width 2/speed, on sorted slopes."""
    left = value = peak = 0
    for right, weight in points:
        value += weight
        while speed * (right - points[left][0]) > 2 * scale:
            value -= points[left][1]
            left += 1
        peak = max(peak, value)
    return peak


def verify(data):
    if not __debug__:
        raise RuntimeError("Run with assertions enabled.")
    limit, cutoff = data["L"], data["tail_from"]
    assert limit == 46 and cutoff > limit
    premia = {v: Fraction(p) for v, p in data["premia"]}
    assert len(premia) == len(data["premia"])
    assert all(v > 0 and p >= 0 for v, p in premia.items())
    points = atoms(data)
    phase_scale, slope_scale, mass_scale = (
        lcm(*(p[i].denominator for p in points)) for i in range(3)
    )
    indexed = sorted(
        ((int(c * phase_scale), int(x * slope_scale), int(w * mass_scale))
         for c, x, w in points),
        key=lambda p: p[1],
    )
    peak_tail = max_window([(x, w) for _, x, w in indexed], cutoff, slope_scale)
    assert peak_tail <= mass_scale
    for speed in range(1, cutoff):
        if speed % 2 == 0 and speed > limit:
            continue  # The probe condition excludes all free zero-phase even tracks.
        by_phase = defaultdict(list)
        for c, x, w in indexed:
            by_phase[(speed * c) % phase_scale].append((x, w))
        peak = max(max_window(group, speed, slope_scale) for group in by_phase.values())
        assert Fraction(peak, mass_scale) <= 1 + premia.get(speed, 0), speed
    total = sum(p[2] for p in points)
    bound = total - sum(premia.values())
    assert bound > limit // 2 - 1
    return dict(
        L=limit, probes=len(points), weight=str(total), tail_from=cutoff,
        tail_capacity=str(Fraction(peak_tail, mass_scale)),
        penalties={v: str(p) for v, p in premia.items()},
        lower_bound=str(bound), minimum_tracks=limit // 2,
    )


if __name__ == "__main__":
    print(json.dumps(verify(json.loads((HERE / "local_mass_46.json").read_text())), indent=2))
