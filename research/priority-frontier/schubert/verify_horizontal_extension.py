"""Independent finite checks by unnormalized Motzkin path enumeration."""
from functools import cache
from itertools import combinations, product
from math import comb
import sympy as sp


def board_row(n, h, old_heights, q):
    @cache
    def number_of_placements(positive):
        # Right-to-left short columns followed by selected new full-height columns.
        total = 0
        for k in range(len(positive)+1):
            for rows in combinations(positive, k):
                for t in range(min(k, len(old_heights))+1):
                    prefixes = sum(all(r <= c for r, c in zip(rows, flags))
                                   for flags in combinations(old_heights, t))
                    total += prefixes * comb(q, k-t)
        return total

    gamma = [0]*(n//2+1)
    for path in product((-1, 0, 1), repeat=n):
        if sum(path):
            continue
        height = 0
        positive = []
        for time, step in enumerate(path, 1):
            height += step
            if height < 0:
                break
            if height and time <= h:
                positive.append(time)
        else:
            gamma[path.count(1)] += number_of_placements(tuple(positive))
    coeff = [0]*(n+1)
    for k, weight in enumerate(gamma):
        for j in range(n-2*k+1):
            coeff[j+k] += weight * comb(n-2*k, j)
    return coeff


def check_interlacing(n, h, old, q):
    z = sp.symbols("z")
    row = board_row(n, h, old, q)
    baseline = [comb(n, j)*comb(n, j+1)//n for j in range(n)]
    p = sp.Poly.from_list(row[::-1], z, domain=sp.QQ)
    qpoly = sp.Poly.from_list(baseline[::-1], z, domain=sp.QQ)
    assert p.degree() == n and qpoly.degree() == n-1
    assert row == row[::-1] and min(row) > 0
    while qpoly.degree() > 0:
        rem = -p.rem(qpoly)
        assert rem.degree() == qpoly.degree()-1 and rem.LC() > 0
        p, qpoly = qpoly, rem.monic()
    print("Verified strict interlacing:", n, h, old, q)


if __name__ == "__main__":
    for n in range(2, 10):
        h = n-1
        heights = tuple(sorted((1, max(1, h//3), max(1, 2*h//3), h)))
        check_interlacing(n, h, heights, h+384*h*h)
    for n in (5, 8, 10):
        h = n-2
        check_interlacing(n, h, (1, h//2, h), h+3_000_000_000*h*h*4)
