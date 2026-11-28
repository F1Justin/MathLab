# All rows at every fixed positive power of the block threshold

For every fixed \(\alpha>0\) there is \(N_0(\alpha)\) such that for every \(N\ge N_0(\alpha)\) and every integer \(N^\alpha\le j\le N\), the polynomial enumerating **all** set partitions of \([N]\) by their number of blocks of size at least \(j\) has exactly \(\lfloor N/j\rfloor\) simple strictly negative roots. This is uniform over thresholds in that interval. It does not supply a numerical \(N_0(\alpha)\).

Alexandersson asks for all thresholds and every row. The growing-threshold assertion here and the [fixed-threshold eventual theorem](fixed_threshold_rows.md) have different quantifiers. The former includes every positive power with one cutoff uniform over all the corresponding thresholds. [Original question](https://mathoverflow.net/questions/462360/set-partitions-with-big-blocks-real-rooted-polynomials) · [Author's formulation](https://www.symmetricfunctions.com/realRootedOpenProblems.htm)

Put \(D=\lfloor N/j\rfloor,\ L=\log N,\ V=\max(1,N/j^2)\). We work with the shifted coefficients \(a_k=[x^k]P_{N,j}(1+x)/N!\), which are positive and log-concave. The [large-threshold theorem](growing_threshold.md) covers \(j>2\sqrt{NL}\). For each intermediate index \(1\le k<D\), set \(m=N-jk\). If \(m\le j^2/(20\log j)\), use the [outer curvature circles](uniform_outer_curvature.md). If \(m\ge V L^2\), choose a fixed integer \(p\ge3\) with \(\alpha(p+1)>1\). The [Radau circle theorem](radau_coefficient_circles.md) applies since \(m L^{2p+1}/j^{p+1}\le N^{1-\alpha(p+1)}L^{2p+1}\to0\). In each case there is a zero-free circle with exactly \(k\) shifted zeros inside.

It remains to give the circles when
\[
          j^2/(20\log j)<m<V L^2,\qquad j\le2\sqrt{NL}.             \tag{1}
\]
In this range \(m=o(N)\), \(k\sim N/j\), \(D-k\sim m/j\), \(\log m\asymp_\alpha L\), and \(m\) tends to infinity at least as a positive power of \(N\). The key point is that both ends of the coefficient support lie far away on the inverse-curvature scale.

## Curvature in a complex neighbourhood of the crossover

Use the [full-saddle interpolation](fifth_power_threshold.md), retaining its notation \(r_0,\sigma_0^2,H,\nu,w_H\). This part of the interpolation applies for every \(j\ge N^\alpha\) under (1). Specifically \(r_0e^{r_0}+k\nu(r_0)=m,\ 0<r_0\le L+1,\ c m\le\sigma_0^2\le C m L\). Write \(d=(j+\nu(r_0))^2/\sigma_0^2\asymp j^2/\sigma_0^2\). With \(U=\max(1,m/j^2)\) take \(R=U L^4\). Then
\[
 jR/m=O(L^5/j)=o(L^{-3}),\qquad
       1/d\le C mL/j^2,\quad k d\longrightarrow\infty,\quad
                              (D-k)d\longrightarrow\infty .
\]
For example \((D-k)d\gg j/L\) and \(k d\gg Nj/(mL)\). The cited saddle estimate yields on \(|s|\le R\)
\[
 \log C_*(s)=\Lambda(s)+U_0(s),\qquad |U_0(s)|\ll_\alpha L,\qquad
 \Lambda''(s)=-(j+\nu(r(s)))^2/\sigma^2(s).
\]
For clarity, the holomorphic inverse for \(\log(r(s)/r_0)\) is available on the larger disk \(c m/(jL)\). The Gaussian error on its small angular arc at radius \(R\) tends to zero since \(m\) grows polynomially. On the remaining arc the real saddle has loss \(\gg m/L^2\) and the complex perturbation is \(O(jR)=o(m/L^2)\). These conditions do not require the fifth-power lower bound on \(j\) used in the later Taylor comparison of that earlier theorem.

For each fixed \(K\), uniformly on \(|s|\le K(1+1/d)\),
\[
   (\log C_*)''(s)=-d(1+o(1)).                                    \tag{2}
\]
Indeed \(R/(1+1/d)\gg L^3\). The saddle inverse gives \(|\log(r(s)/r_0)|\ll j|s|/\sigma_0^2\), so the relative change of \(\sigma^2\) is
\[
 O\big(Lj(1+1/d)/\sigma_0^2+(1+1/d)r_0/(j\sigma_0^2)\big)=o(1),
\]
by the full-saddle bounds on \(\mathcal D\sigma^2=O(L\sigma_0^2)\) and \(w_H=O(r_0/j)\). Here \(d=O(j^2/m)=O(L)\) by (1), and \(j\ge N^\alpha\). The relative change of \(j+\nu\) is \(o(1)\) as well. Cauchy's inequality gives \(|U_0''|\ll L/R^2=o(d)\) on the smaller disk. At supported integral offsets, the actual coefficient logarithm has analytic interpolation
\[
             f(s)=\log C_*(s)-\log\Gamma(k+s+1)-(k+s)\log(j!).
\]
The logarithm is real on the central real interval. The second derivative of the gamma term is \(O(1/k)=o(d)\) there and on the small complex disk: use \(\sum_{h\ge0}(k+s+1+h)^{-2}\), with \((1+1/d)/k=o(1)\). Thus (2) holds for \(f\).

## Counting every rank

Argue along any potentially offending sequence from (1), passing to a subsequence so \(d\) has a limit in \([0,\infty]\). If \(d\to0\), normalize \(F(s)=f(s)-f(0)-s f'(0)\). Equation (2) verifies every hypothesis of the [two-frequency discrete saddle lemma](discrete_saddle_circles.md), including the full complex disk of radius \(100/d\). It provides exactly the required circle.

If \(d\to d_*\in(0,\infty)\), use the positive radius \(r=\exp[-f'(0)]\). For each fixed integral \(h\), (2) gives
\[
       a_{k+h}r^h/a_k\longrightarrow e^{-d_* h^2/2}.
\]
These normalized Laurent polynomials converge uniformly on the unit circle to \(\sum_{h\in\mathbb Z}e^{-d_*h^2/2}e^{ih\theta}\). Indeed the outward ratios at sufficiently large fixed positive and negative offsets are bounded by \(1/2\) for all sufficiently late members; global log-concavity bounds the remaining tails geometrically and their initial terms converge to Gaussian tails. The limiting Fourier series is strictly positive on the real circle by Poisson summation of the Gaussian. Thus the centred polynomial has zero change of argument, and restoring its \(k\)-th power gives count \(k\).

If \(d\to\infty\), (2) on the real interval \([-1,1]\) gives \(\log(a_k^2/(a_{k-1}a_{k+1}))=(1+o(1))d\). On the circle with radius \(\sqrt{a_{k-1}/a_{k+1}}\) the two neighboring terms divided by the centre term both have modulus \(o(1)\), and all successive outward ratios are bounded by the same number by log-concavity. The centre monomial strictly dominates their two geometric tails. This again gives a zero-free circle with count \(k\).

We now have a circle for each \(1\le k<D\); the radii increase because the counts increase. Together with zero and the total degree \(D\), these counts isolate exactly one zero with multiplicity in each annulus or extreme disk. Conjugation makes every zero real and simple. Positivity of the original coefficients excludes all \(t\ge0\). Degrees zero and one obey the same conclusion directly. This proves the theorem.
