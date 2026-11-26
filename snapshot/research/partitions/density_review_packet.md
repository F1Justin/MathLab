Audit the claimed density-one theorem as an adversarial mathematics referee. Re-derive the saddle estimate, zero count, monotonicity, endpoints, and numerical certificate logic. Look for counterexamples and subtle errors. Distinguish a mistake in the claims from an editorial issue. Is it plausible the proof extends to the remaining o(n) zeros, and what concrete route or theorem would do so? Do not claim external priority.

# Density-one real zeros and adjacent interlacing for the four-element block statistic

For the ordinary set-partition polynomial P_n(t) with each block of size at least four carrying weight t, write d_n=floor(n/4). For each eta>0 there are 0<a<b such that for all sufficiently large n, P_n and P_(n+1) each have at least (1-eta)d_n simple negative real zeros in [-bn,-an]. Except for endpoint cells, consecutive zeros there strictly alternate between the two rows. In particular the proportion of simple negative real zeros tends to one. The argument concerns all sufficiently large n, with no restriction on n modulo four. It does not settle the full conjecture: o(n) exceptional zeros and finitely many small rows remain possible.

The proof combines the coefficient integral and its derivative from bulk_theorem.md with a global description of its two dominant saddles. The middle-radius step uses interval arithmetic with outward rounding. Sources of the problem are listed in edge_theorem.md.

## Global saddle lemma

Set B(z)=exp(z)-1-z-z²/2-z³/6, H=z B', K=z H'. For every r>0, the minimum of Re B on the circle |z|=r occurs at exactly two conjugate points z=r exp(+/-i theta(r)), 0<theta(r)<pi. At the upper point H is real negative, Re K<0, and Im B>0.

### Small radii

For 0<r<=1/16 put T=24B/r^4 and write z=r exp(iu), 0<=u<=pi. Then

    T = exp(4iu)+(r/5)exp(5iu)+sum_(j>=2) a_j exp((4+j)iu),
    a_j = 24r^j/(4+j)!.

The sum of the a_j for j>=2 is <=r²/29; the sums with weights (4+j)² and j/4 are <=2r² and <=r²/30 respectively. These inequalities follow by bounding the first terms r²/30, 36r²/30 and r²/60 by their geometric tails using successive term ratios. Outside the pi/32-neighborhoods of pi/4 and 3pi/4, cos(4u)>=-cos(pi/8). Comparison with u=pi/4 excludes that region since 2(r/5+r²/29)<1-cos(pi/8). Inside the neighborhood of 3pi/4, cos(5u)>=cos(13pi/32)>1/4, while cos(5pi/4)=-1/sqrt(2); the possible errors from the tail sum to less than the resulting linear gap. In the remaining neighborhood Re K, normalized by 24/r^4, is at most -16 cos(pi/8)+5r+2r²<0. Thus Re B is strictly convex there in the angular variable and attains its unique minimum at an interior angle. At this point Im H=0. Its real part is negative by the same estimate with weights 4+j in place of their squares (the leading term is now -4 cos(pi/8)).

At this point Im B=Im(B-H/4). In the same normalization the leading nonzero term is -(r/20)sin(5u), which is at least r/80 throughout the neighborhood, while the tail is at most r²/30. Hence Im B>0. The stationarity equation gives theta->pi/4 as r->0 and H~ -r^4/6, B~ -r^4/24.

### Middle radii

Run saddle_certificate.py with python-flint 0.9.0 and SciPy. On closed slabs covering [1/16,32] the program verifies the following sufficient conditions with Arb balls. For each slab an angular core [l,h] (in units of pi) and reference angle q0 are proposed. At its two endpoints Im H has opposite signs (+,-). Throughout the core Re K<0. Outside the core on [0,pi], Re B exceeds its value at pi q0, with the same radius. These facts imply a unique interior angular minimum. A tightened root enclosure proves Re H<0 and Im B>0. For r<=4 the identity Im B=Im(B-H/4) at the root is used to reduce cancellation. All normalizations are real and positive. The certified global minimum is unique in the upper semicircle, so it is the same branch at every shared boundary.

SciPy supplies candidate angles only. The interval kernel includes the complex Taylor tail in both components, uses certified endpoint signs for both bisections, and signals failure if any radius range cannot be certified. The exact input is the interval [1/16,32], not a grid of sample radii. The output in saddle_certificate.json includes a separately certified phase excursion for [1,32].

### Large radii

Let r>=32, z=x+iy in the upper semicircle, and M=1+r+r²/2+r³/6<r³. At the test point in the right half-plane with y=pi, x_pi=sqrt(r²-pi²)>r-1/5, and Re B<=-exp(x_pi)+M. The left half-plane has Re B>=-1-M. On the right with y>=2pi, write x_y=sqrt(r²-y²). Then x_pi-x_(2pi)>=3pi²/(2r) and
exp(x_pi)-exp(x_(2pi))>=exp(r-1/5)/(2r)>2M. On the rest of the right semicircle with y<=2pi and y outside [3pi/4,5pi/4], cos(y)>=-1/sqrt(2), so Re B>=-exp(r)/sqrt(2)-M, strictly above the test value. The exponential-versus-polynomial inequalities here and below hold already at 32 and exp(r)/r^4 is increasing.

In the remaining core, 0<u=arg z<1/8, x>r-1, and cos(y+2u), cos(y+u) are both <=-1/2. The expression K=(z+z²)exp(z)-(z+2z²+3z³/2) has negative real part. The same argument applied to H=z exp(z)-z(1+z+z²/2) gives Re H<=-r exp(r-1)/3. Strict angular convexity again gives the unique minimum and Im H=0 there. Since B=H/z-z³/6,

    Im B >= exp(r-1) sin(u)/3 - r³/6 > 0

as sin(u)>=3pi/(4r). As r->infinity this core gives u=O(1/r), |B/H|=O(1/r), H->-infinity.

## Counting the zeros

The implicit function theorem applies because d(Im H)/du=Re K<0. Along the branch, differentiating Im H=0 gives r dH/dr=|K|²/Re K<0. Thus tau=-1/H falls strictly from infinity to zero. For the phase psi=-tau Im B-theta, differentiation at the saddle gives d psi/d tau=-Im B<0. Its endpoint values are -pi/4 at r=0 and 0 as r->infinity. The first limit follows from B/H->1/4 real and the second from |B/H|+theta->0.

On every fixed compact interval of radii the two-saddle Gaussian estimate and its derivative in bulk_theorem.md apply verbatim. Indeed the global saddle lemma supplies exactly its three requirements: unique conjugate global minima, nonzero real curvature and Im B>0. The zero count for each adjacent row equals n times the phase excursion divided by pi, up to O(1); one zero per complete cosine cell is simple and the two rows' phases differ by theta, bounded away from both 0 and pi. Exhausting the positive radius axis takes the phase excursion to pi/4. Since d_n~n/4 this proves the theorem.

The argument also determines the limiting distribution after scaling zeros by n. On the negative real interval corresponding to radii [r1,r2], 0<r1<r2, the limiting mass is 4(psi(r2)-psi(r1))/pi. To interpret this for all zeros as a complex empirical measure, first restrict to a compact interval accounting for at least 1-eta of the degree, then let eta decrease to zero.


# A linear number of strictly interlacing zeros for the threshold-four statistic

There exist absolute constants 0<a<b and c>0 such that for all sufficiently large n, P_n and P_(n+1) have at least c n consecutive simple real zeros apiece in (-bn,-an). On each closed interior subinterval, apart from the two boundary cells, the zeros of the two rows strictly alternate. Here “consecutive” refers to zeros on the real line in that interval. This assertion gives no information on nonreal zeros elsewhere. The argument below uses all four residue classes of n at once.

## The two dominant saddles

Write A(z)=z+z²/2+z³/6 and B(z)=exp(z)-1-A(z). For small r>0 choose theta(r) near pi/4 by Im(z B'(z))=0 where z=r exp(i theta). Indeed after dividing by r^4/6 this equation is sin(4 theta)+(r/4)sin(5 theta)+O(r²)=0. The implicit function theorem gives

    theta(r)=pi/4-r/(16 sqrt(2))+O(r²),
    tau(r)=-1/(z B'(z))=6 r^(-4)(1+O(r)).

The value of tau is real positive and strictly decreasing for small r, by the differentiable Laurent expansion. Fix any compact interval 0<r0<r1 sufficiently small and set a=tau(r1), b=tau(r0). Any smaller nondegenerate compact interval may be used.

On the circle of radius r, the real part of the exponential rate is -tau Re B(r exp(iu)). Its global maxima occur only at u=+theta and -theta. To see this, factor out the positive factor tau r^4/24. The remaining real function is

    -cos(4u) - (r/5)cos(5u) + O(r²)

in the C² norm of the circle. The four strict local maxima at r=0 persist near +/-pi/4 and +/-3pi/4. The simple critical points of the leading term persist uniquely in small neighborhoods and its derivative is bounded away from zero off those neighborhoods. The values of the perturbed maxima near +/-pi/4 are 1+r/(5 sqrt(2))+O(r²), and those near +/-3pi/4 are 1-r/(5 sqrt(2))+O(r²). The global pair is therefore the first pair. The angular stationarity condition is Im(z B'(z))=0, so this pair is the one specified above. On the chosen compact parameter interval all the separations away from fixed neighborhoods of the two global maxima, and their negative real curvatures, are bounded uniformly away from zero.

## Oscillation and the neighboring row

For j=0,1 use the same large exponent n and the same real argument t=-n tau in the coefficient integral for P_(n+j)(-n tau)/(n+j)!. The angular exponent is

    f(u)=-tau B(r exp(iu))-iu,

with prefactor exp(A(r exp(iu)))(r exp(iu))^(-j), and outside factor r^(-n)/(2 pi). At u=theta we have f'= -i(tau zB'(z)+1)=0 and Re f''<0. Denote psi(tau)=Im(-tau B(z)-log z). The stationary equation gives psi'=-Im B(z). Since zB'(z) is real and B(z)-zB'(z)/4=-z^5/480+O(z^6),

    Im B(z)=r^5/(480 sqrt(2))+O(r^6)>0.

This sign and its lower bound are uniform on the fixed compact interval. In particular there is a nonzero phase excursion across it.

Expanding the angular integral at the two conjugate maxima gives a positive normalization D_(n,j)(tau) such that, uniformly on [a,b],

    P_(n+j)(-n tau)/D_(n,j) = cos(H_j) + o(1),
    H_j=n psi(tau)+phi(tau)-j theta(tau),
    phi=arg(exp(A(z))/sqrt(-f''(theta))).

Take the square root with positive real part and any continuous phase. More explicitly D is (n+j)! times 2 r^(-n-j) exp(n Re f(theta)) |exp(A(z))/sqrt(-f''(theta))| /sqrt(2 pi n). For completeness, outside fixed neighborhoods of the maxima the integral is exponentially smaller. Inside use v=sqrt(n)(u-theta), Taylor expansion with a uniformly bounded cubic remainder and domination by exp(-c v²). Truncation at fixed |v| followed by dominated convergence gives a uniform o(1) relative to D. The conjugate saddle supplies the conjugate Gaussian. The same argument with the extra analytic prefactor -B gives, for the actual derivative with respect to tau,

    (d/dtau P_(n+j)(-n tau))/(n D_(n,j))
      = -Re B(z) cos H_j + Im B(z) sin H_j + o(1).

Here differentiation is of the coefficient before choosing the integration radius. This avoids differentiating an asymptotic error. Curvatures, amplitudes, phases and their derivatives are smooth on [a,b].

The phase H_j is strictly decreasing for n large because psi' is bounded above by a negative constant. Away from small fixed phase neighborhoods of pi/2+ell*pi, the cosine expansion rules out zeros. Choose these neighborhoods sufficiently small that the sine term dominates the cosine term in the derivative expansion throughout each one; this is possible because Im B has a positive minimum and Re B is bounded. Signs on the endpoints are opposite, and the derivative has constant nonzero sign inside. Each complete cell contains exactly one simple real zero. Their phases differ from pi/2+ell*pi by o(1) uniformly. Since H_1=H_0-theta, and theta stays in a compact subinterval of (0,pi), the two sequences of cells alternate strictly, with row n first in increasing t for the same phase index. Boundary cells account for only O(1) zeros. The number of zeros for each row on the interval is

    n |psi(b)-psi(a)|/pi + O(1).

This is an unconditional positive linear lower bound for the number of real zeros of this specific open-problem polynomial. Establishing an all-root result, or a priority claim in the literature, is separate.


"""Rigorous interval certificate for the conjugate saddles, 1/16 <= radius <= 32.

Requires python-flint 0.9.0 and SciPy. Floating-point roots only propose angle
brackets. Every mathematical decision is rechecked with outward-rounded Arb balls.
"""
import cmath
import json
import math
from collections import Counter
from flint import arb, acb, ctx
from scipy.optimize import brentq

ctx.prec=96
pi=arb.pi()
counts=Counter()


def interval(a,b):
    return arb(a).union(arb(b))


# At r<=4 use the series after factoring out z^4/24. The omitted tail
# for each of B,H,K,B-H/4 is bounded by the K-tail starting at j=31.
from fractions import Fraction as Q
series={}
for name in ("B","H","K","D"):
    terms=[]
    for j in range(31):
        k=j+4
        factor={"B":1,"H":k,"K":k*k,"D":1-Q(k,4)}[name]
        x=Q(24,math.factorial(k))*factor
        terms.append(arb(x.numerator)/x.denominator)
    series[name]=terms
first=Q(24*35**2*4**31,math.factorial(35))
assert 2*first < Q(1,10**15)  # next / previous <= 4*36/35^2 < 1/2
err=arb(0,arb('1e-15'))
tail=acb(err,err)


def quantity(r,q,name,small):
    u=pi*q
    unit=acb(u.cos(),u.sin())
    z=r*unit
    if small:
        total=acb(0)
        for coeff in reversed(series[name]):
            total=total*z+coeff
        four=4*u
        return acb(four.cos(),four.sin())*total+tail
    exp_neg=(-r).exp()
    exp_scaled=acb(r*(unit.real-1),r*unit.imag).exp()
    bprime=exp_scaled-exp_neg*(1+z+z*z/2)
    if name=="B":
        return bprime-exp_neg*z**3/6
    if name=="H":
        return z*bprime
    if name=="K":
        return z*bprime+z*z*(exp_scaled-exp_neg*(1+z))
    raise ValueError(name)


def approximate_q(r):
    def imaginary(q):
        z=r*cmath.exp(1j*math.pi*q)
        return (z*(cmath.exp(z)-1-z-z*z/2)).imag
    for i in range(1,1025):
        if imaginary(i/1024)<0:
            return brentq(imaginary,(i-1)/1024,i/1024)
    raise ValueError(r)


def all_angles(lo,hi,predicatedepth,predicate):
    count=0
    stack=[(lo,hi,0)]
    while stack:
        a,b,depth=stack.pop()
        count+=1
        if predicate(interval(a,b)):
            continue
        if depth==predicatedepth:
            return False
        mid=(a+b)/2
        stack.extend(((a,mid,depth+1),(mid,b,depth+1)))
    counts['verified_angle_boxes']+=count
    return True


def certify(a,b):
    r=interval(a,b)
    small=b<=4
    qa,qb=approximate_q(a),approximate_q(b)
    q0=(qa+qb)/2
    width=min(.047,.25/b)
    lo,hi=min(qa,qb)-width,max(qa,qb)+width
    assert 0<lo<q0<hi<1
    h=lambda q:quantity(r,q,"H",small)
    if not (h(arb(lo)).imag>0 and h(arb(hi)).imag<0):
        return False
    if not all_angles(lo,hi,8,lambda q:quantity(r,q,"K",small).real<0):
        return False
    trial=quantity(r,arb(q0),"B",small).real
    predicate=lambda q:quantity(r,q,"B",small).real>trial
    if not all_angles(0,lo,12,predicate) or not all_angles(hi,1,12,predicate):
        return False
    # Tighten the critical-point enclosure by certified endpoint signs.
    left,right=lo,hi
    for _ in range(10):
        q=(left+right)/2
        if h(arb(q)).imag>0:
            left=q
        else:
            right=q
    lower=left
    left,right=lo,hi
    for _ in range(10):
        q=(left+right)/2
        if h(arb(q)).imag<0:
            right=q
        else:
            left=q
    upper=right
    root=interval(lower,upper)
    imag=quantity(r,root,"D" if small else "B",small).imag
    return h(root).real<0 and imag>0


def phase(r):
    q=approximate_q(r)
    lo,hi=q-1e-9,q+1e-9
    small=r<=4
    h=lambda q:quantity(arb(r),q,"H",small)
    assert h(arb(lo)).imag>0 and h(arb(hi)).imag<0
    q=interval(lo,hi)
    H=h(q).real
    B=quantity(arb(r),q,"B",small)
    assert H<0
    return B.imag/H-pi*q


if __name__=="__main__":
    stack=[(.0625,.125),(.125,.25),(.25,.5),(.5,1.),(1.,2.),(2.,4.),(4.,8.),(8.,16.),(16.,32.)]
    while stack:
        a,b=stack.pop()
        if certify(a,b):
            counts['certified_radius_slabs']+=1
        else:
            assert b-a>1e-6,(a,b)
            mid=(a+b)/2
            stack.extend(((a,mid),(mid,b)))
    fraction=4*(phase(32)-phase(1))/pi
    assert fraction>arb(4)/5
    print(json.dumps(dict(counts=counts,phase_at_1=str(phase(1)),phase_at_1_16=str(phase(.0625)),phase_at_32=str(phase(32)),
                          asymptotic_fraction_of_degree=str(fraction)),indent=2))


{
  "counts": {
    "verified_angle_boxes": 1973,
    "certified_radius_slabs": 86
  },
  "phase_at_1": "[-0.74790665 +/- 8.36e-9]",
  "phase_at_1_16": "[-0.7831803 +/- 1.13e-8]",
  "phase_at_32": "[-0.09831463 +/- 8.63e-9]",
  "asymptotic_fraction_of_degree": "[0.8270862 +/- 6.46e-8]"
}
