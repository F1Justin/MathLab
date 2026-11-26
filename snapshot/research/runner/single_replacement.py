"""Remove any two members of a cover and optimally test one unlimited-speed replacement."""
from collections import defaultdict
from fractions import Fraction as Q
from itertools import combinations
from math import floor,lcm
import json
from pathlib import Path
from packing import rules

HERE=Path(__file__).resolve().parent


def low_coverage(seed,d,max_removed=2):
    # Endpoints and open cells are separate obligations since the desired radius is strict.
    start=defaultdict(set)
    stop=defaultdict(set)
    active=set()
    for i,(v,s) in enumerate(seed):
        for k in range(-1,v+2):
            lo,hi=(k-s-d)/v,(k-s+d)/v
            if hi<0 or lo>1:continue
            if lo<0<=hi:active.add(i)
            if 0<=lo<=1:start[lo].add(i)
            if 0<=hi<=1:stop[hi].add(i)
    times=sorted({Q(0),Q(1)}|set(start)|set(stop))
    bins=defaultdict(list)
    for j,t in enumerate(times):
        active.difference_update(stop[t])
        if len(active)<=max_removed:bins[tuple(sorted(active))].append((t,t))
        active.update(start[t])
        if j+1<len(times) and len(active)<=max_removed:
            bins[tuple(sorted(active))].append((t,times[j+1]))
    return bins


def merge(pieces):
    out=[]
    for a,b in sorted(pieces):
        if out and a<=out[-1][1]:
            out[-1]=(out[-1][0],max(out[-1][1],b))
        else:out.append((a,b))
    return sorted(out,key=lambda ab:ab[1]-ab[0],reverse=True)


def new_runner(holes,d,used):
    if not holes:return max(used,default=0)+1,Q(0),0
    width=holes[0][1]-holes[0][0]
    if not width:
        v=lcm(*(a.denominator for a,b in holes))
        while v in used:v*=2
        return v,Q(0),0
    bound=floor(2*d/width)
    # Work in one circle unit for all pieces and velocities.
    den=lcm(d.denominator,*(u.denominator for ab in holes for u in ab))
    a0=int(holes[0][0]*den)
    pieces=[(a0-int(a*den),int((b-a)*den)) for a,b in holes]
    diam=int(2*d*den)
    for v in range(1,bound+1):
        if v in used:continue
        left=0
        right=diam-v*pieces[0][1]
        for da,w in pieces[1:]:
            low=v*da%den
            if low*2>den:low-=den
            left=max(left,low)
            right=min(right,low+diam-v*w)
            if left>=right:break
        if left<right:
            s=(Q(left+right,2*den)-v*holes[0][0]-d)%1
            assert all(max(abs(v*a+s-round(v*(a+b)/2+s)),abs(v*b+s-round(v*(a+b)/2+s)))<d for a,b in holes)
            return v,s,bound
    return None,None,bound


def poliakova():
    d=Q(1,97)
    removed,groups=rules[0]
    out={v:Q(0) for v in range(2,193,2) if v not in removed}
    out.update({v:(a+h*d)%1 for vs,a,h in groups for v in vs})
    return sorted(out.items())


def exhaust(seed):
    n=len(seed)-1
    d=Q(1,n+1)
    bins=low_coverage(seed,d)
    speeds={v for v,s in seed}
    maximum=0
    pairs=0
    hits=[]
    for i,j in combinations(range(len(seed)),2):
        holes=merge(bins[()]+bins[(i,)]+bins[(j,)]+bins[(i,j)])
        vi,vj=seed[i][0],seed[j][0]
        v,s,bound=new_runner(holes,d,speeds-{vi,vj})
        maximum=max(maximum,bound)
        pairs+=1
        if v:
            hits.append(dict(remove=[vi,vj],speed=v,phase=str(s)))
    return dict(target_n=n,target_radius=str(d),seed=[[v,str(s)] for v,s in seed],
                pairs=pairs,largest_speed_bound=maximum,strict_replacements=hits)


if __name__=='__main__':
    out={}
    for name,seed in [('standard59',[(v,Q(0)) for v in range(1,60)]),
                      ('poliakova95',poliakova())]:
        r=exhaust(seed)
        out[name]=r
        print(name,r['pairs'],r['largest_speed_bound'],r['strict_replacements'][:3],flush=True)
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
