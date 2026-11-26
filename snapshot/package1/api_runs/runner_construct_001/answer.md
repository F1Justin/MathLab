**I would try block compression, not extension of the published 57.** Start with the unshifted speeds \(1,\ldots,59\), which give a little more coverage than is needed. Remove *all* the multiples of a selected \(d\), and buy back coverage with **one fewer** speed than was removed. There is an exact, small description of what has to be bought back. In particular, one need not reproduce the arcs of the removed runners, even approximately. Some of those arcs can be replaced by covering very short intervals near particular rationals.

This gives one experiment with a uniform-rule control and a Farey-gap treatment. It searches jointly over multiple speeds and phases, without annealing. The live-run obstruction is a good reason to try this: it concerns a particular fixed core, whereas here the core, the residual time set, and the number of free runners are all different.

### 1. Exact compression target

Use notation \(M=n+1\). For the main target take
\[
 M=59,\qquad \epsilon=1/64,\qquad \delta=1/(M+\epsilon).
\]
Thus a cover at the design radius gives \(E\ge 1/64\); a final candidate can also pass with a smaller positive \(E\). Choose \(d\ge 2\), put \(J=\lfloor M/d\rfloor\), and freeze the unshifted core
\[
 B=\{b:1\le b\le M,\ d\nmid b\}.
\]
Seek \(K=J-1\) distinct new speeds \(d\ell\) with freely selected shifts. The count is \(M-J+K=M-1\). Fewer than \(K\) also suffices by padding. In the coordinate \(x=dt\bmod 1\), a new runner tests \(\|s_\ell+\ell x\|\le\delta\).

Here is the target mask \(H\) in the \(x\) coordinate. The formulas hold for any \(0<\epsilon<1\).

* For every \(b=dj\le M\) and \(1\le a<b\) coprime to \(b\), find \(p_-,p_+\) in the integer interval \((M-b,M]\) by
  \[
       a p_- \equiv 1\pmod b,\qquad a p_+ \equiv -1\pmod b .
  \]
* Insert the following closed interval, modulo one, into \(H\):
  \[
  x_0+\delta[-A_-,A_+],\qquad
  x_0=a/j\bmod 1,\qquad
  A_\pm=\frac{M+\epsilon-dj}{j p_\pm}.                    \tag{1}
  \]
  At the same \(x_0\) just take the largest left and right extents. Then union the intervals.

**Why this is exact.** Use the reduced fractions of Farey order \(M\) as arc centers in time. A retained center of denominator \(c\) has radius \(\delta/c\); arcs from nonprimitive representations there are redundant. The two neighbors of \(a/b\) have denominators \(p_-,p_+\) above and are at distances \(1/(bp_-),1/(bp_+)\). Indeed the congruences construct fractions of determinant one with \(a/b\), and any intervening fraction would have denominator at least the sum of the two denominators, which exceeds \(M\). For an adjacent pair of retained Farey neighbors the two radii sum to more than the center separation since \(\delta(b+c)>1\) when \(b+c\ge M+1\).

Deleted centers are precisely those of denominator divisible by \(d\). No two are Farey neighbors, by the determinant-one condition. On deleting \(a/b\) the two retained neighbor arcs therefore leave a gap extending to the left and right of \(a/b\) by \((1/b-\delta)/p_-\) and \((1/b-\delta)/p_+\), respectively. No more distant arc protrudes into it: left endpoints and right endpoints are each ordered by center, since for distinct fractions of denominators \(b,c\) the separation is at least \(1/(bc)\) and \(\delta|b-c|<1\). The center \(0=1\bmod 1\) is retained. This accounts for all the gaps. Multiplying them by \(d\) gives (1).

The replacement runners must cover the **union** of the projected gaps: if even one lift of \(x\) is missed by the core, the replacements must cover \(x\). Conversely this is sufficient at every lift. Taking closures changes no feasibility condition because the replacements give a finite closed cover. This folding is not an identification of configurations by a supposed global phase symmetry.

**Size and leverage at 58.** There are at most \(\sum_{j\le J}\varphi(j)\) different star centers (counting \(0\) once). For \(d=4\) that is 64 centers, with 13 replacements; for \(d=2\) it is 270, with 28 replacements. The normalized half-widths in (1) are **strictly less than \(1/j\)** since \(p_\pm\ge M-dj+1\). Sometimes they are much less. For example, \(M=59,d=2,a/b=1/58\) projects to \(1/29\); the half-widths in units of \(\delta\) are \((1+\epsilon)/(29\cdot59)\) and \((1+\epsilon)/(29\cdot57)\). There is no second primitive lift at this center. Reconstructing a full radius-\(\delta/29\) arc here would solve a much harder problem than necessary.

A minimal mask generator (intervals returned on the universal cover, to be split at integers) is:

```python
from fractions import Fraction as F
from math import gcd

def stars(M, d, eps=F(1, 64), uniform=False):
    delta = 1 / (F(M) + eps)
    widths = {}
    for j in range(1, M // d + 1):
        b = d*j
        for a in range(1, b):
            if gcd(a, b) != 1:
                continue
            inv = pow(a, -1, b)
            pm = M - (M - inv) % b
            pp = M - (M + inv) % b
            x = F(a % j, j)
            r = (M + eps - b) / j
            L, R = (F(1, j), F(1, j)) if uniform else (r/pm, r/pp)
            l0, r0 = widths.get(x, (0, 0))
            widths[x] = max(l0, L), max(r0, R)
    return [(x, x - delta*l, x + delta*r)
            for x, (l, r) in sorted(widths.items())]
```

As a unit test, explicitly subtract the core arcs from the time circle, close and fold the differences, and compare the rational union to `stars(..., uniform=False)`. Also test wraparound at the star \(0\).

### 2. The uniform-rule control, and how to use the whole interval

**Control:** solve the same compression with every star of denominator \(j\) given normalized half-widths \(1/j,1/j\). This asks to replace the full reference arcs, not just the core's gaps. Indeed every reduced residue modulo \(j\) has a lift coprime to \(dj\) (avoid the primes of \(d\) not dividing \(j\)). **Treatment:** change only the mask to (1). Use the same phase and speed options, resource limits, and optimization code. This isolates whether the extra cost of a uniform repair is important.

There is also a useful precise interface to local uniform rules of the kind motivated by Poliakova. Write a rule entry as \((\ell,c,u)\) with phase \(s_\ell=c+\delta u\bmod 1\). At a star \(h/j\) satisfying \(c+\ell h/j=0\bmod 1\), this entry covers at least the following interval in normalized displacement from the star:
\[
                     [(-1-u)/\ell,\ (1-u)/\ell].            \tag{2}
\]
A list of at most \(J-1\) entries with distinct positive \(\ell\)'s whose compatible intervals (2) cover \([-1/j,1/j]\) at every star is a **portable compression proof** at every \(M,d\) with this \(J\). For the weaker test, just cover \([-A_-,A_+]\) at each star. These statements follow by substitution; they need no result about the threshold 95. They explain how to replay any available published local rule or useful sub-block: translate its actual speeds/phases and radius convention into entries and test the interval inclusions. Do not assume an unspecified rule has the required count or covers a smaller \(n\). The numerical entries of such a rule are not needed to run the experiment.

The treatment optimizes **beyond** truncating a local rule. Different numerators with the same denominator have different demands; one star can be stitched together from parts of several arcs; and the solver below uses the actual phases on the circle, *including* hits with \(c+\ell h/j\ne0\bmod 1\). It does not fix shifts at zero, halves, quarters, or a list of signs. It still has a real restriction: all adjustable speeds lie in one divisibility block.

For interval-wide use, generate the mask table for \(59\le M\le95\). Especially interesting comparators have \(M=dJ\): the outermost stars are essentially point demands but still must be hit. For example \((M,d)=(70,5)\) gives the **same \(J=14\)** as \((59,4)\), and \((88,8)\) gives the same \(J=11\) as \((59,5)\). A solution at either scout size is worth checking in its own right. Replay a good list of \(\ell\)'s at **all** table entries with the same \(J\), first keeping phases fixed, then recentering each as \(c+\delta' u\) at the new radius. For the latter, one reproducible anchor \(c\) is the nearest residue \(-\ell h/j\bmod 1\) among stars the old runner hits, using the short signed displacement for \(\delta u\). This choice of anchor is heuristic; the replay is an exact interval test. If phases do not transfer, the speed list is still a small fixed-list feasibility problem. This tests a family of related targets rather than counting success at 95 as evidence of success at 58.

### 3. Finite optimizer and discriminator

Use \(1\le\ell\le4J\) and shifts \(p/D\), \(D=10^6\). Thus actual speeds are at most \(4M\). These are **search bounds**, not necessary bounds for a theorem of impossibility. Rounding phases changes \(\gamma\) by at most \(1/(2D)\) under nearest rounding, since every distance, the minimum, and the maximum are 1-Lipschitz in the sup phase error. The design margin \(1/M-\delta\) exceeds this rounding error throughout the table. Use Python integers/Fractions for mask and phase-endpoint arithmetic; the old NumPy multiplication bounds need not be assumed.

A row-generation set cover avoids a million columns per speed. Initialize rational test points \(T\) with the centers and the two endpoints of the stars. Keep star IDs even when unioning for verification.

```
repeat within CPU cap:
    for each ell:
        for each x in T:
            compute integer intervals in [0,D-1] for p such that
                       ||p/D + ell*x|| <= delta
            (scale the closed circular arc by D; ceil left, floor right)
        sweep integer interval starts and end+1's
        output one column per distinct nonempty hit mask on T, labeled ell
        representative p = middle integer of a constant-mask segment
    find a 0/1 selection:
        each row hit; <= K columns; <= 1 column with each label ell
    if infeasible: save T and the decision status; stop
    if timed out without a selection: report unknown, not infeasible
    subtract the rational arcs of the selection from the full target mask
    if no residual: assemble original runners and verify
    else:
        save the selection and all residual intervals
        add midpoints of the residual components to T
```

Use the actual circle test, not a linear approximation at the centers. Arcs of speed \(\ell\) in \(x\) have centers \((k-p/D)/\ell\) and radii \(\delta/\ell\). There are at most \(2|T|+1\) sweep segments per speed up to splitting at zero. For a row problem, equal masks of the same speed are interchangeable, regardless of their behavior between rows; **regenerate** them after adding rows. Every unsuccessful selection is cut off as a full grid-phase configuration. Thus without a time cap this is finite, including for infeasibility, even though it need not be fast. The zero-phase choices \(1,\ldots,J\) with budget \(J\) should cover even the control; use this as another end-to-end test.

`scipy.optimize.milp` on a sparse matrix suffices as a first decision engine. Validate returned integer selections. A small infeasible row instance is valuable: the rational rows and sweep definition suffice for a separate exact discrete reproof (e.g. branch on the choices hitting the least-supported unhit row, disallow reused labels, prune by remaining budget). Log solver-only infeasibility as such, not as an exact lower bound. Optionally sweep **real** phase endpoints and the open segments between them on those same rows; if this larger row problem has an exact infeasibility proof, the phase grid was not the obstruction. Neither conclusion rules out other cores or larger speeds.

For every promising selection, including near misses at the design radius, form the full \(M-1\) runners. If necessary fill empty slots with unused positive speeds at zero phase. Test for a rational cover **strictly** below \(1/M\), not merely at \(1/M\); call the independent verifier and the pinned `check(c, exact=True)` wrapper on prospective successes. If a control fails to cover its strong mask, its selections can nevertheless be tried on the treatment mask and in the full verifier; credit that as a candidate found by the control, not a uniform proof. No sampled-row objective is an acceptance criterion.

### 4. CPU plan, measurements, and stopping rules

One proposed 120 **CPU-minute** cap, single threaded, is:

| CPU min | Work |
|---:|---|
| 8 | Unit tests, seed-verifier sanity check, profile column construction/HiGHS/exact subtraction. |
| 70 | At \(M=59\) run \(d=7,5,4,3,2\) (increasing \(J=8,11,14,19,29\)). Seven minutes per mask per \(d\), control vs treatment. |
| 18 | Same paired design at \((70,5),(88,8)\), 4.5 minutes per mask per pair. |
| 10 | Quality-base experiment at \((58,2)\), **\(\epsilon=3/5\)**, five minutes per mask. A cover here is a 57 with \(E\ge0.6\), not a padding proof. |
| 14 | Exact validation, transfers/deletions, artifact export. Stop searches early if validation needs the reserve. |

Use sorted rational rows, increasing \(\ell\), and choose the longest segment for duplicate masks, ties by smaller left endpoint. Use the same solver seed (e.g. 1007 if supported) for all paired decisions, one thread, no random kicks or automatic base regeneration; record versions, settings, and actual process CPU. Use equal *caps* and report early completion separately, without spending an easy control's leftover time on its paired treatment. Give an exactly passing uncovered \(n\) priority over finishing a comparison.

There is a cheap two-way base-pool test: at all five proposed \(d\)'s, \(\lfloor58/d\rfloor=\lfloor59/d\rfloor\). The two cores differ just by the runner 59. Try deleting 59 from good treatment selections at 58 runners, and try inserting it into good new 57's, **retesting the radius**. Save certified 57's by best exact \(E\) and by distinct sorted speed set; for identical sets retain alternatives with different residual-star profiles at the 58 radius. Compare with the supplied upstream seed's quality, without spending time trying to plug its 207 gaps. Attribute that seed to the upstream chain.

Minimal search measurements per case:

* \(J,K,\delta\), star count, actual union length, and distribution of \(jA_\pm\) (the fraction of full reference half-width demanded).
* Row iterations, final rows/columns, selection size, feasible/infeasible/timeout, and CPU split. For the best \(K\)-selection seen, number, total length and largest length of **continuous** residual components on the true mask. As a deterministic fallback reference, score the best single deletion from the trivial \(J\)-list.
* For the largest few residuals, record star \((h/j,a/b,p_\pm)\) including the lift attaining the troublesome extent, missed subinterval, and the runner endpoints immediately before and after it. This supplies active information without interpreting MILP relaxation multipliers as geometric constraints. Save small blocking row sets on failures; full rational configurations, hashes, and exact-check output on passes.

**Decision after the round.** A passing treatment, especially with failing control at the same \(d\), directly justifies transfer. Failing that, a small number of localized, shrinking continuous residuals compared with both the deletion reference and control, or a portable partial rule that works on all but one identified star type across several \(M\)'s, justifies a fixed-list continuous-phase polish or freeing the core neighbor implicated by those residuals. Conversely, small blocking row sets already on the *true* masks across several \(d\)'s would argue against this one-block compression at the tested bounds. Inspect those rows before raising a speed cap. If the computation mostly times out on the initial sampled decisions with no improved continuous residual, that rejects the **optimizer/budget choice**, not the mathematics; do not order another batch of identical jobs.

### Next-call packet

Return a small JSON summary with rational quantities as `"num/den"` strings; put large row sets and configurations in files.

```text
{
  revision, verifier_revision, scipy_highs_versions, thread_seed_settings,
  total_cpu_s, unit_tests: {seed_replay, fold_vs_direct, trivial_J_cover},
  cases: [{
    M, n, d, J, K, delta, mask: "uniform"|"farey", ell_cap, D,
    stars, mask_length, normalized_width_quantiles,
    iterations, final_rows, final_columns, decision, proof_status,
    cpu_s: {sweep, decision, subtraction, validation},
    reference_residual_length,
    best: {selection_file, speed_set_hash, residual_count,
           residual_length, largest_residual, active_star_records_file},
    blocking_rows_file_or_null
  }],
  replays: [{source_case, M, d, phase_mode, pass, largest_residual}],
  verified: [{n, config_file, sha256, gamma_exact, E_exact,
              cover_radius, independent_check, pinned_exact_check}],
  best_57s: [{config_file, speed_set_hash, E_exact, insertion_test}],
  discriminator: "transfer | localized repair | blocked core | optimizer timeout",
  one_question_for_next_call
}
```

This route requires no unverified extrapolation of Poliakova's theorem. Its main testable proposition is narrower: the cost of replacing a block may drop by a whole runner when one optimizes its *actual projected Farey gaps*, rather than imposing a uniform reconstruction rule.
