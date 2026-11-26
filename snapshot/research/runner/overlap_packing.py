"""Exact mixed-rule certificates with compatible shared speeds."""
import json
from fractions import Fraction as Q
from math import gcd
from pathlib import Path
from packing import rule_data, rules


def merged_rule(spec):
    removed = set()
    replacements = {}
    for letter,scale,half_shift in spec:
        base, groups = rules[ord(letter)-ord("A")]
        removed.update(scale*v for v in base)
        for speeds,a,b in groups:
            for v in speeds:
                speed=scale*v
                phase=((a+half_shift*(speed%2)*Q(1,2))%1,b)
                assert replacements.get(speed,phase)==phase
                replacements[speed]=phase
    removed.difference_update(replacements)
    groups=[([v],a,b) for v,(a,b) in replacements.items()]
    return rule_data(removed,groups)


def certificate():
    recipes=[
        [('A',1,0)], [('B',1,0)], [('C',1,0)],
        [('B',1,0),('B',5,1)],
        [('A',1,0),('A',9,0),('C',5,0)],
        [('A',1,0),('C',5,0),('C',9,0)],
        [('A',1,0),('A',5,0),('C',25,0),('C',27,0)],
        [('C',1,0),('C',25,0),('A',45,0),('B',81,0)]]
    thresholds=[]
    witnesses=[]
    for spec in recipes:
        cost,gain,support,checks=merged_rule(spec)
        assert all(prime_core(v)==1 for v in support)
        thresholds.extend([cost]*(gain-len(thresholds)))
        witnesses.append(dict(recipe=spec,threshold=cost,gain=gain,primitive_cases=checks))
    assert thresholds==[96,120,216,600,1080,1944,1944,5832,9720]
    threshold,gain,support,_=merged_rule([('A',1,0),('A',9,0),('A',81,0)])
    assert (threshold,gain)==(7776,3) and all(v%5 for v in support)
    head,cycle=thresholds[:6],thresholds[6:]
    assert threshold<=5*cycle[0] and cycle[-1]<=5*cycle[0]
    alpha=Q(4,15)*(sum(Q(1,t) for t in head)+Q(5,4)*sum(Q(1,t) for t in cycle))
    # At 1944 the gain jumps by two; the recursive triple starts with the seventh unit.
    def cores(n):
        return 8*(n//30)+sum(gcd(k,30)==1 for k in range(1,n%30+1))
    deficit=max(Q(4*(n+1),15)-cores(n) for n in range(30))
    slope=sum(Q(4*151,15*t) for t in thresholds[:7])
    assert (slope-1)*75>7*deficit
    for h in range(1,75):
        assert sum(cores(151*h//t) for t in thresholds)>=h
    return dict(recipes=witnesses,head=head,cycle=cycle,scale_ratio=5,saved_fraction=str(alpha),
                liminf_En_over_n=str(alpha/(1-alpha)),all_n_denominator=150,
                finite_floor_verified_through_h=74,large_h_slope=str(slope))


def prime_core(v):
    for p in (2,3,5):
        while v%p==0:
            v//=p
    return v


if __name__=='__main__':
    result=certificate()
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
    print(result['liminf_En_over_n'],result['all_n_denominator'])
