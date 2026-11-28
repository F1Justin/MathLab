"""Check the polynomial identities and the bounded a=1 search in the proof note."""
from math import isqrt

import sympy as sp


a, s, d, T, e, r, u = sp.symbols('a s d T e r u', nonzero=True)


def check_equal(left, right):
    if sp.cancel(left - right) != 0:
        raise ArithmeticError(f'Polynomial identity failed: {left} != {right}')


k = a**2 + 2*s
m = (3*s**2 + 1) / (4*a)
fixed_u = s*(m + 12*a**3) - a
midpoint = m**2 + 9*a**2*s**2
half_difference = s*((s**2 + 3)/2 + 8*a**4)
q2 = midpoint - half_difference
v2 = midpoint + half_difference
D = 8*a*fixed_u + 9*a**2 - k
F = 9*(k-a**2)*((k-a**2)**2+64*a**4)
check_equal(F, 12*D)
check_equal(3*(v2-q2), 4*(a*fixed_u+k))
check_equal((fixed_u+2*a)**4 + 6*(fixed_u+2*a)**2*q2 + q2**2,
            fixed_u**4 + 6*fixed_u**2*v2 + v2**2)
check_equal(16*a**2*q2, (3*s**2+1)**2 + 144*a**4*s**2
            - 8*a**2*s*(s**2+3+16*a**4))

# The difference-of-squares formula is valid for arbitrary a.
B = 81*s**2 - 36*a**2*s + 640*a**4 + 27
check_equal(B**2-(108*a)**2*q2,
            64*a**2*((738*a**4+243)*s + 6400*a**6+540*a**2))

ac = (d**2+27)/(4*T)
sc = (d+8*ac**2)/9
P = (85*d*(d**2+27)**4 + 6*T**2*(d**2+27)**2*(31*d**2-252)
     + 48*T**4*d*(d**2-45) + 32*T**6)
check_equal(P, 23328*T**4*q2.subs({s: sc, a: ac}, simultaneous=True))
content = 2**32 * 3**45 * 5**2 * 17**2
G = sp.Poly(sp.cancel(sp.discriminant(P, d)/(content*T**24)), T, domain=sp.ZZ)
printed_coefficients = [256, 140564160, -11743512277536, 275862773645746884,
                        -1776983635276715108556, 1301614741918853844382125,
                        13157103861667103667014520000]
expected = sp.Poly(sum(c*T**(24-4*i) for i, c in enumerate(printed_coefficients)), T)
if G != expected:
    raise ArithmeticError('Printed discriminant polynomial is incorrect')
for coefficient in sp.Poly(P, d).all_coeffs():
    coeff_t = sp.Poly(coefficient, T)
    if coeff_t.degree() > 6 or sum(abs(x) for x in coeff_t.all_coeffs()) > 10**8:
        raise ArithmeticError('Height bound for specialization failed')
if 600 * 9**4 != 3936600:
    raise ArithmeticError('Logarithmic exponent is incorrect')

if G.set_modulus(2) != sp.Poly(T**4, T, modulus=2):
    raise ArithmeticError('Squarefreeness certificate failed')

# Obtain both dimensionless profiles directly from R=3q^2D.
k_gen = (1+r)*a**2
den = 8*a*u + 9*a**2-k_gen
R = (9*k_gen-25*a**2)*u**2 + 4*a*u*(k_gen-9*a**2) + 2*k_gen**2-18*a**4
qb = R/(3*den)
vb = qb + 4*(a*u+k_gen)/3
E = 8+(8-r)*e
profiles = [(qb, 9*r-16 + 4*(r-8)*e + (2*r**2+4*r-16)*e**2),
            (vb, 9*r+16 + 32*(1+r)*e + (-2*r**2+32*r+16)*e**2)]
for quantity, numerator in profiles:
    check_equal((quantity/(a*u)).subs(u, a/e), numerator/(3*E))
phi = 8*(16+9*r)**5/(9*24**5*r*(r**2+64))
r0 = sp.Rational(16, 9)
check_equal(12*phi.subs(r, r0), sp.Rational(32, 85))
check_equal((sp.diff(phi, r)/phi).subs(r, r0), sp.Rational(2151, 2720))


def values_one(s_value):
    m_value = (3*s_value**2+1)//4
    center = m_value**2 + 9*s_value**2
    half = s_value*((s_value**2+3)//2 + 8)
    return center-half, center+half


if values_one(39) != (4*321385, 64*21025):
    raise ArithmeticError('2-adic witness failed')
small = []
for s_value in range(1, 395, 2):
    first, second = values_one(s_value)
    if first >= 0 and isqrt(first)**2 == first:
        small.append((s_value, isqrt(first), second))
if small != [(1, 0, 20)]:
    raise ArithmeticError('Unexpected candidate on the a=1 stratum')
gap = 2*(81*s**2-36*s+667)-1-64*(981*s+6940)
if gap.subs(s,395) != 5103 or sp.diff(gap,s).subs(s,395) <= 0 or sp.diff(gap,s,2) <= 0:
    raise ArithmeticError('Large-s exclusion threshold failed')
print('Fixed-J identities, original quartic, genus-4 discriminant, normalized profiles: verified.')
print('Specialized polynomial height bound and logarithmic exponent: verified.')
print('a=1: local witness at 2 verified; finite search gives only (s,q,v^2)=(1,0,20).')
