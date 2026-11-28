"""Certified two-parameter Bessel transfer inequalities; requires python-flint."""
from functools import lru_cache
from math import factorial
from flint import arb, ctx

ctx.prec = 112
ONE = arb(1)
ZERO = arb(0)
ORDER = 148
PAD = arb(0, 1.e-10)


def interval(lo, hi):
    return arb((lo + hi) / 2, (hi - lo) / 2)


@lru_cache(maxsize=8000)
def coefficients(lo, hi):
    p = interval(lo, hi)
    pairs = []
    for q0, q1 in [(ONE, ZERO), (ZERO, -ONE)]:
        q = [q0, q1]
        for k in range(ORDER-1):
            before = q[k-1] if k else ZERO
            q.append(p * ((k+3) * q[-1]) / (k+2)
                     - (q[k] - p * before) / ((k+1) * (k+2)))
        pairs.append((q[2:], [-k*q[k] for k in range(3, ORDER+1)]))
    return pairs


def horner(coef, x):
    y = coef[-1]
    for elt in reversed(coef[:-1]):
        y = y*x + elt
    return y


gc = [arb((-1)**i)/(4**i*factorial(i)*factorial(i+1)) for i in range(37)]
gdc = [2*i*gc[i] for i in range(1,len(gc))]


def midpoint_check(pl, ph, rl, rh):
    pc, rc = (pl+ph)/2, (rl+rh)/2
    p, r = interval(pl,ph), arb(rc)
    coeff = coefficients(pc,pc)
    e, f = (horner(c[0],r)+PAD for c in coeff)
    h, k = (horner(c[1],r)+PAD for c in coeff)
    prmax = arb(ph)*rh
    dp = (3*arb(rh)/(1-prmax)**4)*(ph-pl)/2
    dr = ((1+3*arb(ph)/(1-prmax))/(1-prmax)**3)*(rh-rl)/2
    err = arb(0,(dp+dr).upper())
    t11 = 1+r*r*e + err
    t12 = -r+r*r*f + err
    t21 = r+r*r*h + err
    t22 = 1+3*arb(pc)*r+r*r*k + err
    diff = arb(0,(rh-rl)/2)
    g = 1+r*r*(horner(gc[1:],r*r)+PAD)+diff
    gd = r*(horner(gdc,r*r)+PAD)+diff
    a = 1-g*t11
    b = (3*p-g*(3*p*t11+t12+t21))/2
    c = 1-g*(3*p*t12+t22)
    if not (a>0 and a*c>b*b):
        return False
    b2 = (3*p-t11*(3*p*g+gd)-t12*g)/2
    c2 = 1-t12*(3*p*g+gd)
    return a*c2>b2*b2


def check(pl, ph, rl, rh):
    if rl>=1.5:
        return midpoint_check(pl,ph,rl,rh)
    p, r = interval(pl,ph), interval(rl,rh)
    coeff = coefficients(pl,ph)
    e, f = (horner(c[0],r)+PAD for c in coeff)
    h, k = (horner(c[1],r)+PAD for c in coeff)
    r2 = r*r
    gal = horner(gc[1:],r2)+PAD
    g1 = horner(gdc,r2)+PAD
    g = 1 + r2*gal
    a = -gal - g*e
    b = -(3*p*gal + g*(f+3*p*e+h))/2
    c = -gal - g*(k+3*p*f)
    if not (a>0 and a*c>b*b):
        return False
    t11 = 1+r2*e
    t12r = -1+r*f
    b2 = (3*p*r*a-t11*g1-t12r*g)/2
    c2 = 1-r*t12r*(3*p*g+r*g1)
    return a*c2>b2*b2


def main():
    # Exact dyadic endpoints and a rigorous uniform truncation margin.
    rho = arb(3)/2
    major = (arb(27)).exp()
    # For k>ORDER, |q_k| <= major/(1.5 max(1,rmax))**k.
    tail = major*rho**(-ORDER-1)*(ORDER+4)*3
    assert tail < arb('1e-10')
    assert 12 + 3*arb('0.825')/(1-arb('0.825')) < 27
    # The two even Bessel derivative tails at r <= 8 decay geometrically.
    gtail = abs(2*37*arb(8)**74/(4**37*factorial(37)*factorial(38)))
    assert 2*gtail < arb('1e-10')
    # A decreasing normalized energy bounds the elementary Bessel solution above 5.
    g5 = 1+25*(horner(gc[1:],arb(25))+PAD)
    d5 = 5*(horner(gdc,arb(25))+PAD)
    q5 = 1-arb(3)/100
    assert 125*((d5+3*g5/10)**2+q5*g5**2)/q5 < arb(8)/3
    growth = (arb(2)**3 * (1+arb(3)/20+arb(3)/200) / (1-arb(3)/10)).sqrt()
    radiation = (arb(8)/(3*125*(1-arb(3)/10))).sqrt()
    assert radiation*growth*(1+arb(3)/10) < 1-arb(3)/20
    stack = [(0.,19/64,0.,5.)]
    accepted = 0
    skipped = 0
    while stack:
        pl, ph, rl, rh = stack.pop()
        if pl*rl > 0.5:
            skipped += 1
            continue
        if ph*max(1.,rh) <= 35/64 and check(pl,ph,rl,rh):
            accepted += 1
            continue
        if min(ph-pl,rh-rl)<2**-36:
            raise ValueError((pl,ph,rl,rh))
        if (ph-pl)*20 > (rh-rl):
            m = (pl+ph)/2
            stack.extend([(pl,m,rl,rh),(m,ph,rl,rh)])
        else:
            m = (rl+rh)/2
            stack.extend([(pl,ph,rl,m),(pl,ph,m,rh)])
    print(f'Both normalized symmetric matrices are positive definite throughout. '
          f'{accepted} accepted boxes, {skipped} boxes outside pr <= 1/2.')


if __name__ == '__main__':
    main()
