"""Exact finite-time projections for continuous shift boxes; complete covers use rational arcs."""
import argparse
from bisect import bisect_right
from fractions import Fraction as Q
from math import ceil, floor, lcm
import json
from pathlib import Path
from threading import Timer
from pysat.solvers import Solver
from frozen_extension import gaps, ROOT

HERE=Path(__file__).resolve().parent
R=Q(1,59)


def allowed(v,t,d,lo,hi):
    # k-d <= vt+s <= k+d on the chosen real lift of the phase box.
    a=v*t
    for k in range(ceil(a+lo-d),floor(a+hi+d)+1):
        yield max(lo,k-a-d),min(hi,k-a+d)


def solve_times(speeds,boxes,times,d,seconds):
    rows=[[] for _ in times]
    clauses=[]
    maps=[]
    last=0
    for v,(lo,hi) in zip(speeds,boxes):
        pieces=[list(allowed(v,t,d,lo,hi)) for t in times]
        # Intersections of closed allowed intervals have a common left endpoint.
        # A feasible phase can slide left to the start of its box or of a covered interval.
        knots=sorted({lo,(lo+hi)/2}|{a for row in pieces for a,_ in row})
        index={a:i for i,a in enumerate(knots)}
        ids=[None]+list(range(last+1,last+len(knots)))
        last+=len(knots)-1
        clauses.extend([[-h,l] for l,h in zip(ids[1:],ids[2:])])
        for i,row in enumerate(pieces):
            for a,b in row:
                last+=1
                rows[i].append(last)
                left=index[a]
                right=bisect_right(knots,b)
                if left:clauses.append([-last,ids[left]])
                if right<len(knots):clauses.append([-last,-ids[right]])
        maps.append((ids,knots))
    with Solver(name='glucose42',bootstrap_with=clauses+rows) as slv:
        timer=Timer(seconds,slv.interrupt)
        timer.start()
        try:
            sat=slv.solve_limited(expect_interrupt=True)
            model=set(i for i in slv.get_model() if i>0) if sat else set()
        finally:timer.cancel()
    if not sat:return sat,None
    shifts=[knots[sum(i in model for i in ids[1:])] for ids,knots in maps]
    assert all(any(abs(v*t+s-round(v*t+s))<=d for v,s in zip(speeds,shifts)) for t in times)
    return True,shifts


def config(v,s):
    den=lcm(*(x.denominator for x in s))
    return dict(n=len(v),speeds=v,shift_num=[int((x%1)*den) for x in s],shift_den=den)


def select_times(holes,limit):
    # Sample interiors. Round to a common time grid when that remains strictly in the gap.
    grid=10**9
    out=set()
    for a,b in sorted(holes,key=lambda ab:ab[1]-ab[0],reverse=True)[:limit]:
        mid=(a+b)/2
        approx=Q(round(mid*grid),grid)
        out.add(approx if a<approx<b else mid)
    return out


def run(base,eps,d,rounds,seconds):
    v=base['speeds']
    shifts=[Q(a,base['shift_den']) for a in base['shift_num']]
    boxes=[(a-eps,a+eps) for a in shifts]
    current=base
    times=set()
    history=[]
    for j in range(rounds):
        holes=gaps(current,d)
        history.append(len(holes))
        if not holes:
            return dict(status='covered',radius=str(d),candidate=current,history=history)
        times.update(select_times(holes,120))
        sat,shifts=solve_times(v,boxes,sorted(times),d,seconds)
        if sat is False:
            return dict(status='infeasible',radius=str(d),sample_times=list(map(str,sorted(times))),history=history)
        if sat is None:
            return dict(status='timeout',radius=str(d),sample_count=len(times),history=history)
        current=config(v,shifts)
    return dict(status='round_limit',radius=str(d),sample_count=len(times),history=history)


if __name__=='__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('--eps',default='1/500')
    parser.add_argument('--radius',default='1/59')
    parser.add_argument('--rounds',type=int,default=15)
    parser.add_argument('--seconds',type=float,default=6)
    parser.add_argument('--base',choices=('chain','standard'),default='chain')
    parser.add_argument('--out',type=Path,required=True)
    args=parser.parse_args()
    if args.base=='chain':
        old=json.loads((HERE/'chain_best.json').read_text())
        base=config(old['speeds'],[Q(round(a*10**7),10**7) for a in old['shifts']])
    else:
        base=config(list(range(1,59)),[Q(0)]*58)
    result=run(base,Q(args.eps),Q(args.radius),args.rounds,args.seconds)
    result.update(base=base,eps=args.eps)
    args.out.write_text(json.dumps(result,indent=2)+'\n')
    print(result['status'],result['history'],len(result.get('sample_times',[])),flush=True)
