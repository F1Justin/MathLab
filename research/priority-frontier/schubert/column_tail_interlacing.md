# Strict interlacing for nearly full single columns

Let \(A_n=P_n^{(1,1)}/(n+1)\), normalized by \(A_n(1)=1\). For a single column of height \(1\le b<n\) and column weight \(w\), write
\[
 F_{n,b}=(1+wb)A_n-w\sum_{j=1}^b A_jA_{n-j}.
\]
The [Motzkin–rook model](https://www.symmetricfunctions.com/schubertMatroidZ.htm) gives the normalized Schubert polynomial when \(w=1\). Appending a unit row increases \(n\) and holds \(b\) fixed. We prove the following statements.

* At every \(n\ge2\), the full column of height \(n-1\) and its first extension strictly interlace, for every \(w\ge0\).
* There are absolute constants \(\epsilon>0\) and \(n_0\) such that whenever \(n\ge n_0\) and \(n-1-b\le\epsilon n\), all the roots of \(F_{n,b}\) strictly interlace those of \(F_{n+1,b}\) at unit weight.
* There are absolute constants giving the same all-root conclusion when the height is at most a sufficiently small positive fraction of the rank, even with arbitrary nonnegative weights on the individual cuts.
* For arbitrary nonnegative fixed weights on any of the individual cut times, the two extreme roots move strictly outwards under extension at every admissible rank.

The [single-cut theorem](single_cut.md) places one simple root of every row in each interval between the endpoints and consecutive zeros of \(A_n'\). At the roots in decreasing order, the signs of \(A_n'\) therefore begin with plus and alternate. To prove strict interlacing it suffices that the next row has the opposite sign there, since its endpoint values are \(1,(-1)^{n+1}\). The increasing map \(t=(x-1)/(x+1)\) carries the resulting statements to the negative axis. In either case of full interlacing, the usual degree and endpoint cancellation in \([Z_{n+1}-(1+t)Z_n]/t\) also give strict interlacing of this difference polynomial with \(Z_n\).

## The full column and its first extension

The first-return identity and Jacobi derivative formulas give, with \(z=1-x^2\),
\[
 \sum_{j=0}^n A_jA_{n-j}=4A'_{n+1}/(n+4),\quad
 A_{n+1}=xA_n-zA'_n/(n+3),\quad
 A'_{n+1}=(n+1)A_n+\frac{n+1}{n+3}xA'_n .
\]
For the last identity one can differentiate the preceding one and eliminate \(A_n''\) using \(z A_n''-4xA_n'+n(n+3)A_n=0\). It follows that the full column is
\[
 G_n=\alpha_n A_n-\beta_n x A'_n,\qquad
 \alpha_n=1+\frac{wn(n+1)}{n+4},\qquad
 \beta_n=\frac{4w(n+1)}{(n+3)(n+4)}.
\]
The row of rank \(n+1\) with the same height is \(G_{n+1}-w(A_{n+1}-xA_n)\).

Suppose \(w>0\) and set \(J=\alpha_n/[(n+3)\beta_n]\). At each positive root \(r\) of \(G_n\), \(A_n(r)\ne0\) because \(A_n\) has simple roots, and substitution gives
\[
 r\frac{F_{n+1,n-1}(r)}{A_n(r)}
       =K r^2-B(1-r^2),\qquad
 K=\alpha_{n+1}-\beta_{n+1}(n+1)(1+J)=\frac3{n+5},
 \quad B=(\alpha_{n+1}-w)J>0.
\]
Each root of \(G_n\) obeys \(1-r^2\ge2/S\), since the endpoint logarithmic derivative \(S=G'_n(1)\) contains the terms for the pair of extreme roots \(\pm r_*\), whose sum is \(2/(1-r_*^2)\). In fact
\[
 S=\frac{n(n+3)}4+w\frac{n(n^2-1)}{12},\qquad
 2(K+B)-KS=\frac{n(n^2-1)w^2+(n^2+7n)w+2n+8}{4w(n+1)}>0.
\]
Here \(A'_j(1)=j(j+3)/4\), so that each cut adds \(wj(n-j)/2\) to the derivative. The sample ratio is strictly negative because \(1-r^2>K/(K+B)\). At a positive root \(\alpha_n A_n=\beta_n r A'_n\), so the next row has sign opposite to \(A'_n\). Parity gives the same verdict at negative roots. If \(n\) is odd, zero is an old root and the sign of the new even row at zero is \((-1)^{(n+1)/2}\) by its simple symmetric roots. This is opposite to the sign of \(A_n'(0)\). The case \(w=0\) is ordinary Jacobi interlacing.

## Uniformity when a small fraction of the column is missing

In this section \(w=1\), \(h=n-1-b\), and it suffices to work with \(h+1\le n/4\). Every implicit constant below is absolute. Write \(x=\cos\phi\), \(u=\sin\phi\), \(z=u^2\). Use coordinates in the basis \(A_n,A_n'\). For \(F_{n,b}\) call its coordinates \((P,S)\), and for \(F_{n+1,b}-xF_{n,b}\) use \((U,V)\). If \(P>0\) and \(D=PV-SU<0\) at an old root, the actual new row there equals \((D/P)A'_n\), the required sign.

Use \((P_0,S_0)=(\alpha_n,-\beta_n x)\) for \(G_n\), and \((U_0,V_0)\) for \(G_{n+1}-xG_n\). Direct substitution in the derivative identities gives
\[
 U_0=x[\alpha_{n+1}-\beta_{n+1}(n+1)-\alpha_n]=O(1),\qquad
 V_0=-\frac{\alpha_{n+1}z}{n+3}
       +x^2\left[\beta_n-\frac{n+1}{n+3}\beta_{n+1}\right]=O(z+n^{-2}).
\]
In the second bracket the two terms differ by \(O(n^{-2})\). The full-column determinant is
\[
 D_0=P_0V_0-S_0U_0=\frac{12(n+1)}{(n+3)(n+4)(n+5)}
       -\frac{(n+2)(n^3+4n^2+11n+20)}{(n+3)(n+4)(n+5)}z .
\]
Here the two full columns have different heights. The correction below restores a common height.

For \(0\le j\le h+1\) write
\[
 A_{n-j}=L_j A_n+(z/n)M_j A_n',\qquad
 B_j=L_j+i u M_j,\qquad B_0=1,\quad B_1=e^{i\phi}.
\]
The backward Jacobi recurrence for \(B_j\) gives the transfer on the pair \((B_j,(xB_j-B_{j-1})/u)\) as a stretch of the second coordinate by \(1+3/(n-j)\) followed by an orthogonal rotation, as in the [fixed-board proof](rook_jacobi.md). The pair starts at \((e^{i\phi},i e^{i\phi})\) and its norm is uniformly bounded since \(j\le n/4\). Both coordinates are trigonometric polynomials of degree at most \(j\), by the transfer itself. The real part of the second coordinate and the imaginary part of the first vanish at \(\phi=0,\pi\). Bernstein's inequality for trigonometric polynomials and the distance to the closer endpoint thus give
\[
 |L_j|\ll1,\quad |M_j|\ll\min(j,1/u),\quad
 |L_{j-1}-xL_j|\ll\min(u,jz),\quad |M_{j-1}-xM_j|\ll1.
\]
The same conclusions extend by continuity to the endpoints. The integral representation gives \(|A_j|\le1\). The real polynomial \(L_j\) has parity \(j\) and \(L_j(1)=1\). On \(0\le x\le1\), Markov's inequality and \(1-x\le z\) give \(|A_j L_j-1|\ll\min(1,j^2z)\) and \(|A_{j+1}L_j-x|\ll\min(1,(j+1)^2z)\). Parity recovers all the estimates in modulus at the opposite endpoint.

Time reversal identifies the omitted top cuts with times \(j=1,\ldots,h\). At the new rank the same height omits \(h+1\) cuts. Set \(H=h+1\) and denote the differences from full-column coordinates by \(\delta P,\delta S,\delta U,\delta V\). The exact corrections are
\[
\begin{aligned}
 \delta P&=\sum_{j=1}^{h}(A_j L_j-1),&
 \delta S&=(z/n)\sum_{j=1}^{h}A_jM_j,\\
 \delta U&=\sum_{j=1}^h A_j(L_{j-1}-xL_j)+A_{h+1}L_h-x,&
 \delta V&=\frac zn\left[\sum_{j=1}^h A_j(M_{j-1}-xM_j)+A_{h+1}M_h+\frac{nH}{n+3}\right].
\end{aligned}
\]
In particular
\[
 |\delta P|\ll\min(H,H^3z),\quad |\delta S|\ll zH\min(H,1/u)/n,
 \quad |\delta U|\ll\min(1+Hu,H^2z),\quad |\delta V|\ll zH/n.
\]
Expanding the two determinants now gives \(|D-D_0|\ll Hz\). Indeed the terms containing \(\delta V\) cost \(O(Hz)\), since \(|P|\ll n\). The term \(\delta P V_0\) costs \(O(Hz+H^3z/n^2)\). The term \(S_0\delta U\) costs \(O(H^2z/n)\). For \(\delta S(U_0+\delta U)\) use \(\min(H,1/u)(1+Hu)\le2H\), giving \(O(H^2z/n)\).

Choose \(\epsilon>0\) sufficiently small and then \(n_0\) sufficiently large. Since \(P_0/n\to1\), the \(\delta P\) bound gives \(P>0\) everywhere when \(h\le\epsilon n\). Since the coefficient of \(-z\) in \(D_0\) divided by \(n\) tends to one, the determinant satisfies
\[
 D\le(13/n^2)-(3n/4)z .
\]
At each old root, the endpoint argument gives \(z\ge2/F'_{n,b}(1)\ge2/G'_n(1)=24/(n^3+3n^2+8n)\). Substitution makes \(D<0\) for all sufficiently large \(n\). All root signs therefore have the required orientation.

## The extreme roots at every height

Take fixed nonnegative weights \(w_j\) on \(1\le j<m-1\) and compare the rows of ranks \(m-1,m\). If some weight is positive, the later row at the largest zero \(\xi\) of \(A_m\) is strictly negative because each \(A_j(\xi)A_{m-j}(\xi)>0\) by Jacobi interlacing. Its largest root \(r\) therefore satisfies \(r>\xi\). All the \(A_i\) for \(i\le m\) are positive at \(r\). The ratios \(q_i=A_{i-1}/A_i\) strictly increase in \(i\) at this point. Indeed \(q_1=1/r>r\) and \(1/q_i=r-b_i(q_{i-1}-r)\) with increasing \(b_i=(i-1)/(i+2)\). The product of \(j\) consecutive ratios ending at \(i\) is therefore larger for \(i=m\) than for \(i=m-1\). It follows directly from the cut formulas that
\[
 F_{m-1}(r)/A_{m-1}(r)> F_m(r)/A_m(r)=0.
\]
All but the largest root of \(F_{m-1}\) lie below its largest derivative node of \(A_{m-1}\), itself below \(\xi\), by the single-cut theorem and Jacobi interlacing. Positivity then puts its largest root strictly below \(r\). Parity gives the other endpoint. All-zero weights give the same result by ordinary Jacobi interlacing.

## Columns of small proportional height, uniformly over the cut weights

There are absolute \(\epsilon'>0,m_0\) such that, for every \(m\ge m_0\) and \(1\le b\le\epsilon' m\), adjacent ranks \(m-1,m\) strictly interlace for **arbitrary nonnegative cut weights** \(w_1,\ldots,w_b\) held fixed between the two ranks. The weights may vary with \(m\) in this uniform statement. It suffices to prove that no counterexample sequence exists with \(m\to\infty\) and \(b/m\to0\): failure for all choices of \(\epsilon',m_0\) would yield such a sequence by taking \(\epsilon'=1/i,m_0=i\).

Use the preceding transfer \(B_j=L_j+i u M_j\) at rank \(m\), and set \(\zeta=e^{i\phi}\), \(Y=A_m+i u A_m'/m\). Put
\[
 C=1+\sum_{j\le b} w_j(1-A_jB_j),\qquad
 V=\zeta C+E,\qquad E=-\sum_{j\le b}w_j A_j(B_{j+1}-\zeta B_j).
\]
The rank-\(m\) row is \(\Re(Y\bar C)\) and the preceding row is \(\Re(Y\bar V)\), directly from the representations of \(A_{m-j},A_{m-1-j}\). By parity it suffices to test \(0\le\phi\le\pi/2\). The earlier argument proves positivity of the preceding row at the largest zero of the current row, and parity settles the smallest. At each remaining zero we will have \(\Re C>0\) and \(|E|<u|C|\). Indeed this implies \(\Im(V\bar C)>0\); writing \(Y\bar C=iT\) with real \(T\) gives \(\operatorname{sgn}T=\operatorname{sgn}A_m'\) and \(\Re(Y\bar V)=T\Im(V/C)\). Together with the signs at the two extremes these are the \(m\) alternating values required for strict interlacing.

Let \(K_j=(xB_j-B_{j-1})/u\). The stretch-and-rotate argument, comparing with the pure rotation on both coordinates and telescoping, gives uniformly for \(j\le b+1\)
\[
 B_j=\zeta^j+O(b/m),\qquad K_j=i\zeta^j+O(b/m).
\]
In fact the norm of the true transfer is at most \(\sqrt2\exp(3(b+1)/(m-b-1))\), and each step differs from the comparison rotation by \(O(1/m)\) on these bounded vectors. Directly from the recurrence, \(e_j=B_{j+1}-\zeta B_j\) satisfies
\[
 e_0=0,\qquad e_j=\bar\zeta e_{j-1}+3uK_j/(m-j).
\]
Thus \(|e_j|/u\le(3+o(1))j/m\). Propagating once more, \(|B_j-\zeta^j|\ll u j^2/m\), even when \(u\) is very small.

Choose a fixed sufficiently small \(\delta>0\). When \(ju<\delta\), Markov's inequality gives \(A_j=1+O(j^2u^2)>0\). Since \(\phi\le\pi u/2\), the refined bound on \(B_j\) gives \(L_i>0\) for \(0\le i\le j\) and \(\Im B_j\gg ju\) for all large \(m\). In addition \(L_j\le1\): \(L_0=1,L_1=x\), and the backward recurrence for the differences reads
\[
 L_{i+1}-L_i=(1+d)(L_i-L_{i-1})-(2+d)(1-x)L_i,\qquad d=3/(m-i).
\]
The terms decrease as long as they are positive. Thus \(1-A_jL_j\ge0\) and \(A_j\Im B_j\gg ju\) on this part of the sum.

For \(ju\ge\delta\), uniformly in \(j\) and \(0<\phi\le\pi/2\), one has \(|A_j(\cos\phi)|\le1-c_\delta\) for some \(c_\delta>0\). To verify uniformity, bounded \(j\) follows by compactness from \(|A_j(x)|<1\) in the interior. Along \(j\to\infty\) with \(ju\to L\in[\delta,\infty)\), the normalized Gegenbauer integral with its semicircle probability measure gives \(A_j\to\int_{-1}^1e^{iLt}\,d\mu(t)\), whose modulus is strictly below one. If \(ju\to\infty\), the energy bound (3) in the [single-cut proof](single_cut.md) gives \(A_j\to0\). Since \(|B_j|\le1+o(1)\), each of these large-\(ju\) cuts contributes at least \(c_\delta/2\) to the real part of \(1-A_jB_j\), and has bounded imaginary part. In particular \(\Re C\ge1\), and
\[
 |C|\gg_\delta 1+\sum_{j\le b}w_j\min(ju,1).
\]
Indeed the total weight of the large-\(ju\) terms is bounded by a constant times \(\Re C\). The small-\(ju\) contributions to the imaginary part all have the same sign and their absolute sum is bounded by \(|\Im C|\) plus the modulus bound from the large-\(ju\) terms.

Now if \(mu\to\infty\), the bounds imply
\[
 \frac{|E|}{u|C|}\ll_\delta (mu)^{-1}+b/m\to0.
\]
Here one uses \(j/m\le[(mu)^{-1}+b/m]\min(ju,1)\). If \(mu\) stays bounded, \(bu\to0\), \(A_j=1+o(1)\) uniformly and \(\Im B_j=(1+o(1))ju\), by the refined transfer bound. Unless all weights vanish (ordinary Jacobi interlacing), this yields
\[
 |C|\ge(1-o(1))u\sum_{j\le b}j w_j,\qquad
 \frac{|E|}{u|C|}\le\frac{3+o(1)}{mu}.
\]
At a nonextreme root of the current row the single-cut interlacer ensures that its modulus is at most the largest root of \(A_m'\). The endpoint logarithmic derivative applied to the extreme root pair of \(A_m'\) thus gives
\[
 u^2\ge\frac{2A_m'(1)}{A_m''(1)}
       =\frac{12}{(m-1)(m+4)}.
\]
(The proof uses only large \(m\), so the derivative polynomial has a distinct extreme pair.) Consequently \(\limsup |E|/(u|C|)\le3/\sqrt{12}<1\). Every sequence of candidate failures has a subsequence in one of the two regimes, so the required constants exist.

## A bounded number of endpoint comparisons at all heights

For the unit-weight column there is an absolute integer \(K\) such that at every rank and height all but at most the first and last \(K\) old roots have the correct strict sign in the preceding row. On the common central interval the two rows strictly alternate, with exactly one root in each gap having both endpoints there. The order of the two extreme roots is known separately at every height.

Indeed the preceding results control all roots when \(b/m\) is sufficiently close to zero or one. In the remaining range \(\delta m\le b\le(1-\delta)m\) for a fixed \(\delta>0\), the transfer norm is bounded by a constant depending only on \(\delta\). The Jacobi estimate (3) cited above gives
\[
 \sum_{j=1}^b |A_j(\cos\phi)|\ll 1/u
\]
by using the trivial bound for \(j\le4/u\) and summing \((ju)^{-3/2}\) afterwards. Hence \(\Re C\ge1+b-O_\delta(1/u)\), and the recursion for \(e_j\) gives \(|E|/u\ll_\delta \sum_{j\le b}(j/m)|A_j|\ll_\delta 1/u\). At all sufficiently large \(mu\), the signs follow as before. The same estimate tests the *following* row on these roots: replace \(V\) by \(V_+=(1+b)B_{-1}-\sum_{j\le b}A_j B_{j-1}\), where \(B_{-1}=x-iu m/(m+3)\) is the exact forward Jacobi step in the same basis. Thus \(|V_+-\bar\zeta C|/u\ll_\delta(1+b)/m+1/u\), since \(|B_{j-1}-\bar\zeta B_j|=|e_{j-1}|\). Its determinant has the opposite sign, as required for a following row. Applying both directions on the common interval forces strict alternation there: two consecutive intermediate roots would themselves require a root of the first row between them. This leaves \(mu\le T\) for one absolute constant \(T\). For large \(m\), every positive Jacobi derivative node \(r\) in this region contributes at least \(m^2/T^2\) to the positive sum \(A_m''(1)/A_m'(1)=(m-1)(m+4)/6\), since \(1-r\le1-r^2\le T^2/m^2\). There are only \(O(T^2)\) such nodes. Their interlacing with the current row bounds its exceptional root count by one more at each end. The finitely many small ranks can be absorbed into \(K\).

A compact limiting question describes the remaining possible obstruction to eventual interlacing for all heights. Set \(g(y)=2J_1(y)/y\) with \(g(0)=1\). If there are failures at arbitrarily large ranks, some subsequence of nonextreme old roots has \(m\phi\to t\ge\sqrt{12}\) and \(b/m\to c\in(0,1)\), where
\[
 \begin{split}
 c g(t)&=\int_0^c g(st)g((1-s)t)\,ds,\\
 g'(t)\left[cg'(t)-\int_0^c g(st)g'((1-s)t)\,ds\right]&\le0 .
 \end{split}                                                    \tag{*}
\]
Here the old rank is \(m\) and the comparison is with rank \(m-1\). The first equality follows by dividing the old row by \(m\). For the second, the semicircle integral represents \(A_j\) as the average of \(v^j\), where \(v=\cos\phi+i y\sin\phi\). Uniformly for \(1\le j\le m\), averaging \(m(v-1)v^{j-1}\) gives \(m(A_j-A_{j-1})=t g'(tj/m)+o(1)\), since \(m(v-1)=ity+o(1)\). Likewise \(A_m'/m^2\to-g'(t)/t\) by differentiating the integral with respect to \(m\phi\). Subtracting the preceding row at the old root therefore gives exactly the second required sign in the limit. The [Bessel product inequality](full_column.md) rules out \(g'(t)=0\) in the first equality: at such a critical point \(g(st)g((1-s)t)/g(t)<1\) for \(0<s<c\). The [Bessel transfer inequality](bessel_cut_interlacing.md) excludes every such pair by a pointwise bound and therefore supplies a uniform large-rank theorem at all column heights.
