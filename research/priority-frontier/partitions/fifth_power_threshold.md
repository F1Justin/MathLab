# Real roots at the fifth-power block threshold

There is an absolute \(C>0\) such that, for all sufficiently large \(N\) and all integers \(C N^{1/5}(\log N)^{9/5}\le j\le N\), the polynomial \(P_{N,j}(t)\) counting blocks of size at least \(j\) in set partitions has \(\lfloor N/j\rfloor\) simple negative zeros. We use the [reference-circle estimates](quarter_power_threshold.md) and [uniform high-curvature end](uniform_outer_curvature.md). The new reference matches the third and fourth derivatives and leaves a positive quadratic curvature for root separation. A separate estimate treats the crossover between Bell and excess-block contributions at the saddle.

Write \(L=\log N,\ V=\max(1,N/j^2),\ m=N-kj,\ U=\max(1,m/j^2)\). The remaining range is \(j\le 2\sqrt{NL},\ 1\le k< D=\lfloor N/j\rfloor,\ m>j^2/(20\log j)\). Thus \(m>j^2/(20L)\) and \(\log m\asymp L\). Fix large constants \(A,B\) in that order as in the previous mean-circle argument and put
\[
 J=P=\lceil A U L^2\rceil,\qquad R'=AB U L^2,\qquad R=R'L^2 .
\]
In particular \(jR/m\ll_{A,B}L^5/j=o(L^{-3})\). All constants in estimates below are absolute before \(A,B,C\) are chosen.

## Complex full saddle, including small radii

For the exact coefficient \(C(m,k)=[z^m]\exp(e^z-1)H(z)^k\), retain \(H(z)=\sum_{l\ge0}j!z^l/(j+l)!\), \(\nu=\mathcal D\log H,\ w_H=\mathcal D\nu,\ \mathcal D=z\partial_z\). Let \(r_0>0\) solve \(r_0e^{r_0}+k\nu(r_0)=m\), and let \(\sigma_0^2=(1+r_0)r_0e^{r_0}+k w_H(r_0)\). The estimates of the uniform outer proof give \(r_0\le L+1,\ (1-o(1))m\le\sigma_0^2\le (1+r_0+o(1))m\). They allow \(r_0\) arbitrarily close to zero.

For \(|s|\le c m/(jL)\) with a small absolute \(c>0\), set \(M=m-js,\ K=k+s\). The solution \(r(s)=r_0 e^{u(s)}\) to \(re^r+K\nu(r)=M\) is holomorphic and satisfies
\[
 |u(s)|\ll j|s|/\sigma_0^2,\qquad
 \sigma^2(s)=(1+r)re^r+K w_H(r),\qquad
 |\sigma^2(s)-\sigma_0^2|\le\sigma_0^2/2 .
\]
Here is a uniform inverse argument. Write \(Q(u)=r_0e^u\exp(r_0e^u)+k\nu(r_0e^u)\). For \(|u|\le c_1/L\), \(Q'(0)=\sigma_0^2\) and \(|Q''(u)|\ll L\sigma_0^2\). Indeed the Bell portion is \(O(r_0(1+r_0)^2e^{r_0})\), and \(\mathcal D^q\log H(r_0 e^u)=O_q(r_0/j)\) for fixed \(q\ge1\) by the defining series; \(kr_0/j=O(m)\). Write the equation as a fixed point by isolating \(\sigma_0^2u\) from \(Q(u)-m+s\nu(r_0e^u)=-js\). On \(|u|\le c_1/L\) the Lipschitz constant is \(O(c_1+|s|r_0/(j\sigma_0^2))<1/2\); its value at zero is \(O(j|s|/\sigma_0^2)\). Choose \(c\) sufficiently small after \(c_1\). This also proves the asserted control on \(\sigma^2=Q'(u)+s w_H(r)\), reducing constants if necessary.

Write \(\Lambda=e^r-1+K\log H(r)-M\log r\). Then
\[
  \Lambda''(s)=-\frac{(j+\nu(r))^2}{\sigma^2(s)},\qquad
  \sup_{|s|\le R}|\Lambda'''(s)|\ll j^3 L/m^2 .                 \tag{1}
\]
The second bound follows by applying Cauchy's estimate to the first on the larger disk \(c m/(jL)\). The exact coefficient interpolation \(C_*(s)\) from the quarter-power proof satisfies on \(|s|\le R\)
\[
   \log C_*(s)=\Lambda(s)+U_0(s),\qquad
   U_0(s)=-\tfrac12\log(2\pi\sigma^2(s))+o(1),\qquad |U_0(s)|\ll L . \tag{2}
\]
In its angular integral the linear exponent vanishes and the quadratic term is \(-\sigma^2(s)\theta^2/2\). On \(|\theta|\le c_2/L\), the third angular derivative costs \(O(L\sigma_0^2)\), by the same bounds as for \(Q''\). Thus the central arc \(|\theta|\le L/\sqrt m\) has an \(o(1)\) cubic remainder and a Gaussian relative integral \(1+o(1)\). Up to \(c_2/L\) the remaining arc has loss \(\gg\sigma_0^2\theta^2\) on choosing \(c_2\) small.

On \(c_2/L\le|\theta|\le\pi\), use the real saddle at \(s=0\) for comparison. Its loss is at least \(c_3m\theta^2/(1+r_0\theta^2)\gg m/L^2\) by the Bell modulus and the zero/one masses of the \(H\) tilt, as in the uniform outer proof. Moving \(r_0\) to \(r_0e^{u(s)}\) and \(k\) to \(k+s\) changes the exponent on this arc, including its subtracted central value and the linear term in \(M\), by \(O(m|u(s)|+jR)=O(jR)=o(m/L^2)\). To see the first term, the derivatives with respect to \(u\) of the two log integrands are bounded in absolute value by \(O(r_0 e^{r_0}+k r_0/j+|s|r_0/j)=O(m)\), uniformly in the angle. The change of \(K\) at fixed radius costs \(O(Rr_0/j)\). This proves (2), with no condition comparing \(k\nu(r_0)\) with the Bell portion. The \(U_0\) remainder after the constant and linear terms on \(R'\) costs \(O(L^{-3})\).

## The crossover range

If \(m\le V L^2\), use the deformed exponential \(F\) with \(d=-\Lambda''(0)\) as in the [growing-threshold proof](growing_threshold.md). Here \(c_4/(UL)\le d\le C_4L\). Scaled so its center coefficient and linear variation match as before, the exact coefficient multiplier satisfies on \(R'\)
\[
        |\log\Phi|\ll L^{-3}+ j^3 L(R')^3/m^2 .
\]
If \(m<j^2\) the second term is \(O_{A,B}(L^9/j)\). If \(m\ge j^2\), it is \(O_{A,B}(m L^7/j^3)=O_{A,B}(L^9/j^3+NL^9/j^5)\). Thus \(\sup|\log\Phi|\le\log2\) on choosing the theorem's \(C\) large. The full circle comparison below applies directly.

## Matching four derivatives outside the crossover

Suppose \(m>V L^2\). Throughout the larger disk \(|s|\le m/(10j)\), the contraction about \(W(M)\) in the quarter-power proof now supplies
\[
 \Lambda''(s)=-\frac{j^2}{M(1+W(M))}(1+O(VL/m+L/j^2)).
\]
The error is \(o(1)\) relative, uniform on that disk. Differentiating the analytic error with Cauchy's estimates and differentiating its main term give, at \(0\), with \(L_m=1+W(m)\),
\[
  \Lambda''\sim-\frac{j^2}{mL_m},\qquad
  \Lambda'''\sim-\frac{j^3}{m^2 L_m},\qquad
  \Lambda''''\sim-\frac{2j^4}{m^3L_m},\qquad
  \sup_{|s|\le R}|\Lambda^{(5)}(s)|\ll \frac{j^5}{m^4L}.
\]
Indeed the first two derivatives of \(M\mapsto [M(1+W(M))]^{-1}\) equal \(-(1+O(1/L))/(M^2(1+W(M)))\) and \(2(1+O(1/L))/(M^3(1+W(M)))\) at the real center.

Let \(v=\lfloor m/(2j)\rfloor,\ T=k+v\), \(g(s)=\log\Gamma(v+1)-\log\Gamma(v+1-s)\), and \(K_0(s)=\Lambda(s)-g(s)\). For \(q=2,3,4,5\), \(|g^{(q)}(s)|=O_q(v^{1-q})\) on \(R\), by the polygamma series. The contributions to the displayed asymptotics for \(K_0\) are smaller than the leading terms by a factor \(O(L/j)\). Set
\[
  w=\frac{3K_0'''(0)}{K_0''''(0)}\sim\frac{3m}{2j},\qquad
  b(s)=\log(1-s/w),\qquad
  p=\operatorname{round}\big(-w^3K_0'''(0)/2\big) .
\]
Thus \(w>v,\ p\sim 27m/(16L_m)\) is a positive integer, and \(b^{(q)}(0)=-(q-1)!/w^q\). In particular
\[
 K_0'''(0)-p b'''(0)=O(w^{-3}),\qquad
 K_0''''(0)-p b''''(0)=O(w^{-4}),
\]
because both fourth derivatives are \(3/w\) times their respective third derivatives. Moreover
\[
           d=p b''(0)-K_0''(0)\sim\frac{j^2}{4mL_m}>0 .
\]

Use the reference polynomial
\[
        F_0(z)=\sum_{i=0}^{T}\binom Ti (k+w-i)^p e^{-d i(i-1)/2}z^i .
\]
It has positive coefficients and simple negative roots with consecutive moduli in ratio \(>e^d\). Indeed multiplying each coefficient of a real-negative-rooted polynomial \(f\) by \(a-i\), for \(a>\deg f\), applies \(af-zf'\). At the distinct negative roots \(r\) of \(f\), the signs of \(-rf'(r)\) alternate. Together with the sign at \(-\infty\) they give one negative root in each gap and one to the left of the first. Repeated roots follow by a limit. The multiplier is allowed \(p\) times because \(k+w>T\). Finally apply the root-separating \(q^{\binom i2}\) modification from the quarter-power proof with \(q=e^{-d}\).

Multiply \(F_0\) by a positive constant and scale its argument to match the center coefficient \(a_k\) and the linear variation after the exact factorials are divided out. Explicitly the argument multiplier is \(\exp(S-g'(0)-p b'(0)+d(k-1/2))/j!\), where \(S=(\log C_*)'(0)\). Then the exact ratio of the actual/reference coefficients at \(k+h\) is \(\Phi(h)\) on \(|h|\le R'\) in the support, where
\[
 \log\Phi(s)=\log C_*(s)-\log C_*(0)-Ss
       -(g(s)-g'(0)s)-p(b(s)-b'(0)s)+d s^2/2 .
\]
The remaining quadratic term from \(K_0-pb\) cancels. Taylor's theorem, \(R'\ll w\), and (2) give
\[
 |\log\Phi(s)|\ll L^{-3}+(R'/w)^3
                     +\frac{j^5(R')^5}{m^4L},\qquad |s|\le R'.
\]
Indeed the fifth derivatives from \(p b\) and \(g\) are \(O(p/w^5+v^{-4})=O(j^5/(m^4L))\). For \(m\ge j^2\) the two displayed error terms beyond \(L^{-3}\) are \(O_{A,B}(L^6/j^3+NL^9/j^5)\). For \(m<j^2\) they are \(O_{A,B}(L^{13}/j^3)\). This gives \(\sup|\log\Phi|\le\log2\).

## Root counts

In both cases \(c_5/(UL)\le d\le C_5L\). The finite-reference center curvature satisfies
\[
 \log\frac{\widetilde R_{k+1}}{\widetilde R_k}
  =\log(1+1/k)+\log(1+1/v)+d+p\log\!\left(\frac{w^2}{w^2-1}\right)
  =O(L),
\]
using \(p/w^2=O(j^2/(mL))\). The deformed exponential gives the same bound from its explicit ratios. In both cases every reference log-curvature is at least \(d\): the binomial coefficients and \((k+w-i)^p\) are log-concave on the support before the exponential modification. The referenced midpoint estimates therefore apply with \(|\log(r_*/\widetilde R_k)|\le c_6L,\ M_d\le c_7 UL^2\). The right cutoff is present in both polynomials, since \(D-k>R\) and in the finite case \(T-k=v>R\).

For clarity, choose \(A\) large relative to \(c_5^{-1},c_6,c_7\), then \(B\) large, and finally \(C\) large for the multiplier bounds. The degree-\(P\) Taylor section \(Q\) of \(\Phi\) satisfies \(|Q(\mathcal D-k)F-F|<|F|/4\) on the reference midpoint by (15) of the growing-threshold argument. The central coefficient mismatch costs \(O((J/R')^{P+1})F(r_*)\), and all coefficient tails cost \(O(e^{-dJ^2/5})F(r_*)\) by the same argument as the quarter-power proof: \(dJ\ge c_5 A L\), the true/reference ratios and their inverses are at most two at present cutoffs and their inward neighbors, and the actual coefficients are globally log-concave. The two errors are \(o(e^{-\pi^2/(2d)})F(r_*)\), smaller than the guaranteed circle minimum. Hence each intermediate index has a zero-free circle with its exact count of shifted zeros. The counts, together with zero and infinity, isolate all simple real roots; the positivity of \(P_{N,j}\) for \(t\ge0\) gives their negative signs.
