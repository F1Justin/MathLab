"""Rigorous interval certificate for the conjugate saddles, 1/16 <= radius <= 32.

Requires python-flint 0.9.0 and SciPy. Floating-point roots only propose angle
brackets. Every mathematical decision is rechecked with outward-rounded Arb balls.
"""
import cmath
import json
import math
from collections import Counter
from flint import arb, acb, ctx
from scipy.optimize import brentq

ctx.prec=96
pi=arb.pi()
counts=Counter()
endpoint_cores={}


def interval(a,b):
    return arb(a).union(arb(b))


# At r<=4 use the series after factoring out z^4/24. The omitted tail
# for each of B,H,K,B-H/4 is bounded by the K-tail starting at j=31.
from fractions import Fraction as Q
series={}
for name in ("B","H","K","D"):
    terms=[]
    for j in range(31):
        k=j+4
        factor={"B":1,"H":k,"K":k*k,"D":1-Q(k,4)}[name]
        x=Q(24,math.factorial(k))*factor
        terms.append(arb(x.numerator)/x.denominator)
    series[name]=terms
first=Q(24*35**2*4**31,math.factorial(35))
assert 2*first < Q(1,10**15)  # next / previous <= 4*36/35^2 < 1/2
err=arb(0,arb('1e-15'))
tail=acb(err,err)


def quantity(r,q,name,small):
    u=pi*q
    unit=acb(u.cos(),u.sin())
    z=r*unit
    if small:
        total=acb(0)
        for coeff in reversed(series[name]):
            total=total*z+coeff
        four=4*u
        return acb(four.cos(),four.sin())*total+tail
    exp_neg=(-r).exp()
    exp_scaled=acb(r*(unit.real-1),r*unit.imag).exp()
    bprime=exp_scaled-exp_neg*(1+z+z*z/2)
    if name=="B":
        return bprime-exp_neg*z**3/6
    if name=="H":
        return z*bprime
    if name=="K":
        return z*bprime+z*z*(exp_scaled-exp_neg*(1+z))
    raise ValueError(name)


def approximate_q(r):
    def imaginary(q):
        z=r*cmath.exp(1j*math.pi*q)
        return (z*(cmath.exp(z)-1-z-z*z/2)).imag
    for i in range(1,1025):
        if imaginary(i/1024)<0:
            return brentq(imaginary,(i-1)/1024,i/1024)
    raise ValueError(r)


def all_angles(lo,hi,predicatedepth,predicate):
    count=0
    stack=[(lo,hi,0)]
    while stack:
        a,b,depth=stack.pop()
        count+=1
        if predicate(interval(a,b)):
            continue
        if depth==predicatedepth:
            return False
        mid=(a+b)/2
        stack.extend(((a,mid,depth+1),(mid,b,depth+1)))
    counts['verified_angle_boxes']+=count
    return True


def certify(a,b):
    r=interval(a,b)
    small=b<=4
    qa,qb=approximate_q(a),approximate_q(b)
    q0=(qa+qb)/2
    width=min(.047,.25/b)
    lo,hi=min(qa,qb)-width,max(qa,qb)+width
    assert 0<lo<q0<hi<1
    h=lambda q:quantity(r,q,"H",small)
    if not (h(arb(lo)).imag>0 and h(arb(hi)).imag<0):
        return False
    if not all_angles(lo,hi,8,lambda q:quantity(r,q,"K",small).real<0):
        return False
    trial=quantity(r,arb(q0),"B",small).real
    predicate=lambda q:quantity(r,q,"B",small).real>trial
    if not all_angles(0,lo,12,predicate) or not all_angles(hi,1,12,predicate):
        return False
    # Tighten the critical-point enclosure by certified endpoint signs.
    left,right=lo,hi
    for _ in range(10):
        q=(left+right)/2
        if h(arb(q)).imag>0:
            left=q
        else:
            right=q
    lower=left
    left,right=lo,hi
    for _ in range(10):
        q=(left+right)/2
        if h(arb(q)).imag<0:
            right=q
        else:
            left=q
    upper=right
    if not upper < .25:
        return False
    root=interval(lower,upper)
    imag=quantity(r,root,"D" if small else "B",small).imag
    if not (h(root).real<0 and imag>0):
        return False
    for endpoint in (a,b):
        endpoint_cores[endpoint]=(lo,hi)
    return True


def phase(r):
    q=approximate_q(r)
    lo,hi=q-1e-9,q+1e-9
    core_left,core_right=endpoint_cores[r]
    assert core_left<lo<hi<core_right
    small=r<=4
    h=lambda q:quantity(arb(r),q,"H",small)
    assert h(arb(lo)).imag>0 and h(arb(hi)).imag<0
    q=interval(lo,hi)
    H=h(q).real
    B=quantity(arb(r),q,"B",small)
    assert H<0
    return B.imag/H-pi*q


if __name__=="__main__":
    stack=[(.0625,.125),(.125,.25),(.25,.5),(.5,1.),(1.,2.),(2.,4.),(4.,8.),(8.,16.),(16.,32.)]
    while stack:
        a,b=stack.pop()
        if certify(a,b):
            counts['certified_radius_slabs']+=1
        else:
            assert b-a>1e-6,(a,b)
            mid=(a+b)/2
            stack.extend(((a,mid),(mid,b)))
    fraction=4*(phase(32)-phase(1))/pi
    assert fraction>arb(4)/5
    print(json.dumps(dict(counts=counts,phase_at_1=str(phase(1)),phase_at_1_16=str(phase(.0625)),phase_at_32=str(phase(32)),
                          asymptotic_fraction_of_degree=str(fraction)),indent=2))
