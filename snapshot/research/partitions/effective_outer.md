# The five outermost zeros in every row

For every integer $n\ge20$, the five zeros of $P_n$ of greatest modulus are simple, real, negative, and have distinct moduli. For two such rows at distance one, two, three or four, the two lists of five, sorted from the most negative root, alternate strictly. If the degree increases the later row comes first. Otherwise the earlier row comes first. For lower degrees, the complete finite-row check applies. This is an all-row statement for five ranks; the all-rank theorem still has an unspecified starting row.

For $n=4m+s\ge2000$, write the original variable as $t=-(24/625)m^5/(4X^4)$. The successive $X$-intervals below are **open**, with exact terminating-decimal endpoints.

| $s$ | First | Second | Third | Fourth | Fifth |
|---|---|---|---|---|---|
| 0 | 1.17–1.73 | 4.31–4.87 | 7.45–8.01 | 10.60–11.16 | 13.74–14.30 |
| 1 | 1.96–2.52 | 5.10–5.66 | 8.24–8.80 | 11.38–11.94 | 14.52–15.08 |
| 2 | 2.74–3.30 | 5.88–6.44 | 9.02–9.58 | 12.17–12.73 | 15.31–15.87 |
| 3 | 3.53–4.09 | 6.67–7.23 | 9.81–10.37 | 12.95–13.51 | 16.09–16.65 |

## Exact normalization and the tail

Put $q=1/m,\ y=500q,\ v=4X^4,\ A=z+z^2/2+z^3/6,\ b=24(e^z-1-A)/z^4$.
After extracting the common $t^m$ and a positive constant the reciprocal polynomial is
$$
 S(q,v)=\sum_{l=0}^m(-v)^l p_l(y),\qquad
 p_l(y)=\prod_{h<l}(1-hq)[w^{4l+s}]e^{A(5qw)}b(5qw)^{m-l}.
$$
Products indexed by $h<j$ start at zero. For $d=4l+s$, finite binomial expansion gives the polynomial identity at these integer rows
$$
 p_l(y)=\sum_{i=0}^d [w^d]e^{A(5w)}(b(5w)-1)^i/i!\; q^{d-i}\prod_{h<l+i}(1-hq).
$$
The checker constructs these polynomials only for $l\le L=40$, where $l+d<500$. At $q=0$ the coefficient is $1/d!$.

Fix $R=82, q_0=1/500, a=A(5q_0R), D=(b(5q_0R)-1)/q_0, M=e^{a+D}$. Nonnegative coefficients give $b(5qR)-1\le qD$. Cauchy's estimate yields $|p_l|\le MR^{-d}$ for integer rows, with $p_l=0$ for $l>m$. Thus on $|v|\le V<R^4$ the absolute sum of the tail is at most $MR^{-s}(V/R^4)^{41}/(1-V/R^4)$.

## Counts and ranks

On dyadic subintervals covering every $0\le y\le1$, Arb encloses the degree-40 sum at both endpoints of each window. The absolute tail fits strictly inside the signed margin, proving alternating endpoint signs. For each residue put $X_*=1+$ the right endpoint of its fifth window. Normalize the disk $|v|\le4X_*^4$ to radius one. For the degree-40 polynomial form the Graeffe transform $G(f)=f_{\rm even}^2-zf_{\rm odd}^2$ from the even and odd subsequences of its coefficients. This squares the modulus of each root. If the full series differs by coefficient $\ell^1$ norm at most $e$, the transformed error is at most $e(2\|f\|_1+e)$, by multiplying $f(w)f(-w)$ and then setting $z=w^2$. After two transforms, the fifth coefficient in absolute value strictly exceeds the sum of all other absolute coefficients plus the propagated error. Rouché's theorem gives exactly five roots counted with multiplicity in the disk and none on its boundary. The five real sign changes exhaust the count. Reciprocating establishes the claimed complex-modulus ranks.

The four covers have 64, 128, 128 and 256 slabs. When the residues differ the rational brackets themselves strictly alternate after the degree-jump rescaling $X\mapsto X/(1+q)^{5/4}$. The checker verifies these inequalities at the worst endpoint. For gap four we need the direction of motion inside *the same* bracket.

## The displacement over four rows

Write $H(y,v)=\sum_{l=0}^{40}(-v)^l p_l(y)$. At a fixed original $t$, taking $m$ to $m+1$ changes $(y,v)$ to $(y/(1+q),v(1+q)^5)$. Along this path the derivative in $u\in[0,q]$ is $(5v\partial_v-y\partial_y)H/(1+u)$, evaluated at $(y/(1+u),v(1+u)^5)$.

To control the *difference* of omitted tails, use the sum of absolute Taylor coefficients weighted by $R^j$ as norm in $w$. Put
$$
 D_2=\big(b(5q_0R)-1-q_0R+e^{q_0R}-1-q_0R\big)/q_0^2 .
$$
Then $\|b(5qw)-e^{qw}\|\le q^2D_2$; constant and linear terms cancel. Telescoping the $m-l$ powers costs at most $qD_2 e^D$. Replacing $e^{(1-lq)w}$ by $e^w$ costs at most $lqRe^R$. Replacing $e^{A(5qw)}$ by one costs at most $q(a/q_0)e^a$. Finally $1-\prod_{h<l}(1-hq)\le ql(l-1)/2$ for $l\le m$. Since $D\ge R$, these estimates give
$$
 |p_l(500q)-1/d!|\le qM R^{-d}(a/q_0+D_2+lR+l^2/2).
$$
The same bound holds for the zero extension $l>m$, using $q l^2/2\ge1$ and $R^d/d!\le e^R$. Compare both integer rows to $1/d!$ and use $((1+q)^{5l}-1)/q\le5l(1+q)^{5l}$. The absolute difference of their tails, divided by $q$, is bounded by
$$
 T=M R^{-s}\sum_{l>40}
 \left(\frac{V(1+q_0)^5}{R^4}\right)^l
 \left[2(a/q_0+D_2+lR+l^2/2)+5l\right].
$$
The checker bounds this positive series by its first term divided by one minus a geometric ratio, using that the quadratic factor grows by at most $(42/41)^2$ per step.

For each $X$-window $(a_k,b_k)$, take $V=4b_k^4$. On $4a_k^4\le v\le V(1+q_0)^5$, the checker converts the generator exactly in form into degree-40 Bernstein coefficients in the rescaled $v$; their values are enclosed on 32 intervals in $y$. All signed coefficients, after multiplication by $(-1)^k$, exceed $(1+q_0)T$. The Bernstein basis is nonnegative and sums to one, so after integration the tail cannot reverse the sign. At the old $k$-th root the new value has sign $(-1)^k$, the sign just after its own $k$-th reciprocal root. The rescaled test point stays between the other windows and inside the counted disk. This proves that, at the same rank, the later original root is strictly more negative. The separate brackets give the other half of the alternation.

Finite verification through row 2004 includes every comparison crossing row 2000. [Uniform checker](effective_outer.py) · [dyadic covers](effective_outer.json) · [finite rows](finite_2004_window.json)
