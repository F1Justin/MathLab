# A real-rooted input can follow all but a sublinear number of Eulerian rows before its transform loses log-concavity

Write \(E(N,g)\) for the number of permutations of size \(N\) with \(g\) descents and put \(E(N,g)=0\) outside \(0\le g<N\). In the ordinary square the input row is \(E(n,g)\) and its image is \(\sum_g E(n,g) A_{g+1}(x)\) with \(A_j(x)=x\sum_g E(j,g)x^g\).

**Theorem.** Fix \(0<\epsilon<1\) and an integer \(K\ge0\). For every sufficiently large \(n\) there is a positive rational row \((v_g)_{0\le g<N}\) at rank \(N=\lfloor\epsilon n\rfloor\) with the following properties. Start ordinary Eulerian insertion at this row and perform *every* step through rank \(n\). At every rank from \(N\) to \(n\), both ends of the resulting row agree exactly with the true Eulerian row through index \(K\) measured from each end. The binomially normalized row polynomial is reciprocal, with only negative roots. Its root at \(-1\) has precisely the genuine multiplicity and each other root is simple. Nevertheless the Eulerian transform of the final row violates ordinary coefficient log-concavity.

In particular one can choose initial ranks \(N=o(n)\) and simultaneous matching depths \(K\to\infty\) for counterexamples at every sufficiently large \(n\). Apply the theorem successively with \(\epsilon=1/p, K=p\) for \(p=2,3,\ldots\) and choose strictly increasing rank thresholds beyond the bound for each pair. The genuine square starts with the prescribed rank-one row. Its all-rank real-rootedness remains open.

A finite instance starts at \(N=460\), with \(h=228, c=2^{225}, D=(2^{460}-461)/459-1-hc-\binom h2\) and normalized polynomial
\[
 (1+z)(1+Dz+z^2)\prod_{j=0}^{h-1}(1+(c+j)z+z^2).
\]
Both endpoints match through depth one. After 40 genuine insertion steps the reversed image coefficients satisfy \(1002a_{116}^2<1000a_{115}a_{117}<1003a_{116}^2\). The [exact checker](check_reciprocal_obstruction.py) verifies the edge at each step and the final three-coefficient inequality.

There is also a one-step obstruction even when the initial transformed row itself has only simple real roots. Use the same displayed factorization with \(N=50,\ h=23,\ c=2^{22},\ D=(2^{50}-51)/49-1-hc-\binom h2\). Both ends match the true row through depth one. Exact rational root isolation gives 50 simple real roots for the initial transform, and 49 real roots for the squarefree degree-51 transform after one genuine insertion. The same checker verifies both counts, the insertion and both cases of edge matching. This example concerns a modified input at rank 50.

## The initial data

Fix an integer \(L\ge1\), write \(\rho=L/(L+1)\), and choose \(L\) large enough that
\[
 \log(1+1/L)<\epsilon\log(1+1/K)
 \tag{1}
\]
when \(K\ge1\). Put \(h=\lfloor n^{2/3}\rfloor\), \(i=K+\lfloor h/2\rfloor\), \(r=n-N\), and
\[
 W=(L+1)\rho^{-(n-i)},\qquad
 c=\left\lfloor W\frac{i}{N-i}\frac{i-K}{h-i+K+1}
                    \left(\frac{i}{i+1}\right)^r\right\rfloor .
 \tag{2}
\]
Thus \(\log c/n\to -\log\rho>0\); integer rounding has vanishing relative effect.

Use the [matched-edge construction](matched_edge_obstruction.md) at initial degree \(N-1\) with \(h\) distinct medium reciprocal quadratic factors of parameters \(c+1,\ldots,c+h\), \(K\) large quadratic factors, and all remaining factors bounded exactly as there. Explicitly the large-factor polynomial is selected by unit triangular coefficient matching of
\[
 b_g=E(N,g)/\binom{N-1}{g},\qquad 0\le g\le K .
\]
For fixed \(g\le K\) the genuine ratios grow as \(g((g+1)/g)^N/(N-1)\). The degree-\(s\) coefficients of the product of all non-large factors and of its reciprocal power series are now \(O_K((Nc)^s)\) for \(s\le K\). By (1) the smallest prescribed large ratio exceeds \(Nc\) by an exponential factor, and successive large ratios are exponentially separated. The construction and its proof therefore still produce \(K\) distinct large parameters, all bigger than \(c\) by an exponential factor. The reciprocal normalized input \(B(z)=\sum b_g z^g\) has positive rational coefficients and the required negative root multiplicities. Let \(v_g=\binom{N-1}{g}b_g\). Preservation of both matching and multiplicities by each subsequent step is proved in (3) of the [companion note](matched_edge_obstruction.md). Also \(v_g\) is log-concave, since the coefficient sequence of \(B\) and the binomial sequence are both log-concave.

For bounded integers \(s\), the middle coefficients satisfy
\[
 \frac{v_{i+s}}{v_{i+s-1}}
  =(1+o(1))c\,\frac{N-i-s}{i+s}
                  \frac{h-i-s+K+1}{i+s-K}.
 \tag{3}
\]
Here is a direct relative-error argument despite the growing number of factors. Split each reciprocal quadratic into two real linear factors \((1+t z)(1+z/t)\), \(t>1\). There are \(K\) large positive parameters \(t\gg c\) with an exponential gap, \(h\) medium positive parameters \(t=c+O(h)\), and \(O(N)\) remaining parameters bounded by an absolute constant (including the reciprocal partners). For \(g=i+O(1)\) the contribution using all large factors and \(g-K\) medium ones is uniformly asymptotic to \((\prod t_{\rm large})\binom h{g-K}c^{g-K}\), since \((1+O(h/c))^h=1+o(1)\). If \(a\le K\) large factors are missed and \(b\ge0\) bounded ones are added, the ratio of the two binomial counts is at most \(h^{a+b}\) by the successive binomial-ratio bounds (zero for out-of-range choices). All such contributions relative to the main value are consequently bounded by \((1+o(1))\binom Ka (hc/t_{\min})^a (C N h/c)^b/b!\), with the first power omitted when \(K=0\). Summing over \(a+b>0\) gives \(o(1)\). Taking the quotient at consecutive degrees and inserting the binomial factor proves (3).

## Genuine insertion over the full interval

Denote the row reached at final rank by \(w_g\), and set \(u_g=v_g(g+1)^r\). The latter sequence is log-concave by multiplication. For each fixed \(C_0\), uniformly for \(0\le g\le i+C_0\),
\[
                         w_g=(1+o(1))u_g .                         \tag{4}
\]
Indeed (3) at \(i+C_0\) and log-concavity give \(v_{g-1}/v_g\le O(N/c)\) for every \(1\le g\le i+C_0\). In one insertion the ordinary weights satisfy
\[
 w^{(M+1)}_g=(g+1) w^{(M)}_g+(M+1-g)w^{(M)}_{g-1}.
\]
A path entering the final index \(g\) by \(d\) rises from \(g-d\) has each rise multiplier at most \(n\), each stationary multiplier at most \(g+1\), and at most \(\binom rd\) choices of rise positions. The constant-index path has weight exactly \(u_g\). Thus \(1\le w_g/u_g\le(1+O(nN/c))^r=1+o(1)\), as asserted. From (2), (3) we obtain
\[
 \frac{u_{i+s}}{u_{i+s-1}}=(1+o(1)) W\qquad(s\text{ fixed}).
 \tag{5}
\]
The only rapidly iterated factor is \(((i+s+1)/(i+s))^r\). Its ratio to \(((i+1)/i)^r\) tends to one because \(r/i^2\to0\). Formula (4) transfers (5) to the corresponding ratios of \(w\).

## The two terms in the output coefficient

By reciprocity of the final row and of each Eulerian row, the coefficient of \(y^k\) in the reversed output \(y^n\sum_g w_g A_{g+1}(1/y)\) equals
\[
 a_k=\sum_{\ell=0}^k w_{k-\ell}\,E(n-k+\ell,\ell).
\]
Take \(q=i+s\), \(s=-1,0,1\), and \(k=q+L-1\). Write \(B_q=w_q L^{n-q}\). The two terms at \(\ell=L-1,L\) are asymptotic to \(B_q\) and \(w_{q-1}(L+1)^{n-q+1}\), respectively. This uses the fixed-index estimate \(E(p,l)\sim(l+1)^p\) as \(p\to\infty\), from Eulerian inclusion-exclusion. The ratio of the second main term to the first tends to \(\rho^s\) by (5) and the definition of \(W\).

For all other indices write \(d=\ell-L+1\). If \(d\ge0\), (4) and log-concavity of \(u\) give \(w_{q-d}/w_q\le2(2/W)^d\) by (5), uniformly throughout this sum. For \(d<0\) the same bound holds with the constant \(2^d\) replaced by \(2^{|d|}\), since there are only finitely many such indices and (5) applies to every factor. Now \(E(p,l)\le(l+1)^p\) by the ordered-bin injection. Relative to \(B_q\), each old or new term has upper bound
\[
 \exp(o(n))\left(\frac{\ell+1}{L}\rho^{\ell-L+1}\right)^{n-q}
 \tag{6}
\]
with a single uniform \(o(n)\). In fact, substituting \(W=(L+1)\rho^{-(n-i)}\) leaves a multiplicative factor at most \(\exp(O((k+1)\log(k+2)))=\exp(o(n))\), since \(|q-i|\le1\) and \(0\le\ell\le k=O(n^{2/3})\). The quantity in parentheses in (6) achieves its maximum one only at \(\ell=L-1,L\), by consecutive term ratios. It tends to zero as \(\ell\to\infty\); all remaining values are therefore bounded by a fixed constant strictly below one. The total of all other terms is \(o(B_q)\).

It follows that \(a_{q+L-1}/B_q\to1+\rho^s\). The ratios of successive \(B_q\)'s at these three indices are both asymptotic to \(W/L\). For \(k=i+L-1\) we have proved
\[
                 \frac{a_{k-1}a_{k+1}}{a_k^2}
                    \ \longrightarrow\ \frac{(1+\rho)(1+\rho^{-1})}{4}>1 .
\]
The coefficient ratio is unchanged under reversal. Its strict lower bound above one also forces nonreal zeros by Newton's inequalities.

## A quantitative starting rank

For each fixed \(K\) it already suffices to take \(N=\lceil A n^{3/4}\rceil\). Choose \(D>0\) so that \(1/D<\log(1+1/K)\) when \(K\ge1\). Any constant \(A>0\) with \(A^4>256D^2\) works. In (2) set
\[
 h=\lfloor N/4\rfloor,\qquad i=K+\lfloor h/2\rfloor,
 \qquad L=\lceil Dn/N\rceil,\qquad \rho=L/(L+1).
\]
Then \(\log c\sim N/D\) and the smallest large parameter exceeds \(c\) by a factor exponential in \(N\). In particular the proof of (3) has relative error \(O(e^{-\eta N})\) for some \(\eta>0\), including at \(g=i+L+1\): the counting bound \(h^{a+b}\) remains valid there and \(g-K\) is still between \(0\) and \(h\). Consequently (4) holds to the same exponential precision uniformly for \(g\le i+L+1\), by the same ratio argument at that upper index.

Put \(\delta=r/i^2\). For fixed \(s=0,\pm1\) we have
\[
 \log\left(\frac{w_{i+s}}{w_{i+s-1} W}\right)
                 =-s\delta+o(L^{-2}).
 \tag{7}
\]
At \(s=0\), (2) cancels all displayed factors up to exponential relative error. Shifting \(i\) to \(i+s\) in the two rational factors of (3) changes their logarithms by \(O(1/N)=o(L^{-2})\). Changing the insertion factor gives
\(r\log[(1+1/(i+s))/(1+1/i)]=-sr/i^2+O(r/i^3)\), with \(r/i^3=o(L^{-2})\). This proves (7).

For the two main terms, \(E(p,\ell)/(\ell+1)^p=1+O(\exp[-\eta' n/L])\) at \(\ell=L-1,L,\ p=n-i+O(1)\). Indeed the relative error by inclusion-exclusion is at most \(\exp((p+1)e^{-p/(\ell+1)})-1\). To treat all remaining terms write \(d=\ell-L+1\), \(f(d)=(1+d/L)\rho^d\), and use
\[
 \frac{f(d+1)}{f(d)}=1-\frac{d}{(L+1)(L+d)},\qquad f(0)=f(1)=1 .
\]
For \(d\ge2\) this gives \(-\log f(d)\ge d(d-1)/(2(L+1)(L+d))\); for \(d\le-1\) it gives \(-\log f(d)\ge |d|(|d|+1)/(2L^2)\) by \(\log(1+t)\ge t/(1+t)\). Thus \(-\log f(d)\ge c_0|d|/L^2\) whenever \(d\ne0,1\), for an absolute \(c_0>0\). In the coefficient comparison on either side, log-concavity of \(u\) bounds \(u_{q-d}/u_q\) by \((2/W)^d\) for \(d\ge0\), or by \((2W)^{|d|}\) for \(d<0\), using the two ratios adjacent to \(q\). After using (4), the upper bound for each term relative to \(B_q\) is
\[
             2\exp\big(O(|d|\log n)\big) f(d)^{n-q}.
\]
This follows directly from the displayed coefficient formula, with the leftover factors \(((L+d)/(L+1))^d\rho^{(q-i)d}2^{|d|}\). All their logarithms are \(O(|d|\log n)\) on \(0\le\ell\le k\). Since \(n/L^2\gg\log n\), the collective error from other terms is smaller than any inverse power of \(n\).

Consequently \(a_{q+L-1}/B_q=1+\rho^s\exp(s\delta+o(L^{-2}))+o(L^{-2})\). The central ratio \(B_{i-1}B_{i+1}/B_i^2\) equals \(\exp(-\delta+o(L^{-2}))\). For \(k=i+L-1\), using \(\delta=O(L^{-2})\) and \(-\log\rho=L^{-1}+O(L^{-2})\), multiplication yields
\[
 \frac{a_{k-1}a_{k+1}}{a_k^2}
 = 1+\frac1{4L^2}-\delta+o(L^{-2}),\qquad
 \delta L^2\longrightarrow\frac{64D^2}{A^4}<\frac14.
\]
This proves the quantitative assertion. Diagonalizing over fixed \(K\) even permits \(K\to\infty\) with \(N=n^{3/4+o(1)}\): take a fixed allowed constant \(A_K\) for each depth and enlarge its starting threshold so that \(A_K\le n^{1/K}\).

When only the constant and leading coefficients are prescribed (\(K=0\)), an initial rank \(N=\lceil32\sqrt n\rceil\) suffices. Use \(L=1,\ \rho=1/2\) and again \(h=\lfloor N/4\rfloor,\ i=\lfloor h/2\rfloor\). There is no upper constraint on the medium parameters, and now \(\log c\sim n\log2\). The coefficient and insertion estimates still have exponentially small errors, and the same computation as (7) gives \(w_{i+s}/(w_{i+s-1}W)\to e^{-s/16}\), since \(r/i^2\to1/16\) and \(r/i^3\to0\). The other summands are exponentially small by (6) with fixed \(L\), using \(k=O(\sqrt n)\); a bounded factor per step in the log-concavity estimate suffices. Writing \(y=e^{-1/16}>15/16\), the central output ratio tends to
\[
              \frac{1/2+2y+2y^2}{4}>1 .
\]
