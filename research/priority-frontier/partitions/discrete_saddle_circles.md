# A circle with prescribed zero count from a locally quadratic logarithm

Consider a sequence of finite polynomials \(P(z)=\sum_{i=0}^{D}a_i z^i\) with positive, log-concave coefficients, and interior indices \(k\). Suppose \(d>0\) tends to zero, \(dk\to\infty\), \(d(D-k)\to\infty\), and the coefficient logarithms at \(k+h\) have a holomorphic interpolation on \(|s|\le100/d\), real for real \(s\). More precisely, after a positive constant and a geometric rescaling there is a function \(F\) with
\[
 F(0)=F'(0)=0,\qquad
 \exp F(h)=a_{k+h}/a_k\ \text{at integral }|h|\le100/d,\qquad
                 \sup_{|s|\le100/d}|F''(s)/d+1|=o(1).
\]
Then for all sufficiently large members of the sequence there is a zero-free circle about zero containing exactly \(k\) zeros of \(P\), counted with multiplicity. The assertion is invariant under the two rescalings. Relative control of curvature suffices even when the cubic error in the exponent on the scale \(1/d\) is unbounded.

## Two neighbouring Fourier frequencies

For \(|b|\le1/4\), \(0\le\theta\le\pi\), define the centred Laurent sum
\[
   S_b(\theta)=\sum_{h=-k}^{D-k}(a_{k+h}/a_k)e^{(b+i\theta)h}.
\]
For \(-2\pi\le u\le\pi\), write \(z_u=z_u(b)\) for the unique near-central solution of \(F'(z_u)+b+iu=0\), and \(E_u=F(z_u)+(b+iu)z_u\). Indeed \(z=(b+iu)/d+[F'(z)+dz]/d\) is a contraction of the closed disk \(|z|\le10/d\) into itself for large sequence index. The solution depends analytically on \(b+iu\). Uniformly,
\[
 z_u=(b+iu+o(1))/d,\quad E_u=((b+iu)^2+o(1))/(2d),\qquad
                         \partial_u E_u=i z_u.                     \tag{1}
\]
For real \(b\), \(E_{-u}=\overline{E_u}\) wherever both sides are used; equivalently continue the same contraction up to \(u=2\pi\).

We claim, uniformly in \(b,\theta\),
\[
 S_b(\theta)=\sqrt{2\pi/d}\,
   \big[e^{E_\theta}(1+o(1))+e^{E_{\theta-2\pi}}(1+o(1))\big]
               + O(e^{-20/d}).                                     \tag{2}
\]
Take a half-integer \(T=30/d+O(1)\) and \(Y=2\pi/d\). The terms with \(|h|>T\) have total absolute value \(O(e^{-100/d})\). At each cutoff the curvature assumption integrated twice gives \(F(h)=-dh^2/2+o(dh^2)\), and the next outward ratio is at most \(e^{-20}\) by the first difference of \(F(h)+bh\). Log-concavity bounds all subsequent outward ratios. Both cutoffs are interior eventually.

Apply the residue theorem to
\[
 \frac{e^{F(z)+(b+i\theta)z}}{e^{2\pi iz}-1}
\]
on the rectangle with vertical sides \(\Re z=\pm T\) and horizontal sides \(\Im z=\pm Y\), in the positive orientation. Its contour integral equals the sum over \(|h|<T\). On the vertical sides the denominator has modulus at least one, as \(T\) is a half-integer. The integral there is \(O(e^{-100/d})\) since
\(\Re F(z)=-d((\Re z)^2-(\Im z)^2)/2+o(1/d)\) and \(|b|\le1/4\). On the upper edge the reciprocal denominator is \(-1+O(e^{-2\pi Y})\), while on the lower edge it is \(e^{-2\pi iz}+O(e^{-4\pi Y})\). After reversing the upper orientation both main integrals run left to right with frequencies \(u=\theta\) and \(u=\theta-2\pi\). Completing the real square in \(\Re z\) bounds the upper-edge error by
\[
 O(d^{-1})\exp\big((b^2/2-2\pi^2-2\pi\theta+o(1))/d\big),
\]
and the lower-edge error by \(O(d^{-1})\exp((b^2/2-6\pi^2+2\pi\theta+o(1))/d)\). Both are \(O(e^{-15/d})\), and each is \(o(e^{\Re E_\theta})\) since \(\Re E_\theta\ge-(\pi^2/2+o(1))/d\). They can therefore be absorbed in the first relative error of (2).

For each main integral shift the horizontal line to \(\Im z=\Im z_u\). The short vertical segments at \(\pm T\) again have \(O(e^{-100/d})\) total. On the new line \(z=z_u+t\) with \(t\) real, the exponent minus \(E_u\) equals \(-dt^2/2+o(dt^2)\) uniformly as a complex estimate, by integration of the second derivative. Its real part is at most \(-dt^2/3\). Substitute \(t=x/\sqrt d\) and use Gaussian domination; both endpoints in \(x\) diverge with opposite signs. The horizontal integral equals \(\sqrt{2\pi/d}\,e^{E_u}(1+o(1))\), including for the possibly much smaller second exponential. This proves (2).

## Choosing the circle

Choose \(b\in[-1/4,1/4]\) with \(\Im E_\pi(b)=0\) as a real equality. Such a value exists since (1) gives \(d\Im E_\pi(b)=\pi b+o(1)\) uniformly, with opposite endpoint signs. Every such choice satisfies \(b=o(1)\). Thus \(e^{E_\pi}\) and \(e^{E_0}\) are positive. We show
\[
 \Re\!\left(S_b(\theta)e^{-E_\theta}\sqrt{d/(2\pi)}\right)>1/2
 \quad(0\le\theta\le\pi)
\]
eventually. For \(\theta\le\pi/2\) the second-to-first exponential ratio is exponentially small by (1). For \(\pi/2\le\theta\le\pi\), its log modulus is \(\Re E_{2\pi-\theta}-\Re E_\theta\le-c(\pi-\theta)/d\), by \(\partial_u\Re E_u=-\Im z_u\) and (1) on \([\pi/2,3\pi/2]\). If \((\pi-\theta)/d\to\infty\), the ratio again tends to zero. When \(\pi-\theta=O(d)\), its argument, taken continuously from zero at \(\pi\), is \(o(1)\). Indeed the derivatives of \(\Im E_{\theta-2\pi}\) and \(\Im E_\theta\) are \(\Re z_{\theta-2\pi},\Re z_\theta=o(1/d)\) since \(b=o(1)\). These two alternatives along subsequences prove the uniform right-half-plane bound using (2).

At both endpoints \(S_b\) is real and positive, and the right-half-plane factor has zero change of argument between them. The continuous argument of \(e^{E_\theta}\) changes by \(\Im E_\pi-\Im E_0=0\) as well. Multiplication by the omitted \(e^{ik\theta}\) therefore gives exactly \(k\pi\) for the change of argument of \(P(e^{b+i\theta})\) on the upper semicircle. Conjugation supplies the other half. The whole circle is zero-free and its count is exactly \(k\).
