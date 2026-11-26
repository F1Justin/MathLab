# Coefficient inequalities for every block-size threshold

Let $P^{(j)}_n(t)$ count ordinary partitions of $[n]$ by the number of blocks of size at least $j$. For nonnegative coefficient rows write $U\preceq V$ if $u_i v_k\ge u_k v_i$ whenever $i<k$, with coefficients padded by zeros. For every integer $j\ge2$ and $n\le m\le n+j$,
$$
 (P^{(j)}_m)'\preceq P^{(j)}_n\preceq P^{(j)}_m .
$$
The maximum gap is sharp uniformly in the starting row. If $n=aj+j-1$ and $m=n+j+1=(a+2)j$, the derivative of the later row has degree $a+1$ while the earlier row has degree $a$. Their minor in columns $0,a+1$ is strictly negative.

In particular the ratios of successive coefficients of any single row decrease at least by the factorial factor. If $a_k=[t^k]P_n^{(j)}$, then $a_k^2\ge (1+1/k)a_{k-1}a_{k+1}$ for $k\ge1$. For $t>0$ the tilted expected number of large blocks in the larger row exceeds that in the smaller row by an amount in $[0,1]$.

Put $A=\sum_{1\le i<j}z^i/i!$, $B=e^z-1-A$, $c_h=[z^h]e^A$, and $f_k(h)=[z^h]e^AB^k$. The coefficient of $t^k$ is $h!f_k(h)/k!$. First, $c_h$ is log-concave. Set $\alpha_i=1/(i-1)!$ for $1\le i<j$, zero thereafter, so $hc_h=\sum_i\alpha_i c_{h-i}$. Under weights proportional to $\alpha_i c_{h-i}$, let $E_h$ be the expectation of $\alpha_{i+1}/\alpha_i$. Then
$$
 c_{h+1}/c_h=(1+hE_h)/(h+1).
$$
Given log-concavity up to index $h-1$, moving from the weights at $h-1$ to those at $h$ shifts mass rightwards: their reweighting ratio $c_{h-i}/c_{h-1-i}$ increases with $i$, and newly supported indices appear at the right. The quantity being averaged decreases with $i$ and never exceeds one. Thus $E_h\le E_{h-1}\le1$; the displayed ratio decreases with $h$. The base comparison is $c_2/c_1\le c_1/c_0=1$, also for $j=2$.

Convolution preserves log-concavity for nonnegative sequences with interval support by the order-two minors of their Toeplitz matrices and the Cauchy–Binet identity. Since $[z^l]B$ is log-concave on $l\ge j$, each $f_k$ is log-concave in $h$. Consequently
$$
 R_k(h)=f_{k+1}(h)/f_k(h)=\sum_{l\ge j}[z^l]B\,f_k(h-l)/f_k(h)
$$
increases on its domain. This gives $P_n^{(j)}\preceq P_m^{(j)}$. On the other hand $R_k(m)$ is a weighted average of $R_{k-1}(m-l)$, with weights $[z^l]B\,f_{k-1}(m-l)$. Each positive-weight argument is at most $n$ when $m\le n+j$, giving $R_k(m)\le R_{k-1}(n)$. Clearing factorials proves the derivative inequality. Adjacent coefficient inequalities give the general minors by transitivity of ratios; endpoints follow from interval support. For the mean comparison the derivative inequality implies $P_m^{(j)}\preceq tP_n^{(j)}$. Tilting the three coefficient rows by $t^k$ preserves their order, and hence the order of their means.

This result controls coefficients in the middle of every row even where the sign of the polynomial at its predecessor's negative zeros is unknown. The [API derivation for threshold four](../../package1/api_runs/algebraic_induction_001/answer.md) also gives an upper bound on how many residues in a root-induction step can have the wrong sign, conditional on previous interlacing.
