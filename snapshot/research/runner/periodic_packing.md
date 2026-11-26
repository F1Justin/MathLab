# A uniform finite-size bound for the shifted-runner excess

For every positive integer $n$, the constructions in [compatible rule packing](overlap_packing.md) give
$$
E_n\ \ge\ \max\!\left\{\left\lfloor\frac n{150}\right\rfloor,
\left\lfloor\frac{8011n-3241770}{1085489}\right\rfloor\right\}.
$$
The second term retains the full asymptotic slope with an explicit additive loss under three before rounding. At $n=100000$ this guarantees 735 units of excess, compared with 666 from the first term.

**Eliminating the infinite sum.** Let $C_m(x)$ count positive integers $c\le x$ coprime to $m$. For a given seed size $N$, only finitely many thresholds in the construction can contribute. Its guaranteed saving is
$$
G(N)=\sum_{t\in (96,120,216,600,1080,1944)} C_{30}(N/t)
     +\sum_{t\in (1944,5832,9720)}C_6(N/t).
$$
Multiplicity matters at 1944. Indeed each positive number coprime to 6 has a unique expression $5^j c$ with $\gcd(c,30)=1$. Consequently the entire geometric tail of one threshold $t$ contributes exactly $C_6(N/t)$. The recipes chosen at a particular core need not be nested: select its highest feasible gain just once.

**Period and discrepancy.** Each summand $C_m(N/t)$ has increments periodic modulo $mt$. Their common period $P=17496000$ gives $G(N+P)=G(N)+128176$. Write $p=8011$, $q=1093500$, so $pP=q\cdot128176$. The discrepancy $pN-qG(N)$ is periodic. Its maximum is $K=4335269$, attained at $N=8139479$, $G(N)=59626$. To check this integer claim, enumerate the progressions $N=t(r+jm)$ with $1\le r<m$, $\gcd(r,m)=1$, and $1\le N\le P$. Between jumps $G$ is constant and the discrepancy increases, so only positions immediately before a jump and the period endpoints are needed. Coincident jumps add their multiplicities. The [verifier](periodic_packing.py) checks the extrema at all 125176 distinct jump positions and evaluates the maximizing witness independently by quotient and remainder. [Integer certificate](periodic_packing.json)

**From savings to a radius.** For the second floor let $h=\lfloor(pn+q-1-K)/(q-p)\rfloor$. When $h>0$, put $N=n+h$. Its definition gives $pN-K>q(h-1)$, so the integer $G(N)$ is at least $h$. The certified construction therefore uses at most $n$ distinct speeds and covers at radius $1/(n+h+1)$. Add unused distinct positive speeds if necessary. This implies $E_n\ge h$. For $h\le0$ the even-speed seed gives $E_n\ge0$. The first floor is the previously verified all-$n$ bound.

## Extending each power-of-five layer

The auxiliary triple used to extend a recipe can itself grow. The support of rule $A$ is $\{3,8,9,12,16,24,32,48,64,96,192\}$. Every entry is prime to 5. The only entry divisible by 9 is 9, and 1 is absent. Hence the supports of $A_{9^i}$ for all $i\ge0$ are pairwise disjoint. Each is also disjoint from every speed in a bundle scaled by 5.

Let $g(x)$ be the gain from the old threshold list on a single core. For $x\ge9720$, its explicit geometric list gives $g(x)=3+g(x/5)$. This equality uses that all six head thresholds and all three first-cycle thresholds are already reached at $x$, and all six head thresholds are reached at $x/5$. Use the old recipe for $x<9720$. Above it use the improved recipe at $x/5$, scaled by five, and adjoin every $A_{9^i}$ with $96\cdot9^i\le x$. The first three reproduce the old extension. Each $i\ge3$ thus gives one additional unit at every threshold $96\cdot 9^i 5^j$, $j\ge0$. Reached thresholds add even when some are numerically equal, because their rules use disjoint supports.

For any fixed finite prefix, summing over cores costs only a bounded counting error as $N$ increases. The limiting saved fraction therefore increases by at least
$$
\frac4{15}\sum_{i\ge3,j\ge0}\frac1{96\cdot9^i5^j}
=\frac{1}{186624}.
$$
The resulting saved fraction is $513079/69984000$, giving $\liminf E_n/n\ge513079/69470921$. The uniform finite-size bound above uses the original periodic profile.
