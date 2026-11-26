# A finite quantitative margin for threshold four

Fix the threshold at four. Let $P=P_n, Q=P_{n+1}$, with positive leading coefficients $p,q$, and write $r_1<\cdots<r_d<0$ for the roots of $P$. Per Alexandersson's recurrence in [RealRooted #1773](https://github.com/PerAlexandersson/RealRooted/issues/1773) defines a lag polynomial $G$ such that $Q(r_i)=r_iP'(r_i)+G(r_i)$. The upstream induction tests whether $G(r_i)/(-r_iP'(r_i))<1$. Its margin below one is exactly
$$
M_i=Q(r_i)/(r_iP'(r_i)).
$$

**Finite certificate.** For every $4\le n\le2003$ and every root of $P_n$, $M_i>10^{-15}$. This includes 501,000 root evaluations represented implicitly by the published dyadic intervals. The bound is intentionally conservative. An induction that preserves a positive margin for every row remains open.

**Proof.** Let $s_j$ denote the ordered roots of $Q$. The sign of $M_i$ is positive by the certified strict orientation. Its magnitude is $(q/p)\prod_j|r_i-s_j|/(|r_i|\prod_{h\ne i}|r_i-r_h|)$. We bound the quotient of products with only neighbouring endpoints.

* Equal degrees give $r_h<s_h<r_{h+1}$ and $r_d<s_d$. For $h>i$, $(s_h-r_i)/(r_h-r_i)>1$. For $i>1$ the product of the factors on the left is at least $(r_i-s_{i-1})/(r_i-r_1)$: compare $r_i-s_h$ with $r_i-r_{h+1}$ for $h<i-1$ and cancel. For $i=1$ the left product equals one. Multiply this lower bound by $(q/p)(s_i-r_i)/|r_i|$.
* When the degree increases, $s_h<r_h<s_{h+1}$. Pair the factors of the derivative on the left with $s_h$ for $h<i$, and those on the right with $s_{h+1}$ for $h>i$. Every paired ratio exceeds one. The lower bound is $(q/p)(r_i-s_i)(s_{i+1}-r_i)/|r_i|$.

For $n=4d+j$, the leading coefficient of $P_n$ is
$$
 n!\,[z^j]\exp(z+z^2/2+z^3/6)\bigl(24B(z)/z^4\bigr)^d/(24^d d!),
\quad B(z)=e^z-1-z-z^2/2-z^3/6.
$$
Only degrees zero through three are needed. The script uses this expression for $q/p$, lower bounds on positive numerator distances and upper bounds on positive denominators. Each binary64 endpoint is interpreted as an exact dyadic rational. The minimum of the four bounds printed in [margins.txt](margins.txt) exceeds $10^{-15}$ by integer cross-multiplication.

**Reproduction.** First run the [independent sign verifier in the fixed release](https://github.com/F1Justin/MathLab/tree/ef98c0707e3a9e1b6b66f905aadd24ea6e38cadc/certificates/partitions) to establish the polynomial, sign, degree and ordering hypotheses. Then run the present calculation with Python 3's standard library.

```sh
python3 margins.py /path/to/rows4-2004.bin.gz
```

The finite estimate is a corollary of the certified enclosures. It is a quantitative instance of Alexandersson's rootwise test and does not close the gap between the finite interval and MathLab's eventual theorem. The proof and computation were produced by AI. The human contributor has not independently checked the proof.

## A two-root obstruction to coefficient-only induction

Let $P=(x+3)(x+4)$ and $Q=(x+1)(x+5)$. The coefficient rows in ascending powers are $(12,7,1)$, $(5,6,1)$, and $(6,2,0)$ for $P,Q,Q'$, respectively. In column pairs $(0,1),(0,2),(1,2)$, the minors for $Q'\preceq P$ are $(18,6,2)$ and those for $P\preceq Q$ are $(37,7,1)$. Both polynomials split with distinct negative roots and all six minors are strictly positive. Nevertheless the margin at $r=-4$ equals $-3/4$; at $r=-3$ it equals $4/3$. Thus even the strict coefficient orders of the type considered in Theorem 8 do not suffice to certify interlacing for an arbitrary pair.

A stronger scalar test fails for the same example. Put $D(t)=(Q(t)/P(t)-Q(0)/P(0))/t$ with the continuous value at zero. Its partial fractions are
$$
 D(t)=\frac{4}{3(t+3)}-\frac{3}{4(t+4)} .
$$
Every $(-1)^k D^{(k)}(t)$ is positive on $[0,\infty)$, since the positive term has both the larger weight and the smaller denominator. Yet for $m_k=(-1)^kD^{(k)}(0)/k!$, the first nontrivial Hankel minor is
$$
 m_0m_2-m_1^2
 =\frac{4/3}{3}\frac{-3/4}{4}(1/3-1/4)^2=-1/1728.
$$
For the actual partition recurrence this leaves a concrete question: which property of a *reachable* pair forces positivity of the mixed Hankel minors? The example concerns arbitrary pairs and makes no claim of a counterexample on the partition orbit.
