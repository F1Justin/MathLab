"""Check the factorial-row result and sample the global phase-sign question."""

from math import comb, factorial

import mpmath as mp
import sympy as sp

from check_paired_edge import rows, transformed


def check_factorial_rows():
    x, w, a = sp.symbols("x w a")
    triangle = rows(20)
    for n in range(1, 7):
        f = (x + w) ** n
        g = (n + 1) * f - x * sp.diff(f, x)
        actual = x * sp.diff(f, x) + x * (x * sp.diff(g, x) + a * g)
        linear = n + (n + a) * x + a * (n + 1) * w
        expected = x * (x + w) ** (n - 1) * linear
        if n >= 2:
            expected += n * (n - 1) * x**2 * w * (x + w) ** (n - 2)
        assert sp.expand(actual - expected) == 0
    for shape in (sp.Rational(1, 13), 1, sp.Rational(9, 4), 17):
        for n in (4, 11, 20):
            coefficients = [sp.rf(shape, j) * triangle[n][j] for j in range(n + 1)]
            poly = sp.Poly.from_list(coefficients[::-1], x)
            roots = poly.intervals(fast=True)
            assert len(roots) == n and all(hi <= 0 and mult == 1 for (_, hi), mult in roots)
    print("Symbol identities through n=6 and exact negative-root counts in degrees 4, 11, 20 verified.")

    f = sp.Poly(x * (x + 50) ** 9, x)
    coefficients = [c / factorial(j) for j, c in enumerate(f.all_coeffs()[::-1])]
    image = sp.Poly.from_list(transformed(coefficients, triangle)[::-1], x)
    assert len(image.intervals()) == 8 and image.gcd(image.diff()).degree() == 0
    print("The inverse-factorial Eulerian transform of x(x+50)^9 has a nonreal pair.")


def check_phase_samples(n):
    """Numerical only. Use poles to locate extrema and the actual polynomial to test signs."""
    triangle = rows(n)
    factorial_row = [v * factorial(j) for j, v in enumerate(triangle[n])]
    square = transformed(triangle[n], triangle)
    phases = []

    def pole_imaginary(angle):
        t = -mp.pi / mp.tan(angle)
        z = -(1 + mp.exp(t)) / (t + mp.j * mp.pi)
        return mp.im(z * mp.polyval(factorial_row[::-1], z))

    divisions = 50 * (n + 1)
    left = mp.mpf(0)
    old_sign = 1
    for i in range(1, divisions):
        right = mp.pi * i / divisions
        sign = mp.sign(pole_imaginary(right))
        if sign != old_sign:
            lo, hi = left, right
            for _ in range(70):
                mid = (lo + hi) / 2
                if mp.sign(pole_imaginary(mid)) == old_sign:
                    lo = mid
                else:
                    hi = mid
            phases.append((lo + hi) / 2)
            old_sign = sign
        left = right
    assert len(phases) == n
    for j, angle in enumerate(phases, start=1):
        t = -mp.pi / mp.tan(angle)
        assert mp.sign(mp.polyval(square[::-1], -mp.exp(t))) == (-1) ** j
    print(f"n={n}: all {n} adaptive signs agree at {mp.mp.dps} decimal digits (numerical).")


def check_two_sided_rows():
    x = sp.symbols("x")
    triangle = rows(20)
    for p, q in ((1, 1), (1, sp.Rational(5, 4)), (2, 1), (3, 5)):
        previous = None
        for n in range(1, 15):
            m = n - 1
            coefficients = [
                sp.rf(p, k) * sp.rf(q, m - k) * triangle[n][k + 1]
                for k in range(n)
            ]
            poly = sp.Poly.from_list(coefficients[::-1], x)
            ranges = poly.intervals(fast=True)
            assert sum(mult for _, mult in ranges) == m
            assert all(hi <= 0 for (_, hi), _ in ranges) and poly.eval(0) > 0
            common = poly.gcd(poly.diff()).monic()
            doubled = p == q == 1 and n >= 3 and n % 2 == 1
            assert common.as_expr() == (x + 1 if doubled else 1)
            if p == q == 1 and previous is not None:
                derivative = (n - 1) * previous - x * previous.diff(x)
                expected = (1 + x) * (x * derivative).diff(x)
                assert sp.expand(expected - poly.as_expr()) == 0
            previous = poly.as_expr()
    m = 18
    weights = [0] + [comb(m, k)**2 * 1024**(m-k) for k in range(m + 1)]
    image = sp.Poly.from_list(transformed(weights, triangle)[::-1], x)
    assert image.degree() == 19 and image.gcd(image.diff()).degree() == 0
    assert len(image.intervals(fast=True)) == 17
    print("Two-sided multiplicities, elementary recurrence and the 17-of-19 counterexample verified.")


if __name__ == "__main__":
    check_factorial_rows()
    check_two_sided_rows()
    mp.mp.dps = 80
    for size in (15, 30, 50, 80):
        check_phase_samples(size)
