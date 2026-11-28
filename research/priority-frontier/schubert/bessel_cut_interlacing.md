# Uniform adjacent-rank interlacing for single-column Schubert boards

There is an absolute \(n_0\) such that for every \(n\ge n_0\) and **every** single-column board height \(1\le b<n\), all \(n\) roots of its Schubert \(Z\)-polynomial strictly interlace the \(n+1\) roots obtained by appending a unit part. Alexandersson's difference polynomial then strictly interlaces the old row as well. The column weight is one. [Definitions and fixed-rank reductions](column_tail_interlacing.md) · [Alexandersson's question](https://www.symmetricfunctions.com/schubertMatroidZ.htm)

The [small- and large-height estimates and bounded endpoint reduction](column_tail_interlacing.md) show that a sequence of failures with unbounded rank would give \(t\ge\sqrt{12}\) and \(0<c<1\) such that
\[
 L=cg(t)-\int_0^c g(st)g((1-s)t)\,ds=0,\qquad
 g'(t)D\le0,\qquad
 D=cg'(t)-\int_0^c g(st)g'((1-s)t)\,ds,
\]
where \(g(v)=2J_1(v)/v\), \(g(0)=1\). We exclude the entire range with a pointwise strict bound. The proof includes an [outward-rounded interval certificate](verify_bessel_cut.py).

Set \(p=1/t\), \(a=g(t)\), \(b_1=g'(t)\), and \(W=a^2+3pa b_1+b_1^2\). Since \(g''+3g'/t+g=0\), \((a,b_1)\ne(0,0)\). We prove, for every \(0<s<t\),
\[
 g(s)\big[(a+3pb_1)g(t-s)+b_1g'(t-s)\big]<W.                    \tag{1}
\]
Integrating (1) at \(s\mapsto st\) yields \((a+3pb_1)L+b_1D>0\), contradicting the two necessary conditions above. The bound uses an absolute threshold in the rank theorem through its compactness argument. It gives no numerical value for that threshold.

## The two quadratic forms

Write \(r=\min(s,t-s)\). Let \(T(r)\) be the transfer matrix carrying initial data \(v=(a,b_1)^{\mathsf T}\) of the differential equation \(y''+3y'/t+y=0\) at \(t\) to \((y(t-r),y'(t-r))^{\mathsf T}\). Put \((A,B)^{\mathsf T}=T(r)v\). We establish the following stronger bounds for every nonzero real initial vector, taking the regular Bessel solution only at the shorter argument \(r\):
\[
 \begin{split}
 g(r)\big[(a+3pb_1)A+b_1B\big]&<W,\\
 A\big[(a+3pb_1)g(r)+b_1g'(r)\big]&<W.                       \tag{2}
 \end{split}
\]
Setting \(v=(g(t),g'(t))\) gives (1) on either side of the midpoint.

### Shorter argument at least five

For any real solution \(y\) on the transfer interval let \(f(v)=v^{3/2}y(v)\), \(Q(v)=1-3/(4v^2)\), and \(H=f'^2+Q f^2\). The equation gives \(H'=Q'f^2\ge0\) and \((H/Q)'=-Q'f'^2/Q^2\le0\) on \(v\ge5\). Also
\[
 H/v^3=(1+3/(2v^2))y^2+(3/v)yy'+(y')^2 .
\]
When \(r\ge5\), we have \(t\ge10\) and \(t-r\ge t/2\ge5\). The monotonicity of \(H\) gives
\[
 \|T(r)v\|\le G\|v\|,\qquad
 G^2=8\,\frac{1+3/20+3/200}{1-3/10}.
\]
For the regular solution, the power series for \(g\) gives \(H(5)/Q(5)<8/3\), checked in the certificate. The monotonicity of \(H/Q\) gives \(\|(g(r),g'(r))\|\le M\), where \(M^2=8/[3\cdot125(1-3/10)]\). Finally \(\|(a+3pb_1,b_1)\|\le(1+3/10)\|v\|\), and \(W\ge(1-3/20)\|v\|^2\). Both expressions on the left of (2) have modulus at most \(MG(1+3/10)\|v\|^2\). The strict inequality \(MG(1+3/10)<1-3/20\) proves (2).

### Compact rectangle, including both endpoint limits

For \(0<r\le5\), check \(0\le p\le19/64\) and \(pr\le1/2\). This covers \(t\ge\sqrt{12}\), since \(1/\sqrt{12}<19/64\). Let \(D_1,D_2\) be the symmetric matrices of the quadratic forms given by the right side of (2) minus its first and second left sides. At \(r=0\), \(D_1=0\) and the second quadratic form is \(b_1^2\). The certificate checks \(D_1/r^2\) and \(\operatorname{diag}(1/r,1)D_2\operatorname{diag}(1/r,1)\) with both singularities removed at zero. For positive \(r\) these preserve positive definiteness.

Write the entries of \(T\) as
\[
 T_{11}=1+r^2 e,\quad T_{12}=-r+r^2 f,\quad
 T_{21}=r+r^2 h,\quad T_{22}=1+3pr+r^2 k,
\]
and set \(g=1+r^2 d,\ g'=r d_1\) at \(r\). Both test matrices have top-left entry \(a_0=-d-ge\). The upper-right and bottom-right entries in the first are
\[
 b_0=-[3pd+g(f+3pe+h)]/2,\qquad c_0=-d-g(k+3pf).
\]
Those of the second are
\[
 b_2=[3pr a_0-T_{11}d_1-(T_{12}/r)g]/2,\qquad
 c_2=1-T_{12}(3pg+g').
\]
These formulas follow by multiplying the two real linear factors in (2). Each test requires \(a_0>0\) and a positive determinant.

For either transfer column, write \(y(t-r)=\sum q_j r^j\). The two initial pairs \((q_0,q_1)\) are \((1,0),(0,-1)\), and the second transfer component is the negative derivative with respect to \(r\). The differential equation yields \(q_{-1}=0\) and
\[
 q_{j+2}=p\frac{j+3}{j+2}q_{j+1}
          -\frac{q_j-pq_{j-1}}{(j+1)(j+2)} .
\]
The endpoint-regular functions \(e,f\) use coefficients starting at \(q_2\); \(h,k\) start at \(-3q_3\). In boxes with radius upper bound \(R_0\), the verifier first checks \(p_{\rm hi}\max(1,R_0)\le35/64\). On the complex circle of radius \(R=(3/2)\max(1,R_0)\), the transfer equation is
\[
 T'(r)=\begin{pmatrix}0&-1\\1&3p/(1-pr)\end{pmatrix}T(r).
\]
Since \(R\le12\) and \(pR<0.825\), the norm integral along any radius is at most \(12+3(0.825)/(1-0.825)<27\). Thus \(|q_j|\le e^{27}R^{-j}\). Truncating through \(j=148\) costs less than \(10^{-10}\) in each of the four regular series, including the index factor from differentiation. Indeed the weighted geometric tail is bounded by \(3(148+4)e^{27}(3/2)^{-149}\). The verifier uses the series \(g(r)=\sum_{j\ge0}(-r^2/4)^j/[j!(j+1)!]\) through index 36, with the same error margin for \(d,d_1\) by a geometric majorant even at radius 8.

When a whole box lies at \(r\ge1.5\), direct unnormalized matrices are more efficient. The same series enclose the transfer at the center of the box. For real arguments the transfer satisfies \(\partial_r\|T(r)v\|^2=6p|(T(r)v)_2|^2/(1-pr)\). Hence \(\|T(r)\|\le(1-pr)^{-3}\), and the transfer from a point \(s\) to \(r\) has bound \([(1-ps)/(1-pr)]^3\). The equation and variation of constants give
\[
 \|\partial_r T\|\le[1+3p/(1-pr)](1-pr)^{-3},
 \qquad \|\partial_p T\|\le 3r(1-pr)^{-4}.
\]
For the latter estimate the norm of the integrand is at most \((1-pr)^{-3}3/(1-ps)^2\), which integrates to the stated bound. Multiplying by the box half-widths encloses the transfer throughout. Both \(g,g'\) are 1-Lipschitz by their semicircle integral. The two determinants are then checked directly from (2).

All endpoints and bisections are dyadic. A box is discarded only when its lower corner satisfies \(pr>1/2\). With python-flint and 112 bits of working precision the verifier accepted 2,730 boxes on the inequalities and discarded 141 outside the parameter region. This completes the proof of (1).

For a separate finite check, [the exact polynomial verifier](verify_column_tail.py) constructs both ranks from the cut identity and computes their signed remainder sequence over the integers. Opposite parity makes each quotient a positive multiple of \(x\). Positive leading coefficients at every step down to degree zero imply strict interlacing by induction on the remainders. It passed every height for \(2\le n\le100\), or 4,950 adjacent pairs. The interval between this finite check and the existential threshold remains unverified at general heights.
