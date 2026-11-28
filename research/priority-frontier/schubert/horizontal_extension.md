# Uniform horizontal extensions of every Schubert shape

**Theorem.** Let \(\lambda\) be any positive partition of rank \(n\ge2\). Add \(q\) to each of its parts. If
\[
 q\ge (n-1)+384(n-1)^2 ,
\]
the Schubert \(Z\)-polynomial of \(\lambda+(q^n)\) has \(n\) simple negative roots. All such rank-\(n\) polynomials share the empty-board rank-\(n-1\) strict interlacer. The starting shape and its number of corners are unrestricted. The proof also permits nonnegative weights on the original columns if the newly added columns have unit weight. The matroid assertion uses unit weights throughout.

We use the [Motzkin–rook model, Jacobi recurrence and notation](rook_jacobi.md) with \(x=\cos\phi\), \(u=\sin\phi\), \(y=-u^2/4\). Adding \(q\) to all parts adds \(q\) columns of full height \(h=n-1\), even when some of the original board rows were empty. Take the new columns at the left, reordering any columns of the same height if needed. A first return to zero at time \(L\) has normalized weight \(f_1=x\) or \(f_L=yA_{L-2}\) for \(L\ge2\). For the complete set of constrained rows the path first returns at its endpoint. Hence
\[
 F_{n,[h]}=f_n,\qquad f_n/A_n=u^2/(4b_n)>0
\]
at every node of \(A_{n-1}\), with \(b_n=(n-1)/(n+2)\).

## Bounds at the Jacobi nodes

Fix such a node. Write \(R_j=A_{n-j}/A_n\) and \(r_j=\sin((1-j)\phi)/u\). For \(1\le j\le n\) put
\[
 M_j=\prod_{l=1}^{j-1}\left(1+\frac3{n-l}\right)
 =\frac{n(n+1)(n+2)}{(n-j+1)(n-j+2)(n-j+3)} .
\]
The rotation recurrence from the companion proof gives \(|R_j|\le M_j/u\) since its starting two-vector has norm \(1/u\). It also gives
\[
 R_j-r_j=\sum_{l=1}^{j-1}\tau_l\sin((j-l)\phi),\qquad
 |\tau_l|\le (M_{l+1}-M_l)/u .
\]
Indeed each stretch injects a vertical vector and the unperturbed rotations transport it to step \(j\). Since \(|\sin(k\phi)|\le ku\), telescoping gives the second bound \(|R_j|\le jM_j\). For any \(2\le L\le n\),
\[
 M_{n-L+2}=\frac{n(n+1)(n+2)}{(L-1)L(L+1)}
 \le 4(n/L)^3 .
\]
The positive Fourier weights of \(A_{n-1}(\cos\phi)\) on frequencies of magnitude at most \(n-1\) imply that this polynomial is positive when \(0\le\phi<\pi/(2(n-1))\). By parity and \(\sin\phi\ge 2\phi/\pi\) in the first quadrant, every node thus has \(u\ge1/(n-1)\).

Take any nonempty row set missing \(d\ge1\) of the \(h\) times. An actual path may return to zero before the endpoint at an arbitrary subset of these \(d\) times. For each subset its return gaps yield a term \(\prod_i f_{L_i}\), with \(\sum L_i=n\) and at most \(d+1\) factors. The largest gap \(L\ge n/(d+1)\) is at least two because at least one time is required to be positive. Cancelling the factor \(y\) at this gap against \(f_n\) leaves the ratio \(|A_{L-2}/A_{n-2}|=b_n|R_{n-L+2}|\).

If another gap has length at least two it contributes at most \(u^2/4\) in modulus, while all other factors have modulus at most one. Thus the whole term relative to \(f_n\) is bounded by \((d+1)^3\) using \(|R_j|\le M_j/u\). If all other gaps have length one, then \(n-L+2\le d+2\), so \(|R_j|\le jM_j\) bounds the ratio by \(4(d+2)(d+1)^3\). Summing the at most \(2^d\) subsets gives
\[
 |F_{n,J}/f_n|\le192^d .
\]
Here \(d+2\le3^d\), \(d+1\le2^d\), and \(4\le4^d\). For the empty row set \(d=h\), its complete polynomial is \(A_n\); the same bound follows from \(|A_n/f_n|=4b_n/u^2\le4h^2\le192^h\).

## Combining the columns

Fix any selection of \(t\) original columns which can carry rooks. They can occupy the first \(t\) rows by shifting upwards from any admissible placement. All designated new columns lie to their left. There are exactly \(\binom q{h-t}\) full-row placements using precisely these original columns. At deficit \(d\), after choosing the missing rows and the new columns, the matching is forced. The ratio of the number of such placements to the full-row count is at most
\[
 \binom hd\frac{\binom q{h-t-d}}{\binom q{h-t}}
 \le\binom hd\left(\frac{h}{q-h+1}\right)^d.
\]
The fixed product of original column weights is common to both counts. Thus, at every node, the incomplete summands divided by the full-row summand have total absolute value at most
\[
 \left(1+\frac{192h}{q-h+1}\right)^h-1
 \le e^{192h^2/(q-h+1)}-1<1 .
\]
The sum has the sign of \(f_n\) at every node, and the alternating endpoint signs yield one simple root in each of the \(n\) intervals. The inverse change of variables gives negative roots as claimed.

## An empty tail of variable length at the far end

Write \(m=n-h\) for a board with \(h\) nonempty rows. There are absolute constants \(C_1,C_2\) such that \(n\ge C_1(m+1)\) and \(q\ge h+C_2 h^2m^2\) full-height columns suffice for strict interlacing, for every choice of the shorter columns. One may take \(C_1=4\,000\,000\) and \(C_2=3\,000\,000\,000\). For \(m=1,2\) the additional requirement on \(n\) can be dropped. Here a full column has height \(h\), so this theorem also covers boards with a prescribed block of empty rows.

The full row set requires the first return to occur after \(h\), whence
\[
 F_{n,[h]}=y\sum_{j=0}^{m-1} A_j A_{n-2-j}.
\]
At the Jacobi nodes the ratio to \(f_n\) equals \(-b_n\sum_{j<m}A_jR_{j+2}\). Replacing \(R\) by \(r\) in the sum without \(b_n\) gives the exact positive expression
\[
 S_m=\sum_{j<m} A_j(x)\frac{\sin((j+1)\phi)}u
 =\frac1{2u^2}\mathbb E\!\left[\frac{1-\operatorname{Re}\theta^m}{U}\right],
 \qquad \theta=1-U+Ue^{2i\phi},\quad U\sim{\rm Beta}(3/2,3/2).
\]
Indeed \(e^{ij\phi}A_j=\mathbb E\theta^j\), and \(e^{i\phi}/(1-e^{2i\phi})=i/(2u)\). Because \(U\le1\) and \(|\theta|\le1\), the single-column Fourier gap in the companion proof gives
\[
 S_m\ge(1-|A_m|)/(2u^2)
 \ge(c_0/2)\min(m^2,u^{-2}),\qquad c_0=1/40000 .
\]
For \(n\ge10(m+1)\) the elementary bounds on the rotated errors give \(|R_{j+2}-r_{j+2}|\le3(j+2)(j+1)/(n-m-1)\). Summing bounds the error in \(S_m\) by \(6m^3/(n-m-1)\). Alternatively use the sine expansion of the error: each of its at most \(m\) stretch terms has size at most \(6/[(n-m-1)u]\) times a contiguous Jacobi sine sum of modulus at most \(4/u\), by the geometric progression estimate in the wide-last-row proof. Thus the error is at most \([24m/(n-m-1)]\min(m^2,u^{-2})\). Under the stated rank condition the coefficient is at most \(c_0/4\); since \(b_n\ge1/4\), this yields \(F_{n,[h]}/f_n\ge c_0/16\). For \(m=1\) this ratio is exactly one. For \(m=2\) and \(h\ge1\) the node identity gives the ratio \(1+(a_{n-1}/b_{n-1})x^2\ge1\), where \(a_j=(2j+1)/(j+2)\).

For a nonempty row set missing \(d\ge1\) marked times, specify its actual zero-return subset before or at \(h\), then its first return after \(h\) at \(n-j\), \(0\le j<m\). The resulting weight is a product of at most \(d+1\) first-return factors, times the unrestricted \(A_j\). There are at most \(m2^d\) choices. The longest return gap has \(L\ge(n-j)/(d+1)\ge n/[2(d+1)]\), since \(n-j\ge n/2\) in the stated regimes. As before, if there is another nontrivial gap its \(u^2/4\) factor cancels the possible \(1/u\) loss. With only one nontrivial gap the backward index is at most \(j+d+2\le m(d+2)\). Hence each term divided by \(f_n\) has absolute value at most \(32m(d+2)(d+1)^3\), giving a bound \(32m^2 48^d\) for the full row-set polynomial. The empty row set has \(d=h\) and \(|A_n/f_n|\le4(n-1)^2\le16(h+1)^2\), also sufficient.

Dividing by the full-row placement count as before, the total incomplete contribution relative to \(|f_n|\) is bounded by
\[
 32m^2\left[\exp\!\left(\frac{48h^2}{q-h+1}\right)-1\right]<c_0/16 .
\]
The displayed \(C_2\) works by \(e^v-1\le2v\) for the small exponent. This preserves the full-row signs and proves the extension.
