"""Measure the full saddle phase at independently isolated exact negative zeros."""
import cmath
import json
from collections import deque
from math import comb, pi
from flint import fmpz_poly, ctx

def actions(z):
    # Stable differentiated Taylor series near the fourfold zero.
    if abs(z)<1:
        term=z**4/24
        B=term
        H=4*term
        K=16*term
        for j in range(5,40):
            term*=z/j
            B+=term
            H+=j*term
            K+=j*j*term
    else:
        bprime=cmath.exp(z)-1-z-z*z/2
        B=bprime-z**3/6
        H=z*bprime
        K=H+z*z*(cmath.exp(z)-1-z)
    A=z+z*z/2+z**3/6
    h=z+z*z+z**3/2
    d=z+2*z*z+1.5*z**3
    return A,h,d,B,H,K

def newton(n,x,z):
    for _ in range(80):
        _,h,d,_,H,K=actions(z)
        step=z*(h-x*H-n)/(d-x*K)
        if abs(step)<1e-13*(1+abs(z)):
            break
        if abs(step)>0.35*abs(z):
            step*=0.35*abs(z)/abs(step)
        z-=step
    A,h,d,B,H,K=actions(z)
    assert z.real>0 and z.imag>0 and (d-x*K).real>0
    assert abs(h-x*H-n)<1e-9*n
    G=(A-x*B-n*cmath.log(z)).imag-0.5*cmath.phase(d-x*K)
    return z,G

def row_report(n, p):
    objects=p.complex_roots()
    assert len(objects)==n//4
    assert all(m==1 and z.imag.is_zero() and z.real<0 for z,m in objects)
    roots=sorted((-float(z.real) for z,m in objects),reverse=True)
    prev=None
    residuals=[]
    for k,x in enumerate(roots,1):
        if prev is None:
            z=(6*n/x)**0.25*cmath.exp(1j*pi/4)
        else:
            # Continuation in log x prevents a jump to another saddle.
            while prev/x>1.3:
                prev/=1.3
                z,_=newton(n,prev,z)
        z,G=newton(n,x,z)
        prev=x
        residuals.append(G/pi-(k-0.5-n//4))
    worst=max(range(len(residuals)),key=lambda i:abs(residuals[i]))
    return dict(n=n,degree=len(roots),worst_rank=worst+1,
                max_abs_phase_error_in_pi=abs(residuals[worst]),
                outer=residuals[0],inner=residuals[-1])

if __name__=='__main__':
    ctx.prec=128
    targets={16,32,64,65,66,67,128,256,512,996,997,998,999,1024,2048}
    rows=deque([fmpz_poly([1])],maxlen=4)
    t=fmpz_poly([0,1])
    out=[]
    for n in range(max(targets)):
        p=rows[-1]
        q=p+t*p.derivative()
        if n>=1:q+=n*rows[-2]
        if n>=2:q+=comb(n,2)*rows[-3]
        if n>=3:q+=comb(n,3)*t*rows[-4]
        rows.append(q)
        if n+1 in targets:
            out.append(row_report(n+1,q))
    print(json.dumps(out,indent=2))
