"""Check the paired-edge signs and the reciprocal-input obstruction exactly."""
from fractions import Fraction
from math import comb


def rows(maximum):
    """Shifted Eulerian rows by insertion, without using the descent bound."""
    result = [[1]]
    for n in range(1, maximum + 1):
        prev = result[-1] + [0]
        result.append([0] + [k * prev[k] + (n + 1 - k) * prev[k - 1] for k in range(1, n + 1)])
    return result


def transformed(weights, triangle):
    return [sum(weights[j] * triangle[j][k] for j in range(k, len(weights)))
            for k in range(len(weights))]


def rational_sign(coefficients, argument):
    # Integer homogeneous Horner evaluation, coefficients low-to-high.
    u, v = argument.as_integer_ratio()
    acc, multiplier = 0, 1
    for coeff in reversed(coefficients):
        acc = acc * u + multiplier * coeff
        multiplier *= v
    return (acc > 0) - (acc < 0)


def verify_bands(n, levels):
    triangle = rows(n)
    rev = transformed(triangle[n], triangle)[::-1]
    previous_end = 0
    for level in levels:
        rho = Fraction(level, level + 1)
        s = rho ** (level - 1)
        vertex = (s + Fraction(1, level)) * (level + 1) / (2 * s)
        points = [rho**n * z for z in (Fraction(1, 8), vertex, 2 * vertex)]
        assert previous_end < points[0]
        assert [rational_sign(rev, -t) for t in points] == [1, -1, 1], (n, level)
        previous_end = points[-1]
    print(f"n={n}: exact signs isolate two roots in each band L={levels[0]}..{levels[-1]}")


def verify_power_cluster(n, power, level):
    # Root bounds for the limiting polynomial are found by exact isolation.
    from sympy import Poly, QQ, symbols
    x = symbols("x")
    rho = Fraction(level, level + 1)
    q = Poly(1, x, domain=QQ)
    for i in range(1, power + 1):
        alpha = Fraction(1, level**(power-i)) * rho**((i-1)*(level-1))
        q -= Poly(alpha*x*q.as_expr().subs(x, rho*x), x, domain=QQ)
    bounds = q.intervals(eps=Fraction(1,200))
    assert len(bounds) == power and all(0 < lo <= hi and m == 1 for (lo, hi), m in bounds)
    points = [bounds[0][0][0]/2]
    points.extend((left[0][1]+right[0][0])/2 for left,right in zip(bounds,bounds[1:]))
    points.append(2*bounds[-1][0][1])
    triangle = rows(n)
    weights = triangle[n]
    for _ in range(power-1):
        weights = transformed(weights, triangle)
    actual = [rational_sign(weights[::-1], -rho**n * Fraction(z)) for z in points]
    assert actual == [(-1)**(power*(level-1)+j) for j in range(power+1)]
    print(f"n={n}, power={power}, L={level}: {power} alternating sign gaps")


def verify_obstruction():
    from sympy import Poly, symbols
    x = symbols("x")
    f = Poly(x * (x + 1) * (x*x + 99*x + 1)**3, x)
    h = Poly.from_list(transformed(f.all_coeffs()[::-1], rows(8))[::-1], x)
    assert h.all_coeffs() == [1,545,69756,3063907,36713966,86382243,38859251,2060602,0]
    assert len(h.intervals()) == 6 and h.gcd(h.diff()).degree() == 0
    print("Reciprocal PF quotient witness: degree 8, six real roots, one nonreal conjugate pair")


if __name__ == "__main__":
    verify_bands(80, range(1, 5))
    verify_bands(150, range(1, 6))
    verify_power_cluster(120, 3, 2)
    verify_power_cluster(120, 4, 2)
    verify_obstruction()
