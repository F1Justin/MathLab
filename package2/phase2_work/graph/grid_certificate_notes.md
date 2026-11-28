# Fixed-width integer domination: two verified computational certificates

Research date: 2026-11-28. Status: exact computational proof certificates, with a mathematical transfer argument; novelty screen ongoing; no Lean verification performed.

## Exact mathematical object

Let G(m,n)=P_m □ P_n, with both paths having the indicated **numbers of vertices** and n≥1. An integer {k}-dominating function is f:V(G)→{0,…,k} satisfying Σ_{u∈N[v]}f(u)≥k at every vertex v. Write γ_{ {k} }(G) for the minimum total weight. Allowing arbitrary nonnegative integer values gives the same minimum, because replacing any value greater than k by k preserves feasibility and decreases weight.

These are closed-neighborhood constraints at **every** vertex. They differ from ordinary k-domination, where only unselected vertices need k selected neighbors; from k-tuple domination, where labels are binary; from Roman or Italian domination, where zero labels have special conditions; and from signed domination. The primary definitions are Lee–Liu (2025), arXiv:2502.00134, and Brešar–Henning–Klavžar (2006), Taiwanese J. Math. 10, 1317–1328.

## Two precise outcomes

**A. Three rows and threshold three.** The certificate establishes

γ_{ {3} }(P_3 □ P_n)=floor((11n+8)/5), for every integer n≥1.

The full-state identity is V_24=V_19+11, coordinatewise on all 4^6=4096 states. Direct integer evaluation verifies the formula for 1≤n≤24. The right-hand formula has the same period/increment, giving all remaining n by induction.

**B. Five rows and threshold two.** The certificate establishes

γ_{ {2} }(P_5 □ P_n)=floor((23n+26)/10)−1_{n∈E}, for every integer n≥1,

where E={2,3,5,6,8,9,12,15,18}. In particular the uncorrected formula holds for every n≥19.

The full-state identity is V_40=V_30+23, on all 3^10=59049 states. Exact evaluation verifies the stated exceptional set and all base values through n=40. For n≥30 the formula respects the same period/increment; widths 19–29 are included in the checked prefix.

## Transfer derivation

For fixed m,k let C={0,…,k}^m, with zero column 0, and w(b)=Σ_i b_i. Put b_0=b_{m+1}=0. Define the three-column predicate

Q(a,b,c) ⇔ a_i+b_{i−1}+b_i+b_{i+1}+c_i≥k for each 1≤i≤m.

For a labeling of n columns x_1,…,x_n, set x_0=x_{n+1}=0. The labeling is feasible precisely when Q(x_{j−1},x_j,x_{j+1}) holds for every 1≤j≤n. Thus V_n(a,b) is the minimum total weight of n columns with last pair (a,b), satisfying every constraint in columns 1,…,n−1; V_n=+∞ when no such prefix exists. For n=1, a denotes the fictitious zero column, so

V_1(a,b)=w(b) if a=0, and +∞ otherwise.

Appending c gives

V_{n+1}(b,c)=w(c)+min_{a:Q(a,b,c)}V_n(a,b).

Finally,

γ_{ {k} }(G(m,n))=min_{a,b:Q(a,b,0)}V_n(a,b).

These identities follow by a bijection between labelings and valid column sequences: every feasible prefix can be extended using precisely the admissible last triple, and deleting the last column gives the reverse correspondence. Consequently the recurrence computes a minimum over all assignments, not a heuristic subset.

Write T for the time-independent transfer operator. For any constant d, T(V+d)=T(V)+d, also for coordinates equal to +∞. Therefore V_{N+p}=V_N+d implies by induction that V_{n+p}=V_n+d for all n≥N. Applying the fixed terminal minimum yields the same identity for γ. Equality of whole vectors, rather than equality of a string of terminal minima, is the decisive finite certificate.

## Computation and reproduction

`grid_domination_pilot.py` uses signed 64-bit integer arrays. Its acceleration replaces min over previous columns a≥threshold(b,c) by coordinatewise suffix minima. All finite values in the computed prefix are below mkn≤1500, far below the sentinel 10^9. The abstract induction takes place in integers with +∞ and places no machine-integer bound on the mathematical n.

`verify_grid_certificate.cpp` was separately implemented using explicit enumeration of every triple and direct predecessor lists; it does not use suffix minima. It recomputes the whole prefix from V_1, checks every coordinate against both saved vectors, checks the complete periodicity identity and every necessary base-case formula. This is algorithmic independence within one research agent; a parent-agent mathematical review is separate, and no Lean-kernel check is claimed.

The C++ program additionally enumerates assignments on the actual small grid vertex set and checks four orthogonal neighbors directly, auditing boundary conventions independently of the three-column predicate. For m=3,k=3 it checks widths 1,2,3 (64,4096,262144 assignments). For m=5,k=2 it checks widths 1,2 (243,59049 assignments).

Reproduction:

```bash
python3 grid_domination_pilot.py --m 3 --k 3 --max-n 150 --out results
python3 grid_domination_pilot.py --m 5 --k 2 --max-n 150 --out results
g++ -O2 -std=c++17 verify_grid_certificate.cpp -o verify_grid_certificate
./verify_grid_certificate 3 3 19 5 11 results/grid_m3_k3_start.txt results/grid_m3_k3_end.txt
./verify_grid_certificate 5 2 30 10 23 results/grid_m5_k2_start.txt results/grid_m5_k2_end.txt
```

The full state vectors use lexicographic columns: the first row is the most significant base-(k+1) digit; array row is a and column is b.

| Case | Columns | States | Admissible triples | Full-vector certificate |
|---|---:|---:|---:|---|
| m=3,k=3 | 64 | 4096 | 230325 | V_24=V_19+11 |
| m=5,k=2 | 243 | 59049 | 11929864 | V_40=V_30+23 |

Python first-run time was 0.041s and 0.605s respectively on this host; these are observed local timings, not a portable performance claim. The C++ five-row check took about 0.5s. No paid model API or external compute was used.

## Short explanatory periodic witnesses

`period_witness.py` checks the saved witness labels and all neighborhood sums using ordinary Python integers and no solver. In the three-row case the repeated five-column block has rows `(1,1,1,0,1)`, `(0,0,1,1,1)`, `(1,1,1,0,1)` and total weight 11. With horizontal periodic boundaries, every closed neighborhood has weight at least 3. This displays the 11/5 density; finite end corrections are handled by the full DP argument.

For five rows, let B be the following ten-column block, of total weight 23:

| Row | Labels |
|---|---|
| 1 | 0,1,1,0,0,1,1,0,1,0 |
| 2 | 0,0,0,1,1,0,0,0,2,0 |
| 3 | 1,1,0,0,0,1,1,0,0,0 |
| 4 | 0,0,1,1,0,0,0,1,0,1 |
| 5 | 1,1,0,0,1,1,0,1,0,1 |

Alternating B and its vertical reflection gives a 20-column period of weight 46; all 100 closed-neighborhood inequalities pass integer checking. This illustrates the 23/10 density. A period in the optimum value need not be the period of an individual construction. No impossibility assertion for a ten-column cyclic construction is made.

## Originality screen and scope

The transfer method and the passage from full-state periodicity to an all-width proof are established ideas. In particular, a reader-posted MathDB solution already supplies this proof pattern for the three-row threshold-two Lee–Liu conjecture, and a four-row threshold-two certificate is also publicly claimed. These old targets must be credited and excluded from claims of new discovery.

The present two parameter pairs are extensions of Lee–Liu's explicitly stated further-work direction. Searches for the exact coefficients and phrases `integer {3}-domination grids`, `five-row integer domination`, `integer domination 11n`, `integer domination 23n`, `23n+26 domination`, `11n+8 domination`, and the Chinese `網格圖 整數 控制` located no matching prior formulas. The 2024 Lee thesis catalog gives the same scope as the 2025 article (m=1,2 exact, m=3 upper bound, m=4 computations). The 2006 foundational paper concerns product inequalities and parameter relations; its cited 1993 five/six-row paper concerns ordinary domination. Cheng–Fu–Liu's 2019/2020 result concerns powers of cycles (circulants) rather than open rectangular strips.

This is positive evidence for pursuing a novelty audit, not a complete priority determination. Full thesis access hit a CAPTCHA; no attempt was made to bypass it. Forward-citation coverage and non-indexed manuscripts remain to be checked before publication. The public three-row proof repository explicitly leaves higher thresholds and wider grids beyond its own result. Neither checking that repository's prose nor failing to find a web hit substitutes for independent novelty review.

## Decision

Continue these two cases as one coherent fixed-width domination program, with highest immediate priority on a written, independently reviewed computational theorem and on extracting short periodic constructions or potentials. The mathematical contribution sought is the two exact formulas and a reusable transparent certificate, with measured modest scope. A large infrastructure project is unnecessary. If the formulas are found in prior literature, reclassify them as replication and move the same certificate machinery to a precisely specified unsolved boundary condition or parameter pair only after checking its relevance.
