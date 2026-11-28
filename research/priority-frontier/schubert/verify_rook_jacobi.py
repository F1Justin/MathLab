"""Exact algebra and independent flats-lattice checks for rook_jacobi.md."""
from functools import cache
from itertools import combinations, combinations_with_replacement, product
from math import comb
import sympy as sp


def symbolic_proof():
    n, x, z, s, c = sp.symbols("n x z s c")
    a = lambda j: (2*j+1)/(j+2)
    b = lambda j: (j-1)/(j+2)
    short = [sp.jacobi(j, 1, 1, x)/(j+1) for j in range(4)]
    ratio = [1, 0, -1/b(n), -a(n-1)*x/(b(n)*b(n-1))]
    for mask in range(8):
        J = [i+1 for i in range(3) if mask & (1 << i)]
        node_value = 0
        for count in range(len(J)+1):
            for kept in combinations(J, count):
                cuts = (0,) + kept
                node_value += ((-1)**count * ratio[cuts[-1]]
                               * sp.prod(short[q-p] for p,q in zip(cuts, kept)))
        p = sp.cancel(4*(n-1)*(n-2)*node_value)
        terms = sp.Poly(p.subs(n, s+4).subs(x**2, z), s).all_coeffs()
        for term in terms:
            poly = sp.Poly(term, z)
            coeffs = poly.all_coeffs()
            positive_coeffs = coeffs[-1] > 0 and all(v >= 0 for v in coeffs)
            if not positive_coeffs:
                assert poly.degree() == 2 and poly.LC() > 0 and sp.discriminant(poly) < 0
    slope = n*(n+3)/4 + (c-1)*(n-1)/2
    energy = 2*(c-1)*(1+c*b(n+1)) - slope*((c-1)-c*b(n+1))
    assert sp.factor(4*energy - (2*c*c-c*n+4*c+n*n+n-6)) == 0
    for rank in range(3, 16, 2):
        A = [sp.jacobi(j, 1, 1, x)/(j+1) for j in range(rank+1)]
        half = sum(A[rank]-A[j]*A[rank-j] for j in range(1, (rank+1)//2))
        d = sp.Integer(rank)
        numerator = (rank+1)*(1-x*x)-4*b(d+2)*(1-a(d+1)*x*x)
        identity = (2*(1-x*x)*half - numerator*A[rank]).expand()
        assert sp.rem(identity, A[rank-1], x) == 0
    print("Verified the eight symbolic sign certificates, slope identity and half-height sample residues.")


def flats_polynomial(shape):
    """Construct the lattice of flats from bases and use KL degree/palindromicity."""
    n = len(shape)
    size = n + shape[0]
    bases = []
    for basis in combinations(range(size), n):
        if all(j >= a + shape[0] - shape[a] for a,j in enumerate(basis)):
            bases.append(sum(1 << j for j in basis))
    ranks = [max((basis & bits).bit_count() for basis in bases) for bits in range(1 << size)]
    flats = [bits for bits, rank in enumerate(ranks)
             if all((bits >> i & 1) or ranks[bits | (1 << i)] > rank for i in range(size))]

    @cache
    def interval_polynomials(f):
        r = n-ranks[f]
        if not r:
            return (1,), (1,)
        suffix = [0]*(r+1)
        for g in flats:
            if f == g or (f & g) != f:
                continue
            local_kl, _ = interval_polynomials(g)
            for i, coeff in enumerate(local_kl, ranks[g]-ranks[f]):
                suffix[i] += coeff
        local_kl = tuple(suffix[r-i]-suffix[i] for i in range((r+1)//2))
        for i, coeff in enumerate(local_kl):
            suffix[i] += coeff
        assert suffix == suffix[::-1]
        return local_kl, tuple(suffix)
    return interval_polynomials(0)[1]


def boundary_certificate():
    """Compute the winding polynomial of a four-row, two-column rectangle."""
    s = sp.Symbol("s")
    half = sp.Rational(3, 2)
    D = [sum(comb(j, a) * sp.rf(half, a) * sp.rf(half, j - a)
             * s**a / sp.rf(3, j) for a in range(j + 1)) for j in range(5)]
    polynomial = 0
    for k in range(3):
        for rows in combinations(range(1, 5), k):
            for count in range(k + 1):
                for cuts in combinations(rows, count):
                    polynomial += comb(2, k) * (-1)**count * sp.prod(
                        D[q - p] for p, q in zip((0,) + cuts, cuts))
    expected = 2535 - 1268*s - 590*s**2 - 292*s**3 - 129*s**4
    assert sp.expand(256*polynomial - expected) == 0
    coeffs = sp.Poly(polynomial, s).all_coeffs()[::-1]
    assert coeffs[0] - sum(abs(c) for c in coeffs[1:]) == 1
    # Calculate the same polynomial from the height chain at five rational
    # parameters. After each step, independently count every possible rook.
    for value in map(sp.Rational, (-1, -1/2, 0, 1/2, 1)):
        states = {(0, 3): 1}
        for _ in range(4):
            following = {}
            for (height, column), mass in states.items():
                move = (1 - value) / (4 * (height + 1))
                for new_height, prob in ((height, (1 + value)/2),
                                         (height + 1, (height + 2)*move),
                                         (height - 1, height*move)):
                    if not prob:
                        continue
                    available = range(1, column) if new_height > 0 else ()
                    for next_column in (column, *available):
                        key = (new_height, next_column)
                        following[key] = following.get(key, 0) + mass*prob
            states = following
        assert sum(states.values()) == polynomial.subs(s, value)
    print("Verified the rectangle boundary polynomial and its unit-disk margin by two enumerations.")


def four_row_certificate():
    """Prove the grouped coefficients for all Ferrers boards of height four."""
    n, m, x, y = sp.symbols("n m x y")
    A = [sp.jacobi(j, 1, 1, x)/(j + 1) for j in range(5)]
    R = [1, 0]
    for j in range(2, 5):
        index = n - j + 2
        R.append(sp.factor(((2*index + 1)*x*R[-1] - (index + 2)*R[-2]) / (index - 1)))
    scaled = {}
    factor = 16*(n - 1)*(n - 2)*(n - 3)
    for k in range(1, 5):
        for rows in combinations(range(1, 5), k):
            f = sum((-1)**len(cuts) * R[max((0,) + cuts)]
                    * sp.prod(A[q-p] for p, q in zip((0,) + cuts, cuts))
                    for count in range(k + 1) for cuts in combinations(rows, count))
            f = sp.cancel(factor*f).expand().subs(x**2, y).subs(n, m + 5)
            scaled[rows] = sp.Poly(f, m, y)

    minima = [None]*4
    for k in range(1, 5):
        for heights in combinations_with_replacement(range(1, 5), k):
            if any(j > height for j, height in enumerate(heights, 1)):
                continue
            group = sum(f for rows, f in scaled.items() if len(rows) == k
                        and all(i <= height for i, height in zip(rows, heights)))
            assert group.degree(m) <= 3 and group.degree(y) <= 3
            for power in range(4):
                p = sum(c*y**j for (i, j), c in group.terms() if i == power)
                for half in (0, 1):
                    q = sp.Poly(p.subs(y, (half+y)/2), y)
                    for ell in range(4):
                        bernstein = sum(sp.Rational(comb(ell, i), comb(3, i))*q.nth(i)
                                        for i in range(ell + 1))
                        assert bernstein > 0
                        if minima[power] is None or bernstein < minima[power]:
                            minima[power] = bernstein
    assert minima == [41, 150, sp.Rational(319, 4), 11]
    print("Verified four-row Ferrers groups for arbitrary column weights:", minima)


def rectangle_series_certificate():
    """Check the radical identity against direct Markov occupation counts."""
    max_h, max_w = 5, 4
    indices = [(h, w) for h in range(max_h + 1) for w in range(max_w + 1)]
    one = {(0, 0): 1}
    def multiply(left, right):
        return {(h, w): sum(left.get((i, j), 0) * right.get((h-i, w-j), 0)
                            for i in range(h + 1) for j in range(w + 1))
                for h, w in indices}
    ax = multiply({**one, (0, 1): -1}, {**one, (0, 1): -1, (1, 0): -1})
    for sample in range(max_h + 1):
        s = sp.Rational(2*sample - max_h, max_h)
        k = {(h, w): (-1)**(h+w) * sp.binomial(sp.Rational(1, 2), h+w)
             * comb(h+w, h) * (1+s**h) for h, w in indices}
        k_squared = multiply(k, k)
        denominator = k_squared.copy()
        denominator[0, 1] += 4
        states = {(0, 0): 1}
        g = {}
        for h in range(max_h + 1):
            for w in range(max_w + 1):
                g[h, w] = sum(prob*comb(positive + w, w)
                              for (_, positive), prob in states.items())
            following = {}
            for (height, positive), mass in states.items():
                move = (1-s)/(4*(height+1))
                for new_height, prob in ((height, (1+s)/2), (height+1, (height+2)*move),
                                         (height-1, height*move)):
                    if prob:
                        key = (new_height, positive + int(new_height > 0))
                        following[key] = following.get(key, 0) + mass*prob
            states = following
        assert multiply(multiply(g, ax), denominator) == k_squared
    print("Checked the rectangle generating function exactly through height 5 and width 4.")


def prefix_survival_certificate():
    """Check the prefix boundary symbol with killing at every time."""
    max_height = 8
    for sample in range(max_height + 1):
        s = sp.Rational(2*sample-max_height, max_height)
        masses = {0: 1}
        for h in range(1, max_height + 1):
            following = {}
            for height, mass in masses.items():
                move = (1-s)/(4*(height+1))
                for new_height, prob in ((height, (1+s)/2), (height+1, (height+2)*move),
                                         (height-1, height*move)):
                    if new_height > 0 and prob:
                        following[new_height] = following.get(new_height, 0) + mass*prob
            masses = following
            m = h-1
            moment = sum(comb(m, j)*sp.rf(sp.Rational(1, 2), j)
                         * sp.rf(sp.Rational(3, 2), m-j)*s**j for j in range(m+1))/sp.rf(2, m)
            assert sum(masses.values()) == (1-s)*(1+moment)/4
    print("Checked every prefix survival symbol through height 8 by independent killed-chain counts.")


def direct_motzkin(shape):
    n = len(shape)
    coeffs = [0]*(n+1)
    for steps in product((-1,0,1), repeat=n):
        positive, height = [], 0
        for i, step in enumerate(steps):
            height += step
            if height < 0:
                break
            if height and i < n-1:
                positive.append(i)
        else:
            if height:
                continue
            k = steps.count(1)
            # Choose strictly decreasing columns of nonnesting rooks.
            placements = {shape[0]: 1}
            for row in positive:
                new = placements.copy()
                for previous, count in placements.items():
                    for col in range(1, min(previous, shape[row+1])):
                        new[col] = new.get(col, 0) + count
                placements = new
            for j in range(n-2*k+1):
                coeffs[k+j] += sum(placements.values())*comb(n-2*k,j)
    return tuple(coeffs)


if __name__ == "__main__":
    symbolic_proof()
    boundary_certificate()
    four_row_certificate()
    rectangle_series_certificate()
    prefix_survival_certificate()
    for shape in ((2,2), (3,3,2,1), (4,4,3,2,1), (3,3,2,2,1,1), (3,3,1,1,1,1)):
        from_flats = flats_polynomial(shape)
        assert from_flats == direct_motzkin(shape)
        print(shape, from_flats)
