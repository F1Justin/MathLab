# A unique dominant pair for exponential tails of all sufficiently high orders

Let \(B_j(z)=\sum_{k\ge j}z^k/k!\), \(H=zB_j'\), \(K=zH'\). There exists an absolute integer \(J\) such that for every integer \(j\ge J\) and every radius \(r>0\), the minimum of \(\Re B_j\) on \(|z|=r\) is attained at exactly two conjugate points. At their upper member \(z=r e^{i\theta}\),
\[
 0<\theta<\pi/j,\qquad H(z)<0,\qquad
 \Re K(z)<0,\qquad \Im B_j(z)>0. \tag{1}
\]
Here \(H(z)<0\) includes reality. The proof is uniform in the radius, including when the conditional Poisson variance tends to zero.

### A characteristic-function estimate

Suppose \(X\) is a nonconstant nonnegative integer-valued random variable with a log-concave probability mass function, interval support, mean \(\mu\), and variance \(0<\sigma^2\le\mu\). Write \(\phi(t)=\mathbb E e^{itX}\). As \(\mu\to\infty\), uniformly over these laws, \(\Re\phi\) has a unique minimum on \([0,\pi]\), at \(t_*=(1+o(1))\pi/\mu\). Moreover
\[
 \Re\,\mathbb E X e^{it_*X}<0,\qquad
 \Re\,\mathbb E X^2 e^{it_*X}<0,\qquad
 \Im\phi(t_*)>0 . \tag{2}
\]

For an independent copy \(X'\), the mass function \(p_h\) of \(Y=X-X'\) is symmetric and log-concave. Indeed log-concavity with interval support is equivalent to positivity in order two in the weak sense for the Toeplitz kernel, and convolution preserves these minors by Cauchy–Binet and truncation. In particular \(p_0\) is its largest mass and \(\mathbb E Y^2=2\sigma^2\). For each fixed integer \(b\ge2\),
\[
 \mathbb E|X-\mu|^b\le\mathbb E|Y|^b
 \le C_b\sigma^2(1+\sigma)^{b-2}. \tag{3}
\]
The first inequality is conditional Jensen. Chebyshev gives \(p_0\ge c/(1+\sigma)\), since \(\mathbb P(|Y|\le 3(1+\sigma))\ge 7/9\). Monotonicity gives \(p_h\le1/(2h+1)\) for \(h\ge0\). Thus for a sufficiently large absolute constant \(C\), \(D=\lceil C(1+\sigma)\rceil\) has \(p_D\le p_0/2\). Ratios decrease by log-concavity, so \(p_{h+D}\le p_h/2\) for every \(h\ge0\), including finite-support cases. Summing in blocks \(1,\ldots,D\) and their translates bounds the moment by \(C'_b D^b\Pr(Y\ne0)\). Since \(\Pr(Y\ne0)\le\min(1,2\sigma^2)\), this proves (3).

A symmetric unimodal integer law is a mixture of uniform laws on \(\{-k,\dots,k\}\), using weights \((2k+1)(p_k-p_{k+1})\). Let \(V\) denote the random half-width with these weights. For \(0\le t\le\pi\) each such uniform law has \(1-\mathbb E\cos(tY)\ge c\min(1,k^2t^2)\). If \(kt\le\pi\) use \(1-\cos u\ge2u^2/\pi^2\) on its support. If \(kt\ge\pi\), the absolute value of its normalized Dirichlet kernel is at most \(\pi/((2k+1)t)<1/2\). Also \(\mathbb EV^2\asymp\sigma^2\) and \(\mathbb EV^4\le C\mathbb EY^4\), by the second and fourth moments of each uniform law. Cauchy–Schwarz applied to \(V/\sqrt{1+V^2t^2}\) and \(V\sqrt{1+V^2t^2}\), followed by (3), yields an absolute \(c>0\) such that
\[
 1-|\phi(t)|^2=1-\mathbb E\cos(tY)
 \ge c\frac{\sigma^2t^2}{1+(1+\sigma)^2t^2}. \tag{4}
\]

At \(t_0=\pi/\mu\), \(1+\Re\phi(t_0)\le\sigma^2\pi^2/(2\mu^2)\) by the quadratic bound for \(1-\cos\). For \(t\ge C_0/\mu\), (4) and \(1-|\phi|\ge(1-|\phi|^2)/2\) make \(1+\Re\phi(t)\) strictly larger than this trial bound, for sufficiently large fixed \(C_0\) and then sufficiently large \(\mu\). This uses \((1+\sigma)^2=O(\mu)\). For \(0<t\le C_0/\mu\), (3) and expansion of \(\mathbb E\cos(tY)\) give uniformly
\[
 1-|\phi(t)|=(1+O_{C_0}(1/\mu))\,\sigma^2t^2/2 .
\]
This excludes \(t\ge(1+\epsilon)\pi/\mu\) up to \(C_0/\mu\) for any fixed \(\epsilon>0\). For \(0\le t\le(1-\epsilon)\pi/\mu\), \(\phi(t)=e^{it\mu}(1+O(\sigma^2t^2))\), so \(\Re\phi(t)\) exceeds the trial value there as well. Finally, for \(s=1,2\) and \(t\le C_0/\mu\),
\[
 \mu^{-s}\mathbb E X^s e^{itX}=e^{it\mu}+O_{C_0}(\mu^{-1/2}).
\]
Indeed \(\mathbb E|X/\mu-1|\le\sigma/\mu\) and \(\mathbb E|X^2/\mu^2-1|\le2\sigma/\mu+\sigma^2/\mu^2\). For small fixed \(\epsilon\), \((\Re\phi)''(t)>0\) throughout the remaining interval, proving uniqueness and the first two signs of (2). At its interior minimum \(\mathbb E X\sin(t_*X)=0\). Writing \(\delta=X-\mu\),
\[
 \mathbb E\delta e^{it\delta}=it\sigma^2+O(t^2\sigma^2(1+\sigma)).
\]
Thus \(\mathbb E\delta\sin(t_*X)=t_*\sigma^2\{\cos(\mu t_*)+o(1)\}<0\), yielding the last sign in (2).

### The Poisson tail and the angular bound

Take \(X\) to be Poisson with parameter \(r\), conditioned on \(X\ge j\). Its log-concave probabilities are \(p_k=r^k/(k!B_j(r))\) for \(k\ge j\). Then \(B_j(re^{it})/B_j(r)=\phi(t)\). Its mean satisfies \(\mu=r+jp_j\ge j\), and \(\mathbb E X(X-1)=r\mu+j(j-1)p_j\) by shifting the series. Hence
\[
 \sigma^2-\mu=jp_j(j-1-\mu)\le0 .
\]
Consequently the preceding lemma gives all signs in (1), uniformly for sufficiently large \(j\).

It remains to put the upper saddle strictly before \(\pi/j\), including when \(r\) is tiny and \(\mu\) is very close to \(j\). Put \(U=X-j\), \(m=\mathbb EU\). Any log-concave nonnegative integer law has
\[
 \mathbb E U^b\le C_b m(1+m)^{b-1},\qquad b\ge1. \tag{5}
\]
For a proof, its tails \(q_i=\Pr(U\ge i)\) are log-concave by convolution with a one-sided sequence of ones (or by decreasing tail ratios). For \(D=\lceil 2(1+m)\rceil\), \(q_D\le m/D\le1/2\), so \(q_{i+D}\le q_i/2\). The tail-sum formula for the \(b\)th moment, partitioned into blocks of length \(D\), is at most \(C_bD^{b-1}\sum_{i=1}^Dq_i\le C_b D^{b-1}m\).

If \(m\ge\epsilon j\), take the relative error in \(t_*=(1+o(1))\pi/\mu\) smaller than \(\epsilon/2\) to conclude \(t_*<\pi/j\). For \(0<m<\epsilon j\), (5) gives
\[
 \frac{\mathbb E[XU^3]}{\mathbb E[XU]}
 \le C(1+m)^2(1+(1+m)/j).
\]
Here the numerator is \(j\mathbb EU^3+\mathbb EU^4\), and the denominator is at least \(jm\). Since \(\sin v\ge v-v^3/6\) for \(v\ge0\), choosing \(\epsilon>0\) sufficiently small and \(j\) sufficiently large gives \(\mathbb E[X\sin(\pi U/j)]>0\). Thus \((\Re\phi)'(\pi/j)>0\). In this second range \(\pi/j\) and \(t_*\) both lie in a fixed small relative neighborhood of \(\pi/\mu\) on which \((\Re\phi)''>0\), so \(t_*<\pi/j\) also here. The Poisson tail at positive radius always has \(m>0\).

At fixed such \(j\), simplicity of the angular minimum makes its branch smooth in \(r>0\). Set \(\tau=-1/H\) and \(\psi=\Im B_j/H-\theta\). Differentiating angular stationarity and the saddle value gives
\[
 \frac{dH}{d\log r}=\frac{|K|^2}{\Re K}<0,\qquad
 \frac{d\psi}{d\tau}=-\Im B_j<0 .
\]
At zero the power-series expansion gives \(\theta\to\pi/j\), \(\tau\to\infty\), and \(\psi\to-\pi/j\). At infinity, \(\mu\sim r\), so \(r\theta\to\pi\) by the characteristic-function lemma. Then \(H=z(e^z-\sum_{a=0}^{j-2}z^a/a!)\sim-r e^r\), \(B_j/H=O(1/r)\), \(\tau\to0\) and \(\psi\to0\). Thus the unwrapped phase sweeps the full required interval for degree \(\lfloor n/j\rfloor\).
