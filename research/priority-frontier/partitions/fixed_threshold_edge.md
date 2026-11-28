# Outer interlacing for every fixed threshold

Fix integers $j\ge2$ and $K\ge1$. As $n=jm+s\to\infty$ with $0\le s<j$, the $K$ largest-modulus zeros of the large-block partition polynomial $P_{n,j}$ are simple and negative. Write them $t_{n,k}$ in decreasing order of modulus. For $1\le k\le K$,
\[
 t_{jm+s,k}\sim-\frac{j!}{(j+1)^j}\frac{m^{j+1}}{u_{s,k}},
 \qquad \sum_{\ell\ge0}\frac{(-u_{s,k})^\ell}{(j\ell+s)!}=0,
 \qquad 0<u_{s,1}<u_{s,2}<\cdots .
\]
At this edge all row gaps from 1 through $j$ eventually have the strict interlacing order specified in [Alexandersson's problem](https://mathoverflow.net/questions/462360/set-partitions-with-big-blocks-real-rooted-polynomials). Across the maximal gap the magnitude of a root of the same rank increases by a factor $1+(j+1)/m+o(1/m)$. The proof extends the [threshold-four reciprocal method, §3](https://hexagonmath.org/2611.01129v2) and explains the interlacing without separate trigonometric equations for each threshold.

### A common edge for assemblies

More generally, set $p_n(t)=[z^n]D(z)\exp(t B(z))$, where $D,B$ are real analytic near zero, with nonnegative Taylor coefficients, $D(0)>0$, and $B(z)=b z^j H(z)$, $b>0$, $H(0)=1$, $H'(0)=h>0$. The same result holds with $j!/(j+1)^j$ replaced by $c=h^j/b$. For set partitions, $D=\exp(\sum_{i=1}^{j-1}z^i/i!)$, $b=1/j!$, $h=1/(j+1)$, and the omitted factor $n!$ has no effect on zeros.

Write $a_i=[t^i]p_n$. The coefficient of degree $m$ is positive for large $m$ since the $s$ excess labels can be realized by $s$ of the $m$ large components contributing an excess one. For $0\le\ell\le m$,
\[
 \frac{a_{m-\ell}}{a_m}=(m)_\ell b^{-\ell}
 \frac{[z^{j\ell+s}]D(z)H(z)^{m-\ell}}{[z^s]D(z)H(z)^m}.
\]
The reciprocal polynomial $Q_{m,s}(v)=\sum_\ell(a_{m-\ell}/a_m)(v/(c m^{j+1}))^\ell$ satisfies, locally uniformly on $\mathbb C$,
\[
 Q_{m,s}(v)=s!\sum_{\ell\ge0}\frac{v^\ell}{(j\ell+s)!}+\frac{E_s(v)}m+o(m^{-1})
\]
for an entire $E_s$. To verify this choose $M$ so large that $V/(h M)^j<1$ on the disk $|v|\le V$ (equivalently compare the coefficients of the rescaled generating function below). On $|w|=M$, $D(w/m)H(w/m)^{m-\ell}=D(0)e^{hw}+O_M((1+\ell)/m)$ uniformly for $0\le\ell\le m$, by the analytic logarithm at zero. At fixed $\ell$ this has a uniform first-order expansion in $1/m$. The rescaled denominator $m^{-s}[z^s]D(z)H(z)^m$ tends to $D(0)h^s/s!>0$, with a first-order expansion. The remaining falling-factorial normalization differs from one by at most $\ell(\ell-1)/(2m)$. Cauchy's bound at degree $j\ell+s$ now dominates $m$ times the difference of the $\ell$th summand from its limit by $C_{M,s}(1+\ell^2)(V/(hM)^j)^\ell$, including absent terms $\ell>m$. This proves the expansion.

### Strict cyclic order of the Mittag-Leffler zeros

Let $f_s(u)=\sum_{\ell\ge0}(-u)^\ell/(j\ell+s)!$. Every zero is positive real. One proof takes the residue sections of $(1+z/L)^L$. Its binomial coefficient sequence is totally nonnegative in the Toeplitz sense, since its Toeplitz matrix is a power of a nonnegative bidiagonal matrix. Selecting rows $ji$ and columns $jk+s$ in the upper Toeplitz convention shows the same property for the section coefficients. The finite Aissen–Schoenberg–Whitney theorem gives real nonpositive zeros of each nonconstant section polynomial. After changing the sign of the variable, the sections converge locally uniformly to $f_s$ by factorial domination. Hurwitz's theorem and $f_s(0)>0$ give the claim. All $f_s$ have order $1/j<1$ by the coefficient formula, so Hadamard factorization gives a genus-zero product with infinitely many zeros (a polynomial would contradict the Taylor series).

Termwise differentiation gives, for $1\le s<j$, $f_{s-1}=s f_s+ju f_s'$, and for the remaining link $f_{j-1}=-j f_0'$. Away from the zeros of $f_s$, its product with zeros $a>0$ counted with multiplicity gives
\[
 (u f_s'/f_s)'=-\sum_a\frac{a}{(u-a)^2}<0,
 \qquad (f_s'/f_s)'=-\sum_a\frac1{(u-a)^2}<0 .
\]
Thus any positive zero of a predecessor away from a successor zero is simple. At a positive successor zero of multiplicity $d$, its predecessor has multiplicity $d-1$, also for the derivative link. If any predecessor had a multiple zero, its successor would have an even higher multiplicity there, which cannot continue round the cycle. Hence all zeros are simple and neighboring families have no common zero. For $s\ge1$ the ratio $s+ju f_s'/f_s$ starts at $s>0$, decreases to $-\infty$ before the first pole and decreases from $+\infty$ to $-\infty$ between successive poles. The derivative link has one zero between successive poles and none before the first. In particular
\[
 u_{0,k}<u_{1,k}<\cdots<u_{j-1,k}<u_{0,k+1}.
\]
The real-zero location is also a special case of the [hyper-Bessel zero theorem](https://doi.org/10.1080/10652469.2014.973191).

On a disk enclosing the first $K$ limiting zeros, and on disjoint smaller disks around them, Rouché's theorem transfers the total count and the individual simple roots to $Q_{m,s}$. Reality follows by conjugation. Reciprocation proves the leading constants and the cyclic inequalities give every comparison between different residues, including the wraparound when the degree changes. At identical residues the uniform first-order expansion and simplicity give $|t_{jm+s,k}|=c m^{j+1}u_{s,k}^{-1}(1+d_{s,k}/m+o(1/m))$, so comparing $m$ and $m+1$ gives the claimed strict same-rank drift. These statements concern fixed outer ranks and permit other roots away from that edge.
