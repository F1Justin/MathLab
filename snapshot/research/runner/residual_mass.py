"""Exact single-runner coverage of integer-grid subintervals of a frozen seed's holes."""
import json
from fractions import Fraction
from math import ceil, floor
import numpy as np
from frozen_extension import ROOT, gaps

def peak(lo, hi, speed, period, width, weights=None):
    """Return the maximum mass numerator and a maximizing window start."""
    a=(speed*lo)%period
    whole,rem=np.divmod(speed*(hi-lo),period)
    b=(a+rem)%period
    if weights is None:
        weights=np.ones(len(lo),dtype=np.int64)
    base=int(whole@weights)*width
    first=(np.maximum(0,np.minimum(a+rem,width)-a)
           +np.maximum(0,np.minimum(a+rem,period+width)-period))
    f0=int(first@weights)
    slope=int(weights[(width-a)%period<rem].sum()-weights[(-a)%period<rem].sum())
    nodes=np.concatenate(((a-width)%period,(b-width)%period,a,b))
    steps=np.concatenate((weights,-weights,-weights,weights))
    perm=nodes.argsort()
    x=nodes[perm]
    keep=x>0
    x=x[keep]
    changes=steps[perm][keep]
    lengths=np.diff(np.concatenate(([0],x,[period])))
    slopes=slope+np.concatenate(([0],changes.cumsum()))
    masses=f0+np.cumsum(lengths*slopes)
    assert masses[-1]==f0
    j=int(masses.argmax())
    return base+int(masses[j]), int(x[j]) if j<len(x) else 0

def certificate(k=8):
    base=json.loads((ROOT/'package1/results/known_slr_57.json').read_text())
    radius=Fraction(1,59)
    period=59*10**6
    width=int(2*radius*period)
    intervals=[(ceil(a*period),floor(b*period)) for a,b in gaps(base,radius)]
    intervals=[(a,b) for a,b in intervals if a<b]
    lo,hi=np.array(intervals,dtype=np.int64).T
    total=int((hi-lo).sum())
    limit=floor(Fraction(len(lo)*width*period*k,total*(period-k*width)))
    # Bounds on actual 64-bit integer arrays and products in peak().
    assert limit*period<2**62 and 8*len(lo)*period<2**62
    best=Fraction(0)
    winners=None
    for speed in range(1,limit+1):
        covered,phase=peak(lo,hi,speed,period,width)
        ratio=Fraction(covered,speed*total)
        if ratio>best:
            best=ratio
            winners=[speed,phase]
    tail=Fraction(width,period)+Fraction(len(lo)*width,(limit+1)*total)
    bound=max(best,tail)
    return dict(radius=str(radius),grid_denominator=period,intervals=len(lo),total_grid_units=total,
                speed_limit=limit,small_speed_max=str(best),maximizer_speed_and_window_start=winners,
                large_speed_upper_bound=str(tail),uniform_upper_bound=str(bound),
                additions_required_at_least=ceil(1/bound))

if __name__=='__main__':
    print(json.dumps(certificate(),indent=2))
