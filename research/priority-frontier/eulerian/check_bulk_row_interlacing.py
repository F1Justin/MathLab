"""Certify finite examples of genuine adjacent-row interlacing by joint rational isolation."""
import argparse

import sympy as sp

from check_paired_edge import rows, transformed


def check(through):
    triangle = rows(through)
    z = sp.Symbol("z")
    previous = sp.Poly(1, z)
    for n in range(2, through+1):
        row = transformed(triangle[n], triangle)
        current = sp.Poly.from_list(row[:0:-1], z, domain=sp.ZZ)
        roots = sp.polys.polytools.intervals([previous, current], fast=True, strict=True)
        assert len(roots) == 2*n-3
        assert all(hi <= 0 and owners == {1-j%2: 1} for j, ((lo, hi), owners) in enumerate(roots))
        previous = current
    print(f"After removing zero, each genuine square row strictly interlaces its successor through rank {through}.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--through", type=int, default=55)
    args = parser.parse_args()
    if args.through < 2:
        parser.error("--through must be at least two")
    check(args.through)
