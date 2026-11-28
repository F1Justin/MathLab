"""Independent exact identity/constant checks for quartic_constant_draft.md.
Does not verify the asymptotic compactness argument or the cited GGK positivity lemma.
"""
from pathlib import Path
from math import gcd
import json
import sympy as s

a,u,k,q,r=s.symbols('a u k q r')
D=8*a*u+9*a*a-k
R=(9*k-25*a*a)*u*u+4*a*u*(k-9*a*a)+2*k*k-18*a**4
F=9*(k-a*a)*(k*k-2*k*a*a+65*a**4)
J=192*a*a*q*q+63*a**4+200*a**3*u+74*a*a*k-72*a*k*u-9*k*k
assert s.expand(F-D*J-64*a*a*(R-3*q*q*D))==0
assert s.rem(s.expand(F-64*a*a*R),D,u)==0
assert all(int(c)%3==0 for c in s.Poly(s.expand(J-2*a*a*(a*u+k)),a,u,k,q).coeffs())
assert all(int(c)%8==0 for c in s.Poly(s.expand(J+(k-a*a)**2),a,u,k,q).coeffs())
assert all(j%3 or j%8 not in [0,4,7] for j in range(1,12))
rewrite=(9*u*u+4*a*u+3*q*q)*k+2*k*k-(25*a*a*u*u+36*a**3*u+18*a**4+24*a*u*q*q+27*a*a*q*q)
assert s.expand(rewrite-(R-3*q*q*D))==0
obj=(16+9*r)**5/(r*(r*r+64))
expected=2*(9*r+16)**4*(9*r**3-24*r**2+1152*r-512)/(r*r*(r*r+64)**2)
assert s.factor(s.diff(obj,r)-expected)==0
V5=((16+9*r)/24)**5*s.Rational(8,9)/(r*(r*r+64))
assert s.factor(V5.subs(r,s.Rational(16,9)))==s.Rational(8,255)
assert s.Rational(8,255)*64*12==s.Rational(2048,85)
report=json.loads(Path(__file__).with_name('quartic_probe.json').read_text())
for w in report['witnesses']:
    x,y,z,t=map(w.get,['x','y','z','t'])
    assert x**4+y**4==z**4+t**4
    assert sorted((x,y))!=sorted((z,t)) and min(x,y,z,t)>0
    assert w['N']==min(x,y,z,t) and w['H']==max(x,y,z,t)-min(x,y,z,t)
print(json.dumps({'identities_exact':True,'V5_minimum':'32/85','congruence_minimum_quotient':12,'H10_over_N6_lower_limit':'2048/85','constant':str(s.N(s.Rational(2048,85)**s.Rational(1,10),25)),'witnesses_checked':len(report['witnesses'])},indent=2))
