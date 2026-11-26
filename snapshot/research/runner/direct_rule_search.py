"""Exact 58-runner finite-menu SAT search with the unmodified even runners included."""
import argparse
from collections import defaultdict
from fractions import Fraction as Q
import json
from math import lcm
from pathlib import Path
from threading import Timer
from time import monotonic
from pysat.card import CardEnc, EncType
from pysat.solvers import Solver
from frozen_extension import ROOT, gaps

def smooth(v, primes):
    for p in primes:
        while v%p==0:
            v//=p
    return v==1

def search(K,primes,phase_denom,shifts,odd_cap,seconds,template=False):
    radius=Q(64,64*K+1)
    base=[2*i for i in range(1,K+1)]
    fixed=[v for v in base if not smooth(v,primes)]
    free=sorted(set(base)-set(fixed) | {v for v in range(1,odd_cap+1,2) if smooth(v,primes)})
    events=defaultdict(int)
    options={}
    groups=[]
    edge=1
    for v in fixed+free:
        if v in fixed:
            phases=[Q(0)]
        elif template and v%2==0:
            phases=sorted({Q(0),Q(1,2)+radius/2,Q(1,2)-radius/2,radius,1-radius})
        else:
            phases=sorted({(Q(a,phase_denom)+b*radius)%1 for a in range(phase_denom) for b in shifts})
        ids=[]
        for phase in phases:
            if v in fixed:
                marker=1<<edge
            else:
                marker=1<<edge
                options[edge]=(v,phase)
                ids.append(edge)
            for k in range(v+2):
                left=max(Q(0),(k-phase-radius)/v)
                right=min(Q(1),(k-phase+radius)/v)
                if left<right:
                    events[left]^=marker
                    events[right]^=marker
            edge+=1
        if ids:
            groups.append(ids)
    opt_mask=sum(1<<v for v in options)
    events[Q(0)]^=0
    events[Q(1)]^=0
    cells=set()
    active=0
    for t in sorted(events):
        active^=events[t]
        if t<1 and not active & ~opt_mask:
            cells.add(active)
    assert active==0
    # Every open cell must be covered. Closed finite arcs then cover the endpoints.
    def clause(bits):
        out=[]
        while bits:
            b=bits&-bits
            out.append(b.bit_length()-1)
            bits^=b
        return out
    # Only earlier, smaller clauses containing a shared bit could be redundant.
    kept=[]
    first=defaultdict(list)
    for bits in sorted(cells,key=int.bit_count):
        ids=clause(bits)
        if any(old&bits==old for i in ids for old in first[i]):
            continue
        kept.append(ids)
        if ids: first[ids[0]].append(bits)
        else: break
    top=edge
    clauses=kept.copy()
    used=[]
    for ids in groups:
        top+=1
        label=top
        used.append(label)
        clauses.extend([-i,label] for i in ids)
        enc=CardEnc.atmost(ids,1,top_id=top,encoding=EncType.seqcounter)
        clauses.extend(enc.clauses)
        top=max(top,enc.nv)
    enc=CardEnc.atmost(used,K-1-len(fixed),top_id=top,encoding=EncType.totalizer)
    clauses.extend(enc.clauses)
    if K==96 and primes==(2,3) and template:
        # Poliakova's Theorem 7 gives a known positive assignment for these cells.
        known={v:Q(0) for v in base if v not in (8,32,192)}
        known.update({v:Q(1,2)+radius/2 for v in (12,24,48,96)})
        known.update({v:1-radius for v in (16,64)})
        known.update({v:Q(1,4) for v in (3,9)})
        chosen={i for i,(v,s) in options.items() if known.get(v)==s}
        assert len(chosen)+len(fixed)==95
        assert all(chosen.intersection(row) for row in kept)
        return dict(K=96,state='known_cover_verified',rows=len(kept),movers=95)
    with Solver(name='glucose42',bootstrap_with=clauses) as solver:
        solver.set_phases([i if (v%2==0 and s==0) else -i for i,(v,s) in options.items()])
        timer=Timer(seconds,solver.interrupt)
        timer.start()
        tic=monotonic()
        try:
            result=solver.solve_limited(expect_interrupt=True)
            model=solver.get_model() if result else []
        finally:
            timer.cancel()
        elapsed=monotonic()-tic
    if result:
        movers=[(v,Q(0)) for v in fixed]+[options[i] for i in model if i in options]
        while len(movers)<K-1:
            velocities={v for v,_ in movers}
            movers.append((next(i for i in range(1,2*K) if i not in velocities),Q(0)))
        den=lcm(*(s.denominator for v,s in movers))
        data=dict(n=K-1,speeds=[v for v,s in movers],shift_den=den,
                  shift_num=[int(s*den) for v,s in movers],gamma=str(radius))
        assert not gaps(data,radius)
        path=ROOT/'research/runner'/f'direct_rule_{K-1}.json'
        path.write_text(json.dumps(data,indent=2))
    return dict(K=K,primes=primes,phase_denom=phase_denom,shifts=list(map(str,shifts)),
                odd_speed_cap=odd_cap,template=template,fixed=len(fixed),
                options=len(options),distinct_cells=len(cells),row_clauses=len(kept),
                seconds=round(elapsed,2),state='sat' if result else 'timeout' if result is None else 'unsat')

if __name__=='__main__':
    ap=argparse.ArgumentParser()
    ap.add_argument('--seconds',type=float,default=20)
    ap.add_argument('--K',type=int,default=59)
    args=ap.parse_args()
    for pp,den,sh,cap,template in [
        ((2,3),4,[Q(0),Q(1,2),Q(-1)],81,True),
        ((2,3,5),4,[Q(0)],135,False),
        ((2,3,5),4,[Q(0),Q(1,4),Q(-1,4)],135,True),
        ((2,3,5,7),4,[Q(0)],189,False),
        ((2,3,5,7),4,[Q(0),Q(1,4),Q(-1,4)],189,True)]:
        print(json.dumps(search(args.K,pp,den,sh,cap,args.seconds,template)),flush=True)
