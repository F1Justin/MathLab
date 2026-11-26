"""Find or verify an integer-density obstruction on the seed's uncovered intervals."""
import argparse
import json
from fractions import Fraction
from math import ceil, floor
from pathlib import Path
import numpy as np
from residual_mass import ROOT, gaps, peak

folder=Path(__file__).resolve().parent
period=59*10**6
width=2*10**6

def intervals():
    seed=json.loads((ROOT/'package1/results/known_slr_57.json').read_text())
    pieces=[(ceil(a*period),floor(b*period)) for a,b in gaps(seed,Fraction(1,59))]
    return np.array([(a,b) for a,b in pieces if a<b],dtype=np.int64).T

def contribution(lo,hi,speed,shift):
    a=(speed*lo-shift)%period
    whole,rem=np.divmod(speed*(hi-lo),period)
    return (whole*width+np.maximum(0,np.minimum(a+rem,width)-a)
            +np.maximum(0,np.minimum(a+rem,period+width)-period))

def design(lo,hi,training_speeds=10000,rounds=38):
    from scipy.optimize import linprog
    lens=hi-lo
    p=lens/lens.sum()
    constraints=[]
    known=set()
    for step in range(rounds):
        weights=np.rint(1000*p*lens.sum()/lens).astype(np.int64)
        candidates=[]
        upto = min(training_speeds,(1200,3200,training_speeds)[min(step//8,2)])
        for v in range(1,upto+1):
            num,shift=peak(lo,hi,v,period,width,weights)
            ratio=num/(v*(lens@weights))
            if (v,shift) not in known:
                candidates.append((ratio,v,shift))
        if not candidates:
            break
        for _,v,shift in sorted(candidates,reverse=True)[:50]:
            known.add((v,shift))
            constraints.append(contribution(lo,hi,v,shift)/(v*lens))
        A=np.column_stack((np.array(constraints),-np.ones(len(constraints))))
        fit=linprog([0]*len(lo)+[1], A_ub=A,b_ub=np.zeros(len(A)),
                    A_eq=[np.append(np.ones(len(lo)),0)],b_eq=[1],
                    bounds=[(0,5*w/lens.sum()) for w in lens]+[(0,1)],method='highs')
        assert fit.success
        p=fit.x[:-1]
    return np.rint(1000*p*lens.sum()/lens).astype(np.int64)

def verify(lo,hi,weights,k):
    assert len(weights)==len(lo) and np.all(weights>=0) and weights.max()<=10000
    lo,hi,weights=lo[weights>0],hi[weights>0],weights[weights>0]
    total=int((hi-lo)@weights)
    sum_w=int(weights.sum())
    limit=floor(Fraction(sum_w*width*period*k,total*(period-k*width)))
    assert 0<k*width<period and limit*period<2**62
    assert 8*sum_w*period<2**62 and limit*total<2**62
    best=Fraction(0)
    for v in range(1,limit+1):
        num,shift=peak(lo,hi,v,period,width,weights)
        score=Fraction(num,v*total)
        if score>best:
            best=score
            winner=(v,shift)
    assert int(contribution(lo,hi,*winner)@weights)==best*winner[0]*total
    tail=Fraction(width,period)+Fraction(sum_w*width,(limit+1)*total)
    bound=max(best,tail)
    return dict(positive_intervals=len(lo),total_weight=sum_w,total_weighted_length_units=total,
                tested_through_speed=limit,maximizer=winner,finite_speed_max=str(best),
                high_speed_upper_bound=str(tail),global_upper_bound=str(bound),
                minimum_extra_runners=ceil(1/bound))

if __name__=='__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('--design',action='store_true')
    parser.add_argument('--k',type=int,default=10)
    args=parser.parse_args()
    lo,hi=intervals()
    path=folder/'residual_weights.json'
    if args.design:
        weights=design(lo,hi)
        path.write_text(json.dumps(weights.tolist())+'\n')
    else:
        weights=np.asarray(json.loads(path.read_text()),dtype=np.int64)
    print(json.dumps(verify(lo,hi,weights,args.k),indent=2))
