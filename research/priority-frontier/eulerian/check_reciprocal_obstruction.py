"""Exact certificates for reciprocal Obstruction and two-root interlacing."""

from math import comb

import sympy as sp

from check_paired_edge import rows, transformed


x = sp.Symbol("x")


def nonzero_factor(weights, triangle):
    coefficients = transformed(weights, triangle)
    assert coefficients[0] == 0 and coefficients[1] > 0
    return sp.Poly.from_list(coefficients[:0:-1], x, domain=sp.ZZ)


def check_counterexamples(triangle):
    coeffs = [1, 1]
    for j in range(14):
        old = [0, 0] + coeffs + [0, 0]
        coeffs = [old[k] + (2**23 + j) * old[k+1] + old[k+2] for k in range(len(old)-2)]
    assert len(coeffs) == 30 and coeffs == coeffs[::-1]
    reciprocal = [0] + [comb(29, k) * b for k, b in enumerate(coeffs)]
    tilted = [v * 2**(16*(30-k)) for k, v in enumerate(triangle[30])]
    for weights in (reciprocal, tilted):
        poly = nonzero_factor(weights, triangle)
        intervals = poly.intervals(fast=True)
        assert poly.degree() == 29 and poly.gcd(poly.diff()).degree() == 0
        assert len(intervals) == 27
        assert all(hi <= 0 and mul == 1 for (_, hi), mul in intervals)
    print("Both degree-30 transforms have 28 real roots including zero.")


def variations(signs):
    filtered = [s for s in signs if s != 0]
    return sum(a != b for a, b in zip(filtered, filtered[1:]))


def check_laguerre_limit():
    model = sp.Poly(sp.laguerre(9, -x) + 16*x*sp.laguerre(9, -x/2), x)
    primitive = model.clear_denoms()[1].primitive()[1]
    assert primitive.all_coeffs() == [
        1, 194, 12960, 421632, 7451136, 73156608, 386104320,
        998645760, 1045094400, 290304000, 11612160,
    ]
    seq = primitive.sturm()
    plus_infinity = [sp.sign(p.LC()) for p in seq]
    minus_infinity = [s * (-1)**p.degree() for s, p in zip(plus_infinity, seq)]
    assert (variations(minus_infinity), variations(plus_infinity)) == (9, 1)
    assert primitive.discriminant() < 0
    print("The degree-10 Laguerre limit has eight real roots by Sturm variations 9 and 1.")


def check_two_outer_roots(triangle):
    n = 24

    def error(radius):
        return ((n+1)*radius/sp.Integer(2)**n
                + radius**2 * sp.Rational(3, 4)**n / (1-radius*sp.Rational(2, 3)**n))

    assert (6+error(4))*error(4) + 4*error(2) < sp.Rational(113, 1000)
    moduli = {}
    for n in range(3, 27):
        poly = nonzero_factor(triangle[n], triangle)
        intervals = poly.intervals(fast=True, eps=sp.Rational(1, 100))
        assert len(intervals) == n-1
        assert all(hi <= 0 and mul == 1 for (_, hi), mul in intervals)
        moduli[n] = [(-hi, -lo) for ((lo, hi), _) in intervals[:2]]
    for n in range(3, 24):
        for first, later in zip(moduli[n], moduli[n+1]):
            assert first[1] < later[0]
        for lag in (1, 2, 3):
            now = moduli[n][0]
            later = moduli[n+lag][1]
            if lag == 1 or lag == 2 and n >= 4:
                assert later[1] < now[0]
            else:
                assert now[1] < later[0]
    print("Finite comparisons through starting row 23 and the analytic cutoff 24 verified.")


def check_two_inner_roots(triangle):
    r = sp.Rational
    upper = r(21,10000) + r(876,1000)**81/r(9,10)
    upper += 4*r(88,100)**2*r(943,1000)**80/(1-r(88,100)*r(943,1000)**80)**2
    assert upper < r(4,100)
    reciprocal_moduli = {}
    for n in range(3, 84):
        coeffs = transformed(triangle[n], triangle)
        reversed_row = sp.Poly.from_list(coeffs[1:], x, domain=sp.ZZ)
        intervals = reversed_row.intervals(fast=True)
        assert len(intervals) == n-1 and all(hi <= 0 and m == 1 for (_, hi), m in intervals)
        first_two = []
        for (lo, hi), _ in intervals[:2]:
            if lo != hi:
                upper_sign = sp.sign(reversed_row.eval(hi))
                assert upper_sign and sp.sign(reversed_row.eval(lo)) == -upper_sign
                for _ in range(12):
                    mid = (lo+hi)/2
                    sign = sp.sign(reversed_row.eval(mid))
                    if sign == 0:
                        lo = hi = mid
                        break
                    if sign == upper_sign:
                        hi = mid
                    else:
                        lo = mid
            first_two.append((-hi, -lo))
        reciprocal_moduli[n] = first_two
    for n in range(3, 80):
        for first, later in zip(reciprocal_moduli[n], reciprocal_moduli[n+1]):
            assert first[1] < later[0]
        for lag in range(1, 5):
            first = reciprocal_moduli[n][0]
            later_second = reciprocal_moduli[n+lag][1]
            if lag == 4 and n in (3, 4):
                assert first[1] < later_second[0]
            else:
                assert later_second[1] < first[0]
    print("Smallest-root comparisons through starting row 79 and the analytic cutoff 80 verified.")


if __name__ == "__main__":
    triangle = rows(83)
    check_counterexamples(triangle)
    check_laguerre_limit()
    check_two_outer_roots(triangle)
    check_two_inner_roots(triangle)
