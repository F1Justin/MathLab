# Prescribed summable lower profiles for the WT support radius

**Theorem.** Given any nonnegative summable sequence \((u_m)_{m\ge1}\), there exists one deterministic strong WT witness with \((v,\sigma,\alpha,\beta)=(1,2,1,2)\), bounded positive window \(w\) on \([0,1]\), and autocorrelation \(A=w*\widetilde w\), satisfying the following estimate. For every sufficiently large \(R\) and every real even mass-one window supported in \([-R,R]\) with nonnegative autocorrelation \(B\),
\[
            R^2\|A-B\|_\infty\ \ge\ c\,u_{\lceil\log_2 R\rceil}.
\]
The positive constant, the starting radius and the input can depend on \(u\). In particular, for each \(\eta>0\) there is such a fixed witness with
\[
 \|A-B\|_\infty\ge
 \frac{c_\eta}{R^2\log R\ \log\log R\ (\log\log\log R)^{1+\eta}}
\]
for all sufficiently large \(R\). Choose \(u_m=1/[m\log(m)(\log\log m)^{1+\eta}]\) for large \(m\), with any finite initial values. The input here is obtained from an existence theorem. An [explicit bounded example](rudin_shapiro_radius.md) uses Rudin–Shapiro polynomials.

## Prescribing the derivative

Let \(a_m=\max\{\sqrt{u_m},m^{-3/4}\}\), an \(\ell^2\) sequence. Choose a continuous function \(H\) on the unit circle having no negative Fourier coefficients and satisfying \(|\widehat H(m)|\ge a_m\) for all \(m\ge1\). This is Kislyakov's one-sided strengthening of the de Leeuw–Katznelson–Kahane majorant theorem. The one-sided spectrum prevents cancellation against the reflected frequencies when a real window is formed. [Kislyakov, Introduction, p. 148](https://www.numdam.org/item/10.5802/aif.1138.pdf#page=2)

Choose a fixed \(\lambda>0\) so small that \(\lambda\|H\|_\infty\le1/16\). For \(0\le x\le1/2\) define
\[
 g_0(x)=1+\lambda\Re\{e^{2\pi i x}H(e^{4\pi i x})\},
 \qquad g=g_0\left/(2\int_0^{1/2}g_0)\right. .
\]
Thus \(15/17\le g\le17/15\), and two translates of \(g\) give a mass-one window. Write \(N_m=2\pi(2m+1)\), \(G(z)=\int_0^{1/2} g(x)e^{-izx}\,dx\), and \(G_m=G(N_m)\). By the substitution \(t=2x\), the two parts of the real term before normalization have Fourier coefficients \(\widehat H(m)/4\) and \(\overline{\widehat H(-m-1)}/4=0\). In particular
\[
 G_m=\frac{2/(iN_m)+\lambda\widehat H(m)/4}{2\int_0^{1/2}g_0},
 \qquad |G_m|\ge c_0 a_m
\]
for all sufficiently large \(m\), since \(m a_m\to\infty\). Also \(|G_m|\le1/2\).

## Prescribing the zero separation

Repeat \(g\) on both halves of \([0,1]\) and add the real perturbation
\[
 p(x)=2\Re\sum_{m\ge1} \tau_m G_m e^{iN_m x},
 \qquad \tau_m=2^{-m}/16 .
\]
Extend the resulting \(w\) by zero off \([0,1]\). The perturbation is real analytic, has integral zero on \([0,1]\), and satisfies \(\|p\|_\infty\le1/16\). Hence \(w\) is positive, has mass one and \(\|w\|_\infty<2\), so \(\int w^2<2\). The table \(\mathbf1_{[-1,2]}\) has squared norm three and its convolution with \(w\) equals one on \([0,2]\). This verifies the strong witness conditions. [Original WT definition](https://arxiv.org/html/2610.36207v1#S2.SS2)

For \(F(z)=\int_0^1 w(x)e^{-izx}\,dx\), the repeated part of the window gives \((1+e^{-iz/2})G(z)\). The perturbation has exactly the coefficient \(\tau_m G_m\) at \(N_m\); its derivative contribution there is \(O(1/m)\) by integration by parts for \(xp(x)\). Therefore
\[
 F(N_m)=\tau_mG_m,\qquad F'(N_m)=iG_m/2+o(|G_m|).
\]
Let \(\delta_m=2\tau_m\). Uniform boundedness of the second derivative on the unit strip gives
\[
 \frac{F(N_m+\delta_m h)}{\tau_mG_m}\to1+ih,
 \qquad
 \frac{F(-N_m-\delta_m h)}{\tau_m\overline{G_m}}\to1-ih
\]
uniformly for bounded complex \(h\); the quadratic remainder after normalization is \(O(\tau_m/|G_m|)=o(1)\). The second limit follows by reality. On \(|h-i|=1/2\) the product of the limiting factors has modulus at least \(3/4\), and exactly one factor has a simple zero in the disk. The transform \(F(z)F(-z)\) consequently has exactly one zero there and boundary modulus at least \(\tau_m^2|G_m|^2/4\) for large \(m\).

The approximating transform is the entire square \(\widehat B=(\widehat V)^2\); by Rouché its maximum boundary difference from \(\widehat A\) is at least the preceding bound. With \(\varepsilon=\|A-B\|_\infty\), nonnegativity, the unit masses and the support of \(A\) give \(\|A-B\|_1=2\int(A-B)_+\le4\varepsilon\). Thus \(4\varepsilon e^{3R\delta_m}\ge\tau_m^2|G_m|^2/4\). Taking \(m=\lceil\log_2 R\rceil\) gives \(1/32<R\tau_m\le1/16\) for \(R>1\). The asserted bound follows.

For this particular Fourier construction its summability hypothesis has a direct interpretation. The odd exponential functions form an orthogonal family on the half-interval, and Bessel's inequality gives \(\sum_m |G_m|^2<\infty\). This observation applies to the constructed sequence of single-disk witnesses. It gives no converse approximation theorem for all possible windows.
