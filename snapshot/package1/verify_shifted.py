#!/usr/bin/env python3
"""Independent rational arc-cover verifier for shifted-runner certificates.

This certifies gamma <= delta < 1/(n+1). It does not claim that the stored
gamma is the exact maximum: gamma is used only to choose a candidate delta.
The known example data is credited in tasks/shifted_runner.md.
"""
import argparse
from fractions import Fraction as Q
import json
from pathlib import Path


def covers(intervals):
    right = Q(0)
    for lo, hi in sorted(intervals):
        if lo > right:
            return False, (right, lo)
        right = max(right, hi)
        if right >= 1:
            return True, None
    return False, (right, Q(1))


def verify(c):
    n, speeds = c['n'], c['speeds']
    nums, den = c['shift_num'], c['shift_den']
    if type(n) is not int or n < 1 or len(speeds) != n or len(nums) != n:
        raise ValueError('Invalid dimensions')
    if any(type(v) is not int or v <= 0 for v in speeds) or len(set(speeds)) != n:
        raise ValueError('Speeds must be distinct positive integers')
    if type(den) is not int or den <= 0 or any(type(a) is not int for a in nums):
        raise ValueError('Shifts must have integer numerators and positive integer denominator')
    claimed = Q(c['gamma'])
    threshold = Q(1, n + 1)
    if not 0 <= claimed < threshold:
        raise ValueError('Claimed bound is outside the candidate range')
    delta = (claimed + threshold) / 2
    arcs = []
    for v, a in zip(speeds, nums):
        s = Q(a % den, den)
        # t in [0,1], s in [0,1), delta < 1/2: these include all relevant k.
        for k in range(v + 2):
            lo, hi = (k - s - delta) / v, (k - s + delta) / v
            lo, hi = max(Q(0), lo), min(Q(1), hi)
            if lo <= hi:
                arcs.append((lo, hi))
    ok, gap = covers(arcs)
    return {'n': n, 'certified': ok, 'delta': str(delta),
            'threshold': str(threshold), 'arcs': len(arcs),
            'gap': [str(x) for x in gap] if gap else None,
            'meaning': 'gamma <= delta < threshold' if ok else 'uncovered interval found'}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('certificate', type=Path)
    args = ap.parse_args()
    assert covers([(Q(0), Q(1,2)), (Q(1,2), Q(1))])[0]
    assert not covers([(Q(0), Q(1,3)), (Q(1,2), Q(1))])[0]
    c = json.loads(args.certificate.read_text())
    result = verify(c)
    print(json.dumps(result, indent=2))
    raise SystemExit(0 if result['certified'] else 1)


if __name__ == '__main__':
    main()
