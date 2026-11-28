# Sharp autocorrelation approximation for every fixed finite grid

Fix \(d\ge1\). Let \(\tau(x)=(1-|x|)_+\). Consider all cardinal linear splines
\[
 A(x)=\sum_{|j|\le d}s_j\tau(x-j),\qquad
 s_{-j}=s_j\ge0,\quad \sum s_j=1,\quad S(t)=\sum s_je^{ijt}\ge0.
\]
For this entire class, the minimax error for approximation by autocorrelations of even, real, smooth mass-one windows of actual support radius \(R\), subject to a nonnegative autocorrelation everywhere, is \(\Theta_d(R^{-2})\) in both \(L^1\) and the uniform norm. Each upper bound is attained up to its constant by the same window for both norms. The constants are uniform over the coefficients and over how close the zeros of \(S\) come to each other or to the unit circle.

This includes every finite WT joint law whose input windows are constant on at most \(d+1\) consecutive unit cells of a common grid, allowing signed cell values. Indeed the expected autocorrelation interpolates its values at the grid points and its symbol is the expectation of the squared moduli of the cell polynomials. Pointwise feasibility gives the nonnegative samples, and the mass-one normalization gives the sum one. A common cell width other than one follows by dilation. Only the window profile is prescribed in this theorem.

## Uniform estimates for the square root

Write \(F=\sqrt S\), a real even function. The scalar Fejér–Riesz factorization gives a polynomial \(P\) of degree \(m\le d\) with \(F(t)=|P(e^{it})|\). Reflecting any root outside the unit disk into the disk and absorbing its modulus into the constant preserves \(F\). Thus \(P(z)=c\prod_{l=1}^m(z-z_l)\), \(|z_l|\le1\). Since \(\|P\|_{\infty,\partial\mathbb D}\le1\) by the coefficient hypotheses on \(S\), the Cauchy coefficient estimate gives \(|c|\le1\). The constant case is included directly by \(F=1\). [Fejér–Riesz factorization and proof by root pairs](https://arxiv.org/abs/0903.3639)

Put \(X(t)=\min(1,\min_l|e^{it}-z_l|)\). It is 1-Lipschitz. The product gives \(F(t)\le 2^d X(t)\), in particular \(X(0)\ge 2^{-d}\). Where \(X>0\), differentiating each Euclidean distance shows that its derivative of order \(j\) is at most \(C_j|e^{it}-z_l|^{1-j}\) for \(1\le j\le4\). The product rule therefore yields
\[
 |F^{(j)}(t)|\le C_d F(t) X(t)^{-j}\le C_d X(t)^{1-j}
 \quad(1\le j\le4).
\]
The product is globally Lipschitz, including at its zeros. Moreover \(F'\) has uniformly bounded variation. Away from zeros of \(S\), the sign of \(F''\) is that of \(2SS''-(S')^2\), a trigonometric polynomial of degree at most \(2d\). Unless identically zero it has at most \(4d\) zeros per period. There are at most \(d\) additional points from the \(z_l\) on the circle. On each remaining interval \(F'\) is bounded and monotone; jumps at the excluded points are bounded by the uniform Lipschitz constant. In the identically zero case \(F'\) is constant on each interval. Consequently \(|\widehat F(j)|\le C_d/(1+j^2)\).

With \(h=1/K\), use the smooth Fourier cutoff \(G=\sum_j\chi(j/K)\widehat F(j)e^{ijt}\) in the [two-cell proof](two_cell_minimax.md). Its Taylor argument gives \(|G-F|\le C_d h^4/(X+h)^3\). In particular \(G(0)=1+O_d(h^4)\). For \(0<h\le1\),
\[
 \int_{-\pi}^{\pi}(X(t)+h)^{-2}\,dt\le C_d/h .
\]
Indeed the integrand is bounded by \(1+\sum_l (|e^{it}-z_l|+h)^{-2}\). For \(|z_l|\le1/2\) each term is bounded. For \(|z_l|>1/2\), the squared distance is \((1-|z_l|)^2+4|z_l|\sin^2((t-\arg z_l)/2)\), so its square root bounds a constant times circular angular distance from below. Integrating gives the stated bound. It follows that \(\int |G^2-F^2|=O_d(h^3)\) just as in the two-cell argument, also after dividing \(G\) by \(G(0)\).

The normalized coefficients \(b_j\) of \(G/G(0)\) now obey all the hypotheses used in the sign repair: real and even, supported on \([-K,K]\), \(\sum b_j=1\), \(|b_j|\le C_d/(1+j^2)\), and \(\sup_j |(b*b)_j-s_j|\le C_d K^{-3}\). For \(K\ge d\) the same plateau and exponential taper, with its mixing constant depending only on \(d\), give \(v*v\ge0\) everywhere and \(\|v*v-s\|_\infty=O_d(R^{-2})\). Interpolate with translated unit cells and smooth with a positive even bump as above. All target splines have uniformly bounded Lipschitz constant. Both the target and output profiles are nonnegative of mass one, so their \(L^1\) discrepancy is at most \(4(d+1)\) times the uniform discrepancy. For every \(d\ge1\) the two-cell subfamily belongs to the class and supplies the matching lower bound in both norms.
