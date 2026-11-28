"""Check the one-column convolution identity against integer Motzkin path counts."""
from fractions import Fraction
from itertools import combinations, combinations_with_replacement, product
from math import comb, prod

import sympy as sp

from verify_horizontal_extension import check_interlacing


def check_sum(n):
    # Compare every individual marked-time condition with the convolution identity.
    x = Fraction(2, 5)
    y = (x*x-1)/4
    unrestricted = [
        sum(comb(m, 2*k) * comb(2*k, k) // (k+1) * y**k * x**(m-2*k)
            for k in range(m//2+1))
        for m in range(n+3)
    ]
    for m in range(n+1):
        convolution = sum(unrestricted[i]*unrestricted[m-i] for i in range(m+1))
        assert y * convolution == unrestricted[m+2] - x*unrestricted[m+1]
    paths = []
    for steps in product((-1, 0, 1), repeat=n):
        height = 0
        positive = set()
        for j, step in enumerate(steps, 1):
            height += step
            if height < 0:
                break
            if height:
                positive.add(j)
        else:
            if height == 0:
                num_arcs = steps.count(1)
                paths.append((positive, y**num_arcs * x**(n-2*num_arcs)))
    for length in range(n):
        for rows in combinations(range(1, n), length):
            k = max(rows, default=0)
            f = sum(weight for available, weight in paths if set(rows) <= available)
            s = sum(weight * sum(j > k for j in available)
                    for available, weight in paths if set(rows) <= available)
            rhs = (n-k)*f
            for size in range(length+1):
                for cuts in combinations(rows, size):
                    gaps = [b-a for a, b in zip((0,)+cuts, cuts)]
                    ell = max(cuts, default=0)
                    coef = (-1)**size * prod(unrestricted[g] for g in gaps)
                    partial = sum(unrestricted[b]*unrestricted[n-ell-b] for b in range(k-ell+1))
                    convolution = (unrestricted[n-ell+2]-x*unrestricted[n-ell+1])/y
                    rhs += coef * (partial-convolution)
            assert rhs == s, (n, rows, rhs, s)


def check_four_tiers():
    n, x, v, t = sp.symbols("n x v t")
    A = [sp.jacobi(i, 1, 1, x)/(i+1) for i in range(5)]
    a = lambda m: (2*m+1)/(m+2)
    b = lambda m: (m-1)/(m+2)
    R = {0: sp.Integer(1), 1: sp.Integer(0)}
    for ell in (-1, -2):
        R[ell] = sp.factor(a(n-ell)*x*R[ell+1]-b(n-ell)*R[ell+2])
    for ell in range(2, 5):
        m = n-ell+2
        R[ell] = sp.factor((a(m)*x*R[ell-1]-R[ell-2])/b(m))
    scale = 256*(n-1)*(n-2)*(n-3)*(n+3)*(n+4)
    row_terms = {}
    for size in range(1, 5):
        for rows in combinations(range(1, 5), size):
            k = rows[-1]
            ratio = 0
            for count in range(size+1):
                for cuts in combinations(rows, count):
                    ell = max(cuts, default=0)
                    weight = (-1)**count * prod(A[j-i] for i, j in zip((0,)+cuts, cuts))
                    partial = sum(A[i]*R[ell+i] for i in range(k-ell+1))
                    convolution = 4*(R[ell-2]-x*R[ell-1])/(x*x-1)
                    ratio += weight*((n-k)*R[ell]+partial-convolution)
            polynomial = sp.Poly(sp.cancel((1-x*x)*scale*ratio), x)
            assert all(power % 2 == 0 for (power,), _ in polynomial.terms())
            row_terms[rows] = sp.Poly(sum(c*(1-v)**(power//2)
                                            for (power,), c in polynomial.terms()), v, n)
    lower_den = 5*(n*n+n+8)
    small_nodes = {rank: sp.Poly(sp.jacobi(rank-1, 1, 1, x), x, domain=sp.QQ)
                   for rank in range(5, 12)}
    cache = {}
    minima = []
    for size in range(1, 5):
        minimum = None
        for caps in combinations_with_replacement(range(1, 5), size):
            allowed = [poly for rows, poly in row_terms.items() if len(rows) == size
                       and all(i <= cap for i, cap in zip(rows, caps))]
            if not allowed:
                continue
            P = sum(allowed)
            coeffs = sp.Poly(P.as_expr(), v)
            degree = coeffs.degree()
            for half in (0, 1):
                if (degree, half) not in cache:
                    lo = (2-half)*69 + half*lower_den
                    hi = (1-half)*69 + (1+half)*lower_den
                    cache[degree, half] = [
                        sp.Poly((lo+hi*t)**j*(2*lower_den*(1+t))**(degree-j), n, t)
                        for j in range(degree+1)
                    ]
                certificate = sum(sp.Poly(coeffs.nth(j), n, t)*piece
                                  for j, piece in enumerate(cache[degree, half]))
                shifted = certificate.shift_list([12, 0])
                assert shifted.coeff_monomial(1) > 0 and min(shifted.coeffs()) > 0
                bound = min(shifted.coeffs())
                minimum = bound if minimum is None else min(minimum, bound)
            for rank, nodes in small_nodes.items():
                polynomial = sp.Poly(P.as_expr().subs({v: 1-x*x, n: rank}), x,
                                     domain=sp.QQ)
                remainder = (polynomial * nodes.diff()).rem(nodes)
                if remainder.is_zero:
                    continue
                chain = [nodes, remainder]
                while not chain[-1].is_zero:
                    chain.append(-chain[-2].rem(chain[-1]))
                def variations(at):
                    signs = [sp.sign(poly.eval(at)) for poly in chain[:-1] if poly.eval(at)]
                    return sum(a != b for a, b in zip(signs, signs[1:]))
                assert variations(-1)-variations(1) == rank-1, (rank, caps)
        minima.append(minimum)
    assert minima == [1280, 11200, 96000, 900000]
    print("Positive four-tier certificates by count of selected short columns:", minima)


if __name__ == "__main__":
    for n in range(2, 10):
        check_sum(n)
        check_interlacing(n, n-1, (1, 1, 1, 1), 1)
    check_four_tiers()
    print("Convolution identity holds for every marked-time subset in ranks 2 through 9.")
