Act as referee of a claimed eventual proof of a public open combinatorics conjecture. We only claim all sufficiently large n for j=4, not all n. Hunt for fatal errors, missing regimes, sign errors or uniformity gaps in the three new core notes below. Provide precise derivations or a repair where warranted. Existing input lemmas you may assume: the pure B saddle has a unique global conjugate dominant pair on each fixed circle, H negative real, Re K negative, Im B>0 and psi strictly increasing from -pi/4 to 0; in the small radius regime the two-saddle and centered derivative errors are o(1)+O(exp(-c n rho)). The fixed outer reciprocal-polynomial convergence and fixed inner Airy/adjacent-spacing theorems as specified in the notes have separate proofs. Global symbols: A=z+z²/2+z³/6, B=exp(z)-1-A, P_n=n![z^n]exp(A+tB). On bounded complex angular coordinates v, inner E relative to real constants equals r S(w)+T(v)+O(1/r) with fixed derivative error; remote arcs outside sufficiently large |v| have arbitrarily large exponential suppression. Compare phases as *real* numbers, not modulo pi. Assess the all-roots and interlacing statements separately. Do not assume the bridge or exact index have previously been established.

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

All phases use the principal argument of a curvature with positive real part, and principal log of the saddle in the right half-plane. At bounded p near P, x/n stays on a compact positive interval. The exact saddle differs by O(1/n) from the bulk saddle at the *same* x/n. This follows by the analytic implicit function theorem, since the pure saddle is nondegenerate and near Im z=pi at large fixed p; uniqueness in A also identifies the branch by perturbing the pure solution. The latter has Im z close to pi by its stationary equation with Re H<0 and the large-radius core of density_one.md. The leading n-order action is stationary, so its change is O(1/n). Hence G differs from n psi+phi by o(1) as a real number. The normalized curvatures converge, and both formulas have positive real normalizations.

At p in a fixed-width overlap around r-M (use the estimates of A down to M-2), c ranges in a compact interval. More explicitly, y tends along subsequences to the unique solution of y cot y=p-r in (0,pi) for any given limit of p-r: the exact stationarity equation in bounded local coordinates limits to S'(w)=0; its imaginary part determines c=(3/2)y exp(-u)/sin y. Here c is bounded above and below from lambda comparable to N/p and p-r bounded. The limiting saddle is nondegenerate, uniformly on this compact overlap. For the same c at finite r, the exact-saddle angular coordinate and the reduced saddle (using its own circle R=r+u) agree in z up to O(1/r), by the analytic derivative expansion and inverse function theorem. Evaluating the reduced S at a point O(1/r) away changes r S by O(1/r); T tends to w*², and D/(R² r) tends to S'' at the reduced saddle, with vanishing error. Real normalizing constants from the angular representation do not affect phases. This gives the second unwrapped phase agreement. Equivalently both upper actions can be evaluated as analytic functions of z near r+w*. Interpolate the two real phase functions continuously in each overlap; the change is uniformly o(1).

The sine test is needed only at an actual zero of I. On an overlap either native sine formula suffices there, since its I term vanishes, its remaining normalization is positive, and its phase differs by o(1) from the interpolated one.


# All sufficiently large rows are strictly real-rooted and interlace

**Theorem (research manuscript).** Let P_n(t) enumerate the ordinary set partitions of [n] by the number of blocks of size at least four. There exists N such that for every n>=N all floor(n/4) zeros of P_n are simple and negative, and the zeros of P_n and P_(n+1) strictly interlace in the prescribed direction. This is an existential threshold. Its value has not been bounded numerically. The finite verification through 1000 cannot yet be joined to it to prove the conjecture for every n.

This note is the counting step in the proof, using [the angular saddle certificate](density_one.md), [fixed outer zeros](edge_theorem.md), [absolute outer numbering](outer_index.md), [fixed inner zeros](airy_theorem.md) and [the two transition estimates](full_saddle_bridge.md). Below, left to right means the usual increasing order on the negative real axis.

## Two cuts of known rank

Let m=floor(n/4), s=n-4m. Fix large integers J and H, independent of n. On the outer side take the positive radius rho=(20 sqrt(2)/n)(J+s/4)pi at t=-n tau(rho). Exactly J roots lie to its left, and its unwrapped upper-saddle phase tends to (-m+J)pi after subtracting this n-dependent integer multiple of pi, by outer_index.md. More explicitly, the difference between the phase and (-m+J)pi tends to zero. The sign at the cut is (-1)^(m-J), by the fixed outer-root count or by the cosine test.

On the inner side use r+r²+r³/2=n and set y=[2pi(H+1/4)/r]^(1/3). Put u=y cot y, c=(3/2)y exp(-u)/sin y and t=-c r exp(-r). Its phase is
G=(3/2)r y(u-1)+2uy-arg(1-u-iy)/2.
Indeed Im S(u+iy)=(3/2)y(u-1). Since u=1-y²/3+O(y⁴), this phase tends to -H pi for fixed H. Its Airy coordinate b r^(2/3)(c/c₀-1), with c₀=3/(2e) and b=(3/2)/(3/4)^(1/3), tends to S_H=[(3pi/2)(H+1/4)]^(2/3). The standard indexed Airy-zero asymptotic d_j=[(3pi/2)(j-1/4)]^(2/3)(1+O(j^(-2))) places S_H strictly between d_H and d_(H+1) for large H. The fixed-edge theorem therefore gives exactly H roots between this cut and zero for all sufficiently large n and gives sign (-1)^H at the cut. Standard Airy reference: https://dlmf.nist.gov/9.9.iv .

## Degree saturation

On the interval from the first cut to the second, use the composite unwrapped phase G(t) in full_saddle_bridge.md. Start with the pure B saddle n psi+phi, move to the exact saddle, then to the inner phase. Each joining interval has phase error o(1) as a real number. Choose J,H large enough, then n sufficiently large, so both sign tests throughout this interval have normalized error <1/8 (on overlaps one may absorb the phase comparison error). On the outer part the sine weight is also admissible directly: it is smooth, equals -i on the upper saddle, and has uniformly bounded angular derivatives since theta is separated from 0 and pi up to the fixed outer-middle seam. The outer error O(exp(-cJ)) and inner error O(H^(-1/2)) can both be made arbitrarily small. The other compact and middle ranges have errors tending to zero for those fixed choices.

Along the interval G goes from (-m+J)pi+o(1) to -H pi+o(1), continuously. For each successive interior integer multiple of pi take its first hitting time after the initial cut. These points appear in increasing order; append the two cuts as extremal points. The signs alternate at these m-J-H+1 points by the cosine estimate and endpoint signs. There are therefore at least m-J-H distinct intervening real roots. Together with the two edge counts this gives m distinct negative roots, exactly the degree. Each is simple and there are no other roots, real or complex. This argument does not require monotonicity of the interpolated phase.

## Next-row signs

Let t_1<...<t_m be the zeros. At a zero in the interval going from level l pi to (l+1)pi, the sine in the second sign test has sign (-1)^l. To see this without assuming monotonicity, restrict first to the part between the last visit to the left level preceding the first visit to the right level. The coefficient has opposite signs at those endpoints and the degree count permits only one zero in the larger interval. For the first or last interval an endpoint phase can differ from its designated integer by o(1); one may equivalently bracket the zero using the interior levels (l+1/6)pi and (l+5/6)pi, choosing the first hitting of the latter and the last hitting of the former before that. The signs there are opposite, and on this shorter interval sin G has sign (-1)^l and magnitude >=1/2. Thus the companion estimate gives sign P_(n+1)(t_k)=(-1)^(m-k+1), because l=-m+k-1. The positive scalar normalizations and the subtracted multiple of P_n disappear in this sign test.

The same signs hold at the J outer and H inner roots by the fixed-window interlacing theorems, taking one extra root where needed. At the outer edge the degree jump reverses which row starts, exactly as specified in edge_theorem.md. At the inner edge the same-index (rank from zero) next-row magnitude is smaller than the present magnitude, and the next-larger rank in that next row lies to its left. The positive value at zero fixes the signs from that side. Thus P_(n+1) changes sign in every (t_k,t_(k+1)) and between t_m and 0. If its degree equals m, these m intervals exhaust the roots. If its degree is m+1, its leading-coefficient sign at minus infinity also forces one root to the left of t_1. This gives strict interlacing for every sufficiently large adjacent pair.

The finite computation and the existential theorem leave open the exclusion of exceptional intermediate rows. A proof for all n needs an explicit reachable N or an argument applying independently of the asymptotic threshold.
