"""Exact forward-difference certificate for the first shifted Hankel minor. Run with assertions enabled."""
if not __debug__:
    raise RuntimeError("Enable assertions for the certificate")
from fractions import Fraction
from math import comb, factorial

T = [[1]]
def v(n, i):
    return T[n][i] if n >= 0 and 0 <= i < len(T[n]) else 0

for n in range(204):
    T.append([(1+i)*v(n,i) + n*v(n-1,i) + comb(n,2)*v(n-2,i)
              + comb(n,3)*v(n-3,i-1) for i in range((n+1)//4 + 1)])

def top(n, e):
    h = Fraction(24**e * factorial(e), factorial(n))
    return [h*v(n,e-j) for j in range(5)]

def signs(s, d):
    n = 4*d+s
    p, q = top(n,d), top(n+1,d+1)
    N = []
    for i in range(5):
        N.append(q[i]*p[0]**i - sum(p[j]*p[0]**(j-1)*N[i-j]
                                     for j in range(1,i+1)))
    return -N[2], N[3], N[2]*N[4]-N[3]**2

def certify(values):
    a, u = list(values), []
    while a:
        u.append(a[0])
        a = [y-x for x,y in zip(a,a[1:])]
    while u and u[-1] == 0:
        u.pop()
    assert u and u[-1] > 0
    while min(u) < 0:
        assert u[0] > 0
        u = [x+y for x,y in zip(u,u[1:])] + [u[-1]]
    assert u[0] > 0

for s in range(4):
    L = 8*s+24
    for col in zip(*(signs(s,d) for d in range(2,L+3))):
        certify(col)
print("All four residue classes certified for d >= 2.")
