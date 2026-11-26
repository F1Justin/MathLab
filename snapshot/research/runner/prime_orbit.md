# Local phase geometry of the consecutive-speed configuration

Let $p\ge7$ be prime, let $d=1/p$, and define $F(u)=\max_t\min_{1\le j<p}\|jt+u_j\|$. Put
$$
 M(u)=\max_{1\le a\le(p-1)/2}
 \left|\frac{(p-a)u_a-a u_{p-a}}p\right|,
 \qquad
 Q=\begin{cases}(p-1)/2,&p\equiv3\pmod4,\\(p-3)/2,&p\equiv1\pmod4.\end{cases}
$$
On the whole real cube $\max|u_j|\le\rho_0=1/(2Q(p+1))$,
$$ F(u)=d+M(u). $$
No larger centered cube has this identity. In particular all complementary pairs can be translated independently in time while preserving the value $d$, locally, precisely when $u_a/a=u_{p-a}/(p-a)$.

**Lower estimate.** Choose $a$ attaining $M$, $b=p-a$, and $k$ with $ka\equiv1\bmod p$. At $t=\pm k/p-(u_a+u_b)/p$ their phase corrections are opposite, of magnitude $M$. One sign gives both distances $d+M$. Every other runner initially had distance at least $2d$, and changes by less than $3\rho$ for $\rho=\max|u_j|$. Since $4\rho_0\le d$, no other runner lowers this value.

**Upper estimate.** On a Farey interval between reduced adjacent fractions $P/q<R/h$ of order $p-1$ we have $qR-hP=1$ and $q+h\ge p$. Consider $A=qt-P+u_q$ and $B=R-ht-u_h$. If one is negative, its absolute value is at most $\rho$. Otherwise the smaller distance is at most $(hA+qB)/(q+h)=(1+h u_q-q u_h)/(q+h)$. For sum $p$ the bound is $d+M$; for sum at least $p+2$ it is at most $1/(p+2)+\rho_0\le d$. For sum $p+1$ denote the smaller denominator by $q$, regardless of endpoint order. Coprimality implies $q\le Q$, since the largest possible smaller denominator must be odd and coprime to $p+1$; the displayed $Q$ satisfies both requirements. Subtract the lower bound $M\ge((p-q)|u_q|-q\rho)/p$ from the upper bound $(h|u_q|+q\rho)/(p+1)$ for the phase contribution. The difference is at most $2q\rho/p$. Consequently this peak is at most $1/(p+1)+2Q\rho/p+M\le d+M$.

**Sharpness.** Set $q=Q$, $h=p+1-q$, $u_q=u_{p-q}=\rho$, $u_h=-\rho$, $u_{p-h}=-(p-h)\rho/h$, with all other phases zero. These four indices are distinct. Now $M=(p-2q)\rho/p$. Take $t=k/(p+1)$ with $kq\equiv1\bmod(p+1)$. Both $q$ and $h$ have distance $1/(p+1)+\rho$ there. Every other distance is at least $2/(p+1)-\rho$, so for $\rho_0<\rho\le1/(2(p+1))$, $F(u)>d+M$. This excludes every larger cube by inclusion.

## A wider tube that prohibits strict improvement

If doubling on nonzero residues modulo sign has odd order (in particular if $p\equiv3\bmod4$), then
$$
 \min_\tau\max_{1\le j<p}\|u_j+j\tau\|\ \le\
 \frac{2(p+1)}{3p-1}\frac1p
 \quad\Longrightarrow\quad F(u)\ge1/p .
$$
Translate to real phase lifts of magnitude at most $\rho$ equal to the stated tube radius or smaller. Suppose $F<d$. At $\pm k/p$ with $ka\equiv1\bmod p$, only the pair $a,p-a$ can attain distance strictly below $d$, even for phase magnitudes up to $d$. The two tests require those two phases to have the same strict sign. Translating by any $|z|\le(d-\rho)/(p-1)$ preserves phase magnitudes at most $d$; thus no $u_j+jz$ vanishes, giving $|u_j|>j(d-\rho)/(p-1)$.

For $a\le(p-1)/2$, anchor $h=p-a$ at $t=\pm k/p-u_h/h$. Its distance is $d$ and speed $a$ has distance at least $d$ for one sign. The correction for any $j$ has size at most $(1+(p-1)/h)\rho\le2d$. Only nominal distance $2d$ can block this probe, so a member of the pair $\{\pm2a\}$ must change by more than $d$. A member with the same sign as $u_h$ cannot do so: $|u_j|\le\rho<d$, and
$$
 j|u_h|/h-|u_j|
 <\frac{j}{p-1}[(1+(p-1)/h)\rho-d]\le d .
$$
Hence doubling must alternate pair signs on every orbit, impossible on an odd cycle. For $p=59$ the group modulo sign has order 29, yielding $15/(22\cdot59)$; the exact-formula cube for this prime has radius $1/3480$.

The [Astra derivation](../../package1/api_runs/tight_orbit_001/answer.md) supplies the $p=59$ instance. The argument above treats both congruence classes of primes and gives their different sharp cube radii. The global optimum over unrestricted phases is a separate question.
