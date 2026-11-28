# A reciprocal counterexample and the first two roots in every row

Let \(E(n,k)\) be the number of permutations of \(n\) letters with \(k\) descents, zero outside \(0\le k<n\), and \(A_n(x)=x\sum_{k=0}^{n-1}E(n,k)x^k\). The ordinary Eulerian matrix square has row \(H_n(x)=\sum_{k=0}^{n-1}E(n,k)A_{k+1}(x)\). [Mao and Wang, §4](https://arxiv.org/html/2607.01572v1)

**A finite counterexample.** Set \(m=29\) and
\[
 b(z)=(1+z)\prod_{j=0}^{13}\big(1+(2^{23}+j)z+z^2\big)=\sum_{k=0}^m b_kz^k .
\]
This polynomial is reciprocal, has positive coefficients, and all its 29 roots are simple and strictly negative. Each quadratic has two reciprocal roots, and different quadratic coefficients give disjoint root sets. Its binomially weighted Eulerian transform
\[
 F(x)=\sum_{k=0}^m \binom mk b_k A_{k+1}(x)
\]
has a simple root at zero and exactly 27 more real roots. The two remaining roots form a nonreal conjugate pair. The [exact checker](check_reciprocal_obstruction.py) constructs \(F/x\) by integer arithmetic, checks that its derivative is coprime to it, and obtains 27 disjoint negative intervals by exact real-root isolation.

The actual inverse-binomial Eulerian input \(b_k=E(n,k)/\binom{n-1}k\) is reciprocal and negative-rooted, with only a simple root at \(-1\) and otherwise simple roots when \(n=30\). The counterexample therefore also matches the complete multiplicity restriction in the [factorial-row theorem](factorial_symbol.md). It rules out a possible sufficient principle for the Mao–Wang conjecture. A separate positive tilt fails even when applied to an actual Eulerian row: \(\sum_{j=1}^{30}E(30,j-1)2^{-16j}A_j(x)\) has only 28 real roots including zero, by the same exact calculation.

## A finite comparison for arbitrary inputs

Write \(n=m+1\), \(F=\sum_{i=0}^{n-1} a_i A_{n-i}\), \(a_i\ge0\),
\[
 V_n(s)=\sum_{i=0}^{n-1}a_i(2^{-n}s)^i,\quad
 P_n(s)=(2^{-n}s)^n F(2^n/s),\quad
 \eta_n(R)=(n+1)R\,2^{-n}+
 \frac{R^2(3/4)^n}{1-R(2/3)^n}.
\]
The expression for \(P_n\) at zero is defined by continuity. If \(R(2/3)^n<1\), then on \(|s|\le R\)
\[
 |P_n(s)-V_n(s)-s V_n(s/2)|\le V_n(R)\eta_n(R). \tag{1}
\]
Indeed the reversed \(A_d\) is \(D_d(y)=\sum_j E(d,j)y^j\) by Eulerian symmetry. Its linear coefficient is \(2^d-d-1\), and \(E(d,j)\le(j+1)^d\) follows by encoding the increasing runs as ordered bins. With \(1\le d=n-i\le n\), on this disk
\[
 |D_{n-i}(2^{-n}s)-1-2^{-i}s|\le \eta_n(R).
\]
The terms of degrees \(j\ge2\) are bounded by \(R^j (j+1)^n2^{-nj}\), starting at \(R^2(3/4)^n\) and decreasing by ratios at most \(R(2/3)^n\). Multiplying by \(a_i(2^{-n}s)^i\) and summing gives (1). Thus any locally uniform compact limit \(V\) of \(V_n\), for growing \(n\), yields a locally uniform limit \(V(s)+sV(s/2)\) for these transformed rows.

For an explicit infinite family of counterexamples take \(n\ge19\), \(m=n-1\), \(c_n=2^n/(16m)\), and
\[
 b^{(n)}(z)=(1+z)^{m-18}(1+c_n z+z^2)^9,\qquad
 a_i=\binom mi [z^i]b^{(n)}(z).
\]
Reciprocity identifies these \(a_i\) as the reversed input weights. With \(L_9(t)=\sum_{i=0}^9\binom9i(-t)^i/i!\), one obtains
\[
 V_n(16s)\ \longrightarrow\ L_9(-s),\qquad
 P_n(16s)\ \longrightarrow\ L_9(-s)+16sL_9(-s/2).
\]
For fixed \(i\le9\), \([z^i]b^{(n)}/c_n^i\to\binom9i\), because \(m/c_n\to0\), while \(\binom mi/m^i\to1/i!\). The tail of \(V_n(16s)\) beyond degree nine on \(|s|\le R\) is bounded by the corresponding tail of \(b^{(n)}(R/c_n)\), using \(\binom mi\le m^i\). That tail tends to zero since the full value tends to \((1+R)^9\) and its first ten terms already have that limit. This proves local uniformity. The primitive integral representative of the limiting polynomial in descending degree has coefficients
\[
 (1,194,12960,421632,7451136,73156608,386104320,998645760,
 1045094400,290304000,11612160).
\]
Its Sturm sequence has nine sign changes at \(-\infty\) and one at \(+\infty\). Its discriminant is negative and it has precisely eight distinct real roots. Rouché's theorem on small disks around its two nonreal roots gives a nonreal conjugate pair in all sufficiently large rows of this family.

## The two largest roots in modulus for every genuine row

For \(n\ge3\), the two largest nonzero roots of \(H_n\) in complex modulus are simple negative roots. Denote their positive moduli in decreasing order by \(M_{n,1}>M_{n,2}\). Each \(M_{n,i}\) increases strictly with \(n\). For any lag \(r\ge1\) the two pairs alternate strictly, in the order
\[
 M_{n+r,1}>M_{n,1}>M_{n+r,2}>M_{n,2},
\]
exactly when \(r=1\), or \(r=2\) and \(n\ge4\). For all other cases, \(M_{n+r,2}>M_{n,1}\).

Here \(a_i=E(n,i)\). Taking \(i=0\) in the single-row bound preceding (1) gives \(|V_n(s)-(1+s)|\le\eta_n(R)\). Hence with \(Q(s)=1+2s+s^2/2\), on \(|s|\le4\),
\[
 |P_n(s)-Q(s)|\le(6+\eta_n(4))\eta_n(4)+4\eta_n(2)<0.113\qquad(n\ge24).
\]
The last inequality at \(n=24\) is rational and the bound decreases thereafter. On \(|s|=4\) the product bound over the two negative roots of \(Q\) gives \(|Q(s)|\ge Q(-4)=1\). Thus \(P_n\) has exactly two roots there in the open disk. At the real points \(-1/2,-7/10,-16/5,-18/5\), the values of \(Q\) are respectively \(1/8,-31/200,-7/25,7/25\). Signs transfer and put one simple real root in each of the two intervals, exhausting the disk count. Consequently
\[
 (2^n/M_{n,1},2^n/M_{n,2})\ \in\ (1/2,7/10)\ \times\ (16/5,18/5).
\]
For \(n\ge24\) these brackets imply strict increase of the individual moduli, since each interval has endpoint ratio smaller than two. They imply the cross-rank inequalities for gaps one and two by \(4(7/10)<16/5\), and the reverse inequality at gap three by \(8(1/2)>18/5\). Strict increase then handles every larger gap. For \(3\le n<24\) the checker isolates all roots of rows 3 through 26 over the rationals, sorts their negative real intervals and verifies the same-rank and cross-rank inequalities for gaps one through three, including \(M_{5,2}>M_{3,1}\). These finite computations complete the exact all-row classification.

## The two smallest nonzero roots in every genuine row

For every \(n\ge3\) the two smallest nonzero roots in complex modulus are simple and negative. Their positive moduli \(m_{n,1}<m_{n,2}\) both decrease strictly with \(n\). For \(r=1,2,3\) one always has \(m_{n+r,1}<m_{n,1}<m_{n+r,2}<m_{n,2}\). For \(r=4\) the same inequalities hold exactly when \(n\ge5\), with \(m_{n+r,2}<m_{n,1}\) at both earlier indices. For growing lags the transition is linear:
\[
 \log\frac{m_{n+r,2}}{m_{n,1}}
  =(n+1)\log(\rho_2/\rho_1)+r\log\rho_2+O(0.95^n),\qquad
 \rho_1=\log2,\quad \rho_2=\frac{\log3}{2\log2}.
\]
The error is uniform over every integer \(r\ge0\). The least lag placing the second root of the later row below the first of the earlier row is consequently \(0.5758138463\ldots(n+1)+O(1)\), where the exact slope is \(\log(\rho_2/\rho_1)/\log(1/\rho_2)\).

Write \(a_i=[x^i]H_n(x)\), \(g(v)=(v-1)/\log v=\int_0^1v^t\,dt\), and \(b_i=n!g(i)^{n+1}\), with \(g(1)=1\). First \(a_i\le A_n(i)\le n!\,i g(i)^n\). The first inequality is the ordered-bin estimate \(E(d,i-1)\le i^d\). For the second, let \(S\) be the sum of \(n\) independent uniform random variables on \([0,1]\); then \(\Pr(\lceil S\rceil=k)=E(n,k-1)/n!\) by the inclusion-exclusion formula for the volume of the cube below consecutive integer hyperplanes. Now \(i^{\lceil S\rceil}\le i\,i^S\) and \(\mathbb E i^S=g(i)^n\).

Moreover \(a_1=b_1\), and \(|a_i/b_i-1|<0.001\) for \(i=2,3,\ n\ge80\). To verify the bound, the [Eulerian pole expansion](paired_edge.md) gives \(|A_n(i)/b_i-1|\le4(1/5)^{n+1}\), since the ratios of other poles to the main one are at most \(\log(3)/(2\pi |l|)<1/(5|l|)\). Also \(a_i\ge A_n(i)-(n+1)A_n(i-1)\) for \(i=2,3\) by the exact Eulerian formulas for one and two descents. Here \(b_{i-1}/b_i\le0.8^{n+1}\). Combining these estimates proves the stated relative error.

Fix \(k=1\) or 2 and put \(\rho_k=g(k)/g(k+1)\), \(q_k=g(k)g(k+2)/g(k+1)^2\). Then \(q_1<0.876,\ q_2<0.943\), \(\rho_k<0.8\). For \(0.9\le|s|\le1.1\) put \(x=-\rho_k^{n+1}s\). In \(H_n(x)/(b_k x^k)\) the terms of degrees \(k,k+1\) differ from \(1-s\) by at most \(0.001(1+|s|)\). The sole possible lower term (\(k=2\)) has absolute value \(q_1^{n+1}/|s|\). For each upper term of offset \(d\ge2\), the global coefficient bound gives
\[
 \frac{a_{k+d}|x|^d}{b_k}\le
 \frac{k+d}{g(k)}(\rho_k|s|)^d
 \left(\frac{g(k+d)\rho_k^d}{g(k)}\right)^n
 \le(2+d)\,0.88^d\, 0.943^{n(d-1)}.
\]
Indeed \(g\) is positive and strictly concave, hence log-concave, and its successive ratios from \(g(k+2)/g(k+1)\) onward decrease. The total error is therefore at most
\[
 0.0021+0.876^{81}/0.9+
 \frac{4(0.88)^2 (0.943)^{80}}{(1-0.88(0.943)^{80})^2}<0.04
 \qquad(n\ge80).
\]
On the circle \(|s|=1.1\) this is smaller than \(|1-s|\). Multiplying by \(s^{k-1}\) removes the pole at zero, so Rouché gives exactly \(k\) nonzero roots of \(H_n\) inside the corresponding \(x\)-disk. Real signs at \(s=0.95,1.05\) locate one in the bracket \(0.95\rho_k^{n+1}<m_{n,k}<1.05\rho_k^{n+1}\). The two brackets are disjoint and lie on opposite sides of the first counting circle, since \(\rho_1/\rho_2=q_1<0.876\). This proves the claimed complex ranks and simplicity. Keeping \(n\) in the displayed error estimates and evaluating at the actual root also gives \(m_{n,k}=\rho_k^{n+1}(1+O(0.95^n))\), which proves the uniform logarithmic comparison.

The brackets imply strict decrease of both ranks and the stated cross-order through lag four for \(n\ge80\), using \(1.05(0.8)<0.95\) and \(1.05(0.876)^{81}<0.95(0.79)^4\) with \(\rho_2>0.79\). For \(3\le n<80\), the checker isolates all zeros of the reversed coefficient polynomials of the relevant rows and refines only the first two rational intervals by bisection. This verifies the finite comparisons and both exceptions.
