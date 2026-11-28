"""Exact rational bounds for the Gegenbauer parameter range and Bessel obstruction."""

from fractions import Fraction as F
import sympy as sp


def rayleigh():
    s, l, q, v = sp.symbols("s l q v")
    t = (22*l + 29)/20
    b = l + sp.Rational(1, 2)
    for e, minimum in enumerate([sp.Rational(524799, 16000), sp.Rational(7634799, 160000)]):
        m = 2*s + e + l
        h = s + e + l
        numerator = s**2*h**2*(b+1) - s*(s-1)*h*(h+1)*b
        poly = sp.Poly(b**2*(b+1)*m**4-t**4*numerator, l, s)
        shifted = sp.Poly(sum(c*(1+3*v/2)**i*(1+v)**(7-i)*(1+q)**j
                              for (i, j), c in poly.terms()), v, q)
        assert len(shifted.coeffs()) == 40 and min(shifted.coeffs()) == minimum


def large_angles():
    def threshold(l):
        return (22*l + 29)/20
    for i in range(20):
        lo = 1 + F(i, 40)
        hi = lo + F(1, 40)
        t = threshold(hi)
        loss = hi*(hi-1)/t**2
        prefactor = (1 + (7*hi/(11*t))**2) / ((1-loss)*(1-3*loss/2))
        # Bound after raising the positive product to the twentieth power.
        powered = prefactor**20 * (2/threshold(lo))**(40+i) * F(400, 157)**(i+1)
        assert powered < F(967, 1000)**20


def bessel(b, t):
    term = value = F(1)
    for k in range(1, 61):
        term *= -t**2/(4*k*(b+k-1))
        value += term
    next_term = term * (-t**2/(4*61*(b+60)))
    assert 0 < t**2/(4*61*(b+60)) < 1
    return value + next_term, value


def cuts():
    l = F(77, 20)
    b = l + F(1, 2)
    lo, hi = F(11513567, 10**6), F(11513568, 10**6)
    assert bessel(b+1, lo)[1] < 0 < bessel(b+1, hi)[0]
    a0, a1 = bessel(b, lo)
    c0, _ = bessel(b, lo/2)
    length = hi-lo
    assert a0-length > F(6, 1000)
    assert a1+length < F(61, 10000)
    assert c0-length/2 > F(783, 10000)
    assert F(783, 10000)**2 > F(61, 10000)


def polynomial_tail():
    x, y, l, t = sp.symbols("x y l t")
    def positive_parameter(poly):
        coefs = sp.Poly(poly, l).shift(14).all_coeffs()
        assert min(coefs) >= 0 and coefs[-1] > 0

    def primitive_even(expr):
        p = sp.Poly(sp.expand(expr).subs(x**2, y), y)
        content, p = p.primitive()
        positive_parameter(content)
        return p.as_expr()

    j, n = [sp.Poly(sp.gegenbauer(i, l, x), x).primitive()[1].as_expr() for i in (8, 16)]
    d = primitive_even(sp.cancel(n.diff(x)/x))
    g = primitive_even(sp.cancel((j**2*n.subs(x, 1)-n*j.subs(x, 1)**2)/(1-x**2)))
    result = sp.Poly(sp.resultant(d, g, y), l)
    assert result.degree() == 77
    assert min(result.shift(14).all_coeffs()) > 0

    # Exact signs near the selected squared derivative node at lambda=14.
    lo, hi = sp.Rational(4600706, 10**7), sp.Rational(4600707, 10**7)
    assert d.subs({l: 14, y: lo}) * d.subs({l: 14, y: hi}) < 0
    assert j.subs({x: 1, l: 14}) > 0 and n.subs({x: 1, l: 14}) > 0
    for expr in (g, primitive_even(n)):
        p = sp.Poly(expr.subs(l, 14), y)
        b = sp.Poly(sum(c*(lo+hi*t)**i*(1+t)**(p.degree()-i)
                        for (i,), c in p.terms()), t)
        assert min(b.all_coeffs()) > 0


if __name__ == "__main__":
    rayleigh()
    large_angles()
    cuts()
    polynomial_tail()
    print("Rayleigh coefficients, all 20 angle bounds, Bessel signs and the infinite parameter tail certified.")
