**Verdict.** The two finite bounds and the liminf bound follow from the stated finite certificate checks. I find no loss at the five-adic branch cut and no sign or rounding error in the conversion from seed size to runner count. There is one certificate-contract mismatch to fix: **acceptance by `certify` does not imply coverage by explicitly prescribed tracks alone.** The global bounds can accommodate the checker’s weaker contract. The interval checks for all sixteen records and the upper bound on the maximum discrepancy are finite computations; I have not run them or treated the JSON as an independent verification of them.

### 1. Local replacement and the helper repair

Apply Dirichlet approximation to \(2t\), and take the *least* covering index \(i\) in the original seed. Write \(q=2i\), \(qt=k+dz\), \(|z|\le1\). A common divisor \(b>1\) of \(i,k\) gives the smaller index \(i/b\) with error at most \(d/b\). Thus \(\gcd(i,k)=1\). At an affected slot, \(4\mid q\), so \(i\) is even, \(k\) is odd and in fact \(\gcd(k,q)=1\).

The phase convention is **plus**:
\[
 vt+a+hd=\left(\frac{vk}{q}+a\right)+d\left(\frac vq z+h\right).
\]
It is the parenthesized **sum**, not \(vk/q\), that must vanish modulo one in the center test. Since \(4a\in\mathbb Z\), integrality there implies \(q\mid4v\) for primitive \(k\). Conversely, with \(q\mid4v\), integrality tested at \(r\) persists at \(k=r+4j\), including negative \(k\). The verifier uses exactly the closed interval
\[
 \left[\frac qv(-1-h),\,\frac qv(1-h)\right].
\]
Its sorted right-endpoint scan allows touching endpoints. Checking full coverage for both \(r=1,3\) is sufficient; the representatives need not themselves both be primitive. This is not a necessary test for all ways an actual time could be covered.

The single-copy inputs are Poliakova’s A and the \(19\to17,\ 24\to21\) recipes B and C, of gains \(1,2,3\) at \(96,120,216\). Reflection negates both phase coefficients; half-period translation adds \(v/2\bmod 1\) at the **scaled** speed \(v\). Odd speed scaling preserves parity, both interval ratios and the two-residue argument, with \(d\) taken from the **new global seed**. Coprimality to 30 is not needed for this local fact. Even scaling would not justify the same accounting of inserted odds.

For a combined record, the actual deletion set is a **subset** of the proposed deletions. Deletion suppresses even an offered label; otherwise exactly one offered label is installed at each pool speed. Every cancelled deletion must have an installed label. None of this proves that the old zero-phase slot at that speed is covered. The obligations are for **all** deleted and all prescribed even speeds, using the **final** pool, not the union of incompatible certificates. Shared odds count once. For example, at 480 the cancelled deletions are \(8,32,192,240\). The rescued \(240\) has constant phase \(1/2\), so it does not even pass its own center test. Its old slot is served by \(120\) with label \((1/2,-1/2)\): \(k/2+1/2\) is integral and \(|z/2-1/2|\le1\). The bookkeeping is eleven actual deletions, seventeen retimed evens, seven inserted odds.

**Repair.** If prescribed intervals fail, the verifier can use an unchanged zero-phase multiple \(w\) of \(q\), \(2q\le w\le2K\), in the same smooth support core, contributing \([-q/w,q/w]\). It returns `zero_helpers` but `bounds()` does not assert emptiness; neither supplied JSON is a per-record empty-helper check. This is not evidence that a helper *was* needed. To publish the stronger sentence, disable fallback or assert empty helper lists for all sixteen and supply the check. Alternatively include returned helpers in the reserved support: they cost no tracks, meet the cap, and scale with the recipe. In the five-adic construction these reserved inner speeds then carry a factor of five. The outer A needs no such reservation: for its slots \(24,48,96,192\) use the half-speed; for \(8,32\) use \(3q/2,2q\); for \(16,64\) use \(3q/2,q\); for \(12\) use \(3\) or \(9\) according to the residue.

### 2. Gains 14–16, composition and counting

The last two finite rows are not consequences of multiplying an earlier row by five. From 14 to 15, \(A_{125}\) becomes \(B_{125}\) and the half choice at \(B_{25}\) changes. The selected replacement labels of 14 survive (in particular the label at \(3375\) is now available from \(B_{125}\)); the extra actual deletions are \(5000,9000,22500,30000\), the extra odds \(1875,5625,16875\). The cap is \(125\cdot120=15000\).

From 15 to 16, \(A_{225}\) proposes deleting \(1800,7200,43200\); \(1800\) was already deleted, and \(10800\) is now **restored with a label**. There are no new odds: net gain \(2-1=1\), cap \(225\cdot96=21600\). This is not an intact independent A: the old labels at \(675,2025\) need not give A its preferred odd phases. One can see the new even obligations directly. For \(q=7200,14400\), the track \(3q/2\) has label \((1/2,-1/2)\) and covers \([-1/3,1]\); \(14400\) with \((0,1)\) covers the remaining negative side in both cases. For \(21600,43200\) the half-speed serves the whole interval. The old prescribed tracks remain, and \(10800\) itself was already an obligation in row 15. Whole-row verification avoids any assumption about inheritance of an unchanged helper.

The full A support, **including deletions**, is
\[
 S=\{3,8,9,12,16,24,32,48,64,96,192\}.
\]
It misses multiples of five. A collision between \(9^iS\) and \(9^{i+\ell}S\), \(\ell>0\), would require \(v=9^\ell u\) in \(S\). The only candidate for \(v\) is \(9\), forcing \(\ell=1,u=1\), which is absent. Thus all these supports are pairwise disjoint, not just the first three.

Multiplying a gain-\(u\) recipe by five and adjoining \(A_1,A_9,A_{81}\) gives \(u+3\) at \(\max(5t,7776)\). The scaled inner support is divisible by five. The even-slot cap is twice the threshold; after outer scaling by \(c\) one requires \(ct\le N\). All internal speeds are \(2,3,5\)-smooth, so stripping these primes from a touched speed recovers its unique outer \(c\) coprime to 30. This proves disjointness across cores, not across arbitrary recipes in the *same* core.

Write \(B=(12000,15000,21600)\). The thresholds for gains \(14+3j,15+3j,16+3j\) are **achieved** at \(5^jB\): the first extension gives \(60000,75000,108000\), and \(21600<5\cdot12000\) keeps consecutive triples ordered. With the thirteen-entry head \(H\), let \(g(x)\) count thresholds reached. Install **one** recipe realizing that gain per core, not one recipe per crossed threshold. Then the saving of this schedule is exactly
\[
 \sum_{(c,30)=1}g(N/c)
 =\sum_{t\in H}C_{30}(N/t)+\sum_{t\in B}C_6(N/t)=G(N),
\]
since each positive integer prime to six is uniquely \(5^jc\) with \((c,30)=1\). Neither the thresholds nor \(G\) are asserted optimal over configurations.

### 3. Finite bound and sharpness

Each residue \(r\) of a row \((m,t)\) contributes \(\lfloor(N+t(m-r))/(mt)\rfloor\). The common period of the increments obtained by taking the lcm of the \(mt\)'s is \(P=87480000\). The head contributes \(715696\) hits per period and the triple \(5724\), giving \(p/q=721420/P=36071/4374000\). Thus \(pN-qG(N)\) is periodic. Between jumps it increases; scanning **before** each jump with the old cumulative gain, and checking the period endpoints, is sufficient. At \(4239239\) the head and triple counts are \(34679+277=34956\), giving discrepancy \(16045969\). This verifies attainment; **maximality** is the additional exhaustive claim made by the integer scan.

Taking that maximum \(K\), set \(h=\lfloor(pn+q-1-K)/(q-p)\rfloor\). For \(h>0\),
\[
 p(n+h)-K\ \ge\ q(h-1)+1,\qquad qG(n+h)\ge p(n+h)-K,
\]
so \(G(n+h)\ge h\). The denominator is \(4337929\), the offset **\(-11671970\)**. At seed size \(N=n+h\) at most \(n\) tracks remain; padding with unused positive speeds cannot spoil coverage at \(1/(N+1)\). Nonpositive \(h\) needs only the original seed. Sharpness concerns this schedule: at \(n=4239239-34956-1\), increasing the offset by one would ask for \(34957\) at the witness seed. Nor can a larger seed rescue that inference for the basic schedule: stripping the core identifies a unique threshold at a jump, so \(N-G(N)\) is nondecreasing. This gives no upper bound on \(E_n\).

For \(h=\lfloor n/125\rfloor\), \(n+h\ge126h\). The Lean rows are exactly the residue floors above. Their guaranteed increment over \(126\cdot1029\) is \(1032+6=1038\); the induction starts at \(h=0,\ldots,1028\). Hence the stated counting endpoint plus padding yields the other finite term. The Python alternative uses the linear bound for \(h\ge69\) and direct counts for \(1\le h\le68\). At \(100000\) the terms are indeed \(800,828\), giving radius at most \(1/100829\).

### 4. Infinite layers and scope of proof

The correct recursion cut is \(L=38880=5\max H\). At \(x\ge L\), both heads are complete and the unscaled \(B\) at \(x\) is complete; cancellation of the shifted tails gives \(g(x)-g(x/5)=3\). In particular \(g(L)=16\), \(g(L/5)=13\). One must **not** recurse merely because \(x\) has reached \(21600\): just below \(L\) the inner head is still incomplete.

Use \(f=g\) below \(L\); otherwise install the fivefold inner recipe for \(f(x/5)\) and all \(A_{9^i}\) with \(96\cdot9^i\le x\). This replaces the old choice, not adds to it. Up to the first extra A at \(69984\), recursion agrees with \(g\), including its jump at \(60000\). Subtracting the two recursions gives precisely the extra indicators at \(96\cdot9^i5^j\), \(i\ge3,j\ge0\): whenever one fires, every ancestor down to its insertion level is above the cut. Each fixed seed uses finitely many layers.

A finite prefix of those extra indicators contributes core density \(4/15\) times its reciprocal-threshold sum with bounded error **for that prefix**. The limiting saved fraction per seed is bounded below by
\[
 \alpha=\frac{36071}{4374000}
 +\frac4{15}\frac1{69984}\frac98\frac54
 =\frac{577511}{69984000}.
\]
For a prefix guarantee \(aN-D\), \(h=\max(0,\lfloor(an-D)/(1-a)\rfloor)\) suffices by padding. Taking the liminf first gives the claimed runner coefficient \(\alpha/(1-\alpha)=577511/69406489\). This improves the supplied prior liminf, but is not an all-size line at that slope. The basic periodic runner slope is \(p/(q-p)\) **with an offset**; the uniform floor is \(\lfloor n/125\rfloor\). The latter dominates the prior \(150\)- and \(287\)-denominator floors, but the displayed maximum alone does not subsume the separate \(E_n\ge1\) statement starting at 95.

Finally, the supplied Lean **statements** have narrower endpoints than the global result. `covers` gives coverage for `tracks N` at every positive \(N\), without a general length claim for that list. `certificate476` gives length 476 at \(N=480\), nodup speeds, positivity, and for every real \(t\) a listed entry and integer \(k\) with absolute error **at most** \(1/481\). This implies \(E_{476}\ge4\), not equality or a uniform slope \(4/476\). `all_sizes` states \(h\le\texttt{count}(126h,\texttt{rows})\) for every natural \(h\), not a theorem about configurations. The sixteen-record interval enumeration and discrepancy scan are Python evidence; identifying the row count with realizable savings, composing across cores, padding and taking the layer limit require the written glue. For reproducibility, supply the helper-strict check or reserved-support correction, the imported checker/Lean dependencies and replayable outputs; neither search provenance nor the two Lean endpoints certify the global theorem end to end.
