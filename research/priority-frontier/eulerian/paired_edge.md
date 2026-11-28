# Paired extreme roots of the ordinary Eulerian square

Let \(E(m,j)\) count permutations of \(m\ge1\) with \(j\) descents, extended by zero outside \(0\le j<m\). The Mao–Wang convention is \(A(m,k)=E(m,k-1)\) for \(1\le k\le m\). Let \(H_n(x)=\sum_k (A^2)(n,k)x^k\), \(n\ge1\), and \(R_n(w)=w^nH_n(1/w)\). The reversed polynomial has constant coefficient one and degree \(n-1\); \(H_n\) also has a simple root at zero. [Mao–Wang, §4](https://arxiv.org/html/2607.01572v1)

**Theorem.** Fix an integer \(L\ge1\), set \(\rho=L/(L+1)\), and let \(z_-<z_+\) be the roots of
\[
 1-(s_L+1/L)z+\frac{s_L}{L+1}z^2,\qquad
 s_L=\left(\frac L{L+1}\right)^{L-1}.
\]
Two simple negative roots of \(R_n\) have the asymptotics \(-\rho^n(z_\pm+o(1))\). These are the roots with the \((2L-1)\)-st and \(2L\)-th smallest moduli, respectively, for all sufficiently large \(n\). In addition, for all sufficiently large \(n\), \(H_n\) has at least \(c\sqrt{n/\log n}\) distinct strictly negative roots for an absolute \(c>0\).

Thus pairs of roots at the large-magnitude end of \(H_n\) are asymptotic to \(-\rho^{-n}/z_\pm\). The all-degree real-rootedness conjecture requires control of the remaining zeros.

## The four leading terms

Complementing permutation values gives \(E(m,j)=E(m,m-1-j)\). The coefficient of \(w^k\) in \(R_n\) is consequently
\[
 \sum_{j=0}^k E(n,j)E(n-j,k-j)\qquad(0\le k<n).
\]
Index its summands by \(A=j+1\), \(B=k-j+1\), so \(k=A+B-2\). Both indices are positive and \(A+B\le n+1\).

For \(1\le M\le m\) one has
\[
 M^m-M(m+1)(M-1)^m\ \le\ E(m,M-1)\ \le\ M^m. \tag{1}
\]
Indeed, a function from the \(m\) values to \(M\) ordered bins produces an increasing list within each bin. A valid function gives a descent across every boundary and corresponds to a unique permutation with \(M-1\) descents. For a failed boundary, the two bins there concatenate in increasing order, including the case of an empty bin. Merging them leaves at most \((M-1)^m\) assignments and at most \(m+1\) positions for the cut. Summing over boundaries proves (1).

At \(w=-\rho^n z\), the unsigned monomial bound from (1), before the factor \(z^k\), is
\[
 \bigl[AB\rho^{A+B-2}\bigr]^n B^{-(A-1)} .
\]
The function \(m\rho^m\) on positive integers attains its maximum exactly at \(m=L,L+1\). Normalize \(R_n(-\rho^nz)\) by
\[
 S_{n,L}=\bigl[L^2\rho^{2L-2}\bigr]^n L^{-(L-1)}.
\]
The terms indexed by the four pairs in \(\{L,L+1\}^2\), with the Eulerian factors replaced by the leading powers in (1), sum after normalization to
\[
 z^{2L-2}Q_L(z),\qquad Q_L(z)=1-(s_L+1/L)z+s_Lz^2/(L+1). \tag{2}
\]
For fixed \(L\), replacement incurs vanishing relative error in each leading power. Both roots of \(Q_L\) are positive and distinct, since \((s_L+1/L)^2\ge4s_L/L>4s_L/(L+1)\).

## Uniform tail estimate

Let \(h_m\) denote the distance of the integer \(m\) to \(\{L,L+1\}\), and set \(h=h_A+h_B\). Successive ratios on either side of the maximum of \(m\rho^m\) give
\[
 \frac{m\rho^m}{L\rho^L}\le \exp(-h_m/(L+1)^2).
\]
On the right the first ratio is \(1-1/(L+1)^2\) and later ratios are smaller. On the left the first reverse ratio is \(1-1/L^2\) for \(L>1\), and the reverse ratios subsequently decrease.

The ratio of the nonexponential factors satisfies
\[
 \frac{L^{L-1}}{B^{A-1}}\le L^{(L-A)_++(L-B)_+}\le L^h.
\]
For \(L>1\), the convex function \(\log(L/B)\) lies below the chord joining \(B=1,L\) on \([1,L]\), hence \((L-1)\log(L/B)\le(L-B)\log L\) there. First cap \(A,B\) at \(L\) in the denominator and split the ratio at \(L^{\min(A,L)-1}\) to obtain the displayed inequality. For \(L=1\) it is immediate.

For real \(1/8\le z\le10(L+1)=Z\), or complex \(1/Z\le|z|\le Z\), one has \(|z|^{A+B-2L}\le Z^{h+2}\). There are at most \(4(h+1)\) pairs at distance \(h\) (for each one-dimensional distance there are at most two choices). The absolute contribution of all remaining cells divided by \(S_{n,L}|z|^{2L-2}\) is bounded by
\[
 4 Z^2\sum_{h\ge1}(h+1)\left(LZ e^{-n/(L+1)^2}\right)^h . \tag{3}
\]
For fixed \(L\) the same bound holds with any fixed larger \(Z\). It gives uniform convergence of \(R_n(-\rho^n z)/S_{n,L}\) to \(z^{2L-2}Q_L(z)\) on any compact annulus. Uniform convergence on a disk also follows by the maximum principle applied to the polynomial difference. Rouché's theorem on small disjoint circles about \(z_\pm\) gives one root counted with multiplicity near each. Conjugation makes each root real. On circles centered at zero with radii respectively smaller than \(z_-\), between \(z_-\) and \(z_+\), and greater than \(z_+\), Rouché gives respectively \(2L-2,2L-1,2L\) roots inside. This proves the rankings.

## A growing block of real roots

Take \(100\le L\le M_n=\lfloor\sqrt{n/(400\log n)}\rfloor\). Then \(n/(L+1)^2\ge100\log n\). Here \(Z=O(\sqrt n)\), \(LZ=O(n)\), so (3) tends to zero uniformly. In the four leading terms the relative error from (1) is \(O(n^2e^{-(n-L)/(L+1)})\), uniformly tending to zero even after multiplication by \(O(Z^2)\). The four cells occur in the matrix product once \(n\ge 2L+1\). We obtain
\[
 \frac{R_n(-\rho^n z)}{S_{n,L}z^{2L-2}}=Q_L(z)+o(1)
\]
uniformly for the indicated \(L\) and real \(1/8\le z\le Z\).

Because \(e^{-1}<s_L\le1\), the signs of \(Q_L\) at \(1/8,6,10(L+1)\) are \(+,-,+\), separated uniformly from zero. In detail the first value exceeds \(1-(1+1/L)/8\), the second is at most \(1-6/e+36/(L+1)<-1/2\), and the last equals \(1+(L+1)(90s_L-10/L)>1\). Each interval \(\rho^n[1/8,10(L+1)]\) therefore supplies two distinct negative roots in the reciprocal variable. The intervals for consecutive \(L\) are disjoint for sufficiently large \(n\) since \((\rho_{L+1}/\rho_L)^n=(1-1/(L+1)^2)^{-n}\ge n^{100}>80(L+1)\). This gives \(2(M_n-99)\) distinct strictly negative roots once \(M_n\ge100\) and the uniform error is sufficiently small. Reciprocal inversion proves the asserted lower bound for \(H_n\).

## Clusters for every fixed power

Let \(R_{n,p}\) reverse the degree-\(n\) row polynomial of \(A^p\). For fixed integers \(p,L\ge1\), the roots of \(R_{n,p}\) whose modulus ranks are \(p(L-1)+1,\ldots,pL\) are eventually simple and negative. They are \(-\rho^n(z_i+o(1))\), where \(z_1<\cdots<z_p\) are the positive roots of
\[
 Q_{p,L}(z)=\sum_{b=0}^{p}(-z)^b\rho^{\binom b2}
 e_b(\alpha_1,\ldots,\alpha_p),\qquad
 \alpha_i=L^{-(p-i)}\rho^{(i-1)(L-1)},\quad \rho=L/(L+1).
\]
Here \(e_b\) is the elementary symmetric polynomial.

Indeed a chain of deficits \(d_i\ge0\) contributes \(\prod_i E(n-\sum_{j<i}d_j,d_i)\) to the coefficient of \(w^{\sum_i d_i}\), with only admissible matrix indices retained. Write \(A_i=d_i+1\). By (1) each factor is bounded by \(A_i^{n-\sum_{j<i}d_j}\), and the quotient tends to one when the \(A_i\) are fixed. The exponential weight at \(w=-\rho^nz\) is maximized on the \(2^p\) cells \(A_i=L+\varepsilon_i\), \(\varepsilon_i\in\{0,1\}\). Normalize by \([L\rho^{L-1}]^{pn} L^{-(L-1)\binom p2}\). The remaining factor on a maximizing cell is
\[
 L^{(L-1)\binom p2}\prod_i (L+\varepsilon_i)^{-\sum_{j<i}(L-1+\varepsilon_j)}
 =\left(\prod_{i:\varepsilon_i=1}\alpha_i\right)\rho^{\binom{\sum_i\varepsilon_i}{2}}.
\]
Including the powers of \(-z\), these cells tend to \((-z)^{p(L-1)}Q_{p,L}(z)\).

For local uniformity, let \(h\) be the sum of the distances of the \(A_i\) to \(\{L,L+1\}\). The exponential penalty is at most \(e^{-nh/(L+1)^2}\), the ratio of the nonexponential factor is at most the fixed \(L^{(L-1)\binom p2}\), and the number of cells for a given \(h\) is at most \(2^p\binom{h+p-1}{p-1}\). On \(1/Z\le |z|\le Z\), \(Z\ge1\), the remaining monomial after division by \(|z|^{p(L-1)}\) is bounded by \(Z^{p+h}\). Summing these bounds shows uniform convergence on compact annuli and then, by the maximum principle, on disks.

To see the roots of \(Q_{p,L}\) explicitly separate, insert the positive \(\alpha_i\) in succession. Adding an entry \(\alpha\) replaces \(Q(z)\) by \(Q(z)-\alpha z Q(\rho z)\). Suppose the current roots \(r_1<\cdots<r_\ell\) are positive with \(r_i/\rho<r_{i+1}\). The new polynomial has a zero in \((0,r_1)\), in every \((r_i/\rho,r_{i+1})\), and in \((r_\ell/\rho,\infty)\). At \(r_i/\rho\) its sign is that of \(Q(r_i/\rho)\), namely \((-1)^i\); at \(r_i\) its sign is that of \(-Q(\rho r_i)\), also \((-1)^i\). The two extreme signs follow from the constant and leading coefficients. The degree count gives simple roots, and these intervals force the same strict \(\rho\)-separation for the new roots. Start with \(Q=1\) and then \(Q=1-\alpha_1z\). Rouché's theorem on disjoint root disks and centered modulus circles, as in (2), gives the asserted exact ranks. For \(p=1\) the extreme-root asymptotics of ordinary Eulerian rows are already known. [Durán, Asymptotic for the rightmost zeros of Bell and Eulerian polynomials](https://arxiv.org/abs/2404.03249)

## The opposite end of the ordinary square

Define $g(u)=(u-1)/\log u$ for $u>0$, with $g(1)=1$. Fix any $C>0$. For large $n$ the $\lfloor C\sqrt n\rfloor$ smallest-modulus **nonzero** roots of $H_n$ are simple and strictly negative. In increasing order of modulus they satisfy, uniformly throughout this range,
\[
 x_{n,k}=-\left(\frac{g(k)}{g(k+1)}\right)^{n+1}(1+o_C(1)).
\]
For instance the closest nonzero root is asymptotic to $-(\log 2)^{n+1}$. This end has one root at each scale for fixed $k$, whereas the reciprocal end has pairs.

Let $a_k=[x^k]H_n$ and $b_k=n!g(k)^{n+1}$ for $1\le k\le n$. Binning inequality (1) and summation in the intermediate matrix index show $a_1=n!$ and for $k\ge2$
\[
 A_n(k)-k(n+1)A_n(k-1)\le a_k\le A_n(k).
\]
The Eulerian pole expansion at a positive argument gives $A_n(k)=b_k(1+O(\exp(-c n/\log^2 n)))$ uniformly on $2\le k\le n$. In fact the leading pole is $(k-1)/\log k$, the competing ratios have moduli $\log k/|\log k+2\pi i l|$; the largest is at most $e^{-c/\log^2 n}$ and the sum of their squares is $O(\log^2 n)$. At $k=1$ the formula is exact. Since $(\log g(u))'\sim1/u$, the omitted binning correction relative to $b_k$ is $o(1)$ uniformly for $2\le k\le (C+2)\sqrt n$. Thus $a_k/b_k\to1$ uniformly on that range, and $0\le a_k/b_k\le2$ everywhere.

Put $R_i=b_{i-1}/b_i$ for $i\ge2$. The sequence $R_i$ increases: $g(u)=\int_0^1 u^s\,ds$ is positive and strictly concave for $u>0$, hence strictly log-concave. Moreover $-(\log g(u))''\sim 1/u^2$ at infinity by differentiation of the explicit formula. For any sequence $k\le C\sqrt n$, take a subsequence with $k/\sqrt n\to\tau$. If $\tau>0$, at each fixed offset the log-curvature $\log(R_{k+h+1}/R_{k+h})$ tends to $d=1/\tau^2$. If $\tau=0$, the log-curvature tends to infinity wherever the indices exist, including bounded indices by strict concavity.

On compact annuli in $z\ne0$ compare
\[
 \frac{H_n(R_{k+1}z)}{b_k R_{k+1}^{k}z^k}
 \quad\text{with}\quad
 \begin{cases}1+z,&\tau=0,\\
 \sum_{h\in\mathbb Z} e^{-d h(h-1)/2}z^h,&\tau>0.
 \end{cases}
\]
These are locally uniform limits: the reference terms at offsets 0,1 have coefficient one, and the others follow from their ratio limits. For domination, throughout the indices $2\le i\le(C+1)\sqrt n$ the reference curvatures exceed some fixed positive constant in logarithm. They give a summable Gaussian majorant times $\max(|z|,|z|^{-1})^{|h|}$ there. Beyond that range the outward term ratio is already $O(\exp(-c_C\sqrt n))$ on each compact annulus, and cannot increase by monotonicity of $R_i$. The global bound $a_i/b_i\le2$ controls the actual tail. When $k$ stays bounded the absent negative offsets have zero coefficient. By the Jacobi triple product the bilateral limit has simple zeros precisely at $z=-e^{dh}$, $h\in\mathbb Z$. In particular both limits have a single simple zero near $-1$; Rouché on its small disk and conjugation give a real simple root of relative modulus $1+o(1)$.

For the absolute rank, at the radius $s_i=\sqrt{R_iR_{i+1}}$ ($i\ge2$), normalize instead by $b_i x^i$. If $i/\sqrt n\to\tau>0$, the limiting circle function is the strictly positive theta series $\sum_{h\in\mathbb Z}e^{-d h^2/2}e^{ih\theta}$ by Poisson summation. The same tail majorant proves uniformity. If $i/\sqrt n\to0$, normalize at $s_i$ and use monotonicity: every noncentral reference term is at most $(R_i/R_{i+1})^{|h|/2}$ times the central term. Thus the circle limit is the constant 1. The argument principle gives exactly $i$ zeros including zero inside $s_i$. The annulus between $s_k$ and $s_{k+1}$ therefore contains exactly the nonzero root just located, as both ratios $s_k/R_{k+1}$ and $s_{k+1}/R_{k+1}$ are separated from 1. For $k=1$ use $s_2$ and the simple zero at the origin. The subsequence argument gives uniformity over all claimed ranks.
