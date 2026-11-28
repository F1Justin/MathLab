"""Arb certificate for the middle real roots of the threshold-four rows.

Requires python-flint 0.9.0. Floating-point numbers propose subdivisions and
a continuous reference angle. Arb verifies every accepted mathematical bound.
"""

import cmath
from collections import Counter
from functools import lru_cache
import math

from flint import acb, arb, ctx

ctx.prec = 80
ONE = arb(1)
PI = arb.pi()
RADII = [0.25, 0.5, *range(1, 14)]
TUBE = ONE*12/1000
SERIES = {
    k: [24*ONE*(l+4)**k/math.factorial(l+4) for l in range(32)] for k in range(4)
}
for k in range(2):
    SERIES[4+k] = [
        24*ONE*(l+4)**k*(-ONE*l/4)/math.factorial(l+4) for l in range(32)
    ]
assert 2*24*4**32*36**3*10**13 < math.factorial(36)
ERR = arb(0, ONE/10**13)
TAIL = acb(ERR, ERR)


def interval(a, b):
    return arb(a).union(arb(b))


def unit(t):
    return acb(t.cos(), t.sin())


def polynomial(z, k):
    return z + (2**k)*z*z/2 + (3**k)*z**3/6


@lru_cache(None)
def reference_vertex(radius, normalized_inverse):
    """A fixed real number defining a vertex of the bilinear predictor."""
    if radius == 0:
        return PI/4
    u = normalized_inverse/2000

    def equation(t):
        z = radius*cmath.exp(1j*t)
        h = polynomial(z, 1)
        H = z*cmath.exp(z)-h
        return ((1-u*h)*H.conjugate()).imag

    for i in range(1, 160):
        right = i*math.pi/160
        if equation(right) > 0:
            left = (i-1)*math.pi/160
            break
    for _ in range(42):
        mid = (left+right)/2
        if equation(mid) > 0:
            right = mid
        else:
            left = mid
    return arb((left+right)/2)


def reference_angle(a, b, r, t):
    dr = (r-a)/(b-a)
    low = reference_vertex(a, 0) + dr*(reference_vertex(b, 0)-reference_vertex(a, 0))
    high = reference_vertex(a, 1) + dr*(reference_vertex(b, 1)-reference_vertex(a, 1))
    return low + t*(high-low)


def coefficients(radius, angle, short_series, base, orders):
    z = radius*unit(angle)
    values = []
    if short_series:
        four = unit(4*angle)
        for k in orders:
            coeff = SERIES[k]
            value = coeff[-1]
            for d in reversed(coeff[:-1]):
                value = d+z*value
            values.append(four*value+TAIL)
    else:
        exp_z = (z-base).exp()
        exp_zero = (-base).exp()
        touchard = [1, z, z*z+z, z**3+3*z*z+z]
        for k in orders:
            if k < 4:
                values.append(touchard[k]*exp_z-exp_zero*(polynomial(z,k)+(k==0)))
            else:
                l = k-4
                values.append((touchard[l]-touchard[l+1]/4)*exp_z -
                              exp_zero*(polynomial(z,l)+(l==0)-polynomial(z,l+1)/4))
    return z, values


# Small-radius helper quantities with the leading zero in R divided out.
# Only called for R <= 1/4.
I = acb(0,1)
REM = [[24*ONE*(k+4)**order*(-ONE*k/4)/math.factorial(k+4) for k in range(1,19)]
       for order in (0,1)]
PAIR = [24*(I**k-1)/math.factorial(k+4) for k in range(1,19)]
H1 = [6*ONE/math.factorial(k+3) for k in range(1,19)]
SMALL_TAIL = acb(arb(0,ONE/10**24),arb(0,ONE/10**24))
assert 24*2*23**2*10**24 < 4**18*math.factorial(23)


def series(coefficients, z):
    value = coefficients[-1]
    for c in reversed(coefficients[:-1]):
        value = c+z*value
    return value


def scaled_polynomial(r, theta, k):
    a = unit(theta)
    z = r*a
    return a*(1+2**k*z/2+3**k*z*z/6)


def scaled_remainder(r, theta, order):
    a = unit(theta)
    return a**5*series(REM[order],r*a)+SMALL_TAIL


def paired_height(r, theta, u, tau):
    a = unit(theta)
    z = r*a
    small_part = a*((1-I)+(1-I**2)*z/2+(1-I**3)*z*z/6)
    return u*small_part+tau*(a**5*series(PAIR,z)+SMALL_TAIL)


def log_quotient(v):
    # log(1+v)/v on |v|<1. Taylor remainder starts with v^10/11.
    mod = abs(v).upper()
    assert mod<1
    err = arb(0,mod**10/(11*(1-mod)))
    return series([(-1)**k*ONE/(k+1) for k in range(10)],v)+acb(err,err)


def anchored_phase(r,u,q,tau,T):
    if not (tau>ONE*21/100 and tau<ONE*29/100):
        return False
    a = unit(q)
    h1r = a*series(H1,r*a)+SMALL_TAIL     # (6H/z^4-1)/R
    hr = scaled_polynomial(r,q,1)          # h/R
    if abs(h1r*r).upper()>=1 or abs(u*r*hr).upper()>=1:
        return False
    correction = (h1r*log_quotient(r*h1r)+u*hr*log_quotient(-u*r*hr)).imag/4
    coefficient = u*scaled_polynomial(r,q,0).imag-T.imag+correction
    for s in (0,1,2,3):
        # X/(nR) = (m/n)^(5/4) /(5 sqrt(2) tau_scaled^(1/4)).
        rate = (((1-s*u)/4)**5/tau).root(4)/(5*arb(2).sqrt())
        if not ONE*97/100 < coefficient/rate < ONE*104/100:
            return False
    return True


def outside_boxes(left, right, predicate):
    stack = [(left, right)]
    while stack:
        x, y = stack.pop()
        if predicate(interval(x,y)):
            continue
        if y-x < 0.0001:
            return False
        mid = (x+y)/2
        stack.extend(((x,mid), (mid,y)))
    return True


def certify(a, b, rlo, rhi, tlo, thi, outer_join=False):
    r = interval(rlo,rhi)
    u = interval(tlo,thi)/2000
    n = 2000/arb(thi)
    small = rhi <= 4
    base = arb((rlo+rhi)/2)
    lam = ONE/4 if small else 1/(4+r)

    def vals(angle, orders):
        return coefficients(r, angle, small, base, orders)

    def equation(angle):
        z, (H,) = vals(angle, [1])
        return ((1-u*polynomial(z,1))*H.conjugate()).imag

    # The extrema of a bilinear real function on a box occur at vertices.
    corners = [reference_angle(a,b,arb(rv),arb(tv))
               for rv in (rlo,rhi) for tv in (tlo,thi)]
    reference = corners[0]
    for v in corners[1:]:
        reference = reference.union(v)
    if not equation(reference-TUBE) < 0 < equation(reference+TUBE):
        return "bracket"
    tube = reference + arb(0,TUBE)
    derivative_tube = reference + arb(0,TUBE+ONE/10**8)
    # Unique root of Im(H/(1-u h))=0 in the continuous predictor tube.
    for i in range(6):
        left = derivative_tube.lower()+(derivative_tube.upper()-derivative_tube.lower())*i/6
        right = derivative_tube.lower()+(derivative_tube.upper()-derivative_tube.lower())*(i+1)/6
        z,(H,C2) = vals(interval(left,right), [1,2])
        h = polynomial(z,1)
        d = 1-u*h
        if not (-(C2*d+H*u*polynomial(z,2))/(d*d)).real > 0:
            return "branch derivative"

    # One-sided binary searches sharpen the enclosure. The initial bracket
    # already holds pointwise, even when interval dependency blocks a bisection.
    l0 = float(tube.lower())-1e-12
    r0 = float(tube.upper())+1e-12
    assert derivative_tube.lower() < l0 and l0 < tube and derivative_tube.upper() > r0 and r0 > tube
    left,right = l0,r0
    for _ in range(12):
        mid = (left+right)/2
        if equation(arb(mid)) < 0:
            left = mid
        else:
            right = mid
    lower = left
    left,right = l0,r0
    for _ in range(12):
        mid = (left+right)/2
        if equation(arb(mid)) > 0:
            right = mid
        else:
            left = mid
    q = interval(lower,right)
    z,(B,H,K,BL) = vals(q,[0,1,2,4])
    tau = ((u*polynomial(z,1)-1)/H).real
    C = u*polynomial(z,2)-tau*K
    if not (tau > 0 and C.real > 0 and (H/C).real < 0):
        return "curvature"
    if outer_join:
        T = tau*scaled_remainder(r,q,0)+lam*u*scaled_polynomial(r,q,1)
    else:
        T = tau*BL+lam*u*polynomial(z,1) if small else tau*(B-lam*H)+lam*u*polynomial(z,1)
    if not T.imag > 0:
        return "phase derivative"
    standard_phase = 1+4*((u*polynomial(z,0)-tau*B).imag-q)/PI
    if outer_join and not anchored_phase(r,u,q,tau,T):
        return "outer numbering"
    if not outer_join and rlo == 0.25 and not standard_phase < ONE*13/1000:
        return "lower count"
    if rhi == 13 and not (standard_phase > ONE*685/1000 and q < ONE*24/100):
        return "upper count"

    eta = min(0.116, 0.54/rhi)
    eta_arb = arb(eta)
    if not (q > eta_arb and q < PI/2):
        return "positive arc"
    curvatures, third_derivatives, insertions = [], [], []
    for i in range(8):
        ds = eta_arb*interval(ONE*(i-4)/4,ONE*(i-3)/4)
        zz,(Hz,Kz,Tz,HL) = vals(q+ds,[1,2,3,5])
        curvatures.append((u*polynomial(zz,2)-tau*Kz).real.lower())
        third_derivatives.append(abs(u*polynomial(zz,3)-tau*Tz).upper())
        dv = tau*HL+lam*u*polynomial(zz,2) if small else tau*(Hz-lam*Kz)+lam*u*polynomial(zz,2)
        if outer_join:
            dv = tau*scaled_remainder(r,q+ds,1)+lam*u*scaled_polynomial(r,q+ds,2)
        insertions.append(abs(dv).upper())
    curvature = min(curvatures)
    if not curvature > 0:
        return "local concavity"
    normalization = (n*abs(C)/(2*PI)).sqrt()
    local_error = normalization * max(third_derivatives)*4/(6*n*curvature**2)
    # Both signed one-row shifts have the same first-derivative and global bounds.
    slope = max((max(insertions)/T.imag.lower()).upper(), (1/q.sin().lower()).upper())
    insertion_error = normalization * 2*slope/(n*curvature)

    h0 = (u*polynomial(z,0)-tau*B).real
    gamma = ONE/200
    # At theta=0 the normalized B derivatives are sums of nonnegative terms;
    # B-H/4 instead has all its nonconstant scaled coefficients nonpositive.
    _,(b0,hz0,bl0) = vals(arb(0),[0,1,4])
    absolute_v = tau*abs(bl0) if small else tau*(abs(b0)+lam*abs(hz0))
    if outer_join:
        absolute_v = tau*abs(scaled_remainder(r,arb(0),0)) + lam*u*scaled_polynomial(r,arb(0),1).real
    else:
        absolute_v += lam*u*polynomial(r,1)
    whole_weight = max(((absolute_v+abs(T.real))/T.imag.lower()).upper(),
                       (2/q.sin().lower()).upper(), ONE)
    core_loss = curvature*eta_arb**2/2
    loss = min(core_loss.lower(),gamma.lower())
    if not n*loss>1:
        return "tail scale"
    gauss_tail = 2*(-n*core_loss).exp()/(n*curvature*eta_arb)
    tail = PI*(-n*loss).exp()
    secondary = arb(0)
    if outer_join:
        for i in range(8):
            ds = eta_arb*interval(ONE*(i-4)/4,ONE*(i-3)/4)
            if not paired_height(r,q+ds,u,tau).real > ONE/25:
                return "secondary saddle"
        # Integrate the translated local Gaussian. Its factor n^(-1/2)
        # cancels the peak normalization, including when n tends to infinity.
        secondary = (-arb(250)/25).exp()*(abs(C)/curvature).sqrt()
    cos_error = local_error+normalization*(gauss_tail+tail)+secondary
    flux_error = local_error+insertion_error+normalization*(gauss_tail+whole_weight*tail)+whole_weight*secondary
    if not (cos_error < ONE/2 and flux_error < 4*ONE/5):
        return "Gaussian error"

    def outward_monotone(offset):
        zz,(Hz,) = vals(q+offset,[1])
        m = (u*polynomial(zz,1)-tau*Hz).imag
        return (offset > 0 and m > 0) or (offset < 0 and m < 0)

    ends = []
    for sign in (-1,1):
        last = eta
        for i in range(1,12):
            nxt = eta*(1+i/5)
            if not outward_monotone(sign*interval(last,nxt)):
                break
            last = nxt
        ends.append(last)

    def below(offset):
        zz,(Bz,) = vals(q+offset,[0])
        return h0-(u*polynomial(zz,0)-tau*Bz).real > gamma

    d1 = -float(q.upper())-1e-12
    d2 = float((PI-q).upper())+1e-12
    assert arb(d1) < -q and arb(d2) > PI-q
    ranges = [(d1,-ends[0]),(ends[1],d2)]
    if outer_join:
        # Round the exterior intervals into the paired core so the cover
        # includes both joins even after conversion to binary endpoints.
        lp = math.nextafter(float((PI/2-eta_arb).upper()),math.inf)
        rp = math.nextafter(float((PI/2+eta_arb).lower()),-math.inf)
        assert arb(lp)>PI/2-eta_arb and arb(rp)<PI/2+eta_arb and lp<rp
        ranges = [(d1,-ends[0]),(ends[1],lp),(rp,d2)]
    if not all(outside_boxes(x,y,below) for x,y in ranges):
        return "remote arcs"
    return None


def main():
    totals = Counter()
    for a,b in zip([0]+RADII,RADII):
        stack = [(a,b,0.,1.)]
        while stack:
            r1,r2,t1,t2 = stack.pop()
            failure = certify(a,b,r1,r2,t1,t2,outer_join=(a==0))
            if failure is None:
                totals["accepted"] += 1
                continue
            totals[failure] += 1
            if r2-r1 < 1e-9 or t2-t1 < 1e-9:
                raise ArithmeticError((failure,r1,r2,t1,t2))
            if r2-r1 < (t2-t1)*(r2**3/2000+0.00001)*1.5:
                m = (t1+t2)/2
                stack.extend(((r1,r2,t1,m),(r1,r2,m,t2)))
            else:
                m = (r1+r2)/2
                stack.extend(((r1,m,t1,t2),(m,r2,t1,t2)))
        print("Covered", a, b, "cumulative accepted boxes", totals["accepted"], flush=True)
    print("Full parameter rectangle verified.", dict(totals))


if __name__ == "__main__":
    main()
