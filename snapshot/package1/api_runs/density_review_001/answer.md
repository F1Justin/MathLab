**Referee verdict:** I find no counterexample to the stated density-one theorem or to the bulk adjacent-row interlacing claim. The zero count has the right constant \(1/4\), the phase runs in the claimed direction, and using the **same** argument \(t=-n\tau\) for both rows gives the claimed interlacing offset. The middle-radius argument is a computer-assisted part of the proof: I have audited the logic of the supplied program, not independently executed it. On an ordinary assertion-enabled run with the stated outward-rounded Arb semantics, success of that program suffices. The JSON alone would not suffice.

There are a few points to clarify in the exposition, especially about the bisections and the phase check. They do not appear to be mistakes in the theorem. In contrast, extending the compact saddle estimate to *all* zeros by simply sending its endpoints to \(0\) and \(\infty\) would be a mathematical mistake.

## 1. Audit of the circle minima

The two useful angular identities are
\[
\partial_u\Re B(re^{iu})=-\Im H(re^{iu}),\qquad
\partial_u^2\Re B(re^{iu})=-\Re K(re^{iu}).
\]
Thus \(\Re K<0\) means **convexity** of \(\Re B\), and will mean **negative** real curvature for the exponential rate \(-\tau B\).

**Small radii.** The bounds on the three tails check out. For example the unweighted tail starts at \(r^2/30\), with successive ratio at most \(r/7\); the \(k^2\)-weighted tail starts at \(36r^2/30\), with ratio at most \(7r/36\). The stated bounds have slack at \(r=1/16\). Outside the two upper-semicircle neighborhoods the loss in the leading cosine is at least \(1-\cos(\pi/8)\), larger than the two possible perturbation errors. Of the two neighborhoods, the one at \(3\pi/4\) loses to the test point \(\pi/4\): the \(r/5\) term has cosine \(>1/4\) in the former and \(-1/\sqrt2\) at the latter. This is an order-\(r\) gap against an order-\(r^2\) tail in the normalized function.

In the surviving neighborhood the asserted upper bound on \(24\Re K/r^4\) is strictly negative, so there cannot be two minima there. Also \(\Re H<0\) by the first-power weighted bound. Finally it is important to test \(\Im B\) **at stationarity**, not by discarding the perturbation of the angle in \(\Im z^4\). At stationarity,
\[
\Im B=\Im(B-H/4),\qquad B-H/4=-z^5/480+O(z^6).
\]
The quantitative version in the text works: in the normalization used there the positive contribution is at least \(r/80\), against a tail at most \(r^2/30\). Expanding \(\Im H=0\) gives
\[
\theta=\frac{\pi}{4}-\frac{r}{16\sqrt2}+O(r^2),\quad
H\sim-r^4/6,\quad \Im B\sim r^5/(480\sqrt2).
\]

**Middle radii.** I checked the following possible failure modes of the certificate.

* The small-radius kernel encloses \(24F/r^4\), for \(F=B,H,K,B-H/4\). The powers in the Horner polynomial are powers of \(z\), and the missing leading angular factor \(e^{4iu}\) is indeed restored. The first omitted \(K\)-term is bounded in modulus by \(24\cdot35^2\,4^{31}/35!\), and the successive ratio is at most \(4\cdot36/35^2<1/2\). This dominates the other three tails. Adding the error to **each component** after the rotation is valid.
* The large-radius kernel encloses \(e^{-r}F\). In particular `bprime` is \(e^{-r}B'\), and the formula for `K` is \(e^{-r}(zB'+z^2B'')\). All the comparisons use the same positive normalization at a given radius.
* The computations with ordinary floats propose cuts, not signs. A proposed endpoint can be regarded as the binary number actually produced. The Arb intervals enclose the boxes between those endpoints; a subdivision reuses the same cut on both children. On an accepted slab the exterior lower bound exceeds the trial upper bound. This is **stronger** than the necessary comparison at the same \(r\), so interval dependency here can cause a failed check, not a spurious success.
* The two root tightenings are valid, but are **not two ordinary bracket-preserving bisections**. In the first search only the retained `lower` must have certified positive \(\Im H\); in the second only the retained `upper` must have certified negative \(\Im H\). An inconclusive sign can discard part of a *search interval* without invalidating either retained endpoint. Since \(\partial_u\Im H=\Re K<0\) throughout the original core, the root for every radius in the slab lies between those retained endpoints. This explains why what looks like a bisection bug is not one.
* There is a small linkage needed for `phase(r)`. Opposite endpoint signs in that routine alone do not prove it has enclosed the **global-minimum** stationary point. For the three radii actually printed, the linkage is available: each is an endpoint of an accepted slab, its `approximate_q` was used to build that slab's core, and the core margin is at least \(1/128\), much larger than \(10^{-9}\). Thus the phase bracket is inside a certified uniqueness core. I would state or assert this inclusion explicitly. I would not use `phase(r)` as a stand-alone certificate at arbitrary new radii without such a check.

Together the endpoint signs, convexity, and exterior comparison prove exactly what is needed on each whole slab. Uniqueness identifies the branch across slab boundaries. The reported phase fraction, about \(0.8270862\), is consistent with \(4(\psi_{32}-\psi_1)/\pi\); it is a useful extra check, **not** how density one is proved.

**Large radii.** The comparison with the \(y=\pi\) test point survives the polynomial error on both sides. In particular
\[
x_\pi-x_{2\pi}=\frac{3\pi^2}{x_\pi+x_{2\pi}}\ge \frac{3\pi^2}{2r}.
\]
Hence the exponential gap for the right-hand region \(y\ge2\pi\) exceeds \(e^{r-1/5}/(2r)>2M\). In the low-\(y\) exterior region one uses \(e^{-1/5}>1/\sqrt2\), again with ample room for \(2M\). The left half-plane comparison is easier.

In the remaining core, the tight end of the cosine check is \(5\pi/4+2(1/8)<4\pi/3\), so both exponential contributions to \(\Re[(z+z^2)e^z]\) have the required negative sign. They dominate the polynomial terms. This proves strict convexity there, and the exterior comparison places the minimum in its interior. Similarly \(\Re H\le-r e^{r-1}/3\). At stationarity \(H\) is real, so
\[
\Im B=\Im(H/z-z^3/6)\ge \frac{-H}{r}\sin u-r^3/6>0.
\]
I find no missing competing arc in this argument. The core also gives \(\theta=O(1/r)\), and the same identity for \(B\) gives \(B/H=1/z-z^3/(6H)=O(1/r)\).

## 2. Monotonicity and phase endpoints

Write \(z=r e^{i\theta(r)}\) on the upper branch. Nonzero \(\Re K\) gives the local implicit function, and uniqueness gives the global one. Differentiating \(H\) along it gives
\[
rH'=K(1+ir\theta'),\qquad
r\theta'=-\frac{\Im K}{\Re K},\qquad
rH'=\frac{|K|^2}{\Re K}<0.
\]
Thus \(\tau=-1/H\) is positive and strictly **decreasing** in \(r\), from infinity to zero.

To avoid overloading the phase notation, let
\[
\psi(\tau)=\Im[-\tau B(z)-\log z],\qquad \Psi(r)=\psi(\tau(r)).
\]
In the derivative of the bracket the coefficient of \(dz/d\tau\) vanishes because \(\tau H=-1\). Therefore \(\psi'(\tau)=-\Im B(z)<0\), whereas \(\Psi\) is strictly **increasing**. Directly,
\[
\Psi(r)=\frac{\Im B(z)}{H(z)}-\theta(r).
\]
At zero \(B/H\to1/4\) is real and \(\theta\to\pi/4\); at infinity both \(B/H\) and \(\theta\) tend to zero. Thus the total phase excursion is exactly \(\pi/4\). No choice of the Gaussian square root or of the prefactor phase enters this calculation.

## 3. Saddle estimate, exact bulk count, and interlacing

The starting point is
\[
P_m(t)=m![z^m]\exp(A(z)+tB(z)),\qquad \deg P_m=\lfloor m/4\rfloor .
\]
At \(t=-n\tau\), the angular integral for row \(n+j\), \(j=0,1\), has outside factor \((n+j)!r^{-n}/(2\pi)\), exponent \(nf\), and amplitude \(e^A z^{-j}\), where
\[
f=-\tau B(re^{iu})-iu,\quad
f'=-i(\tau H+1),\quad f''=\tau K .
\]
In particular the upper circle minimum is a saddle of the **complex** exponent, not just a maximum of its real part.

On a fixed compact radius interval the two maxima are separated, have uniformly negative real curvature, and have a uniform rate gap outside their neighborhoods. Rescaling \(u-\theta=v/\sqrt n\) gives the complex Gaussian with factor \(1/\sqrt{-\tau K}\), with square root of positive real part. The Taylor error on bounded \(v\) tends uniformly to zero and the local modulus is dominated by a Gaussian. The lower saddle is conjugate. Consequently, with
\[
\begin{split}
D_{n,j}&=\frac{2(n+j)!\,r^{-n-j}e^{n\Re f(\theta)}}{\sqrt{2\pi n}}\,
 \left|\frac{e^{A(z)}}{\sqrt{-\tau K(z)}}\right|,\\
h_j&=n\psi+\arg\!\left(\frac{e^{A(z)}}{\sqrt{-\tau K(z)}}\right)-j\theta ,
\end{split}
\]
the result is \(P_{n+j}(-n\tau)/D_{n,j}=\cos h_j+o(1)\). This is an **additive** uniform error after normalization, not a relative error at a cosine zero.

For the actual \(\tau\)-derivative, differentiation of the coefficient introduces \(-nB\). Evaluating this new integral, rather than differentiating the error above, gives
\[
\frac{\partial_\tau P_{n+j}(-n\tau)}{nD_{n,j}}
=-\Re B\,\cos h_j+\Im B\,\sin h_j+o(1).
\]
Both the sign of the sine term and the absence of a derivative of \(D_{n,j}\) are correct.

Here is why the result is an **exact bulk count up to boundary cells**, not just a sign-change lower bound. The phases decrease in \(\tau\) for large \(n\). Outside fixed small neighborhoods of \(\pi/2+k\pi\) the first estimate excludes zeros. Choose the neighborhood half-width \(\delta\) so that \(\min\Im B\cos\delta>\max|\Re B|\sin\delta\) on the compact interval. Within each neighborhood the derivative has fixed nonzero sign. Opposite signs at the two ends then give exactly one simple zero per complete neighborhood, and at most one in each cut neighborhood. The phase of each such zero is \(\pi/2+k\pi+o(1)\) uniformly.

In increasing \(t\), both phases increase, with \(h_1=h_0-\theta\). Measured in \(h_0\)-coordinates, the row-\(n+1\) zero at index \(k\) is therefore at \(\pi/2+k\pi+\theta+o(1)\), between successive row-\(n\) zeros. This argument needs \(\theta\) bounded away from **both** 0 and \(\pi\), which is true on the compact interval. It also explains why rescaling the argument separately for row \(n+1\) without correcting the phase would be unsafe.

For \(0<r_1<r_2<\infty\), the count per row in the corresponding interval is consequently
\[
\frac n\pi\big(\Psi(r_2)-\Psi(r_1)\big)+O(1).
\]
One chooses the compact interval with excursion **strictly greater** than \((1-\eta)\pi/4\) before taking \(n\) large. The slack absorbs the \(O(1)\); there is no residue-class issue. This proves the stated quantifiers. It does **not** say a single fixed compact interval contains all but \(o(n)\) zeros: each fixed interval misses a positive part of the limiting phase excursion.

The limiting-measure statement follows too. In the coordinate \(x=t/n=-\tau\), the limiting mass between the two radii is \(4(\Psi(r_2)-\Psi(r_1))/\pi\), equivalently with density \(4\Im B(z)/\pi\) in \(x<0\). These masses exhaust one. Testing on a large fixed compact interval and bounding the remaining contribution by its mass times the sup norm gives weak convergence also for the complex empirical measures. It gives no bound on the distance of an individual outlier from the real axis.

**Editorial versus substantive issues.** I would distinguish \(\psi(\tau)\) from \(\Psi(r)\), explain the one-sided bisection invariants, and document the phase-bracket/core inclusion. Also, in the short small-radius perturbation proof, “derivative bounded away from zero off those neighborhoods” requires neighborhoods of *all* leading critical points, including minima; if referring just to the four maxima, use a *value gap* instead. None changes the density-one conclusion. Counting only cosine sign changes without the derivative estimate, treating SciPy's first root as proof of dominance, or using the compact \(o(1)\) error at moving endpoints would be substantive gaps. The supplied density-one argument need not do any of those things.

## 4. What could settle the exceptional zeros?

It is plausible that a **matched edge analysis** could extend the result, but implausible that the present two-saddle estimate works unchanged. There are identifiable obstructions at *both* ends.

* **Far negative end:** the losing pair near \(\pm3\pi/4\) has a rate disadvantage of order \(r\) in \(-\tau\Re B\), hence only order \(nr\) in the exponent. At \(r\asymp1/n\), or \(|t|\asymp n^5\), it cannot be discarded. There is a concrete residue-dependent model to try here. Put \(n=4m+s\), \(0\le s<4\), and \(p_k=[t^k]P_n\). For fixed \(j\),
  \[
  \frac{p_{m-j}}{p_m}\sim
  \left(\frac{24m^5}{5^4}\right)^j\frac{s!}{(4j+s)!}.
  \]
  Indeed, after extracting \(z^{4(m-j)}/24^{m-j}\) from \(B^{m-j}\), one needs the coefficient of \(z^{4j+s}\) in \(e^A(1+z/5+O(z^2))^{m-j}\); its leading term is \((m/5)^{4j+s}/(4j+s)!\). Thus in the reversed coordinate \(w=(24m^5/5^4)/t\) the candidate normalized edge function is \(s!\sum_{j\ge0}w^j/(4j+s)!\). These are explicit exponential sections; for example the \(s=0\) function at \(w=-4x^4\) is \(\cosh x\cos x\). This gives actual zero locations to compare against. Fixed-coefficient convergence alone is not enough: one needs error control for zeros, adjacent residues, and an overlap with the oscillatory region.
* **Near zero:** \(\theta\to0\), so even the phase margin for adjacent interlacing disappears. Moreover \(e^{A(z)}\) cannot be treated as a uniformly slow prefactor out to \(r=\infty\). At \(t=0\) the natural positive saddle solves \(\rho A'(\rho)=n\), giving \(\rho\sim(2n)^{1/3}\), rather than the infinite radius of the bulk parametrization. A concrete approach is to retain the **full** saddle equation \(zA'(z)+tH(z)=n\). On the positive axis a possible turning point is visible from \(-t=(rA'(r)-n)/H(r)\) for \(r>\rho\): the right-hand side is positive and goes back to zero. A coalescing-saddle analysis would require proving which saddles dominate, controlling the transition, and matching with errors smaller than the adjacent-row zero separation. An Airy approximation cannot just be assumed from the bulk formula.

There is also a precise **algebraic alternative** that would bypass both edge limits. Differentiating the exponential generating function in \(z\) gives the exact recurrence
\[
P_{n+1}=P_n+tP_n'+nP_{n-1}+\binom n2P_{n-2}+\binom n3 tP_{n-3}.
\]
A sufficient Sturm induction is to prove, at every simple negative root \(\xi\) of \(P_n\),
\[
P_{n+1}(\xi)/P_n'(\xi)<0 .
\]
With positive constant and leading coefficients and the known degree increment, these signs force one root in every required gap, one to the right of the last root, and one to the left of the first when the degree increases. Equivalently, a route via the real-stability/interlacing theorem would be to prove real stability of \(P_{n+1}(t)+uP_n(t)\) and exclude common roots; that would give strict interlacing of the full rows. The recurrence is a concrete starting point, **not** already a sign proof: the delayed-row evaluations at \(\xi\) do not have the needed combined sign just from positivity of their coefficients.

Thus the bulk proof does what its title says. Resolving the last \(o(n)\) needs either new uniform edge theorems with matching and exact counting, or a structural sign/interlacing theorem for these polynomials.
