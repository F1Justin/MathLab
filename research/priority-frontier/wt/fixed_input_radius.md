# A single positive WT input forcing nearly inverse-square radius error

There is an explicit deterministic nonnegative WT input \(W\), of fixed parameters \((v,\sigma,\alpha,\beta)=(1,2,1,2)\), and constants \(c>0\), \(R_0>1\) with the following property. If \(R\ge R_0\) and a real even window \(V\) of mass one, supported in \([-R,R]\), has nonnegative autocorrelation \(B=V*V\), then
\[
       \|B-A\|_\infty\ \ge\ \frac{c}{R^2(\log R)^2},                \tag{1}
\]
where \(A\) is the input autocorrelation. Thus accuracy \(\epsilon\) for this one input requires \(R\ge c'/(\sqrt\epsilon\log(1/\epsilon))\) as \(\epsilon\downarrow0\). This concerns the actual support radius of an approximating window. The same obstruction applies when a table and all WT inequalities are also required.

## A geometrically spaced sequence of near-real zeros

Take \(t=\mathbf 1_{[-1,2]}\) and, on \([0,1]\), put
\[
 f(x)=1+\tfrac12\sum_{k\ge1}2^{-k}\sin(2\pi kx),\qquad
 w(x)=f(x)\mathbf 1_{[0,1]}(x).
\]
This \(f\) is real analytic on the interval, \(1/2\le f\le3/2\), and \(f(0)=f(1)=1\). Its integral is one, and \(\int w^2=1+1/24\) by orthogonality. The table has squared norm three and equals one on its required plateau. The cover is one throughout \([0,2]\) and \(A=w*\widetilde w\ge0\), with \(\widetilde w(x)=w(-x)\). This verifies the original WT input hypotheses. [Carter–O'Bryant–Tao, Definitions 2.1–2.2](https://arxiv.org/html/2610.36207v1#S2.SS2)

Write \(F(z)=\int_0^1 f(x)e^{-izx}\,dx\), \(N=2\pi n\), \(b_n=2^{-n-2}\), and \(\delta_n=Nb_n\). Exact Fourier coefficients give \(F(N)=-ib_n\). Integration by parts twice for \(x f(x)\), whose endpoint values are zero and one, gives \(F'(N)=1/N+O(N^{-2})\). The second derivative of \(F\) is uniformly bounded on \(|\operatorname{Im}z|\le1\). Taylor's formula and \(N^2 b_n\to0\) therefore give, uniformly for \(h\) in any compact complex disk,
\[
 \frac{F(N+\delta_nh)}{b_n}\longrightarrow h-i,\qquad
 \frac{F(-N-\delta_nh)}{b_n}\longrightarrow h+i .                  \tag{2}
\]
The second limit uses \(F(-\bar z)=\overline{F(z)}\).

In the \(h\)-disk \(|h-i|<1/2\), the two limiting functions have respectively one and zero zeros. Rouché's theorem transfers each count. Since \(\widehat A(z)=F(z)F(-z)\), the corresponding \(z\)-disk contains exactly one zero counted with multiplicity, and its boundary \(\Gamma_n\) satisfies \(\min_{\Gamma_n}|\widehat A|\ge b_n^2/4\) for all large \(n\).

## Radius versus uniform error

The Fourier transform of \(B\) is the entire square \(\widehat V(z)^2\). It cannot have a single zero counted with multiplicity in that disk. Consequently \(\max_{\Gamma_n}|\widehat A-\widehat B|\ge b_n^2/4\). This use of zero parity follows the compact convolution-root criterion. [Ehm, Gneiting and Richards, Theorem 2.1](https://doi.org/10.1090/S0002-9947-04-03502-0)

Set \(\epsilon=\|B-A\|_\infty\). Both autocorrelations are nonnegative of mass one and \(A\) is supported in \([-1,1]\). Hence \(\|A-B\|_1=2\int(A-B)_+\le4\epsilon\). For \(R\ge1\), the difference is supported in \([-2R,2R]\); as \(|\operatorname{Im}z|\le3\delta_n/2\) on \(\Gamma_n\),
\[
            b_n^2/4\ \le\ 4\epsilon\,e^{3R\delta_n}.                \tag{3}
\]
For large \(R\), choose the first index \(n\ge3\) with \(\delta_n\le(2R)^{-1}\). The consecutive ratio \(\delta_n/\delta_{n-1}=n/[2(n-1)]>1/2\), so \(1/(4R)<\delta_n\le1/(2R)\). Also \(n=O(\log R)\), since already \(n=\lceil2\log_2 R\rceil\) satisfies the selection inequality for all sufficiently large \(R\). Thus \(b_n=\delta_n/(2\pi n)\ge c_1/(R\log R)\). Substitution into (3) proves (1). Inverting the increasing function \(R\log R\) gives the asserted bound in \(\epsilon\).

Akwei and Williams quantify width in terms of proximity of the WT objective to its sharp infimum. Formula (1) measures uniform approximation to one prescribed profile. Their exact objective value and the existence of compact-support convolution-root obstructions predate this estimate. [Akwei–Williams v05](https://doi.org/10.5281/zenodo.24326518)
