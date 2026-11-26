# A four-runner saving at 600 and a seven-runner saving at 1944

For shifted lonely runners, let $E_n$ be the excess defined by the infimal covering radius $1/(n+1+E_n)$. We obtain
$$
 E_n\ge\lfloor n/150\rfloor\quad(n\ge1),\qquad
 \liminf_{n\to\infty}E_n/n\ \ge\ \frac{8011}{1085489}
   =\frac1{135.4998\ldots}.
$$
The previous [disjoint-support construction](packing_theorem.md) gave denominators 167 and about 141.20. In [Poliakova's Table 1](https://arxiv.org/html/2609.23952v1) the strongest listed coefficient is $1/224$.

Use the same seed of $N$ even speeds and radius $\delta=1/(N+1)$, with the three published replacement rules $A,B,C$ as in the disjoint construction. A runner needed by two rules may serve both if its phases agree. A speed removed by one rule may be retained if the other needs it. Translating time by $1/2$ preserves the original phases for even speeds and adds $1/2$ to the phases of odd speeds. In particular the two copies $B_1,B_5$ agree on all shared replacements after this translation on the second copy. At $N=600$ their union saves four runners. A second useful union, $A_1,C_5,C_9$, saves seven at $N=1944$.

For each merged rule the checker constructs the single resulting speed/phase table. It counts the gain after deduplication and verifies coverage from scratch: for every affected even speed $q$, every $k\bmod q$ with $\gcd(k,q/2)=1$, and every $z\in[-1,1]$, at least one replacement $(v,a+h\delta)$ has $vk/q+a\in\mathbb Z$ and $|(v/q)z+h|\le1$. The test forms the union of rational closed intervals in $z$. It remains valid after multiplying every speed by an odd core $c$ because a prime dividing both $k$ and $q/2$ would contradict the minimal responsible speed in the original even seed. The proof of coverage and extension to exactly $n$ runners is given in the preceding note.

The thresholds for the first nine units of saving in each prime-to-30 component are
$$
 96,\ 120,\ 216,\ 600,\ 1080,\ 1944,\ 1944,\ 5832,\ 9720 .
$$
These are achievable thresholds; minimality is unnecessary. As before, adjoining the three copies $A_1,A_9,A_{81}$ to any bundle multiplied by five adds three units at threshold $\max(7776,5t)$. The three copies use only speeds prime to five, with disjoint supports. Starting with the seventh, eighth and ninth units gives the infinite tail $5^j(1944,5832,9720)$, $j\ge0$. The equality $5\cdot1944=9720$ means two thresholds coincide, representing two different units achieved by the higher-gain recipe.

Write $C(x)=\#\{1\le c\le x:\gcd(c,30)=1\}$. Gains add across components. Summing $C(N/t)$ over any finite prefix of thresholds therefore lower-bounds the number of runners saved. Since $C(x)\ge4x/15-14/15$, the attainable asymptotic saved fraction is at least
$$
 \alpha=\frac4{15}\left(\frac1{96}+\frac1{120}+\frac1{216}+
 \frac1{600}+\frac1{1080}+\frac1{1944}+
 \frac54\left(\frac1{1944}+\frac1{5832}+\frac1{9720}\right)\right)
 =\frac{8011}{1093500}.
$$
Taking successively longer *fixed* prefixes proves $\liminf E_n/n\ge\alpha/(1-\alpha)$.

For the all-$n$ bound put $h=\lfloor n/150\rfloor$. If $h>0$ it suffices to save $h$ at $N=151h$, since $n+h\ge151h$. The first seven thresholds give savings at least $(792599/729000)h-7(14/15)>h$ for $h\ge75$. For $1\le h\le74$ the exact residue counts from the first nine thresholds give at least $h$. If $h=0$ the original even seed suffices.

[Exact verifier](overlap_packing.py) · [certificates](overlap_packing.json)
