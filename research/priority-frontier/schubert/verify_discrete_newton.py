"""Uniform Jacobi transfer certificate via finite Newton series (python-flint)."""
from flint import arb, ctx
from math import factorial, nextafter, inf
import argparse

ctx.prec = 88
O, Z = arb(1), arb(0)
ORDER = 72
SMALL_PAD = arb(0, '1e-23')


def interval(a,b):
    return arb(a).union(arb(b))


def positive_part(t):
    return t.max(Z)


def clip(t):
    return positive_part(t).min(O)


def span(z):
    return arb(0,z.upper())


def horner(a, z):
    v = a[-1]
    for c in reversed(a[:-1]):
        v = v*z+c
    return v


def regular(h, s):
    # Scaled falling factorial products for k and k-1, including the factorial.
    f, g, expc, moment = O, O, O, O
    a, d, loss = [], [], []
    for j in range(36):
        mnext = moment * (2*j+1)/(2*j+4)
        if j:
            a.append((-1)**j*f*moment)
        d.append((-1)**j*g*(h*moment + positive_part(1-(2*j+1)*h)*mnext/(2*j+1)))
        expc = expc*positive_part(1-j*h)*h/(j+1)
        loss.append(expc)
        f = f*positive_part(1-2*j*h)*positive_part(1-(2*j+1)*h)/((2*j+1)*(2*j+2))
        g = g*positive_part(1-(2*j+1)*h)*positive_part(1-(2*j+2)*h)/((2*j+1)*(2*j+2))
        moment = mnext
    return tuple(horner(v,s**2)+SMALL_PAD for v in (a,d,loss))


def transfer(h,p,s):
    ps = (p*s).min(arb(1)/2)
    d0 = 1-h*ps
    rate = 3*p/d0
    # Each pair is the row entry in the two columns of B_q.
    aa, ab, ba, bb = O,Z,Z,O
    pa,pb = Z,Z
    series = [[],[],[],[]]
    prev_tail = Z
    for q in range(ORDER+1):
        if q>=2:
            row = aa, ab, ba, bb
            for out,v in zip(series,row):
                out.append(v)
            if q>=ORDER-1:
                m = max(abs(i).upper() for i in row)*s.upper()**(q-2)
                prev_tail=prev_tail.max(m)
        if q==ORDER:
            break
        hold = positive_part(1-q*h)/(q+1)
        denom = 1-clip((q+1)*h)*ps
        fact = hold/denom
        if q>=1:
            fact = fact.min(arb(1)/(q+1))
        # For q>=2 the coefficient of aa is in [0,1] at every active step.
        bg = 1-(clip((q-2)*h) if q>=2 else (q-2)*h)*ps
        tail = p*(1-clip((q-1)*h) if q>=1 else 1+h)
        aa,ab,ba,bb,pa,pb = (hold*ba,hold*bb,
             fact*((q+3)*p*ba-bg*aa+tail*pa),
             fact*((q+3)*p*bb-bg*ab+tail*pb),aa,ab)
    pad = span(4*prev_tail)
    e,b,g,f = [horner(c,s)+pad for c in series]
    return e,b,g-3*h*p/d0,f,rate


def test(hl,hh,pl,ph,sl,sh):
    h,p,s=interval(hl,hh),interval(pl,ph),interval(sl,sh)
    if p*s>arb(1)/2 or 12*p**2*(1+(h*s)**2) > 1+3*h*p*s-4*(h*p*s)**2:
        return True
    G,J,lb = regular(h,s)
    A,V = 1+s**2*G,1+s**2*lb
    if sl>=1 and V>0:
        beta = (p*s).min(arb(1)/2)
        theta=3*p/(1-h*beta)
        den=1-beta
        # Normalized long energy at n and n-k.  h_n=3x/(2M_n u).
        hn=3*p/2
        hm=hn/den
        cm=3*(p**2)*(1+(h*s)**2)/(4*den**2)
        front=(1+hn+hn**2)/(den**3)
        dyad=1+theta/2+theta**2/8
        if 1-cm-hm>0:
            root=1-theta/2
            first = (1+3*h/2)*abs(A)*dyad*(front/(1-cm-hm)).sqrt()
            second = (A**2+(s*J)**2).sqrt()*dyad*(front/(1-cm)).sqrt()
            if first<root*V.sqrt() and second<root*V.sqrt():
                return True
    E,B,H,K,theta = transfer(h,p,s)
    a=lb-G-A*E
    b=(-theta*a-A*(B+H))/2
    c=lb-G-A*(K-theta*B)
    if not (a>0 and a*c>b**2):
        return False
    t11,edge=1+s**2*E,1+s*B
    b2=(-theta*s*a-J*t11-A*edge)/2
    c2=V-s*edge*(-theta*A+s*J)
    return a*c2>b2**2


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--kmin',type=int,default=20)
    parser.add_argument('--smax',type=float,default=5.25)
    args=parser.parse_args()
    if args.kmin<20 or not 0<args.smax<=5.25:
        parser.error('the proven tail estimates require kmin >= 20 and 0 < smax <= 5.25')
    s_bound = arb(21)/4
    h_bound = arb(1)/20
    # Every displayed first-omitted majorant has subsequent ratios below 1/20.
    geometric = arb(20)/19
    assert geometric*s_bound**70/factorial(72) < arb('1e-23')
    assert geometric*s_bound**72*(h_bound+arb(1)/73)/factorial(72) < arb('1e-23')
    assert geometric*h_bound**37*s_bound**72/factorial(37) < arb('1e-23')
    assert (arb(ORDER+3)/2+s_bound+s_bound*(arb(5)/8))/(ORDER+1) < arb(4)/5
    stack=[(0.,nextafter(1/args.kmin,inf),0.,0.3125,0.,args.smax)]
    count=0
    while stack:
        box=stack.pop()
        if test(*box):
            count+=1
            if count%10000==0:
                print(count,box,flush=True)
            continue
        h,H,p,P,s,S=box
        scores=[(H-h)*15,(P-p)*16,(S-s)]
        i=max(range(3),key=scores.__getitem__)*2
        if max(scores)<2**-28:
            raise ArithmeticError(box)
        m=(box[i]+box[i+1])/2
        stack.extend([box[:i]+(box[i],m)+box[i+2:],box[:i]+(m,box[i+1])+box[i+2:]])
    print('accepted or excluded',count)


if __name__=='__main__':
    main()
