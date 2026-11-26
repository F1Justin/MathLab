"""Certify extreme roots uniformly for 4m+s, m >= 500, with Arb balls."""
from fractions import Fraction
from math import comb, factorial
import json
from pathlib import Path
from flint import arb, arb_poly, ctx

ctx.prec = 256
MIN_M = 500
ORDER = 40
RADIUS = 82
RANKS = 5


def real(r):
    r = Fraction(r)
    return arb(r.numerator) / r.denominator


def coefficient_polynomials():
    """Coefficient in xi^l as a polynomial in y=500/m (sign applied later)."""
    dmax = 4 * ORDER + 3
    e = [arb(1)]
    for d in range(1, dmax + 1):
        e.append(sum(c * e[d-j] for j, c in [(1, 5), (2, 25), (3, real(Fraction(125, 2)))] if d >= j) / d)
    # Work in units where w in the auxiliary FPS is divided by 500.
    # The factors 500^i restore the powers from binom(m-l,i).
    b = arb_poly([0] + [real(Fraction(24 * 5**j, factorial(j+4) * MIN_M**(j-1))) for j in range(1, dmax+1)])
    power = arb_poly([v / MIN_M**d for d, v in enumerate(e)])
    column = []
    for i in range(dmax+1):
        column.append(power)
        power = (power*b).truncate(dmax+1) * (arb(1)/(i+1))
    falling = [arb_poly([1])]
    for j in range(ORDER+dmax):
        falling.append(falling[-1] * arb_poly([1, -arb(j)/MIN_M]))
    rows = []
    for s in range(4):
        row = []
        for l in range(ORDER+1):
            d = 4*l+s
            p = arb_poly([])
            for i in range(d+1):
                p += (falling[l+i] * column[i][d]).left_shift(d-i)
            row.append(p)
        rows.append(row)
    return rows


def tail(s, v):
    z = arb(5*RADIUS)/MIN_M
    a = z + z*z/2 + z**3/6
    b = 24*(z.exp()-1-a)/z**4
    ratio = v/RADIUS**4
    assert ratio < 1
    return (a + MIN_M*(b-1)).exp() / RADIUS**s * ratio**(ORDER+1)/(1-ratio)


def signed_cut(row, s, x, sign):
    v = 4*real(x)**4
    polynomial = arb_poly([])
    for a in reversed(row):
        polynomial = polynomial*(-v) + a
    return polynomial*arb(sign), tail(s,v)


def disk_count(coefs, s, x, k):
    v = 4*real(x)**4
    p = arb_poly([a*(-v)**j for j, a in enumerate(coefs)])
    error = tail(s, v)
    for step in range(5):
        c = p.coeffs()
        if abs(c[k]) > sum(abs(a) for j, a in enumerate(c) if j != k) + error:
            return step
        if step < 4:
            norm = sum(abs(a) for a in c)
            error *= 2*norm+error
            p = arb_poly(c[::2])**2 - (arb_poly(c[1::2])**2).left_shift(1)
    return None


def windows(s):
    # Proposed centers in hundredths, frozen to make the certificate platform-independent.
    centers = [(157,471,785,1100,1414), (236,550,864,1178,1492),
               (314,628,942,1257,1571), (393,707,1021,1335,1649)]
    return [(Fraction(c-40,100), Fraction(c+16,100)) for c in centers[s]]


def check_slab(row, s, signs, a, b):
    interval = real(a).union(real(b))
    coefs = [p(interval) for p in row]
    cuts = windows(s)
    for j,(polynomial,error) in enumerate(signs):
        if not polynomial(interval) > error:
            return None, ('sign',j)
    disk = cuts[-1][1] + 1
    steps = disk_count(coefs,s,disk,RANKS)
    return steps, ('disk',str(disk))


def difference_error(s, v):
    """Absolute bound for the change in the omitted tail, divided by 1/m."""
    q = arb(1)/MIN_M
    z = 5*q*RADIUS
    a = z + z**2/2 + z**3/6
    b = 24*(z.exp()-1-a)/z**4
    d = (b-1)/q
    assert d > RADIUS
    d2 = (b-1-q*RADIUS + (q*RADIUS).exp()-1-q*RADIUS)/q**2
    ratio = v*(1+q)**5/RADIUS**4
    # Successive terms of the polynomial majorant grow by at most ((l+1)/l)^2.
    l = ORDER+1
    decay = ratio*(arb(l+1)/l)**2
    assert decay < 1
    majorant = 2*(a/q + d2 + l*RADIUS + arb(l*l)/2) + 5*l
    return (a+d).exp()/RADIUS**s * ratio**l * majorant/(1-decay)


def verify_displacement(row, s):
    """Compare the same residue at m and m+1 using the generator 5v∂v-y∂y."""
    y = arb_poly([0,1])
    generator = [(p*arb(5*l) - y*p.derivative())*((-1)**l) for l,p in enumerate(row)]
    for k,(left,right) in enumerate(windows(s),1):
        vlo = 4*real(left)**4
        vhi = 4*real(right)**4
        width = vhi*(1+arb(1)/MIN_M)**5-vlo
        # Bernstein coefficients in h, where v=vlo+width*h and 0<=h<=1.
        shifted = [sum((generator[l]*(arb(comb(l,j))*vlo**(l-j)*width**j)
                        for l in range(j,ORDER+1)), arb_poly([])) for j in range(ORDER+1)]
        bernstein = [sum((shifted[j]*(arb(comb(i,j))/comb(ORDER,j))
                          for j in range(i+1)), arb_poly([])) * ((-1)**k)
                     for i in range(ORDER+1)]
        threshold = (1+arb(1)/MIN_M)*difference_error(s,vhi)
        for i in range(32):
            interval = (arb(i)/32).union(arb(i+1)/32)
            assert all(b(interval)>threshold for b in bernstein),(s,k,i)


def verify_order():
    scale4 = (1+Fraction(1,MIN_M))**5
    for s in range(4):
        for lag in (1,2,3):
            other = (s+lag)%4
            for k,(a,b) in enumerate(windows(s)):
                c,d = windows(other)[k]
                if other>s:
                    assert b<c
                    if k+1<RANKS:
                        assert d<windows(s)[k+1][0]
                else:
                    assert d<a
                    if k+1<RANKS:
                        assert b**4*scale4<windows(other)[k+1][0]**4
        assert windows(s)[-1][1]**4 * scale4 < (windows(s)[-1][1]+1)**4
        for k in range(RANKS-1):
            assert windows(s)[k][1]**4*scale4 < windows(s)[k+1][0]**4


def certify():
    verify_order()
    rows = coefficient_polynomials()
    results = []
    for s, row in enumerate(rows):
        verify_displacement(row,s)
        pending = [(Fraction(0),Fraction(1))]
        signs = [signed_cut(row,s,x,(-1)**(j+i)) for j,pair in enumerate(windows(s)) for i,x in enumerate(pair)]
        slabs = []
        while pending:
            a,b = pending.pop()
            steps, failed = check_slab(row,s,signs,a,b)
            if steps is None:
                if b-a <= Fraction(1,4096):
                    raise ArithmeticError((s,a,b,failed))
                mid = (a+b)/2
                pending.extend([(mid,b),(a,mid)])
            else:
                slabs.append([str(a),str(b),steps])
        results.append(dict(residue=s,windows=[[str(a),str(b)] for a,b in windows(s)],
                            disk_x=str(windows(s)[-1][1]+1),slabs=slabs))
        print(s,len(slabs),flush=True)
    return results


if __name__ == '__main__':
    result = certify()
    Path(__file__).with_suffix('.json').write_text(json.dumps(dict(min_m=MIN_M,
        retained_degree=ORDER, cauchy_radius=RADIUS, ranks=RANKS,
        same_residue_displacement_y_slabs=32, certified_lags=[1,2,3,4], rows=result),indent=2)+'\n')
