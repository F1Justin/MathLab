"""Optimize shifts exactly within a chosen cyclic chain of covering arcs (LP search).

Floating-point computations propose candidates. Strict results require an independent
rational cover certificate. All fast bounds and logs here are heuristic.
"""
import argparse
from fractions import Fraction
import json
from pathlib import Path

import numpy as np
from scipy.optimize import linprog
from scipy.sparse import coo_matrix

from frozen_extension import ROOT, gaps


class Geometry:
    def __init__(self,speeds):
        self.v=np.asarray(speeds,dtype=int)
        owners=np.repeat(np.arange(len(speeds)),self.v)
        k=np.concatenate([np.arange(v) for v in self.v])
        self.owner=np.tile(owners,3)
        self.ticks=np.concatenate([k-self.v[owners],k,k+self.v[owners]])
        self.width=1/self.v[self.owner]

    def centers(self,s):
        return (self.ticks-s[self.owner])*self.width

    def frontier(self,c,d):
        left=c-d*self.width
        right=c+d*self.width
        order=np.argsort(left,kind='stable')
        ordered_right=right[order]
        maximal=ordered_right>np.maximum.accumulate(np.r_[-np.inf,ordered_right[:-1]])
        idx=order[maximal]
        middle=idx[(c[idx]>=0)&(c[idx]<1)]
        ids=self.owner[middle]
        distances=np.diff(np.r_[c[middle],c[middle[0]]+1])
        return ids,np.roll(ids,-1),distances

    def gamma(self,c,hi=.04):
        def covers(g):
            left,right=c-g*self.width,c+g*self.width
            ix=np.argsort(left,kind='stable')
            prev=np.maximum.accumulate(right[ix])[:-1]
            nxt=left[ix[1:]]
            return not np.any((prev<nxt)&(prev<1)&(nxt>0))
        while not covers(hi):
            hi*=2
        lo=0
        for _ in range(24):
            mid=(hi+lo)/2
            if covers(mid):
                hi=mid
            else:
                lo=mid
        return hi

    def optimize(self,s,rng,rounds=8):
        n=len(self.v)
        c=self.centers(s)
        best=self.gamma(c)
        for step in range(rounds):
            # Every frontier supplies a valid chain; varying radius can change the route.
            d=best*(1 if step%3==0 else rng.uniform(.91,1.09))
            u,v,distance=self.frontier(c,d)
            pairs=u*n+v
            codes,inv=np.unique(pairs,return_inverse=True)
            weights=np.full(len(codes),-np.inf)
            np.maximum.at(weights,inv,distance)
            u,v=codes//n,codes%n
            rowid=np.arange(len(codes))
            A=coo_matrix((np.r_[-np.ones(len(u)),np.ones(len(v)),-(1/self.v[u]+1/self.v[v])],
                          (np.tile(rowid,3),np.r_[u,v,np.full(len(codes),n)])),
                         shape=(len(codes),n+1)).tocsr()
            # Variables are delays of the centers; fixes the first runner's time origin.
            bounds=[(0,0)]+[(-.09/vi,.09/vi) for vi in self.v[1:]]+[(0,None)]
            result=linprog(np.r_[np.zeros(n),1.],A_ub=A,b_ub=-weights,bounds=bounds,method='highs')
            if not result.success:
                continue
            s1=(s-self.v*result.x[:-1])%1
            c1=self.centers(s1)
            g1=self.gamma(c1)
            if g1<=best+2e-9:
                s,c,best=s1,c1,g1
        return s,best


def insertion(base,delta,vmax):
    holes=gaps(base,delta)
    a=np.array([float(lo) for lo,hi in holes])
    b=np.array([float(hi) for lo,hi in holes])
    times=(a+b)/2
    scores=[]
    for v in range(1,vmax+1):
        if v in base['speeds']:
            continue
        phase=np.sort((-v*times)%1)
        twice=np.r_[phase,phase+1]
        ends=np.searchsorted(twice,phase+2*float(delta),side='right')
        count=ends-np.arange(len(phase))
        i=np.argmax(count)
        s=(phase[i]+twice[ends[i]-1])/2%1
        scores.append((int(count[i]),v,float(s)))
    return sorted(scores,reverse=True)


def run(args):
    rng=np.random.default_rng(args.seed)
    base=json.loads((ROOT/'package1/results/known_slr_57.json').read_text())
    vv=np.array(base['speeds'],int)
    ss=np.array(base['shift_num'])/base['shift_den']
    candidates=insertion(base,Fraction(1,59),232)
    best=1.
    for i,(covered,v,shift) in enumerate(candidates[:args.count]):
        geom=Geometry(np.r_[vv,v])
        s,g=geom.optimize(np.r_[ss,shift],rng)
        print(f'{i:3d} added={v:3d} centers={covered:3d} E={1/g-59:+.7f}',flush=True)
        if g<best:
            best=g
            args.output.write_text(json.dumps(dict(speeds=geom.v.tolist(),shifts=s.tolist(),estimated_gamma=g,seed=args.seed),indent=2))


if __name__=='__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('--count',type=int,default=48)
    parser.add_argument('--seed',type=int,default=1007)
    parser.add_argument('--output',type=Path,default=Path(__file__).with_name('chain_best.json'))
    run(parser.parse_args())
