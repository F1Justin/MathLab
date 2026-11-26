# Independent audit of the threshold-four partition paper

Act as a critical mathematical referee. The attached frozen notes concern ordinary set partitions, counted by number of blocks of size at least four. The intended publication claim is eventual strict negative real-rootedness and directed interlacing for gaps one through four. It would not claim an effective threshold or all rows. An older model reviewed the lag-one seam and agreed conditional on the edge estimates, but has not independently audited the five-row extension or the effective edge certificates. Work from the mathematics below, treating the prose as proposed proof. No external tools are available. Identify fatal flaws first. For each flaw provide a derivation of a correction or the smallest statement that must be removed.

Audit in detail:
1. Uniqueness/globality of the pure angular minima, certificate logic and rigorous numerical tail. Check positive Im B, H<0 and curvature on all radii, and that the exact middle saddle identifies the same branch in a genuine overlap.
2. Uniform relative errors of weighted and unweighted integrals near the outer cut nrho fixed-large and the inner cut ry^3 fixed-large, including the secondary saddle and orientation of the tilted Gaussian. Check real unwrapped phases on both seams and degree saturation without composite phase monotonicity.
3. Lag-four centered integration-by-parts insert, signed imaginary part and uniform non-cancellation, plus the precision needed for the same-residue displacement at the extreme roots. Check each direction of interlacing across a degree jump.
4. If viable, check effective certificates, particularly finite-to-asymptotic bridging and that Graeffe and real-saddle inequalities actually imply the assertions. Check the Airy zero count in complex disks and the cancellation needed for the adjacent-row shift. If output is limited, prioritize 1--3.
5. Give a short, prioritized list of indispensable changes a human reader would expect, and explicitly list which conclusions you actually validated. Advice must address this submitted packet rather than repeat the earlier lag-one review.

The files follow. File headings indicate boundaries.

## bulk_theorem.md

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

## density_one.md

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

Run saddle_certificate.py with python-flint 0.9.0 and SciPy. On closed slabs covering [1/16,32] the program verifies the following sufficient conditions with Arb balls. For each slab an angular core [l,h] (in units of pi) and reference angle q0 are proposed. At its two endpoints Im H has opposite signs (+,-). Throughout the core Re K<0. Outside the core on [0,pi], Re B exceeds its value at pi q0, with the same radius. These facts imply a unique interior angular minimum. A tightened root enclosure proves Re H<0 and Im B>0. For r<=4 the identity Im B=Im(B-H/4) at the root is used to reduce cancellation. All normalizations are real and positive. The lower tightening only advances the lower endpoint on a certified positive sign; the upper tightening only decreases the upper endpoint on a certified negative sign. At the radii used to print phases, the program separately verifies that each narrow bracket lies inside a previously accepted uniqueness core. The certified global minimum is unique in the upper semicircle, so it is the same branch at every shared boundary.

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

## saddle_certificate.py

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
endpoint_cores={}


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
    if not upper < .25:
        return False
    root=interval(lower,upper)
    imag=quantity(r,root,"D" if small else "B",small).imag
    if not (h(root).real<0 and imag>0):
        return False
    for endpoint in (a,b):
        endpoint_cores[endpoint]=(lo,hi)
    return True


def phase(r):
    q=approximate_q(r)
    lo,hi=q-1e-9,q+1e-9
    core_left,core_right=endpoint_cores[r]
    assert core_left<lo<hi<core_right
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

## outer_transition.md

# A centered derivative for the transition toward large-modulus roots

There is uniform oscillation even if the radius r in the bulk theorem tends to zero with n, provided nr tends to infinity. More precisely, on any interval [l_n,h_n] with 0<l_n<=h_n tending to zero and n l_n tending to infinity, every complete phase cell has exactly one simple real zero, and the two adjacent rows alternate up to endpoint cells. This covers intermediate root indices on the large-modulus side. In this note r is the bulk contour radius, distinct from the positive solution used at the Airy edge.

Use H=zB', tau=-1/H(z_*), and write L_j[U]=(n+j)![z^(n+j)]U(z)exp(A(z)-n tau B(z)), j=0,1. Logarithmic differentiation of the generating function gives the exact identity

    d(L_j[1])/d tau - (n+j)/(4 tau) L_j[1]
        = -n L_j[B-H/4+zA'/(4n tau)].

Indeed L_j[zA'-n tau H]=(n+j)L_j[1]. The analytic weight B-H/4 starts at -z⁵/480, one order higher than B. Also tau~6/r⁴ and zA'=O(r), making zA'/(4n tau)=O(r⁵/n) on the whole circle. After division by r⁵ the centered derivative weight and its fixed angular derivatives are uniformly bounded. At the dominant upper saddle H is real and Im(B-H/4)/r⁵ tends to 1/(480 sqrt(2)), which is positive. Thus the centered derivative retains a nonzero sine amplitude even as r tends to zero.

Here are the uniform error estimates needed to repeat the bulk count. On |z|=r the exponent f=-tau B(re^(iu))-iu has uniformly bounded angular derivatives of every fixed order; its real part converges smoothly to -cos(4u)/4. The four local maxima at the limiting angles ±pi/4 and ±3pi/4 persist, with negative curvature bounded away from zero. The two near ±pi/4 are genuine complex stationary points by construction; the real heights of the other pair are lower by a positive constant times r plus O(r²), from the fifth Taylor coefficient as in bulk_theorem.md. On fixed neighborhoods of this second pair their total absolute integral relative to the natural leading Gaussian scale is O(exp(-c nr)), by Gaussian integration of the real part alone. Outside all four neighborhoods the gap is bounded below independently of r. At the dominant pair the usual scaled Gaussian argument is uniform because curvature, cubic remainder, the normalized amplitude and its first derivative are uniformly controlled. This applies to both 1 and the centered derivative weight divided by r⁵; the factor z^(-j) is used as r^(-j)exp(-iju), so its amplitude creates no loss. The two normalized remainders tend to zero uniformly whenever n l_n tends to infinity.

In particular, with D and H_j as in the bulk proof, L_j[1]/D=cos H_j+o(1). The centered derivative divided by n r⁵ D is a bounded cosine coefficient times cos H_j plus a sine coefficient tending to 1/(480 sqrt(2)) times sin H_j, with uniform error o(1). The centered derivative has precisely the sign of the derivative of tau^(-(n+j)/4)L_j[1], since the omitted factor is positive. Near each cosine zero this derivative has fixed nonzero sign, while opposite signs at the endpoints yield exactly one simple zero. Elsewhere the cosine term excludes real zeros. Finally d psi/dr=-(Im B) d tau/dr tends to 1/(20 sqrt(2)); the smooth small-r expansions give bounded derivatives of phi and theta in r. Hence H_j is strictly increasing in r for large n, and H_1-H_0=-theta tends to -pi/4. The two sets of complete phase cells therefore give strict alternation as asserted.

This is a statement about real zeros on the indicated intervals. Counting every complex zero of each polynomial would additionally require matching the integer phase counts across all parameter ranges.

## edge_theorem.md

# Extreme zeros of the four-element block statistic

Let P_n(t) count all set partitions of [n] by the number of blocks of size at least four. Put n=4m+r, 0<=r<=3, and c=24/625. For each fixed K, for sufficiently large m the K zeros of largest modulus are simple negative real numbers. If indexed in decreasing modulus, their asymptotics are

    t_(4m+r,k) ~ -c m^5 / (4 x_(r,k)^4),    1 <= k <= K.

Here x_(0,k)=(k-1/2)pi, x_(2,k)=k*pi, x_(1,k) is the unique solution of tan x = -tanh x between x_(0,k) and x_(2,k), and x_(3,k) is the unique positive solution of tan x = tanh x between x_(2,k) and x_(0,k+1). These finite outer windows strictly interlace in the conjectured direction for all sufficiently large n, including the degree increase from 4m+3 to 4m+4.

## Coefficient limit

Write A(z)=z+z²/2+z³/6, H(z)=24(e^z-1-A(z))/z^4=1+z/5+O(z²), and a_(n,b)=[t^b]P_n(t). By the exponential formula,

    a_(n,m-l) = n! 24^(-(m-l))/(m-l)! [z^(4l+r)] exp(A(z)) H(z)^(m-l).

For fixed h and l the coefficient [z^h]exp(A) H^(m-l) is a polynomial in m with leading term m^h/(5^h h!). This follows by expanding in (H-1), whose lowest degree is one. The normalized reciprocal polynomial

    R_(m,r)(u) = sum_(l=0)^m (a_(n,m-l)/a_(n,m)) (u/(c m^5))^l

therefore converges coefficientwise to F_r(u)=sum_(l>=0) r! u^l/(4l+r)!. To get local uniform convergence, for M>0 use the circle |z|=M/m. The nonnegative coefficients of H are bounded termwise by those of exp(z), so exp(A(M/m))H(M/m)^(m-l) <= exp(A(M)+M) for m>=1. Cauchy's bound with h=4l+r gives (m/M)^h times this constant. The denominator coefficient [z^r]exp(A)H^m is >= d_r m^r for some d_r>0 and sufficiently large m, and m!/(m-l)! <= m^l. Consequently the absolute value of the l-th summand on |u|<=B is bounded by C_(M,r) (625 B/M^4)^l. Take M^4>625 B. The omitted tail for l>m is zero.

## Limiting zeros

Put G_r(x)=x^r F_r(-4x^4)/r!. Successive integration from zero gives G_0=cos(x)cosh(x), G_1=(sin(x)cosh(x)+cos(x)sinh(x))/2, G_2=sin(x)sinh(x)/2 and G_3=(sin(x)cosh(x)-cos(x)sinh(x))/4. For G_1 and G_3 the nonzero roots satisfy tan z = +/- tanh z. The poles of either side cannot be zeros of the original expressions. If z=x+iy and xy is nonzero, equating the real and imaginary parts of those equations implies

    sin(2x) sin(2y) = sinh(2x) sinh(2y),

which is impossible in absolute value. Thus all nonzero zeros are on the real and imaginary axes. Symmetry G_r(ix)=i^r G_r(x) identifies the axes after mapping by -4x^4. The elementary sine and cosine factors give the same axis property for r=0,2. The nonzero real roots are simple: for the tangent equations the relevant derivatives are sec²x +/- sech²x, strictly positive at positive zeros. The factors for r=0,2 have simple positive roots. Removing x^r at the origin leaves F_r(0)=1. Thus the zeros of F_r are precisely the simple negative numbers -4x_(r,k)^4.

Choose a circle centered at zero with radius strictly between the Kth and (K+1)st limiting moduli, and disjoint small disks centered at the K enclosed zeros. Uniform convergence and Rouché's theorem give exactly K zeros inside the large circle and exactly one, counted with multiplicity, in each small disk for all sufficiently large m. Real coefficients and conjugation force each single zero to be real. Reciprocation gives the K largest-modulus roots of P_n. The strict inequalities x_(0,k)<x_(1,k)<x_(2,k)<x_(3,k)<x_(0,k+1) transfer to each fixed window; at the degree jump (m+1)^5/m^5 tends to one. This proves the stated finite-window theorem. Interlacing across the entire row remains open. The displayed extreme-root equivalent is a fixed-k formula and cannot hold near zero.

Problem and prior work: Jack Zhan, *Polynomial recursions for counting big blocks in set partitions* (2023), and the current SymCat big-block conjecture, https://www.symmetricfunctions.com/realRootedOpenProblems.htm . Related literature by Bóna and Mező studies partitions forbidding singleton blocks and their leftmost roots, https://people.clas.ufl.edu/bona/files/bigblocknew_asymp.pdf . No priority claim is made.

## Review request

Independently audit the proof, including all constants, multiplicities, the wraparound ordering and the quantifier on K. Then try to solve the full all-n threshold-four interlacing problem. Prefer a concrete new sufficient invariant or an exact obstruction to it. The short recurrence is P_(n+1)=(1+t d/dt)P_n + nP_(n-1) + binom(n,2)P_(n-2) + t binom(n,3)P_(n-3). The empty row is P_0=1 and negative rows vanish. Separate proven statements from unproven ones.

## outer_index.md

# Absolute numbering of the negative real zeros from the outer edge

Let t_(n,k) be the k-th negative real zero of P_n in increasing order, counted from minus infinity. Set n=4m+s, 0<=s<=3. Use the upper saddle z=r exp(i theta), tau=-1/H(z), psi=-tau Im B(z)-theta, and fix the previously arbitrary phase branch by

    phi = Im A(z) - (1/2) arg(-tau K(z)),    -pi/2 < arg(-tau K(z)) < pi/2.
    W_n(r) = m pi + n psi(r) + phi(r).

Here K=z H', H=zB', and the global-saddle certificate gives Re(-tau K)>0. The point on the negative real axis is t=-n tau(r), increasing with r.

**Index formula.** Fix R>0. For any sequence of radii 0<r_n<=R with n r_n tending to infinity and distance from W_n(r_n) to pi(Z+1/2) bounded below, the exact number of negative real zeros strictly to the left of -n tau(r_n), for all sufficiently large n, is

    floor(W_n(r_n)/pi + 1/2).

All real zeros counted here are simple. The restriction on the cut avoids ambiguity immediately next to a zero. For a complete cell at index k tending to infinity and radius at most R the root satisfies W_n(r_(n,k))=(k-1/2)pi+o(1). This counts real roots on a half-line and makes no assumption on complex roots elsewhere.

**Growth of outer ranks.** Whenever k tends to infinity and k=o(n), that negative real zero exists and

    t_(n,k) ~ -3 n^5 / (320000 pi^4 k^4).

For k=o(sqrt(n)) with k tending to infinity the sharper absolute phase estimate is

    (3 n^5/(320000 |t_(n,k)|))^(1/4) = (k-1/2+s/4)pi + o(1).

### Proof

At small r the analytic expansions in the saddle calculation give

    tau=6 r^(-4)(1+O(r)),  psi=-pi/4 + r/(20 sqrt(2)) + O(r²),  phi=O(r).

In fact psi'=-(Im B) tau', with Im B~r⁵/(480 sqrt(2)), and the analytic small-radius branch gives differentiated expansions. Thus W_n increases with derivative n/(20 sqrt(2))+O(nr+1) near zero. On the remainder of (0,R] it increases for n large by compactness and psi'>0.

Fix a large integer J, independent of n, and use the cut

    r_J=(20 sqrt(2)/n)(J+s/4)pi.

At this cut W_n(r_J)=J pi+o(1) for fixed J. In the outer-edge variable u=(24/625)m⁵/t, it tends to -4 X^4 with X=(J+s/4)pi. The limiting roots in that variable are -4 x_(s,k)^4. Exactly J lie above this cut. Indeed x_(0,k)=(k-1/2)pi, x_(2,k)=k pi, x_(1,k) lies between (k-1/2)pi and k pi, and x_(3,k) between k pi and (k+1/2)pi. In all four cases x_(s,J)<X<x_(s,J+1). Compact convergence of the reciprocal polynomial and two fixed circles with radii just below and above 4 X^4 show that the moving cut has exactly J exterior roots in the original modulus, all simple and on the negative axis. This also rules out any extra real root to its left.

The two-saddle estimates and centered derivative estimate in outer_transition.md have error o_n(1)+O(exp(-c n r)) uniformly on (0,r_0] for fixed sufficiently small r_0. To see the uniform o_n(1), the upper saddle has uniformly nonzero curvature and bounded angular derivatives of the normalized exponent and amplitudes all the way to r=0. A common Gaussian cutoff and Taylor estimate give the same o_n(1) there. The other local maximum contributes the displayed O(exp(-c n r)); all constants are independent of J. For r>=r_J that term is at most C exp(-c' J). Choose J so large that sign tests on the two edges of every small phase neighborhood of (i+1/2)pi succeed, the sine term of the centered derivative fixes the sign throughout each such neighborhood, and the cosine bound excludes other real zeros. On [r_0,R] use the compact bulk estimates. This covers the whole interval, including the joins. At r_J the cut is within o(1) of the integer phase J pi, outside every zero neighborhood. Thus the next zero has phase near (J+1/2)pi and index J+1, fixing the integer offset. For a sequence of upper cuts a fixed positive distance from half-integer phases choose phase neighborhoods narrower than that distance before choosing J. At cells with nr tending to infinity the phase error tends to zero since the subdominant pair then vanishes. This proves the index formula.

For the second assertion, cuts at r equal to fixed multiples of k/n straddling 20 sqrt(2) pi k/n enclose the k-th real zero, by the cell count (the cut may be moved by O(1/n) to an integer phase). At that zero expand the exact indexed phase:

    n r/(20 sqrt(2)) = (k-1/2+s/4)pi + O(k²/n) + o(1).

Inserting tau=6r^(-4)(1+O(r)) gives the claimed equivalent. Passing to the fourth root gives the more precise estimate since the O(r) relative error causes an additive O(k²/n) error.

## airy_theorem.md

# The Airy edge and adjacent-row spacing at zero

Let P_n(t)=n![z^n] exp(A(z)+t B(z)), A(z)=z+z²/2+z³/6, B(z)=exp(z)-1-A(z). Let r+r²+r³/2=n, r>0, c₀=3/(2e), a=(3/4)^(1/3), b=3/(2a). Let 0<d₁<d₂<... be the positive numbers for which Ai(-d_k)=0. For each fixed K and sufficiently large n, the K zeros of P_n nearest to zero in complex modulus are simple negative real numbers. Write them as -x_(n,k), in increasing order of positive magnitude. Then for fixed k,

    x_(n,k) = c₀ r exp(-r) [1+(d_k/b)r^(-2/3)+O_k(r^(-1))],
    x_(n,k)-x_(n+1,k) ~ exp(-r)/(e r).

In particular the nearest fixed windows in adjacent rows strictly interlace: x_(n+1,k)<x_(n,k)<x_(n+1,k+1). The spacing between neighbors in one row is of order r^(1/3) exp(-r), much greater than the shift to the next row.

## Local integral

Put x=c r exp(-r). Integrate the coefficient at radius R=r+u₀ for bounded real u₀, with angle v/R; the integral from -pi R to pi R then uses dv/(2pi R). After factoring out exp(A(r))r^(-n), the exponent for bounded (possibly complex) c and bounded real v is

    r S_c(w)+T(v)+O(1/r),     w=u₀+iv,
    S_c(w)=3w²/4-c exp(w),    T(v)=w²-(v²/2) S'_c(w).

Indeed h=R exp(iv/R)-r=w-v²/(2r)+O(r^(-2)). In A(r+h)-A(r)-n log(1+h/r), the linear coefficient vanishes, the quadratic coefficient is 3r/4+1+1/(2r), the cubic coefficient is O(1/r), and the higher-order remainder on bounded h is O(1/r). The B term is c r exp(h)+O(r⁴ exp(-r)). All errors are uniform on bounded parameter sets.

The part with |v|>M is exponentially small relative to any saddle used below, for a sufficiently large fixed M. In the logarithm of the integrand modulus the B term at any angle contributes at most |x|B(R)=O(r). For |v/R| less than fixed small delta, A(R)-Re A(R exp(iv/R)) >= c₁ r v² by the cubic term. Outside this arc the quadratic and cubic terms of A have no common maximum, so the same difference is at least c₂ r². The overall exponential at angle zero relative to the chosen prefactor has logarithmic modulus O(r). Polynomial factors, including the O(r) integration length, preserve the tail bound.

## Compact Airy windows

Set c=c₀(1+lambda r^(-2/3)), take u₀=1-r^(-1/3), and write v=s r^(-1/3), q=-1+is. Factor out exp(-3r/4-(3/2)lambda r^(1/3)); multiply by r^(1/3) to change variables and by R to cancel the measure factor. The normalized integral F_n(lambda) is entire in lambda and has the same zeros as P_n(-x). On compact s,lambda sets, the remaining integrand tends to

    e exp(-q³/4-(3/2)lambda q).

This uses S'_(c₀)(1)=S''_(c₀)(1)=0 and S'''_(c₀)(1)=-3/2. An integrable majorant on |v|<=M is C exp(-d s²+C|s|) for bounded complex lambda. In fact the drop for c=c₀ from angle v=0 in Re S is at most
-3v²/4+c₀ exp(u₀)(1-cos v) <= -(3/4)(1-exp(-r^(-1/3)))v².
The change due to lambda, after subtracting its value at v=0, is bounded by C r^(-2/3)|v| before multiplying by r. The normalized integrand at v=0 stays bounded, and the preceding tail estimate handles the rest of the circle. Consequently F_n converges locally uniformly in complex lambda, with its derivatives, to

    F(lambda)=(e/a) Ai(-b lambda).

The error in this convergence, on each fixed complex compact set and for each fixed derivative, is O(r^(-1/3)). On |v|<=M, Taylor expansion at w=1 bounds the difference of the exact and limiting normalized exponents by C r^(-1/3)(1+|s|^4). Both exponentials have the preceding Gaussian majorant, so integrating the exponent difference times the maximum modulus of the two exponentials gives the rate. For derivatives use Cauchy on a larger compact disk. Since the limiting zeros are simple, the lambda coordinates differ from d_k/b by O_k(r^(-1/3)). The last identity is the vertical-contour Airy integral with t=-a q, Re t=a. Rouché's theorem near each simple limit zero gives one simple zero, real by conjugation. On compact sets disjoint from the limit zeros there are none for large n.

## Excluding zeros closer in complex modulus

It remains to exclude zeros escaping every compact Airy window on the inner side; compact convergence alone would not suffice. Consider a prospective sequence of zeros with |c|<=c₀(1+L r^(-2/3)) for fixed L and with |lambda| divergent. Pass to a subsequence on which c converges to a point in the closed critical disk. Solve (3/2)u exp(-u)=c on the branch through u=0. For |c|<c₀, the map u ↦ (2/3)c exp(u) contracts the closed disk of radius rho<1 solving rho exp(-rho)=(2/3)|c|. At a boundary point other than c₀ the branch continues with |u|<1: an inner radial limit exists along a subsequence, and equality |u|=1 would force Re u=1 in the modulus equation, hence c=c₀. The inverse function theorem at this limit gives a saddle in a neighborhood, which is all that is required.

At a sequence tending to c₀, set delta=c/c₀-1. Then Re delta<=L r^(-2/3), and |delta| r^(2/3) tends to infinity. The local inverse with h=1-u has h=sqrt(-2 delta)+O(delta), choosing the square root of positive real part. Indeed (1-h)exp(h)=1-h²/2+O(h³) is analytically invertible in the square-root parameter. Since Re delta/|delta| is bounded above by o(1), Re h is at least a fixed positive multiple of |h|. Thus 1-|u| is also at least a fixed positive multiple of |h| and r|h|³ tends to infinity.

Choose R=r+Re u, so the vertical w line passes through u at v=Im u. For every real t,

    Re[S_c(u+it)-S_c(u)]
      = Re[-3t²/4-(3/2)u(exp(it)-1-it)]
      <= -(3/4)(1-|u|)t²,

using the integral Taylor bound |exp(it)-1-it|<=t²/2. On scaling t=s/sqrt(r|1-u|), the saddle integral relative to exp(r S_c(u)+T(Im u)) has a nonvanishing complex Gaussian main term, with relative error o(1). Explicitly the limiting quadratic coefficient along any subsequence on which h/|h| converges is -(3/4)h/|h|, with real part uniformly negative. The scaled cubic remainder is O(|s|³/sqrt(r|h|³)) on bounded s, the displayed bound gives a Gaussian majorant, and the remote tails were already excluded. The same argument applies when u stays strictly inside the unit disk and |h| is bounded below. This contradicts a zero for every such sequence. Taking L strictly between d_K/b and d_(K+1)/b now proves the asserted count in the entire disk: for bounded lambda the disk condition implies Re lambda<=L+o(1), and the Airy function's zeros are all simple and negative in its argument.

## Direction and size of the shift to the next row

On the same circle and at the same x, form F_(n,1) from the identical integral with extra factor (r+1)/z. It differs from P_(n+1)(-x) by a nonzero analytic normalization. For fixed s,

    r^(4/3) [(r+1)/z-1] → -q.

On |v|<=M the left-hand side is bounded by C(1+|s|) since z=R exp(iv/R). On the remaining arc a polynomial loss is absorbed by the exponential tail. The same dominated convergence now gives, uniformly on compact lambda sets,

    r^(4/3) [F_(n,1)-F_n] → (2/3) F'(lambda).

This computation cancels all common errors before expanding. Let lambda_n be the k-th root parameter and mu_n the nearby zero of F_(n,1), both expressed using r(n). They have the same simple limit. For the adjacent row the preceding zero count labels this root as the k-th one: r(n+1)-r(n)=O(r^(-2)) changes its scaled parameter by o(1). The real mean value theorem and local uniform derivative convergence give mu_n-lambda_n=-(2/3)r^(-4/3)(1+o(1)). Multiplying by c₀ r exp(-r) r^(-2/3) yields the stated adjacent-row gap.

The numerical programs near_zero_pilot.py and airy_pilot.py use independent methods. The former isolates polynomial roots; the latter evaluates a floating-point angular integral and provides scale diagnostics only.

## full_saddle_bridge.md

# A bridge from the bulk to the Airy regime

Notation: h(z)=z+z²+z³/2=zA'(z), H(z)=z exp(z)-h(z)=zB'(z), r+r²+r³/2=n. Let x>0, t=-x. Set

    E(z)=A(z)-xB(z)-n log z,
    D(z)=z d/dz (h(z)-xH(z)).

Use the principal logarithm of the upper saddle in the right half-plane. On any coefficient circle of radius R, use integrand exp(E(z)); the positive factorial and angular measure are understood. The adjacent coefficient, after another positive normalization, has the extra factor R/z. We need a cosine sign test and a companion sine sign test. Specifically, for a common positive scale C, an angular saddle parameter theta>0 and phase G, use

    I/C = cos G + error,
    [I_1-cos(theta) I]/[C sin(theta)] = sin G + error.

Here I_1 uses R/z on the same coefficient circle. Estimates below use the scale of a single pair of saddles even near zeros of I. At zeros the second test gives the actual next-row sign. This avoids subtracting two independently approximate cosine values with a vanishing phase separation.

## A. The middle range, with an exact saddle

Choose large fixed constants P and M. For P<=p<=r-M the exact saddle runs along z=p+iy, y close to pi. It solves x=(h(z)-n)/H(z)>0. Write N=n-h(p)>0. Convexity gives N>=M h'(p)>=c M p². Uniformly for |y-pi|<=1/2, the estimates

    h(z)-h(p)=O(p²),     H(z)=z exp(z)[1+O(p² exp(-p))]

hold together with the corresponding bounds for one y derivative of the remainders (before the first O term is divided by N). To solve for y, impose

    y+arg z+Im log(1-h(z)/(z exp(z)))-arg(n-h(z)) = pi,

using the branches near the positive axis for the last two arguments. The left side is y+O(1/p+p² exp(-p)+p²/N), and its y derivative is 1+O(1/p+p² exp(-p)+p²/N). For sufficiently large P,M this gives a unique smooth solution in the indicated interval. Its x is positive and lambda=x exp(p) is comparable to N/p. Put q=1/p+(1+x)p/lambda. Then |y-pi|<=C q, q is uniformly small, and lambda tends uniformly to infinity on this interval as n tends to infinity. Indeed (1+x)p/lambda=p/lambda+p exp(-p), and bounded p would force lambda to infinity while unbounded p gives lambda >= c M p. Since the analytic logarithmic derivative of x(z) is h'(z)/(h(z)-n)-H'(z)/H(z)=-1+O(1/p+p² exp(-p)+p²/N), its real part is negative. Along the real-x branch d(log x)/dp is the squared modulus of this derivative divided by its real part. Hence x strictly decreases with p.

At R=|z|, theta=arg z, take the unwrapped phase

    G=Im E(z) - (1/2) arg D(z),    -pi/2<arg D<pi/2.

Both sign tests have errors o(1) uniformly for P<=p<=r-M. Here are the height estimates needed for this assertion. On the small positive angular arc parameterize by v=Im z', z'=sqrt(R²-v²)+iv. The real part of E, up to an angle-independent constant, is (1+x)Re A(z')-x exp(Re z') cos v. Its upper envelope is (1+x)Re A(z')+x exp(Re z'). At the saddle this envelope overestimates the actual height by at most C lambda q². From v=y to v=2pi it drops by at least c[(1+x)p+lambda/p], since Re A decreases by at least cp there (differentiate the three cosine terms, using small positive angles) and Re z' decreases by at least c/p. Both summands of the envelope keep decreasing for angles up to any fixed sufficiently small delta. Since q is uniformly small, this gives a height gap >=c' lambda q on the remainder of this arc with v>=2pi. On the rest of the circle with |arg z'|>=delta, the exponential envelope contributes at most lambda exp(-c p); Re A(z')<=A(R) and A(R)-Re A(z)=O(p). The gap here is at least c lambda. On 0<=v<=2pi outside a fixed small neighborhood of pi the loss in -cos v gives a gap of order lambda, using A(R)-Re A(z)=O(p) and exp(R-p)=1+O(1/p). Reflection gives the same estimates on the lower semicircle. All constants can be chosen for P,M fixed sufficiently large. In particular lambda q >= max(p,lambda/p)>=sqrt(lambda); polynomial factors in p and lambda are negligible on separated arcs.

On a fixed small neighborhood of the upper saddle use angular arclength s=R(arg z'-theta). The complex second derivative at the saddle is -D(z)/R² and its real part is <=-c lambda throughout this neighborhood (with D evaluated at the running point for the second derivative). Indeed the term x(z'+z'²)exp(z')/R² has real part at most -c lambda for v close to pi; the polynomial contribution is O((1+x)p)=O(q lambda). Third angular-arclength derivatives are O(lambda), by direct differentiation. The analytic saddle has zero full first derivative. Rescale s by 1/sqrt(lambda) and use Gaussian domination; the relative error compared with the leading single-saddle magnitude tends uniformly to zero, with complex curvature bounded in modulus above and below after division by lambda. The lower saddle is its conjugate. This gives the cosine test with the stated phase. For the sine test insert (R/z'-cos theta)/sin theta, equal to -i at the upper saddle. Its change in these arclength coordinates is O(|s|), since R sin theta=y stays bounded away from zero. Its global bound is O(p), harmless on the separated arcs. This proves both tests.

## B. The coalescing inner saddles

On the inner side use positive y, u=y cot y, c=(3/2)y exp(-u)/sin y, x=c r exp(-r), R=r+u. As y runs from zero to pi this parameter c strictly increases: (log c)'=1/y-2 cot y+y csc² y, positive since multiplication by y gives (1-y cot y)²+y². With v=R arg z' the exponent relative to real constants is r S(w)+T(v)+O(1/r), w=u+iv, S(w)=3w²/4-c exp(w), T(v)=w²-v² S'(w)/2. The expansion holds on fixed complex compact v sets by the analytic Taylor proof in airy_theorem.md. Upper saddle w*=u+iy, phase

    G=r Im S(w*)+Im(w*²)-(1/2)arg S''(w*),   theta=y/R.

On compact y intervals inside (0,pi) the two sign tests hold with uniform error o(1). Re S on the vertical line is -3v²/4-c exp(u)cos v plus a constant; reducing v modulo 2pi to [-pi,pi] rules out remote maximizers. Within [0,pi], strict decrease of sin(v)/v gives a unique maximum at y. Re S''(w*)>0. For the sine weight use (exp(-iv/R)-cos(y/R))/sin(y/R); at v=y it is -i, and on bounded v its derivative is O(1/y). The large-angle tails absorb its polynomial global bound by the estimate in airy_theorem.md.

For y tending to zero assume L=r y³ is large. The two tests have error tending to zero as L tends to infinity, uniformly in the sequential sense; more precisely for sufficiently small y and sufficiently large L there is a bound O(L^(-1/2))+o_r(1). To see this deform the positive part of the v contour on 0<=V<=epsilon so that

    w = u + delta(y-V) + iV,    delta=1/2.

Use the conjugate on the negative side: both pieces meet at the same real w when V=0. Restore the original vertical line at V=±epsilon by horizontal segments. The exact integrand and both weights are analytic in the complex angular variable, so the deformed integral agrees with the original. Write d=V-y, w=w*+(i-delta)d. The Taylor expansion at w* gives, uniformly there,

    Re[S(w)-S(w*)]/[(3/2)d²]
       = -delta y -(3delta-delta³)d/6 + O(y²+d²).

Since V>=0, the leading expression is <=-c(y+V), so the error can be absorbed for sufficiently small fixed epsilon. At V=epsilon, the real part of S' on the horizontal connector is positive for small y relative to fixed epsilon: at the limiting double saddle it is (3/4)(epsilon²-(Re w-1)²)+O(epsilon³), uniformly positive for |Re w-1|<=0.6epsilon. The highest connector endpoint is the one on the original line, with a strict height gap independent of y for small y, by 1-cos(epsilon)<epsilon²/2. The original line beyond these connectors has a fixed gap on bounded V by the same limiting strict inequality and compactness. The tails outside a large bounded V interval are exponentially small by the original-circle estimate. For the sine weight their additional factor O(R/y) remains polynomial since r y³ is bounded below.

Thus each saddle has a quadratic bound -c y d² on its ray. With s=d sqrt(r y), its endpoint at V=0 is s=-sqrt(L). The omitted Gaussian tail there is exponentially small in L. The normalized complex quadratic coefficient (i-delta)² S''(w*)/(2y) has uniformly negative real part and bounded modulus. The Taylor exponent error on the deformed ray is O(|s|³/sqrt(L)); integrating the difference of exponentials uses this polynomial bound times the greater of the two Gaussian majorants. The analytic factor exp(T) has relative variation O(|d|) on the local arc, and the sine weight varies by O(|d|/y), giving O(L^(-1/2)) integrated error. Taylor's bound for the complex S is uniform on the entire fixed arc, including the cubic remainder. The oriented Gaussian prefactor recovers 1/sqrt(S''(w*)) with the principal square root: the contour tangent in the v coordinate is 1+i delta, and (1+i delta)sqrt(S'') has positive real part. These estimates give the desired cosine and sine tests.

## C. Matching the phases without a winding ambiguity

All phases use the principal argument of a curvature with positive real part, and principal log of the saddle in the right half-plane. At bounded p near P, x/n stays on a compact positive interval. To identify the branch, pass to any subsequence with limits for p and x/n. Divide the height bounds of part A by n: lambda/n has a positive lower bound, q>=1/p, and normalized curvature on the primary neighborhoods stays strictly negative. Thus on the limiting circle the limiting pair minimizes Re B globally, since A/n disappears. The earlier angular certificate identifies its upper point uniquely. Nonzero H' and the inverse function theorem now locate the pure saddle at the same x/n within O(1/n) of the exact saddle, uniformly on the compact overlap; the exact equation differs from H=-n/x by h/x=O(1/n). Because -x B-n log z is stationary at the pure point, its value changes by O(1/n), and the A term does also. In curvature D/n=-(x/n)K(z_pure)+O(1/n). This gives G-(n psi+phi)=o(1) as an actual real phase, with principal log on both sides.

At p in a fixed-width overlap around r-M (use the estimates of A down to M-2), c ranges in a compact interval. More explicitly, y tends along subsequences to the unique solution of y cot y=p-r in (0,pi) for any given limit of p-r: the exact stationarity equation in bounded local coordinates limits to S'(w)=0; its imaginary part determines c=(3/2)y exp(-u)/sin y. Here c is bounded above and below from lambda comparable to N/p and p-r bounded. The limiting saddle is nondegenerate, uniformly on this compact overlap. For the same c at finite r, the exact-saddle angular coordinate and the reduced saddle (using its own circle R=r+u) agree in z up to O(1/r), by the analytic derivative expansion and inverse function theorem. Evaluating the reduced S at a point O(1/r) away changes r S by O(1/r); T tends to w*², and D/(R² r) tends to S'' at the reduced saddle, with vanishing error. Real normalizing constants from the angular representation do not affect phases. This gives the second unwrapped phase agreement. Equivalently both upper actions can be evaluated as analytic functions of z near r+w*. Interpolate the two real phase functions continuously in each overlap; the change is uniformly o(1).

The sine test is needed only at an actual zero of I. On an overlap either native sine formula suffices there, since its I term vanishes, its remaining normalization is positive, and its phase differs by o(1) from the interpolated one.

## eventual_interlacing.md

# All sufficiently large rows are strictly real-rooted and interlace

**Theorem (research manuscript).** Let P_n(t) enumerate the ordinary set partitions of [n] by the number of blocks of size at least four. There exists N such that for every n>=N all floor(n/4) zeros of P_n are simple and negative, and the zeros of P_n and P_(n+1) strictly interlace in the prescribed direction. This is an existential threshold. Its value has not been bounded numerically. The finite verification through 2000 cannot yet be joined to it to prove the conjecture for every n.

This note is the counting step in the proof, using [the angular saddle certificate](density_one.md), [fixed outer zeros](edge_theorem.md), [absolute outer numbering](outer_index.md), [fixed inner zeros](airy_theorem.md) and [the two transition estimates](full_saddle_bridge.md). Below, left to right means the usual increasing order on the negative real axis.

## Two cuts of known rank

Let m=floor(n/4), s=n-4m. Fix large integers J and H, independent of n. On the outer side take the positive radius rho=(20 sqrt(2)/n)(J+s/4)pi at t=-n tau(rho). Exactly J roots lie to its left, and its unwrapped upper-saddle phase equals (-m+J)pi+o(1), by outer_index.md. The sign at the cut is (-1)^(m-J), by the fixed outer-root count or by the cosine test.

On the inner side use r+r²+r³/2=n and set y=[2pi(H+1/4)/r]^(1/3). Put u=y cot y, c=(3/2)y exp(-u)/sin y and t=-c r exp(-r). Its phase is
G=(3/2)r y(u-1)+2uy-arg(1-u-iy)/2.
Indeed Im S(u+iy)=(3/2)y(u-1). Since u=1-y²/3+O(y⁴), this phase tends to -H pi for fixed H. Its Airy coordinate b r^(2/3)(c/c₀-1), with c₀=3/(2e) and b=(3/2)/(3/4)^(1/3), tends to S_H=[(3pi/2)(H+1/4)]^(2/3). The standard indexed Airy-zero asymptotic d_j=[(3pi/2)(j-1/4)]^(2/3)(1+O(j^(-2))) places S_H strictly between d_H and d_(H+1) for large H. For the saturation argument compact Airy convergence gives at least H roots and the cosine test supplies the endpoint sign. The stronger inner theorem, which separately excludes stray zeros in the complex disk, gives exactly H roots between this cut and zero for all sufficiently large n and gives sign (-1)^H at the cut. Standard Airy reference: https://dlmf.nist.gov/9.9.iv .

## Degree saturation

On the interval from the first cut to the second, use the composite unwrapped phase G(t) in full_saddle_bridge.md. Start with the pure B saddle n psi+phi, move to the exact saddle, then to the inner phase. Each joining interval has phase error o(1) as a real number. Choose J,H large enough, then n sufficiently large, so both sign tests throughout this interval have normalized error <1/8 (on overlaps one may absorb the phase comparison error). On the outer part the sine weight is also admissible directly: it is smooth, equals -i on the upper saddle, and has uniformly bounded angular derivatives since theta is separated from 0 and pi up to the fixed outer-middle seam. The outer error O(exp(-cJ)) and inner error O(H^(-1/2)) can both be made arbitrarily small. The other compact and middle ranges have errors tending to zero for those fixed choices.

Along the interval G goes from (-m+J)pi+o(1) to -H pi+o(1), continuously. For each successive interior integer multiple of pi take its first hitting time after the initial cut. These points appear in increasing order; append the two cuts as extremal points. The signs alternate at these m-J-H+1 points by the cosine estimate and endpoint signs. There are therefore at least m-J-H distinct intervening real roots. Together with the two edge counts this gives m distinct negative roots, exactly the degree. Each is simple and there are no other roots, real or complex. This argument does not require monotonicity of the interpolated phase.

## Next-row signs

Let t_1<...<t_m be the zeros. At a zero in the interval going from level l pi to (l+1)pi, the sine in the second sign test has sign (-1)^l. To see this without assuming monotonicity, restrict first to the part between the last visit to the left level preceding the first visit to the right level. The coefficient has opposite signs at those endpoints and the degree count permits only one zero in the larger interval. For the first or last interval an endpoint phase can differ from its designated integer by o(1); one may equivalently bracket the zero using the interior levels (l+1/6)pi and (l+5/6)pi, choosing the first hitting of the latter and the last hitting of the former before that. The signs there are opposite, and on this shorter interval sin G has sign (-1)^l and magnitude >=1/2. Thus the companion estimate gives sign P_(n+1)(t_k)=(-1)^(m-k+1), because l=-m+k-1. The positive scalar normalizations and the subtracted multiple of P_n disappear in this sign test.

The same signs hold at the J outer and H inner roots by the fixed-window interlacing theorems, taking one extra root where needed. At the outer edge the degree jump reverses which row starts, exactly as specified in edge_theorem.md. At the inner edge the same-index (rank from zero) next-row magnitude is smaller than the present magnitude, and the next-larger rank in that next row lies to its left. The positive value at zero fixes the signs from that side. Thus P_(n+1) changes sign in every (t_k,t_(k+1)) and between t_m and 0. If its degree equals m, these m intervals exhaust the roots. If its degree is m+1, its leading-coefficient sign at minus infinity also forces one root to the left of t_1. This gives strict interlacing for every sufficiently large adjacent pair.

The finite computation and the existential theorem leave open the exclusion of exceptional intermediate rows. A proof for all n needs an explicit reachable N or an argument applying independently of the asymptotic threshold.

## four_row_window.md

# Eventual strict interlacing across all gaps of one through four rows

For all sufficiently large n, P_n strictly precedes P_(n+j) for every j=1,2,3,4 in the directed interlacing convention. Thus any five consecutive sufficiently large rows are pairwise strictly interlacing. This width is maximal for a statement uniform in n: for infinitely many starting rows a lag of five increases the degree by two.

Use the all-real-rootedness and absolute indexing from eventual_interlacing.md. We prove the sign of the later row at each earlier zero. On the common contour of radius R the multiplier for the j-th later row, up to a positive scalar, is (R/z)^j. At the two upper and lower angular saddles the centered weight

    ((R/z)^j-cos(j theta))/sin(j theta)

has values -i and +i. Whenever 0<j theta<pi this gives the same sign test as for the adjacent row. In the exact middle regime its arclength derivative at and near the saddle is O(1/y) for y=Im z comparable to pi. On the inner contour with theta=y/(r+u), the derivative is O(1/y) on the local complex arcs, exactly the bound in the coalescing-saddle proof. The remote arcs absorb the polynomial growth. On compact bulk radius ranges theta is strictly less than pi/4. For radii up to 1/16 this follows because Im H at upper angle pi/4, after normalization by 24/rho⁴, is -rho/sqrt(2)+O(rho²) with the same explicit tail <=2rho² as in density_one.md; Im H decreases across the certified core. For intermediate radii the angle enclosure in saddle_certificate.py verifies upper<1/4 in units of pi on every accepted slab. For radii above 32 the large-radius proof gives theta<1/8 radians. Thus on any compact positive radius interval the centered weight is uniformly smooth for j<=4. On intervals tending to zero this remains true for j<=3.

## Removing the degeneracy for a lag of four

Write I[f] for insertion of f into the coefficient integral for P_n(-x), x=n tau. Angular integration by parts gives the exact identity

    (n+4) I[(rho/z)^4]
       = I[(rho/z)^4 h(z)-x rho^4 g(z)],       g(z)=H(z)/z^4.

Indeed integrate the angular derivative of z^(-4) exp(A-xB) z^(-n). The right-hand insertion divided by n+4 defines a weight W. At a zero of I[1], subtracting the real constant Re W(z_*) makes no change. Divide this new weight by the positive rho. Since g(z)=1/6+z/24+O(z²), x rho^4/(n+4)=6(1+O(rho)+O(1/n)), and h(z)=O(rho) on the circle, its angular derivatives of fixed order are uniformly bounded. Its value at the upper saddle is purely imaginary and equals

    -i [1/(4 sqrt(2)) + O(rho+1/n)].

The constant term of g cancels before this normalization. Consequently the same dominant Gaussian estimate, with secondary-pair bound O(exp(-c n rho)), yields a positive multiple of sin G at each high-enough complete phase cell. This yields the prescribed later-row sign uniformly from the fixed outer cut to a small fixed radius. The discontinuity between the two choices of positive scale is harmless because the sign is taken at an actual zero of I[1]. At the two fixed transition cuts used in eventual_interlacing.md choose their integer ranks large enough for every one of the four weights.

## Fixed end ranks

At the near-zero end the already proved adjacent displacement can be summed j times. For fixed k and j the magnitudes decrease strictly with n, and the displacement O(exp(-r)/r) is of smaller order than the separation r^(1/3)exp(-r) between consecutive ranks. Hence for j=1,2,3,4 the k-th inner zero of the later row lies between the corresponding two inner zeros as required.

At the far end, for j=1,2,3 the four fixed-rank limits in edge_theorem.md are strictly ordered, including any single wrap of the residue mod four. For j=4 the same residue recurs, so a first-order refinement is needed. In the notation of that proof, on every compact u disk the reciprocal polynomial has an expansion

    R_(m,s)(u)=F_s(u)+G_s(u)/m+o(1/m)

for some entire G_s. Here is a uniform justification. Let b(z)=24B(z)/z⁴=1+z/5+O(z²). For |z|<=M and 0<=l<=m,

    exp(A(z/m)) b(z/m)^(m-l) = exp(z/5) + O_M((1+l)/m),
    0 <= 1-(m)_l/m^l <= l(l-1)/(2m).

The first estimate follows by taking the analytic logarithm near one and using a uniform exponential bound before comparing exponentials. The second follows from the product of 1-i/m. For each fixed l both factors have expansions through order 1/m by Taylor expansion. Apply Cauchy's bound on |z|=M to degree 4l+s; the denominator coefficient for degree s converges to 5^(-s)/s!>0 and has an expansion through order 1/m. After multiplying differences of the normalized coefficients by m, the l-th summands on |u|<=D are bounded by C_(M,s)(1+l²)(625D/M⁴)^l. For l>m the missing term in R has only the limiting coefficient and m<=l, covered by the same bound. Choosing M⁴>625D and applying dominated convergence proves the first-order locally uniform expansion.

Perturbing a simple zero gives its position in the original variable as -C_(s,k) m^5 [1+c_(s,k)/m+o(1/m)] with C_(s,k)>0. On replacing m by m+1 the magnitude for the same outer rank therefore has ratio 1+5/m+o(1/m)>1, while the next rank remains separated by its different leading constant. Thus fixed outer rank k of row n lies strictly between ranks k and k+1 of row n+4, as required for its degree jump.

The signs at all earlier-row roots are now (-1)^(floor(n/4)-k+1) in increasing root order, for each lag. Exactly as for adjacent rows the degree and signs at zero and minus infinity give the desired directed interlacing.

## effective_outer.md

# The five outermost zeros in every row

For every integer $n\ge20$, the five zeros of $P_n$ of greatest modulus are simple, real, negative, and have distinct moduli. For two such rows at distance one, two, three or four, the two lists of five, sorted from the most negative root, alternate strictly. If the degree increases the later row comes first. Otherwise the earlier row comes first. For lower degrees, the complete finite-row check applies. This is an all-row statement for five ranks; the all-rank theorem still has an unspecified starting row.

For $n=4m+s\ge2000$, write the original variable as $t=-(24/625)m^5/(4X^4)$. The successive $X$-intervals below are **open**, with exact terminating-decimal endpoints.

| $s$ | First | Second | Third | Fourth | Fifth |
|---|---|---|---|---|---|
| 0 | 1.17–1.73 | 4.31–4.87 | 7.45–8.01 | 10.60–11.16 | 13.74–14.30 |
| 1 | 1.96–2.52 | 5.10–5.66 | 8.24–8.80 | 11.38–11.94 | 14.52–15.08 |
| 2 | 2.74–3.30 | 5.88–6.44 | 9.02–9.58 | 12.17–12.73 | 15.31–15.87 |
| 3 | 3.53–4.09 | 6.67–7.23 | 9.81–10.37 | 12.95–13.51 | 16.09–16.65 |

## Exact normalization and the tail

Put $q=1/m,\ y=500q,\ v=4X^4,\ A=z+z^2/2+z^3/6,\ b=24(e^z-1-A)/z^4$.
After extracting the common $t^m$ and a positive constant the reciprocal polynomial is
$$
 S(q,v)=\sum_{l=0}^m(-v)^l p_l(y),\qquad
 p_l(y)=\prod_{h<l}(1-hq)[w^{4l+s}]e^{A(5qw)}b(5qw)^{m-l}.
$$
Products indexed by $h<j$ start at zero. For $d=4l+s$, finite binomial expansion gives the polynomial identity at these integer rows
$$
 p_l(y)=\sum_{i=0}^d [w^d]e^{A(5w)}(b(5w)-1)^i/i!\; q^{d-i}\prod_{h<l+i}(1-hq).
$$
The checker constructs these polynomials only for $l\le L=40$, where $l+d<500$. At $q=0$ the coefficient is $1/d!$.

Fix $R=82, q_0=1/500, a=A(5q_0R), D=(b(5q_0R)-1)/q_0, M=e^{a+D}$. Nonnegative coefficients give $b(5qR)-1\le qD$. Cauchy's estimate yields $|p_l|\le MR^{-d}$ for integer rows, with $p_l=0$ for $l>m$. Thus on $|v|\le V<R^4$ the absolute sum of the tail is at most $MR^{-s}(V/R^4)^{41}/(1-V/R^4)$.

## Counts and ranks

On dyadic subintervals covering every $0\le y\le1$, Arb encloses the degree-40 sum at both endpoints of each window. The absolute tail fits strictly inside the signed margin, proving alternating endpoint signs. For each residue put $X_*=1+$ the right endpoint of its fifth window. Normalize the disk $|v|\le4X_*^4$ to radius one. For the degree-40 polynomial form the Graeffe transform $G(f)=f_{\rm even}^2-zf_{\rm odd}^2$ from the even and odd subsequences of its coefficients. This squares the modulus of each root. If the full series differs by coefficient $\ell^1$ norm at most $e$, the transformed error is at most $e(2\|f\|_1+e)$, by multiplying $f(w)f(-w)$ and then setting $z=w^2$. After two transforms, the fifth coefficient in absolute value strictly exceeds the sum of all other absolute coefficients plus the propagated error. Rouché's theorem gives exactly five roots counted with multiplicity in the disk and none on its boundary. The five real sign changes exhaust the count. Reciprocating establishes the claimed complex-modulus ranks.

The four covers have 64, 128, 128 and 256 slabs. When the residues differ the rational brackets themselves strictly alternate after the degree-jump rescaling $X\mapsto X/(1+q)^{5/4}$. The checker verifies these inequalities at the worst endpoint. For gap four we need the direction of motion inside *the same* bracket.

## The displacement over four rows

Write $H(y,v)=\sum_{l=0}^{40}(-v)^l p_l(y)$. At a fixed original $t$, taking $m$ to $m+1$ changes $(y,v)$ to $(y/(1+q),v(1+q)^5)$. Along this path the derivative in $u\in[0,q]$ is $(5v\partial_v-y\partial_y)H/(1+u)$, evaluated at $(y/(1+u),v(1+u)^5)$.

To control the *difference* of omitted tails, use the sum of absolute Taylor coefficients weighted by $R^j$ as norm in $w$. Put
$$
 D_2=\big(b(5q_0R)-1-q_0R+e^{q_0R}-1-q_0R\big)/q_0^2 .
$$
Then $\|b(5qw)-e^{qw}\|\le q^2D_2$; constant and linear terms cancel. Telescoping the $m-l$ powers costs at most $qD_2 e^D$. Replacing $e^{(1-lq)w}$ by $e^w$ costs at most $lqRe^R$. Replacing $e^{A(5qw)}$ by one costs at most $q(a/q_0)e^a$. Finally $1-\prod_{h<l}(1-hq)\le ql(l-1)/2$ for $l\le m$. Since $D\ge R$, these estimates give
$$
 |p_l(500q)-1/d!|\le qM R^{-d}(a/q_0+D_2+lR+l^2/2).
$$
The same bound holds for the zero extension $l>m$, using $q l^2/2\ge1$ and $R^d/d!\le e^R$. Compare both integer rows to $1/d!$ and use $((1+q)^{5l}-1)/q\le5l(1+q)^{5l}$. The absolute difference of their tails, divided by $q$, is bounded by
$$
 T=M R^{-s}\sum_{l>40}
 \left(\frac{V(1+q_0)^5}{R^4}\right)^l
 \left[2(a/q_0+D_2+lR+l^2/2)+5l\right].
$$
The checker bounds this positive series by its first term divided by one minus a geometric ratio, using that the quadratic factor grows by at most $(42/41)^2$ per step.

For each $X$-window $(a_k,b_k)$, take $V=4b_k^4$. On $4a_k^4\le v\le V(1+q_0)^5$, the checker converts the generator exactly in form into degree-40 Bernstein coefficients in the rescaled $v$; their values are enclosed on 32 intervals in $y$. All signed coefficients, after multiplication by $(-1)^k$, exceed $(1+q_0)T$. The Bernstein basis is nonnegative and sums to one, so after integration the tail cannot reverse the sign. At the old $k$-th root the new value has sign $(-1)^k$, the sign just after its own $k$-th reciprocal root. The rescaled test point stays between the other windows and inside the counted disk. This proves that, at the same rank, the later original root is strictly more negative. The separate brackets give the other half of the alternation.

Finite verification through row 2004 includes every comparison crossing row 2000. [Uniform checker](effective_outer.py) · [dyadic covers](effective_outer.json) · [finite rows](finite_2004_window.json)

## effective_outer.py

"""Certify extreme roots uniformly for 4m+s, m >= 500, with Arb balls."""
from fractions import Fraction
from math import comb, factorial
import json
from pathlib import Path
from flint import arb, arb_poly, ctx

ctx.prec = 256
MIN_M = 500
ORDER = 40
RADIUS = 82
RANKS = 5


def real(r):
    r = Fraction(r)
    return arb(r.numerator) / r.denominator


def coefficient_polynomials():
    """Coefficient in xi^l as a polynomial in y=500/m (sign applied later)."""
    dmax = 4 * ORDER + 3
    e = [arb(1)]
    for d in range(1, dmax + 1):
        e.append(sum(c * e[d-j] for j, c in [(1, 5), (2, 25), (3, real(Fraction(125, 2)))] if d >= j) / d)
    # Work in units where w in the auxiliary FPS is divided by 500.
    # The factors 500^i restore the powers from binom(m-l,i).
    b = arb_poly([0] + [real(Fraction(24 * 5**j, factorial(j+4) * MIN_M**(j-1))) for j in range(1, dmax+1)])
    power = arb_poly([v / MIN_M**d for d, v in enumerate(e)])
    column = []
    for i in range(dmax+1):
        column.append(power)
        power = (power*b).truncate(dmax+1) * (arb(1)/(i+1))
    falling = [arb_poly([1])]
    for j in range(ORDER+dmax):
        falling.append(falling[-1] * arb_poly([1, -arb(j)/MIN_M]))
    rows = []
    for s in range(4):
        row = []
        for l in range(ORDER+1):
            d = 4*l+s
            p = arb_poly([])
            for i in range(d+1):
                p += (falling[l+i] * column[i][d]).left_shift(d-i)
            row.append(p)
        rows.append(row)
    return rows


def tail(s, v):
    z = arb(5*RADIUS)/MIN_M
    a = z + z*z/2 + z**3/6
    b = 24*(z.exp()-1-a)/z**4
    ratio = v/RADIUS**4
    assert ratio < 1
    return (a + MIN_M*(b-1)).exp() / RADIUS**s * ratio**(ORDER+1)/(1-ratio)


def signed_cut(row, s, x, sign):
    v = 4*real(x)**4
    polynomial = arb_poly([])
    for a in reversed(row):
        polynomial = polynomial*(-v) + a
    return polynomial*arb(sign), tail(s,v)


def disk_count(coefs, s, x, k):
    v = 4*real(x)**4
    p = arb_poly([a*(-v)**j for j, a in enumerate(coefs)])
    error = tail(s, v)
    for step in range(5):
        c = p.coeffs()
        if abs(c[k]) > sum(abs(a) for j, a in enumerate(c) if j != k) + error:
            return step
        if step < 4:
            norm = sum(abs(a) for a in c)
            error *= 2*norm+error
            p = arb_poly(c[::2])**2 - (arb_poly(c[1::2])**2).left_shift(1)
    return None


def windows(s):
    # Proposed centers in hundredths, frozen to make the certificate platform-independent.
    centers = [(157,471,785,1100,1414), (236,550,864,1178,1492),
               (314,628,942,1257,1571), (393,707,1021,1335,1649)]
    return [(Fraction(c-40,100), Fraction(c+16,100)) for c in centers[s]]


def check_slab(row, s, signs, a, b):
    interval = real(a).union(real(b))
    coefs = [p(interval) for p in row]
    cuts = windows(s)
    for j,(polynomial,error) in enumerate(signs):
        if not polynomial(interval) > error:
            return None, ('sign',j)
    disk = cuts[-1][1] + 1
    steps = disk_count(coefs,s,disk,RANKS)
    return steps, ('disk',str(disk))


def difference_error(s, v):
    """Absolute bound for the change in the omitted tail, divided by 1/m."""
    q = arb(1)/MIN_M
    z = 5*q*RADIUS
    a = z + z**2/2 + z**3/6
    b = 24*(z.exp()-1-a)/z**4
    d = (b-1)/q
    assert d > RADIUS
    d2 = (b-1-q*RADIUS + (q*RADIUS).exp()-1-q*RADIUS)/q**2
    ratio = v*(1+q)**5/RADIUS**4
    # Successive terms of the polynomial majorant grow by at most ((l+1)/l)^2.
    l = ORDER+1
    decay = ratio*(arb(l+1)/l)**2
    assert decay < 1
    majorant = 2*(a/q + d2 + l*RADIUS + arb(l*l)/2) + 5*l
    return (a+d).exp()/RADIUS**s * ratio**l * majorant/(1-decay)


def verify_displacement(row, s):
    """Compare the same residue at m and m+1 using the generator 5v∂v-y∂y."""
    y = arb_poly([0,1])
    generator = [(p*arb(5*l) - y*p.derivative())*((-1)**l) for l,p in enumerate(row)]
    for k,(left,right) in enumerate(windows(s),1):
        vlo = 4*real(left)**4
        vhi = 4*real(right)**4
        width = vhi*(1+arb(1)/MIN_M)**5-vlo
        # Bernstein coefficients in h, where v=vlo+width*h and 0<=h<=1.
        shifted = [sum((generator[l]*(arb(comb(l,j))*vlo**(l-j)*width**j)
                        for l in range(j,ORDER+1)), arb_poly([])) for j in range(ORDER+1)]
        bernstein = [sum((shifted[j]*(arb(comb(i,j))/comb(ORDER,j))
                          for j in range(i+1)), arb_poly([])) * ((-1)**k)
                     for i in range(ORDER+1)]
        threshold = (1+arb(1)/MIN_M)*difference_error(s,vhi)
        for i in range(32):
            interval = (arb(i)/32).union(arb(i+1)/32)
            assert all(b(interval)>threshold for b in bernstein),(s,k,i)


def verify_order():
    scale4 = (1+Fraction(1,MIN_M))**5
    for s in range(4):
        for lag in (1,2,3):
            other = (s+lag)%4
            for k,(a,b) in enumerate(windows(s)):
                c,d = windows(other)[k]
                if other>s:
                    assert b<c
                    if k+1<RANKS:
                        assert d<windows(s)[k+1][0]
                else:
                    assert d<a
                    if k+1<RANKS:
                        assert b**4*scale4<windows(other)[k+1][0]**4
        assert windows(s)[-1][1]**4 * scale4 < (windows(s)[-1][1]+1)**4
        for k in range(RANKS-1):
            assert windows(s)[k][1]**4*scale4 < windows(s)[k+1][0]**4


def certify():
    verify_order()
    rows = coefficient_polynomials()
    results = []
    for s, row in enumerate(rows):
        verify_displacement(row,s)
        pending = [(Fraction(0),Fraction(1))]
        signs = [signed_cut(row,s,x,(-1)**(j+i)) for j,pair in enumerate(windows(s)) for i,x in enumerate(pair)]
        slabs = []
        while pending:
            a,b = pending.pop()
            steps, failed = check_slab(row,s,signs,a,b)
            if steps is None:
                if b-a <= Fraction(1,4096):
                    raise ArithmeticError((s,a,b,failed))
                mid = (a+b)/2
                pending.extend([(mid,b),(a,mid)])
            else:
                slabs.append([str(a),str(b),steps])
        results.append(dict(residue=s,windows=[[str(a),str(b)] for a,b in windows(s)],
                            disk_x=str(windows(s)[-1][1]+1),slabs=slabs))
        print(s,len(slabs),flush=True)
    return results


if __name__ == '__main__':
    result = certify()
    Path(__file__).with_suffix('.json').write_text(json.dumps(dict(min_m=MIN_M,
        retained_degree=ORDER, cauchy_radius=RADIUS, ranks=RANKS,
        same_residue_displacement_y_slabs=32, certified_lags=[1,2,3,4], rows=result),indent=2)+'\n')

## effective_inner.md

# An explicit interval free of negative real zeros in every row

Let $r+r^2+r^3/2=n$, $s=(15/r)^{1/3}$, $d=1-s/5$, and $c_*=3/(2e)$. For each integer $n\ge1$,
$$
  P_n(-x)>0,\qquad 0\le x\le \tfrac32 d e^{-d}\, r e^{-r}.
$$
For $n\le2004$ the stronger upper endpoint $c_* r e^{-r}$ works. For $n\ge2000$ the displayed coefficient differs from $c_*$ by at most $c_* e^{1/5}(15/r)^{2/3}/50$. This locates the edge to one side on its natural scale. It gives a real interval, without a claim about complex zeros inside the corresponding disk.

## Real saddle

Put $a(R)=R+R^2+R^3/2$, $A(z)=z+z^2/2+z^3/6$, $B=e^z-1-A$, and $F=A-xB$. For $n\ge2000$, $r>15$ and $4/5\le d<1$. Since $a(r+d)-a(r)\ge(3/2)d r(r+d)\ge x(r+d)e^{r+d}$, continuity gives $R\in[r,r+d]$ with $F_1(R)=n$, where subscripts denote powers of the Euler derivative. Put $\beta=xe^R/R\le 3d/2$ and $v=F_2(R)/R^3$. The identity
$$
 v=(1+x)(3/2+2/R+1/R^2)-\beta(1+1/R)
$$
and $F_2\le A_2$ give $0.3s\le v<1.64$.

On the coefficient circle set $L=(R^3v)^{1/2}$, $y=L\theta$, $H=F(Re^{i\theta})-F(R)-in\theta$. The sign of $P_n(-x)$ is the sign of $\int_0^{\pi L}\Re(e^H)\,dy$. In the following estimates every terminating decimal denotes its exact rational value.
$$
 |\Im H|\le0.56y^3,\qquad
 \Re H\ge-y^2/2-0.07y^4,\qquad
 \Re H\le-0.42y^2\quad (0\le\theta\le\sqrt{s}/5).
$$
For the first use $|\sin t-t|\le |t|^3/6$ and add the third moments of $A$ and $xe^z$. The constant is bounded by
$$
 \frac{(4.5+4/R+1/R^2)/R+\beta(1+3/R+1/R^2)}
 {6\sqrt{Rv^3}},
$$
where $Rv^3\ge15(0.3)^3$. For the lower real bound the fourth-order remainder of $\cos t$ costs only the negative part, of fourth moment at most $\beta R^5(1+6/R+7/R^2+1/R^3)$. Use $Rv^2\ge15(0.3)^2$. For the upper real bound only the $A$ fourth moment costs anything; it is $(13.5+8/R+1/R^2)R^3$. Use $\theta^2\le s/25$ and $v\ge0.3s$.

For $\sqrt{s}/5\le\theta\le\pi/3$ the loss $A(R)-\Re A(Re^{i\theta})$ from the cubic alone is at least $0.029sR^3\ge R^2/4$, by $1-\cos t\ge t^2/2-t^4/24$ at $t=3\sqrt{s}/5$. Up to $5\pi/6$ the quadratic term then gives $R^2/4$, and on the final arc the cubic gives $R^3/6$. The negative part adds at most $2\beta R\le3R$, hence $\Re H\le-R^2/20$ on the exterior.

The core runs beyond $y=4/3$ because $R^3s^2\ge15^3$. Its integrand is nonnegative up to $4/3$. On $[0,1]$ its integral exceeds $(1-0.56^2/2)(1-1/6-0.07/5)>2/3$. The intermediate tail has absolute integral at most $e^{-0.42(4/3)^2}/(0.84(4/3))<0.52$. The exterior costs at most $\pi\sqrt{1.64}R^{3/2}e^{-R^2/20}<1/50$, since this majorant decreases for $R\ge15$. The net positive margin exceeds $1/10$. For the deficit estimate use $1-(1-s/5)e^{s/5}=\int_0^{s/5}t e^t\,dt$.

## Finite rows and verification

For each $1\le n\le2004$ the checker constructs $P_n$ by the exact integer recurrence, brackets $r$ with strict inequalities on the increasing cubic, then forms $P_n(t-c_*r e^{-r})$ with outward-rounded Arb coefficients. Every coefficient is strictly positive, so $P_n(-x)>0$ on the full claimed interval, endpoints included. In these rows $d>0$ since $r(1)>1/2$, and $d e^{-d}\le1/e$.

[Independent numerical-inequality and finite-row checker](effective_inner.py) · [verification record](effective_inner.json) · [original model derivation](../../package1/api_runs/effective_inner_001/answer.md). The latter also proposes a two-sided first-root and next-row estimate for $r\ge10^{24}$. The checker verifies its rational Airy endpoint table. The two-sided estimate is recorded separately from the all-row result proved here.

## effective_inner.py

"""Independent checks of the explicit real-saddle and Airy inequalities."""
from collections import deque
from fractions import Fraction
from math import comb
from pathlib import Path
import json
from flint import arb, arb_poly, ctx, fmpz_poly
from scipy.optimize import brentq


def ball(a, b=1):
    return arb(a)/b


def small_rows(last):
    """Certify that the Taylor coefficients shifted by the limiting cutoff are positive."""
    x = fmpz_poly([0,1])
    rows = deque([fmpz_poly([1])], maxlen=4)
    c = 3/(2*arb(1).exp())
    for n in range(last):
        p = rows[-1]
        q = p+x*p.derivative()
        if n >= 1:
            q += n*rows[-2]
        if n >= 2:
            q += comb(n,2)*rows[-3]
        if n >= 3:
            q += comb(n,3)*x*rows[-4]
        rows.append(q)
        def moment(r):
            return r+r*r+r**3/2
        approx = brentq(lambda v: moment(v)-(n+1), 0, 2*(n+1)**(1/3))
        lo = arb(approx-1e-10)
        hi = arb(approx+1e-10)
        assert moment(lo)<n+1<moment(hi)
        r = lo.union(hi)
        shift = c*r*(-r).exp()
        shifted = arb_poly(q)(arb_poly([-shift,1]))
        assert all(v>0 for v in shifted.coeffs()), n+1


def real_saddle_constants():
    R = arb(15)
    v0 = ball(3,10)
    qmax = ball(3,2)
    assert R+R**2+R**3/2 < 2000
    assert ball(3,2)+2/R+1/R**2 < ball(164,100)
    third = (ball(9,2)+4/R+1/R**2)/R + qmax*(1+3/R+1/R**2)
    assert third / (6*(15*v0**3).sqrt()) < ball(56,100)
    fourth = qmax*(1+6/R+7/R**2+1/R**3)
    assert fourth / (24*15*v0**2) < ball(7,100)
    assert (ball(27,2)+8/R+1/R**2)/(24*25*v0) < ball(8,100)
    assert (ball(9,50)-ball(3,5)**4/24)/6 > ball(29,1000)
    assert ball(29,1000)*15 > ball(1,4)
    assert (R**3*v0).sqrt()/5 > ball(4,3)
    assert ball(56,100)*ball(4,3)**3 < arb.pi()/2
    core = (1-ball(56,100)**2/2)*(1-ball(1,6)-ball(7,500))
    mid = (-ball(42,100)*ball(4,3)**2).exp()/(ball(84,100)*ball(4,3))
    far = arb.pi()*(ball(164,100)*R**3).sqrt()*(-R**2/20).exp()
    assert core>ball(2,3) and mid<ball(52,100) and far<ball(1,50)
    assert core-mid-far>ball(1,10)


def airy_table():
    """Exact alternating bounds for f''=-u f with the two extremal initial slopes."""
    Q = Fraction
    for slope in (Q(1,3),Q(1)):
        for u in (Q(2),Q(5,2),Q(13,5)):
            for der in (False,True):
                sums=[Q(0),Q(0)]
                for l,c in [(0,Q(1)),(1,slope)]:
                    terms=[]
                    for j in range(10):
                        terms.append(c*l*u**(l-1) if der else c*u**l)
                        l += 3
                        c = -c/(l*(l-1))
                    sums[0] += sum(terms)
                    sums[1] += sum(terms[:9])
                low,high=sums
                assert low<=high
                if u==2:
                    assert (high < -1) if der else (low>Q(1,4))
                if u==Q(5,2) and not der:
                    assert high < -Q(1,5)
                if u==Q(13,5):
                    assert (high < -1) if der else (-Q(3,4)<low<=high<0)


if __name__ == '__main__':
    ctx.prec=192
    real_saddle_constants()
    airy_table()
    small_rows(2004)
    result=dict(finite_shifted_positive_through=2004,positive_real_saddle_from=2000,
                airy_series_endpoint_arithmetic='exact rational',precision_bits=ctx.prec)
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
    print(result)

## coefficient_ladder.md

# Coefficient inequalities for every block-size threshold

Let $P^{(j)}_n(t)$ count ordinary partitions of $[n]$ by the number of blocks of size at least $j$. For nonnegative coefficient rows write $U\preceq V$ if $u_i v_k\ge u_k v_i$ whenever $i<k$, with coefficients padded by zeros. For every integer $j\ge2$ and $n\le m\le n+j$,
$$
 (P^{(j)}_m)'\preceq P^{(j)}_n\preceq P^{(j)}_m .
$$
The maximum gap is sharp uniformly in the starting row. If $n=aj+j-1$ and $m=n+j+1=(a+2)j$, the derivative of the later row has degree $a+1$ while the earlier row has degree $a$. Their minor in columns $0,a+1$ is strictly negative.

In particular the ratios of successive coefficients of any single row decrease at least by the factorial factor. If $a_k=[t^k]P_n^{(j)}$, then $a_k^2\ge (1+1/k)a_{k-1}a_{k+1}$ for $k\ge1$. For $t>0$ the tilted expected number of large blocks in the larger row exceeds that in the smaller row by an amount in $[0,1]$.

Put $A=\sum_{1\le i<j}z^i/i!$, $B=e^z-1-A$, $c_h=[z^h]e^A$, and $f_k(h)=[z^h]e^AB^k$. The coefficient of $t^k$ is $h!f_k(h)/k!$. First, $c_h$ is log-concave. Set $\alpha_i=1/(i-1)!$ for $1\le i<j$, zero thereafter, so $hc_h=\sum_i\alpha_i c_{h-i}$. Under weights proportional to $\alpha_i c_{h-i}$, let $E_h$ be the expectation of $\alpha_{i+1}/\alpha_i$. Then
$$
 c_{h+1}/c_h=(1+hE_h)/(h+1).
$$
Given log-concavity up to index $h-1$, moving from the weights at $h-1$ to those at $h$ shifts mass rightwards: their reweighting ratio $c_{h-i}/c_{h-1-i}$ increases with $i$, and newly supported indices appear at the right. The quantity being averaged decreases with $i$ and never exceeds one. Thus $E_h\le E_{h-1}\le1$; the displayed ratio decreases with $h$. The base comparison is $c_2/c_1\le c_1/c_0=1$, also for $j=2$.

Convolution preserves log-concavity for nonnegative sequences with interval support by the order-two minors of their Toeplitz matrices and the Cauchy–Binet identity. Since $[z^l]B$ is log-concave on $l\ge j$, each $f_k$ is log-concave in $h$. Consequently
$$
 R_k(h)=f_{k+1}(h)/f_k(h)=\sum_{l\ge j}[z^l]B\,f_k(h-l)/f_k(h)
$$
increases on its domain. This gives $P_n^{(j)}\preceq P_m^{(j)}$. On the other hand $R_k(m)$ is a weighted average of $R_{k-1}(m-l)$, with weights $[z^l]B\,f_{k-1}(m-l)$. Each positive-weight argument is at most $n$ when $m\le n+j$, giving $R_k(m)\le R_{k-1}(n)$. Clearing factorials proves the derivative inequality. Adjacent coefficient inequalities give the general minors by transitivity of ratios; endpoints follow from interval support. For the mean comparison the derivative inequality implies $P_m^{(j)}\preceq tP_n^{(j)}$. Tilting the three coefficient rows by $t^k$ preserves their order, and hence the order of their means.

This result controls coefficients in the middle of every row even where the sign of the polynomial at its predecessor's negative zeros is unknown. The [API derivation for threshold four](../../package1/api_runs/algebraic_induction_001/answer.md) also gives an upper bound on how many residues in a root-induction step can have the wrong sign, conditional on previous interlacing.
