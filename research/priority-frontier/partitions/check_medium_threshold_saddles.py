"""Interval certificates for intermediate thresholds of the Poisson tail."""

from fractions import Fraction
from functools import lru_cache
from math import ceil, comb, factorial, pi
import cmath
import sys

from flint import acb, acb_poly, arb, arb_poly

from check_small_threshold_saddles import PI, Tail, interval, test_angles


class MomentGate:
    """Certify a whole circle by enclosing four real conditional moments."""

    def __init__(self, j):
        self.j = j
        length = 512-j
        base = [arb(1)]
        for k in range(1,length):
            base.append(base[-1]/(j+k))
        self.mass = arb_poly(base)
        assert 2*factorial(j)*128**length*10**60 < factorial(512)

    @lru_cache(None)
    def point(self, r, center):
        j = self.j
        rr = arb(r)
        # The omitted series from X=512 has ratio at most 128/513.
        norm = self.mass(rr) + arb(0,arb("1e-60"))
        known = arb(0)
        weight = arb(1)
        for k in range(j,center+1):
            known += weight
            weight *= rr/(k+1)
        upper = [1-known/norm]
        all_moments = [arb(1)]
        for k in range(4):
            for values, boundary in ((upper, (center+1)*weight/norm),
                                     (all_moments, j*(j-center)**k/norm)):
                jump = sum(comb(k,h)*values[h] for h in range(k))
                values.append((rr-center)*values[k]+rr*jump+boundary)
        lower = [(-1)**k*(all_moments[k]-upper[k]) for k in range(1,5)]
        return upper[1:], lower

    def moments(self,a,b):
        center=max(self.j,round((a+b)/2))
        ua,la=self.point(a,center)
        ub,lb=self.point(b,center)
        # Positive-part powers grow with r, and negative-part powers decrease.
        d=[interval(x,y)+(-1)**k*interval(v,w)
           for k,(x,y,v,w) in enumerate(zip(ua,ub,lb,la),1)]
        h,d2,d3,d4=d
        mu=center+h
        v=d2-h**2
        m3=d3-3*h*d2+2*h**3
        m4=d4-4*h*d3+6*h**2*d2-3*h**4
        return mu,v,m3,m4

    def certifies(self,a,b):
        j=self.j
        mu,v,m3,m4=self.moments(a,b)
        if not (mu>0 and v>0 and m4>0):
            return False
        moment_ratio=m4/v+3*v
        penalty=2*(5*moment_ratio+1)/27
        second=mu*mu+v
        shift1=v/mu
        shift2=(2*mu*v+m3)/second
        biased=((mu+shift1,v+m3/mu-shift1**2),
                (mu+shift2,(mu*mu*v+2*mu*m3+m4)/second-shift2**2))
        if not all(avg>0 and var>0 for avg,var in biased):
            return False
        trial=-1+v*(PI/mu)**2/2
        far=next((q for q in range(110,231,5)
                  if 1/(PI*q/100)**2+penalty/mu**2 < 1/PI**2),None)
        if far is None:
            return False
        for high in range(110,min(160,far)+1,5):
            beta=PI*high/100
            if not all((PI*interval(q,q+5)/100).cos()-v*(PI*(q+5)/(100*mu))**2/2 > trial
                       for q in range(high,far,5)):
                continue
            tmax=beta/mu
            if not tmax**2*moment_ratio < 6:
                return False
            m=mu-j
            xu=mu*m+v
            xu3=mu*m**3+3*m*(mu+m)*v+(mu+3*m)*m3+m4
            if not (mu/j>arb(high)/100 or PI**2*xu3<6*j*j*xu):
                return False
            for low in (78,74,70,66,62,58,82):
                alpha=PI*low/100
                if not alpha.cos()-v*(alpha/mu)**2/2 > -1+v*(PI/mu)**2/2:
                    continue
                tmin=alpha/mu
                if all(tmax*avg<2*PI and
                       (tmin*avg).cos()+tmax**2*var/2<0 and
                       (tmax*avg).cos()+tmax**2*var/2<0 for avg,var in biased):
                    return True
            return False
        return False


class MediumTail(Tail):
    def __init__(self, j):
        self.j = j
        cutoff = j + 1
        m = 12
        while (2*factorial(j)*(j+m)**2*cutoff**m*10**18 >= factorial(j+m)
               or 2*cutoff*(j+m+1) >= (j+m)**2):
            m += 1
        self.length = m
        factors = {
            "B": lambda k: 1,
            "H": lambda k: j+k,
            "K": lambda k: (j+k)**2,
            "D": lambda k: -Fraction(k, j),
        }
        self.excess = {}
        for name, factor in factors.items():
            coeff = [Fraction(factorial(j), factorial(j+k))*factor(k) for k in range(m)]
            self.excess[name] = acb_poly([arb(v.numerator)/v.denominator for v in coeff])
        early = [arb(1)/factorial(k) for k in range(j-1)]
        self.complement = acb_poly(early[:-1])
        self.inv1 = arb(1)/factorial(j-2)
        self.inv2 = arb(1)/factorial(j-1)
        self.tail = acb(arb(0, arb("1e-18")), arb(0, arb("1e-18")))

    def value(self, r, q, name, small):
        j = self.j
        angle = PI*q
        unit = acb(angle.cos(), angle.sin())
        z = r*unit
        if small:
            return acb((j*angle).cos(), (j*angle).sin())*self.excess[name](z) + self.tail
        exponent = acb(r*(unit.real-1), r*unit.imag).exp()
        scale = (-r).exp()
        second = exponent-scale*self.complement(z)
        first = second-scale*z**(j-2)*self.inv1
        if name == "H":
            return z*first
        if name == "K":
            return z*first+z*z*second
        return first-scale*z**(j-1)*self.inv2

    @lru_cache(None)
    def first_stationary(self, r):
        j = self.j
        def derivative(q):
            unit = cmath.exp(1j*pi*q)
            term = 1
            total = j
            for k in range(1, ceil(2*r+90)):
                term *= r*unit/(j+k)
                total += (j+k)*term
            return (unit**j*total).imag

        lo = 0
        for index in range(1, 129):
            hi = index/(128*j)
            if derivative(hi)<0:
                break
            lo = hi
        for _ in range(42):
            mid = (lo+hi)/2
            if derivative(mid)>0:
                lo = mid
            else:
                hi = mid
        return (lo+hi)/2

    def certify_slab(self, a, b):
        r = interval(a,b)
        small = b <= self.j+1
        def val(q, name):
            return self.value(r, q, name, small)
        qa,qb = self.first_stationary(a), self.first_stationary(b)
        center = (qa+qb)/2
        margin = min(.17/self.j,.23/b)
        lo,hi = min(qa,qb)-margin,max(qa,qb)+margin
        if not 0<lo<center<hi<1:
            return False
        if not (val(arb(lo),"H").imag>0 and val(arb(hi),"H").imag<0):
            return False
        if not test_angles(lo,hi,lambda q: val(q,"K").real<0,9):
            return False
        trial = val(arb(center),"B").real
        def higher(q):
            return val(q,"B").real > trial
        if not test_angles(0,lo,higher,14) or not test_angles(hi,1,higher,14):
            return False
        left,right=lo,hi
        for _ in range(15):
            mid=(left+right)/2
            if val(arb(mid),"H").imag>0:
                left=mid
            else:
                right=mid
        lower=left
        left,right=lo,hi
        for _ in range(15):
            mid=(left+right)/2
            if val(arb(mid),"H").imag<0:
                right=mid
            else:
                left=mid
        q=interval(lower,right)
        return (arb(right)<arb(1)/self.j and val(q,"H").real<0
                and val(q,"D" if small else "B").imag>0)

    def certify(self):
        j=self.j
        end=min(128,max(64,4*j))
        bounds=sorted({(j+1)/8,min(end,(j+1)/2),min(end,j+1),end})
        stack=list(zip(bounds,bounds[1:]))
        gate=MomentGate(j)
        counts=[0,0]
        while stack:
            a,b=stack.pop()
            if gate.certifies(a,b):
                counts[0]+=1
                continue
            mid=(a+b)/2
            if not gate.certifies(mid,mid) and self.certify_slab(a,b):
                counts[1]+=1
            else:
                if b-a < 2**-20:
                    raise ArithmeticError((j,a,b))
                stack.extend(((a,mid),(mid,b)))
        gate.point.cache_clear()
        self.first_stationary.cache_clear()
        return tuple(counts)


if __name__ == "__main__":
    for threshold in (map(int,sys.argv[1:]) if len(sys.argv)>1 else range(9,128)):
        if not 9<=threshold<=127:
            raise ValueError("the certificate covers thresholds 9 through 127")
        print(f"j={threshold}: moment/angle slabs {MediumTail(threshold).certify()}",flush=True)
