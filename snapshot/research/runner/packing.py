"""Verify three local rules from Poliakova and pack them at compatible scales.

Only integer sets and fractions enter the proof. Per coprime core, consider
multipliers 3^i*5^j and rule choices with unscaled threshold at most LIMIT.
"""
from fractions import Fraction as Q
from functools import lru_cache
from math import gcd
import json

# Removed speeds and groups (speeds, constant phase, coefficient of delta).
rules = [
    ([8,32,192], [([12,24,48,96],Q(1,2),Q(1,2)),([16,64],0,-1),([3,9],Q(1,4),0)]),
    ([8,32,36,40,72,180,192,240], [([12,24,48,60,96,108,120],Q(1,2),Q(1,2)),([16,64,80],0,-1),([216],0,-2),([3,9,27],Q(1,4),Q(1,4)),([15,45,135],Q(3,4),Q(1,4))]),
    ([4,16,20,36,40,64,72,240,384,432], [([12,24,48,96,192],Q(1,2),Q(1,2)),([60,108,120,216],Q(1,2),Q(-1,2)),([8,128],0,-1),([80,144],0,1),([32],0,Q(-3,2)),([3,45,81],Q(1,4),Q(-1,4)),([5,9],Q(1,4),Q(1,4)),([15,27],Q(1,4),0)])
]
LIMIT=6000


def rule_data(removed,groups):
    replacements={v:(a,b) for speeds,a,b in groups for v in speeds}
    affected=set(removed)|{v for v in replacements if v%2==0}
    obligations=0
    for q in sorted(affected):
        for k in range(q):
            if gcd(k,q//2)!=1:
                continue
            intervals=[]
            for v,(a,b) in replacements.items():
                if (Q(v*k,q)+a).denominator==1:
                    intervals.append((Q(q,v)*(-1-b),Q(q,v)*(1-b)))
            right=-1
            for lo,hi in sorted(intervals):
                if lo>right or right>=1:
                    break
                right=max(right,hi)
            assert right>=1, (q,k)
            obligations+=1
    velocities=affected|set(replacements)
    gain=len(removed)-sum(v%2 for v in replacements)
    return max(affected)//2,gain,velocities,obligations


def packing():
    options=[]
    obligations=[]
    for index,rule in enumerate(rules):
        threshold,gain,velocities,checked=rule_data(*rule)
        obligations.append(checked)
        power3=1
        while threshold*power3<=LIMIT:
            scale=power3
            while threshold*scale<=LIMIT:
                options.append((threshold*scale,gain,{v*scale for v in velocities},index,scale))
                scale*=5
            power3*=3
    options.sort(key=lambda item:(item[0],item[3],item[4]))
    conflicts=[sum(1<<j for j,y in enumerate(options) if x[2]&y[2]) for x in options]

    @lru_cache(None)
    def choose(mask):
        if not mask:
            return 0,()
        i=mask.bit_length()-1
        skip=choose(mask^(1<<i))
        gain,members=choose(mask&~conflicts[i])
        use=gain+options[i][1],members+(i,)
        return max(skip,use,key=lambda t:t[0])

    thresholds=[]
    certificates=[]
    for i,option in enumerate(options):
        best,members=choose((1<<(i+1))-1)
        if best>len(thresholds):
            thresholds.extend([option[0]]*(best-len(thresholds)))
            certificates.append(dict(threshold=option[0],savings=best,
              rules_and_scales=[(options[j][3]+1,options[j][4]) for j in members]))
            used=set()
            for j in members:
                assert not used.intersection(options[j][2])
                used.update(options[j][2])
    assert thresholds == [96,120,216,864,1080,3000,5400,5832]
    data = [rule_data(*rule) for rule in rules]

    def bundle(members):
        support = set()
        gain = 0
        threshold = 0
        for letter, scale in members:
            cost, saving, speeds, _ = data[letter-1]
            scaled = {scale*v for v in speeds}
            assert support.isdisjoint(scaled)
            support.update(scaled)
            gain += saving
            threshold = max(threshold, scale*cost)
        return threshold, gain, support

    ninth = [(3,1),(3,25),(1,45),(2,81)]
    assert bundle(ninth)[:2] == (9720,9)
    thresholds.append(9720)
    certificates.append(dict(threshold=9720,savings=9,rules_and_scales=ninth))
    # These three copies miss every previously constructed bundle multiplied by 5.
    threshold, gain, support = bundle([(1,1),(1,9),(1,81)])
    assert (threshold,gain) == (7776,3)
    assert all(v % 5 for v in support)
    head, cycle = thresholds[:6], thresholds[6:]
    assert 5*cycle[0] >= threshold and cycle[-1] < 5*cycle[0]
    alpha = Q(4,15)*(sum(Q(1,t) for t in head) + Q(5,4)*sum(Q(1,t) for t in cycle))

    residual = [sum(gcd(j,30)==1 for j in range(1,r+1)) for r in range(30)]
    deficit = max(Q(4*(r+1),15)-residual[r] for r in range(30))
    assert deficit == Q(14,15)
    slope = sum(Q(4*168,15*t) for t in thresholds[:3])
    assert slope > 1 and 3*deficit < 3 and 168*7 >= thresholds[4]
    def count(N):
        return sum(8*((N//t)//30)+residual[(N//t)%30] for t in thresholds)
    base_cases = [count(168*h) for h in range(1,7)]
    assert all(value >= h for h,value in enumerate(base_cases,1))
    return dict(obligations=obligations,local_search_limit=LIMIT,
                initial_thresholds=head, repeating_triple=cycle, scale_ratio=5,
                certificates=certificates, saved_fraction=str(alpha),
                liminf_En_over_n=str(alpha/(1-alpha)), inverse_asymptotic=float((1-alpha)/alpha),
                all_n_floor_denominator=167, small_h_counts=base_cases)

if __name__=="__main__":
    print(json.dumps(packing(),indent=2))
