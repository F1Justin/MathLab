#!/usr/bin/env python3
"""Replay the shifted-runner replacement certificates using exact arithmetic."""

import json
from collections import defaultdict
from fractions import Fraction
from heapq import merge
from itertools import groupby
from math import gcd, lcm
from pathlib import Path


def covered(intervals, left, right):
    for lower, upper in intervals:
        if lower > left:
            return False
        left = max(left, upper)
        if left >= right:
            return True
    return False


def smooth(speed):
    assert speed > 0
    for prime in (2, 3, 5):
        while speed % prime == 0:
            speed //= prime
    return speed == 1


def unpack(recipe, base_rules):
    proposed_deletions = set()
    candidates = defaultdict(set)
    for copy in recipe["rules"]:
        rule = base_rules[copy["L"]]
        scale = copy["s"]
        assert scale > 0 and scale % 2 == 1
        assert copy["reflect"] in (0, 1) and copy["half"] in (0, 1)
        sign = 1 - 2 * copy["reflect"]
        proposed_deletions.update(scale * v for v in rule["deleted"])
        for speeds, constant, slope in rule["groups"]:
            for v in speeds:
                speed = scale * v
                adjusted = sign * constant + 2 * copy["half"] * (speed % 2)
                candidates[speed].add((adjusted % 4, sign * slope))

    deleted = set(recipe["deleted"])
    assert deleted <= proposed_deletions
    ties = {int(v): tuple(label) for v, label in recipe["ties_q4"].items()}
    assert ties.keys() == {
        v for v, labels in candidates.items() if v not in deleted and len(labels) > 1
    }
    installed = {}
    for v, labels in sorted(candidates.items()):
        if v not in deleted:
            installed[v] = ties[v] if v in ties else next(iter(labels))
            assert installed[v] in labels
    assert proposed_deletions <= deleted | installed.keys()
    inserted = {v for v in installed if v % 2}
    assert inserted == set(recipe["inserted_odds"])
    assert len(deleted) - len(inserted) == recipe["gain"]

    affected = deleted | {v for v in installed if v % 2 == 0}
    assert all(0 < v <= 2 * recipe["K"] and v % 4 == 0 for v in affected)
    assert all(smooth(v) for v in affected | installed.keys())
    return affected, installed


def check_recipe(recipe, base_rules):
    affected, installed = unpack(recipe, base_rules)
    checked = 0
    for q in sorted(affected):
        arcs = sorted(
            (Fraction((-4 - h) * q, 4 * v), Fraction((4 - h) * q, 4 * v), v, a)
            for v, (a, h) in installed.items()
            if 4 * v % q == 0
        )
        for k in range(q):
            if gcd(k, q) == 1:
                active = ((left, right) for left, right, v, a in arcs if (4*v*k+a*q) % (4*q) == 0)
                assert covered(active, -1, 1), (recipe["K"], q, k)
                checked += 1
    return checked


def check_circle(recipe, base_rules):
    """Cross-check the 476-track example directly, without the residue argument."""
    n = recipe["K"]
    affected, installed = unpack(recipe, base_rules)
    tracks = {v: (0, 0) for v in range(2, 2 * n + 1, 2) if v not in affected}
    tracks.update(installed)
    assert len(tracks) == 476 and n == 480
    scale = 4 * (n + 1)
    intervals = []
    for v, (a, h) in tracks.items():
        s = (a * (n + 1) + h) % scale
        for k in range(v + 2):
            middle = k * scale - s
            if middle + 4 >= 0 and middle - 4 <= v * scale:
                intervals.append((
                    Fraction(middle - 4, scale * v), Fraction(middle + 4, scale * v)
                ))
    assert covered(sorted(intervals), 0, 1)
    return len(intervals)


def count_and_discrepancy(thresholds, first_rule):
    head, cycle = thresholds[:-3], thresholds[-3:]
    assert cycle[-1] < 5 * cycle[0]
    support = set(first_rule["deleted"]) | {v for speeds, _, _ in first_rule["groups"] for v in speeds}
    assert all(v % 5 for v in support) and {v for v in support if v % 9 == 0} == {9}
    assert 1 not in support
    triple_threshold = max(v for v in support if v % 2 == 0) // 2 * 81
    assert triple_threshold == head[-1] == 7776
    assert 96 * 9**3 > max(5 * head[-1], cycle[-1])

    rows = [
        (t * r, t * m)
        for m, group in ((30, head), (6, cycle))
        for t in group
        for r in range(1, m)
        if gcd(r, m) == 1
    ]
    period = lcm(*(step for _, step in rows))
    gain = sum(period // step for _, step in rows)
    slope = Fraction(gain, period)
    p, q = slope.as_integer_ratio()
    assert (period, gain, p, q) == (87480000, 721420, 36071, 4374000)

    running = worst = witness = 0
    streams = (range(start, period + 1, step) for start, step in rows)
    for hit, hits in groupby(merge(*streams)):
        discrepancy = p * (hit - 1) - q * running
        if discrepancy > worst:
            worst, witness = discrepancy, hit - 1
        running += sum(1 for _ in hits)
    assert running == gain and p * period - q * running == 0
    assert (worst, witness) == (16045969, 4239239)

    def count(n):
        return sum((n + step - start) // step for start, step in rows)

    assert count(witness) == 34956
    assert all(count(126 * h) >= h for h in range(1029))
    assert sum(126 * 1029 // step for _, step in rows) == 1038
    finite = (p, q - 1 - worst, q - p)
    assert finite == (36071, -11671970, 4337929)
    assert count(100828) >= 828 and (p * 100000 + finite[1]) // finite[2] == 828

    density = slope + Fraction(4, 15 * 96 * 9**3) * Fraction(9, 8) * Fraction(5, 4)
    assert density == Fraction(577511, 69984000)
    lower_bound = density / (1 - density)
    assert lower_bound == Fraction(577511, 69406489)
    return finite, lower_bound


def main():
    if not __debug__:
        raise SystemExit("Run without -O so the exact checks are enabled.")
    data = json.loads(Path(__file__).with_name("recipes.json").read_text())
    base_rules = data["base_rules"]
    recipes = sorted(data["recipes"], key=lambda r: r["gain"])
    thresholds = [r["K"] for r in recipes]
    assert [r["gain"] for r in recipes] == list(range(1, 17))
    assert thresholds == [
        96, 120, 216, 480, 600, 864, 1080, 2400,
        3000, 4320, 5400, 5832, 7776, 12000, 15000, 21600,
    ]
    for recipe in recipes:
        checked = check_recipe(recipe, base_rules)
        print(f"seed size {recipe['K']:5}  gain {recipe['gain']:2}  primitive centers {checked:7}", flush=True)
    arcs = check_circle(recipes[3], base_rules)
    finite, lower_bound = count_and_discrepancy(thresholds, base_rules["A"])
    print(f"476 distinct positive speeds cover the circle at radius 1/481 ({arcs} exact arcs).")
    print(f"Finite guarantees floor(n/125) and floor(({finite[0]}n{finite[1]})/{finite[2]}).")
    print(f"Asymptotic lower bound liminf E_n/n ≥ {lower_bound}.")


if __name__ == "__main__":
    main()
