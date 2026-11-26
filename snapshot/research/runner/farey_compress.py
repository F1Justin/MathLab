"""Exact folded-Farey test and row-generation SAT for compressing a divisibility block.

Astra proposed the folded-mask construction in runner_construct_001. Candidate
phases use a finite lattice. A positive result is always checked on continuous time.
"""
import argparse
from collections import defaultdict
from fractions import Fraction as Q
import json
from math import gcd,ceil,floor
from pathlib import Path
from time import monotonic
from threading import Timer

from pysat.card import CardEnc,EncType
from pysat.solvers import Solver
from frozen_extension import ROOT,gaps


def parts(a,b):
    if b-a>=1:
        return [(Q(0),Q(1))]
    x=a%1
    y=x+b-a
    return [(x,y)] if y<=1 else [(0,y-1),(x,1)]


def union(intervals):
    out=[]
    for a,b in sorted(intervals):
        if out and a<=out[-1][1]:
            out[-1]=(out[-1][0],max(b,out[-1][1]))
        else:
            out.append((a,b))
    return out


def mask(M,d,eps,uniform):
    delta=1/(M+eps)
    widths={}
    for j in range(1,M//d+1):
        b=d*j
        for a in range(1,b):
            if gcd(a,b)!=1:
                continue
            u=pow(a,-1,b)
            pm,pp=M-(M-u)%b,M-(M+u)%b
            sl,sr=(Q(1,j),Q(1,j)) if uniform else ((M+eps-b)/(j*pm),(M+eps-b)/(j*pp))
            x=Q(a%j,j)
            l,r=widths.get(x,(0,0))
            widths[x]=max(l,sl),max(r,sr)
    targets=union([seg for x,(l,r) in widths.items() for seg in parts(x-delta*l,x+delta*r)])
    return delta,widths,targets


def difference(targets,cover):
    out=[]
    for a,b in targets:
        end=a
        for l,r in cover:
            if l>end:
                if min(l,b)>end:
                    out.append((end,min(l,b)))
            end=max(end,r)
            if end>=b:
                break
        if end<b:
            out.append((end,b))
    return out


def cover_of(runners,delta):
    return union([seg for v,s in runners for k in range(v)
                  for seg in parts((k-s-delta)/v,(k-s+delta)/v)])


def make_columns(v,times,D,delta):
    changes=defaultdict(int)
    for i,x in enumerate(times):
        for a,b in parts(-v*x-delta,-v*x+delta):
            l=max(0,ceil(D*a))
            h=min(D-1,floor(D*b))
            if l<=h:
                changes[l]^=1<<i
                changes[h+1]^=1<<i
        # The circular point 0 is also 1 when the closed arc ends exactly at 1.
        if (-v*x+delta)%1==0 and (-v*x-delta)%1!=0:
            changes[0]^=1<<i
            changes[1]^=1<<i
    points=sorted(set(changes)|{0,D})
    mask=0
    pools={}
    for l,h in zip(points,points[1:]):
        mask^=changes[l]
        if mask and h>l:
            pools[mask]=max(pools.get(mask,(0,0)),(h-l,-l))
    maximal=[]
    for hit in sorted(pools,key=int.bit_count,reverse=True):
        if any(hit & ~other==0 for other in maximal):
            continue
        maximal.append(hit)
        length,start=pools[hit]
        p=-start+(length-1)//2
        assert all(not(hit>>i&1) or abs(v*x+Q(p,D)-round(v*x+Q(p,D)))<=delta for i,x in enumerate(times))
        yield p,hit


def solve_rows(times,delta,J,K,D,vcap,deadline):
    rows=[[] for _ in times]
    columns={}
    groups=[]
    for v in range(1,vcap+1):
        ids=[]
        for p,hit in make_columns(v,times,D,delta):
            var=len(columns)+1
            columns[var]=(v,Q(p,D))
            ids.append(var)
            bits=hit
            while bits:
                low=bits&-bits
                rows[low.bit_length()-1].append(var)
                bits^=low
        if ids:
            groups.append(ids)
    clauses=list(rows)
    top=len(columns)
    used=[]
    for ids in groups:
        top+=1
        label=top
        used.append(label)
        clauses.extend([-v,label] for v in ids)
        enc=CardEnc.atmost(ids,1,top_id=top,encoding=EncType.seqcounter)
        clauses.extend(enc.clauses)
        top=max(top,enc.nv)
    enc=CardEnc.atmost(used,K,top_id=top,encoding=EncType.totalizer)
    clauses.extend(enc.clauses)
    with Solver(name="glucose42",bootstrap_with=clauses) as solver:
        timer=Timer(max(.01,deadline-monotonic()),solver.interrupt)
        timer.start()
        try:
            good=solver.solve_limited(expect_interrupt=True)
            if good:
                return 'sat',[columns[i] for i in solver.get_model() if i in columns],len(columns)
            return ('timeout' if good is None else 'unsat'),[],len(columns)
        finally:
            timer.cancel()


def run(M,d,uniform,secs,eps,cap=4):
    J=M//d
    delta,widths,H=mask(M,d,eps,uniform)
    core=[i for i in range(1,M+1) if i%d]
    if not uniform:
        direct=gaps(dict(speeds=core,shift_num=[0]*len(core),shift_den=1),delta)
        direct=union([pair for a,b in direct for pair in parts(d*a,d*b)])
        assert direct==H
    assert not difference(H,cover_of([(v,0) for v in range(1,J+1)],delta))
    times=set(widths)|{t%1 for a,b in H for t in (a,b)}
    deadline=monotonic()+secs
    for iteration in range(1000):
        state,ls,col=solve_rows(sorted(times),delta,J,J-1,10**6,J*cap,deadline)
        print(M,d,uniform,iteration,len(times),col,state,flush=True)
        if state!='sat':
            return
        assert len(ls)<=J-1
        missed=difference(H,cover_of(ls,delta))
        if not missed:
            v=core+[d*i for i,s in ls]
            sn=[0]*len(core)+[int(s*10**6) for i,s in ls]
            while len(v)<M-1:
                v.append(next(j for j in range(1,2*M) if j not in v))
                sn.append(0)
            data=dict(n=M-1,speeds=v,shift_num=sn,shift_den=10**6,gamma=str(delta))
            assert not gaps(data,delta)
            path=ROOT/'research/runner'/f'farey_candidate_{M-1}_{d}.json'
            path.write_text(json.dumps(data,indent=2))
            print('COVER',path,flush=True)
            return
        print('residual',len(missed),float(sum(b-a for a,b in missed)),flush=True)
        for a,b in missed:
            times.add((a+b)/2)
        if monotonic()>deadline:
            return


if __name__=='__main__':
    ap=argparse.ArgumentParser()
    ap.add_argument('--M',type=int,default=59)
    ap.add_argument('--d',type=int,nargs='+',default=[12,10,8,7,5,4])
    ap.add_argument('--seconds',type=float,default=40)
    ap.add_argument('--epsilon',type=Q,default=Q(1,64))
    ap.add_argument('--uniform',action='store_true')
    args=ap.parse_args()
    for d in args.d:
        run(args.M,d,args.uniform,args.seconds,args.epsilon)
