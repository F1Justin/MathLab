"""Certify each polynomial by disjoint opposite-sign brackets, using Arb roundoff bounds.

Root predictions are dispensable. Only sign changes, the exact degree, and the strict
endpoint ordering establish the claims. Newton updates use ordinary binary64 centers.
"""
import argparse
from collections import deque
import json
from math import comb, isfinite
from pathlib import Path
from time import monotonic
from flint import arb, arb_poly, ctx, fmpz_poly
import flint


def isolate_seed(q):
    with ctx.workprec(96):
        roots=q.complex_roots()
        assert len(roots)==q.degree()
        assert all(m==1 and z.imag.is_zero() and z.real<0 for z,m in roots)
        values=sorted(float(z.real) for z,m in roots)
        bounds=[(v-abs(v)*1e-12,v+abs(v)*1e-12) for v in values]
        for root,(left,right) in zip(sorted(z.real for z,m in roots),bounds):
            assert arb(left)<root<arb(right)
        return values,bounds


def predict(left, right, degree):
    values=[]
    for i in range(degree):
        j=i if i<degree//2 else i-degree
        values.append(right[j]*(right[j]/left[j]))
    return values


def certify(q, guesses):
    degree=q.degree()
    for bits in (max(160,degree+96),2*degree+192,4*degree+300):
        with ctx.workprec(bits):
            poly=arb_poly(q)
            deriv=poly.derivative()
            values=[]
            brackets=[]
            for guess in guesses:
                v=guess
                good=False
                for _ in range(8):
                    a=arb(v)
                    slope=deriv(a)
                    if slope.contains(0):
                        break
                    step=float(poly(a)/slope)
                    if not isfinite(step) or abs(step)>abs(v)/3:
                        break
                    v-=step
                    if abs(step)<abs(v)*1e-11:
                        good=True
                        break
                if not good:
                    break
                left,right=v-abs(v)*1e-11,v+abs(v)*1e-11
                fleft,fright=poly(arb(left)),poly(arb(right))
                if not ((fleft<0 and fright>0) or (fleft>0 and fright<0)):
                    break
                if not (left<right<0 and (not brackets or brackets[-1][1]<left)):
                    break
                values.append(v)
                brackets.append((left,right))
            if len(brackets)==degree:
                return values,brackets,False
    values,brackets=isolate_seed(q)
    return values,brackets,True


def check(first,last,progress=None,max_lag=1):
    assert last>=first>=4 and 1<=max_lag<=4
    x=fmpz_poly([0,1])
    rows=deque([fmpz_poly([1])],maxlen=4)
    centers=deque(maxlen=8)
    history=deque(maxlen=max_lag)
    counts={lag:0 for lag in range(1,max_lag+1)}
    fallbacks=0
    tic=monotonic()
    for n in range(last):
        p=rows[-1]
        q=p+x*p.derivative()
        if n>=1:q+=n*rows[-2]
        if n>=2:q+=comb(n,2)*rows[-3]
        if n>=3:q+=comb(n,3)*x*rows[-4]
        rows.append(q)
        size=n+1
        if size<max(4,first-8):
            continue
        assert q.degree()==size//4
        if size<first or len(centers)<8 or q.degree()<12:
            values,bounds=isolate_seed(q)
        else:
            guesses=predict(centers[0],centers[4],q.degree())
            values,bounds,fallback=certify(q,guesses)
            fallbacks+=fallback
        if size>=first:
            for lag,prev in enumerate(reversed(history),1):
                if len(prev)==len(bounds):
                    assert all(a[1]<b[0] for a,b in zip(prev,bounds)),(size,lag)
                    assert all(b[1]<a[0] for a,b in zip(prev[1:],bounds)),(size,lag)
                else:
                    assert len(bounds)==len(prev)+1
                    assert all(b[1]<a[0] and a[1]<c[0] for a,b,c in zip(prev,bounds,bounds[1:])),(size,lag)
                counts[lag]+=1
            if progress and (size%50==0 or size==last):
                Path(progress).write_text(json.dumps(dict(through=size,elapsed=round(monotonic()-tic,2))))
        centers.append(values)
        history.append(bounds)
    return dict(first_polynomial=max(4,first-max_lag),last_polynomial=last,first_new_row=first,
                strict_pairs_by_lag=counts, fallback_rows=fallbacks,
                method='integer recurrence, disjoint certified sign brackets or FLINT root isolation',
                python_flint=flint.__version__,elapsed_seconds=round(monotonic()-tic,2))

if __name__=='__main__':
    ap=argparse.ArgumentParser()
    ap.add_argument('first',type=int)
    ap.add_argument('last',type=int)
    ap.add_argument('--progress')
    ap.add_argument('--max-lag',type=int,default=1)
    args=ap.parse_args()
    print(json.dumps(check(args.first,args.last,args.progress,args.max_lag),indent=2))
