# Real roots at a polylogarithmic distance from the cube-root scale

There is an absolute \(C>0\) such that, for every sufficiently large \(N\) and every integer
\[
       C N^{1/3}(\log N)^{5/3}\le j\le N ,
\]
the set-partition polynomial enumerating blocks of size at least \(j\) has \(\lfloor N/j\rfloor\) simple negative roots. This strengthens the fixed-power range \(j\ge N^{1/3+\epsilon}\) by choosing the interpolation radii from the residual size at each coefficient. We use the notation, local comparison with the deformed exponential, and numbered inequalities of the [growing-threshold argument](growing_threshold.md).

Write \(L=\log N\). The large-ratio argument covers \(j>2\sqrt{NL}\). In the remaining range set
\[
 V=\max(1,N/j^2),\quad D=\lfloor N/j\rfloor,\quad m=N-kj,\quad
 m_0=j^2/(20L).
\]
Here \(V/j\le j^{-1}+C^{-3}L^{-5}\). All big-\(O\) constants below can be taken independent of \(C\ge1\). Constants depending on two fixed multipliers \(A,B\) below are indicated explicitly or by subscripts.

For \(m\le m_0\) follow the large-curvature argument with truncation index \(b=\lceil V L^2\rceil\). The discarded positive sums are \(O(e^{-c b})\) since \(D\log H(2r_{2N})=O(VL)\). We have \(b=o(j)\), and the comparison of the normalized Bell coefficients on indices of length \(b\) gives the logarithmic approximation \(K\log H(W(M))+O(b^2/M)\) for \(\log S(M,K)\) at every \(M\ge j\), \(K\le D+1\). Thus for \(m\ge2j\) the error in the logarithm of (4) from the \(S\) factors is \(O((k+1+b^2)/m)=o(j^2/(mL))\), as \((D+b^2)L=o(j^2)\). For \(j\le m<2j\) the Bell half-product is \(\gg j/\log(3j)\), dominating the \(O(VL)\) correction. Hence the same \(q_k>9\) midpoint signs count all the required circles in this range.

For \(m>m_0\) put
\[
 U=\max(1,m/j^2),\qquad d=\frac{j^2}{m(1+W(m))}.
\]
We have \(1/(2UL)\le d\le32\). Choose fixed \(A>1\), then \(B>1\) sufficiently large, and finally choose the theorem's \(C\) sufficiently large in terms of \(A,B\). Set
\[
 J=P=\lceil A U L^2\rceil,\qquad R'=AB U L^2,\qquad R=R'\sqrt V\, L^2.
\]
The estimates \(jR/m=O_{A,B}(L^5\sqrt V/j)\) and \(R/(N/j)=o(1)\) hold uniformly. In particular \(jR/m\) tends to zero faster than any fixed negative power of \(L\), since \(\sqrt V/j\le j^{-1}+\sqrt N/j^2\). The local disk is contained in the analytic domain for \(r=W(m-js)\), with \(\Re r\asymp L\), and \(D-k=\lfloor m/j\rfloor>R\) for all large \(N\).

The complex interpolation estimate (14) holds on \(|s|\le R\). In its proof \(|K|\le D+R=O(N/j)\), so \(|K\log H(r)|=O(VL)\) and the angular perturbation from \(H\) is \(O(VL|\theta|)\). Choose \(\theta_0=L/\sqrt m\). In the central arc the cubic error is \(O(L^5/\sqrt m)=o(1)\), and \(VL\theta_0=O(VL^{5/2}/j)=o(1)\). On \(\theta_0<|\theta|\le c/L\) the Gaussian loss \(\gg mL\theta^2\) dominates the perturbation, giving \(O(e^{-c' L^3})\) in absolute integral. On \(c/L\le|\theta|\le\pi\) the loss \(\gg m/L^2\) dominates both \(O(jR)\) and \(O(VL)\). These estimates retain the uniform relative \(1+o(1)\) in (14), including the endpoints of the integration arc.

Write \(\log C_*(s)=T(m-js)+U_0(s)\) as in that proof, where \(T'''=O(1/(m^2L))\) and \(\sup_{|s|\le R}|U_0(s)|=O(VL)\). On the smaller disk \(R'\), the remainder of \(U_0\) after its linear part is \(O(VL(R'/R)^2)=O(L^{-3})\). The cubic Taylor remainder for \(T\) is at most
\[
 O\!\left((AB)^3\frac{j^3U^3L^5}{m^2}\right)
 \ \le\
 \begin{cases}
  O\big((AB)^3/C^3\big),&m\ge j^2,\\
  O\big((AB)^3 L^7/j\big),&m<j^2 .
 \end{cases}
\]
The second line uses \(m>j^2/(20L)\). By the choice of \(C\), the analytic coefficient multiplier \(\Phi(s)\) obtained by removing the constant, linear and principal quadratic parts obeys \(\Phi(0)=1,\ \sup_{|s|\le R'}|\Phi(s)|\le2\). A uniform bound suffices for the derivative-series argument; convergence to one on this entire disk is unnecessary.

Normalize the deformed exponential \(F\) as in (15) and take its \(k\)-th root-midpoint circle of radius \(r_*\). Its reference ratios satisfy \(|\log(r_*/\widetilde R_k)|\le c_0 L\) by (13), and the logarithmic-derivative parameter \(M_d\le c_1 U L^2\) by (15), with absolute constants. Let \(Q\) be the degree-\(P\) Taylor section of \(\Phi\). The exact local coefficient identity and Cauchy's bounds imply
\[
 \frac{|Q(\mathcal D-k)F(z)-F(z)|}{|F(z)|}
 \le 2\sum_{p=1}^{P}\left(\frac{e\max(P,M_d)}{R'}\right)^p <\tfrac14
 \qquad (|z|=r_*),
\]
by first choosing \(A\ge c_1+1\), then \(B\) large. The central Taylor error relative to \(F(r_*)\) is \(O((J/R')^{P+1})\).

For \(|h|\ge J\) the reference term, relative to its index-\(k\) magnitude, is \(\le\exp(c_0L|h|-d|h|(|h|-1)/2)\). Since \(dJ\ge A L/2\), taking \(A\) large relative to \(c_0\) bounds this by \(\exp(-dh^2/3)\). Multiplication by \(Q(h)\) still gives \(\le\exp(-dh^2/4)\): use \(|Q(h)|\le2(P+1)\max(1,(|h|/R')^P)\) and \(P\log_+(|h|/R')\le P|h|/R'\le 2|h|/B\), while \(dJ^2\gg\log(P+1)\). At the actual cutoff and its next inward neighbor \(\Phi(h)\) and its inverse are bounded by \(2\) by the same Taylor bounds on \(\log\Phi\). Hence the actual outward coefficient ratio there is at most \(4\exp(c_0L-d(J-1))<1/2\). Global log-concavity gives the same bound further out. If the left side stops at coefficient zero, there is no omitted tail beyond the support. The full tail cost is \(O(e^{-dJ^2/5})F(r_*)\).

Both errors \((J/R')^{P+1}\) and \(e^{-dJ^2/5}\) are \(o(e^{-\pi^2/(2d)})\), since \(dJ\ge A L/2\) and \(J/R'\le2/B<1\). The circle minimum (12) and the \(1/4\) derivative bound now give Rouché's strict inequality. Each integer \(1\le k<D\) has a zero-free circle with exactly \(k\) zeros inside. Including the center and exterior counts gives one simple real zero per gap, as complex zeros come in conjugate pairs. Positivity of the original polynomial on \(t\ge0\) places them all on the negative axis.
