"""Finite exact checks, independent of the phase-sampling argument.

Run with Python 3 and SymPy 1.14. Row entries use weighted path word counts.
"""
from functools import cache
from math import comb
from sympy import Poly, QQ, Rational as Rat, symbols

x = symbols("x")


@cache
def path_entry(weight, n, j):
    # Choose places for NE, then places for N among the remaining steps.
    return sum(
        comb(n - h, h) * comb(n - 2 * h, j - h) * weight**h
        for h in range(min(n - j, j) + 1)
    )


def row_value(weight, n, point):
    return sum(path_entry(weight, n, j) * point**j for j in range(n + 1))


def product_row(c, d, n):
    coefficients = [
        sum(path_entry(c, n, j) * path_entry(d, j, k) for j in range(k, n + 1))
        for k in range(n + 1)
    ]
    return Poly.from_list(list(reversed(coefficients)), x, domain=QQ)


def verify_case(c, d, limit):
    for n in range(limit + 1):
        q = product_row(c, d, n)
        assert q.degree() == n and q.LC() == 1 and q.eval(0) > 0
        for u in (Rat(1, 7), Rat(3, 5), Rat(5, 4)):
            v = (1 / d - u) / (1 + u)
            if v == u or v == 0:
                continue
            y = 1 / (d * u * v)
            h_u = row_value(c, n, -u) / u**(n + 1)
            h_v = row_value(c, n, -v) / v**(n + 1)
            assert d * y * (v - u) * (-1)**n * q.eval(-y) == h_u - h_v
        if n:
            intervals = q.intervals(eps=Rat(1, 10_000))
            assert len(intervals) == n
            assert all(m == 1 and hi < 0 for (lo, hi), m in intervals)
            if c == d == 1:
                # Rational endpoints strictly inside the asserted radical bounds.
                assert all(-Rat(82426, 10000) < lo and hi < -Rat(1716, 10000)
                           for (lo, hi), _ in intervals)
    print(f"c={c}, d={d}, degrees 0..{limit}: identity and root isolation verified")


if __name__ == "__main__":
    for cw, dw, limit in ((1, 1, 40), (1, Rat(1, 3), 20), (Rat(1, 20), Rat(1, 2), 20),
                          (Rat(9, 2), Rat(1, 3), 20), (20, 5, 20)):
        verify_case(Rat(cw), Rat(dw), limit)

    witness = 25 * product_row(Rat(1, 10), Rat(1, 10), 3)
    assert witness.all_coeffs() == [25, 160, 328, 210]
    assert witness.discriminant() == -72300
    print("c=d=1/10: exact cubic discriminant -72300")
