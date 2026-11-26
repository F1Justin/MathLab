"""Replay selected infeasible endpoints in real arithmetic, with original phase variables."""
from fractions import Fraction as Q
from math import ceil,floor
import json
from pathlib import Path
import sys
from z3 import And,Or,Real,RealVal,SolverFor,unsat


def rat(x):
    return RealVal(str(x))


def verify(data,seconds,delay=False):
    v=data['speeds']
    s=list(map(Q,data['original_phases']))
    eps,d=Q(data['phase_halfwidth']),Q(data['radius'])
    rows=data.get('infeasible_endpoints',[(i,k) for i,w in enumerate(v) for k in range(w)])
    delta=[Real(f's{i}') for i in range(len(v))]
    sol=SolverFor('QF_RDL' if delay else 'QF_LRA')
    sol.set(timeout=1000*seconds)
    for w,u in zip(v,delta):
        bound=eps/w if delay else eps
        sol.add(u>=rat(-bound),u<=rat(bound))
    for i,k in rows:
        w=v[i]
        choices=[]
        for j,h in enumerate(v):
            if j==i:continue
            center=h*(k+d-s[i])+w*s[j]
            freedom=(w+h)*eps
            for m in range(ceil((center-freedom)/w-d),floor((center+freedom)/w+d)+1):
                left=w*(m-d)-center
                right=w*(m+d)-center
                if delay:
                    expr=delta[j]-delta[i]
                    left/=w*h
                    right/=w*h
                else:
                    expr=w*delta[j]-h*delta[i]
                choices.append(And(expr>rat(left),expr<rat(right)))
        sol.add(Or(choices))
    status=sol.check()
    print(data['base'],str(eps),len(rows),status,flush=True)
    return str(status)


if __name__=='__main__':
    verdict=verify(json.loads(Path(sys.argv[1]).read_text()),int(sys.argv[2]),'--delay' in sys.argv[3:])
    sys.exit({'unsat':0,'sat':1,'unknown':2}[verdict])
