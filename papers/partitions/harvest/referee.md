**Referee recommendation: minor revision of the analytic argument, with a separate qualification about the effective computations.** I find no counterexample or unclosed asymptotic regime in the eventual interlacing theorem. In particular, the two moving-radius estimates do more than extend a density-one result: they carry a *signed, absolutely numbered* oscillation from one cut to the other. I would not claim an effective value of \(N\), or all-row interlacing, from this proof.

I take the 86-slab comparisons and the 501,501 root brackets as the finite outputs specified in the question. I do not take an Airy approximation, an unwrapped phase, or any assertion for infinitely many rows as an output of either computation. The effective outer and inner checkers are also **different** computations from those two. The compact two-saddle route, its unique angular minimum, the density-one conclusion, and the identification of the missing moving-radius issue are prior contributions of Per Alexandersson, not the novelty of this paper.

### 1. Starting the phase and fixing its outer integer

The normalizations of the coefficient integral work. The later-row insertion is \(e^{-ij\alpha}\), with a *positive* conversion factor from the integral to the polynomial. On the compact angular certificate, the comparisons off the core are enough: a global upper-half minimizer must be in the core, and there \(-\Re K>0\) gives strict convexity. The two endpoint signs locate the stationary point. This is a valid inference from a slab enclosure; an enclosure just of a stationary point, without the comparison off the core, would not suffice.

On the pure branch,
\[
 \rho H_\rho=K(1+i\rho\theta_\rho)=|K|^2/\Re K,\qquad
 \psi_\tau=-\Im B .
\]
Thus \(t=-n\tau\) and \(\psi\) increase in the same direction. The curvature square root is the right-half-plane choice. In particular, the compact counting measure has density \(4\Im B/\pi\) in \(t/n\), not its negative. Exhaustion gives total mass one, so this weak limit does not require assuming eventual real-rootedness.

At the small-radius end I get
\[
 \Im(B-H/4)(z_*)=\frac{\rho^5}{480\sqrt2}+O(\rho^6),\qquad
 \psi=-\frac{\pi}{4}+\frac{\rho}{20\sqrt2}+O(\rho^2).
\]
There are four peaks of the limiting *real* phase, not two. The normalized height difference of the primary and secondary maxima is \(\rho/(10\sqrt2)+O(\rho^2)\). It is legitimate to use the secondary maxima just for an absolute bound, without making them stationary for the complex phase. Their integrated contribution contains the \(n^{-1/2}\) from their own curvature. Hence the error on dividing by one primary pair's scale is \(o_n(1)+O(e^{-c n\rho})\), **not** \(O(\sqrt n\, e^{-c n\rho})\). This distinction matters: at the cut, \(n\rho\) is a large *fixed* number.

The reciprocal limit supplies information not contained in that estimate. Its scale \(24m^5/625\) follows from the falling factorial giving \(m^\ell\) and the excess degree giving \((m/5)^{4\ell}\). The \(M/m\) coefficient bound proves locally uniform convergence. The non-axis-zero exclusion for the tangent equations works: when both coordinates are nonzero the real and imaginary equations imply
\(\sin(2x)\sin(2y)=\sinh(2x)\sinh(2y)\), which is impossible in absolute value. Poles have to be excluded using the original entire functions, as in the paper. Thus the reciprocal disk count is a *complex* count and the conjugation argument gives simplicity and reality.

At the stated cut, putting \(D=(J+s/4)\pi\), I obtain
\[
 G_{\rm pure}=(-m+J)\pi+o(1),\qquad
 \frac{(24/625)m^5}{-n\tau(\rho_J)}\longrightarrow -4D^4 .
\]
In each residue \(x_{s,J}<D<x_{s,J+1}\). This fixes the integer: there are \(J\), not \(J\) up to an additive constant, to the left. In particular the outer rank formula is consistent with the offset \(k-\tfrac12+s/4\). The leading mesoscopic coefficient is \(6/(20\sqrt2)^4=3/320000\). The refinement with additive \(o(1)\) in the fourth root needs \(n\rho^2=o(1)\), hence the stated \(k=o(\sqrt n)\), not just \(k=o(n)\).

There are two different derivative issues here.

* For uniqueness in a small-radius phase bracket, an uncentered \(B\)-insertion is not a uniform sine test. The Euler identity gives exactly
  \[
  \partial_\tau L_j[1]-\frac{n+j}{4\tau}L_j[1]
     =-nL_j[B-H/4+h/(4n\tau)] .
  \]
  After division of the bracket by \(\rho^5\) its upper imaginary part is \(1/(480\sqrt2)+O(\rho+1/n)\). Its real part and its angular derivative are bounded. This tests the derivative of \(\tau^{-(n+j)/4}L_j[1]\), which has the same zeros as the row. The minus sign on the right gives a **positive** coefficient of \(\sin(G-j\theta)\). One must choose the phase bracket narrow compared with the ratio of this small lower bound to the bound on the real coefficient, *then* choose \(J\) large. There is no differentiation of a uniform \(o(1)\) here. The compact derivative formula likewise tests the derivative of the polynomial, not the derivative of a polynomial divided by a variable saddle amplitude.
* For the fixed-rank comparison with \(m+1\) in the same residue, mere convergence of the reciprocal roots would be insufficient. The paper's first-order summand bound, including the zero extension for \(\ell>m\), is summable after multiplication by \(m\). It gives the *same* first correction \(c_{s,k}\) in the two rows. The ratio of magnitudes is therefore \(1+5/m+o(1/m)\), with the later row more negative. This reasoning would fail with two unrelated \(O(1/m)\) relative errors.

### 2. The moving middle saddle and the two seams

Here are the uniformity checks I regard as essential to the main result.

On \(P\le p\le r-M\), \(N_p\ge (r-p)h'(p)\), so \(p^2/N_p\) is small even at the moving end of the interval. The phase equation for \(y\) uses \(n-h(z)\) in a neighborhood of the positive real direction, and the logarithmic correction to \(ze^z\) near 1. It has derivative \(1+O(1/p+p^2e^{-p}+p^2/N_p)\). This selects the solution near \(+\pi\), without taking an ambiguous principal argument of \(ze^z\) across the negative axis. The logarithmic derivative calculation gives \(d\log x/dp<0\). Thus this is a parametrization in the same real variable as the cuts, not just a locus of candidate saddles.

For the real-part comparison, an important clarification is that the excess \(O(\Lambda q_0^2)\) of the envelope over the saddle is **at \(v=y\)**. It need not be that small at \(v=0\). Starting at \(y\), the envelope loses at least \(c((1+x)p+\Lambda/p)=c\Lambda q_0\) by \(2\pi\): the cubic cosine produces the first term and the change of the real coordinate of the exponential produces the second. Beyond \(2\pi\) the envelope is decreasing on the small-angle arc. On the bounded \(v\)-arc separated from \(\pi\), the cosine loss is order \(\Lambda\), and the gain from the polynomial and radius change is only \(O(\Lambda q_0)\). On the arcs separated in **angle** from zero, the possible polynomial gain is still only \(O((1+x)p)\), by comparing to \(A(R)\), whereas the exponential envelope is reduced by a fixed fraction of \(\Lambda\). These estimates cover also the many secondary exponential peaks when \(p\) grows.

In local arclength the real quadratic loss is at least \(c\Lambda\) times squared distance, and the third derivative is \(O(\Lambda)\). The near-saddle error on bounded rescaled distances is \(O(\Lambda^{-1/2})\) in the cubic Taylor term. The rest of that neighborhood has a Gaussian majorant. On the separated arcs the loss is at least \(c\Lambda q_0\), with \(\Lambda q_0\ge\max(p,\Lambda/p)\ge\sqrt\Lambda\). It absorbs the arc length, Gaussian normalization, and the \(O(p)\) bound for \(W_j\). Locally the derivative of \(W_j\) in arclength is bounded because \(R\sin(j\theta)\asymp y\) for these fixed \(j\). Finally \(\inf\Lambda\to\infty\): a sequence with bounded \(p\) has \(N_p\to\infty\), and a sequence with \(p\to\infty\) has \(\Lambda\gtrsim Mp\). These facts justify a **uniform absolute pair-scale error**, including for the sine insertion.

I checked the seams at the *same \(x\)*, which is necessary. Matching two descriptions just at approximately the same radius would not justify matching the phases.

1. On \(P\le p\le P+1\), \(\Lambda/n\) and \(q_0\) are bounded below by positive constants depending on \(P\). Use the stronger gap \(c\Lambda q_0\), not merely \(c\sqrt\Lambda\), when dividing by \(n\). The limit saddle minimizes \(\Re B\) on its circle, and the pure branch is identified by uniqueness and the value of \(H\). Since \(H'\ne0\), the two saddles at this \(x/n\) differ by \(O(1/n)\). In the action, the possibly dangerous \(n\) multiplies a **quadratic** difference, by stationarity. The remaining \(A\) difference is \(O(1/n)\), and \(D/n=-(x/n)K_{\rm pure}+O(1/n)\). Thus the real phases differ by \(O(1/n)\).
2. On \(r-M\le p\le r-M+1\), \(N_p\asymp_M r^2\), \(\Lambda\asymp_M r\), and \(c=x e^r/r\) stays in a compact set depending on \(M\), not on \(n\). The limiting imaginary part is near \(\pi\), but is **below** \(\pi\) by the imaginary stationary equation. It selects \(u=y\cot y\), \(c=3y e^{-u}/(2\sin y)\). On this fixed overlap the saddle is nondegenerate. The differentiated local expansion gives \(z-r-w_*=O_M(1/r)\). Again stationarity gives an action error \(O_M(1/r)\), not \(O_M(1)\), and \(D=z^2E''\) gives \(D/(|z|^2r)=S''_c(w_*)+O_M(1/r)\). The imaginary part of the order-one term is \(2uy\); dropping this term would not in general match the phases.

Both actions use \(\log z\) in the right half-plane and the curvatures use the argument in \((-\pi/2,\pi/2)\). These comparisons are of **real numbers**, not of cosines or phases modulo \(2\pi\). The proof can interpolate in \(x\) without changing a sign test by more than \(o(1)\). The order of choices matters: fix the neighborhood of \(\pi\), then the large constants \(P,M\), use compact endpoints reaching beyond the two fixed overlaps, and only later take the end-cut indices large and \(n\to\infty\). No estimate uniform as \(M\to\infty\) at the second seam is required.

### 3. Airy limit, local tails, and displacement

Direct expansion in \(z=r+w\) gives the quadratic coefficient \(3r/4+1+1/(2r)\) and cubic coefficient \(1/6-n/(3r^3)=O(1/r)\). Thus \(rS_c(w)+w^2\) is the correct direct phase to order one. In the circle coordinate the \(-v^2/(2r)\) displacement produces \(-v^2S'_c(w)/2\). It vanishes at the reduced saddle but cannot simply be dropped as a uniform expansion on a fixed \(v\)-arc.

There are **three different tail arguments**; none can be replaced by convergence of the local integrand on bounded rescaled coordinates.

* On the Airy contour with \(q=-1+is\), \(1-\cos v\le v^2/2\) gives real loss at least \(\tfrac34 r(1-e^{-r^{-1/3}})v^2\) for the unperturbed reduced phase. On a compact complex \(\lambda\)-set the extra growth after centering at zero is at most \(C r^{1/3}|v|\). This gives \(C\exp(-c s^2+C|s|)\) out to \(|v|=M\), not just out to fixed \(|s|\). Beyond \(M\) the \(A\)-loss is at least \(c r v^2\) at small angle and \(c r^2\) away from small angle; the possible saddle-scale and \(xB\) costs are \(O(r)\). Taking \(M\) sufficiently large absorbs both. These bounds survive a polynomial factor in \(r\) on the remote arc. On the local arc the exponent difference from the limiting one is \(O(r^{-1/3}(1+|s|^4))\); interpolation between the two exponentials costs their **maximum real exponential**, not the exponential of this error bound. This proves the claimed locally uniform rate and permits Cauchy differentiation. The orientation in \(t=-a q\) gives \(+(e/a)\Ai(-b_0\lambda)\).
* For the *modulus* assertion, compact Airy convergence alone is not a disk count. On the extra-root subsequence away from \(c_0\), the selected solution of \(u=(2/3)c e^u\) has \(|u|<1\). This remains valid locally at a noncritical point of \(|c|=c_0\) by inverse continuation. Near \(c_0\) with \(|\lambda|\to\infty\), \(\Re\Delta\le M_0r^{-2/3}=o(|\Delta|)\) as an upper bound. Consequently the choice \(\sqrt{-2\Delta}\) has real part comparable from below to its modulus, \(1-|u|\gtrsim |1-u|\), and \(r|1-u|^3\to\infty\). On the line through \(u\), the bound \(-3(1-|u|)t^2/4\) is a full local-tail bound on the scale \(t=s/\sqrt{r|1-u|}\). The cubic error tends to zero on bounded \(s\); the Gaussian majorant controls the rest up to the remote arc. The Gaussian has nonzero integral even when its coefficient is complex. This excludes an extra root that escapes every bounded Airy parameter set while staying in the proposed modulus disk.
* On the oscillatory side with small \(y\), the untilted line does **not** give a uniform real quadratic loss of order \(y\): \(\Re S''\) is only of order \(y^2\). The tilt in the paper repairs exactly this issue. On putting \(d=V-y\), the real quadratic-plus-cubic calculation gives
  \[
  \Re(S_c(w)-S_c(w_*))\le -c(y+V)d^2.
  \]
  Indeed both linear coefficients after substituting \(d=V-y\) in the displayed expansion are negative. On \(s=d\sqrt{ry}\) the majorant is Gaussian, the cubic error is \(O(|s|^3/\sqrt{ry^3})\), and the insertion varies by \(O(|s|/\sqrt{ry^3})\). Truncation at \(V=0\) costs a Gaussian tail starting at \(\sqrt{ry^3}\). The horizontal connectors and the undeformed bounded arc outside them have a fixed height gap. For clarity, the connector expansion at \(c=c(y)\) can be written with error \(O(\epsilon^3+y^2)\), and one takes \(y\) sufficiently small *after* fixing \(\epsilon\); alternatively use strict positivity of \(\Re S'\) on the connector at \(y=0\) and continuity. The compact \(y\)-argument handles the rest. The remote insertion bound \(O(R/y)\) is polynomial for \(ry^3\) bounded below. The local tangent \(1+i\delta\) times \(\sqrt{S''}\) has positive real part, so cancellation of the tangent in the Gaussian introduces no sign or half-turn.

For the adjacent-row derivative-sized effect, subtracting two Airy root asymptotics of the accuracy in the theorem would be invalid. Instead, on the same contour \(r^{4/3}((r+1)/z-1)\to-q\), bounded in absolute value on the local arc by \(C(1+|s|)\). The first tail argument above applies. Since the limiting integrand differentiates with factor \(-3q/2\), the difference limit is \(+(2/3)F'\). The common-parameter root displacement is \(-(2/3)r^{-4/3}(1+o(1))\). This gives \(x_{n,k}-x_{n+1,k}\sim e^{-r}/(er)\), much smaller than the separation between successive fixed ranks. Both the magnitude and the sign in the theorem check out.

### 4. Saturation and gap four

The sign insertion needs more accuracy than a cosine approximation to each of two independent rows. In the middle \(W_j(z_*)=-i\), so its pair contribution is \(+\sin G\). At small radius this works directly only for \(j=1,2,3\). For \(j=4\) I get, by integration around the full circle,
\[
 (n+4) I[e^{-4i\alpha}]
   = I[e^{-4i\alpha}h-x\rho^4 (H/z^4)] .
\]
The coefficient \(n+4\), the minus sign, and the linear coefficient \(1/24\) of \(H/z^4\) are all needed. After dividing by \(n+4\), subtracting the real part at the saddle, and dividing by \(\rho\), the upper value is
\[
 -i\{1/(4\sqrt2)+O(\rho+1/n)\}.
\]
The constant part cancels on the **whole circle** in this centered insertion, whose value and angular derivative are now bounded. Its integral at an old root is a *positive* multiple of the later-row value. This is a valid gap-four test even where dividing an ordinary pair-scale error by \(\sin 4\theta\) would be useless.

At the inner cut \(r\Im S_c=-ry^3/2+O(ry^5)\) and the curvature contributes \(+\pi/4+o(1)\). The resulting real phase is \(-H_0\pi+o(1)\). The limiting \(b_0\lambda\) is the stated \([(3\pi/2)(H_0+1/4)]^{2/3}\), between \(d_{H_0}\) and \(d_{H_0+1}\) for large fixed \(H_0\). Thus there are exactly \(H_0\) roots on the origin side. One may use fixed disks on either side of this moving cut to make the inference from the modulus count explicit.

There are \(m-J-H_0\) sign changes between the two cuts, in addition to the \(J+H_0\) distinct cut roots. This exhausts the degree. It does **not** require a derivative bound or strict monotonicity of the interpolated phase in the middle. Even for a backtracking continuous phase, the last lower-strip hit before the first upper-strip hit encloses a root and keeps the sine of one sign there. The first and last cuts are within \(\pi/12\) of their levels, sufficient for these hits. For rank \(k\) the lower level is \((k-1-m)\pi\), hence the later sign is \((-1)^{m-k+1}\). At fixed outer ranks this agrees with counting later roots on the left (one more at a degree jump); at fixed inner ranks it agrees with counting exactly \(m-k+1\) on the right. Signs at 0 and \(-\infty\) then give precisely the interlacing convention in the question. The degree obstruction to six rows uniform in the starting row is valid.

### 5. Finite and effective claims; coefficient order

* The 501,501 brackets with opposite endpoint signs and the indicated disjointness exhaust the exact degrees from the integer recurrence. Multiplicity greater than one, an extra complex zero, or an extra real zero is then impossible. Strict endpoint ordering gives the \(2000+1999+1998+1997=7994\) strict pair orders. This argument proves **nothing about rows above the range**.
* In the effective outer theorem the retained coefficients really are polynomials: extracting degree \(4\ell+s\) after binomial expansion gives the displayed \(q^{d-i}\) times the falling product. For an actual \(q=1/m\) the omitted series has the Cauchy norm bound stated. Two Graeffe steps preserve the disk count, and dominance of coefficient five *with the propagated \(\ell^1\) error included* is sufficient by Rouché. Five real sign changes then exhaust the disk. For repeated residue the path derivative on the retained polynomial is indeed \((5v\partial_v-y\partial_y)/(1+u)\) at the path point. The tail comparison to \(1/(4\ell+s)!\) costs \(O(q)\), including the missing \(\ell>m\) terms; comparing both integer endpoints and accounting for the \((1+q)^{5\ell}\) factor gives the displayed \(T\). No analytic continuation in \(m\) of the infinite tail is needed. The resulting sign \((-1)^k\) is the sign *after* the later \(k\)-th reciprocal root, giving a more negative later root. The finite range covers the join. This is a sound reduction to the specific additional slab, dominance, and Bernstein inequalities. Those inequalities are not outputs of the 86 angular slabs or the finite-row replay.
* In the effective inner theorem the moment estimates use the two different signs correctly: the quartic error for a lower real bound is charged to \(xB_4\), and for an upper bound to \(A_4\). For example, \(Rv^3\ge15(0.3)^3\) and \(R\ge15\) bound the cubic coefficient by \(0.56\); \(Rv^2\ge15(0.3)^2\) gives the \(0.07\) quartic coefficient. The lower bound on the central integral exceeds the two tail costs. The endpoint deficit follows by integrating \(t e^t\), as claimed. For the separate small-\(n\) test, strict positivity of the shifted coefficients is sufficient since one evaluates the shifted polynomial at \(c_0r e^{-r}-x\ge0\). It is not a consequence of mere interlacing through 2004.
* For general \(b\), the log-concavity induction for the restricted exponential works with the zero-left extension: new indices in the averaging weights enter at the high end. Convolution then preserves interval-supported log-concavity. The ratio \(R_k(h)\) is increasing where its denominator is positive. The key second comparison is an average of \(R_{k-1}\) at arguments \(\le m-b\le n\), not a comparison of two ratios at the same \(m\). This gives the derivative order, including the factorial factors. The degree obstruction at gap \(b+1\) is genuine. In shifting the derivative comparison, \(i a_i^{(m)}a_{k-1}^{(n)}\ge k a_k^{(m)}a_{i-1}^{(n)}\) for \(1\le i<k\) is stronger than needed. The tilted-mean conclusion follows. I find no missing real-rootedness assumption in this theorem.

### 6. Proposed appendix

The degree bounds work, including for the degree-aligned, rather than actual-degree-aligned, numerator of the rational function. More explicitly, write \(U=1+D\), \(D(0)=0\). Extraction in degree \(h\ge0\) of \(EU^{d-j}\) uses only \(\binom{d-j}{i}\) for \(i\le h\). The prefactor has degree \(j\), giving \(s+5j\). For \(Q\) the extraction is in degree \(s-3+4j\) and the prefactor uses \(d+1\), giving \(s-3+5j\); a negative extraction index gives zero. In particular one must **not** move \(q_1\) to position \(q_0\) when \(s<3\).

The division recurrence gives \(\deg N_i\le(i+1)s+5i-3\), since even a summand involving \(p_jp_0^{j-1}N_{i-j}\) obeys that bound. Thus the determinant numerator has degree at most
\[
 (3s+7)+(5s+17)=2(4s+12)=8s+24.
\]
Its two terms have the same denominator \(p_0^8\) in the corresponding \(c_i\) expression. The factor from the two \(C\)'s is \((n+1)/(24(d+1))>0\). Subtraction of the value at zero affects \(M_0\), **not** \(M_1,M_2,M_3\).

For clarity, here is my exact-arithmetic reduction of the entire appendix finite test. It uses block size at a specified label, not the differential recurrence. The final Boolean test is also a short way to specify the finite sign certificate without companion-file conventions. In particular the differences are taken **after restoring the rational normalizations**; taking differences of integer numerators with a \(d\)-dependent scale would not verify this proof.

```python
from fractions import Fraction as Fr
from math import comb, factorial as fac

def appendix_test():
    B = [[1]]
    for h in range(1, 205):
        row = [0]*(h//4 + 1)
        for l in range(1, h+1):
            b = int(l >= 4)
            c = comb(h-1, l-1)
            for k, a in enumerate(B[h-l]):
                row[k+b] += c*a
        B.append(row)

    def aligned(h, e):
        g = Fr(24**e * fac(e), fac(h))
        return [g*B[h][e-j] if 0 <= e-j < len(B[h]) else Fr(0)
                for j in range(5)]

    for s in range(4):
        L = 8*s+24
        cols = [[], [], []]
        for d in range(2, L+3):
            h = 4*d+s
            p, q = aligned(h,d), aligned(h+1,d+1)
            N = []
            for i in range(5):
                N.append(q[i]*p[0]**i -
                         sum(p[j]*p[0]**(j-1)*N[i-j]
                             for j in range(1, i+1)))
            for col, val in zip(cols, (-N[2], N[3], N[2]*N[4]-N[3]**2)):
                col.append(val)
        for col in cols:
            if col[0] <= 0:
                return False
            while len(col) > 1:
                col = [v-u for u,v in zip(col,col[1:])]
                if col[0] < 0:
                    return False
    return True
```

The finite assertion is `appendix_test() == True`; the largest row needed is 204. The inference to all integers is Newton expansion about **2**, since the binomial basis there is nonnegative for every integer \(d\ge2\). Positivity of the sampled values *alone*, even if inferred at all sample rows from verified interlacing, would not be a replacement for this difference test.

For the conditional implication, division and partial fractions give exactly
\[
 \frac{Q/P-Q(0)/P(0)}{x}-a
     =\sum_{P(u)=0}\frac{w_u}{x-u},\qquad
 M_j=\sum_u w_u(-u)^j
\]
under the simple-negative hypothesis. There is no pole at zero. A positive definite shifted \(2\times2\) matrix cannot be represented this way with at most one positive \(w_u\): take a nonzero linear polynomial vanishing at that one location in the moment variable. Every surviving contribution is nonpositive. This proves **two distinct positive residues**, not positivity of all the residues, and not interlacing by itself. For \(d<2\) there is at most one simple pole, so the determinant is zero.

Finally, at an Airy root the derivative of the common parameter-dependent normalization multiplies \(P_n(u)=0\) and drops out. The coefficient factors are \((n+1)/(r+1)\) and \(u/t'(\lambda)=r^{2/3}+\lambda\). With the same-contour difference, the limit of the margin is indeed \((1/2)(2/3)=1/3\). It concerns fixed rank from the origin; it is not a uniform positive lower bound over the row.

### Disposition by claim

| Claim | Disposition |
|---|---|
| Angular lemma, compact count, limiting law | Supported by the finite angular output plus the analytic end and compact arguments. Do not claim the unique minimum or density-one route as new. |
| Fixed and mesoscopic outer ranks, including gap four | Supported. The first-order reciprocal expansion and the centered Euler derivative test serve different purposes; retain both. |
| Fixed complex-modulus inner ranks, displacement | Supported. The complex single-saddle exclusion and the pre-approximation subtraction are essential. |
| Eventual full real-rootedness, four strict gaps, maximal uniform window | Supported. No missing integer at either seam. Clarify the envelope at \(v=y\), connector error, and order of uniform choices; these are proof-presentation repairs, not changes to the theorem. |
| Rows and pair orders through 2004 | Established from the assumed finite brackets, signs, and degrees. No inference closing the gap to existential \(N\). |
| Effective outer five for every \(n\ge20\) | Mathematical implication of the stated effective-outer comparisons is valid; computational component separate from the two assumed replays. |
| Effective inner positivity | Large-\(n\) analytic bound supported; finite strengthened endpoint rests on the separate finite positivity test. |
| All-threshold coefficient and tilted-mean theorem | Supported, with the stated uniform sharpness. |
| Appendix determinant inequalities and two-margin consequence | Valid degree reduction and exact finite difference criterion; conditional two-margin implication valid, not an all-margin criterion. Fixed Airy margin limit supported. |
| All-row four-gap conjecture | **Not established** and not needed for any of the eventual conclusions. |
