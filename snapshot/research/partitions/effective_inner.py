"""Independent checks of the explicit real-saddle and Airy inequalities."""
from collections import deque
from fractions import Fraction
from math import comb
from pathlib import Path
import json
from flint import arb, arb_poly, ctx, fmpz_poly
from scipy.optimize import brentq


def ball(a, b=1):
    return arb(a)/b


def small_rows(last):
    """Certify that the Taylor coefficients shifted by the limiting cutoff are positive."""
    x = fmpz_poly([0,1])
    rows = deque([fmpz_poly([1])], maxlen=4)
    c = 3/(2*arb(1).exp())
    for n in range(last):
        p = rows[-1]
        q = p+x*p.derivative()
        if n >= 1:
            q += n*rows[-2]
        if n >= 2:
            q += comb(n,2)*rows[-3]
        if n >= 3:
            q += comb(n,3)*x*rows[-4]
        rows.append(q)
        def moment(r):
            return r+r*r+r**3/2
        approx = brentq(lambda v: moment(v)-(n+1), 0, 2*(n+1)**(1/3))
        lo = arb(approx-1e-10)
        hi = arb(approx+1e-10)
        assert moment(lo)<n+1<moment(hi)
        r = lo.union(hi)
        shift = c*r*(-r).exp()
        shifted = arb_poly(q)(arb_poly([-shift,1]))
        assert all(v>0 for v in shifted.coeffs()), n+1


def real_saddle_constants():
    R = arb(15)
    v0 = ball(3,10)
    qmax = ball(3,2)
    assert R+R**2+R**3/2 < 2000
    assert ball(3,2)+2/R+1/R**2 < ball(164,100)
    third = (ball(9,2)+4/R+1/R**2)/R + qmax*(1+3/R+1/R**2)
    assert third / (6*(15*v0**3).sqrt()) < ball(56,100)
    fourth = qmax*(1+6/R+7/R**2+1/R**3)
    assert fourth / (24*15*v0**2) < ball(7,100)
    assert (ball(27,2)+8/R+1/R**2)/(24*25*v0) < ball(8,100)
    assert (ball(9,50)-ball(3,5)**4/24)/6 > ball(29,1000)
    assert ball(29,1000)*15 > ball(1,4)
    assert (R**3*v0).sqrt()/5 > ball(4,3)
    assert ball(56,100)*ball(4,3)**3 < arb.pi()/2
    core = (1-ball(56,100)**2/2)*(1-ball(1,6)-ball(7,500))
    mid = (-ball(42,100)*ball(4,3)**2).exp()/(ball(84,100)*ball(4,3))
    far = arb.pi()*(ball(164,100)*R**3).sqrt()*(-R**2/20).exp()
    assert core>ball(2,3) and mid<ball(52,100) and far<ball(1,50)
    assert core-mid-far>ball(1,10)


def airy_table():
    """Exact alternating bounds for f''=-u f with the two extremal initial slopes."""
    Q = Fraction
    for slope in (Q(1,3),Q(1)):
        for u in (Q(2),Q(5,2),Q(13,5)):
            for der in (False,True):
                sums=[Q(0),Q(0)]
                for l,c in [(0,Q(1)),(1,slope)]:
                    terms=[]
                    for j in range(10):
                        terms.append(c*l*u**(l-1) if der else c*u**l)
                        l += 3
                        c = -c/(l*(l-1))
                    sums[0] += sum(terms)
                    sums[1] += sum(terms[:9])
                low,high=sums
                assert low<=high
                if u==2:
                    assert (high < -1) if der else (low>Q(1,4))
                if u==Q(5,2) and not der:
                    assert high < -Q(1,5)
                if u==Q(13,5):
                    assert (high < -1) if der else (-Q(3,4)<low<=high<0)


if __name__ == '__main__':
    ctx.prec=192
    real_saddle_constants()
    airy_table()
    small_rows(2004)
    result=dict(finite_shifted_positive_through=2004,positive_real_saddle_from=2000,
                airy_series_endpoint_arithmetic='exact rational',precision_bits=ctx.prec)
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
    print(result)
