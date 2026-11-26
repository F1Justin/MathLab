"""Verify the archived dyadic witnesses independently of the root finder."""
from collections import deque
from math import comb,isfinite
from pathlib import Path
import gzip,struct
from flint import arb,arb_poly,ctx,fmpz_poly

def signs(poly,bounds):
    # All finite binary64 numbers are exact dyadic rationals.
    d=poly.degree()
    for bits in (max(160,d+96),2*d+192,4*d+300,8*d+600):
        with ctx.workprec(bits):
            f=arb_poly(poly)
            if all((f(arb(a))*(-1)**(d-i)>0 and f(arb(b))*(-1)**(d-i-1)>0)
                   for i,(a,b) in enumerate(bounds)):
                return
    raise ValueError('A claimed endpoint sign was not certified.')

def verify():
    x=fmpz_poly([0,1])
    polys=[fmpz_poly([1])]
    rows=deque(maxlen=4)
    count=0
    pairs=[0]*4
    with gzip.open(Path(__file__).with_name('rows4-2004.bin.gz'),'rb') as f:
        for m in range(1,2005):
            n=m-1
            # Marked-block insertion recurrence, Zhan's Theorem 3.3.
            p=sum((comb(n,i)*polys[-1-i] for i in range(min(2,n)+1)),fmpz_poly([]))
            p+=x*polys[-1].derivative()
            if n>=3:p+=comb(n,3)*x*polys[-4]
            polys=(polys+[p])[-4:]
            if m<4:continue
            d=m//4
            assert d==p.degree()
            bounds=[struct.unpack('<dd',f.read(16)) for _ in range(d)]
            assert all(isfinite(a) and a<b<0 for a,b in bounds)
            assert all(b<c for (_,b),(c,_) in zip(bounds,bounds[1:]))
            signs(p,bounds)
            for lag,old in enumerate(reversed(rows),1):
                left,right=(old,bounds) if len(old)==len(bounds) else (bounds,old)
                assert len(left)-len(right) in (0,1)
                assert all(b<c for (_,b),(c,_) in zip(left,right))
                assert all(b<c for (_,b),(c,_) in zip(right,left[1:]))
                pairs[lag-1]+=1
            rows.append(bounds)
            count+=d
        assert f.read(1)==b''
    print('Rows 4..2004. Dyadic sign intervals:',count,'Directed pairs by lag:',pairs)

if __name__=='__main__':
    if not __debug__: raise SystemExit('Run with assertions enabled.')
    verify()
