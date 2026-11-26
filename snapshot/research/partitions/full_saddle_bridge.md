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
