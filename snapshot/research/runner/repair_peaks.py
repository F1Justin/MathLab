"""Repair exact-time bottlenecks by moving a runner from a locally chosen pool.

Proposals are heuristic. An integer pair-event pass and rational circle-cover
validation must accept a final certificate. Start from a saved cyclic-chain seed.
"""
from pathlib import Path
import argparse
import json
import numpy as np
from chain_search import Geometry

HERE=Path(__file__).resolve().parent


def obstacles(geom,s,threshold):
    c=geom.centers(s)
    w=geom.width*threshold
    left,right=c-w,c+w
    order=np.argsort(left)
    rights=right[order]
    records=rights>np.maximum.accumulate(np.r_[-np.inf,rights[:-1]])
    ids=order[records]
    l=left[ids[1:]]
    r=right[ids[:-1]]
    mask=(l>r)&(l>0)&(r<1)
    l=np.minimum(l[mask],1)
    r=np.maximum(r[mask],0)
    start=geom.owner[ids[:-1][mask]]
    stop=geom.owner[ids[1:][mask]]
    return r,l,start,stop


def proposals(geom,s,rng):
    v=geom.v
    limit=geom.gamma(geom.centers(s))
    a,b,i,j=obstacles(geom,s,limit-2e-5)
    ta=(a+b)/2
    depth=(b-a)/(1/v[i]+1/v[j])
    # At a difficult peak ask a third runner to cover it. Prefer a phase shift
    # that simultaneously repairs several distinct near-maximal peaks.
    merit=[]
    sample=rng.choice(len(ta),size=min(30,len(ta)),replace=False,p=depth/depth.sum())
    avail=np.setdiff1d(np.arange(1,233),v)
    for k in rng.choice(np.arange(1,len(v)),size=15,replace=False):
        for speed in [v[k],*rng.choice(avail,size=3,replace=False)]:
            for anchor in sample:
                phase=(-speed*ta[anchor]+rng.uniform(-.65,.65)*limit)%1
                ds=np.abs((speed*ta+phase+.5)%1-.5)
                score=float(np.sum(depth*(ds<limit)))
                # How much old coverage must be abandoned by this move?
                if speed==v[k]:
                    shift=abs((phase-s[k]+.5)%1-.5)
                    score*=1+.03/(.03+shift)
                merit.append((score,k,speed,phase))
    merit.sort(reverse=True)
    return merit


def run(args):
    rng=np.random.default_rng(args.seed)
    init=json.loads((HERE/'chain_best.json').read_text())
    geom=Geometry(init['speeds'])
    s=np.asarray(init['shifts'])
    best=geom.gamma(geom.centers(s))
    pool=[(best,geom,s)]
    seen=set()
    for it in range(args.steps):
        idx=0 if it%3 else rng.integers(len(pool))
        _,base,shifts=pool[idx]
        candidates=proposals(base,shifts,rng)
        # Keep three distinct proposed changes; run local optimization from each.
        picks=[]
        for score,k,v,phase in candidates:
            tag=(k,v,int(phase*200))
            if tag in seen:
                continue
            seen.add(tag)
            if any(k==j for j,_,_ in picks):
                continue
            picks.append((k,v,phase))
            if len(picks)>=3:
                break
        for k,v,phase in picks:
            vv=base.v.copy()
            vv[k]=v
            ss=shifts.copy()
            ss[k]=phase
            cur=Geometry(vv)
            ss,val=cur.optimize(ss,rng,rounds=4)
            pool.append((val,cur,ss))
            if val<best-1e-8:
                best=val
                print('step',it,'best E',1/val-59,flush=True)
                args.out.write_text(json.dumps(dict(speeds=vv.tolist(),shifts=ss.tolist(),estimated_gamma=val,seed=args.seed),indent=2))
                if val<1/59-1e-8:
                    return
        pool.sort(key=lambda r:r[0])
        unique=[]
        for item in pool:
            if not any(abs(item[0]-old[0])<1e-8 for old in unique):
                unique.append(item)
        pool=unique[:6]
    print('final E',1/best-59,flush=True)


if __name__=='__main__':
    ap=argparse.ArgumentParser()
    ap.add_argument('--steps',type=int,default=70)
    ap.add_argument('--seed',type=int,default=2601)
    ap.add_argument('--out',type=Path,default=HERE/'repair_best.json')
    run(ap.parse_args())
