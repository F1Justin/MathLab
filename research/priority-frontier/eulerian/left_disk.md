# Every zero in a fixed disk is eventually real

Let \(H_n(x)=\sum_j A(n,j)A_j(x)\) be the row polynomial of the ordinary Eulerian matrix square in the shifted convention \(A(n,j)=E(n,j-1)\), \(A_j(x)=\sum_kA(j,k)x^k\). Mao and Wang conjecture that these polynomials are real-rooted in every degree. [Mao and Wang, §4](https://arxiv.org/html/2607.01572v1)

**Theorem.** For each fixed \(R>0\), all sufficiently large \(n\) have the following property. Every zero of \(H_n\) in \(|x|\le R\) is simple and real. The zero at the origin is simple for every \(n\), and every other real zero is strictly negative. In particular, along any sequence of nonreal zeros with \(n\to\infty\), the moduli must tend to infinity.

The proof uses two earlier results. First, the [rising-factorial row and phase theorems](factorial_symbol.md) give
\[
 G(z)=z\sum_{j=1}^n j! A(n,j)z^j
     =n!\prod_{i=1}^{n+1}(z+\lambda_i),\qquad \lambda_i\ge0.
\]
Exactly two of the \(\lambda_i\) vanish. The phase
\(\Phi(t)=\sum_i\arg[-(1+e^t)/(t+\pi i)+\lambda_i]\), with each argument in \((0,\pi)\), increases strictly on \(\mathbb R\). Second, for every fixed \(C>0\), the [smallest-modulus root theorem](paired_edge.md) identifies the first \(\lfloor C\sqrt n\rfloor\) nonzero roots in absolute rank as simple negative roots, for sufficiently large \(n\). We connect these initial roots to the fixed annuli by counting zeros on entire circles.

## The two nearest poles on a circle

Fix \(1\le T\le c\sqrt n\) with an absolute constant \(c\in(0,1)\) to be chosen sufficiently small. On the upper semicircle write \(x=e^{-T+i\alpha}\), \(0\le\alpha\le\pi\), \(1-x=a-ib\), and put
\[
 \beta_l=\alpha+2\pi l,\qquad
 \zeta_l=\frac{a-ib}{T-i\beta_l},\qquad
 q_l=\frac{|\zeta_l|}{|\zeta_0|}
     =\sqrt{\frac{T^2+\alpha^2}{T^2+\beta_l^2}} .
\]
The exact Eulerian partial fractions yield \(H_n(x)=\sum_{l\in\mathbb Z}G(\zeta_l)\), absolutely convergently. In particular, \(\zeta_0=\int_0^1 x^u\,du\) for the branch \(\log x=-T+i\alpha\). Its imaginary part is positive when \(0<\alpha\le\pi\), and at \(\alpha=0\) it is a positive real number.

For all \(l\), \(\operatorname{Re}\zeta_l\le \operatorname{Re}\zeta_0\). To check this, \(\operatorname{Re}\zeta_l=(aT+b\beta_l)/(T^2+\beta_l^2)\) with \(a>0,b\ge0\). For \(\beta\ge\alpha\) its derivative has numerator \(b(T^2-\beta^2)-2aT\beta\le0\), as \(bT\le a\alpha\) follows from \(Te^{-T}\le1-e^{-T}\) and \(\sin\alpha\le\alpha\). Negative \(\beta_l\) have \(|\beta_l|\ge\alpha\), and replacing them by their absolute values can only increase the real part.

Let \(r=|\zeta_0|\). Uniformly on the semicircles, \(r\) lies between \(c_1/\sqrt n\) and \(2\) for an absolute \(c_1>0\), independent of the choice \(c\le1\). For all large \(n\),
\[
 \sum_{i:\lambda_i>0}\left(\frac r{r+\lambda_i}\right)^2\ge c_2 n
 \tag{1}
\]
with an absolute \(c_2>0\). Indeed with \(c_j=j! A(n,j)\),
\(rG'(r)/G(r)=1+\sum j c_j r^j/\sum c_jr^j\). The mean index in the second term is increasing in \(r\), since its derivative with respect to \(\log r\) is its variance. Evaluate the mean at \(r_0=c_1/\sqrt n\). The total of the terms with \(j\le n/2\) is at most \(n\,n!\max(1,(nr_0)^{n/2})\). Put \(h=\lfloor n/(3\log n)\rfloor\). The Eulerian lower bound \(A(n,n-h)\ge(h+1)^n/2\) from the [coefficient concentration proof](density_one.md) gives
\[
 c_{n-h}r_0^{n-h}\ \ge\ \tfrac12 n!\,n^{-h}(h+1)^n r_0^{n-h}.
\]
After division by \(n!\), the logarithms of the upper and lower bounds are at most \(\tfrac14 n\log n+O(n)\) and at least \(\tfrac12n\log n-n\log\log n-O(n)\), respectively. Thus the mean is at least \(n/3\) for large \(n\). Now \(rG'(r)/G(r)=\sum_i r/(r+\lambda_i)\); omit the two zero factors and apply Cauchy–Schwarz to get (1).

The real-part comparison gives
\[
 \frac{|\zeta_l+\lambda|^2}{|\zeta_0+\lambda|^2}
 \le 1-(1-q_l^2)\left(\frac r{r+\lambda}\right)^2,\qquad \lambda\ge0 .
\]
Use (1) on the nonzero factors and keep the exact ratio \(q_l\) on each zero factor. For an absolute \(\gamma>0\),
\[
 \left|\frac{G(\zeta_l)}{G(\zeta_0)}\right|
 \le q_l^2\,\exp[-\gamma n(1-q_l^2)]. \tag{2}
\]
Uniformly, the sum of (2) over \(l\ne0,-1\) is less than \(1/4\) for large \(n\) if \(c\) is sufficiently small. In detail \(\beta_l^2-\alpha^2\gg l^2\) for \(l\ge1\) or \(l\le-2\). For \(1\le |l|\le T\), the exponent is at most \(-c_3 n l^2/T^2\) with absolute \(c_3>0\); the Gaussian tail sum is as small as desired when \(T\le c\sqrt n\). For \(|l|>T\) the exponent is at most \(-c_4 n\), and \(\sum_l q_l^2=O(T)\) by comparison with the integral of \(T^2/(T^2+u^2)\).

## Counting at a phase maximum or minimum

Choose one of the radii for which \(\Phi(-T)=j\pi\) is an integral multiple of \(\pi\). We claim that the open disk \(|x|<e^{-T}\) contains exactly \(j\) zeros with multiplicity and its boundary is zero-free. For the remaining pole put \(Q(\alpha)=G(\zeta_{-1})/G(\zeta_0)\), \(y=\pi-\alpha\). In (2) we now have
\[
 1-q_{-1}^2=\frac{4\pi y}{T^2+(2\pi-\alpha)^2}\gg y/T^2 .
\]
Fix a sufficiently large absolute \(D\). For \(y\ge DT^2/n\), we have \(|Q|\le1/2\).

For \(0\le y\le DT^2/n\), choose \(c\) smaller so that \(Dc^2\) is small. At \(\alpha=\pi\), conjugacy and the phase condition give \(Q(\pi)=1\). Reflection across \(\pi\) gives \(Q(\pi+y)=1/\overline{Q(\pi-y)}\), so the local continuously unwrapped argument of \(Q\), zero at \(\pi\), has vanishing first derivative there. In an absolute neighborhood \(|\alpha-\pi|\le\epsilon\), both \(\zeta_0,\zeta_{-1}\) have positive real parts, uniformly for \(T\ge1\). Indeed \(aT\ge1\) there for \(\epsilon\le1/4\), while \(|b\beta_l|\le e^{-1}\epsilon(\pi+\epsilon)<1\) for these two poles. Thus \(|\zeta_l+\lambda|\ge (|\zeta_l|+\lambda)/\sqrt2\). Their first and second derivatives satisfy
\[
 |\zeta_l'/\zeta_l|=O(T^{-1}),\qquad
 |\zeta_l''/\zeta_l|=O(T^{-2}).
\]
These follow by differentiating the numerator \(1-e^{-T+i\alpha}\), whose derivatives cost \(O(e^{-T})\), and the reciprocal denominator. Differentiating the factorization twice consequently gives \(|(\log G(\zeta_l))''|=O(n/T^2)\). Taylor's theorem bounds
\[
 |\arg Q(\alpha)|\le C n y^2/T^2\le C D^2 c^2 .
\]
Choose \(c\) sufficiently small that the last bound is at most \(\pi/3\) and \(Dc^2\le\epsilon\). Then \(\operatorname{Re}Q\ge0\) throughout this endpoint segment.

Combining both segments with the \(1/4\) bound for the other poles yields \(\operatorname{Re}(H_n(x)/G(\zeta_0))>0\) on the whole upper semicircle. At its two endpoints the quotient is positive real: at the negative endpoint \(G(\zeta_0)\) is real by the phase condition. The continuous change of argument of the quotient is therefore zero. The change of argument of \(G(\zeta_0)\) from the positive to the negative endpoint is exactly \(\Phi(-T)=j\pi\), using the argument of each factor in the upper half-plane. Complex conjugation gives another \(j\pi\) on the lower semicircle. The argument principle proves the claimed zero count.

## Joining the counted disks

The integral phase values in \(\Phi([-c\sqrt n,-1])\) correspond to consecutive integers \(j\), and their radii increase with \(j\). Write \(j_0\) for the smallest such integer. At \(t=-c\sqrt n\), every factor argument is at most the argument of \(z(t)\), which is \(\arctan(\pi/(c\sqrt n))\). Hence \(j_0\le1+(n+1)\arctan(\pi/(c\sqrt n))/\pi=O_c(\sqrt n)\). Choose a fixed \(C\) larger than that bound after division by \(\sqrt n\). The smallest counted disk has exactly \(j_0\) roots including zero; the smallest-modulus root theorem therefore guarantees that all of them are simple and real. Each annulus between two consecutive counted circles then has exactly one zero counted with multiplicity. Real coefficients force this zero to be real, and positivity of all coefficients in positive degrees makes it negative.

The largest counted radius exceeds \(e^{-2}\) for all sufficiently large \(n\), since \(\Phi'\gg n\) on \([-2,-1]\) by the [compact-interval phase estimate](factorial_symbol.md). All zeros of modulus at most \(e^{-2}\) are therefore covered. On the remaining fixed annulus \(e^{-2}\le |x|\le R\), when nonempty, the compact-annulus theorem in the same note gives simple negative zeros. This proves the disk theorem.
