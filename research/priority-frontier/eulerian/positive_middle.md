# The positive logarithmic transition by factorial-row variance

Let \(H_n\) be row \(n\) of the ordinary Eulerian matrix square in the [Mao–Wang convention](https://arxiv.org/html/2607.01572v1). We use the exact factorization \(G(z)=z\sum_{j=1}^n j!A(n,j)z^j=n!\prod_{i=1}^{n+1}(z+\lambda_i)\) from the [factorial-row theorem](factorial_symbol.md). All \(\lambda_i\ge0\), and two are zero.

**Theorem.** Fix \(\epsilon>0\). Along any sequence \(n\to\infty\) and any zeros \(x_n\) of \(H_n\) such that \(T=\log|x_n|\to+\infty\) and \(T\le n^{1/2-\epsilon}\), the zeros \(x_n\) are eventually simple and negative.

## Tilted factorial row

Throughout let \(0\le\alpha\le\pi\), \(x=e^{T+i\alpha}\), \(N=x-1\), \(r=|N/(T+i\alpha)|\), \(D=\log(nr)\) and \(K=n/T^2\). In fact the variance estimates below apply whenever \(T\to\infty\) and \(T=o(\sqrt n)\). Uniformly \(r\sim e^T/T\), \(D=T+\log n-\log T+o(1)\), and \(s=\sqrt n/D\to\infty\). Under the positive tilt of coefficient \(j!A(n,j)\) by \(r^j\), let \(h=n-j\). We claim
\[
 \mathbb E h\sim n/D,\qquad \operatorname{Var} h\sim n/D^2. \tag{1}
\]

After removing the common factor \(r^n\) the weights are \((n-h)!E(n,h)r^{-h}\) for \(0\le h<n\). They are bounded above by \(W_h=(n-h)!(h+1)^n r^{-h}\). The Eulerian bin bound gives the upper inequality, while its exact inclusion–exclusion formula implies
\[
 \left|\frac{E(n,h)}{(h+1)^n}-1\right|
 \le \exp\big((n+1)e^{-n/(h+1)}\big)-1 .
\]
Indeed the \(j\)-th omitted summand has absolute relative magnitude at most \(\binom{n+1}{j}e^{-nj/(h+1)}\).

The logarithmic forward ratio of \(W\) is
\[
 L_h=n\log(1+1/(h+1))-\log(r(n-h)).
\]
For integer \(h\) near \(n/D\), \(L_h-L_{h+1}\sim n/h^2\); this follows by differencing and \(h=o(n)\). More generally this difference lies between \(c D^2/n\) and \(C D^2/n\) when \(n/(3D)\le h\le3n/D\), for positive absolute constants. Since \(L_{\lfloor(1-\delta)n/D\rfloor}>0>L_{\lceil(1+\delta)n/D\rceil}\) for each fixed \(0<\delta<1/2\) eventually, there is a mode \(H\sim n/D\) in this interval with \(L_{H-1}\ge0\ge L_H\). In particular \(L_H=O(s^{-2})\) and \(n/(H+1)=D+o(1)\), the latter by the ratio identity, \(H/n=o(1)\) and \(n/H^2=o(1)\). For bounded real \(y\), uniformly at \(h=H+\lfloor s y\rfloor\),
\[
 \frac{W_h}{W_H}\longrightarrow e^{-y^2/2},\qquad
 (n+1)e^{-n/(h+1)}\sim r^{-1}\to0 .
\]
The first limit follows by summing the ratio differences, each \((1+o(1))/s^2\) locally; the second follows because an \(O(s)\) shift costs \(O(1/s)\) in \(n/(h+1)\).

On \(H/2\le h\le2H\), the ratio differences give a Gaussian upper bound \(C\exp[-c(h-H)^2/s^2]\) for \(W_h/W_H\). Outside this interval \(W_h/W_H\le e^{-c' n}\) uniformly eventually. To see the lower tail, use the factorial ratio \((n-h)!/(n-H)!\le n^{H-h}\), giving \(\log(W_h/W_H)\le n\log((h+1)/(H+1))+(H-h)D\). Its maximum on \(h\le H/2\) occurs at the upper end for large \(n\), and is at most \((\log(1/2)+1/2+o(1))n\). For \(h\ge2H\) use \((n-h)!/n!\le(e/n)^h\), which follows by averaging \(\log l\) over the largest \(h\) integers \(1,\ldots,n\) and \(n!\ge(n/e)^n\). Since \((n-H)!/n!\ge n^{-H}\), the log ratio is at most \(n\log((h+1)/(H+1))-(h-H)D+h\). This expression is decreasing on \(h\ge2H\) and is at most \((\log 2-1+o(1))n\). These bounds imply convergence of the normalized first two moments of \((h-H)/s\) to those of the standard Gaussian, by Riemann sums and Gaussian domination. They prove (1).

Writing \(t_i=\lambda_i/(r+\lambda_i)\), differentiation of the product for \(G\) gives
\[
 \sum_i t_i=\mathbb E h=:m=O(n/T),\qquad
 \sum_i t_i(1-t_i)=\operatorname{Var} h=:V\le (1+o(1))K .
 \tag{2}
\]
In particular the number of near factors \(r/2\le\lambda_i\le2r\) is at most \((9/2)V\). These statements are uniform in \(\alpha\), as the preceding argument holds along every sequence of angles.

## Competing poles

Put \(\beta_l=\alpha+2\pi l\), \(\zeta_l=N/(T+i\beta_l)\), \(q_l=|\zeta_l/\zeta_0|\). By the exact Eulerian partial fractions, \(H_n(x)=\sum_l G(\zeta_l)\). The nearest pole \(\zeta_0=\int_0^1 x^u\,du\), with branch \(T+i\alpha\), lies in the open upper half-plane for \(0<\alpha\le\pi\), and is positive at \(\alpha=0\). Thus \(G(\zeta_0)\ne0\).

For \(l\ne0,-1\),
\[
 \sum_{l\ne0,-1}|G(\zeta_l)/G(\zeta_0)|\le e^{-\gamma K} \tag{3}
\]
for some absolute \(\gamma>0\) eventually along the sequences of the theorem. We give the constants that ensure suppression of the first competing poles. Each ratio has the exact form
\[
 q_l^{n+1}
 \prod_{\lambda_i>0}\frac{|T+i\beta_l+N/\lambda_i|}{|T+i\alpha+N/\lambda_i|}.
\]
For a near factor the quotient is at most \(1+4|l|\). If \(\alpha\ge\pi/2\), the imaginary part of the denominator is at least \(\pi/2\), since \(\operatorname{Im}N\ge0\). Otherwise its real part is at least \(T-1/\lambda_i\ge\pi/2\) eventually.

For a far factor \(\lambda=\lambda_i>0\) outside \([r/2,2r]\), the denominator has modulus at least \(cT(r+\lambda)/\lambda\) by the reverse triangle inequality. Put \(v=\alpha+\operatorname{Im}N/\lambda\ge0\). For a real increment \(b=2\pi l\), its log gain is at most
\[
 \frac{|b|v+b^2/2}{|T+i\alpha+N/\lambda|^2}.
\]
This follows by taking \(\log(1+x)\le x\) in the squared quotient (a vanishing numerator only improves the estimate). Use \(|N|=r\sqrt{T^2+\alpha^2}=O(rT)\). Summing over far factors bounds their total gain by
\[
 O\!\left(|l| V/T+(|l|+l^2)m/T^2\right)=O(l^2 K/T)
\]
using (2); the term containing \(\operatorname{Im}N\) uses \(\lambda r/(r+\lambda)^2=t_i(1-t_i)\).

Fix a sufficiently small positive absolute \(\delta\), say \(\delta=1/100\). For \(|l|\le\delta T\) and \(l\ne0,-1\), \(\beta_l^2-\alpha^2\ge 2\pi^2 l^2\). From \(\log(1+y)\ge y/(1+y)\), for all large \(T\),
\[
 -(n+1)\log q_l\ \ge\ \frac{(n+1)(\beta_l^2-\alpha^2)}{2(T^2+\beta_l^2)}
 \ \ge\ 9 K l^2 .
\]
The near factors contribute at most \((9/2)(1+o(1))K\log(1+4|l|)\), strictly less than \(8K l^2\) eventually since \((9/2)\log5<8\). The far gain is \(o(K l^2)\). The summed bound on these integer \(l\) is exponentially small in \(K\).

For \(|l|>\delta T\), \(q_l\le1-c_\delta\) eventually and \(\sum_l q_l^2=O(T)\). We have \(|G(\zeta_0)|\ge G(r)\exp[-O(K\log T)]\): for the far factors their squared ratio \(|\zeta_0+\lambda|^2/(r+\lambda)^2=1-4t_i(1-t_i)\sin^2(\arg\zeta_0/2)\) is bounded away from zero, giving a total log loss \(O(V)\). For a near factor the ratio in modulus is at least \(c/T\), by the same denominator estimate \(|T+i\alpha+N/\lambda|\ge\pi/2\) used above. Their count is \(O(K)\). On the other hand
\[
 G(q_l r)/G(r)\le q_l^2\exp[-(1-q_l)\sum_{\lambda_i>0}(1-t_i)] .
\]
Here the two zero factors were extracted and the sum is \(n-1-m\sim n\). Since \(K\log T=o(n)\), summing the absolute ratios gives \(O(T)e^{-c_\delta' n}\). This proves (3).

The remaining pole \(l=-1\) satisfies \(\operatorname{Re}\zeta_{-1}\le\operatorname{Re}\zeta_0\) for large \(T\). Indeed write \(N=a+ib\), with \(b=e^T\sin\alpha\). The sign of \(\operatorname{Re}\zeta_0-\operatorname{Re}\zeta_{-1}\) is the sign of
\[
 2aT(\pi-\alpha)+b\big(T^2+\alpha(2\pi-\alpha)\big).
\]
For \(\alpha\ge\pi/2\), \(\sin\alpha\ge2(\pi-\alpha)/\pi\) and \(a\ge-e^T-1\) suffice. For \(\alpha\le\pi/2\), if \(a\ge0\) both terms are nonnegative; if \(a<0\), then \(\alpha\ge\pi/3\) eventually and \(a\ge-1\). Thus the displayed expression is nonnegative throughout. As in the [disk proof](left_disk.md) the comparison of each shifted squared modulus gives
\[
 |G(\zeta_{-1})/G(\zeta_0)|\le\exp[-c_1 n(1-q_{-1}^2)]
 \le\exp[-c_2 K(\pi-\alpha)] . \tag{4}
\]
In fact \(\sum_i(1-t_i)^2\gg n\) by (2) and Cauchy–Schwarz; the modulus ratio squared of each factor is at most \(1-(1-q_{-1}^2)(1-t_i)^2\). Finally \(1-q_{-1}^2=4\pi(\pi-\alpha)/(T^2+(2\pi-\alpha)^2)\).

## Confinement and simple roots at the real phase centers

By conjugation consider \(0\le\alpha\le\pi\) and set \(y=\alpha-\pi\le0\). At a zero of \(H_n\), (3)–(4) imply \(1-e^{-c_2K|y|}\le e^{-\gamma K}\). In particular \(|y|\le C e^{-\gamma K}/K\). Under \(T\le n^{1/2-\epsilon}\), \(K\ge n^{2\epsilon}\), so this bound is smaller than any negative fixed power of \(n\).

Introduce the complex coordinate \(s\) by \(x=-e^s\). In a neighborhood of \(T\) put
\[
 Z_\pm(s)=-\frac{1+e^s}{s\pm i\pi},\qquad
 \Psi(s)=\frac{\log G(Z_+(s))-\log G(Z_-(s))}{2i}.
\]
Choose conjugate logs at the real center so that \(\Psi(T)=\Phi(T)\), the real increasing phase of the [factorial-row theorem](factorial_symbol.md). On \(|s-T|\le n^{-5}\) all logarithms exist. Indeed at \(T\) the angle of \(Z_\pm\) has distance \(\arctan(\pi/T)\) to the negative real axis, giving \(|Z_\pm(T)+\lambda|\gg(r+\lambda)/T\) for every \(\lambda\ge0\), where here \(r=|Z_\pm(T)|\). Their first two derivatives in \(s\) are \(O(r)\) uniformly on that disk, so the same separation holds there. Consequently the absolute values of the first two logarithmic derivatives of \(G(Z_\pm)\) are \(O(nT)\) and \(O(nT^2)\).

On the real axis the positive factorwise phase derivative formula gives
\[
 \Phi'(T)\ge\frac{\pi}{T^2+\pi^2}\sum_i\frac{r^2}{(r+\lambda_i)^2}\gg K .
\]
Here the other numerator term \(\lambda_i(\operatorname{Im}Z_+)'(T)\) is nonnegative, and (2) controls the displayed sum. In particular on \(|s-T|\le n^{-5}\), \(\operatorname{Re}\Psi'(s)\gg K\).

Write \(M(s)=\exp[(\log G(Z_+)+\log G(Z_-))/2]\). On this disk the two pole magnitudes are comparable with ratio \(1+o(1)\), by the \(O(nT)\) logarithmic derivative bound and equality of their real-center magnitudes. The residual \(H_n(-e^s)-G(Z_+)-G(Z_-)\) divided by \(M(s)\) is \(O(e^{-\gamma' K})\) there for an absolute \(\gamma'>0\). Indeed at each \(s=u+iv\) the radius is \(e^u\), the angle in the upper or lower semicircle has distance \(|v|\) from the cut, and the unordered two principal poles are precisely \(Z_\pm(s)\). Apply (3), with conjugation on the lower semicircle. After reducing \(\epsilon\) slightly if necessary, \(u\) meets the same growth hypotheses; \(n/u^2\sim K\). It follows that
\[
 H_n(-e^s)/(2M(s))=\cos\Psi(s)+O(e^{-\gamma' K}).
\]

At the given zero \(s=T+iy\), the distance from \(\Phi(T)\) to a half-integral multiple of \(\pi\) is exponentially small in \(K\), using \(|\Psi(T+iy)-\Phi(T)|=O(nT |y|)\) and the last display. There is a unique real \(\tau\) within \(o(n^{-5})\) of \(T\) at which \(\Phi(\tau)\) equals that half-integral multiple, by the derivative lower bound. On the circle \(|s-\tau|=n^{-6}\), \(|\Psi(s)-\Psi(\tau)|\gg K n^{-6}\), by integrating \(\operatorname{Re}\Psi'\gg K\) on the straight segment after division by \(s-\tau\). The same difference is \(O(nT n^{-6})=o(1)\). Thus \(|\cos\Psi(s)|\gg K n^{-6}\) there, and \(\cos\Psi\) has just one simple zero inside: \(\operatorname{Re}\Psi'>0\) gives injectivity on this convex disk by the same segment integral. Rouché gives exactly one zero of \(H_n(-e^s)\) counted with multiplicity. It is real by conjugation and it is the given zero, which lies at distance \(o(n^{-6})\) from \(\tau\) by the exponential estimates. This proves the theorem.
