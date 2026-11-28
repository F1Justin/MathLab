"""Exact exploratory quartic-Sidon parameter sieve from GGK (2026), §8.
CPU bounded; all accepted witnesses independently checked in original equation.
Scope a<=32, floor(25a²/9)+1<=k<=4a². Not a global enumeration.
"""
from math import isqrt, gcd
from time import process_time
import json
import sympy as sp
from pathlib import Path

def square(n):
    if n < 0:return None
    s=isqrt(n)
    return s if s*s==n else None

def run():
    start=process_time(); out=[]; pairs=0; divisors=0; possible=0; expired=False
    for a in range(1,33):
        for k in range(25*a*a//9+1,4*a*a+1):
            pairs+=1
            F=9*(k-a*a)*(k*k-2*k*a*a+65*a**4)
            for D in sp.divisors(F):
                divisors+=1
                u_num=int(D)-9*a*a+k
                if u_num <=0 or u_num%(8*a):continue
                u=u_num//(8*a)
                # The paper's interesting branch k<=au, q<=v; no approximation.
                if k>a*u: continue
                R=(9*k-25*a*a)*u*u+4*a*u*(k-9*a*a)+2*k*k-18*a**4
                if R<0 or R%(3*D):continue
                q=square(int(R//(3*D)))
                if q is None:continue
                vnum=4*a*u+3*q*q+4*k
                if vnum%3:continue
                v=square(vnum//3)
                if v is None:continue
                possible+=1
                p=u+2*a
                if (p+q)%2 or (u+v)%2:continue
                x=(p+q)//2;y=(p-q)//2;z=(u+v)//2;t=(u-v)//2
                if min(x,y,z,t)<=0 or sorted((x,y))==sorted((z,t)):continue
                assert x**4+y**4==z**4+t**4
                common=gcd(gcd(x,y),gcd(z,t))
                N=min(x,y,z,t);H=max(x,y,z,t)-N
                out.append(dict(a=a,k=k,u=u,q=q,v=v,x=x,y=y,z=z,t=t,N=N,H=H,gcd=common,H5_over_N3_num=H**5,H5_over_N3_den=N**3))
            if process_time()-start>80:
                expired=True;break
        if expired:break
    report=dict(method='GGK section 8 exact divisor sieve',a_max=32,k_range='floor(25a^2/9)+1 .. 4a^2',complete=not expired,last_a=a,last_k=k,parameter_pairs=pairs,divisors_tested=divisors,preparity_squares=possible,cpu_seconds=process_time()-start,witnesses=out)
    Path(__file__).with_name('quartic_probe.json').write_text(json.dumps(report,indent=2))
    print(json.dumps(report,indent=2))
if __name__=='__main__':run()
