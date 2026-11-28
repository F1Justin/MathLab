"""Compare marked Motzkin paths with the polarization formula over Q."""

from collections import Counter
from math import comb

import sympy as sp


def marked_counts(n):
    counts = Counter()

    def visit(i, height, up, first_up, second_positive, last_down):
        if height > n - i:
            return
        if i == n:
            counts[up, first_up, second_positive, last_down] += 1
            return
        for step in (-1, 0, 1):
            if height + step >= 0:
                visit(i + 1, height + step, up + (step == 1),
                      (step == 1) if i == 0 else first_up,
                      (height + step > 0) if i == 1 else second_positive,
                      step == -1)

    visit(0, 0, 0, False, False, False)
    return counts


def choose(n, k):
    return comb(n, k) if 0 <= k <= n else 0


def polynomial(n, weights, counts, x):
    a, b, d = weights
    coefficients = Counter()
    for (k, first, _, last), paths in counts.items():
        coefficients[k] += paths * (1 + int(first)*a + int(last)*b + int(first and last)*d)
    result = 0
    for k in range(n//2 + 1):
        exact = comb(2*k, k) // (k+1) * (
            choose(n-2, 2*k) + (2+a+b)*choose(n-2, 2*k-1)
            + (1+a+b+d)*choose(n-2, 2*k-2))
        assert exact == coefficients[k], (n, weights, k)
        result += exact * sp.Rational(-1, 4)**k * x**(n-2*k)
    return sp.Poly(result, x, domain=sp.QQ)


def check_three_rows(n, weights, counts, y):
    a, b, c, d = map(sp.Rational, weights)
    B = b+d
    C = 1+a+B
    L = C+1+b
    v = 3*B/4
    m = n-2
    cubic = ((1+(1+c)*y)*(1+L*y+(C-B/4)*y**2)
             - v*((1-c/m)*y*(1+y)**2/(m+1) + c*y**2*(1+y)/m))
    symbol = sp.Poly((1+y)**(n-3)*cubic, y)
    actual = Counter()
    for (k, first, second, last), paths in counts.items():
        top = 1 + a*int(first) + b*int(second) + d*int(first and second)
        actual[k] += paths * top * (1 + c*int(last))
    for k in range(n//2+1):
        assert actual[k] == comb(2*k, k)//(k+1) * symbol.nth(2*k)
    intervals = sp.Poly(cubic, y).intervals(eps=sp.Rational(1, 10**8))
    assert sum(mult for _, mult in intervals) == 3
    assert all(right < 0 for (_, right), _ in intervals)


def check():
    x = sp.Symbol("s")
    examples = [(0, 0, 0), (1, 1, 1), (53, 87, 53*87), (12, 3, 17),
                (sp.Rational(7, 5), sp.Rational(5, 3), sp.Rational(2, 7)),
                (0, 8, 16)]
    previous_intervals = {}
    for n in range(3, 13):
        counts = marked_counts(n)
        for weights in examples:
            f = polynomial(n, weights, counts, x)
            intervals = f.intervals(eps=sp.Rational(1, 10**8))
            assert len(intervals) == n and all(m == 1 for _, m in intervals)
            current = [interval for interval, _ in intervals]
            if weights in previous_intervals:
                previous = previous_intervals[weights]
                assert all(current[j][1] < previous[j][0] <= previous[j][1]
                           < current[j+1][0] for j in range(n-1))
            previous_intervals[weights] = current
        if n >= 5:
            for weights in [(1, 2, 3, 2), (11, 7, 41, 35), (0, 0, 0, 0),
                            (3, 0, 45, 0), (5, 17, 0, 65), (0, 0, 4, 101),
                            (3, sp.Rational(21, 8), sp.Rational(7, 5), 5)]:
                check_three_rows(n, weights, counts, x)
    print("Exact marked paths, polarization and interlacing through rank 12.")


if __name__ == "__main__":
    check()
