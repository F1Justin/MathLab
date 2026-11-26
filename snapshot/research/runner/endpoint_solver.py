"""Exact continuous-time, continuous-phase decision at a strict covering radius."""
import argparse
from fractions import Fraction as Q
from math import ceil, floor, lcm
from pathlib import Path
import json
from z3 import And, Bool, BoolVal, Implies, Int, Or, SolverFor, sat, unsat
from frozen_extension import ROOT,gaps

HERE=Path(__file__).resolve().parent


def solve(speeds,phases,eps,d,seconds,extract=False):
    n=len(speeds)
    assert 0<d<Q(1,2) and len(set(speeds))==n
    unit=lcm(*(x.denominator for x in [d,eps,*phases]))*lcm(*speeds)*(n+1)
    # Every allowed delay difference has endpoints on the coarser grid unit/(n+1).
    def integer(x):
        num=x*unit
        assert num.denominator==1
        return num.numerator
    delay=[Int(f'y{i}') for i in range(n)]
    box=[eps/v for v in speeds]
    slv=SolverFor('QF_IDL')
    slv.set(timeout=int(seconds*1000))
    for y,b in zip(delay,box):
        slv.add(y>=integer(-b),y<=integer(b))
    clauses=0
    tracked=[]
    labels={}
    for i,v in enumerate(speeds):
        for k in range(v):
            e=(k-phases[i]+d)/v
            choices=[]
            automatic=False
            for j,w in enumerate(speeds):
                if j==i:continue
                b=box[i]+box[j]
                a=w*e+phases[j]
                for h in range(ceil(a-d-w*b),floor(a+d+w*b)+1):
                    left,right=(h-a-d)/w,(h-a+d)/w
                    if left < -b and b < right:
                        automatic=True
                        break
                    if left>=b or right<=-b:continue
                    pred=[]
                    if left>=-b:pred.append(delay[i]-delay[j]>=integer(left)+1)
                    if right<=b:pred.append(delay[i]-delay[j]<=integer(right)-1)
                    choices.append(And(pred))
                if automatic:break
            if not automatic:
                clauses+=1
                clause=Or(choices) if choices else BoolVal(False)
                if extract:
                    name=Bool(f'row_{i}_{k}')
                    slv.add(Implies(name,clause))
                    tracked.append(name)
                    labels[str(name)]=(i,k)
                else:
                    slv.add(clause)
    verdict=slv.check(*tracked)
    result=dict(status=str(verdict),endpoint_clauses=clauses,total_endpoints=sum(speeds),
                phase_halfwidth=str(eps),radius=str(d))
    if verdict==sat:
        model=slv.model()
        final=[(s-v*Q(model.eval(y,model_completion=True).as_long(),unit))%1
               for s,v,y in zip(phases,speeds,delay)]
        den=lcm(*(s.denominator for s in final))
        candidate=dict(n=n,speeds=speeds,shift_num=[int(s*den) for s in final],shift_den=den)
        assert not gaps(candidate,d)
        # Find a strictly smaller rational radius, independently of strict SMT inequalities.
        shrink=Q(1,1000000)
        while gaps(candidate,d-shrink):
            shrink/=2
            assert shrink>Q(1,unit**3)
        result.update(candidate=candidate,verified_radius=str(d-shrink))
    elif verdict==unsat and extract:
        result['infeasible_endpoints']=[labels[str(lit)] for lit in slv.unsat_core()]
    elif verdict!=unsat:result['reason']=slv.reason_unknown()
    return result


if __name__=='__main__':
    p=argparse.ArgumentParser()
    p.add_argument('--base',choices=['chain','standard'],default='chain')
    p.add_argument('--n',type=int,default=58)
    p.add_argument('--eps',default='1/100')
    p.add_argument('--radius',default='1/59')
    p.add_argument('--core',action='store_true')
    p.add_argument('--seconds',type=int,default=30)
    p.add_argument('--out',type=Path,required=True)
    args=p.parse_args()
    if args.base=='chain':
        data=json.loads((HERE/'chain_best.json').read_text())
        speeds=data['speeds']
        phases=[Q(round(x*10**7),10**7) for x in data['shifts']]
    else:
        speeds=list(range(1,args.n+1))
        phases=[Q(0)]*args.n
    r=solve(speeds,phases,Q(args.eps),Q(args.radius),args.seconds,args.core)
    r.update(base=args.base,speeds=speeds,original_phases=list(map(str,phases)))
    args.out.write_text(json.dumps(r,indent=2)+'\n')
    print(r['status'],r.get('verified_radius'),r['endpoint_clauses'],flush=True)
