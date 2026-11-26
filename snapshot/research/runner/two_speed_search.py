#!/usr/bin/env python3
"""
Exact two-speed cover search. Python 3, standard library only; no Z3 needed.

Usage:
    python3 two_speed_search.py --self-test
    python3 two_speed_search.py --max-speed 200 < problem.json

JSON fields: "H" is a list of [left, right] pairs, "d" is a rational,
and "forbidden" is an optional list of positive integers. Rationals may
be integers, fraction strings such as "3/17", or exact decimal strings.
JSON decimal numbers are also parsed directly as Fractions.

Python API:
    fixed_phases(H, d, v, w) -> (Fraction, Fraction) or None
    search(H, d, forbidden, max_speed) -> result dictionary

Results:
    FOUND               A verified strict cover; both speeds <= max_speed.
    IMPOSSIBLE          The filters and search prove global nonexistence.
    NO_PAIR_WITHIN_CAP  Exhaustive for v < w <= max_speed, incomplete globally.

The resource bound is a speed cap, not a wall-clock timeout. No phase solver
call returns "unsatisfiable" merely because a resource limit was reached.
"""

import argparse
import json
import sys
from fractions import Fraction as F
from math import ceil, floor, gcd

ZERO, ONE = F(0), F(1)


def _rat(x):
    if isinstance(x, bool) or not isinstance(x, (int, str, F)):
        raise ValueError("use integers, rational strings, or Fractions, not floats")
    return F(x)


def _posint(x):
    if type(x) is not int or x <= 0:
        raise ValueError("expected a positive integer")
    return x


def _normalize(H, d):
    d = _rat(d)
    if not ZERO < d < F(1, 4):
        raise ValueError("require 0 < d < 1/4")
    merged = []
    for a, c in sorted((_rat(a), _rat(c)) for a, c in H):
        if not ZERO <= a <= c <= ONE:
            raise ValueError("require 0 <= left <= right <= 1")
        if merged and a <= merged[-1][1]:
            merged[-1] = (merged[-1][0], max(c, merged[-1][1]))
        else:
            merged.append((a, c))
    if not any(a < c for a, c in merged):
        raise ValueError("H needs a positive-length interval")
    return merged, d


def _hole(lo, hi, closed_blocks):
    """Rational point of (lo,hi) outside all closed blocks, or None."""
    blocks = []
    for a, c in closed_blocks:
        if a <= lo and hi <= c:
            return None
        if a < hi and lo < c:
            blocks.append((a, c))
    edge = lo
    for a, c in sorted(blocks):
        if edge < a:
            return (edge + a) / 2
        edge = max(edge, c)
        if edge >= hi:
            return None
    return (edge + hi) / 2


# ---------------------- Complete fixed-speed solver ----------------------

def _axis_cells(H, d, u):
    """
    For phase x, speed u misses the CLOSED time gaps
        G_k = [(k+d-x)/u, (k+1-d-x)/u].
    G_k meets [a,c] iff u*a+x-1+d <= k <= u*c+x-d, including equality.
    The integer index range is constant between the following phase cuts.
    """
    cuts = {ZERO, ONE}
    for a, c in H:
        cuts.add((-u*a - d) % 1)
        cuts.add((d - u*c) % 1)
    cuts = sorted(cuts)
    for left, right in zip(cuts, cuts[1:]):
        x = (left + right) / 2
        ranges = [(ceil(u*a + x - 1 + d), floor(u*c + x - d))
                  for a, c in H]
        yield left, right, ranges


def _blocked_z(d, v, w, slow_ranges, fast_ranges):
    """
    Inside an open phase rectangle, emit closed forbidden intervals for
    z = w*s - v*b.

    For a given H component, the index ranges already say that both gaps
    meet that component. Three closed real intervals have a common point
    iff they intersect pairwise. Thus all that remains to test is whether
    slow gap k and fast gap j meet each other. This is exactly
        w*(k+d)   - v*(j+1-d) <= z
      <= w*(k+1-d) - v*(j+d).

    For fixed k, consecutive j shift these blocks by v, but each block has
    length (v+w)*(1-2*d) > v. Their union is ONE closed interval, even if
    the fast speed gives millions of gap indices on the component.
    """
    for (k0, k1), (j0, j1) in zip(slow_ranges, fast_ranges):
        if k0 > k1 or j0 > j1:
            continue
        left = w*d - v*(j1 + 1 - d)
        right = w*(1 - d) - v*(j0 + d)
        # The block for k is [left+w*k, right+w*k].
        if right - left >= w:
            yield left + w*k0, right + w*k1
        else:
            for k in range(k0, k1 + 1):
                yield left + w*k, right + w*k


def _solve(H, d, v, w, slow_cells=None):
    """
    It is complete to use only OPEN phase rectangles: for a strict cover,
    the maximum on compact H of the minimum of the two distances is < d.
    Small phase perturbations preserve that margin. By periodicity we can
    therefore avoid every phase cut, including 0 mod 1. This argument does
    NOT discard time endpoints; _blocked_z treats time gaps as closed.
    """
    if slow_cells is None:
        slow_cells = list(_axis_cells(H, d, v))
    for b0, b1, js in _axis_cells(H, d, w):
        for s0, s1, ks in slow_cells:
            # Exact image of the open rectangle under z = w*s - v*b.
            lo, hi = w*s0 - v*b1, w*s1 - v*b0
            z = _hole(lo, hi, _blocked_z(d, v, w, ks, js))
            if z is not None:
                # Lift z to a rational point inside that rectangle.
                left = max(s0, (z + v*b0) / w)
                right = min(s1, (z + v*b1) / w)
                assert left < right
                s = (left + right) / 2
                return s, (w*s - z) / v
    return None


def fixed_phases(H, d, v, w):
    """Complete decision and rational witness for the specified speeds."""
    H, d = _normalize(H, d)
    if not _posint(v) < _posint(w):
        raise ValueError("require v < w")
    return _solve(H, d, v, w)


def _verify(H, d, v, w, s, b):
    """Independent witness check, including singletons and gap endpoints."""
    for a, c in H:
        for k in range(floor(v*a + s) - 1, floor(v*c + s) + 1):
            p = max(a, (k + d - s) / v)
            q = min(c, (k + 1 - d - s) / v)
            if p <= q:
                # The whole closed slow-missed segment [p,q] must lie in
                # ONE open fast window. Its center index must be an integer
                # strictly between w*q+b-d and w*p+b+d.
                if floor(w*q + b - d) + 1 >= w*p + b + d:
                    return False
    return True


# ------------------ Necessary tests before phase solving ------------------

def _slow_phase_possible(rows, v, f):
    """
    f = 2*d/w is a fast window's length. A covered connected [a,c]
    meets at most one slow window: otherwise a whole closed slow gap of
    length (1-2*d)/v > f would have to fit inside one open fast window.

    If c-a >= f, [a,c] MUST meet a slow window, say (p,q). We need
    p < a+f and q > c-f: any wing outside that window, INCLUDING the
    slow boundary point, has to fit in an open fast window. In phase
    coordinates this requires, modulo 1,
        -d-v*a-v*f < s < d-v*c+v*f.
    All such requirements must hold for the SAME s. Failure is monotone
    as w increases: more rows qualify, and the allowed arcs only shrink.
    """
    bad = []
    margin = v*f
    for length, left0, right0 in rows:
        if length < f:
            continue
        left, right = left0 - margin, right0 + margin
        width = right - left
        if width <= 0:
            return False
        if width > 1:
            continue
        # Complement of (left,right) mod 1 is a CLOSED circular arc.
        # For width == 1 it is a single forbidden point, not an empty arc.
        start = right % 1
        end = start + 1 - width
        bad.append((start, end))
        if end >= 1:
            bad.append((start - 1, end - 1))
    # A nonempty intersection of finitely many open arcs cannot consist
    # solely of s == 0 mod 1.
    return _hole(ZERO, ONE, bad) is not None


def search(H, d, forbidden, max_speed):
    H, d = _normalize(H, d)
    banned = {_posint(u) for u in forbidden}
    cap = _posint(max_speed)
    L = max(c - a for a, c in H)

    # Write S=2*d/v, f=2*d/w. By the one-slow-window argument above,
    # a covered component has length < S+2*f (two wings each < f);
    # if it misses all slow windows it even has length < f. Since w>v,
    # necessarily L < 6*d/v. Strict bounds use ceil(bound)-1.
    vmax = ceil(6*d / L) - 1
    global_done = vmax <= cap
    calls = 0

    for v in range(1, min(vmax, cap) + 1):
        if v in banned:
            continue
        S = 2*d / v
        wmax = ceil(4*d / (L - S)) - 1 if L > S else None
        limit = cap if wmax is None else min(cap, wmax)
        rows = [(c-a, -d-v*a, d-v*c) for a, c in H]
        slow_cells = None

        for w in range(v + 1, limit + 1):
            if w in banned:
                continue

            # Over a full common period 1/g the two speeds cover, counting
            # even their overlap twice, only a fraction 4*d < 1.
            if gcd(v, w)*L >= 1:
                continue

            f = 2*d / w
            if L >= S + f:
                # One wing alone cannot suffice on a longest component.
                # Its two endpoints lie in distinct fast windows, n periods
                # apart. Endpoint separation gives L < n/w + f. Both fast
                # windows must reach across the respective slow boundaries,
                # so the gap n/w - f between them is strictly less than S.
                # Reject if there is no integer w*(L-f) < n < w*(S+f).
                if floor(w*(L-f)) + 1 >= w*(S+f):
                    continue

            if not _slow_phase_possible(rows, v, f):
                break  # proves failure also for every larger w at this v

            if slow_cells is None:
                slow_cells = list(_axis_cells(H, d, v))
            calls += 1
            ans = _solve(H, d, v, w, slow_cells)
            if ans is not None:
                s, b = ans
                if not _verify(H, d, v, w, s, b):
                    raise AssertionError("internal error: invalid witness")
                return dict(status="FOUND", v=v, w=w, s=s, b=b,
                            max_speed=cap, phase_calls=calls)
        else:
            # No monotone rejection terminated this v's loop. If the
            # analytic w bound ran past the cap, don't claim global failure.
            if wmax is None or wmax > cap:
                global_done = False

    return dict(status="IMPOSSIBLE" if global_done else "NO_PAIR_WITHIN_CAP",
                max_speed=cap, phase_calls=calls)


def self_test():
    d = F(1, 8)

    # v=1,w=2: a length just below 3/8 works with overlapping windows;
    # length exactly 3/8 cannot be obtained by merely touching them.
    H = [(ZERO, F(37, 100))]
    ans = fixed_phases(H, d, 1, 2)
    assert ans is not None and _verify(H, d, 1, 2, *ans)
    H = [(ZERO, F(3, 8))]
    assert fixed_phases(H, d, 1, 2) is None
    assert search(H, d, [], 3)["status"] == "IMPOSSIBLE"

    # With these specific phases, t=0 is a missed endpoint although the
    # slow window covers the entire open interior.
    assert not _verify([(ZERO, F(1, 4))], d, 1, 2, -d, F(1, 2))

    # Forbidden speed, isolated point, and an incomplete global outcome.
    H = [(ZERO, F(1, 8)), (F(1, 2), F(1, 2))]
    assert search(H, d, [2], 2)["status"] == "NO_PAIR_WITHIN_CAP"
    r = search(H, d, [2], 3)
    assert r["status"] == "FOUND" and (r["v"], r["w"]) == (1, 3)
    assert _verify(H, d, 1, 3, r["s"], r["b"])
    print("self-test passed")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Exact strict two-speed cover")
    parser.add_argument("--self-test", action="store_true")
    parser.add_argument("--max-speed", type=int)
    args = parser.parse_args()
    if args.self_test:
        self_test()
    else:
        if args.max_speed is None or args.max_speed < 1:
            parser.error("supply a positive --max-speed")
        obj = json.load(sys.stdin, parse_float=F)
        result = search(obj["H"], obj["d"], obj.get("forbidden", []),
                        args.max_speed)
        print(json.dumps(result, default=str, indent=2))
