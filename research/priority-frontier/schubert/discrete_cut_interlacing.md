# Finite Jacobi transfers for adjacent one-column Schubert rows

For \(A_m=P_m^{(1,1)}/(m+1)\), compare
\[
 F_m=A_m+\sum_{j=1}^{n-2}w_j(A_m-A_j A_{m-j}),\qquad m=n-1,n,\quad w_j\ge0 .
\]
**Theorem.** For every \(n\ge3\) and every such choice of weights, the \(n-1\) roots of \(F_{n-1}\) strictly interlace the \(n\) roots of \(F_n\). In particular this holds at every admissible rank for a single column of any fixed height, using an initial string of unit weights followed by zeros. The following reduction gives a pointwise two-dimensional test for the entire cone of weights. It uses [one-cut real-rootedness](single_cut.md) and [strict motion of the extreme roots at every rank](column_tail_interlacing.md).

## Two transfer tests

By symmetry take \(x=\cos\phi\ge0,\ u=\sin\phi>0\). Every nonextreme root of \(F_n\) obeys \(u^2\ge12/[(n-1)(n+4)]\). Indeed, such a root lies between the two extreme derivative nodes of \(A_n\), and \(A_n''(1)/A_n'(1)=(n-1)(n+4)/6\) bounds \(2/(1-x_*^2)\) for the pair \(\pm x_*\) of extreme derivative nodes. Write
\[
 v_i=(A_i,d_i),\quad d_i=u A'_i/i=(A_{i-1}-xA_i)/u,\quad
 v_0=(1,0),\qquad R=\begin{pmatrix}x&u\\-u&x\end{pmatrix}.
\]
Backward propagation by \(k\le n/2\) steps gives \(T_kv_n=v_{n-k}\), each factor at step \(l=1,\dots,k\) being \(\mathrm{diag}(1,1+3/(n-l))R\). Forward regular propagation is \(v_i=R^{\mathsf T}\mathrm{diag}(1,(i-1)/(i+2))v_{i-1}\).

For free data \(v=(a,d)\) define \(D(v)=(a-\theta d,d)\), \(W(v)=D(v)\cdot v\), with \(\theta=3x/[(n-1)u]\). At the possible nodes \(W\) is positive definite since \(\theta^2\le3(n+4)/(4(n-1))-9/(n-1)^2<4\) for \(n\ge3\). Put \(k=\min(j,n-j)\). The tests are
\[
 A_k D(v)\cdot T_kv<W(v)\quad(j=k),\qquad
 (T_kv)_1 D(v)\cdot v_k<W(v)\quad(j=n-k).                         \tag{1}
\]
The second case only needs \(k\ge2\). For the first with \(k=1\), the difference is exactly \(u^2\|v\|^2\). For each cut \(j\) the pair of values of its product term in the basis \((F_n,(F_{n-1}-xF_n)/u)\) is \(A_j v_{n-j}\). Thus (1) gives strictly positive scalar product with \(D(v_n)\), including the initial term \(W(v_n)>0\). At a zero of \(F_n\) this scalar product equals \(d_n F_{n-1}/u\). The signs of \(A'_n\) alternate there by the common strict interlacer. The extreme zeros already give the required signs by their strict outward motion, including arbitrary weights. Hence (1) on the indicated region gives strict interlacing for all weights. Evaluation at the old negative roots then gives strict interlacing of the difference polynomial with the old row.

## The oscillating range

Put \(M_i=i+3/2,\ g_i=(i+1)(i+2)(2i+3)/6,\ c_i=3/[4M_i(M_i-1)u^2],\ H_i=3x/(2M_i u),\ \ell_i=i/M_i\). The increasing discrete energy from [the one-cut proof](single_cut.md) applies to every solution of the symmetric three-term recurrence. Dividing \(4E_i\) by \(g_i u^2\) gives exactly
\[
             (\ell_i d-H_i a)^2+(1-c_i)a^2.                       \tag{2}
\]
For \(m=n-k\), \(g_n/g_m\le(n/m)^3\). At \(n\), (2) is at most \((1+H_n+H_n^2)\|v\|^2\). At \(m\) it is at least \((1-c_m)a^2\), and also at least \((1-c_m-H_m)\ell_m^2\|(a,d)\|^2\) when the coefficient is positive. The continuous Jacobi energy of the regular solution gives
\[
 (\ell_k d_k-H_k A_k)^2+
 \left(1-\frac{3}{4M_k^2u^2}\right)A_k^2 \ \le\ \frac{8}{\pi(M_ku)^3}.
\]
This is the energy of \(u^{3/2}A_k\), bounded at \(\pi/2\) in the [larger-angle proof](single_cut.md).

For \(k\ge20,\ ku\ge5\), use \(H_m,H_k\le3/10,\ H_n\le3/20,\ c_m,c_k\le3/100,\ \ell_k^{-1},\ell_m^{-1}\le43/40,\ \theta\le4/13,\ g_n/g_m<8\). Relative to \(\|v\|^2\), the absolute value of either left side of (1) is bounded by
\[
 (1+4/13)(43/40)
 \sqrt{\frac{8(1+3/20+9/400)\,8/3}{125(1-3/100)(1-3/100-3/10)}}
 <1-2/13\ \le W(v)/\|v\|^2 .
\]
The scalar factor in each product uses the stronger coordinate estimate in (2) or its continuous version. For \(k\ge6,\ ku\ge6\) instead use \(H_n\le1/8,\ H_m,H_k\le1/4,\ c_m,c_k\le1/48,\ \ell_i^{-1}\le5/4,\ \theta\le3/11\), and replace \(125\) by \(216\) in the same calculation. The bound is \(<1-3/22\).

## Short cuts at every rank

The [two-variable finite checker](verify_discrete_cut.py) covers \(2\le k\le19\), including all \(n\ge2k\). It uses \(t=\tan(\phi/2)\in[0,1],\ p_0=1/[(n-1)u]\in[0,5/8]\); the latter bound follows from \(12p_0^2\le1+5p_0u\). It discards boxes outside these constraints or \((2k-1)p_0u\le1\), and uses the oscillating-range proof when applicable. At step \(l\) it stores
\[
 T_{11}=1+u^2 E,\quad T_{12}=lu+u^2B,\quad
 T_{21}=-lu+u^2H,\quad T_{22}=1+3lp_0 u+u^2K,\quad
 A_l=1+u^2G,\quad d_l=uJ .
\]
Updates result from multiplying the elementary transfers and using \((1-x)/u^2=1/(1+x)\). Put \(a=-G-A_kE\). In the first test the difference matrix divided by \(u^2\) has entries
\[
 a,\quad (-\theta a-A_k(B+H))/2,\quad -G-A_k(K-\theta B+3kp_0u/(1+x)).
\]
In the second conjugate by \(\mathrm{diag}(1/u,1)\); its other two entries are \((-\theta ua-JT_{11}-A_k(k+uB))/2\) and \(1-T_{12}(-\theta A_k+uJ)\).

On the entire \(u=0\) face the common first entry is \(L=k(5k+3)/8\), the first matrix's other entries are \(3p_0(k-L)/2,\ L-3p_0^2k(k-1)/2\), and those of the second are \(-(5k+3)/8,\ 1\). Its determinant is \(3(k-1)(5k+3)/64\).

## A Newton expansion uniform in the integer cut length

It remains to consider \(k\ge20,\ ku\le5\), where \(x>0\). Set
\[
 h=1/k,\quad s=k\tan\phi,\quad p=1/(n\tan\phi),\quad
 \beta=ps=k/n,\qquad \theta=3p/(1-h\beta).
\]
Then \(0\le s\le21/4,\ \beta\le1/2,\ p\le5/16,\ 12p^2(1+h^2s^2)\le1+3h\beta-4h^2\beta^2\). For the bound on \(p\), use \(n\ge40\) in \(12p^2\le1+3/n\).

Strip \(x^l\) from the backward \(l\)-step transfer and call the matrix \(U(l)\). With \(X=lh\) and \(\Delta U(l)=U(l+1)-U(l)\), its rows satisfy
\[
 \Delta U_1/h=sU_2,\quad
 (1-(X+h)\beta)\Delta U_2/h=3\beta U_2-s[1-(X-2h)\beta]U_1.
\]
For \(N_q(l)=q!h^q\binom lq\) one has \(\Delta N_{q+1}/h=(q+1)N_q,\ XN_q=N_{q+1}+qhN_q\). Expand each column in this Newton basis. Denote the coefficient of \(N_q\), multiplied by \(N_q(k)/s^q\), by \(b_{i,q}\) in row \(i\). The zeroth column pair is that of the identity, and \(b_{1,-1}=0\). Coefficient comparison gives, for \(0\le q<k\),
\[
 \begin{split}
 b_{1,q+1}&=(1-qh)b_{2,q}/(q+1),\\
 b_{2,q+1}&=\frac{1-qh}{(q+1)(1-(q+1)h\beta)}
 \big[(q+3)p b_{2,q}-(1-(q-2)h\beta)b_{1,q}
          +p(1-(q-1)h)b_{1,q-1}\big].
 \end{split}                                                       \tag{3}
\]
This finite expansion follows by matching the difference equation on the \(k\) sites \(0,\ldots,k-1\), where the basis is triangular. Thus \(U(k)=\sum_{q=0}^k s^q b_q\), and all further terms vanish. One can range \(h\) over a single interval during verification: factors \(1-qh\) may be replaced with their positive parts, and terms multiplying inactive coefficients may be clipped to \(0\le(q+1)h\le1\). For \(q\ge1\), \((1-qh)/(1-(q+1)h\beta)\le1\).

At an actual \(s>0\) set \(z_{i,q}=s^{q-2}b_{i,q}\) and truncate at \(Q=72\). For \(q\ge Q\) the absolute coefficients of \(z_{2,q},z_{1,q},z_{1,q-1}\) in the update for \(z_{2,q+1}\) are at most \((q+3)/(2(q+1)),\ (21/4)/(q+1),\ (21/8)/(q+1)\). The first-row coefficient is at most \((21/4)/(q+1)\). If \(M\) bounds both last levels \(Q-1,Q\), induction gives \(|z_{i,Q+l}|\le (4/5)^lM\), since the sum of the three bounds with the last divided by \(4/5\) is \(<4/5\). The omitted sum is at most \(4M\), including its limit at zero.

For a semicircle variable \(Y\) with moments \(m_{2j}=\mathrm{Cat}_j/4^j\), we have exactly
\[
 \bar A=x^{-k}A_k=\mathbb E(1+ihsY)^k,\qquad
 \bar d=x^{-k}d_k=\mathbb E(hs-iY)(1+ihsY)^{k-1},\qquad
 V=x^{-2k}=(1+h^2s^2)^k .
\]
The verifier sums \(G=(\bar A-1)/s^2,\ J=\bar d/s,\ B_0=(V-1)/s^2\) by the ordinary binomial theorem. It truncates before index \(j=36\) in \(G,J\) and after \(j=36\) in \(V\). Each omitted absolute tail is \(<10^{-23}\) by \(s\le21/4,\ h\le1/20,\ h^q\binom{k}{q},h^q\binom{k-1}{q}\le1/q!\). Ratios of successive majorants after the first omitted index are \(<1/20\).

Write \(U_{11}=1+s^2E,\ U_{12}=s+s^2B,\ U_{21}=-s+s^2H,\ U_{22}=1+\theta s+s^2K\). In (3) the coefficient of \(s\) in \(U_{21}\) is exactly \(-(1+2h\beta)/(1-h\beta)\), giving the correction \(-3hp/(1-h\beta)\) in \(H\). Multiply both difference matrices of (1) by \(V\). Normalizing the first by \(1/s^2\) and the second by congruence with \(\mathrm{diag}(1/s,1)\) gives common leading entry and respective remaining entries
\[
 \begin{split}
 a&=B_0-G-\bar A E,\\
 b&=(-\theta a-\bar A(B+H))/2,\qquad c=B_0-G-\bar A(K-\theta B),\\
 b_2&=(-\theta sa-JU_{11}-\bar A(1+sB))/2,\qquad
 c_2=V-s(1+sB)(-\theta\bar A+sJ).
 \end{split}
\]
The [three-variable checker](verify_discrete_newton.py) tests \(a>0,\ ac>b^2,\ ac_2>b_2^2\) on boxes in \(h,p,s\). It may first apply (2) to both left sides of (1), using the regular-vector intervals. Upper bounds on \(H_n,H_m,c_m\) are \(3p/2,\ (3p/2)/(1-\beta),\ 3p^2(1+(hs)^2)/(4(1-\beta)^2)\), and \(\|D\|\le1+\theta/2+\theta^2/8\) by the singular value of a shear.

With python-flint 0.9 and 88-bit precision, the three-variable verifier terminated with 175,264 accepted or excluded boxes. The short-cut verifier at 96 bits terminated for every integer cut from 2 through 19. These two certificates, the exact first cut, and the oscillating-range estimates cover every rank and every cut in (1).

## Extending the height in the last row

The theorem also permits a new cut of arbitrary weight \(w_{n-1}\ge0\) at the appended position. Let \(F_n^0\) be the rank-\(n\) row already proved to interlace \(F_{n-1}\). At each old root \(r\) its sign is opposite to \(A'_{n-1}(r)\): the latter is positive at the largest old root by the common interlacer, \(F_n^0\) is negative there, and both signs alternate through the ordered old roots. The newly allowed cut contributes exactly
\[
 w_{n-1}\big[A_n(r)-rA_{n-1}(r)\big]
       =-\frac{w_{n-1}(1-r^2)}{n+2}\,A'_{n-1}(r).
\]
Thus the alternating strict signs persist for every nonnegative new weight. The values at \(x=\pm1\) stay \((\pm1)^n\), which supplies both exterior intervals. The rank-one to rank-two case follows from \(A_1=x,\ A_2=(5x^2-1)/4\): the new row, including its last cut, is negative at the old root zero.

Consequently [Alexandersson's row-extension question](https://www.symmetricfunctions.com/schubertMatroidZ.htm) has an affirmative answer for every partition of rank \(n\ge2\) with \(\lambda_2\le2\), independently of \(\lambda_1\). Its board rows have lengths \(\lambda_{j+1}-1\in\{0,1\}\); appending a part of size two may extend a full column by one cell, and appending a part of size one adds an empty row. At successive old roots \(t<0\), \(Q_n(t)=[Z_n(t)-(1+t)Z_{n-1}(t)]/t=Z_n(t)/t\) alternates strictly. The constant and leading coefficients of both rows are one. Thus \(\deg Q_n\le n-2\), with exactly one simple root in each of the \(n-2\) gaps of \(Z_{n-1}\) for \(n\ge3\); \(Q_2\) is a nonzero constant. This establishes the original interlacing question throughout the empty- and one-column family.
