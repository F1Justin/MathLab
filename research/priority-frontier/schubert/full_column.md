# Adjoining a tall column to a Schubert board at every admissible rank

For a fixed Ferrers board whose boundary polynomial has no unit-circle zeros, adjoining one sufficiently tall column preserves the predicted number of nonreal zeros at **every admissible finite rank**. The height threshold depends only on the old board and its weights. The [uniform theorem](#a-single-height-threshold-works-for-every-admissible-rank) includes weighted columns. A [separate finite calculation](#a-full-hook-at-every-rank) handles all hooks with no height threshold.

Fix a Ferrers board \(B\) of height at most \(h\), with fixed nonnegative column weights and empty placement of weight one. For each rank \(n>h\), keep its rows in positions \(1,\ldots,h\) and place one new column to their left, of height \(n-1\) and weight \(w_n\ge0\). This gives a board of height \(n-1\) when the new column is included, irrespective of the original height. Let \(H\) be the boundary polynomial of \(B\) defined in [the fixed-board proof](rook_jacobi.md#winding-criterion-for-every-fixed-board). We use the Motzkin–rook model and Jacobi normalization of that proof. All-one weights recover actual Schubert \(Z\)-polynomials. [Alexandersson's model](https://www.symmetricfunctions.com/schubertMatroidZ.htm)

**Theorem.** If \(H\) has no zero on \(|s|=1\) and has \(q\) zeros in \(|s|<1\), counted with multiplicity, then for all sufficiently large \(n\) the new polynomial has exactly \(n-2q\) simple negative real zeros and \(2q\) nonreal zeros counted with multiplicity. The threshold depends only on \(B\) and its weights. If \(\Re H>0\) on the circle, \(A_n'\) is a common strict interlacer in the normalized variable. In particular, this applies to every fixed rectangular top board of arbitrary dimensions with unit weights. Its full-height enlargement has bottom width one and no empty board rows.

### Summing over the position of the new rook

Write \(F_{n,J}\) for the normalized Motzkin polynomial requiring positive height at the times in \(J\), \(A_n=F_{n,\varnothing}\), and \(y=(x^2-1)/4\). Put \(k=\max(J\cup\{0\})\). As columns must strictly decrease, a rook in the new leftmost column must be placed in a row \(j>k\). Cutting at its forbidden height zero gives
\[
 S_{n,J}=\sum_{j=k+1}^{n-1}F_{n,J\cup\{j\}}
 =(n-1-k)F_{n,J}-\sum_{j=k+1}^{n-1}F_{j,J}A_{n-j}.                 \tag{1}
\]
For each \(I=\{i_1<\cdots<i_p\}\subseteq J\), set \(i_0=0,\ \ell=i_p\) (zero for the empty set) and \(d_I=(-1)^p\prod_{a=1}^p A_{i_a-i_{a-1}}\). Then \(F_{j,J}=\sum_I d_I A_{j-\ell}\) for \(j>k\). With \(C_m=\sum_{b=0}^m A_bA_{m-b}\), (1) becomes
\[
 S_{n,J}= (n-k)F_{n,J}
 +\sum_{I\subseteq J}d_I\left(\sum_{b=0}^{k-\ell}A_b A_{n-\ell-b}-C_{n-\ell}\right).
                                                               \tag{2}
\]
The first-return identity of unrestricted Motzkin paths gives \(y C_m=A_{m+2}-xA_{m+1}\). Thus \(S_{n,J}-nF_{n,J}\) is a fixed finite combination of shifts \(A_{n-l}\) and convolutions \(C_{n-l}\), with polynomial coefficients independent of \(n\). The enlarged polynomial equals \(\widetilde F_n=\sum_J w_J(F_{n,J}+w_n S_{n,J})\), where \(w_J\) counts the original weighted placements.

### The extrema and the winding count

Use \(x=\cos\phi,\ z=e^{i\phi}\). Put \(U_n=A_n+i\sin\phi A'_n/n\) and use the fixed-board amplitudes \(B_{n,l}\) satisfying
\[
 A_{n-l}=\Re(U_n\overline{B_{n,l}}),\qquad B_{n,0}=1,\quad B_{n,1}=z .
\]
The Jacobi recurrence defines all the finitely many required indices, including \(-1,-2\), and \(B_{n,l}\to z^l\) uniformly for each of them. If \(R_{n,l}=\Re B_{n,l}\), these are polynomials in \(x\) of bounded degree and bounded coefficients for fixed \(l\), since \(R_{n,0}=1,\ R_{n,1}=x\). Moreover \(R_{n,l}(\pm1)=(\pm1)^l\), since the Jacobi coefficients satisfy \(a_m-b_m=1\). The amplitude for \(C_{n-l}\) in the open interval is
\[
 D_{n,l}=\frac{B_{n,l-2}-x B_{n,l-1}}{y}.
\]
Its real part extends to a polynomial bounded uniformly on the closed interval: its numerator polynomial vanishes at both endpoints and division by the fixed quadratic preserves boundedness of the coefficients. Both parts of \(D_{n,l}\) are bounded uniformly on each compact subinterval of \(0<\phi<\pi\).

Let \(T_n\) be the amplitude representing \(\widetilde F_n/(1+n w_n)\) on the open interval by \(\Re(U_n\overline{T_n})\). By (2), this equals the fixed-board amplitude plus the amplitude representing
\(\sum_J w_J(S_{n,J}-n F_{n,J})\) times \(w_n/(1+nw_n)\le1/n\). It follows that
\[
 \Re T_n\longrightarrow\Re H(z^2)\quad\text{uniformly through the endpoints},
 \qquad
 T_n\longrightarrow H(z^2)\quad\text{uniformly on compact interior intervals}.
\]
If \(\Re H>0\), at all \(n-1\) critical points of \(A_n\) the real ratio
\(\widetilde F_n/[(1+nw_n)A_n]=\Re T_n\) is therefore positive. The endpoint values of \(\widetilde F_n\) are \(1,(-1)^n\), proving strict interlacing there.

In general \(H(1)=1\). Choose a small endpoint neighborhood at each end on which \(\Re H(z^2)>1/2\). Take \(0\le\chi\le1\) continuous, zero near each endpoint and one outside the two neighborhoods. The amplitude \(V_n=\Re T_n+i\chi\Im T_n\), extended by its real part at the endpoints, is nonvanishing for large \(n\). On the two endpoint neighborhoods its real part is positive, and elsewhere it is uniformly close to \(H(z^2)\). The straight-line homotopy to \(H(z^2)\) avoids zero by the same two bounds. Its endpoints stay on the positive real axis, so its total change of argument is \(2\pi q\). The change for \(U_n\) is \(n\pi\) by the Jacobi zero count. Consequently \(\arg(U_n\overline V_n)\) attains successively all integer multiples from \(0\) to \((n-2q)\pi\). At each interior such level \(U_n/V_n\) is real and
\[
 \Re(V_n\overline{T_n})=(\Re T_n)^2+\chi(\Im T_n)^2>0 .
\]
The sign of \(\widetilde F_n\) is thus the prescribed alternating sign. At the two endpoints its actual signs are \(+,(-1)^n\) as required. This supplies \(n-2q\) distinct real roots in \((-1,1)\).

For the complementary count, on compact subsets of \(0<|z|<1\) take \(x=(z+z^{-1})/2\). The fixed-board Jacobi ratio \(A_{n-l}/A_n\to z^l\) also holds for the two negative shifts, by inversion of the positive-shift ratios. Here \(y\ne0\) so \(C_{n-l}/A_n\) is bounded. Equation (2) gives \(\widetilde F_n/[(1+n w_n) A_n]\to H(z^2)\) locally uniformly. The same Rouché argument as in the fixed-board proof gives \(2q\) nonreal zeros, exhausting the degree and proving simplicity of the real ones. All bounds are uniform in \(w_n\).

### Columns missing a sublinear number of bottom rows

The theorem still holds if the new column has height \(b_n=n-1-L_n\), where \(L_n=o(n)\). Its position on the left is valid for large \(n\), since \(B\) is fixed. The difference from (1) omits \(L_n\) terms \(F_{n,J}-F_{j,J}A_{n-j}\), with \(j>b_n\). Each has a uniformly bounded amplitude on the real interval. Indeed the shifts used for \(F_{j,J}\) have indices \(l=n-j+\ell\le L_n+h\). The rotation-and-stretch bound in the [fixed-board proof](rook_jacobi.md#winding-criterion-for-every-fixed-board) gives \(|B_{n,l}|\le \sqrt2\exp(3l/(n-l))=O(1)\), and \(|A_{n-j}|\le1\). Thus after normalization the additional error is \(O_B(L_n/n)=o(1)\) even before cutting off the imaginary part.

On a compact subannulus of \(0<|z|<1\), the same terms divided by \(A_n\) are uniformly bounded. In fact the Gegenbauer series from the fixed-board proof gives \(A_m((z+z^{-1})/2)=z^{-m}(m+1)^{-3/2} E_m(z)\), where the \(E_m\) are uniformly bounded on compact subdisks and bounded away from zero there for large \(m\). The ratio of powers of \(m+1\) for \(A_{j-\ell}/A_n\) is bounded because \(j/n\to1\) uniformly, and the factor \(z^{n-j+\ell}\) cancels the possible growth \(z^{-(n-j)}\) of \(A_{n-j}\). The same interior Rouché count follows. For a prescribed sequence \(L_n=o(n)\), the threshold may depend on that sequence.

### A full hook at every rank

For every \(n\ge2\), take one column of height \(n-1\) and any number of columns of height one to its right. Every nonnegative assignment of column weights has \(A_{n-1}\) as a common strict interlacer. In particular for every positive integer \(r\) the actual finite board \((r,1,\ldots,1)\) has \(n\) simple negative \(Z\)-zeros. This all-rank statement uses neither a tail nor a width threshold.

Let \(G_n=\sum_{j=1}^{n-1}F_{n,\{j\}}=(n+1)A_n-C_n\). If \(w\) is the weight of the tall column and \(c\) the total weight of the short columns, the polynomial is
\[
 A_n+wG_n+cF_{n,\{1\}}+cw L_n,\qquad
 L_n=\sum_{j=2}^{n-1}F_{n,\{1,j\}}=G_n-xG_{n-1}-F_{n,\{1\}} .
\]
The equality follows by deleting an initial horizontal step when time one fails the positive-height condition. At a zero \(x\) of \(A_{n-1}\), \(F_{n,\{1\}}/A_n=1\). With \(v=1-x^2\), \(a_j=(2j+1)/(j+2)\), \(b_j=(j-1)/(j+2)\), one has
\[
 \frac{C_n}{A_n}=\frac{4b_{n+2}(1-a_{n+1}x^2)}{v}\le4b_{n+2},
 \qquad \frac{C_{n-1}}{A_n}=-\frac{4b_{n+1}x}{v}.
\]
Therefore \(G_n/A_n\ge n+1-4b_{n+2}>0\). Substitution gives
\[
 \frac{L_n}{A_n}=
 \frac{(n-1)(n^2+4n+12)v-12n}{(n+3)(n+4)v}.                  \tag{3}
\]
For \(n=2\), \(L_n=0\). For \(n\ge3\), the Jacobi endpoint derivatives for \(m=n-1\) give
\(a=A_m'(1)/A_m(1)=m(m+3)/4\) and \(b=A_m''(1)/A_m(1)=m(m-1)(m+3)(m+4)/24\).
From the logarithmic derivative and symmetry of the roots \(r\),
\[
 \sum_{A_m(r)=0}\frac{1}{(1-r^2)^2}=\tfrac12(a^2-b+a).
\]
The extreme roots are distinct and opposite. Hence at every root
\[
 v^{-2}\le \tfrac14(a^2-b+a)=\frac{(n-1)(n+2)(n^2+n+18)}{192}.
\]
This makes (3) strictly positive. Indeed the difference between \([(n-1)(n^2+4n+12)]^2\) and \((12n)^2\) times the last bound equals
\((n-1)(n+4)(n^4+15n^3+8n^2+84n-144)/4>0\).
All four summands therefore give the sign of \(A_n\) at its preceding Jacobi nodes whenever their coefficients are positive. The empty placement gives the endpoint values, closing the alternating-sign count.

### Columns occupying any fixed positive proportion of the rank

In fact the theorem applies with the new column of any height \(b=b_n\) satisfying \(\delta n\le b\le n-1\), for each fixed \(\delta>0\). The threshold is uniform over these heights and the new weight. In particular an arbitrary fixed board with zero-free boundary polynomial can be enlarged by a column reaching any prescribed positive fraction of the rank. If \(\Re H>0\) on the circle, the enlarged family still has the common strict interlacer \(A_n'\).

We first prove the required endpoint inequality. Put
\[
 f(t)=\frac{2J_1(t)}t=\frac2\pi\int_{-1}^1 e^{itu}\sqrt{1-u^2}\,du,\qquad f(0)=1 .
\]
If \(c>0\) satisfies \(f'(c)=0\), then
\[
 f(t)f(c-t)/f(c)<1\qquad(0<t<c).                              \tag{4}
\]
It suffices to take \(t\le c/2\). The differential equation is \(f''+3f'/t+f=0\); in particular \(f(c)\ne0\). The function \(g=t^{3/2}f(t)\) satisfies \(g''+Q(t)g=0\), with \(Q(t)=1-3/(4t^2)\). The unwrapped phase of \(g'+ig\) starts at zero and has derivative
\((g'^2+Qg^2)/(g'^2+g^2)\le1\). At every zero of \(g\) it crosses the corresponding multiple of \(\pi\) in the increasing direction. The first positive zero \(a\) therefore exceeds \(\pi\), and successive zeros are more than \(\pi\) apart. The alternating series \(f(t)=\sum_{k\ge0}(-t^2/4)^k/[k!(k+1)!]\) gives \(0.078<f(7/2)<0.082\), \(-0.264<f'(7/2)<-0.253\), and \(f(4)<0\) (bounds between the degree-four and degree-five partial sums in \(t^2\) suffice). Thus \(7/2<a<4\).

On each lobe between consecutive zeros, \(t^3 f'\) is strictly monotone since its derivative is \(-t^3 f\). In the first lobe \(f\) decreases from one. Each positive critical point \(c\) therefore lies in a later lobe and gives the maximum of \(|f|\) on that lobe. If \(c\) lies after two consecutive zeros \(a_{k-1},a_k\), its phase at \(c\) exceeds its phase at \(a_k\) by \(\arctan(2c/3)\), since \(g'(c)/g(c)=3/(2c)\). Hence \(c-a_{k-1}>\pi+\arctan(2c/3)>4\), using \(c>7/2\). For \(0<t<a\), \(c-t\) is in the same lobe as \(c\) or the immediately preceding one, because \(t<4\). In the latter lobe their signs differ, and in the former \(|f(c-t)|\le|f(c)|\). As \(0<f(t)<1\), either case proves (4). At \(t=a\) the product is zero.

For \(a<t\le c/2\), the decreasing energy \(f^2+(f')^2\) and the rational bounds at \(7/2\) give \(|f(t)|<0.28\). The energy \(g'^2+Qg^2\) is increasing since its derivative is \(Q'g^2\ge0\). Thus with \(v=c-t\ge7/2\), \(c\ge7\),
\[
 \left|\frac{f(v)}{f(c)}\right|
 \le (c/v)^{3/2}\sqrt{\frac{1+3/(2c^2)}{1-3/(4v^2)}}<3.1 .
\]
This proves (4) on the remaining range.

For the rank argument write \(P_n=\sum_J w_J F_{n,J}\) for the original board, and let \(S_n\) count the enlarged placements using the new column, with its weight removed. By cutting at each forbidden visit to zero and setting \(k=\max(J\cup\{0\})\),
\[
 S_n=\sum_J w_J\left[(b-k) F_{n,J}-\sum_{j=k+1}^b F_{j,J} A_{n-j}\right]. \tag{5}
\]
Its normalized amplitude after division by \(b\) converges to \(H(e^{2i\phi})\) uniformly on each compact subinterval of \(0<\phi<\pi\). To see this, each product \(A_{j-\ell}A_{n-j}\) in the convolution is represented by \(A_{j-\ell}B_{n,j}\) for \(j\le n/2\), and by \(A_{n-j} B_{n,n-j+\ell}\) for \(j>n/2\). All these \(B\)'s are bounded uniformly by the rotation-and-stretch estimate. The Gegenbauer integral \(A_m(\cos\phi)=\int (\cos\phi+iv\sin\phi)^m(2/\pi)\sqrt{1-v^2}\,dv\) gives
\[
 |A_m(\cos\phi)|\le\min\{1,\,4/[\pi(m+1)\sin\phi]\}
\]
by one integration by parts. In particular, whenever \(n\sin\phi\to\infty\), the sum of the absolute values of the convolution amplitudes is \(o(n)\), uniformly in \(b\). Indeed, dividing by \(n\), the sum up to the midpoint of \(\min(1,C/[(j+1)\sin\phi])\) is \(O((1+\log(1+n\sin\phi))/(n\sin\phi))\); a bounded shift \(\ell\) only changes the constant. Since \(b\ge\delta n\), the first sum in (5) gives the claimed limit even along such sequences approaching an endpoint.

It remains to control the signs at the Jacobi extrema near \(\phi=0,\pi\). By symmetry use the first endpoint. When \(n\sin\phi\to\infty\) this follows from the previous bound and \(\Re H(1)=1\). For the other case take a subsequence of interior extrema \(\phi_n\to0\) on which \(n\phi_n\to c<\infty\) and \(b/n\to\beta\in[\delta,1]\). The positive cosine expansion of \(A_n(\cos\phi)\) has only frequencies at most \(n\) and includes frequency \(n\), so there is no positive critical angle in \((0,\pi/n)\). Thus \(c\ge\pi\). The same integral gives \(A_m(\cos\phi_n)-f(cm/n)\to0\) uniformly for \(0\le m\le n\), by expanding the logarithm of its integrand through its linear term. Differentiating the integral after the scaling \(\phi=v/n\) also gives convergence of the scaled first derivatives at \(m=n\). Hence \(f'(c)=0\) and \(A_n(\cos\phi_n)\to f(c)\ne0\).

In \(F_{j,J}=\sum_{I\subseteq J}d_I A_{j-\ell}\) the short factors tend to one and changing \(j\) by a fixed \(\ell\) changes its limiting \(f(cj/n)\) by \(o(1)\) uniformly for \(k<j\le n\). The alternating sum vanishes for every nonempty \(J\). Consequently \(P_n/A_n\to1\) at these extrema, and only \(J=\varnothing\) contributes to the limit in (5):
\[
 \frac{S_n}{b A_n}\longrightarrow
 1-\frac1\beta\int_0^\beta\frac{f(ct)f(c(1-t))}{f(c)}\,dt>0
\]
by (4). Every sequence of near-endpoint extrema has such a subsequence or one with \(n\sin\phi\to\infty\). Therefore for large \(n\) the extrema sufficiently close to the endpoints have the correct alternating signs both for \(P_n\) and \(S_n\), uniformly over the allowed heights. On any compact interior neighborhood where \(\Re H>0\) the same conclusion follows from the amplitude limit. If \(\Re H>0\) throughout the circle, this proves the common-interlacer assertion directly.

For arbitrary nonvanishing \(H\), choose a fixed small angle \(\eta>0\) so \(\Re H>0\) for \(0\le\phi\le2\eta\) and \(\pi-2\eta\le\phi\le\pi\). Take a Jacobi extremum in \([\eta,2\eta]\) at the left and one in \([\pi-2\eta,\pi-\eta]\) at the right. These exist for large \(n\), for example by the Jacobi zero asymptotics on compact interior intervals (equivalently, by Sturm comparison after transforming the Jacobi differential equation). Use all extrema outside these two selected nodes and the actual endpoints as sign tests. On the interval between the selected nodes, both \(P_n\) and \(S_n/b\) have complex amplitudes tending uniformly to \(H\), so the same holds for their convex combination \((P_n+w_n S_n)/(1+bw_n)\). Cut off its imaginary part at these two nodes, keeping the cutoff supported in the positive-real-part neighborhoods as above. The truncated curve starts and ends on the positive real axis and has argument change \(2\pi q\), by homotopy and the fact that the omitted arcs of \(H\) stay in the right half-plane. The unwrapped \(U_n\)-phase takes successive integer multiples of \(\pi\) at successive extrema, including the actual endpoints. Indeed there is one simple Jacobi zero between each consecutive two and the intervening half-planes give that increment. Thus the interior phase test and the two end lists give \(n-2q\) real sign changes in all.

Finally, on compact subannuli in \(0<|z|<1\) the Gegenbauer bound gives
\[
 |A_{j-\ell} A_{n-j}/A_n|\le C_B(1+\min(j,n-j))^{-3/2},\qquad k<j\le b .
\]
The sum is \(O_B(1)\), so (5) also gives local uniform convergence \((P_n+w_n S_n)/[(1+bw_n) A_n]\to H(z^2)\). The \(2q\) remaining zeros follow as before.

### A single height threshold works for every admissible rank

**Uniform extension theorem.** For every fixed top board \(B\) with no zero of \(H\) on the circle and \(q\) zeros inside, there exists a finite \(b_0(B)\) with the following property. Adjoin one leftmost column of any height \(b\ge b_0(B)\). At **every** rank \(n\ge b+1\), and for every choice of weight \(w\ge0\) of that column, the enlarged board has exactly \(n-2q\) simple negative real \(Z\)-zeros and \(2q\) nonreal zeros with multiplicity. If \(\Re H>0\) on the circle, the common interlacer is \(A_n'\) in the normalized variable. In particular one can enlarge a fixed rectangular board this way in every admissible rank.

Otherwise there would be a sequence of counterexamples with \(b\to\infty\). Passing to a subsequence, we may assume \(b/n\to\beta\in[0,1]\). The preceding section covers \(\beta>0\). Suppose \(\beta=0\). On compact interior angle intervals the convolution amplitudes in (5) are now bounded by \(O_B(1+\log b)\), since \(j\le b=o(n)\) and the small factor \(A_{j-\ell}\) is paired with the uniformly bounded \(B_{n,j}\). Their sums divided by \(b\) converge to zero. On compact subannuli of the complex disk the already proved summable bound is still valid and gives the same Rouché conclusion, since \(b\to\infty\).

It remains to check the signs of \(S_n/A_n\) at interior Jacobi extrema approaching zero angle, the other endpoint following by parity. Write \(u=\sin\phi\). If \(bu\to\infty\), the convolution amplitudes divided by \(b\) are \(O_B((1+\log(1+bu))/(bu))\), and the fixed-board ratio tends to \(H(1)=1\). If \(bu\to v\) with \(0<v<\infty\), the rotation-and-stretch estimate on \(j\le b\) gives \(R_j=A_{n-j}/A_n=\cos(j\phi)+O(b/n)\) at the extrema. The Gegenbauer integral yields \(A_{j-\ell}=f(vj/b)+o(1)\) uniformly for \(k<j\le b\) and \(\ell\le k\le h\). Therefore \(\sum_{I\subseteq J} d_I A_{j-\ell}\) tends uniformly to zero for nonempty \(J\). The original fixed-board ratio tends to one, and (5) gives
\[
 S_n/(b A_n)\ \longrightarrow\ 1-\int_0^1 f(vt)\cos(vt)\,dt>0 .
\]
Here \(|f(s)|<1\) at every \(s>0\), by its continuous nondegenerate characteristic-function representation.

Finally suppose \(bu\to0\). Put \(d=1-x\asymp u^2\). For \(j\ge2\) the backward recurrence at the extrema reads
\[
 R_j-R_{j-1}=(1+e_j)(R_{j-1}-R_{j-2})-(2+e_j)d\, R_{j-1},
 \quad e_j=3/(n-j+1),\quad R_0=1,\ R_1=x .
\]
For \(1\le j\le b\), one has \(1/2\le R_j\le1\) and
\(jd\le R_{j-1}-R_j\le 6jd\) for all sufficiently large \(n\). Indeed, while the ratios lie in \([1/2,1]\), iterating the recurrence for the differences gives the upper bound since \(\prod_{i=2}^b(1+e_i)\le2\) and \(2+e_i\le3\). The lower bound follows by adding at least \(d\) each step. The upper bound on the differences gives \(R_j\ge1-6b^2d>1/2\), closing the induction. Thus the empty-top-placement contribution to \(S_n/A_n\) is
\[
 \sum_{j=1}^b (1-R_j A_j)\ \ge\ \sum_{j=1}^b(1-R_j)\ \ge c b^3 u^2 .
\]
For every nonempty fixed \(J\), \(F_{n,J}/A_n=O_B(u^2)\) by inclusion–exclusion, since \(R_\ell=1+O_B(u^2)\) for fixed \(\ell\le h\). Also \(F_{j,J}=O_B(j u^2)\) for \(k<j\le b\). In detail \(A_m=\mathbb E\theta^m\), where \(\theta=x+iVu\) and \(V\) has the symmetric semicircle density above. Then
\[
 |A_m-A_{m-1}|\le |\,\mathbb E(\theta-1)\,|+
       (m-1)\mathbb E|\theta-1|^2=O(m u^2)
\]
because \(|\theta|\le1\). Hence \(A_{j-\ell}=A_j+O_B(j u^2)\); the signed coefficients \(d_I\) sum to \(O_B(u^2)\) for nonempty \(J\). The entire nonempty-\(J\) contribution to (5) divided by \(A_n\) is \(O_B(b^2u^2)\). The strictly positive empty term dominates. The original ratio \(P_n/A_n\) tends to one, so the two terms give the correct sign for every new weight, even if it varies without bound. These cases exhaust all subsequences. The same extrema and interior phase argument completes the proof.

Combining the uniform extension theorem with the [boundary stability theorem for adjoining a tall column](tall_column.md) also permits iteration. Starting with a fixed boundary polynomial zero-free on the closed unit disk, one may append any finite number of successively sufficiently tall leftmost columns. At each stage the threshold may depend on the entire previously fixed board and its weights. Once the final height exceeds its threshold, every admissible finite rank has simple negative zeros.

For actual boards consisting of one column, at most finitely many pairs \((b,n)\), \(1\le b<n\), can fail real-rootedness. The uniform extension theorem with empty \(B\) covers all sufficiently large \(b\) at once. Each of the finitely many smaller \(b\) gives a fixed \(b\times1\) rectangle, whose boundary polynomial has positive real part on the closed disk, so only finitely many ranks remain for that height. The argument is qualitative and gives no numerical bound on this joint exceptional set.

### Arbitrary first four widths and unit widths below them at every rank

For every rank \(n\), take one column of height \(n-1\) and any number of additional columns of heights at most four that fit in the board. All column weights may be arbitrary nonnegative reals. Then \(A_{n-1}\) is a common strict interlacer, and the Schubert \(Z\) at unit weights has \(n\) simple negative zeros. Equivalently, every row below the fourth has width one, with arbitrary admissible widths in the first four. There is no lower bound on the rank, the column heights or the widths.

The part omitting the tall column has the required sign at every Jacobi node by the [four-row theorem](rook_jacobi.md). The previous hook calculation handles \(S_{n,\varnothing}=G_n\). Consider a fixed nonempty set of short columns with heights \(a_1\le\cdots\le a_p\) in right-to-left order. Its product of weights multiplies the sum of \(S_{n,J}\) over \(J=\{j_1<\cdots<j_p\}\) with \(j_i\le a_i\). There are 41 feasible height tuples of length at most four. For \(n\le4\) the entire board already has at most three rows. For \(n\ge5\), put
\[
 P_{\mathbf a}(n,v)=256(n-1)(n-2)(n-3)(n+3)(n+4)v
       \sum_{J:\, j_i\le a_i}\frac{S_{n,J}(x)}{A_n(x)}
\]
at a root of \(A_{n-1}\), with \(v=1-x^2\). Explicit polynomial representatives follow from (2), with \(R_0=1,R_1=0\) and the Jacobi recurrence in both directions. In particular the convolution term is \((R_{\ell-2}-xR_{\ell-1})/y\).

Here are finite rational certificates for the needed nonnegativity. The Rayleigh bound proved for the hook gives
\[
 v\ge\frac{\sqrt{192}}{\sqrt{(n^2+n-2)(n^2+n+18)}}
 >\frac{69}{5(n^2+n+8)}=:v_0 .
\]
Use \(D=5(n^2+n+8)\), and split \([v_0,1]\) into its two equal intervals. For half \(e=0,1\), set \(L=(2-e)69+eD,\ K=(1-e)69+(1+e)D\). The substitution \(v=(L+Kt)/[2D(1+t)]\), \(t\ge0\), covers the half interval up to its upper endpoint. Multiply \(P_{\mathbf a}\) by the denominator to the power \(\deg_v P_{\mathbf a}\) and substitute \(n=N+12\). The resulting polynomial in \(N,t\) has positive constant coefficient and every nonzero coefficient is positive. The minimum of its nonzero coefficients across both halves and the eligible height tuples, by \(p=1,2,3,4\), is respectively \(1280,11200,96000,900000\). Continuity gives nonnegativity at the upper endpoint of either interval.

For \(5\le n<12\), take \(Q=P_{n-1}^{(1,1)}\) and \(f(x)=P_{\mathbf a}(n,1-x^2)\). The signed remainder chain started at \(Q,\ (fQ')\bmod Q\) either has zero second entry or its variation drops by \(n-1\) between \(-1\) and \(1\). In the first case \(f\) vanishes at every Jacobi node since \(Q\) is square-free. In the second its signs at these \(n-1\) nodes sum to \(n-1\) by the Sturm–Tarski identity, proving strict positivity. The [integer and rational verifier](verify_full_column.py) constructs all polynomials, checks the coefficient minima, performs the finite sign queries, and independently verifies (2) against direct path counts in small ranks. Adding the previously strictly signed empty-short-column polynomial completes the alternating-sign proof.
