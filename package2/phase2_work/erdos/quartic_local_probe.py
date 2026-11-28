"""Finite residue consequences of equal fourth powers; uses exact integer polynomial J."""
import sympy as s
from collections import defaultdict
from itertools import product
from pathlib import Path
import json
x,y,z,t=s.symbols('x y z t');a=(x+y-z-t)/2;u=z+t;q=x-y;v=z-t;k=(3*v*v-4*a*u-3*q*q)/4
J=s.Poly(s.expand(192*a*a*q*q+63*a**4+200*a**3*u+74*a*a*k-72*a*k*u-9*k*k),x,y,z,t)
terms=[(powers,int(coef)) for powers,coef in J.terms()]
results=[]
for mod in [3,5,7,8,9,11,13,16,17,32]:
    fourth=[i**4%mod for i in range(mod)]
    pairs=defaultdict(list)
    for i in range(mod):
        for j in range(mod):pairs[(fourth[i]+fourth[j])%mod].append((i,j))
    powers=[[i**e%mod for e in range(5)] for i in range(mod)]
    seen=set();count=0
    for bucket in pairs.values():
        for xx,yy in bucket:
            for zz,tt in bucket:
                count+=1
                val=0
                for exps,coef in terms:
                    term=coef
                    for coord,e in zip((xx,yy,zz,tt),exps):term*=powers[coord][e]
                    val+=term
                seen.add(val%mod)
    results.append(dict(modulus=mod,solution_residue_quadruples=count,J_residues=sorted(seen)))
print(json.dumps(results,indent=2))
Path(__file__).with_suffix('.json').write_text(json.dumps(results,indent=2))
