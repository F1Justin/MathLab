# Boundary rows of a skew lattice path matroid

Let a connected skew shape have rank \(n\ge3\) in the north-step convention. Suppose the top-left cells of its \(2\times2\) squares occur only in rows \(1\) and \(n-1\), counting from the top. Either row may be empty. Then its matroid \(Z\)-polynomial has \(n\) simple negative roots. The same holds for its rank-\(n\) rook matroid in the convention of Bonin and de Mier. The row widths and the rank are unrestricted. With the two boundary rows fixed, inserting a row with no such cells between them gives strict interlacing whenever the weights of the one- and two-rook placements are preserved.

Simple negative roots also hold when the first **two** rows and the last row may contain cells. The upper two rows can overlap in arbitrary columns. There is no width bound at any of the three positions.

The input is Alexandersson's Motzkin formula for connected skew shapes, stated as a theorem with a proof sketch in his online notes. The board in row \(j\) is the integer interval \(\mu_j<c<\lambda_{j+1}\). An admissible pair of rooks in rows \(j<k\) has columns \(c_j>c_k\). At unit weights the path formula gives the matroid invariant. The same-shape identity for the rook matroid follows from Bonin–de Mier, Theorem 4.7, and valuativity of \(Z\). Their §4 explicitly uses unoccupied rows and occupied columns for bases, switching the row and column convention in Alexandersson–Jal. [Alexandersson's skew-shape theorem](https://www.symmetricfunctions.com/schubertMatroidZ.htm) · [Bonin and de Mier](https://arxiv.org/html/2506.06109v2#S4) · [Ferroni and Schröter](https://doi.org/10.1112/jlms.12984)

For comparison, the single-cut theorem applies to every connected skew board supporting at most one nonnesting rook at a time. Such a board is empty, has only one nonempty row, or has all its nonempty rows consisting of one common column. Indeed if \(j<k\) are both nonempty with intervals \([L_j,R_j],[L_k,R_k]\), their endpoints decrease weakly with the row index. The absence of an admissible pair forces \(R_j\le L_k\), hence all four endpoints agree. [Single-cut theorem](single_cut.md)

## The boundary weights

Let \(a,b\) be the sums of the cell weights in the top and bottom active rows. Let \(d\) be the sum of the products of the weights in admissible pairs. For nonnegative weights \(0\le d\le ab\). The proof in fact allows any nonnegative \(a,b,d\) with \(4d\le(a+b)^2\). In rank at least four, an intervening empty board row forces the two active intervals to be disjoint and strictly ordered, so \(d=ab\) for multiplicative weights. The result also covers overlapping intervals in rank three. An example with arbitrary positive integer widths \(a,b\) in every \(n\ge4\) is
\[
  \lambda=(b+a+2,b+a+2,(b+1)^{n-2}),\qquad
  \mu=(b+1,b^{n-3},0,0).
\]

Put \(x=(1+t)/(1-t)\), and divide the path polynomial by \((1-t)^n\). The unrestricted polynomial becomes \(A_n=P_n^{(1,1)}(x)/(n+1)\), with \(A_1=x\). A return to zero at either boundary time leaves \(x A_{n-1}\). Returns at both leave \(x^2 A_{n-2}\). Inclusion–exclusion gives the normalized board polynomial
\[
  B_n=(1+a+b+d)A_n-(a+b+2d)x A_{n-1}+d x^2 A_{n-2}.             \tag{1}
\]

## Polarization

For \(-1<x<1\) set \(u=\sqrt{1-x^2}\) and \(s=x/u\). Let \(V\) have density \(2\sqrt{1-v^2}/\pi\) on \((-1,1)\). Define \(p_m(s)=\mathbb E(s+iV)^m\). Its moments \(\mathbb E V^{2j}=\mathrm{Cat}_j/4^j\), together with the unrestricted Motzkin count \(\binom{m}{2j}\mathrm{Cat}_j\), give \(A_m(x)=u^m p_m(s)\). In particular \(p_m\) is monic with \(m\) simple real roots, since \(A_m\) has \(m\) simple roots in \((-1,1)\).

There are positive \(h_1,h_2\) with sum \(2+a+b\) and product \(1+a+b+d\), since their discriminant is \((a+b)^2-4d\ge0\). With \(Y=iV\), equation (1) reduces to
\[
 f_n(s):=u^{-n}B_n(x)=\mathbb E(s+Y)^{n-2}(s+h_1Y)(s+h_2Y).       \tag{2}
\]
The polynomial \(P(z_1,\ldots,z_n)=\mathbb E\prod_{j=1}^n(z_j+Y)\) is the unique symmetric multiaffine polarization of \(p_n\). For any real-rooted polynomial \(p\) of degree \(n\), its polarization has no zero with all coordinates in the open upper half-plane by Grace–Walsh–Szegő. Hence \(T_cp(s)=\operatorname{Pol}_n(p)(c_1s,\ldots,c_ns)\) is real-rooted for any positive \(c_j\). On \(s^k\), \(T_c\) acts by the positive scalar \(e_k(c)/\binom nk\), so it is invertible on real polynomials of degree at most \(n\). A degree-\(n\) polynomial is in the interior of the real-rooted set precisely when it has simple real roots. This follows by isolating simple roots in disjoint sign intervals and by perturbing any repeated pair \((s-r)^2\) to \((s-r)^2+\epsilon\). Thus \(T_c\) also preserves simplicity at every degree-\(n\) input with simple real roots. [Grace–Walsh–Szegő and polarization](https://doi.org/10.1007/s00209-021-02825-4)

There is also a direct count for (2). For a path with \(k\) up-steps, choose its \(2k\) nonhorizontal positions and a Dyck path of length \(2k\). Positivity after time \(1\) means that position \(1\) was chosen, and positivity after time \(n-1\) means that position \(n\) was chosen. According to whether neither, one, or both were chosen, the total placement weights are \(1\), \(1+a\) or \(1+b\), and \(1+a+b+d\). Consequently
\[
 \gamma_k=\mathrm{Cat}_k\!\left[
  \binom{n-2}{2k}+(2+a+b)\binom{n-2}{2k-1}
       +(1+a+b+d)\binom{n-2}{2k-2}\right]
   =\mathrm{Cat}_k\,e_{2k}(1^{n-2},h_1,h_2),
\]
with out-of-range binomial coefficients interpreted as zero. Multiplication by \((-1/4)^k s^{n-2k}\) and summation recovers (2).

Now take \(c=(1,\ldots,1,h_1^{-1},h_2^{-1})\). Equation (2) reads \(f_n=h_1h_2 T_c p_n\). All its roots are simple and real. The increasing bijection \(s\mapsto x=s/\sqrt{1+s^2}\mapsto t=(x-1)/(x+1)\) puts the \(n\) roots at distinct negative real points.

## Strict interlacing under insertion of an empty board row

Keep \(a,b,d\) fixed, so that the scale factors \(h_1,h_2\) stay fixed. Compare ranks \(n\ge4\) and \(n-1\). Removing one unscaled factor \(s+Y\) in (2) gives \(f_{n-1}\). We prove that this operation gives strict interlacing.

For a real polynomial \(p\) of degree \(n\) with simple real roots, put \(F=T_c p\), \(G(s)=(\partial_1\operatorname{Pol}_n p)(c_1s,\ldots,c_ns)\). The polynomial \(F(s)+wG(s)\) is stable in \((s,w)\) by the specialization \(z_1=c_1s+w\). For real \(r\) this implies \(F'(r)G(r)-F(r)G'(r)\ge0\). Indeed where \(G(r)\ne0\), the rational function \(F/G\) has nonnegative imaginary part immediately above \(r\), since \(-F/G\) cannot lie in the upper half-plane there. Differentiation normal to the real axis gives the inequality, which extends to all \(r\) by continuity.

If \(F(r)=G(r)=0\), apply this inequality for both signs of small perturbations \(p+\epsilon q\), which still have simple real roots. Its linear term must vanish, so \(F'(r)G_q(r)-F_q(r)G'(r)=0\) for all \(q\), using the same two operators on \(q\). Taking \(q=1\) gives \(G'(r)=0\); taking \(q(s)=s\) gives \(G_q=1/n\) and hence \(F'(r)=0\), contrary to the simplicity of \(F\). Thus at the \(n\) simple real roots of \(F\), \(G\) has the alternating signs of \(F'\). It has degree \(n-1\) and strictly interlaces \(F\).

For \(p=p_n\), the two polynomials are \(f_n/(h_1h_2)\) and \(f_{n-1}/(h_1h_2)\). The same rank-independent change of variables gives strict interlacing of \(Z_{n-1}\) and \(Z_n\). Moreover \((Z_n-(1+t)Z_{n-1})/t\) has degree at most \(n-2\), since both \(Z\)'s are monic with constant one. At the \(n-1\) roots of \(Z_{n-1}\) its signs alternate, so it has precisely \(n-2\) simple negative zeros, one in each intervening interval.

## A third boundary row

Suppose all nonempty board rows lie in \(\{1,2,n-1\}\), with \(n\ge5\). An intervening empty board row separates the last row strictly to the left of both upper rows. Let \(a,b\) be the sums of cell weights in the first two rows, \(d\) the total weight of their admissible pairs, and \(c\) the sum in the last row. Thus choosing a last-row rook contributes an independent factor \(c\) whenever the path is positive there. We prove simple negative roots for arbitrary nonnegative \(a,b,c,d\) in this product model. Rank four, where the last row can overlap the first two, follows from the three-row common-interlacer theorem with independent placement weights. Reading paths backwards gives the reflected family with occupied rows in \(\{1,n-2,n-1\}\). [Three-row theorem](rook_jacobi.md)

Write \(B=b+d,\ C=1+a+B,\ L=C+1+b,\ v=3B/4,\ m=n-2\). For a path with \(k\) up-steps put \(K=2k\). First choose its \(K\) nonhorizontal positions and then its Dyck path. If neither of the first two positions is chosen, the upper weight is one. Choosing only the first makes both upper rows available and contributes \(C\). Choosing only the second contributes \(1+b\). When both positions are chosen, the upper weight is \(C\), except when the Dyck path starts \(UD\). In that case the second row becomes unavailable and the weight drops by \(B\). Among Dyck paths this case has proportion
\[
 r_K=\frac{\mathrm{Cat}_{k-1}}{\mathrm{Cat}_k}
    =\frac{K+2}{4(K-1)}
    =\frac14+\frac{3}{4(K-1)}\qquad (k\ge1).
\]
The last row is available precisely when the last position is chosen. Put \(D(y)=(1+y)^{n-3}(1+(1+c)y)\). The resulting coefficient is
\[
 \frac{\gamma_k}{\mathrm{Cat}_k}
 =[y^K]D(y)(1+Ly+Cy^2)-B r_K[y^{K-2}]D(y).                     \tag{3}
\]
The correction term vanishes for \(k=0\). To remove its denominator, expand \(D=(1+y)^{n-2}+cy(1+y)^{n-3}\) and use
\[
 \frac{\binom{n-2}{K-2}}{K-1}=\frac{\binom{n-1}{K-1}}{n-1},
 \qquad
 \frac{\binom{n-3}{K-3}}{K-1}=
 \frac{\binom{n-2}{K-2}}{n-2}
    -\frac{\binom{n-1}{K-1}}{(n-2)(n-1)} .
\]
These identities give a single cubic \(J\), independent of \(k\), with
\(\gamma_k/\mathrm{Cat}_k=[y^K](1+y)^{n-3}J(y)\). Explicitly,
\[
\begin{split}
 J(y)={}&(1+(1+c)y)\bigl(1+Ly+(C-B/4)y^2\bigr)\\
 &-v\!\left[\frac{(1-c/m)y(1+y)^2}{m+1}
                 +\frac{cy^2(1+y)}m\right].
\end{split}
\]
Consider its reversed polynomial \(H(h)=h^3J(-1/h)\). Thus
\[
 H(h)=(h-1-c)(h^2-Lh+C-B/4)
   +v(h-1)\left[\frac{(h-1)(1-c/m)}{m+1}-\frac cm\right].        \tag{4}
\]
When \(c>0\) and \(B>0\), the signs are determined exactly by
\[
\begin{split}
 H(0)&=-(1+c)\bigl(C-B/4-v/(m+1)\bigr)<0,\\
 H(1)&=c(b+B/4)>0,\\
 H(1+c)&=-vc^2(1+c)/(m(m+1))<0 .
\end{split}
\]
Since \(H\) is monic, its three roots \(h_1,h_2,h_3\) are positive. When \(c=0\) or \(B=0\), take nonnegative parameter limits from the strict case. The monic cubic retains positive roots counting multiplicities, because \(H(0)<0\) throughout. Consequently
\[
    \gamma_k=\mathrm{Cat}_k\, e_{2k}(1^{n-3},h_1,h_2,h_3).
\]
Applying polarization with these three positive dilations gives \(n\) simple negative roots exactly as in (2). The cubic depends on the rank, so this argument establishes the simple-root conclusion for the three-row family.
