"""Decide whether one extra runner can fill the positive-width gaps of a fixed base."""
from fractions import Fraction as Q
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[2]


def gaps(base, delta):
    arcs = []
    for speed, num in zip(base["speeds"], base["shift_num"]):
        shift = Q(num % base["shift_den"], base["shift_den"])
        for k in range(speed + 2):
            lo, hi = (k-shift-delta)/speed, (k-shift+delta)/speed
            if lo < 1 and hi > 0:
                arcs.append((max(0,lo), min(1,hi)))
    result = []
    end = 0
    for lo, hi in sorted(arcs):
        if end < lo:
            result.append((end, lo))
        end = max(end, hi)
    if end < 1:
        result.append((end, Q(1)))
    return result


def allowable_shifts(speed, lo, hi, delta):
    # For the entire closed interval, s belongs to [k-v*lo-d, k-v*hi+d].
    left, right = -speed*lo-delta, -speed*hi+delta
    if left > right:
        return []
    start, stop = left % 1, (left % 1) + right-left
    if stop < 1:
        return [(start, stop)]
    return [(start, Q(1)), (Q(0), stop-1)]


def solve(base, delta):
    holes = sorted(gaps(base,delta), key=lambda ab: ab[1]-ab[0], reverse=True)
    width = holes[0][1]-holes[0][0]
    vmax = int(2*delta/width)
    resolved = {}
    solutions = []
    for v in range(1,vmax+1):
        if v in base["speeds"]:
            continue
        allowed = [(0,1)]
        for index,(lo,hi) in enumerate(holes,1):
            choices = allowable_shifts(v,lo,hi,delta)
            # Keep 0 and 1 interchangeable at a seam.
            if any(a==0 for a,b in choices):
                choices.append((1,1))
            if any(b==1 for a,b in choices):
                choices.append((0,0))
            allowed = sorted(set((max(a,c),min(b,d)) for a,b in allowed for c,d in choices if max(a,c)<=min(b,d)))
            if not allowed:
                resolved[index]=resolved.get(index,0)+1
                break
        if allowed:
            solutions.append([v,allowed])
    return dict(radius=delta, gap_count=len(holes), longest_gap=holes[0],
                longest_width=width, speed_bound=vmax, eliminated_at_gap=resolved,
                witnesses=holes[:max(resolved,default=0)], solutions=solutions)


if __name__ == "__main__":
    base = json.loads((ROOT / "package1/results/known_slr_57.json").read_text())
    print(json.dumps(solve(base,Q(1,59)), default=str, indent=2))
