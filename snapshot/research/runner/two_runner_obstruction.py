"""Exact necessary conditions for covering the 57-runner seed's holes with two runners.

This even permits repeated speeds and real shifts. Sweep small intervals of the
slower runner's phase. Pairs of rational witness times rule out the faster one.
"""
from fractions import Fraction as Q
from itertools import combinations
from math import floor
import json
from frozen_extension import ROOT, gaps


def dist(t):
    return abs(t - round(t))


def check(base, delta, count=20, bins=32):
    holes = sorted(gaps(base,delta), key=lambda g: g[1]-g[0], reverse=True)[:count]
    widths = [b-a for a,b in holes]
    centers = [(a+b)/2 for a,b in holes]
    slow_max = floor(4*delta/((1-4*delta)*widths[0]))
    fast_bounds = [floor(2*delta/w) for w in widths]
    vmax = max(fast_bounds)
    # Bit v remains set only if speed v can cover the two midpoints at one phase.
    compatible = {(i,j): sum(1 << v for v in range(1,vmax+1)
                              if dist(v*(centers[i]-centers[j])) <= 2*delta)
                  for i,j in combinations(range(count),2)}
    unresolved = []
    least_missed = count
    for v in range(1, slow_max+1):
        phases = [(v*t)%1 for t in centers]
        radii = [delta+Q(1,2*bins)+v*w/2 for w in widths]
        for k in range(bins):
            phase = Q(2*k+1,2*bins)
            untouched = [i for i in range(count) if dist(phases[i]+phase)>radii[i]]
            least_missed = min(least_missed,len(untouched))
            if not untouched:
                unresolved.append([v,k,"no width bound"])
                continue
            limit = fast_bounds[untouched[0]]
            # Speeds are ordered v <= w. Whole gap gives w <= limit.
            speeds = ((1 << (limit+1))-1) & ~((1 << v)-1)
            for pair in combinations(untouched,2):
                speeds &= compatible[pair]
                if not speeds:
                    break
            if speeds:
                unresolved.append([v,k,speeds.bit_count()])
    return dict(radius=str(delta),witnesses=count,bins=bins,slow_max=slow_max,
                phase_boxes=bins*slow_max,min_untouched=least_missed,
                unresolved_count=len(unresolved),unresolved_examples=unresolved[:20])


if __name__ == "__main__":
    base = json.loads((ROOT / "package1/results/known_slr_57.json").read_text())
    print(json.dumps(check(base,Q(1,59)),indent=2))
