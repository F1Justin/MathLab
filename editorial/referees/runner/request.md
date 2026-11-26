Act as a skeptical independent research referee for two proposed shifted lonely runner manuscripts. Give line-by-line correctness objections or a compact independent proof at decisive points. Treat the enclosed results as claims, not ground truth. Do not claim to have executed code or browsed. Quantitative and computer-assisted statements need both sound finite reduction and reproducible numerical evidence. Distinguish originality relative to named sources from proof correctness.

Read Poliakova v1 Theorem 7 and Table 1 as the prior construction (the transcribed rule table is enclosed). Blanco–Criado–Santos have counterexamples for all n=5..17, Poliakova for all n>=95, and the public solved-conjectures repository reports n=18..57. The work is not a resolution at n=58. SLR uses distinct positive integer speeds, the stationary observer excluded, and arbitrary real phases. Absolute priorities:
1. Prove or refute primitive-residue locality, parity/time-translation compatibility, exact gain and avoidance of duplicate velocities, separation of coprime cores, tightness of numerical coefficients and periodic finite-size lower bound. Check recurrent use of all A_9^i for x>=9720, threshold multiplicity and convergence, and h integer rounding.
2. Stress-test finite affine rule reductions with arbitrary real parameters and unbounded odd speeds. Check shifting lowest frontier, incidence preservation under gcd classes, rephased even versus unchanged even, completeness of the L=12 negative instance as stated. Find concise proofs or material counterexamples.
3. Check the fixed 57-seed optimum (closed intervals vs isolated point at strict target; speeds bounded only when one runner covers whole connected gap). Discuss uniqueness, all optimal phases, stability and simultaneous common time translation. Audit weighted residual measure and large-speed bounds, the exact scope of requiring at least seven changes with 58 final runners.
4. Check triple deletion two-runner reduction including possible lattice boundaries, finite tail bounds, thresholds and the reduction of phase-rectangle failures to one-dimensional intervals. Check continuous phase boxes via strict inequalities and integer potentials, including which solver-backed claims should be labeled computed and how to reproduce. No need to judge heuristic search outcomes except claim wording.
5. Recommend mandatory manuscript repairs and a hierarchy among new results, archived prior-art replay, and limited searches.


===== packing_theorem.md =====
# Mixed-scale lower bounds for the shifted lonely-runner excess

Let E_n be defined by inf gamma=1/(n+1+E_n), with n moving runners, mutually distinct positive integer speeds and arbitrary starting phases. The following bounds follow by combining three of Daria Poliakova's existing rules:

    E_n >= floor(n/167) for every n >= 1,
    liminf E_n/n >= 76897/10858103 = 1/141.2032...

The construction starts from her local rules. The new calculation chooses between different rules and compatible bundles separately for each scale. This improves the asymptotic coefficient 1/224 reported in Table 1 of her September 2026 preprint. It concerns large n and supplies no certificate at n=58. Priority beyond the compared sources has not been established.

## Proof

Use N even speeds 2,4,...,2N with zero phase. Among the N+1 numbers 0,2t,...,2Nt modulo 1, two consecutive points in circular order differ by at most 1/(N+1). Their index difference gives an even speed covering t at radius d=1/(N+1). Coincident points also give a covering speed. Assign t to the smallest such speed.

Write A,B,C for Poliakova's Theorem 7, Table 1 row 19 to 17, and Table 1 row 24 to 21, respectively. Their gains are 1,2,3. Their largest affected even speeds are 192,240,432. At odd scale b they require N>=96b,120b,216b respectively. The locality property says that if the originally responsible speed is affected, one of this rule's rephased or added speeds covers t. Disjoint rule supports therefore compose.

For reproducibility an independent exact local check is in packing.py. If the responsible speed is qb, write qbt=k+d z where |z|<=1. Any common divisor p>1 of k and q/2 would supply a smaller even speed qb/p covering t. Hence gcd(k,q/2)=1. For each such k modulo q, a replacement of speed vb and phase a+hd covers all z satisfying |(v/q)z+h|<=1 whenever vk/q+a is integral. Taking unions of closed rational intervals verifies full coverage of [-1,1] for every required residue class and all three rules, at every admissible b.

Let c run through positive integers coprime to 30. Inside the component of c use the following one recipe according to the size of N/c. A multiplier following a letter indicates the scale relative to c.

| Minimum N/c | Simultaneous rules | Runners saved |
|---:|---|---:|
|96|A1|1|
|120|B1|2|
|216|C1|3|
|864|A1, B5, A9|4|
|1080|A1, A9, C5|5|
|3000|A1, A5, B9, B25|6|
|5400|A1, A5, B9, C25|7|
|5832|A1, A5, C25, C27|8|
|9720|C1, C25, A45, B81|9|

At each row the individual supports are disjoint, as direct integer set intersection verifies. Every velocity in the component has the form c times a product of powers of 2,3,5. Its prime-to-30 part recovers c, so distinct components also have disjoint supports.

The triple A1, A9, A81 has gain three and threshold 7776. It has disjoint supports because 9 is the only multiple of 9 in the support of A and 1 is absent. Every velocity in this triple is prime to 5. Thus any valid bundle of gain g and threshold t extends to gain g+3 at threshold max(7776,5t) by multiplying the existing bundle by 5 and adjoining this triple. Starting with rows seven through nine gives all further thresholds in increasing order. After the first six thresholds the list consists of the triples 5^j (5400,5832,9720) for j >= 0.

Let C(y) count positive c <= y coprime to 30. For each finite prefix T of the threshold list the guaranteed saving is G(N)=sum over t in T of C(N/t). Select the highest available bundle separately for each c. Each reached threshold contributes one unit of saving. The residues 1,7,11,13,17,19,23,29 modulo 30 give C(y) >= 4y/15 - 14/15 by taking the maximum deficit just before each residue. Thus G(N) >= a N - D for a=(4/15) sum 1/t and the fixed D=14|T|/15. For n runners choose h=max(0,floor((a n-D)/(1-a))) and N=n+h. If h>0 the construction saves at least h. Pad the configuration to exactly n with unused distinct positive speeds. Its covering radius is at most 1/(N+1), giving E_n >= h. Applying this argument separately to each finite prefix and then taking the supremum proves the asymptotic bound. Indeed the infinite sum gives a=(4/15)(1/96+1/120+1/216+1/864+1/1080+1/3000+(5/4)(1/5400+1/5832+1/9720))=76897/10935000.

For the all-n floor, set h=floor(n/167). Since n+h>=168h it suffices to show G(168h)>=h. The first three terms sum to at least (707/675)h-14/5>h-3, hence at least h-2 by integrality. For h>=7 the fourth and fifth thresholds each contribute at least one. For h from 1 through 6 the exact counts are 2,3,3,4,5,6. For h=0 the even-speed starting configuration suffices.

Source: Daria Poliakova, *More (shifted) runners, less loneliness*, Definition 5, Theorem 7 and Table 1, https://arxiv.org/html/2609.23952v1 .

===== overlap_packing.md =====
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

===== periodic_packing.md =====
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

===== bounded_local_rules.md =====
# A finite decision problem for affine local runner replacements

Fix an even limit $L$ on the removed or rephased even speeds and a target saving $g\ge1$. Consider Poliakova-type local rules with distinct added odd integer speeds, phases $a_i+h_i\delta$ independent of $N$, and the primitive-residue coverage test used in [the construction](overlap_packing.md). For this class, arbitrary real phase parameters and unbounded added speeds can be replaced by an explicit finite search. In fact the decision problem belongs to NP when $L$ is given in unary.

**Speed bound.** Let $Q$ be the set of affected even speeds and $M=\operatorname{lcm}(Q)$. There are at most $L/2-g$ added speeds. Within each occupied odd residue class modulo $M$, relabel the added speeds in increasing order by the smallest distinct positive members of the class. This decreases or preserves each speed $v$. At its new value $v'$ keep $a$ and take $h'=hv'/v$. For every $q\in Q$ the condition $vk/q+a\in\mathbb Z$ is unchanged; moreover $|(v'/q)z+h'|=(v'/v)|(v/q)z+h|$. Thus each replacement covers at least its previous set. The new odd speeds are distinct and at most $(L/2-g)M$. Rephased even speeds are unaffected by this reduction. When there are no added speeds the bound is vacuous.

**Phase bound.** Discard any added runner that never serves as a witness. A rephased even runner that never witnesses any obligation may be restored to its original zero phase, shrinking $Q$. Every remaining witnessing constant phase, taken modulo one, has the form $a=-vk/q\bmod 1$ for one of the finitely many primitive residues. In particular $Ma\in\mathbb Z$. One can use the $M$ of the original $Q$, or the larger universal $\operatorname{lcm}(2,4,\ldots,L)$.

**A common grid for the offsets.** Write $u_i=-h_i/v_i$. For $(q,k)$, all eligible witnesses have a fixed interval $[u_i-1/v_i,u_i+1/v_i]$ in the coordinate $z/q$; their union must cover $[-1/q,1/q]$. Choose from any feasible real solution, for each obligation, a simple chain of eligible intervals containing the left endpoint in the first, the right endpoint in the last, and with consecutive intervals intersecting. Such a chain exists by connectedness. Conversely every such chain gives a covering. All its constraints are differences of two centers bounded by sums of signed terms from $\{1/q,1/v_i\}$. Endpoint comparisons use a fixed center $u_0=0$.

Let $D=\operatorname{lcm}(Q\cup\{v_i\})$. Multiplying all these inequalities by $D$ makes their right sides integral. For any feasible scaled real centers the componentwise floors still satisfy every difference constraint: $x_i\le x_j+c$, $c\in\mathbb Z$, implies $\lfloor x_i\rfloor\le\lfloor x_j\rfloor+c$. The reference center stays zero. A common choice $u_i\in D^{-1}\mathbb Z$ therefore preserves all chain witnesses simultaneously. We may select each chain from the intervals meeting the target segment (truncate each interval to the target first); every used center then originally had $|u_i|\le1/2+1/v_i$. Unused witnesses can be discarded or restored as above. A grid representative with $|u_i|\le 1/2+1/v_i+1/D$ suffices.

**Certificate size.** There are at most $L/2$ distinct retained replacements, since the number added is at most the number removed minus $g$. The universal $M$ has $O(L\log L)$ bits from a product bound; after speed compression, $\log D=O(L^2\log L)$. Speeds, phases, and all grid centers have certificates of polynomial size in $L$. For each of at most $\sum_{q\le L}q$ primitive residues, an exact verifier sorts rational interval endpoints and checks coverage, distinctness and the gain. No list of chains need be submitted. This reduction is exhaustive for the specified local affine witness test. It gives no comparable bound for arbitrary 58-runner covers of the whole time circle.

Source for the rule class: [Poliakova, Definition 5 and Theorem 7](https://arxiv.org/html/2609.23952v1). The compatible-overlap construction uses much smaller explicitly listed speeds.

## Eliminating the grid search

The [API pivot argument](../../package1/api_runs/public_rule_001/answer.md) reduces the branching further. For each primitive row $r=k/q$, start at frontier $-1/q$ and stop at $1/q$. Pick an unfinished row with the smallest frontier $f$. Some unused runner in any completion must cover points immediately to the right of $f$ on this row. Anchor its intercept at $a=-vr\bmod1$ and move its common interval right until the left endpoint equals $f$, so $h=-1-vf$. The slide loses points only strictly below $f$, whereas all unfinished frontiers are at least $f$. Thus it preserves a completion. The compatible rows are exactly those with $\operatorname{den}(s-r)\mid v$. Advance their frontiers to the greater of the old value and $f+2/v$, capped at their right endpoint. Induction proves completeness and the updates directly prove soundness.

For this algorithm it suffices to retain the first $B$ available speeds of each class $\gcd(v,M)$, where $B$ is the runner budget. Such speeds have identical anchored incidence relations. Sort the speeds used in the class and replace them by its smallest available elements, reanchoring each intercept at a previously served row and preserving its interval's left endpoint. Old incidences are preserved and intervals grow. This gives fewer classes than the congruence compression above.

The [exact pivot search](local_pivot.py) includes all even speeds through $L$ and these representatives of **all** odd positive speeds, with budget $L/2-1$. All original even speeds through $L$ contribute their primitive rows, including those eventually left in place. Any saving rule of the stated class would induce such a cover (retained zero-phase runners directly meet their own obligations). At $L=12$ there are 24 primitive rows and 26 catalogue speeds; the search exhausts the tree with no cover by five. This therefore excludes gains for this class through $L=12$, with arbitrary real offsets and arbitrary added odd speeds. It does not decide the strict cutoff $L<192$. [Small exhaustive instances](local_pivot.jsonl)

===== packing.py =====
"""Verify three local rules from Poliakova and pack them at compatible scales.

Only integer sets and fractions enter the proof. Per coprime core, consider
multipliers 3^i*5^j and rule choices with unscaled threshold at most LIMIT.
"""
from fractions import Fraction as Q
from functools import lru_cache
from math import gcd
import json

# Removed speeds and groups (speeds, constant phase, coefficient of delta).
rules = [
    ([8,32,192], [([12,24,48,96],Q(1,2),Q(1,2)),([16,64],0,-1),([3,9],Q(1,4),0)]),
    ([8,32,36,40,72,180,192,240], [([12,24,48,60,96,108,120],Q(1,2),Q(1,2)),([16,64,80],0,-1),([216],0,-2),([3,9,27],Q(1,4),Q(1,4)),([15,45,135],Q(3,4),Q(1,4))]),
    ([4,16,20,36,40,64,72,240,384,432], [([12,24,48,96,192],Q(1,2),Q(1,2)),([60,108,120,216],Q(1,2),Q(-1,2)),([8,128],0,-1),([80,144],0,1),([32],0,Q(-3,2)),([3,45,81],Q(1,4),Q(-1,4)),([5,9],Q(1,4),Q(1,4)),([15,27],Q(1,4),0)])
]
LIMIT=6000


def rule_data(removed,groups):
    replacements={v:(a,b) for speeds,a,b in groups for v in speeds}
    affected=set(removed)|{v for v in replacements if v%2==0}
    obligations=0
    for q in sorted(affected):
        for k in range(q):
            if gcd(k,q//2)!=1:
                continue
            intervals=[]
            for v,(a,b) in replacements.items():
                if (Q(v*k,q)+a).denominator==1:
                    intervals.append((Q(q,v)*(-1-b),Q(q,v)*(1-b)))
            right=-1
            for lo,hi in sorted(intervals):
                if lo>right or right>=1:
                    break
                right=max(right,hi)
            assert right>=1, (q,k)
            obligations+=1
    velocities=affected|set(replacements)
    gain=len(removed)-sum(v%2 for v in replacements)
    return max(affected)//2,gain,velocities,obligations


def packing():
    options=[]
    obligations=[]
    for index,rule in enumerate(rules):
        threshold,gain,velocities,checked=rule_data(*rule)
        obligations.append(checked)
        power3=1
        while threshold*power3<=LIMIT:
            scale=power3
            while threshold*scale<=LIMIT:
                options.append((threshold*scale,gain,{v*scale for v in velocities},index,scale))
                scale*=5
            power3*=3
    options.sort(key=lambda item:(item[0],item[3],item[4]))
    conflicts=[sum(1<<j for j,y in enumerate(options) if x[2]&y[2]) for x in options]

    @lru_cache(None)
    def choose(mask):
        if not mask:
            return 0,()
        i=mask.bit_length()-1
        skip=choose(mask^(1<<i))
        gain,members=choose(mask&~conflicts[i])
        use=gain+options[i][1],members+(i,)
        return max(skip,use,key=lambda t:t[0])

    thresholds=[]
    certificates=[]
    for i,option in enumerate(options):
        best,members=choose((1<<(i+1))-1)
        if best>len(thresholds):
            thresholds.extend([option[0]]*(best-len(thresholds)))
            certificates.append(dict(threshold=option[0],savings=best,
              rules_and_scales=[(options[j][3]+1,options[j][4]) for j in members]))
            used=set()
            for j in members:
                assert not used.intersection(options[j][2])
                used.update(options[j][2])
    assert thresholds == [96,120,216,864,1080,3000,5400,5832]
    data = [rule_data(*rule) for rule in rules]

    def bundle(members):
        support = set()
        gain = 0
        threshold = 0
        for letter, scale in members:
            cost, saving, speeds, _ = data[letter-1]
            scaled = {scale*v for v in speeds}
            assert support.isdisjoint(scaled)
            support.update(scaled)
            gain += saving
            threshold = max(threshold, scale*cost)
        return threshold, gain, support

    ninth = [(3,1),(3,25),(1,45),(2,81)]
    assert bundle(ninth)[:2] == (9720,9)
    thresholds.append(9720)
    certificates.append(dict(threshold=9720,savings=9,rules_and_scales=ninth))
    # These three copies miss every previously constructed bundle multiplied by 5.
    threshold, gain, support = bundle([(1,1),(1,9),(1,81)])
    assert (threshold,gain) == (7776,3)
    assert all(v % 5 for v in support)
    head, cycle = thresholds[:6], thresholds[6:]
    assert 5*cycle[0] >= threshold and cycle[-1] < 5*cycle[0]
    alpha = Q(4,15)*(sum(Q(1,t) for t in head) + Q(5,4)*sum(Q(1,t) for t in cycle))

    residual = [sum(gcd(j,30)==1 for j in range(1,r+1)) for r in range(30)]
    deficit = max(Q(4*(r+1),15)-residual[r] for r in range(30))
    assert deficit == Q(14,15)
    slope = sum(Q(4*168,15*t) for t in thresholds[:3])
    assert slope > 1 and 3*deficit < 3 and 168*7 >= thresholds[4]
    def count(N):
        return sum(8*((N//t)//30)+residual[(N//t)%30] for t in thresholds)
    base_cases = [count(168*h) for h in range(1,7)]
    assert all(value >= h for h,value in enumerate(base_cases,1))
    return dict(obligations=obligations,local_search_limit=LIMIT,
                initial_thresholds=head, repeating_triple=cycle, scale_ratio=5,
                certificates=certificates, saved_fraction=str(alpha),
                liminf_En_over_n=str(alpha/(1-alpha)), inverse_asymptotic=float((1-alpha)/alpha),
                all_n_floor_denominator=167, small_h_counts=base_cases)

if __name__=="__main__":
    print(json.dumps(packing(),indent=2))

===== overlap_packing.py =====
"""Exact mixed-rule certificates with compatible shared speeds."""
import json
from fractions import Fraction as Q
from math import gcd
from pathlib import Path
from packing import rule_data, rules


def merged_rule(spec):
    removed = set()
    replacements = {}
    for letter,scale,half_shift in spec:
        base, groups = rules[ord(letter)-ord("A")]
        removed.update(scale*v for v in base)
        for speeds,a,b in groups:
            for v in speeds:
                speed=scale*v
                phase=((a+half_shift*(speed%2)*Q(1,2))%1,b)
                assert replacements.get(speed,phase)==phase
                replacements[speed]=phase
    removed.difference_update(replacements)
    groups=[([v],a,b) for v,(a,b) in replacements.items()]
    return rule_data(removed,groups)


def certificate():
    recipes=[
        [('A',1,0)], [('B',1,0)], [('C',1,0)],
        [('B',1,0),('B',5,1)],
        [('A',1,0),('A',9,0),('C',5,0)],
        [('A',1,0),('C',5,0),('C',9,0)],
        [('A',1,0),('A',5,0),('C',25,0),('C',27,0)],
        [('C',1,0),('C',25,0),('A',45,0),('B',81,0)]]
    thresholds=[]
    witnesses=[]
    for spec in recipes:
        cost,gain,support,checks=merged_rule(spec)
        assert all(prime_core(v)==1 for v in support)
        thresholds.extend([cost]*(gain-len(thresholds)))
        witnesses.append(dict(recipe=spec,threshold=cost,gain=gain,primitive_cases=checks))
    assert thresholds==[96,120,216,600,1080,1944,1944,5832,9720]
    threshold,gain,support,_=merged_rule([('A',1,0),('A',9,0),('A',81,0)])
    assert (threshold,gain)==(7776,3) and all(v%5 for v in support)
    head,cycle=thresholds[:6],thresholds[6:]
    assert threshold<=5*cycle[0] and cycle[-1]<=5*cycle[0]
    alpha=Q(4,15)*(sum(Q(1,t) for t in head)+Q(5,4)*sum(Q(1,t) for t in cycle))
    # At 1944 the gain jumps by two; the recursive triple starts with the seventh unit.
    def cores(n):
        return 8*(n//30)+sum(gcd(k,30)==1 for k in range(1,n%30+1))
    deficit=max(Q(4*(n+1),15)-cores(n) for n in range(30))
    slope=sum(Q(4*151,15*t) for t in thresholds[:7])
    assert (slope-1)*75>7*deficit
    for h in range(1,75):
        assert sum(cores(151*h//t) for t in thresholds)>=h
    return dict(recipes=witnesses,head=head,cycle=cycle,scale_ratio=5,saved_fraction=str(alpha),
                liminf_En_over_n=str(alpha/(1-alpha)),all_n_denominator=150,
                finite_floor_verified_through_h=74,large_h_slope=str(slope))


def prime_core(v):
    for p in (2,3,5):
        while v%p==0:
            v//=p
    return v


if __name__=='__main__':
    result=certificate()
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
    print(result['liminf_En_over_n'],result['all_n_denominator'])

===== periodic_packing.py =====
"""Turn the geometric saving thresholds into a periodic finite-size bound."""
from collections import Counter
from fractions import Fraction
from math import gcd, lcm
from pathlib import Path
import json


def certificate(head, cycle, ratio):
    if ratio != 5:
        raise ValueError("The coprime-core identity below removes powers of five.")
    rows = [(30, t) for t in head] + [(6, t) for t in cycle]
    period = lcm(*(mod * t for mod, t in rows))
    jumps = Counter()
    for mod, t in rows:
        for residue in range(1, mod):
            if gcd(residue, mod) == 1:
                jumps.update(range(t * residue, period + 1, t * mod))

    def gain(N):
        result = 0
        for mod, t in rows:
            cycles, remainder = divmod(N // t, mod)
            residues = [r for r in range(1, mod) if gcd(r, mod) == 1]
            result += cycles * len(residues) + sum(r <= remainder for r in residues)
        return result

    slope = Fraction(sum(jumps.values()), period)
    p, q = slope.as_integer_ratio()
    saved, worst, witness = 0, 0, 0
    for N, increase in sorted(jumps.items()):
        deficit = p * (N - 1) - q * saved
        if deficit > worst:
            worst, witness = deficit, N - 1
        saved += increase
    assert saved == gain(period) and p * period == q * saved
    assert p * witness - q * gain(witness) == worst
    assert p * period - q * gain(period) <= worst
    return dict(head=head, cycle=cycle, period=period, period_gain=saved,
                slope=str(slope), jump_positions=len(jumps), discrepancy_numerator=worst,
                witness_N=witness, witness_gain=gain(witness),
                excess_numerator=p, excess_denominator=q-p, excess_offset=q-1-worst)


if __name__ == '__main__':
    root = Path(__file__).resolve().parent
    data = json.loads((root / 'overlap_packing.json').read_text())
    result = certificate(data['head'], data['cycle'], data['scale_ratio'])
    assert result['slope'] == data['saved_fraction']
    from packing import rule_data, rules
    threshold, gain, support, _ = rule_data(*rules[0])
    assert (threshold, gain) == (96, 1)
    assert all(v % 5 for v in support)
    assert {v for v in support if v % 9 == 0} == {9} and 1 not in support
    first_new = threshold * 9**3
    extra_density = Fraction(4, 15 * first_new) * Fraction(9, 8) * Fraction(5, 4)
    improved = Fraction(result['slope']) + extra_density
    result['extra_saved_fraction'] = str(extra_density)
    result['expanded_layer_liminf'] = str(improved / (1 - improved))
    (root / 'periodic_packing.json').write_text(json.dumps(result, indent=2) + '\n')
    print(result)

===== optimal_extension.md =====
# Exactly optimizing the 58th runner with the published 57 fixed

Keep the speeds and phases of [the published seed](../../package1/results/known_slr_57.json) fixed. Over **all** new distinct positive integer speeds and **all** real phases, the least attainable covering radius for the resulting 58 runners is
$$
 d_*=\frac{1359451}{79000000}=0.0172082405063291\ldots .
$$
The only speed attaining this value is $528344$. Its allowable phases form the closed interval with left endpoint $4737613/31600000$ and length $178783/158000000$, modulo one. This improves the original radius by $63/395000000$. It remains $1207609/4661000000$ above the target $1/59$.

There is also a stability consequence. Allow each of the 57 original phases to move by at most $\epsilon$ turns, keeping their speeds and allowing an arbitrary 58th runner. The optimum is at least $d_*-\epsilon$, since restoring the old phases changes the minimum distance at each time by at most $\epsilon$. Strict escape thus needs a phase displacement greater than $1207609/4661000000$ turns, even after allowing a common change of time origin.

**Upper bound.** At $d_*$ form the complement of the closed arcs swept by the fixed seed, retaining its eleven positive-length gaps. Continuity lets us use their closures. For the new speed and the left endpoint of the stated phase interval, each full gap $[a,b]$ satisfies $-d_*\le va+s-k\le vb+s-k\le d_*$ for one integer $k$. This certifies the indicated radius over the whole time circle.

**All speeds and phases.** On any missing interval of length $w$ a single extra runner must fit it in one of its own connected arcs. Hence $v w\le2d_*$. The longest gap has length $53/1264000000$ and gives $v\le820800$. For each candidate velocity, order the gaps by decreasing length and write $a_0$ for the first left endpoint. In units of turns, set $u=s+va_0+d_*\pmod1$. The first gap forces $0\le u\le2d_*-v(b_0-a_0)$. Each other gap allows a window of length $2d_*-v(b-a)$ starting at $v(a_0-a)\pmod1$. Use its representative in $[-1/2,1/2]$; the widths and the range of $u$ are each at most $2d_*<1/4$. An exact intersection of closed intervals for each speed leaves only the single speed and the phase interval stated above. All comparisons after the initial gap calculation use integers.

**Sharp lower bound.** The fixed seed has an isolated limiting time
$$
 t_*=\frac{38586773}{79000000}
$$
where speeds 44 and 114 both attain $d_*$ and all other seed distances are at least $d_*$. At the left feasible phase of the extra runner its distance at $t_*$ is $66324111/158000000$; shifting within the feasible interval can lower this by at most $178783/158000000$. Thus every configuration attaining at most $d_*$ has distance at least $d_*$ there. The checker also explicitly forms the complement of the *open* seed arcs at $d_*$: it contains the eleven intervals and this isolated point. Even weak coverage of all twelve by one new runner is infeasible. Treating a zero-width gap as absent in this lower-bound step would give an incorrect optimum.

The floating search identified a chamber; only the independent full integer sweep and rational interval tests enter the certificate. [Verifier](optimal_extension.py) · [exact results](optimal_extension.json). This conditional optimum uses the upstream configuration credited to tomdif; the original 57 runners are fixed throughout.

===== optimal_extension.py =====
"""Sharp continuous-phase optimum for adding one arbitrary integer speed to the published seed."""
from bisect import bisect_left,bisect_right
from fractions import Fraction as Q
from math import floor, lcm
from pathlib import Path
import json
from frozen_extension import ROOT, gaps

HERE=Path(__file__).resolve().parent


def candidate(base):
    # Floating search only suggested this chamber; the verifier below is independent of it.
    d=Q('0.01720824051')
    v=528344
    approx=Q('0.15049025')
    endpoints={Q(0):(Q(0),Q(0)), Q(1):(Q(1),Q(0))}
    for w,num in zip(base['speeds'],base['shift_num']):
        s=Q(num,base['shift_den'])
        for k in range(w+2):
            center=(k-s)/w
            for slope in (Q(-1,w),Q(1,w)):
                endpoints[center+slope*d]=(center,slope)
    lows,highs=[],[]
    for a,b in gaps(base,d):
        ca,sa=endpoints[a]
        cb,sb=endpoints[b]
        k=round(v*(a+b)/2+approx)
        lows.append((k-v*ca,-v*sa-1))
        highs.append((k-v*cb,1-v*sb))
    assert all(j<0 for _,j in lows) and all(h>0 for _,h in highs)
    radius=max((i-k)/(h-j) for i,j in lows for k,h in highs)
    phase=max(i+j*radius for i,j in lows)
    # A gap can disappear at a seed maximum before the endpoint constraints bind.
    starts=sorted((c+j*d,c,j) for c,j in endpoints.values() if j<0)
    points=[t for t,_,_ in starts]
    possible=[radius]
    for ca,sa in endpoints.values():
        if sa<=0:continue
        right=ca+sa*d
        for _,cb,sb in starts[bisect_left(points,right-2*(d-radius)):bisect_right(points,right)]:
            event=(cb-ca)/(sa-sb)
            if radius<=event<=d:
                possible.append(event)
    for trial in sorted(set(possible)):
        trial_holes=gaps(base,trial)
        bounds=[(round(v*(a+b)/2+approx)-v*a-trial,
                 round(v*(a+b)/2+approx)-v*b+trial) for a,b in trial_holes]
        lower=max(lo for lo,hi in bounds)
        if lower<=min(hi for lo,hi in bounds):
            return v,lower%1,trial
    raise ValueError('No feasible event in the proposed chamber')


def strict_residual(base,d):
    # Complement of the *open* seed arcs, including isolated touching points.
    arcs=[]
    for v,num in zip(base['speeds'],base['shift_num']):
        phase=Q(num,base['shift_den'])
        for k in range(-1,v+2):
            a,b=(k-phase-d)/v,(k-phase+d)/v
            if a<=1 and b>=0:arcs.append((a,b))
    components=[]
    for a,b in sorted(arcs):
        if components and a<components[-1][1]:
            components[-1]=(components[-1][0],max(components[-1][1],b))
        else:components.append((a,b))
    bounds=[(b,a) for (_,b),(a,_) in zip(components,components[1:]) if 0<=b<=a<=1]
    if components[0][0]>=0:bounds.insert(0,(Q(0),components[0][0]))
    if components[-1][1]<=1:bounds.append((components[-1][1],Q(1)))
    return bounds


def all_extensions(base,d,strict=False):
    """All feasible phases at this radius for every integer speed, modulo one."""
    residual=strict_residual(base,d) if strict else gaps(base,d)
    holes=sorted(residual,key=lambda ab:ab[1]-ab[0],reverse=True)
    assert holes and 4*d<Q(1,2)
    length=holes[0][1]-holes[0][0]
    limit=floor(2*d/length)
    unit=lcm(d.denominator,*(x.denominator for ab in holes for x in ab))
    twice=int(2*d*unit)
    anchor=int(holes[0][0]*unit)
    intervals=[(anchor-int(a*unit),int((b-a)*unit)) for a,b in holes]
    existing=set(base['speeds'])
    hits=[]
    for v in range(1,limit+1):
        if v in existing:continue
        lo=0
        hi=twice-v*intervals[0][1]
        for offset,width in intervals[1:]:
            start=v*offset%unit
            if 2*start>unit:start-=unit
            lo=max(lo,start)
            hi=min(hi,start+twice-v*width)
            if lo>hi:break
        if lo<=hi:
            origin=-v*holes[0][0]-d
            hits.append((v,(origin+Q(lo,unit))%1,Q(hi-lo,unit)))
    return limit,len(holes),length,hits


def verify():
    base=json.loads((ROOT/'package1/results/known_slr_57.json').read_text())
    speed,phase,radius=candidate(base)
    assert radius<Q(base['gamma'])
    limit,pieces,length,hits=all_extensions(base,radius)
    assert len(hits)==1 and hits[0][0]==speed
    _,strict_pieces,_,strict_hits=all_extensions(base,radius,strict=True)
    assert all(width==0 for _,_,width in strict_hits)
    # Independently test direct coverage on each entire remaining time interval.
    for a,b in gaps(base,radius):
        k=round(speed*(a+b)/2+phase)
        assert -radius<=speed*a+phase-k<=speed*b+phase-k<=radius
    point=Q(38586773,79000000)
    seed_distances=[abs(z-round(z)) for w,num in zip(base['speeds'],base['shift_num'])
                    for z in [w*point+Q(num,base['shift_den'])]]
    assert min(seed_distances)==radius
    added=speed*point+hits[0][1]
    assert abs(added-round(added))-hits[0][2]>radius
    assert len(base['speeds'])==len(set(base['speeds']))==57 and speed not in base['speeds']
    result=dict(speed=speed,phase=str(phase),radius=str(radius),base_radius=base['gamma'],
                strict_improvement=str(Q(base['gamma'])-radius),target_gap=str(radius-Q(1,59)),
                unchanged_runners=57,uncovered_intervals=pieces,longest_interval=str(length),
                maximum_possible_speed=limit,feasible_speeds=len(hits),feasible_phase_start=str(hits[0][1]),feasible_phase_width=str(hits[0][2]),
                strict_residual_components=strict_pieces,weak_hits_on_strict_residual=len(strict_hits))
    return result


if __name__=='__main__':
    result=verify()
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))

===== residual_measure.md =====
# The published 57-runner configuration requires at least eight extra runners at radius 1/59

Keep all speeds and phases of the 57-runner certificate credited to tomdif in the public collection. Allow the extra runners arbitrary positive integer speeds and arbitrary real phases, even repeated speeds. At radius d=1/59, **seven extra runners still cannot cover the time circle**. In particular, deriving a 58-runner cover from this specific configuration by changing old runners and adding one requires **changing at least seven of the original runners**. Indeed if m originals were replaced, restoring them in addition to the proposed cover leaves the 57 originals and only m+1 new runners.

## A probability measure on uncovered times

Use Q=59,000,000. For each of the seed's 207 open holes (a,b) form the integer range [ceil(Qa),floor(Qb)] and give its interior the constant density listed in residual_weights.json (in increasing order of a). Divide coordinates by Q to return to the time circle. Endpoint choices have measure zero. Of these intervals 121 have positive density; the sum of the densities is W=303345. The sum of density times integer interval length is T=153120431. Normalize to total mass one. A second verifier checks that for each supported interval and each of the 57 original runners, the entire affine phase lies between j+d and j+1-d for one integer j. Thus the original cover has mass zero. Linear programming was used only to propose the integer densities.

For a new speed v and arbitrary phase, write U=2dQ=2000000. The allowed residues of v times the integer-grid time coordinate, modulo Q, lie in a sliding window of length U. Under this change of variable a component [a,b] becomes [va,vb] with a Jacobian 1/v. Each full period contributes exactly U units. The remaining arc on the circle contributes its intersection length with the window. Multiply each contribution by its corresponding integer density, sum and divide by vT.

The maximum over all continuous window positions is attained at a grid integer. Indeed the intersection length is piecewise affine and its only slope changes occur when either end of the sliding window meets a residual arc endpoint. All these coordinates are integers. For 1<=v<=59940 the exact maximum over all speeds and phases is

    beta = 20159589 / 153120431 = 0.1316583872...

It is attained at speed 160 with window starting at integer 9192800. The programs compute it by different operations: weighted_residual.py accumulates slope jumps in the sliding window, while check_residual_weights.py builds the phase-density prefix integral and subtracts it at each pair of window endpoints. The interval endpoints and comparisons use integer arithmetic. The declared 64-bit bounds cover all products in both procedures.

For v>=59941, each component's remaining partial period contributes at most U units. The mass is bounded by

    U/Q + U W/(vT) <= 7735870501306 / 77359044788527 < beta.

Every extra runner therefore covers at most beta of this probability mass. The union of seven has mass at most 7 beta = 141117123/153120431 < 1. This proves the claim. The calculation gives a necessary number of changes only. It supplies no 58-runner configuration and does not prove that eight extras would suffice.

Reproduce at the MathLab root with Python and NumPy:

    python3 research/runner/weighted_residual.py
    python3 research/runner/check_residual_weights.py

The optional --design flag additionally needs SciPy; it searches for weights and is unnecessary to check the stored certificate.

===== check_residual_weights.py =====
"""Independent exact verification via prefix integrals on the phase circle."""
import json
from fractions import Fraction
from math import ceil, floor
import numpy as np
from frozen_extension import ROOT
from weighted_residual import intervals, period, width, folder

def verify():
    base=json.loads((ROOT/'package1/results/known_slr_57.json').read_text())
    weights=np.array(json.loads((folder/'residual_weights.json').read_text()),dtype=np.int64)
    cert=json.loads((folder/'weighted_residual.json').read_text())
    lo,hi=intervals()
    selected=weights>0
    lo,hi,weights=lo[selected],hi[selected],weights[selected]
    assert len(lo)==cert['positive_intervals'] and np.all(hi>lo)
    assert np.all(lo[1:]>=hi[:-1])
    for a,b in zip(lo,hi):
        for v,shift in zip(base['speeds'],base['shift_num']):
            s=Fraction(shift,base['shift_den'])
            left=s+Fraction(v*int(a),period)
            right=s+Fraction(v*int(b),period)
            j=floor(left)
            assert left>=j+Fraction(1,59) and right<=j+1-Fraction(1,59)
    total=int((hi-lo)@weights)
    wsum=int(weights.sum())
    limit=cert['tested_through_speed']
    assert total==cert['total_weighted_length_units'] and wsum==cert['total_weight']
    assert 0<limit*total<2**62 and 8*period*wsum<2**62
    best=Fraction(0)
    for v in range(1,limit+1):
        a=(v*lo)%period
        whole,rem=np.divmod(v*(hi-lo),period)
        end=(a+rem)%period
        wrap=int(weights[a>end].sum())
        coords=np.concatenate(([0],a,end,[period]))
        increments=np.concatenate(([wrap],weights,-weights,[0]))
        order=coords.argsort()
        points,starts=np.unique(coords[order],return_index=True)
        density=np.add.reduceat(increments[order],starts).cumsum()
        integral=np.concatenate(([0],np.cumsum(np.diff(points)*density[:-1])))
        assert integral[-1]==rem@weights
        def primitive(t):
            cycles,t=np.divmod(t,period)
            pos=np.searchsorted(points,t,side='right')-1
            return cycles*integral[-1]+integral[pos]+(t-points[pos])*density[pos]
        cuts=np.concatenate((points[:-1],(points[:-1]-width)%period))
        mass=int((primitive(cuts+width)-primitive(cuts)).max())+width*int(whole@weights)
        best=max(best,Fraction(mass,v*total))
    tail=Fraction(width,period)+Fraction(width*wsum,(limit+1)*total)
    assert best==Fraction(cert['finite_speed_max'])
    assert tail==Fraction(cert['high_speed_upper_bound'])
    necessary=ceil(1/max(best,tail))
    assert necessary==cert['minimum_extra_runners']
    return dict(exact_fraction=str(best),necessary=necessary,verified_intervals=len(lo))

if __name__=='__main__':
    print(json.dumps(verify(),indent=2))

===== frozen_obstruction.md =====
# How many runners must change in the published 57-runner seed?

At radius d=1/59, even keeping all published 57 runners and appending two extra runners, both allowed arbitrary real phases and positive integer speeds with repetitions, cannot cover the whole unit circle. In particular a 58-runner construction derived from this seed must change at least two original runners. This condition refers to the specific rational seed, with the time origin fixed; translating a whole configuration in time is harmless.

For the original runners take the complement of the union of [(k-s-d)/v,(k-s+d)/v] on [0,1]. There are 207 positive-width gaps. Ignoring endpoints is harmless: a closed family covering a gap's interior covers its closure. A single new runner able to cover an interval of length L must have speed <=2d/L because each connected component of its time cover has width 2d/v. The largest gap has width 26269/295000000. This gives v<=380. Intersecting the allowed phase arcs for four gaps eliminates all unused speeds.

For two new runners with speeds v<=w, each covers at most 2dL+2d/v of an interval of length L: separate whole periods and a remainder of length less than a period, whose covered measure cannot exceed 2d/v. Adding the two bounds gives v<=4d/((1-4d)L), hence v<=816 using the largest gap. For each such v split the phase circle into 32 closed intervals with midpoint p and half-width 1/64. On an original gap of midpoint t and width l, the condition

    ||v t+p|| > d+1/64+v l/2

suffices for the slower runner to miss the entire gap throughout that phase interval. Retain only the 20 widest gaps. At least eight remain entirely missed in every box. The faster runner must cover the widest remaining gap, giving an explicit finite upper bound on w. For every pair of missed midpoints t_i,t_j, its necessary phase-independent condition is ||w(t_i-t_j)||<=2d. Exact rational tests discard all remaining w in every one of the 26112 boxes. All inequalities weaken the conditions for success, so an empty candidate set proves impossibility. A modification of one of the original runners followed by adding a runner would still cover after restoring the original runner as an extra, contradicting the two-runner result.

Run python3 research/runner/frozen_extension.py and python3 research/runner/two_runner_obstruction.py at the MathLab root. Both use fractions from the standard library. The input is tomdif's 57-runner certificate distributed in the public solved-conjectures collection, credited in package1/results/known_slr_57.json.

The upstream speed-changing search was separately replayed at version 60e47a0419d97deb104e72eb23692232430ce35f with SO=1007, MULT=0.6, VMX=4, RESET=999999, n=58 and four attempts. Only the path variables HERE and OFF in a3chain3.py were adapted. The best reported post-polish excess was -1.0000. No 58-runner certificate resulted. The independent cyclic-chain heuristic in chain_search.py reached an estimated excess of -0.666671 with 100 tested initial additions, also short of the strict target E>0.

===== replacement_surgery.md =====
# Deleting any two runners and inserting one

Two complete replacement tests at the original strict target gave the following exclusions.

| Target | Starting configuration | Removed pairs checked | Largest necessary new speed | Successful replacements |
|---:|---|---:|---:|---:|
| 58 | Speeds 1 to 59, all at phase zero | 1,711 | 170 | 0 |
| 94 | Poliakova's 95-runner construction, using its phases at $\delta=1/97$ | 4,465 | 580 | 0 |

In each row *any* two of the original runners can be removed. The inserted runner can have any positive integer speed distinct from the surviving speeds and any real phase, including one of the deleted speeds at a different phase. The speed bounds are derived separately for each pair. These exclusions apply to the indicated fixed phases of the survivors.

At target $d=1/(n+1)$ form the open arcs in the time circle of the starting system. Sweep their endpoints and record every open cell and every single endpoint covered by at most two original runners. For an endpoint, first remove the arcs ending there, record its current coverage, and only then insert the arcs starting there. Deleting a pair $i,j$ leaves exactly the recorded pieces whose previous coverage was contained in $\{i,j\}$. Merge their closures. If the largest residual interval has length $w>0$, the new speed must be at most $\lfloor2d/w\rfloor$. A new runner at speed $v$ must put its phase in the *open* window $(-va-d,-vb+d)$ modulo one for every residual $[a,b]$, including isolated points. Intersect those windows after normalization by the first left endpoint, as in the [sharp fixed-seed optimization](optimal_extension.md). The calculation uses integer and rational arithmetic. It covers the continuum and addresses strict improvement, even if a deletion pattern admits equality.

**Reflection reduction.** More generally, if the residual set $H$ is symmetric about time zero and $d<1/4$, a single extra runner that strictly covers $H$ at phase $s$ can be put instead at phase $0$ or $1/2$. For any $t\in H$ both $s+vt$ and $s-vt$ are within $d$ of integers $k,l$. Thus $s$ is within $d$ of $(k+l)/2$. Modulo one this choice between $0$ and $1/2$ is unique and independent of $t$. After recentering, both $s-(k+l)/2$ and $vt-(k-l)/2$ are obtained by adding or subtracting the two signed errors and dividing by two. Indeed their absolute values sum to the maximum absolute error. The new phase therefore covers every $t$, with at least the same slack. A time translation gives the version for any reflection center. This simplification applies to the first test; the verifier treats continuous phases directly in both tests.

[Exact verifier](single_replacement.py) · [full configurations and results](single_replacement.json) · [Poliakova's source construction](https://arxiv.org/html/2609.23952v1).

## Three deletions and two unrestricted replacements

Tested twelve triples in each starting configuration, allowing both new runners to choose distinct positive integer speeds and arbitrary real phases. To select the triples reproducibly, rank them by the number of positive-length cells exposed before merging, breaking ties by seed order. All 24 tests exclude strict improvement for the specified survivors. For example, deleting speeds 1, 2 and 6 from the 59-runner seed leaves eight intervals. Deleting speeds 2, 3 and 9 from the 95-runner seed leaves twelve. These results concern only the listed triples.

For slower speed $v$ and faster speed $w$, a component of the residual cannot span two slow bands, since a complete gap between them is longer than any fast band. Thus a residual component of length $L$ requires $L<2d/v+4d/w$. Testing its two end portions gives a necessary circular interval for the slow phase, shrinking as $w$ grows. The solver returns a global exclusion only when a length bound or an empty intersection rules out all higher speeds. Its fallback speed cap was 2500. None of the 24 results depended on truncation.

For each surviving speed pair the solver partitions the two-dimensional phase space into rectangles where the relevant winding indices are fixed. A missed time is a common point of three closed intervals: a residual component and one gap of each runner. Their pairwise intersection conditions give closed forbidden intervals for the single coordinate $ws-vb$, where $s,b$ are the two phases. A strict cover of a compact set persists under small phase perturbations, so testing the open phase rectangles suffices, including when a residual time component is a singleton.

[Astra's search implementation](two_speed_search.py) · [reproduce the selected triples](triple_replacement.py) · [results by triple](triple_replacement.json).

===== two_speed_search.py =====
#!/usr/bin/env python3
"""
Exact two-speed cover search. Python 3, standard library only; no Z3 needed.

Usage:
    python3 two_speed_search.py --self-test
    python3 two_speed_search.py --max-speed 200 < problem.json

JSON fields: "H" is a list of [left, right] pairs, "d" is a rational,
and "forbidden" is an optional list of positive integers. Rationals may
be integers, fraction strings such as "3/17", or exact decimal strings.
JSON decimal numbers are also parsed directly as Fractions.

Python API:
    fixed_phases(H, d, v, w) -> (Fraction, Fraction) or None
    search(H, d, forbidden, max_speed) -> result dictionary

Results:
    FOUND               A verified strict cover; both speeds <= max_speed.
    IMPOSSIBLE          The filters and search prove global nonexistence.
    NO_PAIR_WITHIN_CAP  Exhaustive for v < w <= max_speed, incomplete globally.

The resource bound is a speed cap, not a wall-clock timeout. No phase solver
call returns "unsatisfiable" merely because a resource limit was reached.
"""

import argparse
import json
import sys
from fractions import Fraction as F
from math import ceil, floor, gcd

ZERO, ONE = F(0), F(1)


def _rat(x):
    if isinstance(x, bool) or not isinstance(x, (int, str, F)):
        raise ValueError("use integers, rational strings, or Fractions, not floats")
    return F(x)


def _posint(x):
    if type(x) is not int or x <= 0:
        raise ValueError("expected a positive integer")
    return x


def _normalize(H, d):
    d = _rat(d)
    if not ZERO < d < F(1, 4):
        raise ValueError("require 0 < d < 1/4")
    merged = []
    for a, c in sorted((_rat(a), _rat(c)) for a, c in H):
        if not ZERO <= a <= c <= ONE:
            raise ValueError("require 0 <= left <= right <= 1")
        if merged and a <= merged[-1][1]:
            merged[-1] = (merged[-1][0], max(c, merged[-1][1]))
        else:
            merged.append((a, c))
    if not any(a < c for a, c in merged):
        raise ValueError("H needs a positive-length interval")
    return merged, d


def _hole(lo, hi, closed_blocks):
    """Rational point of (lo,hi) outside all closed blocks, or None."""
    blocks = []
    for a, c in closed_blocks:
        if a <= lo and hi <= c:
            return None
        if a < hi and lo < c:
            blocks.append((a, c))
    edge = lo
    for a, c in sorted(blocks):
        if edge < a:
            return (edge + a) / 2
        edge = max(edge, c)
        if edge >= hi:
            return None
    return (edge + hi) / 2


# ---------------------- Complete fixed-speed solver ----------------------

def _axis_cells(H, d, u):
    """
    For phase x, speed u misses the CLOSED time gaps
        G_k = [(k+d-x)/u, (k+1-d-x)/u].
    G_k meets [a,c] iff u*a+x-1+d <= k <= u*c+x-d, including equality.
    The integer index range is constant between the following phase cuts.
    """
    cuts = {ZERO, ONE}
    for a, c in H:
        cuts.add((-u*a - d) % 1)
        cuts.add((d - u*c) % 1)
    cuts = sorted(cuts)
    for left, right in zip(cuts, cuts[1:]):
        x = (left + right) / 2
        ranges = [(ceil(u*a + x - 1 + d), floor(u*c + x - d))
                  for a, c in H]
        yield left, right, ranges


def _blocked_z(d, v, w, slow_ranges, fast_ranges):
    """
    Inside an open phase rectangle, emit closed forbidden intervals for
    z = w*s - v*b.

    For a given H component, the index ranges already say that both gaps
    meet that component. Three closed real intervals have a common point
    iff they intersect pairwise. Thus all that remains to test is whether
    slow gap k and fast gap j meet each other. This is exactly
        w*(k+d)   - v*(j+1-d) <= z
      <= w*(k+1-d) - v*(j+d).

    For fixed k, consecutive j shift these blocks by v, but each block has
    length (v+w)*(1-2*d) > v. Their union is ONE closed interval, even if
    the fast speed gives millions of gap indices on the component.
    """
    for (k0, k1), (j0, j1) in zip(slow_ranges, fast_ranges):
        if k0 > k1 or j0 > j1:
            continue
        left = w*d - v*(j1 + 1 - d)
        right = w*(1 - d) - v*(j0 + d)
        # The block for k is [left+w*k, right+w*k].
        if right - left >= w:
            yield left + w*k0, right + w*k1
        else:
            for k in range(k0, k1 + 1):
                yield left + w*k, right + w*k


def _solve(H, d, v, w, slow_cells=None):
    """
    It is complete to use only OPEN phase rectangles: for a strict cover,
    the maximum on compact H of the minimum of the two distances is < d.
    Small phase perturbations preserve that margin. By periodicity we can
    therefore avoid every phase cut, including 0 mod 1. This argument does
    NOT discard time endpoints; _blocked_z treats time gaps as closed.
    """
    if slow_cells is None:
        slow_cells = list(_axis_cells(H, d, v))
    for b0, b1, js in _axis_cells(H, d, w):
        for s0, s1, ks in slow_cells:
            # Exact image of the open rectangle under z = w*s - v*b.
            lo, hi = w*s0 - v*b1, w*s1 - v*b0
            z = _hole(lo, hi, _blocked_z(d, v, w, ks, js))
            if z is not None:
                # Lift z to a rational point inside that rectangle.
                left = max(s0, (z + v*b0) / w)
                right = min(s1, (z + v*b1) / w)
                assert left < right
                s = (left + right) / 2
                return s, (w*s - z) / v
    return None


def fixed_phases(H, d, v, w):
    """Complete decision and rational witness for the specified speeds."""
    H, d = _normalize(H, d)
    if not _posint(v) < _posint(w):
        raise ValueError("require v < w")
    return _solve(H, d, v, w)


def _verify(H, d, v, w, s, b):
    """Independent witness check, including singletons and gap endpoints."""
    for a, c in H:
        for k in range(floor(v*a + s) - 1, floor(v*c + s) + 1):
            p = max(a, (k + d - s) / v)
            q = min(c, (k + 1 - d - s) / v)
            if p <= q:
                # The whole closed slow-missed segment [p,q] must lie in
                # ONE open fast window. Its center index must be an integer
                # strictly between w*q+b-d and w*p+b+d.
                if floor(w*q + b - d) + 1 >= w*p + b + d:
                    return False
    return True


# ------------------ Necessary tests before phase solving ------------------

def _slow_phase_possible(rows, v, f):
    """
    f = 2*d/w is a fast window's length. A covered connected [a,c]
    meets at most one slow window: otherwise a whole closed slow gap of
    length (1-2*d)/v > f would have to fit inside one open fast window.

    If c-a >= f, [a,c] MUST meet a slow window, say (p,q). We need
    p < a+f and q > c-f: any wing outside that window, INCLUDING the
    slow boundary point, has to fit in an open fast window. In phase
    coordinates this requires, modulo 1,
        -d-v*a-v*f < s < d-v*c+v*f.
    All such requirements must hold for the SAME s. Failure is monotone
    as w increases: more rows qualify, and the allowed arcs only shrink.
    """
    bad = []
    margin = v*f
    for length, left0, right0 in rows:
        if length < f:
            continue
        left, right = left0 - margin, right0 + margin
        width = right - left
        if width <= 0:
            return False
        if width > 1:
            continue
        # Complement of (left,right) mod 1 is a CLOSED circular arc.
        # For width == 1 it is a single forbidden point, not an empty arc.
        start = right % 1
        end = start + 1 - width
        bad.append((start, end))
        if end >= 1:
            bad.append((start - 1, end - 1))
    # A nonempty intersection of finitely many open arcs cannot consist
    # solely of s == 0 mod 1.
    return _hole(ZERO, ONE, bad) is not None


def search(H, d, forbidden, max_speed):
    H, d = _normalize(H, d)
    banned = {_posint(u) for u in forbidden}
    cap = _posint(max_speed)
    L = max(c - a for a, c in H)

    # Write S=2*d/v, f=2*d/w. By the one-slow-window argument above,
    # a covered component has length < S+2*f (two wings each < f);
    # if it misses all slow windows it even has length < f. Since w>v,
    # necessarily L < 6*d/v. Strict bounds use ceil(bound)-1.
    vmax = ceil(6*d / L) - 1
    global_done = vmax <= cap
    calls = 0

    for v in range(1, min(vmax, cap) + 1):
        if v in banned:
            continue
        S = 2*d / v
        wmax = ceil(4*d / (L - S)) - 1 if L > S else None
        limit = cap if wmax is None else min(cap, wmax)
        rows = [(c-a, -d-v*a, d-v*c) for a, c in H]
        slow_cells = None

        for w in range(v + 1, limit + 1):
            if w in banned:
                continue

            # Over a full common period 1/g the two speeds cover, counting
            # even their overlap twice, only a fraction 4*d < 1.
            if gcd(v, w)*L >= 1:
                continue

            f = 2*d / w
            if L >= S + f:
                # One wing alone cannot suffice on a longest component.
                # Its two endpoints lie in distinct fast windows, n periods
                # apart. Endpoint separation gives L < n/w + f. Both fast
                # windows must reach across the respective slow boundaries,
                # so the gap n/w - f between them is strictly less than S.
                # Reject if there is no integer w*(L-f) < n < w*(S+f).
                if floor(w*(L-f)) + 1 >= w*(S+f):
                    continue

            if not _slow_phase_possible(rows, v, f):
                break  # proves failure also for every larger w at this v

            if slow_cells is None:
                slow_cells = list(_axis_cells(H, d, v))
            calls += 1
            ans = _solve(H, d, v, w, slow_cells)
            if ans is not None:
                s, b = ans
                if not _verify(H, d, v, w, s, b):
                    raise AssertionError("internal error: invalid witness")
                return dict(status="FOUND", v=v, w=w, s=s, b=b,
                            max_speed=cap, phase_calls=calls)
        else:
            # No monotone rejection terminated this v's loop. If the
            # analytic w bound ran past the cap, don't claim global failure.
            if wmax is None or wmax > cap:
                global_done = False

    return dict(status="IMPOSSIBLE" if global_done else "NO_PAIR_WITHIN_CAP",
                max_speed=cap, phase_calls=calls)


def self_test():
    d = F(1, 8)

    # v=1,w=2: a length just below 3/8 works with overlapping windows;
    # length exactly 3/8 cannot be obtained by merely touching them.
    H = [(ZERO, F(37, 100))]
    ans = fixed_phases(H, d, 1, 2)
    assert ans is not None and _verify(H, d, 1, 2, *ans)
    H = [(ZERO, F(3, 8))]
    assert fixed_phases(H, d, 1, 2) is None
    assert search(H, d, [], 3)["status"] == "IMPOSSIBLE"

    # With these specific phases, t=0 is a missed endpoint although the
    # slow window covers the entire open interior.
    assert not _verify([(ZERO, F(1, 4))], d, 1, 2, -d, F(1, 2))

    # Forbidden speed, isolated point, and an incomplete global outcome.
    H = [(ZERO, F(1, 8)), (F(1, 2), F(1, 2))]
    assert search(H, d, [2], 2)["status"] == "NO_PAIR_WITHIN_CAP"
    r = search(H, d, [2], 3)
    assert r["status"] == "FOUND" and (r["v"], r["w"]) == (1, 3)
    assert _verify(H, d, 1, 3, r["s"], r["b"])
    print("self-test passed")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Exact strict two-speed cover")
    parser.add_argument("--self-test", action="store_true")
    parser.add_argument("--max-speed", type=int)
    args = parser.parse_args()
    if args.self_test:
        self_test()
    else:
        if args.max_speed is None or args.max_speed < 1:
            parser.error("supply a positive --max-speed")
        obj = json.load(sys.stdin, parse_float=F)
        result = search(obj["H"], obj["d"], obj.get("forbidden", []),
                        args.max_speed)
        print(json.dumps(result, default=str, indent=2))

===== endpoint_boxes.md =====
# An exact test for coordinated phase changes

For a fixed list of distinct positive integer speeds let $d=1/59$. A strict escape has $\min_i\|v_i t+s_i\|<d$ for every time. The bad-time arcs for runner $i$ are open; their right endpoints are $(k+d-s_i)/v_i$ for $0\le k<v_i$. A finite nonempty family of open arcs covers the circle if and only if every right endpoint lies in some other arc. An uncovered component has an uncovered arc endpoint on its boundary; this also detects isolated uncovered points. Compactness turns the pointwise strict inequality into a strictly smaller maximum.

Let the phases in a box be $s_i-v_i y_i$, where $s_i$ is fixed and $|y_i|\le\epsilon/v_i$. At each original endpoint $e=(k+d-s_i)/v_i$ the constraint becomes the following disjunction:
$$
 \frac{l-s_j-v_j e-d}{v_j}<y_i-y_j<
 \frac{l-s_j-v_j e+d}{v_j}
 \qquad(j\ne i,\ l\in\mathbb Z).
$$
Only integers $l$ whose interval intersects the permitted delay-difference range need be considered. Every disjunct is a pair of difference inequalities. This tests all continuous times and all continuous phases in the specified box.

**Exact integer encoding.** Let $D$ be the lcm of the denominators of $d,\epsilon,s_1,\ldots,s_n$ times the lcm of the speeds. All difference bounds and box endpoints scaled by $D$ are integers. After selecting a disjunct per endpoint, introduce a zero reference node for box constraints; every directed simple cycle has at most $n+1$ edges. Feasibility means a cycle has nonnegative weight and a cycle containing any strict edge has positive weight. For a real feasible selection, the latter cycles therefore have at least one integer unit of slack. Tighten every strict bound by $1/(n+1)$ in scaled coordinates. No cycle becomes negative. Multiplication by $n+1$ now gives a feasible system of non-strict integer-weight bounds, with integer shortest-path potentials. Shift the reference to zero. Thus a solution exists on the grid $1/((n+1)D)$ whenever any real solution exists. Conversely each such tightened solution satisfies the original strict inequalities.

**Results for 58 runners.** The exact integer-difference solver returned infeasible for the standard speeds $1,\ldots,58$ when every phase may move simultaneously by up to $3/125$ turns about zero, and for the locally optimized 58-runner speed set when all 58 phases may move simultaneously by $1/32$ turns about the exact nominal phases stored in the certificate. A common translation of time preserves each conclusion. A direct real-arithmetic encoding independently returned infeasible on just 203 endpoints of the standard box at half-width $1/50$. The larger two boxes have an integer-solver result; the second real-arithmetic encoding timed out on those two boxes. Solver timeouts at larger boxes give no exclusion. The five-speed positive control produced rational phases strictly below $1/6$ by independent full interval coverage, and the four-speed control excluded strict improvement below $1/5$ on the full phase torus.

[Standard box](standard58_box.json) · [58-runner search box](chain58_box.json) · [203-endpoint real replay](standard58_core.json) · [integer solver](endpoint_solver.py) · [independent formulation](check_endpoint_boxes.py). Run the integer solver with the indicated nominal base and half-width; the core can be replayed directly by the real verifier. The local checks used the Z3 Python package 5.4.1.0.

The [API derivation](../../package1/api_runs/tight_orbit_001/answer.md) gives the unshifted-coordinate endpoint criterion and a separate sign-alternation proof for a smaller tube. Difference constraints for shifted-runner coverage also appear in [Blanco, Criado and Santos, §5](https://arxiv.org/html/2603.24784v1). The computed boxes are specific to the stored speed/phase data.

===== endpoint_solver.py =====
"""Exact continuous-time, continuous-phase decision at a strict covering radius."""
import argparse
from fractions import Fraction as Q
from math import ceil, floor, lcm
from pathlib import Path
import json
from z3 import And, Bool, BoolVal, Implies, Int, Or, SolverFor, sat, unsat
from frozen_extension import ROOT,gaps

HERE=Path(__file__).resolve().parent


def solve(speeds,phases,eps,d,seconds,extract=False):
    n=len(speeds)
    assert 0<d<Q(1,2) and len(set(speeds))==n
    unit=lcm(*(x.denominator for x in [d,eps,*phases]))*lcm(*speeds)*(n+1)
    # Every allowed delay difference has endpoints on the coarser grid unit/(n+1).
    def integer(x):
        num=x*unit
        assert num.denominator==1
        return num.numerator
    delay=[Int(f'y{i}') for i in range(n)]
    box=[eps/v for v in speeds]
    slv=SolverFor('QF_IDL')
    slv.set(timeout=int(seconds*1000))
    for y,b in zip(delay,box):
        slv.add(y>=integer(-b),y<=integer(b))
    clauses=0
    tracked=[]
    labels={}
    for i,v in enumerate(speeds):
        for k in range(v):
            e=(k-phases[i]+d)/v
            choices=[]
            automatic=False
            for j,w in enumerate(speeds):
                if j==i:continue
                b=box[i]+box[j]
                a=w*e+phases[j]
                for h in range(ceil(a-d-w*b),floor(a+d+w*b)+1):
                    left,right=(h-a-d)/w,(h-a+d)/w
                    if left < -b and b < right:
                        automatic=True
                        break
                    if left>=b or right<=-b:continue
                    pred=[]
                    if left>=-b:pred.append(delay[i]-delay[j]>=integer(left)+1)
                    if right<=b:pred.append(delay[i]-delay[j]<=integer(right)-1)
                    choices.append(And(pred))
                if automatic:break
            if not automatic:
                clauses+=1
                clause=Or(choices) if choices else BoolVal(False)
                if extract:
                    name=Bool(f'row_{i}_{k}')
                    slv.add(Implies(name,clause))
                    tracked.append(name)
                    labels[str(name)]=(i,k)
                else:
                    slv.add(clause)
    verdict=slv.check(*tracked)
    result=dict(status=str(verdict),endpoint_clauses=clauses,total_endpoints=sum(speeds),
                phase_halfwidth=str(eps),radius=str(d))
    if verdict==sat:
        model=slv.model()
        final=[(s-v*Q(model.eval(y,model_completion=True).as_long(),unit))%1
               for s,v,y in zip(phases,speeds,delay)]
        den=lcm(*(s.denominator for s in final))
        candidate=dict(n=n,speeds=speeds,shift_num=[int(s*den) for s in final],shift_den=den)
        assert not gaps(candidate,d)
        # Find a strictly smaller rational radius, independently of strict SMT inequalities.
        shrink=Q(1,1000000)
        while gaps(candidate,d-shrink):
            shrink/=2
            assert shrink>Q(1,unit**3)
        result.update(candidate=candidate,verified_radius=str(d-shrink))
    elif verdict==unsat and extract:
        result['infeasible_endpoints']=[labels[str(lit)] for lit in slv.unsat_core()]
    elif verdict!=unsat:result['reason']=slv.reason_unknown()
    return result


if __name__=='__main__':
    p=argparse.ArgumentParser()
    p.add_argument('--base',choices=['chain','standard'],default='chain')
    p.add_argument('--n',type=int,default=58)
    p.add_argument('--eps',default='1/100')
    p.add_argument('--radius',default='1/59')
    p.add_argument('--core',action='store_true')
    p.add_argument('--seconds',type=int,default=30)
    p.add_argument('--out',type=Path,required=True)
    args=p.parse_args()
    if args.base=='chain':
        data=json.loads((HERE/'chain_best.json').read_text())
        speeds=data['speeds']
        phases=[Q(round(x*10**7),10**7) for x in data['shifts']]
    else:
        speeds=list(range(1,args.n+1))
        phases=[Q(0)]*args.n
    r=solve(speeds,phases,Q(args.eps),Q(args.radius),args.seconds,args.core)
    r.update(base=args.base,speeds=speeds,original_phases=list(map(str,phases)))
    args.out.write_text(json.dumps(r,indent=2)+'\n')
    print(r['status'],r.get('verified_radius'),r['endpoint_clauses'],flush=True)
