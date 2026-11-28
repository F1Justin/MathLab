"""Certify the global angular minima for the four stated Poisson tails.

The interval argument follows research/partitions/saddle_certificate.py.
Angles are measured in multiples of pi. Binary floats propose subdivisions;
all signs, ordering against 1/j, and Taylor errors are verified with Arb.
"""

import cmath
import math
import sys
from fractions import Fraction

from flint import acb, arb, ctx


ctx.prec = 112
PI = arb.pi()


def interval(a, b):
    return arb(a).union(arb(b))


def test_angles(lo, hi, predicate, depth=13):
    todo = [(lo, hi, 0)]
    while todo:
        a, b, level = todo.pop()
        if predicate(interval(a, b)):
            continue
        if level == depth:
            return False
        mid = (a + b) / 2
        todo.extend([(a, mid, level + 1), (mid, b, level + 1)])
    return True


class Tail:
    def __init__(self, j):
        self.j = j
        self.terms = {name: [] for name in ("B", "H", "K", "D")}
        for i in range(53):
            k = j + i
            base = Fraction(math.factorial(j), math.factorial(k))
            for name, factor in (("B", 1), ("H", k), ("K", k * k),
                                 ("D", -Fraction(i, j))):
                value = base * factor
                self.terms[name].append(arb(value.numerator) / value.denominator)
        k = j + 53
        first = Fraction(math.factorial(j) * k * k * 8**53, math.factorial(k))
        assert 8 * (k + 1) * 2 <= k * k
        assert 2 * first < Fraction(1, 10**18)
        error = arb(0, arb("1e-18"))
        self.tail = acb(error, error)

    def value(self, r, q, name, small):
        j = self.j
        angle = PI * q
        unit = acb(angle.cos(), angle.sin())
        z = r * unit
        if small:
            result = acb(0)
            for coefficient in reversed(self.terms[name]):
                result = result * z + coefficient
            return acb((j * angle).cos(), (j * angle).sin()) * result + self.tail
        # All four quantities use the same positive exponential normalization.
        exp_scaled = acb(r * (unit.real - 1), r * unit.imag).exp()
        exp_neg = (-r).exp()
        term = acb(1)
        partial = acb(1)
        for k in range(1, j - 2):
            term *= z / k
            partial += term
        second = exp_scaled - exp_neg * partial
        term *= z / (j - 2)
        first = second - exp_neg * term
        if name == "H":
            return z * first
        if name == "K":
            return z * first + z * z * second
        return first - exp_neg * term * z / (j - 1)

    def first_stationary(self, r):
        j = self.j

        def derivative(q):
            unit = cmath.exp(1j * math.pi * q)
            z = r * unit
            if r <= 8:
                term = 1
                total = j
                for i in range(1, 55):
                    term *= z / (j + i)
                    total += (j + i) * term
                return (unit**j * total).imag
            return (z * (cmath.exp(z) - sum(z**k / math.factorial(k)
                                             for k in range(j - 1)))).imag

        # A proposal only; the certified interior bracket is tested below.
        lo = 0.0
        for index in range(1, 257):
            hi = index / (256 * j)
            if derivative(hi) < 0:
                break
            lo = hi
        else:
            raise ArithmeticError(f"no proposed first saddle at radius {r}")
        for _ in range(56):
            mid = (lo + hi) / 2
            if derivative(mid) > 0:
                lo = mid
            else:
                hi = mid
        return (lo + hi) / 2

    def certify_slab(self, a, b):
        r = interval(a, b)
        qa, qb = self.first_stationary(a), self.first_stationary(b)
        trial_angle = (qa + qb) / 2
        width = min(.19 / self.j, .25 / b)
        lo, hi = min(qa, qb) - width, max(qa, qb) + width
        if not 0 < lo < trial_angle < hi < 1:
            return False

        def val(q, name):
            return self.value(r, q, name, b <= 8)

        if not (val(arb(lo), "H").imag > 0 and val(arb(hi), "H").imag < 0):
            return False
        if not test_angles(lo, hi, lambda q: val(q, "K").real < 0, 9):
            return False
        trial = val(arb(trial_angle), "B").real
        higher = lambda q: val(q, "B").real > trial
        if not (test_angles(0.0, lo, higher) and test_angles(hi, 1.0, higher)):
            return False
        left, right = lo, hi
        for _ in range(13):
            mid = (left + right) / 2
            if val(arb(mid), "H").imag > 0:
                left = mid
            else:
                right = mid
        lower = left
        left, right = lo, hi
        for _ in range(13):
            mid = (left + right) / 2
            if val(arb(mid), "H").imag < 0:
                right = mid
            else:
                left = mid
        narrow = interval(lower, right)
        return (arb(right) < arb(1) / self.j and val(narrow, "H").real < 0
                and val(narrow, "D" if b <= 8 else "B").imag > 0)

    def certify(self):
        todo = [(2.0**k, 2.0**(k + 1)) for k in range(-4, 6)]
        count = 0
        while todo:
            a, b = todo.pop()
            if self.certify_slab(a, b):
                count += 1
                continue
            if b - a < 2**-22:
                raise ArithmeticError(f"unresolved interval j={self.j}, [{a}, {b}]")
            mid = (a + b) / 2
            todo.extend([(a, mid), (mid, b)])
        return count


if __name__ == "__main__":
    thresholds = list(map(int, sys.argv[1:])) if sys.argv[1:] else range(5, 9)
    for j in thresholds:
        if not 5 <= j <= 8:
            raise ValueError("the analytic endpoint proof covers j=5,6,7,8")
        print(f"j={j}: [1/16,64] certified on {Tail(j).certify()} radius intervals",
              flush=True)
