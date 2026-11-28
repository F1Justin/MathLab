# A bounded positive WT input with large support cost at every accuracy scale

There is one explicit deterministic nonnegative WT input \((v,\sigma,\alpha,\beta)=(1,2,1,2)\) with autocorrelation \(A\) such that, for all sufficiently large \(R\), every real even mass-one window supported in \([-R,R]\) with nonnegative autocorrelation \(B\) satisfies
\[
  \|B-A\|_\infty
       \ \ge\ \frac{c}{R^2\,\log R\,(\log\log R)^4}.                  \tag{1}
\]
The earlier [fixed analytic input](fixed_input_radius.md) gives a denominator \(R^2(\log R)^2\). The present input is bounded and piecewise continuous, with a uniform positive lower bound on its support. The improvement comes from prescribing two independent Fourier quantities at each odd frequency.

## Two copies of a bounded density

Use the Rudin–Shapiro polynomials \(P_0=Q_0=1,\ P_{k+1}=P_k+z^{2^k}Q_k,\ Q_{k+1}=P_k-z^{2^k}Q_k\). Their coefficients are signs and on \(|z|=1\) their squared moduli sum to \(2^{k+1}\), by the parallelogram identity. For \(2^k\le m<2^{k+1}\), let \(r_m\) be the coefficient indexed \(m-2^k\) in \(P_k\), and put \(d_m=2^{-k/2}/(k+1)^2\). For each \(m\ge1\) write \(N_m=2\pi(2m+1)\). On \(0\le x\le1/2\) set
\[
       g(x)=1+\frac1{16}\sum_{k\ge0}\ \sum_{m=2^k}^{2^{k+1}-1}
                                r_m d_m\cos(N_m x).
\]
The \(k\)-th block before the factor \(1/16\) has uniform norm at most \(\sqrt2/(k+1)^2\): its complexification is \(d_{2^k}\) times a unit phase times \(P_k(e^{4\pi ix})\). The series of blocks converges uniformly, and \(\|g-1\|_\infty<1/4\). Each cosine has integral zero over \([0,1/2]\). [Rudin's original polynomial construction](https://doi.org/10.2307/2033609)

Repeat \(g\) on both halves of \([0,1]\), with either value at the common endpoint, and add
\[
       p(x)=\frac18\sum_{m\ge1}r_m2^{-m}\cos(N_m x).
\]
Call the resulting function \(w\) on \([0,1]\), extended by zero elsewhere. Its integral is one and \(5/8\le w\le11/8\) on the support. Thus \(\int w^2\le(11/8)\int w<2\). Taking the table \(\mathbf1_{[-1,2]}\) gives a deterministic nonnegative WT witness as in the previous note.

## Zeros at the prescribed scales

Write \(G(z)=\int_0^{1/2}g(x)e^{-izx}\,dx\), \(F(z)=\widehat w(z)\), and let \(F_0(z)=(1+e^{-iz/2})G(z)\) be the transform before adding \(p\). Orthogonality of the odd exponentials on the half-interval gives exactly
\[
     G(N_m)=\frac{2}{iN_m}+\frac{r_m d_m}{64},\qquad
     F_0(N_m)=0,\qquad F'_0(N_m)=\frac1{N_m}+\frac{i r_m d_m}{128}.
\]
On \([0,1]\) the perturbation has Fourier coefficient \(r_m e_m\), where \(e_m=2^{-m}/16\). Its derivative contribution to \(F'(N_m)\) is \(O(1/N_m)\) by integration by parts for \(x p(x)\). Since \(N_m d_m\to\infty\),
\[
        F(N_m)=r_m e_m,\qquad F'(N_m)=i r_m d_m/128+o(d_m).
\]
Put \(\delta_m=128 e_m/d_m\). The second derivative of \(F\) is uniformly bounded in the unit strip, and \(\delta_m^2/e_m=O(2^{-m}/d_m^2)\to0\). Uniformly on any fixed compact \(h\)-disk,
\[
 \frac{F(N_m+\delta_mh)}{r_m e_m}\longrightarrow 1+ih,\qquad
 \frac{F(-N_m-\delta_mh)}{r_m e_m}\longrightarrow 1-ih.
\]
The second relation uses the reality of \(w\). On \(|h-i|=1/2\), the first limiting factor has one zero inside and the second has none. Rouché's theorem gives exactly one zero for \(\widehat A=F(z)F(-z)\) and a boundary modulus at least \(e_m^2/4\) for large \(m\).

For all sufficiently large \(m\) one has \(1/2\le\delta_{m+1}/\delta_m\le9/10\). Inside a block the ratio equals \(1/2\). Across a block boundary it equals \(2^{-1/2}(k+2)^2/(k+1)^2\), which tends to \(2^{-1/2}\). For large \(R\) choose the first sufficiently large \(m\) with \(\delta_m\le1/(2R)\). Then \(\delta_m\ge1/(4R)\) and \(m=O(\log R)\). Moreover \(d_m\ge c_1/[\sqrt m\,(\log(m+1))^2]\), so
\[
          e_m=\delta_m d_m/128
          \ge\frac{c_2}{R\sqrt{\log R}\,(\log\log R)^2}.
\]
The entire square \(\widehat B\) has an even zero count in every disk whose boundary is zero-free. The one-zero disk above requires \(\sup_{\Gamma_m}|\widehat B-\widehat A|\ge e_m^2/4\). On that same circle this difference is bounded by \(4e^{3R\delta_m}\|B-A\|_\infty\), using the supports, masses and nonnegativity as in the [analytic-input proof](fixed_input_radius.md). This proves (1).

## A single input for every logarithmic exponent above two

In the same construction replace \((k+1)^{-2}\) in \(d_m\) by
\(h_k=[(k+2)(\log(k+2))^2]^{-1}\). The integral test gives
\(\sum_{k\ge0}h_k\le 1/[2(\log2)^2]+1/\log2<5/2\), so the same \(1/16\) keeps \(\|g-1\|_\infty<1/4\). The ratio \(h_k/h_{k+1}\) tends to one, which again bounds the eventual scale ratios between \(1/2\) and \(9/10\). For all large \(m\),
\[
 d_m\ge \frac{c}{\sqrt m\,\log m\,(\log\log m)^2}.
\]
All the Fourier identities and the two zero counts above hold with the new coefficients. Substitution gives the single-input estimate
\[
 \|B-A\|_\infty\ge
 \frac{c}{R^2\log R\,(\log\log R)^2\,(\log\log\log R)^4}.
\]
In particular this one bounded input satisfies, for each \(\eta>0\), a lower bound \(c_\eta/[R^2\log R\,(\log\log R)^{2+\eta}]\) for all sufficiently large \(R\).
