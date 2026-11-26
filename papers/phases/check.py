"""Independent exact tests of the local formula, using integer arithmetic."""
from fractions import Fraction as F
from itertools import combinations_with_replacement
from math import lcm
from random import Random


def radius(phases):
    # At a maximum the lower envelope has opposite one-sided slopes.
    # A cusp in one runner's triangle wave is included by using i == j.
    scale = lcm(*(v.denominator for v in phases))
    shifts = [int(v * scale) for v in phases]
    n = len(shifts)
    best, divisor = 0, 1
    for i, j in combinations_with_replacement(range(1, n + 1), 2):
        step = i + j
        period = scale * step
        origin = (-shifts[i-1] - shifts[j-1]) % scale
        for numerator in range(origin, period, scale):
            smallest = period
            for v, s in enumerate(shifts, 1):
                residue = (v * numerator + step * s) % period
                smallest = min(smallest, residue, period - residue)
                if smallest * divisor <= best * period:
                    break
            if smallest * divisor > best * period:
                best, divisor = smallest, period
    return F(best, divisor)


def prediction(phases):
    p = len(phases) + 1
    return F(1, p) + max(abs((p-a)*phases[a-1] - a*phases[p-a-1])/p
                           for a in range(1, (p+1)//2))


def run():
    rng = Random(57)
    for p in (7, 11, 13, 17, 19, 23, 29, 31, 59):
        q = (p-1)//2 if p % 4 == 3 else (p-3)//2
        h = p+1-q
        r = F(1, 2*q*(p+1))
        for _ in range(5):
            u = [r * F(rng.randint(-8, 8),8) for _ in range(1,p)]
            assert radius(u) == prediction(u)
        for factor in (1, F(1001,1000)):
            s = r*factor
            u = [F(0)]*(p-1)
            u[q-1] = u[p-q-1] = s
            u[h-1], u[p-h-1] = -s, -F(p-h,h)*s
            actual = radius(u)
            assert (actual == prediction(u)) if factor == 1 else (actual > prediction(u))
        print(f'p={p}: five interior samples, boundary and exterior witness verified', flush=True)


if __name__ == '__main__':
    run()
