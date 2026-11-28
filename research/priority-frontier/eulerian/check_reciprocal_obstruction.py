"""Exact certificates for reciprocal Obstruction and two-root interlacing."""

from math import comb
from fractions import Fraction

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


def check_matching_example(triangle):
    n = 50
    m = n-1
    true_edge = Fraction(triangle[n][2], m)
    parameters = [Fraction(3)] + [Fraction(3_000_000+j) for j in range(22)]
    parameters.append(true_edge-1-sum(parameters))
    assert len(set(parameters)) == 24 and min(parameters) > 2
    coeffs = [1, 1]
    for value in parameters:
        left, middle = value.denominator, value.numerator
        old = [0, 0] + coeffs + [0, 0]
        coeffs = [left*(old[k]+old[k+2])+middle*old[k+1] for k in range(len(old)-2)]
    assert len(coeffs) == n and coeffs == coeffs[::-1]
    assert Fraction(coeffs[1],coeffs[0]) == true_edge
    weights = [0] + [comb(m,k)*c for k,c in enumerate(coeffs)]
    image = nonzero_factor(weights,triangle)
    genuine = transformed(triangle[n],triangle)
    assert image.all_coeffs()[:2] == [coeffs[0]*c for c in genuine[-1:-3:-1]]
    assert image.gcd(image.diff()).degree() == 0
    roots = image.intervals(fast=True)
    assert len(roots) == 47 and all(hi <= 0 and mul == 1 for (_,hi),mul in roots)
    q = sp.assoc_laguerre(15,1,-x)/16
    limiting = sp.Poly(q + 8*x*q.subs(x,sp.Rational(2,3)*x),x)
    assert limiting.degree() == 16 and len(limiting.intervals(fast=True)) == 14
    print("The degree-50 matching example has 48 real roots, and its limiting model has 14 of 16.")


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


def check_log_concavity_example():
    n = 500
    triangle = rows(n)
    for start, h, c, center, bound in [(500, 248, 2**219, 126, 1008), (460, 228, 2**225, 116, 1002)]:
        m = start-1
        true_edge = Fraction(2**start-start-1, m)
        last = true_edge-1-h*c-comb(h, 2)
        assert last > c+h and 1+h*c+comb(h, 2)+last == true_edge
        assert 1+2*(h+1) == m
        # Compute only the prefix used in the three output coefficients.
        coeffs = [1, 1]
        for parameter in [Fraction(c+i) for i in range(h)] + [last]:
            old = [0, 0] + coeffs + [0, 0]
            coeffs = [parameter.denominator*(old[k]+old[k+2]) + parameter.numerator*old[k+1]
                      for k in range(min(len(old)-2, center+2))]
        assert Fraction(coeffs[1], coeffs[0]) == true_edge
        weights = [comb(m, k)*b for k, b in enumerate(coeffs)]
        for rank in range(start, n):
            weights = [(g+1)*w + ((rank+1-g)*weights[g-1] if g else 0) for g, w in enumerate(weights)]
            assert weights[1] == weights[0]*triangle[rank+1][2]
        left, mid, right = [sum(weights[g]*triangle[n-g][k-g+1] for g in range(k+1))
                            for k in (center-1, center, center+1)]
        assert bound*mid**2 < 1000*left*right < (bound+1)*mid**2
        print(f"The degree-{n} matching example starting at {start} fails log-concavity at reversed index {center}.")


def check_single_insertion(triangle):
    n, m, h, c = 50, 49, 23, 2**22
    edge = Fraction(2**n-n-1, m)
    last = edge-1-h*c-comb(h, 2)
    assert last > c+h
    coeffs = [1, 1]
    for parameter in [Fraction(c+i) for i in range(h)] + [last]:
        old = [0, 0] + coeffs + [0, 0]
        coeffs = [parameter.denominator*(old[k]+old[k+2]) + parameter.numerator*old[k+1]
                  for k in range(len(old)-2)]
    weights = [comb(m, k)*b for k, b in enumerate(coeffs)]
    for rank, expected in ((50, 50), (51, 49)):
        assert weights == weights[::-1]
        assert weights[1] == weights[0]*triangle[rank][2]
        image = nonzero_factor([0]+weights, triangle)
        assert image.gcd(image.diff()).degree() == 0
        roots = image.intervals(fast=True)
        assert len(roots)+1 == expected and all(hi <= 0 and mult == 1 for (_, hi), mult in roots)
        old = [0]+weights+[0]
        weights = [(k+1)*old[k+1]+(rank+1-k)*old[k] for k in range(rank+1)]
    print("One genuine insertion takes the matched rank-50 example from 50 real roots to 49 of 51.")


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
    check_matching_example(triangle)
    check_log_concavity_example()
    check_single_insertion(triangle)
    check_two_outer_roots(triangle)
    check_two_inner_roots(triangle)
