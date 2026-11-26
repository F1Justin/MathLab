**Referee verdict:** Conditional on the stated inputs, I find the eventual all-roots statement valid, and I also find the eventual strict interlacing statement valid. The latter needs the weighted saddle estimates and the fixed inner adjacent-row input; it does not follow just from the degree saturation argument. I find no missing \(n\)-dependent regime between the two cuts.

There are a few points I would tighten in a proof. In particular, a *raw* normalized centered-derivative amplitude need not have bounded angular derivatives at small radius; \(H<0\) alone does not identify the correct saddle at the outer-middle seam; and compact Airy convergence alone would not justify excluding roots all the way from a fixed Airy window to \(t=0\). There are repairs or ways around all three points.

## 1. Absolute outer index

First, strict positivity of \(\psi'\) on a compact bulk interval need not be inferred just from strict increase. It follows quantitatively from the saddle conditions. With a dot denoting \(d/d\log \rho\), the reality of \(H\) gives
\[
0=\Im\big[K(1+i\dot\theta)\big],\qquad
\dot H=\frac{|K|^2}{\Re K}<0.
\]
Thus \(\tau'<0\), and stationarity gives \(\psi'=-\tau'\Im B>0\). These facts give both the orientation in \(t\) and, with the small-\(\rho\) expansions, the asserted eventual monotonicity of \(W_n\) on \((0,R]\).

The constants at the outer edge check out. For example,
\[
B-H/4=-z^5/480+O(z^6)
\]
gives the stated leading \(\Im B\) since \(H\) is real and \(\theta\to\pi/4\). The phase is
\[
W_n=-s\pi/4+\frac{n\rho}{20\sqrt2}+O(n\rho^2+\rho).
\]
At the proposed cut it tends to \(J\pi\), in the sense of difference tending to zero. Also
\[
-n\tau(\rho_J)\sim-\frac{3n^5}{320000 X^4},\qquad
\frac{24m^5}{625(-n\tau(\rho_J))}\ \longrightarrow\ -4X^4,\qquad
X=(J+s/4)\pi,
\]
where one may take residue classes separately. In particular, the number \(J\) at the cut is **not** obtained by applying the proposed index theorem with \(n\rho_J\to\infty\); that hypothesis fails for fixed \(J\). It is obtained independently from the reciprocal polynomial. The given strict inequalities \(x_{s,J}<X<x_{s,J+1}\) have the correct direction: smaller reciprocal modulus means farther to the left in \(t\) for negative roots. For the simplicity and reality assertion from compact convergence, use disjoint small disks about the simple limiting zeros, in addition to the cut-radius circles. One zero counted with multiplicity in a conjugation-invariant disk about a real zero must be simple and real.

**Centered derivative uniformity.** The error bound itself is an allowed input. If explaining it by bounded amplitudes, one should specify the amplitude being used. For example, \((B(z')-\Re B(z_\star))/\Im B(z_\star)\) on the circle does *not* have uniformly bounded angular derivatives by a direct size estimate: its numerator contains a term of order \(\rho^4\) while its denominator is of order \(\rho^5\). There is an exact regularization. Write \(\langle f\rangle\) for insertion of \(f\) into the coefficient integral, \(z_\star\) for the upper pure saddle, and \(F=B-H/4\). Integration of an angular derivative gives
\[
\langle h-n\tau H-n\rangle=0.
\]
Consequently
\[
\langle B-\Re B(z_\star)\rangle
=\left\langle F-\Re F(z_\star)+\frac{h}{4n\tau}\right\rangle.
\]
Now \(F\) and its fixed angular derivatives are \(O(\rho^5)\), and \(h/(n\tau)=O(\rho^5/n)\), with the same derivative bounds. This version really does have bounded normalized amplitudes down to \(\rho=0\). Its principal centered insertion at the upper saddle after normalization is \(i+O(1/n)\).

With the stated estimates, the cell argument proves the exact index. Choose the phase-neighborhood width first, then \(J\) large, then \(n\) large. Outside the neighborhoods there are no zeros; a complete neighborhood has opposite endpoint signs, and at every zero in it the centered derivative gives a nonzero actual derivative of one prescribed sign. The latter is enough for uniqueness: two simple crossings in the same direction cannot be consecutive. One need not claim that the *uncentered* polynomial is monotone throughout a neighborhood. The fixed starting count is \(J\), and the first subsequent neighborhood is centered at \((J+1/2)\pi\) in \(W_n\). This proves the floor formula, including the offset. A sequence with \(n\rho_n\to\infty\) is eventually beyond the fixed cut, and at diverging ranks in complete cells the local phase error goes to zero, not merely to a \(J\)-dependent small constant.

For \(k\to\infty,\ k=o(n)\), bracketing with radii comparable to \(k/n\) first gives existence and \(\rho_{n,k}\asymp k/n\). The indexed expansion then gives
\[
\frac{n\rho_{n,k}}{20\sqrt2}
=(k-1/2+s/4)\pi+O(k^2/n)+o(1).
\]
The fourth root of \(3n^5/(320000|t_{n,k}|)\) differs from the left side by \(O(n\rho_{n,k}^2)\). This gives both the equivalent and the stated \(k=o(\sqrt n)\) absolute-phase refinement.

## 2. Uniform bridge estimates

**Middle range.** The choice of \(q\) controls two genuinely different errors: the displacement from \(y=\pi\), and the excess of the exponential envelope above the true saddle height. The argument equation near \(\pi\) has derivative \(1+O(p^{-1}+p^2 e^{-p}+p^2/N)\); here \(N\ge M h'(p)\). Its root satisfies \(|y-\pi|=O(q)\), using \(\lambda\asymp N/p\) and \(p^2e^{-p}=O(1/p)\). If \(f\) denotes the complex logarithmic derivative of \((h-n)/H\), then \(\Re f<0\) and
\[
(\log x)'=\frac{|f|^2}{\Re f}<0
\]
along the branch, as required. In particular there is no reversal or uncovered \(x\)-interval caused by parametrizing with \(p\).

The height comparison works even if \(q\) is only small, not tending to zero. The envelope error at the saddle is
\[
\lambda(1+\cos y)=O(\lambda q^2),
\]
whereas the envelope loss by \(v=2\pi\) is bounded below by a constant times
\[
(1+x)p+\lambda/p=\lambda q .
\]
For the polynomial part this uses the order-\(p\) drop of \(\Re A\) over the indicated \(v\)-interval; the cubic term alone has this order of drop. For the exponential part \(\Re z'\) drops by order \(1/p\). Both comparisons are in the correct direction. On angles separated from zero, the possible polynomial gain is only \(O((1+x)p)\), by comparison with \(A(R)\), and the exponential envelope there is at most \(\lambda e^{-c p}\). On the bounded \(v\)-arc away from a fixed neighborhood of \(\pi\), the loss from \(-\cos v\) beats the \(O(q\lambda)\) allowance if \(P,M\) are chosen large *after* fixing this neighborhood.

Uniform negligibility follows because \(\lambda\to\infty\) uniformly and
\[
\lambda q\ \ge\ \max(p,\lambda/p)\ \ge\ \sqrt\lambda .
\]
In proving the first assertion about \(\lambda\), bounded \(p\) gives \(N\to\infty\), while unbounded \(p\) gives \(\lambda\gtrsim M p\). Thus even relative to the single-saddle scale, the polynomial losses from arc length, normalization and sine weight are harmless on the separated arcs.

In arclength the quadratic term is \(-D s^2/(2R^2)\). Near \(v=\pi\), the term with sign **plus** \(x(z'+z'^2)e^{z'}/R^2\) in the second derivative of \(E\) has negative real part of order \(\lambda\); the polynomial contribution is \(O(q\lambda)\). The third derivative is \(O(\lambda)\); the logarithm is linear in the angular coordinate here. Gaussian localization therefore gives the phase \(\Im E-\arg D/2\), uniformly. For the companion test the derivative of the inserted weight in arclength has modulus \(1/(R\sin\theta)=1/y\), uniformly bounded. Its value \(-i\) at the upper saddle gives \(+\sin G\), not \(-\sin G\).

**Inner range.** For compact \(y\)-intervals in \((0,\pi)\), the vertical-line maximum argument and the nondegenerate Gaussian are sufficient. In particular \(S'(w_*)=0\) and
\[
S''(w_*)=\tfrac32(1-u-iy),\qquad 1-u>0.
\]
For small \(y\), using the compact-interval Gaussian without modification would be a uniformity gap. The proposed deformation closes it. In fact if \(a=(3\delta-\delta^3)/6\), the leading real-part expression after division by \((3/2)d^2\) on the tilted ray is
\[
-\delta y-a(V-y)=-(\delta-a)y-aV .
\]
Both coefficients of loss are positive for \(\delta=1/2\), so the \(O(y^2+d^2)\) error can be absorbed uniformly, including at \(V=0\). At the connector, the limiting real derivative has leading term \((3/4)(\epsilon^2-(\Re w-1)^2)\); the original-line endpoint is the higher one. Its limiting gap follows from the *strict* inequality \(1-\cos\epsilon<\epsilon^2/2\). One can fix \(\epsilon\) first and then take \(y\) sufficiently small. Reflection joins the tilted pieces at a common point, so there is no unaccounted central endpoint integral.

In \(s=(V-y)\sqrt{ry}\), the real Gaussian bound is \(e^{-c s^2}\), the cubic exponent error is \(O(|s|^3/\sqrt L)\), and the sine weight changes from \(-i\) by \(O(|s|/\sqrt L)\). The cubic error need not be small on the whole rescaled arc: the bound
\[
|e^a-e^b|\le |a-b|\max(e^{\Re a},e^{\Re b})
\]
using the real-part estimates for both exponents suffices. The endpoint truncation at \(-\sqrt L\) costs \(O(e^{-cL})\). With the given analytic inner expansion and remote-arc bounds, this proves the required \(O(L^{-1/2})+o_r(1)\) accuracy. In particular the remote-arc factor \(O(R/y)\) is only polynomial here. The oriented Gaussian gives the principal \(1/\sqrt{S''}\): the multiplier \(1+i\delta\) in the angular tangent cancels the same factor in the Gaussian square root, with \(\Re[(1+i\delta)\sqrt{S''}]>0\). There is no extra constant phase from the tilt.

**Pure-saddle companion estimate.** This estimate is also uniform where it is used. If only an *unweighted* small-radius saddle formula is quoted, it is worth giving the reason it extends to the new weight, rather than deducing a weighted error from an unweighted integral error. The small-radius real angular exponent divided by \(n\), up to a constant and treating \(e^A\) as amplitude, is
\[
-\frac{\tau\rho^4}{24}\cos 4\alpha
-\frac{\rho}{20}(1+O(\rho))\cos 5\alpha+O(\rho^2).
\]
The four maxima near \(\pm\pi/4,\pm3\pi/4\) have uniformly negative real curvature; the leading pair beats the secondary pair by \(\rho/(10\sqrt2)+O(\rho^2)\) in height. The shifts of the maxima affect this comparison only in second order. Hence the secondary neighborhoods admit an *absolute* Gaussian bound with relative suppression \(O(e^{-c n\rho})\). The centered adjacent-coefficient weight is bounded with bounded angular derivatives since \(\sin\theta\) is separated from zero here. It preserves these bounds and has upper-saddle value \(-i\). On the rest of the fixed bulk interval the same conclusion follows by compactness. This adjacent-coefficient weight is different from the centered \(t\)-derivative weight used for the outer index.

## 3. Real phase matching

I would make the following branch-identification argument explicit at the outer-middle seam. The stationary equation with negative real \(H\) alone is not a rule for choosing the dominant stationary solution. Instead, take \(p\) in a fixed compact overlap near \(P\) and pass to a subsequence on which \(p\) and \(x/n\) have limits, the latter positive. The middle height estimates divided by \(n\) select the limiting dominant pair on the limiting circle: \(\lambda/n\) is bounded below there, \(q\ge 1/p\), and the local neighborhoods have strictly negative normalized real curvature. The \(A/n\) term disappears. Thus the limiting upper saddle is the global pure upper saddle by the certificate. This uses the already proved estimates, not a new branch assumption. Locally \(H'\ne0\), and the exact equation differs from \(H=-n/x\) by \(h/x=O(1/n)\). The pure saddle at the **same \(x/n\)** is therefore \(O(1/n)\) from the exact one, uniformly on the compact overlap. Here the local pure branch is equivalently obtained by inverting \(\tau\), since \(\tau'<0\).

For \(F_a(z)=-aB(z)-\log z,\ a=x/n\), one has \(F_a'(z_{\rm pure})=0\). Thus the change in \(nF_a\) between the two points is \(O(1/n)\), not \(O(1)\); the change in \(A\) is \(O(1/n)\) as well. Also \(D/n=-aK(z_{\rm pure})+O(1/n)\). This compares the actual real phases to \(o(1)\) when the same principal logarithm is used.

For the middle-inner seam a useful direct check in \(z=r+w\) coordinates is
\[
E(r+w)=C_{\mathbb R}+rS(w)+w^2+O(r^{-1})
\]
on bounded complex \(w\)-sets in the overlap, with differentiated versions. Indeed \(A-n\log z\) has zero linear coefficient there at \(w=0\), quadratic coefficient \(3r/4+1+O(1/r)\), and remainder after the quadratic \(O(1/r)\) for bounded \(w\). The exponential term contributes \(-cr e^w\) up to exponentially small corrections. In a fixed-width overlap at \(p-r\) near \(-M\), \(\lambda\asymp N/p\) bounds \(c\) in a positive compact interval. Any limit of the exact saddle solves \(S'=0\), has \(y\) close to \(\pi\), and obeys \(u=y\cot y\) with \(0<y<\pi\) (the imaginary equation requires \(\sin y>0\)). This selects the nondegenerate reduced branch. At the same finite-\(r\) value of \(c\), the exact \(w\) is \(O(1/r)\) from \(w_*\) by the differentiated expansion and local inversion. Hence the change in \(rS\) is \(O(1/r)\). At an exact saddle \(D=z^2 E''(z)\), so \(D/(R^2r)=S''(w_*)+O(1/r)\), since \(\arg z=O(1/r)\). This recovers precisely the inner phase in the question, including \(\Im(w_*^2)\). No comparison modulo \(\pi\) is involved.

These are actual overlaps in the real parameter \(t\): the middle \(x\) decreases with \(p\), and \(c(y)\) increases with \(y\) on the inner parametrization. The inner compact range can stop short of \(\pi\) for fixed \(M\), even if its endpoint is very close to \(\pi\). Thus constants on that compact range need not be uniform as \(M\to\infty\). Interpolating the *real phases* over the overlaps changes either native phase by \(o(1)\); there is no need to interpolate the coefficient-circle radii or positive scales.

## 4. Degree saturation versus interlacing

**All roots.** The inner cut has the claimed absolute phase. Specifically,
\[
r\Im S(w_*)=-r y^3/2+O(ry^5),\qquad
-\tfrac12\arg(1-u-iy)\longrightarrow+\pi/4.
\]
Since \(r y^3=2\pi(H+1/4)\), the total tends to \(-H\pi\). Also \(c/c_0=1+y^2/2+O(y^4)\), yielding exactly the stated \(S_H\). For large fixed \(H\), the indexed Airy asymptotic has error smaller than the gap of \(S_H\) to either neighboring zero. If the fixed Airy result is formulated only as compact-window convergence, one should say initially **at least** \(H\) distinct roots on the zero side of this cut. Compact convergence by itself does not control an unbounded Airy-coordinate interval towards \(t=0\). This weaker count is sufficient, and the cut sign also follows from the bridge cosine estimate.

The choices of constants are compatible: fix the middle ranges and overlaps, take \(J,H\) large enough for the endpoint-regime errors, and then take \(n\) sufficiently large with all these choices fixed. One does not need the errors \(O(e^{-cJ})\) or \(O(H^{-1/2})\) to tend to zero at a fixed cut as \(n\to\infty\).

The first-hitting argument now uses only continuity and the cosine test. The starting and ending designated levels are \((-m+J)\pi\) and \(-H\pi\), not levels obtained by reducing these phases into a principal interval. There are \(m-J-H\) sign-changing intervals. This forces that many distinct negative roots in addition to the \(J\) outer and at least \(H\) inner roots. Since the degree is \(m\), all counts saturate, every root is simple, and no complex or additional real roots remain. In particular saturation upgrades the weaker inner count to an exact one if needed. This part uses neither the sine test nor monotonicity of the composite phase.

**Interlacing.** In each saturated central interval with designated levels \(l\pi,(l+1)\pi\), the proposed shorter bracket works: take the first hit of \((l+5/6)\pi\) in the interval and the last hit of \((l+1/6)\pi\) before that. Between them the phase stays in this closed strip. Opposite cosine signs place the unique zero there, including for the first and last intervals with inexact cut phases. At the zero the subtracted term in the companion test is *exactly* zero. The remaining integral is a positive multiple of \(P_{n+1}\), and \(|\sin G|\ge 1/2\) on the strip. This gives
\[
\operatorname{sgn} P_{n+1}(t_{n,k})
=(-1)^l=(-1)^{m-k+1}.
\]
In particular there is no subtraction of independent relative approximations to values of size \(\cos G\) when \(\sin\theta\) is small.

At the fixed outer ranks the same signs can be checked from reciprocal convergence alone with one spare rank. In the three no-jump cases \(x_{s+1,k}\) is strictly between \(x_{s,k}\) and \(x_{s,k+1}\). In the jump case \(x_{0,k}<x_{3,k}<x_{0,k+1}\), and the ratio of the two \(m^5\)-type scaling factors tends to one. Thus at the \(k\)-th old root the number of new roots to its left is \(k-1\) in the first cases and \(k\) in the jump case; the new leading sign changes in precisely the jump case. At the inner ranks the fixed **adjacent-spacing** result matters: knowing the leading Airy limit for the same rank in two rows would not by itself order them. With the assumed direction and the neighboring-rank separation, exactly \(m-k+1\) new roots lie to the right of the old \(k\)-th root, giving the required sign from \(P_{n+1}(0)>0\).

There are consequently \(m-1\) forced new roots between successive old roots and one between the last old root and zero. For new degree \(m+1\) there is additionally a sign change to the left of the first old root; for new degree \(m\) the first \(m\) intervals already exhaust the degree. This proves the prescribed strict direction in both cases.

The result of this audit is an **existential sufficiently-large-\(n\)** conclusion for both assertions. None of the compactness arguments or nested choices of fixed cuts supplies a threshold that can be joined to the finite verification.
