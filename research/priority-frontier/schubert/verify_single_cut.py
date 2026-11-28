"""Exact checks for the one-cut Jacobi inequality using rational arithmetic."""

import sympy as sp


def check_constants():
    s, q = sp.symbols("s q")
    for e in (0, 1):
        m = 2 * s + e + sp.Rational(3, 2)
        b = s + e + sp.Rational(3, 2)
        linear = -s * b / 2
        quadratic = s * (s - 1) * b * (b + 1) / 12
        squares = linear**2 - 2 * quadratic
        rayleigh = sp.Poly((16 * (m**4 - 96 * squares)).subs(s, q + 1), q)
        expected = ([128, 896, 1856, 1008, 1] if e == 0 else
                    [128, 1152, 3392, 3600, 1857])
        assert rayleigh.all_coeffs() == expected

        energy = m * (m**2 - sp.Rational(3, 4) if e == 0 else (2*s + 1)**2)
        ratio = energy.subs(s, s + 1) * ((2*s + 1) / (2*(s + 2)))**2 / energy
        num, den = sp.fraction(sp.factor(ratio - 1))
        assert min(sp.Poly(num, s).all_coeffs()) > 0
        assert min(sp.Poly(den, s).all_coeffs()) > 0
    t = sp.Rational(31, 10)
    long = 8 * (1 + sp.Rational(9, 4)*(7/(11*t))**2) / (1 - sp.Rational(21, 20)/t**2)
    short = sp.Rational(8, 3) / (t**3 * (1 - sp.Rational(3, 4)/t**2))
    assert long * short == sp.Rational(509224000, 533403453) < 1


def sign_at_nodes(nodes, polynomial):
    sequence = [nodes, (polynomial * nodes.diff()).rem(nodes)]
    while not sequence[-1].is_zero:
        sequence.append(-sequence[-2].rem(sequence[-1]))
    def variations(at):
        values = [p.eval(at) for p in sequence[:-1]]
        signs = [value > 0 for value in values if value]
        return sum(left != right for left, right in zip(signs, signs[1:]))
    return variations(-1) - variations(1)


def check_nodes(max_rank):
    x = sp.Symbol("x")
    polys = [sp.Poly(sp.jacobi(i, 1, 1, x)/(i + 1), x, domain=sp.QQ)
             for i in range(max_rank + 1)]
    total = 0
    for n in range(2, max_rank + 1):
        a = polys[n]
        nodes = a.diff()
        for j in range(1, n//2 + 1):
            difference = a * (a - polys[j] * polys[n-j])
            assert sign_at_nodes(nodes, difference) == n - 1, (n, j)
            total += n - 1
    return total


if __name__ == "__main__":
    check_constants()
    print("Exact sign queries at Jacobi critical nodes through rank 24:", check_nodes(24))
