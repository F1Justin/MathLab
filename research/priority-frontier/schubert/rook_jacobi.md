# Real zeros of Schubert Z-polynomials with restricted Ferrers boards

Let a positive partition have rank (number of rows) \(n\). Its board for the Motzkin formula has row lengths \(\lambda_2-1,\ldots,\lambda_n-1\). Every Schubert \(Z\)-polynomial whose board has at most four nonempty rows has \(n\) simple negative roots, with unbounded rank and widths. This is the condition \(\lambda_6\le1\) if the sixth part exists. An admissible placement has increasing row indices and strictly decreasing column indices. The four-row result permits arbitrary nonnegative column weights, and up to three rows it permits independent nonnegative weights on whole placements. The empty placement has weight one. The actual matroid polynomial corresponds to unit weights. For a single nonempty first board row we also prove Alexandersson's strict interlacing under appending a unit part.

We use Alexandersson's 2026 Motzkin–rook formula as the input theorem. Its source gives the model and a proof sketch, attributes its full treatment to unpublished notes, and independently reports real-rootedness through rank 27 for all boards. [Author's statement and add-a-row question](https://www.symmetricfunctions.com/schubertMatroidZ.htm)

Two results allow the number of nonempty rows to grow. Every fixed rectangle of arbitrary height and width has simple negative roots after sufficiently many unit parts are appended. For a Ferrers board of height \(h\) with at least \(h+256h^2\) full-height columns, rank \(n\ge64h\) suffices, regardless of the upper boundary. More generally, a polynomial of degree at most \(h\) determines the exact eventual number of nonreal zeros of any fixed board whenever it has no zeros on the unit circle.

## Common interlacing for three board rows

Normalize \(x=(1+t)/(1-t)\), so that \(t=(x-1)/(x+1)\). Divide every path polynomial of length \(n\) by \((1-t)^n\). The unrestricted path polynomial becomes
\[
A_n(x)=\frac{P_n^{(1,1)}(x)}{n+1},\qquad A_0=1,\quad A_1=x .
\]
Indeed its original Narayana polynomial has coefficients \(\binom{n+1}{j}\binom{n+1}{j+1}/(n+1)\), and the binomial expansion of Jacobi polynomials gives this normalization. The \(A_n\) have simple zeros in \((-1,1)\), interlace their neighbors, and satisfy
\[
A_n=a_n x A_{n-1}-b_n A_{n-2},\qquad
a_n=\frac{2n+1}{n+2},\quad b_n=\frac{n-1}{n+2}.
\]

For \(J\subseteq[n-1]\), let \(F_{n,J}\) be the normalized polynomial of paths strictly above zero after every step indexed by \(J\). Prescribing height zero at a set of times cuts the path into independent unrestricted paths. Writing \(i_0=0,i_{\ell+1}=n\) gives the exact formula
\[
F_{n,J}=\sum_{I=\{i_1<\cdots<i_\ell\}\subseteq J}
(-1)^\ell\prod_{p=0}^{\ell}A_{i_{p+1}-i_p}.
\]
The normalized Schubert polynomial is \(\sum_J w_J F_{n,J}\), where \(w_J\ge0\) is the total weight of all placements on exactly \(J\) and \(w_\emptyset=1\).

For \(n\ge4\), fix a root \(x\) of \(A_{n-1}\), and put \(z=x^2,\ s=n-4\). At this node the successive ratios \(A_{n-k}/A_n\) for \(k=0,1,2,3\) equal \(1,0,-1/b_n,-a_{n-1}x/(b_nb_{n-1})\). Inserting them into the displayed sum gives
\[
4(n-1)(n-2)\frac{F_{n,J}(x)}{A_n(x)}
       =u_J(z)s^2+v_J(z)s+w_J'(z).
\]

| \(J\) | \(u_J\) | \(v_J\) | \(w_J'\) |
|---|---|---|---|
| \(\emptyset,\{1\}\) | 4 | 20 | 24 |
| \(\{2\}\) | \(5z+3\) | \(40z+12\) | \(60z+12\) |
| \(\{1,2\}\) | \(z+3\) | \(8z+12\) | \(12z+12\) |
| \(\{3\}\) | \(14z^2-6z+4\) | \(133z^2-57z+20\) | \(294z^2-126z+24\) |
| \(\{1,3\}\) | \(4z^2-4z+4\) | \(38z^2-38z+20\) | \(84z^2-84z+24\) |
| \(\{2,3\}\) | \(4z^2+z+3\) | \(38z^2+2z+12\) | \(84z^2-24z+12\) |
| \(\{1,2,3\}\) | \(2z^2-z+3\) | \(19z^2-11z+12\) | \(42z^2-30z+12\) |

Every entry is positive for \(z\ge0\). Each quadratic with a negative linear coefficient has positive leading coefficient and negative discriminant. Hence the sum over placements has the sign of \(A_n\) at each zero of \(A_{n-1}\). At \(x=1,-1\) it has values \(1,(-1)^n\), since all nonempty row conditions require an up-step and its normalized weight factor is \(t/(1-t)^2=(x^2-1)/4\). These \(n+1\) test points have alternating signs. There is one simple zero in each gap, since the degree is at most \(n\). The change of variables maps all of them to negative real numbers. In the original variable the empty-board polynomial of rank \(n-1\) is thus a common strict interlacer for the *complete* weighted board polynomials.

For \(n=2,3\) the original polynomial is \((1+t)^n+\alpha t(1+t)^{n-2}\) with \(\alpha\ge\binom n2>0\). Normalization gives the two nonzero quadratic-factor roots \(\pm\sqrt{\alpha/(4+\alpha)}\), and an additional root zero for \(n=3\). For \(n=3\) the two nodes of \(A_2\) are \(\pm1/\sqrt5\), strictly inside the two outer roots. Rank one is immediate.

## Strict row extension for a one-row board

Write \(c=1+\sum_{u\in B}w(u)\ge1\) for one nonempty board row, allowing an empty row as well. A rook is available exactly when the path is above zero after step one. A path failing this condition starts with a horizontal step of original weight \(1+t\), of normalized weight \(x\). Thus for \(n\ge2\) the normalized whole polynomial is
\[
F_n=cA_n-(c-1)xA_{n-1}=(1+c b_n)xA_{n-1}-c b_n A_{n-2}.
\]
The same formula on the left yields \(F_1=x\). Appending a unit part leaves the board unchanged. We show \(F_n\) strictly interlaces \(F_{n+1}\) for each \(n\ge2\). At every root \(r\) of \(F_n\),
\[
F_{n+1}(r)=\left[\frac{(c-1)(1+c b_{n+1})}{c}\,r^2-c b_{n+1}\right]A_{n-1}(r).
\]
The bracket is strictly negative. For \(c=1\) this follows directly. Otherwise put \(b=b_{n+1}=n/(n+3)\), \(H=(c-1)(1+cb)\). Symmetry pairs the two extreme roots \(r_*,-r_*\) of \(F_n\); \(r_*>0\). Its logarithmic derivative at 1 gives
\[
S=F_n'(1)=\frac{n(n+3)}4+\frac{(c-1)(n-1)}2
=\sum_{\rho:F_n(\rho)=0}\frac1{1-\rho}
\ \ge\ \frac{2}{1-r_*^2}.
\]
Here \(F_n(1)=1\) and \(A_n'(1)=n(n+3)/4\) by Jacobi differentiation. Therefore \(1-r^2\ge2/S\). Direct expansion gives
\[
2H-S[(c-1)-cb]=(2c^2-cn+4c+n^2+n-6)/4>0 .
\]
Indeed \(n^2-cn+2c^2=(n-c/2)^2+7c^2/4\), and \(4c+n-6\ge0\). Since \(H-c^2b=(c-1)-cb\), these inequalities imply \(Hr^2<c^2b\). This proves the required sign.

By the first theorem \(A_{n-1}\) strictly interlaces \(F_n\). Its sign at the largest root of \(F_n\) is positive, so \(F_{n+1}\) is negative there, and alternates on all roots of \(F_n\). The endpoints \(F_{n+1}(1)=1,\ F_{n+1}(-1)=(-1)^{n+1}\) supply both outer intervals. Thus \(F_{n+1}\) strictly interlaces across \(F_n\). For the original negative roots \(r_i\) of \(Z_n\), the row recurrence gives \(Q_{n+1}(r_i)=Z_{n+1}(r_i)/r_i\). These values alternate. As the leading and constant coefficients of each original \(Z\) are one, \(Q_{n+1}=(Z_{n+1}-(1+t)Z_n)/t\) has degree at most \(n-1\). It has exactly one simple root in each interval \((r_i,r_{i+1})\). Rank one to two follows directly from the quadratic above.

## A board family of unbounded height

For \(n=2h+1\ge3\), consider a single board column of height \(h\). Its normalized polynomial is \(A_n+w\sum_{j=1}^h F_{n,\{j\}}\) at any fixed column weight \(w\ge0\). In this family both rank and number of nonempty board rows are unbounded. Time reversal gives \(F_{n,\{j\}}=F_{n,\{n-j\}}\). The sum for the half-height column is therefore half the sum over a full-height column. Set \(y=(x^2-1)/4\); a normalized Motzkin horizontal step has weight \(x\), while a matched up- and down-step has weight \(y\). First return to zero gives
\[
A_{n+2}=x A_{n+1}+y\sum_{j=0}^{n}A_j A_{n-j}.
\]
At any node of \(A_{n-1}\), two uses of the Jacobi recurrence give
\[
\frac{\sum_{j=1}^{n-1}F_{n,\{j\}}}{A_n}
=n+1-4b_{n+2}\frac{1-a_{n+1}x^2}{1-x^2}
\ \ge\ n+1-4b_{n+2}
=\frac{n(n+1)}{n+4}>0.
\]
Here \(F_{n,\{j\}}=A_n-A_jA_{n-j}\), and \(a_{n+1}\ge1\). Hence \(A_{n-1}\) strictly interlaces this half-height family by the same endpoint argument. Equivalently the Ferrers shapes are \((\lambda_1,2^h,1^h)\) with \(\lambda_1\ge2\).

## Boundary polynomials for a fixed board and an explicit mixed-height theorem

Suppose the board is confined to the first \(h\) rows. For \(z=e^{i\phi}\) set \(x=\cos\phi\), \(s=z^2\). The polynomials
\[
D_i(s)=z^i A_i(x)=\mathbb E(1-U+Us)^i,\qquad U\sim{\rm Beta}(3/2,3/2),
\]
have nonnegative coefficients summing to one. Indeed the Gegenbauer generating function factors as \((1-zu)^{-3/2}(1-z^{-1}u)^{-3/2}\). Its coefficient of degree \(i\), normalized at \(x=1\), gives the beta-binomial probabilities \(\binom ia(3/2)_a(3/2)_{i-a}/(3)_i\) at powers \(s^a\). In particular \(|A_i(x)|\le1\).

For each rook-row set \(J\), retain the cuts \(I=\{i_1<\cdots<i_\ell\}\) of the earlier inclusion–exclusion sum and set \(i_0=0\). Its boundary polynomial is
\[
H_J(s)=\sum_{I\subseteq J}(-1)^{|I|}\prod_{q=1}^{|I|} D_{i_q-i_{q-1}}(s).
\]
Write \(H=\sum_J w_J H_J\). These are fixed finite polynomials independent of the tail length. At a root of \(A_{n-1}\), put \(R_i=A_{n-i}/A_n\). Then \(R_0=1,R_1=0\); uniformly on those nodes \(R_i\to \sin((1-i)\phi)/\sin\phi\) for each fixed \(i\). This follows by recurrence because its backward coefficients converge uniformly to those of \(R_{i+1}=2xR_i-R_{i-1}\). For a critical point of \(A_n\) the same recurrence starts with \(R_1=x\) by \((1-x^2)A_n'=n(A_{n-1}-xA_n)\), so the limit is \(\cos(i\phi)\). Consequently \(F_n/A_n\), at the two respective sets of nodes, differs uniformly by \(o(1)\) from
\[
2\operatorname{Re}\frac{H(s)}{1-s},\qquad \operatorname{Re} H(s).
\]
These real boundary expressions extend continuously to \(\phi=0,\pi\) via the finite trigonometric polynomials above. A strictly positive minimum in either test proves simple negative roots for every sufficiently long tail. The first test gives \(A_{n-1}\) as a common interlacer. The second gives \(A_n'\). Both conclusions follow by alternating signs and the endpoint values.

There is a transfer description for all board shapes. Let \(B\) be the birth–death chain on \(a=0,1,\ldots\) with upward probability \((a+2)/(2a+2)\) and downward probability \(a/(2a+2)\), and let \(P_s=(1+s)I/2+(1-s)B/2\). For real \(-1\le s\le1\) this is a lazy nearest-neighbor chain. Its \(j\)-step probability of returning to 0 is \(D_j(s)\). Indeed a returning path with \(2k\) moving steps has moving-chain probability \(2^{-2k}\) by telescoping the factors \((a'+1)/(a+1)\), so its total contribution is
\[
\binom j{2k}\mathrm{Cat}_k
   \left(\frac{1+s}{2}\right)^{j-2k}
   \left(\frac{(1-s)^2}{16}\right)^k.
\]
Summing over \(k\) gives \(D_j(s)\) by the unrestricted Motzkin expansion. The Markov property at all cut times and inclusion–exclusion show that \(H_J(s)\) is the probability, starting at 0, of being positive at every time in \(J\). Summing over placements gives \(H(s)=\mathbb E[W_B(\{j:X_j>0\})]\), where \(W_B\) here counts weighted placements of the original Ferrers board. The transfer evaluates the polynomial for complex \(s\) as well by polynomial identity. A real-variable probability interpretation alone yields no sign control at complex boundary points.

### Winding criterion for every fixed board

Let \(H(s)\) be the complete boundary polynomial above, including the empty placement, for a fixed board with fixed nonnegative weights. Suppose \(H\) has no zero on the unit circle, and let \(q\) be the number of its zeros in the open disk, with multiplicity. For every sufficiently long tail of appended unit parts the corresponding degree-\(n\) polynomial then has **exactly \(n-2q\) simple negative real zeros** and \(2q\) nonreal zeros with multiplicity. In particular a disk zero-free test implies eventual real-rootedness even if neither Jacobi node test has positive real part. The bound on how long a tail suffices may depend on the board and weights.

To prove this write \(x=\cos\phi\) and
\[
U_n(\phi)=A_n(x)+i\sin\phi\, A_n'(x)/n,\qquad 0\le\phi\le\pi .
\]
It never vanishes, since the interior roots of \(A_n\) are simple and its endpoint values are nonzero. Its argument changes by exactly \(n\pi\). Indeed putting \(f(\phi)=A_n(\cos\phi)\) gives \(U_n=f-if'/n\). The real part of \(U_n\) changes sign at the \(n\) simple roots of \(f\). At the first crossing the imaginary part is positive, and its sign alternates at successive crossings. Between crossings the curve is in the open half-plane determined by the sign of \(f\). Starting from \(U_n(0)=1\) and ending at \(U_n(\pi)=(-1)^n\) therefore gives the claimed argument increment.

Set \(B_{n,0}=1,\ B_{n,1}=e^{i\phi}\), and generate \(B_{n,j}\) by the same real backward Jacobi recurrence used for \(R_j\). The derivative identity used above gives the exact representation
\[
 A_{n-j}(\cos\phi)=\operatorname{Re}\big[U_n(\phi)\overline{B_{n,j}(\phi)}\big]
\]
at \(j=0,1\), hence at all fixed \(j\le h<n\). For each such \(j\), \(B_{n,j}\to e^{ij\phi}\) uniformly on the whole interval by induction, since the limiting backward recurrence has coefficients \(2\cos\phi,-1\). Form \(H_n(\phi)\) by replacing each inclusion–exclusion term \(\prod_{p=1}^\ell A_{i_p-i_{p-1}}\, A_{n-i_\ell}\) with \(\prod_{p=1}^\ell A_{i_p-i_{p-1}}\, B_{n,i_\ell}\), retaining its sign and placement weight. Then
\[
 F_n(\cos\phi)=\operatorname{Re}\big[U_n(\phi)\overline{H_n(\phi)}\big],
 \qquad
 \sup_\phi|H_n(\phi)-H(e^{2i\phi})|\longrightarrow0.
\]
At both endpoints \(B_{n,j}=(\cos\phi)^j\) exactly, so \(H_n(0)=H_n(\pi)=1\). For large \(n\), the closed curve \(H_n\) is homotopic in \(\mathbb C\setminus\{0\}\) to \(H(e^{2i\phi})\) by linear interpolation. The latter winds \(q\) times by the argument principle. The angle of \(U_n\overline{H_n}\) therefore changes by \((n-2q)\pi\). Successive levels of the angle that are integral multiples of \(\pi\) give \(n-2q+1\) ordered, alternating-sign test points for \(F_n\), even without monotonicity of that angle. This gives at least \(n-2q\) distinct real roots in \((-1,1)\).

For the complementary count, let \(0<|z|<1\), \(x=(z+z^{-1})/2\). The Gegenbauer coefficient identity gives
\[
 z^m A_m(x)=\binom{m+2}{2}^{-1}
       \sum_{\ell=0}^m c_{m-\ell}c_\ell z^{2\ell},
 \qquad c_a=(3/2)_a/a!.
\]
After division by \(c_m/\binom{m+2}{2}\) the right side tends to \((1-z^2)^{-3/2}\) uniformly on compact subdisks. This follows by dominated convergence of the series since \(c_{m-\ell}/c_m\le1\) and this quotient tends to one at each fixed \(\ell\). Therefore \(A_{n-j}(x)/A_n(x)\to z^j\) for fixed \(j\), locally uniformly off \(z=0\). On this disk the denominator does not vanish, by the roots of \(A_n\). It follows term by term that \(F_n(x)/A_n(x)\to H(z^2)\).

For real \(-1\le s\le1\) the chain formula gives \(H(s)\ge1\). Thus each interior zero of \(H(z^2)\) is nonreal and nonzero. Disjoint small disks around these roots yield at least \(2q\) zeros with multiplicity of the composed \(F_n(x)\), by Rouché. The map \(z\mapsto(z+z^{-1})/2\) is holomorphic and injective on the punctured disk, with nonzero derivative there, and sends nonreal points of this disk to nonreal points. These zeros are consequently distinct from the \(n-2q\) real roots counted above. The degree \(n\) exhausts the count and gives simplicity of all real roots. Since \(H\) is real and has no real zero on the disk, \(q\) is even as required by reciprocity.

**Effective bound in the zero-free case.** Suppose \(H\) has no zero in the closed disk. Put \(m_H=\min_{|s|=1}|H(s)|>0\) and \(C=\sum_J w_J(2^{|J|}-1)\). For every \(n\ge10h\) satisfying \(n-h>9hC/m_H\), all \(n\) roots are simple and negative. For rational weights this reduces the question for *every* tail of a given board with zero-free \(H\) to finitely many exact polynomial tests.

Indeed, write \(u=\sin\phi>0\) and \(V_j=(B_{n,j},(x B_{n,j}-B_{n,j-1})/u)\). By the backward recurrence, evolving from \(j\) to \(j+1\) stretches the second coordinate by \(1+3/(n-j)\), then applies the orthogonal rotation with rows \((x,u)\) and \((-u,x)\). Omitting the stretching gives first coordinate \(e^{ij\phi}\), since \(V_1=(e^{i\phi},i e^{i\phi})\). The exact norm is at most \(\sqrt2\exp(3h/(n-h))<2\sqrt2\) for \(n\ge10h\). Each stretching introduces an error of norm at most \(6\sqrt2/(n-h)\); summing these errors propagated by the comparison rotations gives \(|B_{n,j}-e^{ij\phi}|\le9h/(n-h)\) for \(j\le h\), including the endpoints by continuity. All short factors satisfy \(|A_i(x)|\le1\) by their positive Fourier weights. Summing over all nonempty cuts gives \(\|H_n-H(e^{2i\phi})\|_\infty\le9hC/(n-h)<m_H\). The homotopy in the preceding proof now gives \(n\) real sign changes at this rank.

For completeness, writing \(H(s)=\sum h_i s^i\) gives the computable formula \(m_H^2=\min_{-1\le y\le1}[\sum_i h_i^2+2\sum_{j>0} T_j(y)\sum_i h_i h_{i+j}]\), with \(T_j\) the Chebyshev polynomial. For rational coefficients one may isolate the derivative roots in this interval and include both endpoints. Schur's polynomial recursion on the reversed \(H\) tests strict disk stability, and a Sturm count on \((-1,1)\) of each remaining normalized \(F_n\) tests simple negative real-rootedness.

For the rectangle with four rows, two columns and unit weights, the inclusion–exclusion formula gives
\[
 256H(s)=2535-1268s-590s^2-292s^3-129s^4 .
\]
The constant coefficient exceeds the sum of the remaining absolute coefficients by 256, and \(H(1)=1\). Thus this board has \(m_H=1\) and \(q=0\). Its eight single rooks and six pairs give \(C=26\), and the bound yields simple negative roots at every \(n\ge941\). The verifier independently recovers the boundary polynomial from the Markov chain at five rational parameters.

### Rectangles of arbitrary height and width

For every rectangular board of height \(h\) and width \(w\), all nonconstant coefficients of its complete boundary polynomial \(H_{h,w}(s)\) are nonpositive. In particular \(\operatorname{Re}H_{h,w}(s)\ge H_{h,w}(1)=1\) on the closed disk. For each fixed pair \(h,w\) there exists \(n_0(h,w)\) such that every rank \(n\ge n_0(h,w)\) gives simple negative roots. The corresponding partitions are \((\lambda_1,(w+1)^h,1^{n-h-1})\) with \(\lambda_1\ge w+1\). The matroid statement uses unit weights. The same conclusions hold for individual column weights in \([0,1]\), since independently retaining each column with its weight as probability represents the weighted polynomial as an average of unit-weight rectangular polynomials of varying widths. The effective bound above is uniform in these weights with \(m_H=1\) and \(C\le\sum_{k\ge1}\binom hk\binom wk(2^k-1)\).

Use the boundary chain started at zero and write \(N_0=\#\{1\le i\le h:X_i=0\}\). A path with \(T=h-N_0\) positive times has \(\sum_k\binom Tk\binom wk=\binom{T+w}{w}\) placements. Let \(D(u)=\sum_{j\ge0}D_j(s)u^j\). Marking a subset of the visits to zero, then applying the Markov property at the marked times, gives
\[
 \sum_{h\ge0}u^h\mathbb E_s[v^{N_0}]
 =\frac{1}{(1-u)[1-(v-1)(D(u)-1)]}.
\]
Summing first over the widths with variable \(x\), we obtain
\[
 G=\sum_{w,h\ge0}x^w z^h H_{h,w}(s)
 =\frac{1}{(1-x-z)[1+x(D(z/(1-x))-1)]}.
\]
Here \(D(u)=[1-F(u)]^{-1}\) where the first-return series for the Motzkin chain is
\[
 F(u)=\tfrac12\big[1+(1+s)u/2-\sqrt{(1-u)(1-su)}\big].
\]
Indeed the unrestricted moments satisfy \(D=1+(1+s)uD/2+(1-s)^2u^2D^2/16\) by first return, giving the stated series with \(F(0)=0\). Write \(a=z,\ b=sz,\ A=1-x-a,\ B=1-x-b\) and \(K=\sqrt A+\sqrt B\), choosing the square roots equal to one at the origin. Simplification gives
\[
 G=\frac{K^2}{(1-x)A(K^2+4x)}
  =\frac{1}{(1-x)A}-\frac{4x}{1-x}\,L(x,a,b),\qquad
 L(x,a,b)=\frac{1}{A(K^2+4x)} .
\]

We claim that every coefficient of the Taylor series of \(L\) in the three independent variables \(x,a,b\) is nonnegative. For small real nonnegative parameters let \(A,B>0\). The elementary Laplace and heat-kernel integrals give
\[
 L=\int_0^\infty \frac{\sin(2\sqrt x\,t)}{2\sqrt x}
          \frac{e^{-t\sqrt A}}{A}e^{-t\sqrt B}\,dt,
\quad
 \frac{e^{-t\sqrt A}}{A}=\int_0^\infty e^{-Ar}\operatorname{erfc}\!\big(t/(2\sqrt r)\big)\,dr,
\]
\[
 e^{-t\sqrt B}=\int_0^\infty e^{-Bq}\frac{t}{2\sqrt\pi q^{3/2}}e^{-t^2/(4q)}\,dq,
 \qquad
 \operatorname{erfc}(\sqrt u)=\frac2\pi\int_0^\infty\frac{e^{-(1+y^2)u}}{1+y^2}\,dy .
\]
The last identity follows by differentiation in \(u\) and the value at zero. The two heat-kernel transforms follow from the Gaussian integral (the first also follows by integrating the second). At \(x=0\) use the limit \(t\) for the sine quotient. Integrating in \(t\) first is justified by absolute convergence: bound the sine quotient by \(t\), then the remaining positive integrals reproduce \(A^{-1}\int_0^\infty t e^{-Kt}\,dt\). Set \(c=1/(4q)+(1+y^2)/(4r)\); the differentiated Fourier transform of a Gaussian gives
\[
 \int_0^\infty t e^{-ct^2}\frac{\sin(2\sqrt x\,t)}{2\sqrt x}\,dt
 =\frac{\sqrt\pi}{4c^{3/2}}e^{-x/c}.
\]
Consequently
\[
 L=\int_{r,q,y>0}
 \frac{e^{-r-q}}{4\pi q^{3/2}(1+y^2)c^{3/2}}
 \exp\{ar+bq+x(r+q-1/c)\}\,dr\,dq\,dy .
\]
All three coefficients in the exponent are nonnegative, because
\(1/c\le4qr/(q+r)\le q+r\). Expand the exponential and use monotone convergence for small nonnegative \(x,a,b\). Uniqueness of the convergent Taylor series proves the claim. The first summand of \(G\) is independent of \(b\), so after \(a=z,b=sz\) every positive power of \(s\) in \(G\) has nonpositive coefficients in \(x,z\). Coefficient extraction proves the rectangular theorem. As an independent check, the verifier computes the distribution of positive times by the height chain at six distinct rational values of \(s\), and checks every coefficient of \((1-x)A(K^2+4x)G=K^2\) through \(z^5 x^4\). The degree in \(s\) is at most five in this range, so these checks identify the polynomials exactly.

**Mixed columns.** Suppose there is one board column of height \(h\ge1\) and any number of additional columns of height one. All individual column weights may be arbitrary nonnegative reals. For every \(n>12h^2+h\) the complete polynomial is strictly interlaced by \(A_{n-1}\), uniformly over the weights and the number of columns.

To prove this, let \(v=1-U+Us\). The coefficient of the long-column variable in \(H\) is \(\sum_{j=1}^h(1-D_j)\). Dividing by \(1-s\) gives
\[
\mathbb E\!\left[U\sum_{\ell=0}^{h-1}(h-\ell)v^\ell\right].
\]
The real part of the triangular polynomial is at least \(h/2\) throughout the closed disk. On the boundary this follows from \(\lvert\sum_{\ell=0}^{h-1}v^\ell\rvert^2=h+2\sum_{\ell=1}^{h-1}(h-\ell)\operatorname{Re}v^\ell\), and harmonicity extends the bound to the disk. Thus the first node test for this coefficient is at least \(h/2\) because \(\mathbb E U=1/2\). A short column alone contributes \(1-D_1\) with test value 1. The coefficient for a chosen short–long column pair is summed over row sets \(\{1,j\}\), \(2\le j\le h\). For each,
\[
\frac{H_{\{1,j\}}}{1-s}
=\frac{1-D_1-D_j+D_1D_{j-1}}{1-s}
=\frac12+\mathbb E[(U-1/2)v^{j-1}].
\]
Since \(\mathbb E|U-1/2|\le\sqrt{\operatorname{Var}(U)}=1/4\), the first node test is at least \(1/2\) per such summand. Two short columns cannot both carry rooks.

For the finite-\(n\) error write \(u=\sin\phi>0,\ V_i=(R_i,(xR_i-R_{i-1})/u)\). The exact backward recurrence is
\[
V_{i+1}=
\begin{pmatrix}x&u\\-u&x\end{pmatrix}
\operatorname{diag}\left(1,1+\frac3{n-i}\right)V_i.
\]
The comparison solution \(r_i=\sin((1-i)\phi)/u\) uses the same rotation and omits the diagonal stretching. For \(1\le i\le h\) and \(n\ge10h\), \(\|V_i\|\le 2/u\) since \(\|V_1\|=1/u\) and \(\prod_{\ell=1}^{h-1}(1+3/(n-\ell))\le e^{3h/(n-h)}<2\). Each stretching at step \(\ell\) injects a vertical vector; propagating it by the comparison rotations to step \(j\) contributes at most \(6|\sin((j-\ell)\phi)|/[(n-h)u]\) to the first coordinate. This telescoping difference gives
\[
|R_j-r_j|\le 3 j(j-1)/(n-h).
\]
The error per single marked row is at most \(3h^2/(n-h)\), since \(|A_j|\le1\). The error per pair is at most \(6h^2/(n-h)\), since the only unfixed ratio has coefficient \(-A_j+xA_{j-1}\). Both are strictly below the respective \(1/2\) margins under the theorem's hypothesis. At \(h=1\) the pair coefficient is absent. The empty term has ratio 1. Positive linear combination gives the theorem.

**One column with linearly growing height.** A separate critical-point estimate permits \(h\le n/400000\) for one board column. It works even if each individual one-rook placement has its own nonnegative weight. The constant is chosen for a short uniform bound.

We first record \(1-|A_j(x)|\ge c_0\min(1,j^2 u^2)\) for \(u=\sqrt{1-x^2}\), \(j\ge1\), with \(c_0=1/40000\). For \(j\ge8\), the Fourier weights of \(A_j(\cos\phi)\) at frequencies \(2a-j\) equal \(c_a c_{j-a}/\binom{j+2}{2}\), where \(c_a=(3/2)_a/a!=(2a+1)\binom{2a}{a}/4^a\). The elementary bound \(\binom{2a}{a}/4^a\ge1/(2\sqrt a)\) for \(a\ge1\) follows by induction. On the central consecutive block \(j/4\le a\le3j/4\) each probability is at least \(1/(4j)\); its size \(L\) is at least \(j/3\) and at least four. Thus the law has as a component, of mass at least \(1/12\), the uniform law on these \(L\) frequencies. For its characteristic function \(V\), \(|V|\le1/(Lu)\), so \(|V|\le1/2\) when \(u\ge2/L\). Otherwise take \(0\le\phi\le\pi/2\) by symmetry. Here \(\phi\le\pi/L\). From the average of \(2\sin^2((a-b)\phi)\) over all ordered frequency indices \(a,b\), and restricting their difference in absolute value to \([L/4,L/2]\), we get
\[
1-|V|^2\ge L^2\phi^2/(16\pi^2).
\]
Indeed there are at least \(L/8\) such integer differences and at least \(L\) ordered pairs for each; the sine is at least \(L\phi/(2\pi)\). The triangle inequality for the mixture and \(1-|V|\ge(1-|V|^2)/2\) give the stated \(c_0\). For \(1\le j<8\), the same beta-binomial representation gives \(A_j(x)=\mathbb E(x+i u(2U-1))^j\). Since \(x^2+u^2(2U-1)^2\le1\), concavity of the square root and \(\mathbb E(2U-1)^2=1/4\) imply \(1-|A_j(x)|\ge3u^2/8\), sufficient for these \(j\).

At a critical point of \(A_n\) the comparison solution is \(r_j=\cos(j\phi)\) and \(V_1=(x,-u)\). Write \(M_i=\prod_{\ell=1}^{i-1}(1+3/(n-\ell))\). The rotation formula gives \(\|V_i\|\le M_i\) and \(|(V_i)_2|\le i u M_i\) by induction, hence \(|(V_i)_2|\le M_i\min(1,iu)\). Propagating each vertical stretching through the comparison rotations now gives
\[
 |R_j-\cos(j\phi)|\le\frac{6j}{n-h}\min(1,j^2u^2)
 \qquad(1\le j\le h,\ n\ge10h).
\]
If \(400000h\le n\), then \(6h/(n-h)<c_0\). Therefore \(1-A_j(x)R_j>0\) at every interior critical point. This is exactly the ratio for one marked row at position \(j\). Adding arbitrary nonnegative weights and including the empty placement preserves the signs at all \(n-1\) critical points; the endpoint signs finish the proof. Time reversal also covers a single marked row within \(h\) positions of the far end.

## Arbitrary upper boundaries above a wide last row

Let the board have height \(h\ge1\), with \(q\) full-height columns. The heights and number of its other columns are arbitrary. If
\[
 n\ge64h,\qquad q\ge h+256h^2 ,
\]
then \(A_{n-1}\) strictly interlaces the whole polynomial. Consequently every zero of its Schubert \(Z\)-polynomial is simple and negative. The statement allows arbitrary nonnegative weights on the shorter columns and unit weight on the full-height columns. It applies uniformly to shapes with a growing number of corners.

We first show that the full row set \([h]\) alone has a uniform positive margin at the zeros of \(A_{n-1}\). The boundary chain must move up at its first step, of weight \((1-s)/2\). After that it starts at height one and is killed on reaching zero. For the underlying nonlazy chain the probability of surviving \(m\) steps from one equals \((1+S_m)/2\), where \(S_m\) is the probability that a simple symmetric walk starting at one avoids zero up to time \(m\). Indeed each surviving trajectory ending at \(a\) has ordinary walk probability multiplied by \((a+1)/2\). The killed walk's endpoint has expectation one by the stopped martingale, including the value zero on killed paths. The usual reflection count gives \(S_m=2^{-m}\binom m{\lfloor m/2\rfloor}\). These numbers are the moments of the measure \((1+y)\,dy/(\pi\sqrt{1-y^2})\) on \([-1,1]\), by the arcsine even moments, for even and odd indices separately. Adding the holds of \(P_s\), then using polynomial identity, gives
\[
 \frac{2H_{[h]}(s)}{1-s}
 =\frac{1+\mathbb E(1-U+Us)^{h-1}}2,
 \qquad U\sim {\rm Beta}(1/2,3/2).
\]
The beta-binomial coefficients \(p_i\) of this expectation decrease with \(i\): at degree \(m=h-1\) their ratio is \((m-i)(i+1/2)/[(m-i+1/2)(i+1)]\). Every decreasing probability mass function on \(0,\ldots,m\) is a mixture of uniforms on \(0,\ldots,k\), with weights \((k+1)(p_k-p_{k+1})\). Each uniform generating polynomial has real part at least \(-1/2\) on the unit circle. To see this take the angle \(0\le\theta\le\pi\) by symmetry and use \(2\sum_{j=0}^k\cos(j\theta)=1+\sin((k+1/2)\theta)/\sin(\theta/2)\). If the numerator sine is negative then \(\theta\ge\pi/(k+1/2)\), hence \(\sin(\theta/2)\ge\theta/\pi\ge1/(k+1/2)\); the other angles give a nonnegative sum. The limiting node ratio therefore has real part at least \(1/4\).

Write \(u=\sin\phi\) at a node and \(f_1=x,\ f_d=-(u^2/4)A_{d-2}\) for \(d\ge2\), the normalized first-return weights. Exact first return gives
\[
 F_{n,[h]}=A_n-\sum_{j=1}^h f_j A_{n-j}.
\]
From the rotation formula for mixed columns,
\[
 R_j-r_j=\sum_{1\le l<j}\tau_l\sin((j-l)\phi),\qquad
 |\tau_l|\le6/[(n-h)u].
\]
In fact \(\tau_l\) is the vertical component of the stretched-vector error at step \(l\). For every integer \(p\) and every nonempty block \(v\le m\le w\) of nonnegative integers one has
\[
 \left|\sum_{m=v}^w A_m(\cos\phi)\sin((m+p)\phi)\right|
 \le\left|\sum_{m=v}^w D_m(s)\right|
 \le\frac{2\mathbb E[1/U]}{|1-s|}=\frac4u ,
 \qquad U\sim {\rm Beta}(3/2,3/2).
\]
The first inequality takes the imaginary part after multiplication by \(e^{ip\phi}\), and the second sums a geometric progression under the beta integral. Thus for any \(i<h\), the error in \(\sum_{j=i+2}^h f_{j-i}R_j\) from replacing \(R_j\) by \(r_j\) is at most \(6h/(n-h)\): each \(\tau_l\) sees a contiguous block of sines with coefficient \(-u^2A_{j-i-2}/4\). Since \(R_1=r_1=0\), the full-row node ratio differs from its limit by at most \(6h/(n-h)<1/8\). This gives \(F_{n,[h]}/A_n>1/8\) at every node.

For a row set missing \(d\ge1\) of the first \(h\) times, split by the *actual* set of returns to zero up to step \(h\). It is one of at most \(2^d\) subsets of the missing times. For each subset the initial weight is a product of \(f_j\)'s, of absolute value at most one. After its last return at \(i\) (or \(i=0\)), the remaining factor divided by \(A_n\) is \(R_i-\sum_{j=i+1}^h f_{j-i}R_j\). For \(i<h\) its comparison value has absolute value at most two: the first two terms are \(r_i-xr_{i+1}=\cos(i\phi)\), and the remaining sine block has modulus at most \((u^2/4)(1/u)(4/u)=1\). In the first pair the finite-rank error is at most \(6h/(n-h)\), since \(\sin(m\phi)-x\sin((m+1)\phi)=-u\cos((m+1)\phi)\), also covering the newly injected term at \(l=i\). The rest costs another \(6h/(n-h)\) as above. The full ratio from this return subset thus has modulus less than three.

For \(i=h\), if any return gap has length at least two, its factor has modulus at most \(u^2/4\), whereas \(|R_h|\le2/u\) from the rotation norm. The only remaining possibility consists of all consecutive unit returns up to \(h\), so \(d=h\). Its contribution is at most \(2h\le2^d\) by \(|R_h-r_h|\le3h(h-1)/(n-h)\). Altogether every row set missing \(d\) times has absolute node ratio at most \(4\cdot2^d\).

Finally fix a selection of \(t\) shorter columns that can carry rooks. In their required order they can be placed in the first \(t\) rows, by moving them up from any admissible placement. All full-height columns are to their left. Thus the number of full-row placements with these short columns is \(\binom q{h-t}\). For placements missing \(d\) rows, first specify these rows, then choose \(h-t-d\) full-height columns; the row-to-column matching is forced, and might be inadmissible. Relative to the full-row count this gives at most \(\binom hd [h/(q-h+1)]^d\). The fixed short-column weight cancels on both sides. The absolute contribution of all incomplete summands, relative to the total full-row weight, is therefore at most
\[
 4\Big[\exp\!\big(2h^2/(q-h+1)\big)-1\Big]\le1/16.
\]
Here \(e^v-1\le2v\) for the indicated small exponent. The full-row term has margin greater than \(1/8\), so the complete board has strictly alternating node signs. The endpoints give the two outer intervals as before.

For unit-weight rectangles the long-tail rank threshold can therefore be chosen independently of the width. Fix \(h\) and let \(w_0=h+256h^2\). Widths \(w\ge w_0\) are covered here at rank \(64h\). For smaller widths the rectangular boundary theorem gives \(m_H=1\) and \(C\le2^h\binom{h+w_0}{h}\) by Vandermonde's identity. Thus \(n\ge64h+9h\,2^h\binom{h+w_0}{h}\) suffices simultaneously for all widths.

## A bound for every board with a long empty tail

If the board is supported on rows \(1,\ldots,h\) and \(n>2h\), the matroid polynomial has at least \(n-2h\) distinct negative real zeros, each of odd multiplicity. In particular at most \(2h\) zeros counted with multiplicity can be nonreal. For a sequence with \(h=o(n)\) this forces an asymptotic proportion one of the zeros onto the negative real axis.

Every term in inclusion–exclusion has the form \(U_i(x)A_{n-i}(x)\), where its last cut \(i\) satisfies \(0\le i\le h\) and \(\deg U_i\le i\). For \(\deg q<n-2h\) one has \(\deg(q U_i)<n-i\). Jacobi orthogonality therefore gives
\[
\int_{-1}^1 (1-x^2)q(x)F_n(x)\,dx=0
\]
for the complete normalized polynomial \(F_n\). If it had fewer than \(n-2h\) sign changes inside the interval, the product of the corresponding linear factors would furnish a \(q\) of the permitted degree for which the integrand has one sign and is not identically zero. This contradiction proves the assertion.

The nonreal bound improves to \(4\lfloor h/2\rfloor\). Indeed the original \(Z\) is reciprocal, and gamma-positivity with constant gamma coefficient one excludes unit-circle zeros other than \(-1\): on the unit circle away from \(-1\) the argument \(t/(1+t)^2\) of its gamma polynomial is strictly positive. Each nonreal root therefore occurs in a quartet \(t,\bar t,1/t,1/\bar t\) of distinct complex numbers with equal multiplicities.

## Boundary of the common-interlacer argument

Already at rank five, the separated individual row condition \(J=\{1,4\}\) gives \(F_{5,J}=A_5-2xA_4+x^2 A_3\). At a zero of \(A_4\) its ratio to \(A_5\) is \(1-7x^2/4\). The outer node has \(x^2=(7+2\sqrt7)/21>4/7\) from \(8A_4=21x^4-14x^2+1\), so the common sign changes. This concerns one specified rook-row set. The full Schubert polynomial also counts other placements forced by its Ferrers shape. Their coupling matters to a proof for arbitrary boards.

For a general board the correct grouped coefficients can be kept without enumerating its widths. Select \(k\) columns from right to left and write their heights \(h_1\le\cdots\le h_k\). The coefficient of the selected square-free monomial in the column weights is exactly
\[
K_{\mathbf h}(x)=\sum_{1\le j_1<\cdots<j_k<n,\ j_i\le h_i} F_{n,\{j_1,\ldots,j_k\}}(x).
\]
This follows by putting the selected rooks in increasing rows. At any node of \(A_{n-1}\) the condition that *every* nonnegative choice of column weights preserves the sign of \(A_n\) is equivalent to \(K_{\mathbf h}/A_n\ge0\) for all selections. Nonnegative coefficients suffice because the constant coefficient is one after division by \(A_n\). Necessity follows by setting unselected weights to zero and all selected weights to \(u\), then letting \(u\) tend to infinity. The general positivity of these sums at the Jacobi nodes is open in this note.

## Four nonempty Ferrers rows at every rank

For every board of height at most four and arbitrary nonnegative column weights, \(A_{n-1}\) strictly interlaces the complete normalized polynomial. In particular this proves simple negative real-rootedness for the four-by-two rectangle above at *all* permissible ranks. For height at most three, the first theorem applies. For height four we necessarily have \(n\ge5\).

There are only 41 possible nonzero groups \(K_{\mathbf h}\) to check in the column expansion just given. With \(k=1,2,3,4\), their numbers are \(4,9,14,14\) respectively, since \(1\le h_1\le\cdots\le h_k\le4\) and \(h_i\ge i\). At a node of \(A_{n-1}\) use \(R_0=1,R_1=0\) and
\[
 R_j=\frac{(2d+1)xR_{j-1}-(d+2)R_{j-2}}{d-1},\qquad d=n-j+2.
\]
For each group form the polynomial \(16(n-1)(n-2)(n-3) K_{\mathbf h}/A_n\) by the inclusion–exclusion formula, substituting \(R_{\max I}\) for the last ratio. Its degrees in \(m=n-5\) and \(y=x^2\) are each at most three. For each coefficient of \(m^i\), express its restriction to each half of the interval \(0\le y\le1\) in the degree-three Bernstein basis on that half. The exact minima over the 41 groups, both halves and all four Bernstein coefficients are
\[
\begin{array}{c|cccc} i&0&1&2&3\\\hline
 \min&41&150&319/4&11.\end{array}
\]
The computation uses only rational operations: for \(p(y)\) the coefficient of \(m^i\), write \(p((e+u)/2)=\sum_{t=0}^3 b_tu^t\) for \(e=0,1\). Its Bernstein coefficient of index \(l\) is \(\sum_{t=0}^l b_t\binom lt/\binom3t\). The function `four_row_certificate` in the companion verifier implements the formulas in this paragraph and regenerates the four minima. Positive Bernstein coefficients give strict positivity on the full interval, and \(m\ge0\). The node signs and endpoints therefore yield all \(n\) roots by the same argument as at height three.

The companion verify_rook_jacobi.py reconstructs the sign certificates symbolically and independently computes sample Schubert polynomials from both the lattice of flats and direct enumeration of paths and placements.
