"""Exact Rouché comparisons bridging the second exterior cluster to rank 128."""
from fractions import Fraction as Q

from check_paired_edge import rows, transformed


def check():
    triangle = rows(127)
    rho = Q(2, 3)
    model = [Q(0), Q(0), Q(1), Q(7, 6), Q(2, 9)]
    radii = (Q(1), Q(6, 5), Q(4), Q(22, 5))
    for n in range(46, 128):
        rev = transformed(triangle[n], triangle)[::-1][:-1]
        scale = Q(16, 9)**n/2
        main = [scale*c/rho**(n*j) for j, c in enumerate(model)]
        for z in radii:
            radius = rho**n*z
            error = Q(0)
            for j in reversed(range(len(rev))):
                error = error*radius + abs(rev[j]-(main[j] if j < len(main) else 0))
            lower = scale*z*z*abs(1-Q(7, 6)*z+Q(2, 9)*z*z)
            assert error < lower
    n = 128
    tail_ratio = 10*Q(8, 9)**n
    discarded = 100*((1-tail_ratio)**(-2)-1)
    leading_error = 14*6*(n+1)*rho**(n-2)
    assert discarded + leading_error < Q(1, 100)
    assert all(abs(1-Q(7, 6)*z+Q(2, 9)*z*z)>Q(1, 100) for z in radii)
    print("Four second-cluster Rouché circles certified at ranks 46–127 and at the uniform cutoff 128.")


if __name__ == "__main__":
    check()
