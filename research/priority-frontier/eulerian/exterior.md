# The exterior zeros of the ordinary Eulerian square

Let $H_n$ be row $n$ of the ordinary matrix square in [Mao–Wang, §4](https://arxiv.org/html/2607.01572v1). For every fixed $c>0$ and all sufficiently large $n$, **every zero of $H_n$ with $\log|x|\ge c\sqrt n$ is simple and strictly negative**. Together with the [fixed disk theorem](left_disk.md), this implies that a sequence of nonreal zeros could only occur with $\log |x|\to\infty$ and $(\log |x|)/\sqrt n\to0$.

The collision of two limiting zeros needs a first-order calculation. At the common limiting scale the product of two independent theta functions alone would allow a conjugate pair.

## Two integer indices

Write $R_n(w)=w^nH_n(1/w)$. With the descent convention of the [paired extreme-root calculation](paired_edge.md), its terms are
\[
 E(n,A-1)E(n-A+1,B-1)w^{A+B-2},\qquad A,B\ge1,\quad A+B\le n+1.
\]
Set $w=e^{-T}z$, where $T\ge c\sqrt n$. We prove the result by contradiction along any sequence of multiple or nonreal zeros on $|z|=1$. First pass to a subsequence with $s=n/T\to\infty$; the bounded-$s$ case is handled below. Define the positive weight
\[
 W(A,B)=A^n B^{n-A+1}e^{-T(A+B-2)} .
\]
Choose a maximum $(P,Q)$ on the integer triangle. Comparing to a step backwards in either coordinate gives $P,Q\le 1+s$ (use $\log(1+1/k)\le1/k$). Thus both forward steps are available for large $n$. The forward comparisons give $P+1\ge n/(T+\log Q)$ and $Q+1\ge(n-P+1)/T$, by $\log(1+1/k)\ge1/(k+1)$. Hence $P,Q\sim s$ uniformly along the subsequence.

With $i=A-P$, $j=B-Q$, set
\[
 u_i=(1+i/P)^n e^{-(T+\log Q)i},\qquad
 v_j=(1+j/Q)^{n-P+1} e^{-Tj}.
\]
The first sequence starts at $i=1-P$ and the second at $j=1-Q$. Extend both indefinitely to the right. Each has maximum one at its zero index, by log-concavity and the two adjacent comparisons at the maximum. Their local Laurent series $U(z)=\sum_i u_i z^i$, $V(z)=\sum_jv_j z^j$ are holomorphic on every fixed compact annulus for large $n$. The exact model weight divided by $W(P,Q)$ is
\[
 u_i v_j\exp[-i\log(1+j/Q)].
\]
On compact annuli about the origin, with $D=z\,d/dz$, the actual polynomial has the expansion
\[
 F_n(z):=\frac{R_n(e^{-T}z)}{W(P,Q) z^{P+Q-2}}
       =U(z)V(z)-Q^{-1}D U(z)D V(z)+O(Q^{-2}). \tag{1}
\]

Here are details of tail control in (1). Outside $s/2\le A,B\le2s$, the contribution from admissible terms is exponentially small in $n$ even after multiplication by $|z|^{i+j}$. In fact $B^{1-A}\le1$. Absorb the compact annular multiplier using $T'=T-C$ for fixed $C$, at a cost $e^{O_C(s+1)}$ independent of $A,B$. The logarithmic loss of each factor $A^n e^{-T'A}$ from its real maximum at $s'=n/T'$ is $n(A/s'-1-\log(A/s'))$, and likewise for $B$. For an outside cell the combined loss is at least $c_0 n$, with $c_0>0$, since $s'/s\to1$. The product of the two real maxima at $T'$ and at $T$ differs by $e^{O_C(s)}$. The normalization $W(P,Q)$, including the common $e^{2T}$ factor, is at least the value obtained by rounding $A=B=s$ to nearest integers. Rounding costs $O(n/s^2)$ in the logarithm, and the extra factor $B^{1-A}$ costs $O(s\log(2s))$. Both are $o(n)$. There are at most $n^2$ admissible cells. The Eulerian bin estimate bounds the actual terms by these model terms everywhere. Inside the rectangle it replaces both Eulerian factors by their model powers with relative error $O(n^2e^{-c_1 n/s})$, since both row indices exceed $n/2$ there for large $n$.

Inside the rectangle the discrete log-curvatures of $u,v$ are bounded below by a constant $\kappa>0$ depending only on $c$: the second derivative of $n\log A$ is $-n/A^2$ and that of $(n-P+1)\log B$ is $-(n-P+1)/B^2$. Since each is at its maximum at offset zero, its term of offset $l$ is at most $\exp[-\kappa |l|(|l|-1)/2]$ (decrease $\kappa$ at the rectangle boundary if necessary). At the rectangle endpoints these bounds are $e^{-\Omega(s^2)}$; the outward ratios are then $e^{-\Omega(s)}$ and can only decrease by global log-concavity. This also controls the extensions of $U,V$ and their derivatives outside the rectangle. Throughout the rectangle $|\log(1+j/Q)|\le C_2|j|/Q$, and $|\log(1+j/Q)-j/Q|\le C_2 j^2/Q^2$, since $B/Q$ stays bounded away from zero. Expanding the mixed exponential gives an error bounded by
\[
 C_3 Q^{-2}(|i|j^2+i^2j^2)\exp(C_3|ij|/Q).
\]
The two Gaussian bounds absorb this factor after summation, uniformly on each fixed compact annulus. This proves (1) and permits compact convergence of all fixed derivatives of the two factors.

## The sign at a collision

Pass to a subsequence on which $d=n/s^2$ tends to $d_0\in[c^2,\infty]$. If $d_0<\infty$, the first-order slopes of $u$ and $v$ at their centers stay bounded, by the forward and backward integer mode inequalities. Taylor expansion of the logarithm at each fixed offset, followed by subsequence extraction for these slopes, gives the two limiting functions
\[
 \sum_{l\in\mathbb Z}\exp(a l-d_0l^2/2)z^l
\]
with possibly different real $a$. Both are nonzero functions with simple negative zeros by the Jacobi triple product. If $d_0=\infty$, the central curvature tends to infinity at every fixed offset. Only offsets $-1,0,1$ can survive, and the product of the two neighboring coefficients tends to zero since $(1-1/P^2)^n\to0$ and $(1-1/Q^2)^{n-P+1}\to0$. Each limit is consequently the constant one or a binomial $1+az$ or $1+a/z$ with $0<a\le1$. This also gives only simple negative zeros. The preceding domination makes all these limits locally uniform off zero.

Every limit of the offending points on $|z|=1$ must now be a zero of the product of the two limits. Such a point can only be $-1$. If only one factor vanishes there, Rouché on a small conjugation-invariant disk gives a single real simple zero, a contradiction. In the remaining case write $z=-e^y$. On a fixed small disk about zero in $y$, each finite factor $U(-e^y),V(-e^y)$ has precisely one simple, real zero, denoted $a_n,b_n$. Both tend to zero by Rouché and conjugation. Their derivatives there tend to nonzero real limits. Divide (1) by the product of these two derivatives at the respective zeros. At $y=(a_n+b_n)/2$ the result is
\[
 -\tfrac14(a_n-b_n)^2(1+o(1))-Q^{-1}(1+o(1))+O(Q^{-2})<0.
\]
Indeed $D$ is exactly differentiation in $y$, and the derivatives of the two factors vary continuously and uniformly near the limiting zero. At two fixed nearby real endpoints on opposite sides of zero the normalized limiting product is strictly positive. There are two distinct real crossings; the complex zero count in the same disk is exactly two by Rouché. Both roots are simple. More precisely, their log coordinates are $(a_n+b_n)/2\ \pm\sqrt{(a_n-b_n)^2/4+1/Q}\,(1+o(1))$: Taylor expansion on the scale of this square root gives the normalized limit $y^2-1$ in the centered, scaled coordinate. The mixed term in (1) determines the direction of splitting.

## When the maximizing indices remain bounded

It remains to treat sequences on which $s$ stays bounded. Pass to a subsequence on which $T/n\to t\in(0,\infty]$. If $t=\infty$, $A\le2^{A-1}$ and $B\le2^{B-1}$ make the sum of all nonconstant terms on a fixed annulus $o(1)$ at $w=e^{-T}z$. If $t$ is finite, the scalar weight $a\mapsto a e^{-t(a-1)}$ has either one maximizing positive integer $L$, or two, $L,L+1$, with the latter case occurring at $t=\log(1+1/L)$. Since $T/n$ stays bounded away from zero, all indices larger than a sufficiently large fixed constant have exponentially decaying relative weight. More explicitly for $A$ beyond a fixed constant the scalar ratio at consecutive indices is $[e^{-T/n}(1+1/A)]^n\le e^{-tn/4}$, and similarly for $B$; the factor $B^{1-A}$ is at most one. Normalize here by the squared scalar maximum at $T/n$ (with the same $A-1,B-1$ convention). Multiplication by $|z|^{A+B-2}$ on compact annuli preserves this geometric bound. On any fixed finite set, replacing Eulerian factors by their powers makes relative error $o(1)$.

If the scalar maximum at $t$ is unique, the normalized limit is a single nonzero monomial. In the tie case put $\Delta_n=T-n\log(1+1/L)$. For $\Delta_n\to\pm\infty$ only one of the two integers contributes after normalization, since the consecutive weight ratio is $e^{-\Delta_n}$. Again we obtain a nonzero monomial. For bounded $\Delta_n$ pass to a convergent subsequence. The four surviving cells then give precisely the rescaled quadratic with two distinct positive roots in the variable $-z$ in the [fixed-cluster calculation](paired_edge.md); the rescaling $e^{-\Delta_n}$ has a finite positive limit. All zeros in the compact annulus are eventually simple and negative, by Rouché around the simple limiting roots. This excludes every offending sequence and completes the proof.
