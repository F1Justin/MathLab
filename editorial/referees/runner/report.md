**Referee verdict.** I would separate the large-\(n\) theorem from the obstructions near a particular seed. The packing theorem has a sound local-to-global proof, including the improvement using *all* the \(A_{9^i}\). Its coefficients are coefficients of specified constructions, not optimal SLR coefficients. The finite affine-rule reduction also works, with an important qualification about what counts as a witness. The single-seed optimum and the weighted obstruction have good finite reductions; their numerical conclusions depend on data not in the enclosure. The two-speed strict phase test is substantially stronger than a phase-grid search and appears sound, including at lattice equalities. The phase-box results should be reported as exact encodings with **computed solver verdicts**.

I have not executed the programs or browsed the sources. Below I distinguish checks that can be made from the transcribed tables, reproducible finite tests, and numbers for which I would require the missing artifacts. None of these results decides \(n=58\).

## 1. Packing: locality, gain, and the coefficients

**Primitive residues.** Write \(\gamma=\max_t\min_i\|v_it+s_i\|\). The circular-spacing argument on \(0,2t,\ldots,2Nt\) gives \(\gamma\le\delta=1/(N+1)\) for the seed, including in the case of a tie. Use the *least speed*, not an arbitrary covering seed runner, to assign each \(t\). If this speed is \(qb\) and \(qbt=k+\delta z\), \(|z|\le1\), then
\[
p\mid k,\quad p\mid q/2,\quad p>1
\quad\Longrightarrow\quad
qb/p\text{ is in the even seed and }\|(qb/p)t\|\le\delta/p .
\]
This is a contradiction. The conclusion is \(\gcd(k,q/2)=1\), **not** necessarily \(\gcd(k,q)=1\). One need not impose any condition involving factors of \(b\). Reducing \(k\) modulo \(q\) is legitimate. A replacement of speed \(vb\) has coordinate
\[
vk/q+a+\delta((v/q)z+h).
\]
Thus integrality of the first term and coverage of \(z\) by the indicated closed interval are sufficient, with no asymptotic approximation or error near a residue boundary. This is a sufficient witness test; it need not characterize all ways real runner configurations cover.

For the transcribed \(A,B,C\), useful checksums are:

| rule | largest affected even | net deleted evens before adding odds (single rule) | added odds | primitive \((q,k)\) tests |
|---|---:|---:|---:|---:|
| \(A\) | 192 | 3 | 2 | 184 |
| \(B\) | 240 | 8 | 6 | 536 |
| \(C\) | 432 | 10 | 7 | 882 |

The last column counts \(\sum_{q\ {\rm affected}}2\varphi(q/2)\). The finite check in `rule_data` has the correct direction: initialize the reached point to \(-1\), sort by left endpoints, stop on a **strict** gap, and require reaching \(1\). Use both removed and rephased evens as obligations, not just removed evens. I would add input assertions that no single-rule table assigns two phases to one speed and that its removed list is disjoint from its replacement list; a dictionary comprehension is not itself a check of this.

**Translations and sharing.** Under \(t\mapsto t+1/2\) a phase gains \(v/2\bmod 1\); it does not gain \(1/2\) for every runner. All even seed phases are unchanged. The primitive tests are permuted (\(k\) is shifted by a multiple of \(q/2\) at an affected even); the offset \(h\) is unchanged. The scales in question are odd. Translating one local rule in this way is legitimate *before merging*; there is no need for a time translation that changes one physical copy of a shared runner but not the other. There must be just one consistent assignment in the final table.

Here are independent gain checks for the decisive overlaps:

* For \(B_1,B_5\) the removal lists share \(40,180\); \(240\) is removed in one list but needed as a replacement. The net deletion is \(16-2-1=13\) evens. The shared rephased evens are \(60,80,120\); the shared odds are \(15,45,135\). The latter acquire exactly the required constant after the half-shift on \(B_5\), and the coefficients of \(\delta\) agree. There are \(12-3=9\) new odds, hence gain \(4\), not a gain obtained by counting two assignments to a speed.
* For \(A_1,C_5,C_9\), the two scaled \(C\)'s share removals \(180,360,2160\), rephased evens \(540,720,1080\), and odds \(45,135,405\), with matching assignments. The \(A\) support is separate. This gives \(20\) net deleted evens and \(13\) new odds, gain \(7\).

In general the net deletion set is \((\bigcup R_i)\setminus(\bigcup V_i)\), where \(V_i\) are the replacement speeds. Leave all other non-rephased seed evens alone. Replacements even in one rule and removed in another need not be deleted. The merged primitive test in `overlap_packing.py` is a particularly good way of avoiding a tacit assumption about such speeds. For disjoint bundles it is enough to check the intersection of **whole supports**, including the removed speeds. All listed support entries have no prime factor outside \(2,3,5\); stripping these primes from a touched speed uniquely recovers the core \(c\). This separates different cores. Added odds cannot inadvertently duplicate untouched seed evens.

**Threshold profiles.** A list of thresholds is a list for *units of gain*, not a list of operations all to perform at once. At each core take one highest feasible recipe. In particular:

* In the overlap profile \(1944\) accounts for units six **and** seven. The sixth is a head term, the seventh is a cycle term.
* At \(9720\) one can take the seven-unit recipe scaled by \(5\), plus the three \(A\)'s. Gain ten is feasible there. The two entries at \(9720\) do not mean superposing the nine-unit recipe and another overlapping recipe.
* If \(S\) is the given support of \(A\), an intersection of \(9^i S\) with \(9^{i+k}S\), \(k>0\), would give \(s=9^k s'\) in \(S\). The only candidate \(s\) is \(9\), and \(s'=1\) is absent. These sets miss the entire \(5\)-scaled subrecipe since they are prime to \(5\).

For clarity, here is a proof of the improved recurrence. Let \(g\) count the old overlap thresholds at \(x\), and define \(g'\) by the improved construction. For \(x\ge9720\), all six heads are reached even at \(x/5\), and the three unscaled cycle thresholds are reached at \(x\). Cancelling the rest of the cycles gives \(g(x)-g(x/5)=3\), **including equality** at \(9720\). Use
\[
g'(x)=g'(x/5)+\#\{i\ge0:96\cdot 9^i\le x\}
\]
there, and \(g'=g\) below the cutoff. This is an attainable gain by the support argument. The first three \(i\)'s cancel the \(3\) in the old recurrence. The first extra threshold \(96\cdot9^3\) is already above the cutoff. Iteration therefore gives exactly the extra threshold multiset \(96\cdot 9^i5^j\), \(i\ge3,\ j\ge0\), for this accounting. This explains why counting the extra \(A\)'s just once, or using the recurrence below its cutoff without proof, would be wrong.

**Densities and conversion to \(E_n\).** For a finite threshold multiset \(T\), count \(\sum_{t\in T} C_{30}(N/t)\), with multiplicities. The eight residues give the stated supremum deficit \(14/15\) (take the left limits at the residues). For \(a=(4/15)\sum_{t\in T}1/t\), \(D=14|T|/15\), the saving is at least \(aN-D\). With \(N=n+h\), one needs \((1-a)h\le an-D\), so the indicated floor when positive is safe. At \(h=0\) use the unmodified seed if necessary. A saving **at least** \(h\) suffices: pad by never-used distinct positive speeds. Then the infimal radius is at most \(1/(n+h+1)\), in the direction giving \(E_n\ge h\).

Taking fixed prefixes and *then* a supremum of liminf bounds is valid. Alternatively \(C_{30}(N/t)/N\le1/t\) gives summable domination for all the stated lists. Thus the densities are the actual limits of the **threshold counts divided by \(N\)**, not just formal infinite sums. My arithmetic for (saved fraction, excess slope) is
\[
\begin{array}{c|cc}
 &\alpha&\alpha/(1-\alpha)\\ \hline
\text{disjoint}&76897/10935000&76897/10858103\\
\text{compatible}&8011/1093500&8011/1085489\\
\text{expanded layers}&513079/69984000&513079/69470921.
\end{array}
\]
Indeed the increment in the last saved fraction is
\((4/15)(96\cdot9^3)^{-1}(9/8)(5/4)=1/186624\). None of this is an upper bound on what different recipes, different rules, or SLR itself can do.

For the uniform floors, the disjoint calculation uses \(N\ge168h\); the first three terms exceed \(h-3\), hence contribute at least \(h-2\). Both additional terms are present from \(h=7\) on. The counts \(2,3,3,4,5,6\) for the small cases use the profile including the fourth term. For overlap, the linear estimate with seven terms at \(151h\) works from \(75\) on. The small check can be reproduced just by
```
R = (1,7,11,13,17,19,23,29)
C = lambda u: 8*(u//30) + sum(r <= u%30 for r in R)
T = (96,120,216,600,1080,1944,1944,5832,9720)
assert all(sum(C((151*h)//t) for t in T) >= h for h in range(1,75))
```
There is some limited tightness here: the disjoint list has only four units at \(167\cdot5=835\), and the compatible list has only six at \(150\cdot7=1050\). So one cannot simply decrease the floor denominators \(167,150\) by one in the respective tests \(G((1+\text{denominator})h)\ge h\). This is not sharpness for \(E_n\).

**Periodic bound.** The identity \(\sum_{j\ge0}C_{30}(x/5^j)=C_6(x)\) follows by unique factorization, including when \(x\) is an integer. Use the six \(30\)-rows and three \(6\)-rows as written, not nine \(30\)-rows. For these rows the lcm period and total increment are \(17\,496\,000\) and \(128176=16\cdot8011\). As a check on the event count, the \(30\)-row at \(1944\) and the \(6\)-row at \(9720\) are subsets of the \(6\)-row events at \(1944\); they account for \(2400+600\) repeated events per period. Distinct positions number \(125176\).

The test for the maximum \(K\) in `periodic_packing.py` is exhaustive: start at discrepancy zero, test \(p(J-1)-qG(J-1)\) **before** each distinct jump \(J\), add its full multiplicity, and test the far endpoint. At the supplied witness the nine row counts in order are
\[
22609,\ 18087,\ 10049,\ 3617,\ 2009,\ 1116,\ 1395,\ 465,\ 279.
\]
They sum to \(59626\), giving \(K=4335269\) there. The witness checks attainment; the finite maximum test, not the witness, checks the upper bound. I would assert the published period, maximum, and witness value in the regression test rather than just writing computed fields to JSON.

Finally \(h=\lfloor(pn+q-1-K)/(q-p)\rfloor\) gives \(p(n+h)-K\ge q(h-1)+1\). It follows that \(G(n+h)>h-1\); rounding the wrong way here would cost a unit or give a false implication. The offset is \(-3241770\), and at \(100000\) the second floor is \(735\). The maximum discrepancy is tight for the original \(G\); this is **not** a maximum-discrepancy calculation for the expanded layers, nor a best possible finite-size theorem for runners.

## 2. Finite local decision problem

**Define the problem before stating its complexity.** The obligations are the primitive rows of specified affected speeds, the eligible local witnesses are the listed replacements, and both their incidence and their \(z\)-interval must pass the test. This is not a decision procedure for necessity of the primitive test, for arbitrary \(\delta\)-dependent phases, or for covers exploiting arbitrary other even seed runners at some large \(N\).

With that definition the following reductions work.

1. In the congruence compression \(M=\operatorname{lcm}(Q)\) is even, and each represented odd residue has an increasing sequence of positive odd representatives. Termwise compression within the class cannot create duplicates, including across classes. Keeping \(a\) and setting \(h'=v'h/v\) preserves eligibility and contracts the signed error towards zero. Do not compress rephased evens this way. A witnessing constant has \(Ma\in\mathbb Z\bmod M\) by any one incidence. An added runner not needed may be discarded; a never-needed rephased even may instead be restored, *removing* an obligation. Keeping the old universal denominator is harmless.
2. In \(z/q\)-coordinates the chain proof uses **both** endpoint comparisons for containment and **both** inequalities for intersection. Choose chains in intervals clipped to the target and keep the constraints for the original intervals. Flooring all scaled centers simultaneously works for differences with an integer right side, including bounds involving zero. It is not independent rounding of phase endpoints. Centers used somewhere had magnitude at most \(1/2+1/v_i\) before flooring; unnecessary runners need not have bounded original parameters. The product bounds for \(M,D\), the number of runners, and the number of rows give polynomial certificate length and verification time for unary \(L\). This is membership in NP, not a polynomial running-time guarantee for the exhaustive search.
3. For the pivot algorithm an invariant is needed: on each unfinished row a prefix is certified and there are no islands to its right certified by previously pivoted intervals. Initially this is true. On a least-frontier row, finiteness gives an unused interval covering the frontier and extending strictly to its right in any completion. Sliding it right to start at \(f\) loses only points \(<f\), already unnecessary on **every row it serves**. On any unfinished compatible row its new left end is no larger than that row's frontier, so extending to \(\min(1/q,\max(\text{frontier},f+2/v))\) preserves the invariant. Finished rows need nothing. Anchoring \(a\) at the chosen row does not change its eligible rows: it was already eligible there. Picking a non-minimal frontier without further tests does not have this proof.
4. For an anchored runner the incidence condition on another row is \(\operatorname{den}(s-r)\mid v\), and that denominator divides \(M\). Hence \(\gcd(v,M)\) suffices **after anchoring**. Reanchor a compressed odd speed at a formerly served row and keep its interval's left end; all incidences survive and the interval grows. Keeping an arbitrary old intercept merely because the gcd agrees would be false. Keep up to the budget in *distinct* odd representatives of each gcd class, not just one. Keep the even catalogue separately.

**What the \(L=12\) negative test has to exhaust.** Use all rows of evens through 12, and budget five for *all* chosen witnesses, even or odd. A rule with a gain supplies such a cover by including its unchanged evens through 12 at \((a,h)=(0,0)\); they meet their own rows. In the search they may be slid like any other chosen runner because one is testing an all-row cover, not requiring that a named unchanged runner keep its phase. This is at least a necessary relaxation; its **negative** result suffices. Do not claim that sliding a named unchanged even in a fixed-\(Q\) rule leaves that particular fixed-\(Q\) rule valid. For a positive test specify whether an identically zero-phase even may be designated a replacement witness. Nor does the negative test pay for, or include, unchanged evens above \(L\) as free witnesses. Any broader claim allowing such help needs justification, e.g. requiring validity already for the seed ending at \(L\).

Here is a short reproducible exhaustive test independent of the missing `local_pivot.py`. It uses integer frontiers. The catalogue size follows from \(M=120\), four odd gcd classes \(1,3,5,15\), and six evens; the primitive row counts are \(2,2,4,4,8,4\). The decisive numerical test is the last assertion, not the mere count “24 rows, 26 speeds.”
```python
from math import gcd, lcm

E = list(range(2,13,2))
M = lcm(*E)
V = E[:]
for g in (1,3,5,15):
    V += [v for v in range(1,5*M+1,2) if gcd(v,M)==g][:5]
rows = [(q,k*(M//q)) for q in E for k in range(q) if gcd(k,q//2)==1]
D = lcm(*V, *E)
end = [D//q for q,r in rows]
assert (len(rows),len(set(V))) == (24,26)

def possible(F, used, left):
    unfinished = [i for i in range(len(F)) if F[i]<end[i]]
    if not unfinished: return True
    if left==0: return False
    i = min(unfinished,key=lambda j:F[j])
    f,r = F[i],rows[i][1]
    for j,v in enumerate(V):
        if used>>j & 1: continue
        G = F[:]
        for m in unfinished:
            if v*(rows[m][1]-r)%M == 0:
                G[m] = min(end[m],max(G[m],f+2*(D//v)))
        if possible(G,used|(1<<j),left-1): return True
    return False

assert not possible([-x for x in end],0,5)
```
A smaller \(L\) rule could be padded by unchanged evens through 12. There is no inference from this instance to the full range \(L<192\).

## 3. The fixed 57, its optimum, and the measure obstruction

**One extra runner.** There are two different residual problems. For \(\gamma\le d\) it suffices to cover the closures of the positive gaps of the closed seed cover by closed bands of the new runner. For \(\gamma<d\) every point where the seed distance is **at least** \(d\) matters. A touching point of seed arcs can disappear completely from the first list and be decisive in the second.

On a closed gap \([a,b]\) covered by one runner there is one lift \(k\) with
\[
k-va-d\ \le s\ \le k-vb+d .
\]
This follows from connectedness and \(2d<1\). It is why the longest gap bounds **every candidate speed in the one-runner problem**; the same bound on each individual speed in a two-runner cover would be invalid. At the stated \(d_*\) the claimed width gives the quotient \(43502432/53\), hence limit \(820800\). Anchor at the first gap as in the manuscript. Windows and the anchor range have widths \(\le2d_*\); a translate meeting the anchor range must start within \(2d_*\) of zero. The nearest-to-zero representative test in the code is safe. Use non-strict intersection, exclude existing speeds, and include the last speed in the loop.

The numerical certificate I would require is the following exact test on the **published rational seed**, without needing to regenerate the floating search chamber:

* Set \(d=1359451/79000000\) directly. Check eleven positive gaps, longest \(53/1264000000\), and that the complete hit list modulo one is exactly
\[
[(528344,\ 4737613/31600000,\ 178783/158000000)]
\]
in (speed, initial phase, interval length) notation. Verify direct affine bounds on every gap. Then *every* phase in the closed interval, endpoints included, gives \(\gamma\le d\).
* At \(38586773/79000000\) check the two stated equalities for 44 and 114 and the minimum over the entire seed. Check the added-runner distance at the left feasible phase. Its possible decrease across the interval is at most the interval length, and
\((66324111-178783)/158000000>d\). Thus **all** the feasible phases give \(\gamma=d\). Any configuration with \(\gamma<d\) would be in the weak hit list and fail at that same point. This proves a minimum, not just nonattainment of a guessed lower radius.
* For the auxiliary strict-residual computation check twelve components, including the singleton, and `assert not strict_hits` for the asserted **weak** infeasibility on those twelve. `all(width==0 for ... in strict_hits)` alone would allow isolated feasible phases and does not assert that claim. The point argument above is independently sufficient.

The sign of the target comparison is important: \(d_*-1/59=1207609/4661000000>0\). This is uniqueness of a speed relative to a fixed seed, **not** uniqueness of a phase, nor optimization of 58 unconstrained runners. The supplied `all_extensions` gives a reproducible integer-sweep algorithm; the seed, the imported closed-gap routine, and the result files are not included here, so I would not certify the numerical hit list from the prose alone.

**Stability.** Circle distance is 1-Lipschitz in the phase, and pointwise minimum and subsequent maximum preserve a uniform error bound. Restore the 57 old phases, leaving the candidate extra runner in place. The new radius before restoration was at least \(d_*-\epsilon\). To get strictly below \(1/59\) one needs **strictly more** than the stated target gap in maximum old phase displacement. One can minimize this displacement over a **single** \(\tau\), comparing phases after \(s_i\mapsto s_i+v_i\tau\bmod1\); translate the extra runner as well when changing time coordinates. This is not invariance under adding the same phase constant to all runners, still less under independent choices of time origin.

**Weighted residual.** This is the more informative obstruction to seed surgery. The mathematics of the proposed certificate is as follows. In coordinates \(x=Qt\), a component of integer length \(b-a\) and density \(\rho\) maps to an interval of length \(v(b-a)\) on the lifted phase line. Write that length as \(mQ+r\). Its covered weighted length in the original coordinate is
\[
\frac{\rho}{v}\bigl(mU+|I_r\cap J|\bigr),
\]
where \(I_r\) starts at \(va\bmod Q\), and \(J\) is one common sliding window of length \(U\). Normalize by \(T\), **not** by \(W\) or by the number of components. Endpoint equality in the seed-miss test has measure zero; because speeds are positive, an entire positive-width supported interval cannot sit at equality. The prefix-integral method sums the densities of the residual circular arcs, counting wraps, and evaluates the integral at the window's right minus left endpoint. It suffices to test starts at arc ends/starts and those coordinates minus \(U\) modulo \(Q\), with zero also available. Piecewise affinity justifies this test for arbitrary *real* phase.

Since \(m\le v(b-a)/Q\) and \(|I_r\cap J|\le U\), the bound for all high speeds is \(U/Q+UW/(vT)\). At the stated cutoff it is already below the stated finite maximum; it need not be a sharp tail estimate. With the reported numbers the decisive strict inequality is
\[
7\cdot20159589=141117123<153120431.
\]
No independence of windows or disjointness of new covers is assumed; this is just subadditivity of mass.

For reproducibility, release the ordered \(207\) endpoint pairs or the seed and their exact generation convention, and the **actual weights**. Check nonnegative integer densities, the 121 positive intervals in order, the seed inequalities on each, \(W=303345,\ T=153120431\), and the maximum including its witness \(v=160,\ J_{\rm left}=9192800\). Check all \(1\le v\le59940\) and the tail starting at \(59941\). For the displayed prefix implementation, the coordinates \(vQ\), full weighted lengths \(vT\), and integral intermediates of order a few \(QW\) fit signed 64-bit at these values; cast to Python integers before rational comparisons. The other implementation's intermediate products should be bounded from its own code. The enclosure lacks the weights and the imported `weighted_residual` data/routine; the reported maximum is not independently checkable from \(W,T\) and one maximizing speed. LP optimality is neither established nor needed.

If the certificate passes, even *repeated* extra speeds cannot evade the mass bound. In a final set of 58, if \(m\) of the 57 original speed-phase pairs have not been retained, restoring them leaves the originals plus only \(m+1\) other runners. Hence \(m\ge7\), or at most 50 old pairs retained. This applies even for weak coverage at \(1/59\), relative to this seed or one simultaneous time translate of it. It does **not** require changing seven speeds as opposed to phases, prove that seven changes suffice, or constrain a seed-independent 58-runner construction in the same way.

The earlier frozen two-extra test is logically superseded by this result. Its distinct slow-speed bound is reasonable: on a gap of length \(L\), a speed \(u\) covers measure at most \(2dL+2d/u\), so \(v\le4d/((1-4d)L)\) for \(v\le w\). Only **after** finding a whole gap missed by the slow runner throughout a phase box may one bound \(w\) by its width. The midpoint difference filter is necessary by the triangle inequality. Archive the actual missed-gap and empty-candidate checks if retaining the counts; include repetitions wherever the claim allows them.

## 4. Deletions and continuous phase tests

**Two deletions, one insertion.** At a strict target take the complement of **open** survivor bands. The endpoint sweep must record the active set after all endings and before all beginnings at a tied coordinate. At the time-circle cut use genuine lifts, not artificial open endpoints from clipping a band that covers zero. Include singleton residuals. For a compact residual \([a,b]\) use the **open** phase window in the manuscript. Reflection reduction is valid for a nonempty symmetric residual: \(s\) is strictly within \(d<1/4\) of just one half-integer modulo one. The half-sum/half-difference of the two errors at \(\pm t\) have absolute values summing to the larger absolute error. Recentring at that half-integer therefore does not worsen coverage. This argument does not apply to general asymmetric deletions. The pair counts are \(\binom{59}{2}\) and \(\binom{95}{2}\); the numerical maxima 170 and 580 and zero hit counts require the missing sweep/results. In particular specify the *survivor phases* of the 95-seed at \(1/97\), not phases recomputed at the deletion target.

**Three deletions, two insertions.** I find the strict two-speed reduction in `two_speed_search.py` sound under its hypotheses: \(H\) compact, at least one interval of positive length, \(0<d<1/4\), and distinct \(v<w\). Here are the decisive boundary checks.

* Write \(S=2d/v,\ f=2d/w\). If a connected residual meets two open slow bands it contains the full closed gap between them, of length \((1-2d)/v>f\); a single fast band cannot contain it. If it meets no slow band it has length \(<f\). Otherwise each nonempty wing outside the one slow band, **including the boundary point**, must fit in an open fast band. Consequently \(L<S+2f\) for the longest residual, giving \(v<6d/L\) and, if \(L>S\), \(w<4d/(L-S)\). For an integer speed strictly below \(x\) the limit is \(\lceil x\rceil-1\).
* For \(\ell=c-a\ge f\) the band must be present, with left boundary \(<a+f\) and right boundary \(>c-f\). This gives exactly the open slow-phase window \((-d-va-vf,d-vc+vf)\bmod1\). At \(\ell=f\) the fast runner **alone** cannot strictly cover the closed interval. An allowed window of width one omits a point, and width zero is empty. As \(w\) increases the constraints only shrink and more rows qualify, so emptiness gives a genuine infinite-tail exclusion.
* At \(L\ge S+f\) there must be two wings. The two closed endpoints are in distinct open fast bands \(n\) periods apart; these bands must also reach the respective slow boundaries. Hence
\[
                   w(L-f)< n < w(S+f).
\]
Equality at either integer lattice boundary does **not** work. Testing \(\lfloor w(L-f)\rfloor+1 < w(S+f)\) is the correct existence test. This filter is for the individual pair, not a monotone tail rejection. Likewise \(\gcd(v,w)L\ge1\) rules out that pair because the interval contains a full common period with total covered fraction at most \(4d<1\).
* A finite cap is not a tail proof. The `for ... else` distinction in `search` is material: absent a monotone break, a \(w\)-range extending beyond the cap leaves the conclusion incomplete. The slow range must also be exhausted. For the claimed 24 exclusions require `IMPOSSIBLE` for every listed input, not just no `FOUND` below 2500.

For fixed speeds there is an especially clean proof of the phase solver. At a phase \(s\) a slow missed band is the **closed** interval \([(k+d-s)/v,(k+1-d-s)/v]\). Its possible indices meeting \([a,c]\) are exactly those in the integer range in `_axis_cells`; the endpoint cuts there are the places where that range can change. Do this on both axes. In an open phase rectangle, to fail on a particular component requires a common point of it and two closed missed intervals. Each missed interval already meets the component by the index tests. Pairwise intersection suffices for three intervals on the line. The remaining intersection is exactly the closed forbidden block
\[
w(k+d)-v(j+1-d)\ \le\ ws-vb\ \le\
w(k+1-d)-v(j+d)
\]
with fast phase \(b\). Consecutive \(j\)'s shift by \(v\), less than the block length \((w+v)(1-2d)\), so their coalescence is safe. The linear image of the open rectangle is the full open range between its two extreme values. One rational point outside the union of closed forbidden blocks lifts to phases in the rectangle; conversely a blocked range has no solution there. A strict cover of compact \(H\) has positive uniform slack, so if one exists it can avoid *all phase cuts*. This last argument discards no **time** endpoints, even for a singleton component. It would not justify checking only open rectangles for a non-strict covering problem.

The method deserves a proof independent of the 24 outputs. The outputs themselves are selected triples, not all triples. Archive the ranking direction, tie order, speed IDs, exact merged residuals, forbidden speeds and result/status per triple, preferably with the terminal tail reason for each slow speed. The selector, residual inputs and JSON results are not in the enclosure; the self-tests in the supplied solver do not establish those instance totals.

**Coordinated phase boxes.** For a finite nonempty union of proper open bands, a non-full union has a positive-orientation exit endpoint not covered by the union, including when the complement is just a point. Conversely an uncovered right endpoint disproves coverage. Different bands of the same runner cannot cover its own right endpoint here. With delays \(y_i\) the endpoint moves to \(e+y_i\), so runner \(j\)'s coordinate is \(v_j e+s_j+v_j(y_i-y_j)\); the signs of both strict inequalities in the disjunction follow. Finite enumeration of \(l\) uses the bounded delay difference, retaining strict comparisons at the edges of the box. Covering every endpoint in this sense gives strict covering everywhere, and compactness makes the maximum strictly smaller than \(d\).

The integer encoding is exact, not a phase discretization assumption. In particular each bound is a difference of terms with denominators dividing the stated \(D\); one does not need a product of *all pairs* of speeds. Fix one true disjunct for each endpoint. With a zero reference there are \(n+1\) potential nodes; box edges are non-strict. A feasible real system has nonnegative integer cycle weight after scaling by \(D\), at least one on any cycle with a strict edge. Tighten each strict edge by \(1/(n+1)\); no **simple** cycle becomes negative, hence no cycle does. After multiplying by \(n+1\), shortest paths from an auxiliary source give integer potentials. Subtract the reference potential. The converse follows from the strict tightening. This justifies the `+1`/`-1` bounds in the fine integer coordinates and arbitrary Boolean disjunctions of these pairs of constraints.

The following distinctions should appear alongside the box numbers:

* \(1,\ldots,58\) at half-width \(3/125\), and the specified other 58 speeds at half-width \(1/32\): **reported integer-solver UNSAT**, for simultaneous movement of all phases about the indicated centers. These are not two independently cross-solved UNSAT results.
* The 203-endpoint real replay concerns the **smaller** standard box at \(1/50\). Infeasibility of a subset is sufficient there. A replay timeout on a larger box is not corroborating numerical evidence. A common time translation translates the entire box to an equivalent one.
* For the controls, verify a SAT witness by actual coverage at a smaller rational radius; specify the fixed speed list and full-torus bounds for the four-speed UNSAT control. Do not generalize a fixed-list solver run over all possible speeds.

Ship the exact nominal rational phases, rather than requiring reconstruction by floating JSON parsing and rounding, and export the actual solver instances, versions, timeout settings, logs and core labels. For example the integer replays require `endpoint_solver.py --base standard --n 58 --eps 3/125 --radius 1/59 --seconds <budget> --out <file>` and the corresponding `--base chain --eps 1/32` run with the archived center. Replay the smaller core separately in real arithmetic. An UNSAT core is an input reduction, not on its own a checkable refutation; a proof log or second successful independent solve would strengthen the largest results.

## 5. Required revision and attribution

1. **Lead the construction paper with the strongest results:** the expanded-layer asymptotic slope and the compatible periodic finite-size guarantee. Give one definition of the radius and one locality/merger lemma. Present the disjoint packing as a transparent intermediate construction. The single rules, including their phases, belong to Poliakova v1 Theorem 7 and Table 1 on the supplied attribution. Relative to those rules and the named \(1/224\) comparison, the contributions are the packing, compatible sharing, recurrences and finite-size analysis, not discovery of the local replacements. Do not claim global priority or coefficient optimality.
2. **Lead the obstruction paper with conditional theorems about specified data:** the all-speed one-runner optimum and the weighted eight-extra lower bound, if reproduced. Give the finite local decision theorem and the continuous two-speed/endpoint methods clear independent statements of scope; distinguish the endpoint/difference-constraint antecedents in Blanco–Criado–Santos from the particular reductions and computed boxes. Credit tomdif and the public collection for the fixed seed.
3. **Make the evidence stand alone.** Supply immutable seed and rule tables, weights, selectors, exact gap conventions, hashes, expected outputs, dependencies and a single replay manifest. Separate certificate discovery from checking: hard-code the proposed \(d_*\) in the verifier, omit LP design from the weight check, and run Python assertions enabled. Include regression assertions for the claimed counts, intervals, extrema and empty hit lists. The packing scripts are much closer to self-contained evidence than references to missing JSON, `frozen_extension`, the deletion drivers or the box replays.
4. **Demote archived replay and limited searches.** On the supplied historical record the named coverage ranges are \(5\!:\!17\) (Blanco–Criado–Santos), \(18\!:\!57\) (public repository reports), and \(n\ge95\) (Poliakova). Replaying upstream searches is not a new existence result. Four attempts, 100 initial additions, a finite set of deletion triples, a local phase box, and a fixed-seed obstruction are five different scopes; none justifies a nonexistence claim for 58 arbitrary distinct positive integer speeds and arbitrary real phases.
