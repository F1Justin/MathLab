# Strict interlacing when a unit part is appended

Fix a Ferrers board \(B\) of height \(h\), with nonnegative column weights, and append unit parts to the associated Schubert partition. The board and its rook weights then stay fixed while the rank \(n\) increases. Let \(H(s)\) be its [fixed-board boundary polynomial](rook_jacobi.md#winding-criterion-for-every-fixed-board). If \(H\) has no zeros on the unit circle and has \(q\) zeros inside it, the \(n-1-2q\) real roots of the preceding row **strictly interlace** the \(n-2q\) real roots of the current row for all sufficiently large \(n\). In particular the full consecutive \(Z\)-polynomials strictly interlace when \(H\) has no zeros in the closed disk. This includes every fixed rectangular board with unit weights and the irregular boards certified in the [tall-column theorem](tall_column.md). The question about consecutive matroid polynomials and their difference appears in [Alexandersson's Motzkin–rook model](https://www.symmetricfunctions.com/schubertMatroidZ.htm).

In the disk-zero-free case there is an effective bound. Put \(M=\min_{|s|=1}|H(s)|\) and \(D=\sum_J 2^{|J|}w_J\), where \(w_J\) counts placements with row set exactly \(J\), including the empty placement. It suffices that
\[
 n\ge10(h+1),\qquad n-h-1>450(h+1)^3D^2/M^2 . \tag{1}
\]
For a given rationally weighted board, all smaller consecutive ranks can be tested by exact univariate polynomial arithmetic.

Write \(x=\cos\phi,\ z=e^{i\phi}\), and let \(A_k=P_k^{(1,1)}/(k+1)\). In the normalized variable each fixed-board row is \(F_n(x)=\sum_{k=0}^h c_k(x)A_{n-k}(x)\). The inclusion–exclusion formula over cuts in occupied rows defines \(c_k\) independently of \(n\). Each summand of \(c_k\) is a signed product of short \(A_i\)'s of total degree \(k\). Thus \(\deg c_k\le k\), and \(\sum_k|c_k(x)|\le D\) on \([-1,1]\). The boundary identity is \(\sum_k c_k(x)z^k=H(z^2)\).

Use \(U_n=A_n+i\sin\phi\,A'_n/n\) and the backward Jacobi amplitudes \(B_{n,k}\) with \(B_{n,0}=1,\ B_{n,1}=z\) from the fixed-board proof. Their defining identity is \(A_{n-k}=\Re(U_n\overline{B_{n,k}})\). Represent both rows in this same basis by
\[
 C_n=\sum_{k=0}^h c_k B_{n,k},\qquad
 V_n=\sum_{k=0}^h c_k B_{n,k+1}.
\]
Then \(F_n=\Re(U_n\overline C_n)\), \(F_{n-1}=\Re(U_n\overline V_n)\). Uniformly on the circle \(B_{n,k}\to z^k\) for fixed \(k\). Consequently \(C_n\to H(z^2)\), \(V_n\to z H(z^2)\). More precisely,
\[
 \frac{\Im(V_n\overline C_n)}{\sin\phi}
 \longrightarrow |H(z^2)|^2
\tag{2}
\]
uniformly all the way to both endpoints, using continuous extension at \(\phi=0,\pi\). To see this, the numerator error \(E_n=\Im(V_n\overline C_n)-\sin\phi\,|H(z^2)|^2\) is a real sine polynomial of degree at most \(d=4h+1\). Its supremum tends to zero. Its sine coefficients have absolute value \(\le2\|E_n\|_\infty\), and \(|\sin(k\phi)|\le k\sin\phi\) for \(0\le\phi\le\pi\). This gives \(\sup |E_n/\sin\phi|\le d(d+1)\|E_n\|_\infty\).

For \(n\ge10(h+1)\) the uniform Jacobi estimate in the fixed-board proof gives \(\max_{k\le h+1}|B_{n,k}-z^k|\le e=9(h+1)/(n-h-1)\le1\). Hence \(\|E_n\|_\infty\le(2e+e^2)D^2\). Condition (1) puts \(d(d+1)(2e+e^2)D^2<M^2\). It also makes \(eD<M\), so \(C_n\) is homotopic to \(H(z^2)\) without meeting zero. At both endpoints \(C_n=H(1)=1\). These assertions also hold eventually in the nonzero-winding case, with the complementary complex zero count furnished by the fixed-board theorem.

The continuous argument of \(U_n\overline C_n\) starts at 0 and ends at \(N\pi\), \(N=n-2q\). The fixed-board root count gives exactly \(N\) simple real roots in \(0<\phi<\pi\); when \(q=0\) this also follows immediately from the winding and the degree under (1). By continuity the argument must reach \((k-1/2)\pi\) in increasing order for \(1\le k\le N\). Each hit is a root, exhausting the count. At the \(k\)th root in this order \(U_n\overline C_n=i(-1)^{k-1}|U_n C_n|\). Since (2) gives \(\Im(V_n\overline C_n)>0\) in the open interval,
\[
 \operatorname{sgn}F_{n-1}(\cos\phi_k)=(-1)^{k-1}.
\]
Thus there is one root of \(F_{n-1}\) in each gap between consecutive roots of \(F_n\). The degree when \(q=0\), or the preceding row's fixed-board count when \(q>0\), supplies exactly \(N-1\) real roots and rules out any extra roots in the gaps. The monotone change \(t=(x-1)/(x+1)\) and the positive row normalization preserve the interlacing.

For \(q=0\) Alexandersson's difference \(Q_n(t)=(Z_n(t)-(1+t)Z_{n-1}(t))/t\) consequently also strictly interlaces \(Z_{n-1}\): at each of its negative roots the value is \(Z_n(t)/t\) with alternating signs, and \(\deg Q_n\le n-2\) since both \(Z\)-polynomials have leading and constant coefficient one.
