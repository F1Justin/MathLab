"""Compare the absolute saddle index with exact counts at certified contour cuts."""
from collections import deque
import json
from math import comb

from flint import acb, arb, ctx, fmpz_poly
import saddle_certificate as cert


def saddle_cut(radius):
    assert cert.certify(radius, radius)
    angle = cert.approximate_q(radius)
    left, right = angle-1e-10, angle+1e-10
    lo, hi = cert.endpoint_cores[radius]
    assert lo < left < right < hi
    def saddle(q):
        u = q*arb.pi()
        z = radius*acb(u.cos(), u.sin())
        A = z+z*z/2+z**3/6
        B = z.exp()-1-A
        H = z*(z.exp()-1-z-z*z/2)
        K = H+z*z*(z.exp()-1-z)
        return u,A,B,H,K
    assert saddle(arb(left))[3].imag>0 and saddle(arb(right))[3].imag<0
    u,A,B,H,K = saddle(arb(left).union(arb(right)))
    tau = -1/H.real
    assert tau>0 and K.real<0
    psi = -tau*B.imag-u
    phi = A.imag-(-K).arg()/2
    return tau, psi, phi


def measure():
    cuts={r:saddle_cut(r) for r in (1,2,3,4)}
    jobs={64,65,66,67,256,257,258,259,996,997,998,999}
    rows=deque([fmpz_poly([1])],maxlen=4)
    x=fmpz_poly([0,1])
    results=[]
    for i in range(max(jobs)):
        p=rows[-1]
        q=p+x*p.derivative()
        if i>=1: q+=i*rows[-2]
        if i>=2: q+=comb(i,2)*rows[-3]
        if i>=3: q+=comb(i,3)*x*rows[-4]
        rows.append(q)
        n=i+1
        if n not in jobs:
            continue
        roots=q.complex_roots()
        assert all(mult==1 and z.imag.is_zero() and z.real<0 for z,mult in roots)
        assert len(roots)==n//4
        for radius,(tau,psi,phi) in cuts.items():
            threshold=-n*tau
            assert all(z.real<threshold or z.real>threshold for z,mult in roots)
            count=sum(z.real<threshold for z,mult in roots)
            phase=n//4+(n*psi+phi)/arb.pi()
            pred=(phase+arb(1)/2).floor().unique_fmpz()
            assert pred is not None
            results.append(dict(n=n,radius=radius,expected=int(pred),isolated=count,
                                phase_in_pi=float(phase)))
    return results

if __name__=='__main__':
    ctx.prec=128
    print(json.dumps(measure(),indent=2))
