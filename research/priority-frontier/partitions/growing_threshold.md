# Real zeros and entire interlacing windows at growing block thresholds

Let $P_{v,j}(t)$ count ordinary set partitions of $[v]$ by the number of blocks of size at least $j$. All logarithms are natural. Put $W(x)e^{W(x)}=x$ for $x>0$.

**Main results.** For every fixed $\alpha>1/3$ and all sufficiently large $N$ depending on $\alpha$, every threshold $N^\alpha\le j\le N$ gives simple negative zeros. The proof of the power bound is in the final section. The earlier arguments also give a deformed-exponential limit at $j^2\sim\lambda N\log N$ and strict pairwise interlacing of the whole window $N-j,\ldots,N$ when $j\ge3\sqrt N\log N$. The proof leaves the boundary exponent $1/3$ open.

**Theorem.** Fix $\epsilon>0$. For all sufficiently large $N$, if $j^2\ge(\log 4+\epsilon)N\log N$ then $P_{N,j}$ has only simple negative zeros. If $j\ge3\sqrt N\log N$, all rows $P_{v,j}$, $N-j\le v\le N$, strictly interlace in the directed order, pairwise whenever both have positive degree. Here $2\le j\le N$. The window statement locates every zero, even when the degrees grow without bound.

The original problem is [Alexandersson's question](https://mathoverflow.net/questions/462360/set-partitions-with-big-blocks-real-rooted-polynomials). This result gives a two-parameter region. For fixed threshold four the [all-row interlacing theorem](interlacing_four.md) applies. The proof uses the quantitative Bell ratio of [Grunwald–Serafin, Thm. 5.2](https://arxiv.org/abs/2408.14182) and log-concavity of the factorial-normalized Bell numbers [Asai–Kubo–Kuo](https://arxiv.org/abs/math/0104137).

**Factorial-moment coordinates.** Put $b_m=B_m/m!$, with $b_m=0$ for $m<0$. Let $r_m=b_{m-1}/b_m$ for $m\ge1$. The cited results give that $r_m$ is nondecreasing and

$$r_m=W(m)(1+O(1/m)).\tag{1}$$

Indeed $B_m/B_{m-1}=e^{W(m)}+O(1/W(m))$. Set $H(z)=\sum_{h\ge0}j!z^h/(j+h)!$, $C(m,k)=[z^m]\exp(e^z-1)H(z)^k$, $S(m,k)=C(m,k)/b_m$ for $m\ge0$. Mark an unordered set of $k$ distinguished large blocks in a partition, allowing further large blocks in the remainder. This gives exactly

$$ a_{v,k}=[x^k]P_{v,j}(1+x)/v!=\frac{C(v-kj,k)}{k!(j!)^k}.$$

For $v\le 2N$, $m\le2N$, write $L=r_{2N}\sim\log N$. Nonnegative coefficients and $b_{m-h}/b_m\le L^h$ give

$$1\le S(m,k)\le H(L)^k\le(1-L/(j+1))^{-k}.\tag{2}$$

All subsequent asymptotic bounds are uniform in the indices indicated. When $j^2\ge cN\log N$ for any fixed $c>0$ and $k\le 2N/j+1$, (2) is bounded. For $j\le m\le 2N$ one has more precisely

$$\log S(m,k)= kW(m)/j+o(1).\tag{3}$$

To see this, truncate the sum over $h$ at $h=K$. Its tail is bounded by $2^{-K}H(2L)^k=O_c(2^{-K})$. For fixed $h$, (1) implies $b_{m-h}/b_m=W(m)^h(1+o(1))$. Among compositions of $h$ across $k$ factors of $H$, the terms with $h$ distinct nonzero positions contribute $\binom{k}{h}(W(m)/(j+1))^h$. The others have at most $h-1$ positions and total size $O_h((1+k)^{h-1}(L/j)^h)=o(1)$ for $h\ge1$. Thus the $h$th term equals $(kW(m)/j)^h/h!+o(1)$, including bounded $k$. The exponential series has uniformly bounded argument. First let $N\to\infty$ and then $K\to\infty$ to get (3).

**Curvature.** For an interior coefficient let $m=v-kj\ge j$ and $R_{v,k}=a_{v,k-1}/a_{v,k}$ for $k\ge1$. Then

$$\frac{R_{v,k+1}}{R_{v,k}}=\frac{k+1}{k}\prod_{i=1}^j\frac{r_{m+i}}{r_{m-j+i}}\cdot\frac{S(m,k)^2}{S(m-j,k+1)S(m+j,k-1)}.\tag{4}$$

If $m\ge2j$ the last factor is $\exp(o(1))$ by (3): $W(m+j)-W(m-j)\le\log 3$ by $W'(x)\le1/x$, and $k/j=O(1/\log N)$. Each log-ratio in the product is at least

$$ \frac{j}{(m+j)(1+W(m+j))}-O(1/m) $$

by (1) and $(\log W(x))'=1/[x(1+W(x))]$. The relative error is $O((1+\log N)/j)=o(1)$. Thus when $v\le N$, the product in (4) is at least $\exp((1-o(1))j^2/[N(1+W(N))])$. For $j\le m<2j$ use just the indices $j/2<i\le j$. Their denominator indices are at least $j/2$, their numerator indices at most $3j$, so their log-ratios are $\gg1/\log(3j)$ by the same derivative and (1). Other factors in the product are $\ge1$. The $S$ factor is bounded below by a positive constant by (2). Hence in this second case $\log(R_{v,k+1}/R_{v,k})\gg j/\log(3j)$, which dominates $\log N$.

These estimates give $R_{v,k+1}/R_{v,k}>4$ in the first range of the theorem, for $v\le N$. At $x=-\sqrt{R_{v,k}R_{v,k+1}}$ the $k$th term of the shifted polynomial controls the sign: the two immediate neighbors together have modulus less than that of this term and the rest on each side alternate with decreasing magnitudes. Including $x=0$ and the sign at $-\infty$ gives a sign change for every degree. Translating $x$ back to $t=1+x$ preserves simplicity and realness, and $P_{v,j}(t)>0$ for $t\ge0$. Degree zero and one follow directly.

**How the individual zeros move.** In the second range of the theorem (4) gives $R_{v,k+1}/R_{v,k}\ge N^4$ for every interior $k$, $v\le N$, once $N$ is sufficiently large. The positive magnitudes $z_{v,k}$ of the zeros in the shifted $x$ coordinate, indexed from smallest to largest, satisfy

$$z_{v,k}=R_{v,k}(1+O(N^{-4})).\tag{5}$$

Indeed at $x=-R_{v,k}(1\pm 8N^{-4})$ the central terms $k-1,k$ have opposite signs and mismatch by $8N^{-4}$ times the $(k-1)$st magnitude. Each outer tail starts below $2N^{-4}$ times that magnitude and decays geometrically. These disjoint brackets supply all roots, including the endpoints $k=1,\lfloor v/j\rfloor$.

For rows $v,v+1\le 2N$ with $v-kj=m\ge0$, put $M=m+j$, $h_0=\lfloor j/2\rfloor$. The lower bound

$$ C(m+1,k)/C(m,k)\ge1/r_{m+1} $$

follows termwise by monotonicity of the Bell ratios. In $C(M+1,k-1)$ retain first the terms with $h\le h_0$ coming from $H^{k-1}$. Their sum is at most $C(M,k-1)/r_{M+1-h_0}$. The remaining terms are at most $b_{M+1}2^{-h_0}H(2L)^{k-1}$. Dividing and using $C(M,k-1)\ge b_M$ gives

$$\frac{R_{v+1,k}}{R_{v,k}}\le \frac{r_{m+1}}{r_{M+1-h_0}}+O(2^{-h_0})\le1-\Omega\!\left(\frac{j}{N\log N}\right).\tag{6}$$

For the last bound integrate $(\log W)'$ over the last $\lfloor j/4\rfloor$ steps below $b=M+1-h_0$. Monotonicity permits replacing $m+1$ by $b-\lfloor j/4\rfloor$, which is at least a fixed fraction of $b$. The (1) errors are $O(1/b)$, while the integrated increase is $\gg j/[b(1+\log b)]$. This also handles $m=0$.

For a full step $j$ the residual index is the same for $(v,k)$ and $(v+j,k+1)$. For any $m$ in range one has $1\le C(m,k+1)/C(m,k)\le H(L)$: the second inequality follows by convolving with $H$ and comparing $C(m-h,k)\le L^h C(m,k)$ termwise. Thus

$$\frac{R_{v+j,k+1}}{R_{v,k}}=\frac{k+1}{k}\frac{C(m+j,k)/C(m+j,k-1)}{C(m,k+1)/C(m,k)}\ge(1+1/k)(1-L/(j+1))\ge1+\frac1{2k}.\tag{7}$$

The last inequality uses $(k+1)L/j=o(1)$ in this range. For $v<w\le v+j$ compare $R_{w,k}$ with $R_{v,k}$ by (6), and $R_{w,k+1}$ with $R_{v+j,k+1}$ by the same monotonicity whenever index $k+1$ exists in row $w$. The gaps in (6) and (7) dominate the bracket widths in (5). Therefore $z_{w,k}<z_{v,k}<z_{w,k+1}$ whenever the respective indices exist. The first inequality also holds for the final common index when degrees are equal. Since the degrees differ by at most one, this proves strict directed interlacing throughout the window.

## Removing the coefficient-ratio cutoff

**Strengthened theorem.** For every fixed $c>0$, all sufficiently large $N$ and all $j$ with $c\sqrt{N\log N}\le j\le N$, every zero of $P_{N,j}$ is simple and negative. The stronger interlacing hypothesis above is unchanged. At the scale $j^2/(N\log N)\to\lambda\in(0,\infty)$ the small-index zeros in factorial-moment coordinates converge after rescaling to the zeros of a deformed exponential.

Here are the details giving uniformity even when the factor $c$ is small. By subsequences the only additional regime to consider is $j^2/(N\log N)\to\lambda\in(0,\infty)$. Write $a_k=a_{N,k}$, $D=\lfloor N/j\rfloor$, $R_k=a_{k-1}/a_k$ and $q_k=R_{k+1}/R_k$. From (3)–(4) the following limits hold.

* Uniformly over $1\le k<D$, $q_k\ge q_*>1$ for all sufficiently large $N$. One may take $q_*=e^{\lambda/2}$.
* For fixed $k$, $q_k\to(1+1/k)e^\lambda$. If $k\to\infty$ and $m=N-kj$ has $m/N\to\beta>0$, then $q_{k+h}\to e^{\lambda/\beta}$ for each fixed integer $h$. Indeed all indices in the product of (4) are $m+O_h(j)\sim\beta N$, so integration of $(\log W)'$ gives $j^2/[m(1+W(m))](1+o(1))$, with additional error $O(j/m)=o(1)$. Also $(k+h+1)/(k+h)\to1$ and the $S$ factor tends to 1.
* For $m/N\to0$ and $k<D$, $q_k\to\infty$. For $m\ge2j$ this follows from the same lower bound in (4) with $m+j$ in the denominator. For $m<2j$ it is the preceding half-product estimate.

Let $s_k=\sqrt{R_k R_{k+1}}$ for $1\le k<D$. On the circle $x=s_k e^{i\theta}$ divide $\sum a_l x^l$ by $a_k x^k$. Its Fourier coefficient of index $h$ is $w_h=a_{k+h}s_k^h/a_k$ (zero outside the row), and $w_0=1$, $w_{-1}=w_1=q_k^{-1/2}$. The ratio bounds give

$$ 0\le w_h\le q_*^{-h^2/2} $$

on either side by successive multiplication. For any sequence $k\to\infty$ in the interior, extract a subsequence on which $m/N\to\beta$. If $\beta=0$, both nearest coefficients vanish and so do all other $w_h$ for $h\ne0$ by the ratio bounds. If $\beta>0$, both $k$ and $D-k$ diverge. Each fixed coefficient tends to $\exp(-\lambda h^2/(2\beta))$. Uniform convergence of the circle functions follows from the Gaussian majorant. In the second case their limit is strictly positive at every real angle, since for $d=\lambda/\beta>0$ Poisson summation gives

$$ \sum_{h\in\mathbb Z}e^{-dh^2/2}e^{ih\theta}=\sqrt{2\pi/d}\sum_{r\in\mathbb Z}\exp[-(\theta-2\pi r)^2/(2d)]>0. $$

In the first case the limit is the constant 1. Thus along any sequence $k\to\infty$ the normalized circle map eventually stays in the open right half-plane (otherwise take a contradicting subsequence). It has winding zero. The argument principle counts exactly $k$ zeros strictly inside $|x|=s_k$, none on its boundary. Consecutive such circles trap one zero counted with multiplicity. Complex conjugation and positivity of the coefficients make it simple and negative.

For bounded $k$ the correct endpoint model differs from the bilateral one. From the fixed-index ratio limits and $R_1=a_0/a_1$ we get, uniformly on compact subsets of the complex plane,

$$\frac{1}{a_0}\sum_k a_k R_1^k z^k\longrightarrow \sum_{k\ge0}e^{-\lambda k(k-1)/2}\frac{z^k}{k!}.$$

Indeed $a_kR_1^k/a_0\le q_*^{-k(k-1)/2}$ gives uniform domination. All zeros of this deformed exponential are simple and negative for $0<e^{-\lambda}<1$. [Wang–Zhang, *Zeros of the deformed exponential function*](https://arxiv.org/abs/1709.04357). On any fixed disk with zero-free boundary, Rouché's theorem first counts the zeros and then isolates them in disjoint small conjugation-invariant disks centered on the individual limiting zeros. This proves eventual simplicity and reality of every zero in that disk. It also gives convergence of each fixed-index zero in these coordinates.

For completeness, suppose infinitely many rows had a bad zero. Identify the annulus containing its modulus, using the ordered $s_k$ and adding 0 and infinity at the ends. If its lower index stays bounded, the upper radius divided by $R_1$ stays bounded by the fixed-index limits, and the endpoint argument excludes a bad zero. If its lower index tends to infinity, the two circle counts differ by one (use the degree $D$ at the exterior endpoint), and the annulus contains exactly one simple real zero. The same circle argument excludes boundary zeros at growing index. These cases exhaust all subsequences. Translation back to $t$ and positivity on $t\ge0$ finish the proof.

## Log-concavity at every threshold and a count below the critical scale

**Proposition.** At every $2\le j\le v$, the sequence $k!a_{v,k}$ is log-concave in $k$. Thus $q_{v,k}\ge(k+1)/k$ at every interior index. If $j/\sqrt N\to C\in(0,\infty)$, the lower limit of the fraction of all zeros of $P_{N,j}$ that are simple and negative is at least
$$
 \min\{1,C^2/\pi^2\}.
$$
In particular that fraction tends to 1 for $C\ge\pi$.

For the first assertion let $c_i=i![t^i]P_{v,j}(t)/v!$, extended by zero. This is log-concave with interval support by the [coefficient inequalities for the original rows](../../../snapshot/research/partitions/coefficient_ladder.md). Translation gives $k!a_{v,k}=\sum_{h\ge0}c_{k+h}/h!$ for $k\ge0$. This is the convolution of $c$ with the reflected sequence $1/h!$ on nonpositive indices, hence log-concave. Indeed both Toeplitz matrices have nonnegative order-two minors, and Cauchy–Binet preserves these for their product. All relevant sums are finite since $c$ has finite support.

For the zero count write $D=\lfloor N/j\rfloor$. Fix constants $0<\gamma_0<\gamma_1<\min(1,C^2/\pi^2)$, and consider the consecutive indices with $\gamma_0\le (N-kj)/N\le\gamma_1$. Here both $m=N-kj$ and $N-m$ are comparable to $N$. For any fixed $A>0$ and $|h|\le A\log N$, the following estimate is uniform:
$$
 \log q_{k+h}=d+O_A(N^{-1/2}),\qquad d=\frac{j^2}{m(1+W(m))}. \tag{8}
$$
First, uniformly for $M\asymp N$ and $K\ll\sqrt N$, one has
$$
 \log S(M,K)=K\log H(W(M))+O(\log^2 N/N). \tag{9}
$$
Truncate the coefficient sum defining $S$ and the series for $H(W(M))^K$ at excess $B\log N$. Their tails are $\le2^{-B\log N}H(2L)^K\ll N^{-5}$ when $B$ is sufficiently large, since $K L/j=O(\log N)$. Up to the cutoff, (1) gives $b_{M-i}/[b_M W(M)^i]=\exp(O(\log^2 N/N))$, by summing the errors and integrating $(\log W)'$. Both untruncated sums have constant term 1. This proves (9). For arguments $z\le L$, $0\le(\log H)'(z)\le (1-z/(j+1))^{-2}/(j+1)$ by the coefficient bounds. Hence the logarithm of the $S$ factor in (4) is $O(N^{-1/2})$ by (9) and $|W(M\pm j)-W(M)|=O(j/N)$. The change of $K$ to $K\pm1$ cancels in the constant term of this difference. In the Bell product each logarithmic ratio has the integral of $(\log W)'$ over length $j$, with additive error $O(1/N)$ from (1). All arguments are $m+O_A(j\log N)$; the logarithmic derivative of $1/[m(1+W(m))]$ is $O(1/N)$ in this range. Thus the Bell product's logarithm is $d+O_A(N^{-1/2})$. Also $1/k=O(N^{-1/2})$. This proves (8).

On $|x|=s_k=\sqrt{R_kR_{k+1}}$, write $w_h$ for the normalized Laurent coefficients as above. For $|h|\le J=\lceil A\log N\rceil$, successive multiplication using (8) gives
$$
 w_h=\exp(-d h^2/2)\exp(O_A((1+h^2)/\sqrt N)).
$$
Their total absolute difference from the Gaussian coefficients is $O_A(\log^3 N/\sqrt N)$. Choose $A$ large enough that $\exp(-dJ^2/2)\ll N^{-3}$ uniformly. Beyond either cutoff the successive outward ratios are at most $\exp(-dJ/2)$ for all large $N$, since (8) gives this at the cutoff and global log-concavity prevents a subsequent increase. Thus the summed polynomial tails are $O(N^{-3})$, as are the Gaussian tails. Poisson summation bounds the Gaussian series below for every angle by $\sqrt{2\pi/d}\exp(-\pi^2/(2d))$. Since $m/N\le\gamma_1<C^2/\pi^2$, this lower bound exceeds $N^{-1/2+\eta}$ for some fixed $\eta>0$ and all sufficiently large $N$. It dominates the absolute error. The circle map lies in the open right half-plane and the number of zeros inside is $k$. Each consecutive annulus therefore contains one simple negative real zero. These indices span $(\gamma_1-\gamma_0)D+O(1)$ roots, and taking the supremum over the two fixed constants proves the claimed lower limit.

## All roots beyond a constant times the square-root scale

**Theorem.** For every fixed $\epsilon>0$, if $(\pi+\epsilon)\sqrt N\le j\le N$ and $N$ is sufficiently large depending on $\epsilon$, all zeros of $P_{N,j}$ are simple and negative.

It suffices to treat $(\pi+\epsilon)\sqrt N\le j\le2\sqrt{N\log N}$ by (4) and the first theorem. Throughout this range the proof of (9) gives, uniformly for $M\ge j$, $M\le2N$, $K\le 2N/j+1$,
$$
 \log S(M,K)=K\log H(W(M))+O(\log^2 N/M). \tag{10}
$$
Indeed $KL/j=O(\log N)$ uniformly, $M\gg\log N$, and the finite Bell-ratio comparison up to excess $B\log N$ has logarithmic error $O(\log^2N/M)$. For $m\ge2j$, the logarithm of the $S$ factor in (4) is consequently $O((k+1+\log^2N)/m)$, using $|W(m\pm j)-W(m)|=O(j/m)$ and $(\log H)'=O(1/j)$. This error is $o(j^2/[(m+j)(1+W(m+j))])$ since $k=O(\sqrt N)$. For $j\le m<2j$, the crude bound (2) now contributes only $O(\log N)$ in the logarithm, dominated by the Bell half-product $\gg j/\log(3j)$. It follows that for $m=N-kj\le m_0=j^2/(20\log N)$, $1\le k<D$, we have $q_k>9$ eventually. In the case $m\ge2j$ here one can use $m+j\le(3/2)m$ and $1+W(m+j)\le (1+o(1))\log N$ in (4). On the midpoint circle at $s_k$, global monotonicity of all $R_i$ implies $w_h\le q_k^{-|h|/2}$. The sum off index zero is at most $2/(\sqrt{q_k}-1)<1$; there are exactly $k$ roots inside this circle.

For the remaining indices $m>m_0$ fix
$$
 d=\frac{j^2}{m(1+W(m))},\qquad J=\lceil A\log N\log\log N\rceil.
$$
Here $d$ is bounded above by an absolute constant (as $m_0\gg N/\log N$) and $d\ge((\pi+\epsilon)^2+o(1))/\log N$. Uniformly for $|i-k|\le J+1$, $1\le i<D$, we have
$$
 \log q_i=\log(1+1/i)+d+O_A(N^{-1/2}\log^5 N). \tag{11}
$$
Indeed all Bell ratio arguments are within $O(jJ)$ of $m\gg N/\log N$. Replacing the integrand $(\log W)'$ by its value at $m$ costs $O(djJ/m)$ in the sum of the $j$ integrals, and (1) costs $O(j/m)$. Formula (10) costs $O((k+J+\log^2 N)/m)$ in the logarithm. Each is bounded by the error in (11). The distance $D-k\gg N/(j\log N)$ is larger than $J+1$; to the left both actual and reference coefficients start at index zero.

**Reference circles.** For $d>0$, let
$$
 E_d(z)=\sum_{i\ge0}e^{-di(i-1)/2}\frac{z^i}{i!}.
$$
Write its negative zeros as $-\rho_i$, with $0<\rho_1<\rho_2<\cdots$. It has order zero and its simple negative zeros give the product $E_d(z)=\prod_i(1+z/\rho_i)$. The identity $E_d'(z)=E_d(e^{-d}z)$ and strict interlacing of a genus-zero real-rooted function with its derivative give $\rho_{i+1}>e^d\rho_i$. Indeed the logarithmic derivative is strictly decreasing between consecutive zeros and has no zero to the right of its largest zero, so the successive derivative zeros are precisely the interstitial ones. These properties also hold after a positive rescaling of the variable. At the circle with radius $r=\sqrt{\rho_k\rho_{k+1}}$,
$$
 \min_{|z|=r}\frac{|E_d(z)|}{E_d(r)}
 =\prod_{i\ge1}\frac{|r-\rho_i|}{r+\rho_i}
 \ge\prod_{p\ge0}\tanh((p+1/2)d/2)^2
 \ge \exp[-\pi^2/(2d)]. \tag{12}
$$
The first inequality uses geometric spacing on both sides of $r$. For the second, $g(y)=\log\tanh(y/2)$ has derivative $1/\sinh y$ and hence is concave for $y>0$. Its midpoint value on each interval of length $d$ majorizes its average. Integrating the series for $\log(1-e^{-y})-\log(1+e^{-y})$ gives $\int_0^\infty g(y)\,dy=-\pi^2/4$.

If $b_i$ are the coefficients of a positive rescaling of $E_d$ and $\tilde R_i=b_{i-1}/b_i$, their root moduli satisfy
$$
 (1-e^{-d})\tilde R_i\le\rho_i\le\tilde R_i/(1-e^{-d}). \tag{13}
$$
Indeed $b_i$ are the elementary symmetric functions of the inverse roots (or a common constant times these). Removing the largest index in each $i$-tuple gives $b_i\le b_{i-1}\sum_{l\ge i}\rho_l^{-1}$. Extending each $(i-1)$-tuple by one missing index $l\le i$ gives $b_{i-1}\le b_i\sum_{l\le i}\rho_l$. Geometric spacing bounds the two sums.

**Local comparison.** Choose the positive rescaling of $E_d$ so that $\tilde R_k=R_k$, and multiply it by a positive constant to make $b_k=a_k$. Write this reference function as $F$. Its ratios of consecutive $\tilde R_i$ are exactly $(1+1/i)e^d$. Let $r$ be its $k$th root midpoint as in (12). By (13),
$$
 (C_1\log N)^{-1}\le r/R_k\le C_1\log N
$$
for an absolute $C_1$ depending at most on $\epsilon$, since $d$ is bounded above and $1-e^{-d}\gg1/\log N$. For $|h|\le J$ with $k+h\ge0$, successive multiplication of (11) and the anchored equalities at $k$ gives $a_{k+h}/b_{k+h}=1+O_A(N^{-1/2}\log^9 N)$. This estimate is relative to the individual coefficient, so the bound on the sum of the absolute discrepancies at radius $r$ in this range is $O_A(N^{-1/2}\log^9N)F(r)$.

Here both tails can be controlled even when $r$ is much larger or smaller than $R_k$. In the local window, both sets of log-curvatures are at least $d/2$ by (11). For $|h|=J$ the term relative to the central magnitude $a_kr^k=b_kr^k$ is thus at most
$$
 (C_1\log N)^J\exp[-dJ(J-1)/4]\le N^{-4}
$$
on taking the fixed $A$ large enough; if the lower cutoff is outside support its tail is empty. The next outward ratios are at most $(C_1\log N)\exp[-d(J-1)/2]<1/2$ eventually. Global monotonicity of both sets of coefficient ratios now bounds all further outward ratios by $1/2$. Since $F(r)\ge b_kr^k$, the sum of both functions’ tails is $O(N^{-4})F(r)$. We have proved
$$
 \max_{|z|=r}\left|\sum_i a_iz^i-F(z)\right|
 \ll_A (N^{-1/2}\log^9 N+N^{-4})F(r).
$$
By (12), $\min_{|z|=r}|F(z)|/F(r)\ge N^{-\pi^2/(2(\pi+\epsilon)^2)+o(1)}$, strictly larger than this relative error for large $N$. Rouché gives exactly $k$ polynomial zeros inside this circle and no zeros on it.

We have a zero-free circle with count $k$ for every $1\le k<D$, using the two constructions for their respective ranges. Its radius is strictly increasing with $k$ because the counts increase. Include the origin and the outermost region where the count totals $D$. Every resulting annulus contains just one simple zero; reality follows by conjugation, and negative sign by positivity of the coefficients. Translating back gives the stated result. This argument does not give an interlacing statement between two different rows at the square-root scale.

## A power bound by local analytic interpolation

**Theorem.** Fix $\alpha>1/3$. For all sufficiently large $N$ depending on $\alpha$ and all $N^\alpha\le j\le N$, every zero of $P_{N,j}$ is simple and negative. In particular the result covers $j\ge\sqrt N/(\log N)^A$ for each fixed $A\ge0$.

By nesting the ranges it suffices to prove this for $1/3<\alpha<1/2$. The elementary large-ratio theorem disposes of $j>2\sqrt{N\log N}$. Put $a=\log_N j$, $v=(1-2a)_+$ and $\delta=\min((\alpha-1/3)/100,1/1000)$, where $y_+=\max(y,0)$. In the remaining range $\alpha\le a\le 1/2+o(1)$, $v<1/3$, $k\le D=\lfloor N/j\rfloor\le N^{1-a}$ and $L=r_{2N}=O(\log N)$. Constants may depend on $\alpha$.

**Large-curvature end.** In (10), use the cutoff $B=\lceil N^{v+\delta}\rceil$. For $j\le M\le2N$ and $K\le D+1$, $\log H(2L)^K=O(N^v\log N)$. The cutoff tails are bounded by $2^{-B}H(2L)^K\le\exp(-cB)$. We have $B=o(j)$ with a uniform power saving, since $a-v\ge\min(3\alpha-1,\alpha)>\delta$. Thus $B=o(M)$. Formula (1) gives
$$
 e^{-O(B^2/M)}\le \frac{b_{M-i}}{b_M W(M)^i}\le e^{O(B^2/M)}
 \qquad(0\le i\le B).
$$
Indeed the logarithmic error is $O(B/M+B^2/M)$ by summing (1) and integrating $(\log W)'$ over indices in $[M-B,M]$. The truncated sums for $S(M,K)$ and $H(W(M))^K$ therefore differ by at most these multiplicative factors. Each truncated sum is at least 1, so restoring either tail changes the logarithm by $O(e^{-cB})=o(B^2/M)$. This gives $\log S(M,K)=K\log H(W(M))+O(B^2/M)$ even when $B^2/M$ grows. If $m=N-kj\ge2j$, the $S$ factor in (4) contributes $O((k+1+B^2)/m)$ to its logarithm. This is $o(j^2/[(m+j)(1+W(m+j))])$, since $k=O(N^{1-a})$, $1-a<2a$ uniformly, and $B^2=o(j^2/\log N)$. If $j\le m<2j$, the half-product contribution $\gg j/\log(3j)$ dominates the cruder log cost $O(N^v\log N)$ from (2). Consequently $q_k>9$ for every interior $k$ with $m\le m_0=j^2/(20\log N)$, as before. Such an index already has a circle containing exactly $k$ zeros.

**Analytic interpolation near an index.** For $m>m_0$ put $b=\log_N m$, $u=(b-2a)_+$ and $d=j^2/[m(1+W(m))]$. Then $2a-\delta\le b\le1$, $0\le u\le v$ and, uniformly for large $N$,
$$
 N^{-u-\delta/4}\le d\le32.
$$
The upper bound follows from $m>m_0$ and $1+W(m)\ge (2/3-o(1))\log N$, using $m> N^{2\alpha}/(20\log N)$.

Choose the local scales
$$
 p_0=u+2\delta,\qquad t'=u+6\delta,\qquad t=t'+v/2+3\delta,\qquad
 R'=N^{t'},\quad R=N^t .
$$
They satisfy $t+\delta<\min(b-a,1-a)$. Indeed $b-a-u\ge a-\delta$ by $b\ge2a-\delta$, while $v/2\le1/6$. Also $u\le v$ gives $1-a-t\ge1-a-3v/2-9\delta$. When $a\le1/2$ the latter is $2a-1/2-9\delta$, and when $a>1/2$ it is $1-a-9\delta$. Both exceed $\delta$ uniformly. Two other uniform inequalities drive the proof:
$$
 3a+3t'-2b\le
 \begin{cases}
 1-3\alpha+18\delta,& b\ge2a,\\
 -a+20\delta,& b<2a,
 \end{cases}
 \qquad v+\delta+2(t'-t)=-5\delta .
$$
Indeed, in the first case the left side equals $b-3a+18\delta$. Both right sides of the piecewise bound are strictly negative by a margin depending only on $\alpha$.

For a complex variable $s$ with $|s|\le R$ put $M=m-js$, $K=k+s$, $r=W(M)$ on the continuation of the positive branch and $T(M)=e^r-1-M\log r$. The branch is analytic here. For example solve $r+\log r=\log M$ as
$r=W(m)+(\log M-\log m)-\log(r/W(m))$ by contraction in $|r-W(m)|\le 2|\log M-\log m|$ when $M\ne m$, and use the analytic implicit function theorem. Thus $r=W(m)+O(jR/m)$ and $\operatorname{Re}r\asymp\log N$. All logarithms below use the branches continuous from the real axis. In particular $|H(z)-1|=O(\log N/j)$ for $|z|\le2\log N$ by its defining series, so its principal logarithm exists there.

Define
$$
 C_*(s)=\frac{e^{T(M)}H(r)^K}{2\pi}
 \int_{-\pi}^{\pi}\exp\left(e^{r e^{i\theta}}-e^r-iM\theta
            +K[\log H(re^{i\theta})-\log H(r)]\right)\,d\theta .
$$
It is analytic throughout this disk. At integral $s$ with $K,M$ nonnegative integers it equals $C(M,K)$ by Cauchy's coefficient formula. The integral has the following uniform approximation across the complex disk:
$$
 C_*(s)=e^{T(M)}H(r)^K[2\pi M(1+r)]^{-1/2}(1+o(1)). \tag{14}
$$
Here $\operatorname{Re}[M(1+r)]\asymp m\log N$ and the square root is taken from its value at $s=0$. To prove (14), put $\theta_0=m^{-1/2}N^{2\delta}$. For $|\theta|\le c/\log N$ with sufficiently small fixed $c>0$, the exponent without the $H$ term has expansion
$$
 -M(1+r)\theta^2/2+O(m(\log N)^2|\theta|^3).
$$
The vanishing of its linear term is the saddle identity $re^r=M$. The bound on the third derivative follows by differentiating $e^{re^{i\theta}}$ three times, using $|e^{re^{i\theta}}|=O(e^{\operatorname{Re} r})$ there. For $|\theta|\le\theta_0$, the cubic remainder is $O(N^{-b/2+6\delta}\log^2N)=o(1)$ uniformly. Throughout the circle,
$$
 \big|K[\log H(re^{i\theta})-\log H(r)]\big|
 \ll N^{v+\delta}|\theta|,
$$
by integrating the derivative along the arc, since $|(\log H)'|=O(1/j)$. In particular the perturbation is $o(1)$ for $|\theta|\le\theta_0$, because $b/2\ge a-\delta/2$ and $a-v\ge\min(3\alpha-1,\alpha)>4\delta$. The integrated error is $o((m\log N)^{-1/2})$ by Gaussian domination. Extending the complex Gaussian to the real line gives $\sqrt{2\pi/[M(1+r)]}$ with exponentially small cutoff error. For $\theta_0<|\theta|\le c/\log N$ the quadratic decay is at least a constant times $m\log N\,\theta^2$, which dominates $N^{v+\delta}|\theta|$ since $m\theta_0=N^{b/2+2\delta}$. The absolute integral over this arc is $O(\exp(-c_1 N^{4\delta}\log N))$.

For clarity, on the entire remaining arc $c/\log N\le |\theta|\le\pi$,
$$
 \operatorname{Re}(r e^{i\theta})\le \operatorname{Re} r-c'/\log N.
$$
Indeed $1-\cos\theta\ge2\theta^2/\pi^2$ there, and $|\operatorname{Im}r|=O(jR/m)=o(1/\log N)$. Consequently
$\operatorname{Re}(e^{r e^{i\theta}}-e^r)\le-c''m/(\log N)^2$ using $\operatorname{Re}(e^r)=e^{\operatorname{Re}r}\cos(\operatorname{Im}r)$ and $e^{\operatorname{Re}r}\asymp m/\log N$. Even $\pi|\operatorname{Im}M|=O(jR)$ and $O(N^{v+\delta})$ from $H$ are smaller than this loss, using $a+t<b-\delta$. This proves (14), including the arc near $\pm\pi$.

In particular $\log C_*(s)=T(M)+U(s)$ with $U$ analytic and $|U|=O(N^{v+\delta})$ on the disk: choose the logarithm using (14), the explicit term $K\log H(r)$, and $-\frac12\log(2\pi M(1+r))$. The interpolation is real and positive near real $s=0$, by conjugation of the integral and (14). Now
$$
 T'(M)=-\log W(M),\qquad T''(M)=-1/[M(1+W(M))],\qquad T'''(M)=O(1/[m^2\log N])
$$
on this disk. With $S=(\log C_*)'(0)\in\mathbb R$, define
$$
 V(s)=\log C_*(s)-\log C_*(0)-Ss+ds^2/2 .
$$
On $|s|\le R'$, the third-order Taylor remainder from $T$ is $O(j^3(R')^3/(m^2\log N))=o(1)$ by the bound on $3a+3t'-2b$. The remainder from $U$ after its constant and linear terms is $O(N^{v+\delta}(R'/R)^2)=O(N^{-5\delta})$ by Cauchy's estimates. Therefore $\Phi(s)=e^{V(s)}$ has $\Phi(0)=1$ and $\sup_{|s|\le R'}|\Phi(s)-1|=o(1)$ uniformly.

**Perturbed comparison on the root midpoint.** Let $F$ be a positive constant times a positive rescaling of $E_d$, chosen so its coefficients $b_i$ satisfy
$$
 b_k=a_k,\qquad \frac{b_{k+h}}{b_k}
 =\frac{k!}{(k+h)!}(j!)^{-h}\exp(Sh-dh^2/2).
$$
Indeed the required argument scaling is $\exp(S+d(k-1/2))/j!$. For integral $|h|\le R'$ in the coefficient range this gives the **exact** identity $a_{k+h}/b_{k+h}=\Phi(h)$ using the factorial-moment coefficient formula; no approximation of the factorial is involved. In particular the true and reference ratios at $k$ differ by $1+o(1)$. Let $r_*$ be the reference midpoint between root moduli $\rho_k,\rho_{k+1}$. Equations (12)–(13) give
$$
 |\log(r_*/\tilde R_k)|=O(\log N),\qquad
 |F(z)|/F(r_*)\ge \exp[-\pi^2/(2d)]\quad(|z|=r_*),
 \qquad \tilde R_k=b_{k-1}/b_k .
$$

Write $\mathcal D=z\,d/dz$ and let $M_d=C(1+1/d)\log(2+1/d)$ with an absolute, sufficiently large $C$. For every integer $p\ge1$ and $|z|=r_*$,
$$
 |(\mathcal D-k)^p F(z)|\le [e\max(p,M_d)]^p |F(z)|. \tag{15}
$$
We prove this by controlling the product directly. In $e^{-kw}F(ze^w)/F(z)$ assign one factor $e^{-w}$ to each root of modulus $\rho_i<r_*$. Write $Z_i=z/\rho_i$. For $i\le k$ the resulting factor differs from 1 by $(e^{-w}-1)/(1+Z_i)$. For $i>k$ the difference is $(e^w-1)Z_i/(1+Z_i)$. At the $l$th successive root on either side, starting with $l=0$, the absolute log-distance of $\rho_i$ from $r_*$ is at least $(l+1/2)d$. Each difference is therefore at most $e|w|/(e^{(l+1/2)d}-1)$ whenever $|w|\le1$. By splitting the sum at $l=1/d$, using $e^y-1\ge y$ for the first range and a geometric tail for the rest,
$$
 2e\sum_{l\ge0}(e^{(l+1/2)d}-1)^{-1}\le M_d.
$$
The inequality $|1+y|\le e^{|y|}$ gives $|e^{-kw}F(ze^w)/F(z)|\le\exp(M_d|w|)$ on the unit disk in $w$, including points where its numerator vanishes. Taking the Cauchy radius $\min(1,p/M_d)$ and using $p!\le p^p$ proves (15). The lower bound on $d$ implies $M_d=O(N^{u+\delta/2})$.

Set $J=P=\lceil N^{p_0}\rceil$, and truncate the Taylor expansion of $\Phi$ to $Q(s)=\sum_{l=0}^P q_ls^l$. Then $q_0=1$, $|q_l|\le2(R')^{-l}$. By (15),
$$
 |Q(\mathcal D-k)F(z)-F(z)|/|F(z)|
 \le 2\sum_{l=1}^P (e\max(P,M_d)/R')^l=o(1)
$$
on the reference circle, since $\max(P,M_d)/R'\ll N^{-4\delta}$. For $|h|\le J$ the absolute Taylor error is $O((J/R')^{P+1})$. Summing the central coefficient errors between the true polynomial and $Q(\mathcal D-k)F$ on the circle costs at most $O((J/R')^{P+1})F(r_*)$.

Both outer tails are negligible relative to the circle minimum. For the reference function global curvature is at least $d$. At $|h|\ge J$ its positive-radius term relative to $b_k r_*^k$ is bounded by
$$
 \exp(O(|h|\log N)-d|h|(|h|-1)/2)\le\exp(-d h^2/3).
$$
Here $dJ\ge N^{7\delta/4}$, and the negative side terminates at $h=-k$. Multiplication by $|Q(h)|\le 2(P+1)\max(1,(|h|/R')^P)$ increases this bound to at most $\exp(-d h^2/4)$ eventually: at $|h|\ge J$ the ratio $dh^2/[P\log(2+|h|)]$ tends uniformly to infinity. The sum of these weighted tails is $O(e^{-dJ^2/5})F(r_*)$ by geometric summation. For the true polynomial, at any present cutoff $h=\pm J$ the ratio to the reference term is $1+o(1)$, also at its next inward neighbor. The reference ratio of successive outward terms at that cutoff is at most $\exp(O(\log N)-d(J-1))=o(1)$; hence the same is true for the actual outward ratio to that cutoff. Global log-concavity of the true coefficients then bounds all subsequent outward ratios by $1/2$. A truncated negative tail that reaches index zero contributes nothing beyond zero. Also $D-k=\lfloor m/j\rfloor\ge N^{b-a}-1>J$ in this regime. This bounds the actual tails by $O(e^{-dJ^2/5})F(r_*)$ as well.

Finally $(J/R')^{P+1}+e^{-dJ^2/5}=o(\exp[-\pi^2/(2d)])$ since $J/R'\ll N^{-4\delta}$ and $dP=dJ\ge N^{7\delta/4}$. The Taylor error exponent multiplied by $d$ is at least $dP\log(R'/J)\to\infty$, and the Gaussian tail exponent multiplied by $d$ is $(dJ)^2/5\to\infty$. Using (12), the central error and both tails together are $o(|F(z)|)$, uniformly on the circle. Combining this with (15) bounds the total perturbation from $F$ there by $o(|F(z)|)$. Rouché counts exactly $k$ zeros inside and none on the circle. The outer-end circles established above complete the counts for every $1\le k<D$. As before, conjugation and positivity imply one simple negative zero in each intervening annulus, and the same is true after translating the variable back.
