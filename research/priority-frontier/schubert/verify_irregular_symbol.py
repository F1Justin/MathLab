"""Prove disk stability on six irregular columns with arbitrary nonnegative weights."""
from functools import reduce
from itertools import accumulate
from math import comb, gcd, lcm
import numpy as np


def selection_symbols(flags):
    """Coefficient of each selected-column monomial in 4^h times H(s)."""
    h = max(flags)
    masks = 1 << len(flags)
    state = np.zeros((masks, h + 2, h + 1), dtype=object)
    state[0, 0, 0] = 1
    for time in range(1, h + 1):
        previous = state[:, :time, :time]
        following = np.zeros((masks, time + 1, time + 1), dtype=object)
        # After conjugation by height+1 the three step weights, times 4,
        # are 2(1+s) for a hold and 1-s for either neighbor.
        following[:, :time, :time] += 2 * previous
        following[:, :time, 1:] += 2 * previous
        following[:, 1:, :time] += previous
        following[:, 1:, 1:] -= previous
        following[:, :time-1, :time] += previous[:, 1:time]
        following[:, :time-1, 1:] -= previous[:, 1:time]
        # Decreasing mask order keeps every source free of same-time rooks.
        for mask in reversed(range(1, masks)):
            column = mask.bit_length() - 1
            if time <= flags[column]:
                following[mask, 1:] += following[mask ^ (1 << column), 1:]
        state[:, :time+1, :time+1] = following
    return (state[:, :h+1, :] * np.arange(1, h+2)[None, :, None]).sum(axis=1)


def primitive(values):
    divisor = reduce(gcd, values)
    return [entry // divisor for entry in values]


def real_part_on_interval(coeffs):
    """Return sum c_j T_j(1-2t) in the monomial basis."""
    result = [0] * len(coeffs)
    prior, current = [], [1]
    for j, c in enumerate(coeffs):
        for i, value in enumerate(current):
            result[i] += c * value
        if j == 0:
            prior, current = current, [1, -2]
            continue
        nxt = [0] * (len(current) + 1)
        for i, value in enumerate(current):
            nxt[i] += 2*value
            nxt[i+1] -= 4*value
        for i, value in enumerate(prior):
            nxt[i] -= value
        prior, current = current, nxt
    return result


def integer_bernstein(power):
    degree = len(power) - 1
    divisors = [comb(degree, j) for j in range(degree + 1)]
    common = reduce(lcm, divisors)
    return primitive([sum(power[j] * (common//divisors[j]) * comb(i, j)
                          for j in range(i+1)) for i in range(degree+1)])


def positive_leaves(bernstein, depth=0):
    if min(bernstein) > 0:
        return 1, depth
    assert max(bernstein) > 0 and depth < 10
    degree = len(bernstein) - 1
    levels, left, right = bernstein, [], []
    for j in range(degree + 1):
        left.append(levels[0] << (degree-j))
        right.append(levels[-1] << (degree-j))
        levels = [x+y for x, y in zip(levels, levels[1:])]
    first, level1 = positive_leaves(primitive(left), depth+1)
    second, level2 = positive_leaves(primitive(right[::-1]), depth+1)
    return first+second, max(level1, level2)


def evaluate_at_rational_point(poly, real, imag, denominator):
    """Horner evaluation returning the numerator after clearing all denominators."""
    numerator_real, numerator_imag, scale = 0, 0, 1
    for c in reversed(poly):
        numerator_real, numerator_imag = (real*numerator_real - imag*numerator_imag + c*scale,
                                          imag*numerator_real + real*numerator_imag)
        scale *= denominator
    return numerator_real, numerator_imag, scale//denominator


if __name__ == "__main__":
    flags = (1, 40, 62, 63, 72, 104)
    symbols = selection_symbols(flags)
    certificates = []
    for row in symbols[1:]:
        assert sum(row) == 0
        quotient = list(accumulate(row))[:-1]  # H_J / (1-s)
        coefficients = real_part_on_interval(primitive(quotient))
        certificates.append(positive_leaves(integer_bernstein(coefficients)))
    assert len(certificates) == 63
    assert sum(k for k, d in certificates) == 353 and max(d for k, d in certificates) == 4
    # The shortest column of weight 2000 is exactly 2000 unit columns
    # of height one, because two such columns cannot both receive rooks.
    target = sum((2000 if mask & 1 else 1)*row for mask, row in enumerate(symbols))
    real, imag, scale = evaluate_at_rational_point(target, 99, 20, 101)
    scale *= 4**max(flags)
    assert 99**2 + 20**2 == 101**2 and -288392579 * scale < real < -288392578 * scale
    print("Certified all nonempty flag terms on the circle and the strict negative real part.")
