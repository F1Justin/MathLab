# The sharp support-radius exponent for a two-cell WT family

Let \(w_p=p\mathbf1_{[0,1)}+(1-p)\mathbf1_{[1,2)}\), \(0\le p\le1\), and \(A_p=w_p*\widetilde w_p\). With table \(\mathbf1_{[-2,4]}\) these are deterministic strong WT inputs with common parameters \((v,\sigma,\alpha,\beta)=(2,4,2,1)\). Let \(\mathcal V_R\) be the real even mass-one windows supported in \([-R,R]\) with nonnegative autocorrelation. All the windows constructed below can be smooth. There are absolute \(c,C>0\) such that, for every sufficiently large \(R\),
\[
  cR^{-2}\ \le\ \sup_{0\le p\le1}\ \inf_{V\in\mathcal V_R}
  \|V*V-A_p\|_\infty\ \le\ CR^{-2}.
\]
The same bounds hold in \(L^1(\mathbb R)\), with different constants. These estimates concern approximation of the autocorrelation with the indicated actual support radius. Rates for simultaneous approximation of the table profile or its surplus require a separate argument.

The lower bounds follow from the simple nonreal zero for \(p=e^{1/(2R)}/(1+e^{1/(2R)})\) in the [WT manuscript, support-radius proposition](https://github.com/F1Justin/MathLab/blob/ae92acdcae0f6bd718a9cdfb3e537606f86f0336/papers/wt-derandomization/single-even-window.pdf). Its Rouché argument directly gives \(\|V*V-A_p\|_1\ge cR^{-2}\); nonnegativity and the support of \(A_p\) also give \(\|V*V-A_p\|_1\le8\|V*V-A_p\|_\infty\). We prove the upper bound and enforce exact nonnegativity, including away from the input support.

## A finite trigonometric square

Put \(a=|2p-1|\) and \(F_a(t)=(\cos^2(t/2)+a^2\sin^2(t/2))^{1/2}\), the modulus of \(p+(1-p)e^{it}\). Write \(f_j\) for its real even Fourier coefficients with the \(1/(2\pi)\) convention. There is an absolute \(C_0\) with
\[
 |f_j|\le C_0/(1+j^2),\qquad 0\le a\le1.                         \tag{1}
\]
Indeed \(F_a\) is uniformly Lipschitz by its expression as a complex modulus. Writing \(F_a^2=A+B\cos t\), the sign changes of \(F_a''\) for \(a>0\), \(B\ne0\), occur among the roots of \(B^2\cos^2t+2AB\cos t+B^2=0\). Thus \(F_a'\) has bounded variation uniformly. The constant case is immediate, and uniform convergence of \(F_a\) proves (1) at \(a=0\).

Fix a real even smooth cutoff \(\chi\), supported on \([-1,1]\), equal to one in a neighborhood of zero. For integer \(K\ge1\), write \(h=1/K\) and \(G(t)=\sum_j \chi(j/K) f_j e^{ijt}\). With \(d(t)\) the circular distance to \(\pi\) and \(X=a+d(t)\),
\[
 |G(t)-F_a(t)|\le C h^4/(X+h)^3.                                 \tag{2}
\]
To see this, write \(G(t)=\int_{\mathbb R}\psi_h(y)F_a(t-y)\,dy\), where \(\psi\) is the inverse Fourier transform of \(\chi\), \(\psi_h(y)=h^{-1}\psi(y/h)\), and \(F_a\) is periodically extended. The integral of \(\psi\) is one and all its strictly positive integer moments vanish. The Lipschitz bound costs \(Ch\) for \(X\le h\). For \(X>h\), near \(t\) one has \(|F_a^{(m)}|\le C_m X^{1-m}\) for \(1\le m\le4\), throughout \(|y|\le X/2\). In fact \(F_a\asymp a+d\) globally since \(d\le\pi\). Differentiating \(F_a\) as the Euclidean norm of \((\cos(t/2),a\sin(t/2))\) gives these derivative bounds wherever \(a+d>0\), using \(a+d(t-y)\ge X/2\) and bounded derivatives of the vector. Subtract the Taylor polynomial of order three at \(t\) inside the convolution. Its remainder is \(O(|y|^4 X^{-3})\) on the near interval. The same bound holds for \(|y|>X/2\) by global Lipschitz continuity and the bounds on the three Taylor coefficients. Integration against \(|\psi_h|\) proves (2).

Now \(G(0)=1+O(h^4)\). Define \(b_j=\chi(j/K)f_j/G(0)\) so that \(\sum b_j=1\) and \(b\) is real even. Let \(s=(s_j)\) be the coefficients of \(F_a^2\), supported on \(\{-1,0,1\}\), with \(s_j\ge0\). Then uniformly in \(a\),
\[
 \sup_j |(b*b)_j-s_j|\le C_1 K^{-3}.                              \tag{3}
\]
Indeed (2), \(F_a=O(X)\), and \(G=O(X+h)\) bound \(|G^2-F_a^2|\) by \(Ch^4(X+h)^{-2}\). Its integral over a period is \(O(h^3)\); normalizing \(G^2\) costs \(O(h^4)\). The absolute Fourier coefficient bound gives (3).

## Repairing the sign of every coefficient

Write \(M=\lfloor R\rfloor-2\), \(K=\lfloor M/200\rfloor\), \(\gamma=40\log(M)/M\). Use the probability sequence
\[
 u_j=Z^{-1}\exp[-\gamma(|j|-3M/4)_+]\,\mathbf1_{|j|\le M}.
\]
Here \(Z\asymp M\). On \(|l|\le M-K\), (1) gives
\[
  (b*u)_l\ge u_l\left(1-\sum_{|j|\le K}|b_j|(e^{\gamma |j|}-1)\right)
             \ge u_l/2
\]
for large \(M\): the sum is \(O(\gamma e^{\gamma K}\log(2K))=o(1)\). For \(|l|\le2K\) the convolution equals exactly \(1/Z\). In the boundary band \(M-K<|l|\le M+K\) it has absolute value at most \(C M^{-1}\exp[-\gamma(M/4-2K)]\le C M^{-10}\). Finally \((u*u)_l\ge c_2/M\) for all \(|l|\le M+K\), because the two plateaux of radius \(3M/4\) overlap on at least \(M/3\) integers for large \(M\).

Take \(\eta=C_3 M K^{-3}\) with a sufficiently large absolute \(C_3\), and \(v=(1-\eta)b+\eta u\). Its mass is one, \(0<\eta<1/2\) for large \(M\), and \(v*v\) is nonnegative everywhere. For \(|l|\le2K\), the mixed term \(2(1-\eta)\eta/Z\) dominates the possible negative part in (3). For \(2K<|l|\le M-K\) the mixed term is nonnegative and \(b*b=0\). Throughout the boundary band the possible negative term is at most \(C\eta M^{-10}\), dominated by \(c_2\eta^2/M\). Beyond \(M+K\) only \(\eta^2 u*u\) survives. Since \(\|b\|_{\ell^1}=O(1)\), changing \(b\) to \(v\) costs \(O(\eta)=O(R^{-2})\) in the sup norm of the coefficient squares. Together with (3), \(\|v*v-s\|_{\ell^\infty}=O(R^{-2})\).

Set \(V_0(x)=\sum_j v_j\mathbf1_{[-1/2,1/2]}(x-j)\). Its autocorrelation linearly interpolates \(v*v\) at the integers; \(A_p\) interpolates \(s\) in the same manner. Thus \(V_0*V_0\ge0\) and the uniform bound follows. To obtain a smooth window, convolve \(V_0\) with an even smooth probability bump of radius \(R^{-3}\). The mass and nonnegative autocorrelation persist and the actual support lies inside \([-R,R]\). The resulting extra uniform error against the target is \(O(R^{-3})\) by the uniform Lipschitz bound of the piecewise linear \(A_p\) and convolution contraction. The \(L^1\) upper bound follows from nonnegativity and the common integral one.

The earlier exact square-root criterion of Ehm, Gneiting and Richards detects the nonreal zero obstruction. Akwei and Williams study width versus distance to the optimal WT objective. The upper estimate here constructs a compact factor with nonnegative autocorrelation and gives the sharp power and constants up to fixed factors for an entire family of prescribed profiles. [Ehm–Gneiting–Richards](https://doi.org/10.1090/S0002-9947-04-03502-0) · [Akwei–Williams](https://doi.org/10.5281/zenodo.24326518)
