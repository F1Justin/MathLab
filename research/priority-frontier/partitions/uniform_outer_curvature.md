# Outer real roots at every row length for a growing block threshold

Let \(P_{N,j}(t)\) count set partitions of \([N]\) by the number of blocks of size at least \(j\), and put \(D=\lfloor N/j\rfloor\). For every sufficiently large integer \(j\) and **every** \(N\ge j\), at least
\[
           \min\!\left(D,\left\lfloor\frac{j}{20\log j}\right\rfloor-1\right)
\]
largest-modulus roots of \(P_{N,j}\) are simple and strictly negative. The root ranking counts complex roots with multiplicity. In particular \(N\) may grow arbitrarily quickly compared with \(j\).

Write \(b_m=[z^m]\exp(e^z-1)\), \(H(z)=\sum_{l\ge0}j!z^l/(j+l)!\), and \(C(m,k)=[z^m]\exp(e^z-1)H(z)^k\). The [factorial-moment identity and coefficient inequalities](growing_threshold.md) give
\[
 a_k=[x^k]P_{N,j}(1+x)/N!=C(N-jk,k)/(k!(j!)^k),
 \quad R_k=a_{k-1}/a_k,\quad R_{k+1}/R_k\ge1+1/k .
\]
We prove \(R_{k+1}/R_k> e^5\) for every \(1\le k<D\) with \(m=N-jk\le m_0=j^2/(20\log j)\). Only the residual size enters this cutoff.

## A saddle for the full coefficient

For real \(M>0,\ K\ge0\), choose \(r>0\) by
\[
       r e^r+K\nu(r)=M,\qquad \nu(r)=\mathcal D\log H(r),
       \qquad \mathcal D=r\,d/dr .
\]
Existence and uniqueness follow since both summands increase, \(\nu\) being the mean in the positive power-series tilt of \(H\) and \(w=\mathcal D\nu\) its variance. Set
\[
 S(M,K)=e^r-1+K\log H(r)-M\log r,\qquad
 \sigma^2=r(1+r)e^r+Kw(r).
\]
This is the minimum of the defining expression for \(S\) over \(r>0\). Define \(S(0,K)=0\) by continuity. Throughout \(M\le m_0+j\), so \(0<r\le W(M)\le2\log j\) for large \(j\). If \(\xi=r/(j+1)\), then
\[
  \nu=\xi+O(\xi^2),\quad w=\xi+O(\xi^2),\quad
  \mathcal Dw=O(\xi).
\]
Indeed the coefficient of the first excess step is exactly \(\xi\), and the coefficient of step \(l\) in \(H(r)\) is at most \(\xi^l\). The same bounds after up to three logarithmic derivatives follow by summing \(l^3\xi^l\). In particular
\[
      (1-o(1))M\le\sigma^2\le(1+r+o(1))M,\qquad
      |\mathcal D\sigma^2|\ll M(1+r)^2,                              \tag{1}
\]
uniformly in \(K\), with the derivative taken at fixed \(K\).

Along \(M=m-jt,\ K=k+t\) for \(-1<t<1\) one obtains
\[
 \frac{d\log r}{dt}=-\frac{j+\nu}{\sigma^2},
 \qquad
 \frac{d^2}{dt^2}S(m-jt,k+t)=-\frac{(j+\nu)^2}{\sigma^2}.            \tag{2}
\]
For the second equality differentiate \(dS/dt=j\log r+\log H(r)\), since the derivative with respect to \(r\) vanishes at the minimum.

For integers \(M,K\), let \(p_l=[z^l]\exp(e^z-1)H(z)^K\,r^l/\{\exp(e^r-1)H(r)^K\}\). This is a probability law of mean \(M\), with \(C(M,K)=e^{S(M,K)}p_M\). Its sequence is log-concave: the normalized Bell coefficients \(b_l\) are log-concave, the ratios of the coefficients of \(H\) decrease, and convolution preserves log-concavity. [Asai, Kubo and Kuo](https://arxiv.org/abs/math/0104137)

Interpolating \(\log p_l\) linearly between successive integers gives a concave function. Jensen at its mean yields \(\log p_M\ge\sum_l p_l\log p_l\). The entropy at mean \(M\) is at most \((M+1)\log(M+1)-M\log M\le\log(e(M+1))\) by nonnegativity of relative entropy to the geometric distribution of that mean. Consequently
\[
        S(M,K)-\log(e(M+1))\le\log C(M,K)\le S(M,K).                 \tag{3}
\]
This holds at \(M=0\) as well since \(C(0,K)=1\).

If \(j^{3/2}/2\le M\le m_0+j\), a uniform sharper estimate is
\[
 \log C(M,K)=S(M,K)-\tfrac12\log(2\pi\sigma^2)+o(1).                \tag{4}
\]
Here \(K\) is unrestricted. To verify it, integrate the power-series tilt around the saddle circle. In the central arc \(|\theta|\le M^{-2/5}\), subtracting \(iM\theta\) from its log cancels the linear term. The quadratic term is \(-\sigma^2\theta^2/2\). The cubic error is \(O(M(1+r)^2|\theta|^3)=o(1)\). The third angular derivatives from \(K\log H(re^{i\theta})\) are \(O(K\xi)=O(M)\) because \(|H(re^{i\theta})-1|=O(\xi)\) and its first three angular derivatives are \(O(\xi)\). For the Bell factor the bound follows by differentiating \(e^{re^{i\theta}}\) three times. Gaussian integration therefore gives \((2\pi\sigma^2)^{-1/2}(1+o(1))\).

For the outer arcs the Bell loss in real exponent is at least \(e^r(1-e^{-r(1-\cos\theta)})\gg r e^r\theta^2/(1+r\theta^2)\) on \([-\pi,\pi]\). The tilt of one \(H\) factor has masses \(1/H(r)\) and \(\xi/H(r)\) at zero and one. Expanding the squared modulus of its characteristic function bounds its log modulus by \(-c\xi(1-\cos\theta)\). Together these give loss at least \(c M\theta^2/(1+r\theta^2)\), which for \(|\theta|\ge M^{-2/5}\) is \(\gg M^{1/5}\). The integral on the outer arcs is \(o(1/\sigma)\). This establishes (4).

## Coefficient curvature and absolute root ranks

For \(j\le m\le j^{3/2}\), integrate the negative second derivative (2) against \(1-|t|\) on \([-1,1]\). Using (1) gives a central log curvature for \(S\) of order at least \(j^{1/2}/\log j\). If an endpoint has \(M=0\), use continuity and integrate first on compact subintervals. Estimate (3) costs only \(O(\log j)\) in replacing the three \(S\)'s by \(\log C\).

For \(j^{3/2}<m\le m_0\) use (4) at the three integer arguments. Along the connecting interval,
\[
 \left|\frac{d}{dt}\log\sigma^2\right|
 \le \frac{w}{\sigma^2}
   +\frac{|\mathcal D\sigma^2|(j+\nu)}{(\sigma^2)^2}
 \ll \frac{j(1+\log j)^2}{m}=o(1).
\]
Thus the log-normalization contributes only \(o(1)\) to the central curvature. In (2), \(M\le m+j=(1+o(1))m\) and \(r\le2\log j\), so the integral of the curvature is at least \((1-o(1))j^2/(2m\log j)\ge10-o(1)\). The factorials in \(a_k\) add \(\log(1+1/k)>0\). The two estimates prove the claimed \(R_{k+1}/R_k>e^5\).

At \(s_k=\sqrt{R_kR_{k+1}}\), the index-\(k\) term of \(\sum a_i x^i\) strictly dominates all other terms together at every radius in \([0.9s_k,1.1s_k]\). Indeed global monotonicity of \(R_i\) bounds each successive outward term ratio by \(e^{-5/2}/0.9\), and two corresponding geometric tails sum to less than the central term. Rouché counts exactly \(k\) zeros inside each such circle.

These counts persist when the circles are centered at zero in the original \(t\) coordinate. To see that \(s_k\to\infty\) uniformly, put \(r_l=b_{l-1}/b_l\) for \(l\ge1\), and \(r_0=0\). The monotonicity of these ratios gives
\[
 C(m+j,k-1)\ge r_{m+j}^{-j}C(m,k-1),\qquad
 C(m,k)\le H(r_m)C(m,k-1).
\]
Both follow termwise by comparison of the Bell coefficients, using convolution with one additional \(H\) in the second. The Bell-ratio bound \(r_{m+j}=O(\log j)\) and \(H(r_m)=O(1)\) give \(R_k\ge k\, j!/[(O(\log j))^j H(r_m)]\to\infty\). [Grunwald and Serafin, Theorem 5.2](https://arxiv.org/abs/2408.14182)

The disk \(|t|<s_k\), written as \(|1+x|<s_k\), therefore has the same count as the two disks \(|x|<s_k\pm1\) that bracket it. Its boundary is zero-free. Every consecutive count up to \(D-1\), followed by the total count \(D\) at infinity, isolates one simple real root by conjugation. Its sign is negative since the coefficients of \(P_{N,j}\) are positive on \(t\ge0\). If the first available count is zero, use the empty radius at the origin. With \(m=(N-jD)+j(D-k)\) and \(0\le N-jD<j\), these consecutive counts cover the claimed number of largest-modulus roots.
