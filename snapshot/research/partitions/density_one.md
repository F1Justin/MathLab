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
