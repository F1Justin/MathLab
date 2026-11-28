"""Verify the Bessel obstruction in order intervals with Bernstein interpolation."""

from fractions import Fraction as F
from flint import arb, ctx

ctx.prec = 96
one = arb(1)


def real(x):
    return arb(x.numerator)/x.denominator


def integral(order, t):
    z = real(order)
    x = real(t)
    return arb.pi().sqrt() * z.gamma()/(z+one/2).gamma() * (-x*x/4).hypgeom_0f1(z+one/2)


def bernstein(y):
    def inner(a, b, c, d):
        return 3*b-3*c/2-5*a/6+d/3
    return [y[0], inner(*y), inner(*reversed(y)), y[-1]]


def span(a, b):
    return [a+(b-a)*i/3 for i in range(4)]


def hull(points):
    first, *others = points
    for entry in others:
        first = first.union(entry)
    return first


def enclosure(lo, hi, a, b):
    vals = [[integral(lam, t) for t in span(a, b)] for lam in span(lo, hi)]
    along_t = [bernstein(row) for row in vals]
    coefs = [c for column in zip(*along_t) for c in bernstein(column)]
    error = (hi-lo)**4/12 + F(17, 3)*(b-a)**4/12
    return hull(coefs) + arb(0, real(error))


def vertical(lo, hi, t):
    vals = [integral(lam, t) for lam in span(lo, hi)]
    return hull(bernstein(vals)) + arb(0, real((hi-lo)**4/12))


def trial(lo, hi):
    mid = (lo+hi)/2
    guess = F(1152, 100) + F(6, 5)*(mid-F(77, 20))
    left, right = guess-F(7, 10), guess+F(7, 10)
    assert integral(mid+1, left) < 0 < integral(mid+1, right)
    for _ in range(36):
        c = (left+right)/2
        if integral(mid+1, c) < 0:
            left = c
        else:
            right = c
    pad = F(7, 8)*(hi-lo) + F(1, 10**9)
    a, b = left-pad, right+pad
    if not (vertical(lo+1, hi+1, a) < 0 < vertical(lo+1, hi+1, b)):
        return False
    midval = enclosure(lo, hi, a, b)
    half = enclosure(lo, hi, a/2, b/2)
    mass = vertical(lo, hi, F(0))
    return midval > 0 and half > 0 and half**2 > mass*midval


def bessel_cover():
    faces = [(F(192211, 50000), F(14))]
    count = 0
    while faces:
        lo, hi = faces.pop()
        if trial(lo, hi):
            count += 1
            continue
        assert hi-lo > F(1, 10**10), (lo, hi)
        mid = (lo+hi)/2
        faces.extend(((lo, mid), (mid, hi)))
    print("Bessel parameter slabs:", count)


if __name__ == "__main__":
    bessel_cover()
