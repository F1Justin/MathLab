# A Jacobi product inequality and one-column Schubert matroids at every rank

Let \(A_k=P_k^{(1,1)}/(k+1)\), normalized by \(A_k(1)=1\). For every \(n\ge2\), every interior zero \(x\) of \(A'_n\), and every \(1\le j<n\),
\[
                     \frac{A_j(x)A_{n-j}(x)}{A_n(x)}<1.                 \tag{1}
\]
In particular, every one-column Ferrers board at every admissible finite rank has a Schubert \(Z\)-polynomial with simple strictly negative zeros. The proof gives a common strict interlacer for arbitrary nonnegative weights on individual cuts.

In the [Motzkin–rook formula](https://www.symmetricfunctions.com/schubertMatroidZ.htm), cutting a path at height zero and time \(j\) gives \(A_jA_{n-j}\). Thus an arbitrary weighted one-cut mixture is
\[
       F=A_n+\sum_{j=1}^{n-1}w_j(A_n-A_jA_{n-j}),\qquad w_j\ge0.
\]
The rank-\(n\) one-column board of height \(b<n\) takes \(w_j=1\) for \(j\le b\) and zero afterwards. By (1), \(F/A_n\ge1\) at every zero of \(A'_n\). Its endpoint values are \(1,(-1)^n\) at \(1,-1\). These \(n+1\) alternating signs give one simple zero in each interval between the endpoints and successive derivative nodes. Under the [normalized Schubert change of variable](rook_jacobi.md) all \(n\) roots are strictly negative.

## Discrete energy at a derivative node

By parity take \(x=\cos\phi\ge0\), \(0<\phi\le\pi/2\), and write \(u=\sin\phi\), \(j\le n/2\), \(k=n-j\). The derivative identity \((1-x^2)A'_n=n(A_{n-1}-xA_n)\) gives \(A_{n-1}=xA_n\) and \(A_n\ne0\). For \(j=1\) the ratio is \(x^2<1\). Henceforth \(k\ge j\ge2\).

Put
\[
 M_i=i+3/2,\quad d_i=(i+1)(i+2)(2i+3)/6,\quad v_i=\sqrt{d_i}A_i(x),
 \qquad a_i=\tfrac12\sqrt{1-\frac3{(2i+1)(2i+3)}} .
\]
The symmetric Jacobi recurrence reads \(xv_i=a_{i+1}v_{i+1}+a_iv_{i-1}\). Its edge coefficients \(0<a_i<1/2\) increase for \(i\ge1\). The energy
\[
 E_i=a_i^2v_{i-1}^2-a_i x v_{i-1}v_i+a_i^2 v_i^2
\]
satisfies \(E_{i+1}-E_i=(a_{i+1}^2-a_i^2)v_i^2\ge0\) by the recurrence. Completing the square yields \(4E_k\ge(4a_k^2-x^2)v_k^2\). At the derivative node, \(a_nv_{n-1}/v_n=nx/(2n+3)\), whence
\[
 \frac{4E_n}{v_n^2}=u^2-\frac3{(2n+1)(2n+3)}+\frac{9x^2}{(2n+3)^2}
 \le u^2+\frac9{4M_n^2}.
\]
Consequently, when the denominator is positive,
\[
 \left|\frac{A_k}{A_n}\right|^2
 \le \frac{d_n}{d_k}\,
 \frac{1+9/(4M_n^2 u^2)}{1-3/[4M_k(M_k-1)u^2]}.                    \tag{2}
\]

## The larger-angle range

Set \(T=31/10\). Suppose \(M_j u\ge T\). A second energy estimate gives
\[
 |A_j(\cos\phi)|^2
 \le \frac{8/\pi}{(M_j u)^3[1-3/(4M_j^2 u^2)]}.                    \tag{3}
\]
Indeed \(g=(\sin\phi)^{3/2}A_j(\cos\phi)\) satisfies \(g''+Vg=0\) with \(V=M_j^2-3/(4\sin^2\phi)\). The derivative of \(g'^2+Vg^2\) is \(V'g^2\ge0\) on \((0,\pi/2]\). Its value at \(\pi/2\), multiplied by \(M_j\), is at most \(8/\pi\). To check this constant, let \(j=2s+e\), \(e=0,1\), \(c_s=\binom{2s}{s}/[4^s(s+1)]\). The exact center values \(A_{2s}(0)=(-1)^s c_s\), \(A'_{2s+1}(0)=(2s+1)A_{2s}(0)\) give the two sequences
\[
 c_s^2 M_{2s}(M_{2s}^2-3/4),\qquad c_s^2 M_{2s+1}(2s+1)^2.
\]
Each increases to \(8/\pi\) by the central binomial asymptotic. Their successive ratios minus one are respectively
\[
 \frac{8s^2+20s+17}{4(s+2)^2(4s+3)(8s^2+12s+3)},\qquad
 \frac{1}{4(s+2)^2(4s+5)} .
\]
Dividing the energy bound by \(V u^3>0\) gives (3).

In (2) the product \(d_n(1+9/(4M_n^2u^2))\) increases with \(n\), since \(3d_n=M_n^3-M_n/4\). Use \(n\le2k\), \(d_{2k}/d_k<8\), \(M_{2k}/M_k\ge11/7\), \(M_k/(M_k-1)\le7/5\), and \(M_k u\ge T\). This gives
\[
 \left|\frac{A_k}{A_n}\right|^2
 \le 8\frac{1+(9/4)(7/(11T))^2}{1-(3/4)(7/5)/T^2}=\frac{127306}{12947}.
\]
Using \(\pi>3\), the right side of (3) is less than \(4000/41199\). The product of the rational bounds is \(509224000/533403453<1\), proving (1) in this range.

## The smaller-angle range

Suppose \(M_j u<T\). We first show \(A_j(x)>0\). Write \(j=2s+e\), \(s\ge1\), \(e\in\{0,1\}\). The Jacobi equation, with \(v=1-x^2\), gives
\[
 A_j(x)=x^e\, {}_2F_1(-s,s+e+3/2;2;v).
\]
The \(s\) zeros of the terminating series lie in \((0,1)\), since they correspond to the \(s\) positive zeros of \(A_j\). Write their reciprocals as \(\lambda_i\). Its first two coefficients give
\[
 S_2=\sum_i\lambda_i^2
 =\frac{s(2s+2e+3)(2s^2+(2e+3)s+4e+10)}{48}.
\]
For \(q=s-1\ge0\), \(16(M_j^4-96 S_2)\) is
\[
 \begin{cases}
 128q^4+896q^3+1856q^2+1008q+1,&e=0,\\
 128q^4+1152q^3+3392q^2+3600q+1857,&e=1.
 \end{cases}
\]
As \(T^4<96\), we have \(u^2<1/\sqrt{S_2}\le1/\max_i\lambda_i\), so all the factors \(1-\lambda_i u^2\) are positive. Also \(x>0\) since \(M_j\ge7/2>T\). This proves the claim. In the interior \(|A_j(x)|<1\), for example from the normalized Gegenbauer integral averaging \((x+iu t)^j\) over the semicircle density on \((-1,1)\).

We also have \(j\phi<\pi\). For \(j=2\) this follows from \(x>0\). For \(j\ge3\), \(\sin t\ge t-t^3/6\) gives \((j+3/2)\sin(\pi/j)\ge\pi\). Here \((1+3/(2j))(1-\pi^2/(6j^2))\ge1\) follows from \(\pi^2<10\) and \(j\ge3\). Since \(M_j\sin\phi<T<\pi\), this proves the strict angle bound.

Write \(R_l=A_{n-l}/A_n\), so \(R_0=1,R_1=x<1\). The normalized Jacobi recurrence in the backward direction is
\[
 R_l-R_{l-1}=(1+h_l)(R_{l-1}-R_{l-2})-(2+h_l)(1-x)R_{l-1},
 \qquad h_l=\frac{3}{n-l+1}.
\]
Until the first nonpositive value the terms decrease strictly. If \(R_j>0\) following a nonpositive value, there is a nonempty consecutive segment of strictly negative terms between \(R_0\) and \(R_j\). An isolated zero has opposite signs at its two neighbors by the three-term recurrence. Let \(p\le j-1\) be the length of such a segment. On these \(p\) sites form the positive vector \(v^-\) by taking minus \(\sqrt{d_{n-l}}R_l\). In the symmetric Jacobi recurrence, its two exterior neighbors are nonpositive. The Dirichlet Jacobi matrix \(J\) on the segment therefore satisfies \(Jv^-\ge x v^-\) componentwise. By the Rayleigh quotient,
\[
 x\le\frac{\langle Jv^-,v^-\rangle}{\|v^-\|^2}
 \le\cos\!\left(\frac{\pi}{p+1}\right)\le\cos(\pi/j)< x .
\]
The middle bound follows by increasing every positive off-diagonal entry to \(1/2\) and using the first sine eigenvector of the constant-coefficient path. Thus \(R_j\le1\) whenever \(R_j>0\); when \(R_j\le0\) the desired upper bound is immediate. With \(0<A_j(x)<1\), this completes the proof. The [algebraic checker](verify_single_cut.py) verifies the scalar identities and independently tests (1) at all derivative nodes through rank 24 using exact Sturm–Tarski queries.
