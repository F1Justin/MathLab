"""Exhaust an affine local cover with distinct even speeds <=L and arbitrary odd speeds."""
from fractions import Fraction as Q
from functools import lru_cache
from math import gcd,lcm
import json


def catalogue(limit,budget):
    m=lcm(*range(2,limit+1,2))
    odd=m
    while odd%2==0:
        odd//=2
    divisors={1}
    n=odd
    p=3
    while p*p<=n:
        powers=[1]
        while n%p==0:
            n//=p
            powers.append(powers[-1]*p)
        divisors={d*power for d in divisors for power in powers}
        p+=2
    if n>1:
        divisors |= {d*n for d in divisors}
    speeds=set(range(2,limit+1,2))
    for d in divisors:
        found=0
        k=1
        while found<budget:
            if gcd(k,m//d)==1:
                speeds.add(d*k)
                found+=1
            k+=2
    return sorted(speeds)


def decide(limit):
    budget=limit//2-1
    rows={}
    for q in range(2,limit+1,2):
        for k in range(q):
            if gcd(k,q//2)==1:
                r=Q(k,q)
                rows[r]=max(rows.get(r,0),Q(1,q))
    centers=list(rows)
    right=tuple(rows.values())
    speeds=catalogue(limit,budget)
    classes=[]
    for v in speeds:
        groups={}
        for i,r in enumerate(centers):
            groups.setdefault((v*r)%1,[]).append(i)
        classes.append([tuple(groups[(v*r)%1]) for r in centers])
    widths=[Q(2,v) for v in speeds]
    explored=0

    @lru_cache(maxsize=65536)
    def visit(front, used):
        nonlocal explored
        explored+=1
        active=[i for i,f in enumerate(front) if f<right[i]]
        if not active:
            return ()
        slots=budget-used.bit_count()
        if not slots:
            return None
        i=min(active,key=lambda i:front[i])
        f=front[i]
        avail=[j for j in range(len(speeds)) if not used>>j&1]
        # Rows chosen below cannot share any one remaining runner, even at a single point.
        incompatible=[]
        for t in active:
            if all(all(b not in classes[j][t] for j in avail) for b in incompatible):
                incompatible.append(t)
                if len(incompatible)>slots:
                    return None
        if slots==1:
            last=max(right[t] for t in active)
            for j in avail:
                if f+widths[j]>=last and all(t in classes[j][i] for t in active):
                    v=speeds[j]
                    return ((v,(-v*centers[i])%1,-1-v*f),)
            return None
        for j in avail:
            end=f+widths[j]
            updated=list(front)
            for k in classes[j][i]:
                updated[k]=min(right[k],max(front[k],end))
            result=visit(tuple(updated),used|1<<j)
            if result is not None:
                v=speeds[j]
                return ((v,(-v*centers[i])%1,-1-v*f),)+result
        return None

    solution=visit(tuple(-x for x in right),0)
    return dict(max_even=limit,budget=budget,catalogue_size=len(speeds),primitive_rows=len(rows),
                nodes=explored,solution=None if solution is None else [[v,str(a),str(h)] for v,a,h in solution])


if __name__=='__main__':
    import sys
    for value in sys.argv[1:]:
        print(json.dumps(decide(int(value))),flush=True)
