"""Certify all consecutive pairs through a specified endpoint with FLINT root balls."""
import argparse
from collections import deque
import json
from math import comb
from pathlib import Path
from flint import fmpz_poly,ctx
import flint

def check(nmax, start=4):
    if not 4 <= start <= nmax:
        raise ValueError("Require 4 <= start <= nmax.")
    x=fmpz_poly([0,1])
    rows=deque([fmpz_poly([1])],maxlen=4)
    previous=[]
    compared=0
    for n in range(nmax):
        p=rows[-1]
        q=p+x*p.derivative()
        if n>=1:
            q+=n*rows[-2]
        if n>=2:
            q+=comb(n,2)*rows[-3]
        if n>=3:
            q+=comb(n,3)*x*rows[-4]
        assert q.degree()==(n+1)//4
        rows.append(q)
        if n+1<start:
            continue
        objects=q.complex_roots()
        assert all(mult==1 and z.imag.is_zero() and z.real<0 for z,mult in objects)
        roots=sorted(z.real for z,mult in objects)
        assert len(roots)==q.degree()
        if not previous:
            previous=roots
            continue
        if len(roots)==len(previous):
            assert all(a<b for a,b in zip(previous,roots))
            assert all(b<a for a,b in zip(previous[1:],roots))
        else:
            assert len(roots)==len(previous)+1
            assert all(b<a<c for a,b,c in zip(previous,roots,roots[1:]))
        compared+=1
        previous=roots
    return dict(start=start,nmax=nmax,nonconstant_rows=nmax-start+1,pairs_with_both_nonconstant=compared,
                method="FLINT complex root isolation; exact-zero imaginary part, multiplicity one, disjoint ordered real intervals",
                precision_bits=ctx.prec,python_flint=flint.__version__)

if __name__=="__main__":
    ap=argparse.ArgumentParser()
    ap.add_argument('nmax',nargs='?',type=int,default=1000)
    ap.add_argument("--start",type=int,default=4)
    args=ap.parse_args()
    ctx.prec=96
    print(json.dumps(check(args.nmax,args.start),indent=2))
