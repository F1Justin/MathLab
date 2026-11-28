# Sharp minimax and pointwise support-radius rates for WT autocorrelations

Let \(v>0\) and let \(\beta\ge1/v\). Consider finite laws of real windows \(w_i\) with mass one, supported in \([0,v]\), with \(\sum_i p_i\|w_i\|_2^2\le\beta\). Their mean autocorrelation \(A=\sum_i p_i w_i*\widetilde w_i\) is assumed nonnegative. This includes the window profile of every original WT witness of width \(v\) and window budget \(\beta\). For \(R>0\) approximate \(A\) by \(B=V*V\), where \(V\) is real, even, smooth, supported in \([-R,R]\), has mass one, and \(B\ge0\) pointwise. Write \(e_R(A)\) for the infimum of \(\|B-A\|_1+\|B-A\|_\infty\).

**Theorem.** Uniformly over the stated input class, \(e_R(A)\le C(v,\beta)R^{-2}\) for all sufficiently large \(R\). For \(\beta>1/v\) the supremum of \(e_R(A)\) is bounded below by \(c(v)R^{-2}\) for all sufficiently large \(R\) depending on \(v,\beta\). The same two bounds hold for either norm separately, even if the supremum is restricted to valid WT inputs. For every *fixed* \(A\), one has \(R^2e_R(A)\to0\). This limit can be arbitrarily slow along a subsequence, as quantified below. If \(\beta=1/v\), the input window is the uniform density on \([0,v]\) almost surely and the approximation infimum is zero once \(R>v/2\).

**Positive definite densities on the line.** The same statements apply to all continuous nonnegative positive definite densities \(A\) of integral one, supported in \([-v,v]\), with \(A(0)\le\beta\). By the one-dimensional Boas–Kac–Krein factorization, such an \(A\) is the autocorrelation of an \(L^2\) factor supported in an interval of length \(v\). Translate the factor into \([0,v]\) and multiply it by a unit scalar to normalize its integral; \(|\int w|^2=\int A=1\) and \(\|w\|_2^2=A(0)\). The proof below applies also to complex factors with \(\widehat A=|\widehat w|^2\). The same two-cell lower bounds belong to this class. [Ehm–Gneiting–Richards, Theorem 2.1(a)](https://doi.org/10.1090/S0002-9947-04-03502-0)

The estimates concern the support of a symmetric factor of the given autocorrelation. The [simultaneous WT theorem](https://github.com/F1Justin/MathLab/blob/ae92acdcae0f6bd718a9cdfb3e537606f86f0336/papers/wt-derandomization/single-even-window.pdf) also matches a covering profile and two actual cost coordinates, with its own choice of radius.

## A cubic Fourier estimate

Use \(\widehat f(t)=\int e^{-itx}f(x)\,dx\). Set \(P(t)=(\sqrt{p_i}\widehat w_i(t))_i\) and \(F(t)=\|P(t)\|\), so \(F^2=\widehat A\), \(F(0)=1\). For \(k=0,1,2\),
\[
 \int_{\mathbb R}\|P^{(k)}\|^2\le 2\pi v^{2k}\beta
\]
by Plancherel. The vector norm is Euclidean on the realification of the complex coordinates. Thus \(|F'|\le\|P'\|\) almost everywhere and \(F\in H^1\). These bounds are independent of the number of atoms.

We use either \(g=F\), or a signed even root \(g^2=F^2\) specified below. First take \(g=F\). Its derivative has locally bounded variation. For an interval \(J\) of length three,
\[
   |Dg'|(J)\le 2\sup_{\bar J}\|P'\|+2\int_J\|P''\| .               \tag{1}
\]
One can take \(J\) open, or include endpoints by an arbitrarily small enlargement. Indeed \(F_\epsilon=(\|P\|^2+\epsilon^2)^{1/2}\) has \(|F_\epsilon'|\le\|P'\|\) and \(F_\epsilon''\ge-\|P''\|\) by convexity and the bound one on the gradient of the regularized norm. Integrating its second derivative and its negative part proves the variation bound, which passes to the distributional limit. In particular, for \(I_m=[m,m+1]\) and \(J_m=[m-1,m+2]\),
\[
 \sum_m\sup_{J_m}\|P'\|\; |Dg'|(J_m)\le C(v,\beta).               \tag{2}
\]
For this formula one may use the slightly larger open intervals \((m-2,m+3)\) in (1), with the identical endpoint proof for length five. The one-dimensional local Sobolev inequality bounds \(\sum_m(\sup_{J_m}\|P'\|)^2\) by \(C(\|P'\|_2^2+\|P''\|_2^2)\), and bounded overlap and Cauchy–Schwarz complete (2).

Take a real even \(C^\infty_c\) function \(\chi\), equal to one in a neighborhood of zero and supported in \([-1,1]\). Let \(\psi\) be its inverse Fourier transform and \(\psi_h(t)=h^{-1}\psi(t/h)\). This is a real kernel of integral one, with all strictly positive integer moments zero. For \(h\) sufficiently small depending on \(v\), \(\psi_h*g^2=g^2\): in the inverse transform this multiplies \(A\), supported on \([-v,v]\), by \(\chi(hx)=1\). Put \(G=\psi_h*g\). We claim
\[
                         \|G^2-g^2\|_1\le C(v,\beta)h^3 .          \tag{3}
\]
By the exact identity
\[
 g^2(t)-G(t)^2=\tfrac12\iint\psi_h(y)\psi_h(z)
                       [g(t-y)-g(t-z)]^2\,dy\,dz,
\]
we can subtract \(g'(t)^2(y-z)^2\) inside the right-hand integral without changing its value. For \(\rho=\max(|y|,|z|)\le1\), the absolute difference between the two squares, at almost every \(t\), is bounded by
\[
 2|y-z|^2\sup_{[t-\rho,t+\rho]}\|P'\|\;|Dg'|([t-\rho,t+\rho]).
\]
This follows by integrating \(g'\) between the two arguments and comparing its mean there with \(g'(t)\). Integrating over \(I_m\) and using Fubini costs at most \(4\rho |y-z|^2 \sup_{J_m}\|P'\|\, |Dg'|(J_m)\). If \(\rho>1\), translation in \(H^1\) bounds the integrated difference by \(2|y-z|^2\|g'\|_2^2\), also \(O(\rho |y-z|^2)\). Now integrate against \(|\psi_h(y)\psi_h(z)|\). Its moment of \(\rho |y-z|^2\) is \(O(h^3)\). This proves (3).

For each fixed \(A\), there is an even real analytic signed square root \(g\) on the real axis with \(g(0)=1\). Indeed \(\widehat A\) is entire, real nonnegative on \(\mathbb R\), and not identically zero. Its real zeros are isolated and of even multiplicity. Continue the positive square root from zero across each real zero of multiplicity \(2k\) using its local analytic factor \((t-t_0)^k\) times the positive analytic square root of the remaining nonvanishing factor. Uniqueness of the analytic continuation along the real axis gives evenness. This is a real-axis statement. Complex zeros of odd multiplicity can still obstruct compact exact factors.

On zero-free intervals \(g'=\pm F'\). At a zero where \(F'\) jumps, \(g'\) is continuous. Splitting compact intervals at their finitely many zeros therefore shows \(|Dg'|\le |DF'|\) as measures and \(|g'|\le\|P'\|\) almost everywhere. Thus (1)–(3) apply unchanged. In fact \(\|G^2-g^2\|_1=o_A(h^3)\). On each fixed compact interval, Taylor expansion to order three gives \(G-g=O_A(h^4)\) uniformly, since \(g\) is smooth there and globally bounded (\(|g|^2=\widehat A\le1\)); the Schwartz tail outside an enlarged interval is \(O_{A,M}(h^M)\) for each \(M\). Outside a large compact interval and for \(\rho\le1\), the preceding proof of (3) uses only a tail of the convergent series (2). For \(\rho>1\) the integrated bound contributes \(o(h^3)\) by the Schwartz tail. Taking first \(h\to0\) and then the compact interval to \(\mathbb R\) proves the assertion.

## A compact window with nonnegative autocorrelation

For the uniform estimate use \(g=F\); for the pointwise estimate use the signed root. Write \(s=\mathcal F^{-1}g\), real and even. Its \(L^1\) norm and \(\|x s(x)\|_2\) are bounded in terms of \(v,\beta\) by \(g\in H^1\), Plancherel and Cauchy–Schwarz with \((1+x^2)^{-1}\). At zero \(G(0)=1+O_v(h^4)\): \(\widehat A(0)=1\), \(|\widehat A^{(j)}|\le v^j\) since \(A\) is a nonnegative probability density on \([-v,v]\), and the square root has uniformly bounded first four derivatives in a fixed neighborhood of zero. Use the Taylor expansion and the vanishing moments as above.

Take \(M=R-1\), \(K=M/200=1/h\) and \(b(x)=\chi(x/K)s(x)/G(0)\). Then \(\int b=1\), \(\|b\|_1+\|xb\|_2\le C(v,\beta)\), and \(b\) is real even and supported in \([-K,K]\). Fourier inversion and (3) give
\[
 E=\|b*b-A\|_\infty=O_{v,\beta}(K^{-3}),\qquad
 E=o_A(K^{-3})\ \text{for the fixed-input signed root}.            \tag{4}
\]
The normalization error is \(O_v(h^4)\|G^2\|_1\), with \(\|G^2\|_1=O_{v,\beta}(1)\).

Normalize \(u(x)=Z^{-1}\exp[-\gamma(|x|-3M/4)_+]\mathbf1_{|x|\le M}\), where \(\gamma=40\log(M)/M\) and \(Z\asymp M\). For \(|x|\le M-K\), translation by a distance at most \(K\) stays in the support, and
\[
   b*u(x)\ge u(x)\Big(1-\int |b(y)|(e^{\gamma |y|}-1)\,dy\Big)\ge u(x)/2.
\]
Indeed the integral is at most \(\gamma e^{\gamma K}(2K)^{1/2}\|yb(y)\|_2=o(1)\). On \(|x|\le2K\) the convolution equals \(1/Z\). In \(M-K<|x|\le M+K\), it has absolute value at most \(C M^{-1}e^{-\gamma(M/4-2K)}\le C M^{-10}\). The overlapping plateaux give \(u*u(x)\ge c/M\) throughout \(|x|\le M+K\).

Set \(\eta=4ZE+M^{-3}\) and \(V_0=(1-\eta)b+\eta u\). Then \(\eta=O(R^{-2})\) uniformly and \(\eta=o_A(R^{-2})\) in the fixed-input construction. For large \(R\), one has \(0<\eta<1/2\). In \(|x|\le2K\), \(b*b\ge-E\) by nonnegativity of \(A\), and the positive mixed term dominates \(E\). In \(2K<|x|\le M-K\), \(b*b=0\) and the mixed term is nonnegative. In the boundary band the mixed term is at least \(-C\eta M^{-10}\), dominated by \(c\eta^2/M\) since \(\eta\ge M^{-3}\). Beyond \(M+K\) only \(\eta^2 u*u\) survives. Thus \(V_0*V_0\ge0\) everywhere. Equations (4), \(\|A\|_\infty\le\beta\), \(\|b*u\|_\infty=O(1/M)\), and \(\|u*u\|_\infty=O(1/M)\) bound the uniform profile error by \(O_{v,\beta}(\eta+E)\).

Convolve \(V_0\) with an even nonnegative smooth probability bump of radius less than one. Its radius can be taken small enough, depending on the continuous input \(A\), that the double smoothing changes \(A\) by at most \(R^{-3}\) uniformly. Contraction in the sup norm preserves the preceding error order. The resulting window \(V\) is smooth of mass one and satisfies every stated support and positivity requirement. Since both profiles are nonnegative with integral one, \(\|V*V-A\|_1=2\int(A-V*V)_+\le4v\|V*V-A\|_\infty\).

## Sharpness and order of quantifiers

The [two-cell lower bound](two_cell_minimax.md) already holds for valid strong WT witnesses, with separate lower bounds for both norms. Dilate its cells by \(v/2\), renormalizing the input density, and take its parameter \(p\to1/2\) on the scale \(v/R\). The energy \((2/v)(p^2+(1-p)^2)\to1/v\), so every fixed \(\beta>1/v\) admits these witnesses for sufficiently large \(R\). The table may be dilated with the window. Equality in the mass–energy Cauchy–Schwarz inequality proves the assertion for \(\beta=1/v\); arbitrarily narrow even smoothing of the centered uniform window realizes the stated infimum.

For any positive \(q(R)\to0\), take \(m_j\uparrow\infty\) with \(q(2^{m_j})\le2^{-2j}\), and define \(u_{m_j}=2^{-j}\), zero elsewhere. The [summable lower-profile theorem](summable_radius_profiles.md) supplies a single strong WT witness, of width one and energy at most two, for which \(R^2 e_R(A)/q(R)\) is unbounded along \(R=2^{m_j}\). Thus the pointwise little-oh result and the sharp uniform order are compatible even on fixed input parameters.

Ehm, Gneiting and Richards characterize the existence of exact compact even factors through the complex zeros. The quantitative result here uses approximation on the real frequency axis and preserves nonnegative autocorrelation after compact truncation. [Exact factorization](https://doi.org/10.1090/S0002-9947-04-03502-0) · [Original WT definition](https://arxiv.org/html/2610.36207v1#S2.SS2)
