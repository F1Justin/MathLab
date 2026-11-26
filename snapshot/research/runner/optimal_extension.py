"""Sharp continuous-phase optimum for adding one arbitrary integer speed to the published seed."""
from bisect import bisect_left,bisect_right
from fractions import Fraction as Q
from math import floor, lcm
from pathlib import Path
import json
from frozen_extension import ROOT, gaps

HERE=Path(__file__).resolve().parent


def candidate(base):
    # Floating search only suggested this chamber; the verifier below is independent of it.
    d=Q('0.01720824051')
    v=528344
    approx=Q('0.15049025')
    endpoints={Q(0):(Q(0),Q(0)), Q(1):(Q(1),Q(0))}
    for w,num in zip(base['speeds'],base['shift_num']):
        s=Q(num,base['shift_den'])
        for k in range(w+2):
            center=(k-s)/w
            for slope in (Q(-1,w),Q(1,w)):
                endpoints[center+slope*d]=(center,slope)
    lows,highs=[],[]
    for a,b in gaps(base,d):
        ca,sa=endpoints[a]
        cb,sb=endpoints[b]
        k=round(v*(a+b)/2+approx)
        lows.append((k-v*ca,-v*sa-1))
        highs.append((k-v*cb,1-v*sb))
    assert all(j<0 for _,j in lows) and all(h>0 for _,h in highs)
    radius=max((i-k)/(h-j) for i,j in lows for k,h in highs)
    phase=max(i+j*radius for i,j in lows)
    # A gap can disappear at a seed maximum before the endpoint constraints bind.
    starts=sorted((c+j*d,c,j) for c,j in endpoints.values() if j<0)
    points=[t for t,_,_ in starts]
    possible=[radius]
    for ca,sa in endpoints.values():
        if sa<=0:continue
        right=ca+sa*d
        for _,cb,sb in starts[bisect_left(points,right-2*(d-radius)):bisect_right(points,right)]:
            event=(cb-ca)/(sa-sb)
            if radius<=event<=d:
                possible.append(event)
    for trial in sorted(set(possible)):
        trial_holes=gaps(base,trial)
        bounds=[(round(v*(a+b)/2+approx)-v*a-trial,
                 round(v*(a+b)/2+approx)-v*b+trial) for a,b in trial_holes]
        lower=max(lo for lo,hi in bounds)
        if lower<=min(hi for lo,hi in bounds):
            return v,lower%1,trial
    raise ValueError('No feasible event in the proposed chamber')


def strict_residual(base,d):
    # Complement of the *open* seed arcs, including isolated touching points.
    arcs=[]
    for v,num in zip(base['speeds'],base['shift_num']):
        phase=Q(num,base['shift_den'])
        for k in range(-1,v+2):
            a,b=(k-phase-d)/v,(k-phase+d)/v
            if a<=1 and b>=0:arcs.append((a,b))
    components=[]
    for a,b in sorted(arcs):
        if components and a<components[-1][1]:
            components[-1]=(components[-1][0],max(components[-1][1],b))
        else:components.append((a,b))
    bounds=[(b,a) for (_,b),(a,_) in zip(components,components[1:]) if 0<=b<=a<=1]
    if components[0][0]>=0:bounds.insert(0,(Q(0),components[0][0]))
    if components[-1][1]<=1:bounds.append((components[-1][1],Q(1)))
    return bounds


def all_extensions(base,d,strict=False):
    """All feasible phases at this radius for every integer speed, modulo one."""
    residual=strict_residual(base,d) if strict else gaps(base,d)
    holes=sorted(residual,key=lambda ab:ab[1]-ab[0],reverse=True)
    assert holes and 4*d<Q(1,2)
    length=holes[0][1]-holes[0][0]
    limit=floor(2*d/length)
    unit=lcm(d.denominator,*(x.denominator for ab in holes for x in ab))
    twice=int(2*d*unit)
    anchor=int(holes[0][0]*unit)
    intervals=[(anchor-int(a*unit),int((b-a)*unit)) for a,b in holes]
    existing=set(base['speeds'])
    hits=[]
    for v in range(1,limit+1):
        if v in existing:continue
        lo=0
        hi=twice-v*intervals[0][1]
        for offset,width in intervals[1:]:
            start=v*offset%unit
            if 2*start>unit:start-=unit
            lo=max(lo,start)
            hi=min(hi,start+twice-v*width)
            if lo>hi:break
        if lo<=hi:
            origin=-v*holes[0][0]-d
            hits.append((v,(origin+Q(lo,unit))%1,Q(hi-lo,unit)))
    return limit,len(holes),length,hits


def verify():
    base=json.loads((ROOT/'package1/results/known_slr_57.json').read_text())
    speed,phase,radius=candidate(base)
    assert radius<Q(base['gamma'])
    limit,pieces,length,hits=all_extensions(base,radius)
    assert len(hits)==1 and hits[0][0]==speed
    _,strict_pieces,_,strict_hits=all_extensions(base,radius,strict=True)
    assert all(width==0 for _,_,width in strict_hits)
    # Independently test direct coverage on each entire remaining time interval.
    for a,b in gaps(base,radius):
        k=round(speed*(a+b)/2+phase)
        assert -radius<=speed*a+phase-k<=speed*b+phase-k<=radius
    point=Q(38586773,79000000)
    seed_distances=[abs(z-round(z)) for w,num in zip(base['speeds'],base['shift_num'])
                    for z in [w*point+Q(num,base['shift_den'])]]
    assert min(seed_distances)==radius
    added=speed*point+hits[0][1]
    assert abs(added-round(added))-hits[0][2]>radius
    assert len(base['speeds'])==len(set(base['speeds']))==57 and speed not in base['speeds']
    result=dict(speed=speed,phase=str(phase),radius=str(radius),base_radius=base['gamma'],
                strict_improvement=str(Q(base['gamma'])-radius),target_gap=str(radius-Q(1,59)),
                unchanged_runners=57,uncovered_intervals=pieces,longest_interval=str(length),
                maximum_possible_speed=limit,feasible_speeds=len(hits),feasible_phase_start=str(hits[0][1]),feasible_phase_width=str(hits[0][2]),
                strict_residual_components=strict_pieces,weak_hits_on_strict_residual=len(strict_hits))
    return result


if __name__=='__main__':
    result=verify()
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))
