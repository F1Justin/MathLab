# WT covering and actual energy matching at the pointwise autocorrelation rate

Fix any finite Carter–O'Bryant–Tao window–table law, expressed in the [centred and extended coordinates of the WT theorem](https://github.com/F1Justin/MathLab/blob/ae92acdcae0f6bd718a9cdfb3e537606f86f0336/papers/wt-derandomization/single-even-window.pdf). Write \(A\) for its mean autocorrelation, \(B=A(0)\) for the actual window energy, \(H\) for the actual table surplus, and \(C_L^+\) for the reflected mean covering after extension to \([-L,L]\). For every sufficiently large real \(R\) one can take \(L=50R\), declared width \(12R\), and a smooth deterministic symmetric WT pair \(V_R,T_R\), with actual window support in \([-R,R]\), such that
\[
 \|V_R*V_R-A\|_\infty+\|V_R*V_R-A\|_1=o_A(R^{-2}),\quad
 \|V_R*T_R-C_L^+\|_\infty\longrightarrow0,\quad
 \|T_R\|_2^2-2L\longrightarrow H .
\]
The actual window energies converge to \(B\) with error \(o_A(R^{-2})\) by evaluation at zero. Both pointwise feasibility inequalities hold, including at the ends of the covering interval. The worst-case inverse-square obstruction from the [support-radius theorem](universal_radius_rate.md) already occurs among two-cell strong inputs.

## The window and its primitive

Reflect the centred joint atoms and halve their masses as in the WT theorem. Choose the real analytic even signed root \(g(0)=1\), \(g^2=\widehat A\), from the [support-radius proof](universal_radius_rate.md), and put \(s=\mathcal F^{-1}g\). In addition to \(s\in L^1\cap L^2\), its one-sided tail integrals are \(O_A(|x|^{-2})\). To prove this take a real even smooth compact probability density \(b_*\). The function
\[
    Q(t)=\frac{g(t)-\widehat b_*(t)}{it}
\]
belongs to \(L^1\); use local analyticity at zero and \(g\in L^2\) at infinity. Its distributional second derivative is a finite measure: the proof of (1)–(2) in the support-radius theorem gives \(\sum_{m\in\mathbb Z}|Dg'|([m,m+1])^2<\infty\), by the local Sobolev bound and bounded overlap. Thus \(|t|^{-1}|Dg'|\) is integrable outside \([-1,1]\) by Cauchy–Schwarz. The other two terms involve \(g'/t^2\) and \(g/t^3\), both integrable there. The same argument applies to \(\widehat b_*\). Fourier inversion gives \(\mathcal F^{-1}Q=O_A(|x|^{-2})\), with derivative \(s-b_*\). Its limits vanish at both ends. Outside the fixed support of \(b_*\) it therefore gives the asserted tail bounds.

Use the compact sign-corrected window of the support-radius proof, including its signed root. Besides its autocorrelation rate, it obeys
\[
  \|V_R\|_1+\|V_R\|_2=O_A(1),\qquad
  \sup_x\left|\int_{-\infty}^x(V_R-s)\right|=O_A(R^{-2}).          \tag{1}
\]
Indeed the cutoff error \((\chi(x/K)-1)s(x)\), with \(K\asymp R\), acts only in the two tails \(|x|\ge cK\). Integrating it by parts using the just-proved primitive bound and the fixed total variation of the dilated cutoff gives \(O_A(K^{-2})\) for every partial integral, including ones that cross both tails. Normalization costs \(O_A(K^{-4})\) in \(L^1\). The positivity repair changes the window by \(o_A(R^{-2})\) in \(L^1\). Choose the last smooth probability bump small enough that its \(L^1\) change to this window is at most \(R^{-3}\), and also meets the modulus-of-continuity choice for \(A\) in the cited proof. Translation continuity in \(L^1\) allows both choices.

## Smoothing the tables alone

Choose a nonnegative even Schwartz probability density \(\phi\) whose Fourier transform is smooth and compactly supported, for instance a normalized square of a real even inverse transform of a smooth compactly supported function. For \(N\ge1\) put \(\phi_N(x)=N\phi(Nx)\) and \(\chi_N=\widehat\phi_N\). For the paired atom \(i\) define
\[
 \widehat K_i=p_i\chi_N\,\widehat w_i/g,\qquad U_L=\sum_i K_i*t_{i,L}.
\]
The quotient has removable real singularities. At any real zero of \(g\) of order \(k\), each entire \(\widehat w_i\) with \(p_i>0\) vanishes to order at least \(k\) by the sum of squared moduli on the real axis. All the kernels are therefore Schwartz for fixed \(N\); they are real by the conjugation symmetry. The joint reflection makes \(U_L\) even. The identities \(\sum_i\int K_i=1\) and
\[
       s*U_L=\phi_N*C_L^+,\qquad \|U_L\|_2^2\le2L+H
\]
follow from the Fourier product and pointwise Cauchy–Schwarz, using \(|\chi_N|\le1\). Extend the frequency inequality across the finitely many zeros on the support of \(\chi_N\) by continuity.

The surplus estimate also needs
\[
          \sup_{N\ge1,L\text{ large}}\|U_L-\mathbf1_{[-L,L]}\|_2<\infty. \tag{2}
\]
Write \(I_L=\mathbf1_{[-L,L]}\). Each \(t_{i,L}-I_L\) is a fixed pair of bounded shoulders, translated with the endpoints, with uniformly bounded \(L^2\) norm. The contribution of these differences is bounded in \(L^2\) by the same frequency Cauchy–Schwarz. For the remaining term put \(m(t)=\sum_i p_i\widehat w_i(t)/g(t)\) with the same removable values. One has \(|m|\le1,\ m(0)=1\), and \(m\) is smooth near zero. Uniformly for \(N\ge1\), \(|\chi_N(t)m(t)-1|\le C\min(|t|,1)\), adjusting \(C\) for \(|t|\ge1\). Since \(|\widehat I_L(t)|\le 2/|t|\), Plancherel proves (2).

For fixed \(N\), \(U_L\) is smooth with bounded total variation independently of \(L\). The derivative of \(K_i*I_L\) is the difference of two translates of \(K_i\), and the derivative of \(K_i*(t_{i,L}-I_L)\) has \(L^1\) bound \(\|K_i'\|_1\|t_{i,L}-I_L\|_1\). Hence (1) and integration by parts yield \(\|(V_R-s)*U_L\|_\infty=O_N(R^{-2})\). Constants indexed by \(N\) here and below may also depend on the original input.

Put \(L=50R\). Smoothly blend \(U_L\) to one for \(|x|\le L-R/4\) and to zero for \(|x|\ge L+R/4\), with both transitions where the distance to the endpoint is at least \(R/8\). The resulting even \(T_0\) satisfies \(\|T_0-U_L\|_\infty+\|T_0-U_L\|_2=O_{N,k}(R^{-k})\) for every fixed \(k\): each shoulder and each end of the blurred interval has Schwartz tail at its distance from the endpoint, uniformly in \(L\). The inner region has length \(O(R)\) and the exterior tails are square integrable with arbitrarily high power decay. In particular
\[
 \|T_0\|_2^2\le2L+H+o_N(1),\qquad
 \|V_R*T_0-\phi_N*C_L^+\|_\infty\le a_N R^{-2}                  \tag{3}
\]
for all sufficiently large \(R\) at fixed \(N\). Equation (2) bounds \(\|T_0-I_L\|_2\) by an input-dependent constant plus \(o_N(1)\).

## Local payment for the covering deficit

The two shoulders of \(C_L^+\) are translates or reflections of fixed continuous profiles, with a unit plateau between them. Thus \(\varepsilon_N=\sup_{L\text{ large}}\|\phi_N*C_L^+-C_L^+\|_\infty\to0\). For \(x\in[-L,L]\) and \(t=L-|x|\), nonnegativity of \(\phi_N\) and \(C_L^+\ge1\) on the interval give
\[
 (1-\phi_N*C_L^+(x))_+\le m_N(t)
 :=\min\!\left(\varepsilon_N,(1+\sup_L\|C_L^+\|_\infty)
                         \int_{|y|\ge t}\phi_N(y)\,dy\right).
\]
This nonincreasing envelope has \(\int_0^\infty m_N(t)dt=O(1/N)\) by the first absolute moment of \(\phi\).

With \(a_N\) as in (3), put
\[
 E_L(y)=2\sum_{b=\pm L}
 \mathbf1_{|y-b|\le2R}\big[m_N((|y-b|-v)_+)+a_N R^{-2}\big],
 \qquad  T_1=T_0+V_R*E_L .
\]
The old cover equals one on \(|x|\le L-5R/4\) since \(V_R\) has mass one. Every deficient \(x\) is within \(5R/4\) of its nearest endpoint \(b\). For \(|u|\le v\), \(E_L(x-u)\ge2[m_N(t)+a_N R^{-2}]\) for large \(R\). The nonnegative autocorrelation \(A_R=V_R*V_R\) has \(\int_{-v}^v A_R\to1\) by its \(L^1\) estimate. Consequently \(A_R*E_L\) corrects the entire deficit at each such \(x\), without decreasing the cover anywhere.

Here \(\|E_L\|_\infty=O(\varepsilon_N+a_N R^{-2})\), and
\[
 \|E_L\|_1=O(v\varepsilon_N+N^{-1}+a_N/R).
\]
The table increment \(\Delta=V_R*E_L\) has \(L^1\) and \(L^2\) norms bounded by \(C_A\|E_L\|_1\). Its cross term with \(T_0\) is at most \(\|\Delta\|_1+\|T_0-I_L\|_2\|\Delta\|_2\) in absolute value. This is where (2) removes dependence on the sup norm of the frequency-smoothed table. By (3) the surplus of \(T_1\) is bounded above by \(H+o(1)\) along a choice \(N=N(R)\to\infty\) sufficiently slowly. The same choice gives \(\|V_R*T_1-C_L^+\|_\infty\to0\) by (3) and \(\|A_R*E_L\|_\infty\le\|E_L\|_\infty\). For example, for each integer \(N\) take an increasing threshold beyond which all its fixed-\(N\) errors and \(a_N/R\) are at most \(1/N\); between adjacent thresholds keep the lower \(N\).

The smooth even table \(T_1\) equals one for \(|x|<L-3R\) and vanishes for \(|x|>L+3R\), within the required plateau and support for declared width \(12R\). If its surplus is below \(H\), insert two equal even-reflected smooth bumps near \(\pm(L+5R)\), disjoint from the table and at distance greater than \(R\) from the covered interval. Their squared norms can fill the shortfall exactly. For each \(R\) choose their supports narrow enough that their \(L^1\) norms times \(\|V_R\|_\infty\) total at most \(R^{-1}\). The table surplus becomes the maximum of \(H\) and its previous value; the feasibility inequalities and the limiting profile persist. This proves the joint assertion.
