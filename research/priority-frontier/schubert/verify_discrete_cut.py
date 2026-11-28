"""Arb verification of the finite-rank Jacobi transfer forms for short cuts."""
import argparse
from flint import arb, ctx

ctx.prec = 96
ZERO = arb(0)
ONE = arb(1)


def hull(a, b):
    return a.union(b)


def definite(a, b, c):
    return a > 0 and a*c > b**2


def test(k, pl, ph, tl, th):
    # t=tan(phi/2), p=1/((n-1)sin(phi)); boxes use dyadic endpoints.
    p = hull(arb(pl), arb(ph))
    s = lambda t: 2*t/(1+t*t)
    c = lambda t: (1-t*t)/(1+t*t)
    u = hull(s(arb(tl)),s(arb(th)))
    x = hull(c(arb(th)),c(arb(tl)))
    nu = p*u
    if (k >= 6 and k*u >= 6) or (k >= 20 and k*u >= 5):
        return True
    if (2*k-1)*nu > 1 or 12*p**2 > 1+5*nu:
        return True
    if not (k-1)*nu < 1:
        return False
    q = 1/(1+x)
    theta = 3*p*x
    E, B, H, K, G, J = (ZERO,)*6
    for l in range(k):
        rho = arb(l)/(l+3)
        rate = 3*p/(1-l*nu)
        stretch = 1+u*rate
        E, B, H, K = (
            x*E-q-l+u*H,
            x*B+3*l*p+u*K-l*q*u,
            stretch*(x*H-u*E+l*q*u)-(l+1)*rate,
            stretch*(x*K-l-u*B-q-3*l*p*q*u)+3*l*p*rate+l*p*rate
        )
        G, J = x*G-q-rho*J, 1+u**2*G+rho*x*J
    A = 1+u**2*G
    left = -G-A*E
    off = (-theta*left-A*(B+H))/2
    right = -G-A*(K-theta*B+3*k*p*q*u)
    if not definite(left,off,right):
        return False
    first = 1+u**2*E
    edge = k+u*B
    off2 = (-theta*u*left-J*first-A*edge)/2
    right2 = 1-u*edge*(-theta*A+u*J)
    return definite(left,off2,right2)


def run(k):
    stack = [(0., 0.625, 0., 1.)]
    count = 0
    while stack:
        pl, ph, tl, th = stack.pop()
        if test(k,pl,ph,tl,th):
            count += 1
            continue
        if max(th-tl,ph-pl)<2**-35:
            raise ArithmeticError((k,pl,ph,tl,th))
        # Restrict the p coordinate first near a coordinate axis.
        if (ph-pl) > (th-tl)*(1+k*tl):
            m = (pl+ph)/2
            stack.extend([(pl,m,tl,th), (m,ph,tl,th)])
        else:
            m = (tl+th)/2
            stack.extend([(pl,ph,tl,m), (pl,ph,m,th)])
    return count


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--first', default=2,type=int)
    parser.add_argument('--last', default=19,type=int)
    args = parser.parse_args()
    for k in range(args.first,args.last+1):
        print(k,run(k),flush=True)
