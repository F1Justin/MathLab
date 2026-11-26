There is an exact **leftmost-deficit reduction** for the local model in the question. At each step of the reduced search, a rational center and a real endpoint are forced. The only choice is the next velocity: both parameters \(a,h\) of that runner are then forced. This works with numerator-specific phases, not just phases that serve all primitive numerators of a denominator together.

I give the reduction first, then a composable saving construction. The construction gives a saving of \(m-1\) on a ladder of \(m\) blocks, but does **not** establish either of the requested strict velocity cutoffs.

### 1. Put every local obligation on the same coordinate axis

For an original arc at \(r=k/q\), use \(x=z/q\). Its target becomes
\[
T_r=[-1/q,1/q].
\]
A replacement \((v,a,h)\), with \(v>0\), can serve the row \(r\) if \(vr+a\in\mathbb Z\). On **every** row it can serve, its interval in the \(x\)-coordinate is the same:
\[
I(v,h)=\left[\frac{-1-h}{v},\frac{1-h}{v}\right].
\]
Thus a runner is a single translatable interval of length \(2/v\), copied onto an arithmetic subset of the rows. The common translation, rather than independent translations on the different rows, is important.

One can use just the specified primitive obligations, or construct the rows directly from all \(k/q\) of the affected speeds. In the latter case identify equal centers modulo one and keep the largest target there. This handles odd reduced denominators without assuming that an odd velocity was present in the original system.

Runners designated unchanged can be processed first. Subtract their aligned intervals from the targets and take the closures of the remaining nonempty pieces. Taking closures is exact: any finite union of closed replacement intervals covering a residual piece also covers its closure. We now have target pieces \((r,[L,R])\), possibly more than one for a row.

### 2. Exact pivot theorem

For each unfinished piece keep a frontier \(F\), initially \(L\); the portion up to \(F\) has been processed. Discard a piece once the frontier reaches \(R\). Use the following recursion:

1. Pick a piece with **least frontier** \(f\) among all unfinished pieces. Let its row be \(r\). Ties can be broken deterministically.
2. Choose an available velocity \(v\). Set
   \[
   \boxed{\quad a=-vr\pmod 1,\qquad h=-1-vf.\quad}
   \]
3. For each unfinished piece on row \(s\) satisfying \(v(s-r)\in\mathbb Z\), update
   \[
   F_s\ \longleftarrow\ \min\{R_s,\max\{F_s,f+2/v\}\}.
   \]
   Leave the other frontiers unchanged.

**Theorem.** For any given velocity catalogue and runner budget, the recursion has a successful branch if and only if the target pieces admit a cover in the local alignment model with that catalogue and budget. In particular it is exact if velocities must be distinct: just remove the chosen velocity from the catalogue.

**Proof.** Soundness follows because the boxed parameters put the interval at \([f,f+2/v]\) on exactly the indicated rows. Since \(f\le F_s\) on every unfinished piece, no update jumps over a gap.

For completeness, suppose a completion exists. On the pivot row, points immediately to the right of \(f\) must be covered. By finiteness, some runner of the completion is aligned there and has an interval \([\ell,\ell+2/v]\) with
\[
\ell\le f<\ell+2/v.
\]
Its intercept is necessarily \(a=-vr\bmod 1\). Slide its interval to the right until its left endpoint is \(f\), without changing its intercept. On any compatible row the slide can lose points only **strictly left of \(f\)**. No such point still needs processing on any piece, by minimality of the pivot frontier. Thus the slide preserves the existence of a completion, and gives exactly the boxed value of \(h\). Induction on the remaining budget proves the theorem. \(\square\)

In particular, the real endpoints occurring in a successful branch have the form
\[
L+\sum_{i\in J}\frac{2}{v_i},
\]
where \(L\) is an initial piece endpoint and the summands come from previously placed runners, each placement used at most once in the sum. Indeed, an unfinished frontier is either still its initial endpoint or is the right endpoint of an earlier placement. There is no need to enumerate these sums in advance, let alone grid the continuous parameters \(h\).

### 3. The remaining choice is arithmetic

For integer velocities, precompute
\[
d_{rs}=\operatorname{den}(s-r)
\]
in lowest terms, with denominator \(1\) for zero. The entire incidence test in step 3 is just
\[
d_{rs}\mid v.
\]
Thus for a bounded-velocity search one branches on integers, doing divisibility tests and rational frontier comparisons. There is no separate choice of numerator classes, intercepts, interval orderings on individual rows, or slopes of phases with respect to \(\delta\).

There is also a safe catalogue compression. Let \(M\) be the lcm of the row denominators, and group available velocities by \(g=\gcd(v,M)\). With budget \(B\) and distinct velocities, it suffices to keep the **first \(B\) available velocities in each group**, in increasing order. To see this, take the \(u\le B\) velocities used from one group in any solution and replace them, in increasing order, by the first \(u\) available ones. For each runner anchor its new intercept at one row it previously served. All its old incidences are preserved, because the divisibility tests against divisors of \(M\) are unchanged. Its interval can keep its old left endpoint and only grows in length. This argument compresses the catalogue *before* searching; it does not assume it is safe to greedily spend the smallest velocity in a group at the current pivot.

This reduction is not a smooth-number ansatz. For example the rows \(1/14\) and \(25/154\) differ by \(1/11\); a pivot at either can select velocity \(11\) and serve both, with intercept \(-11/14\bmod 1\). More generally **every** such incidence for velocities in the catalogue is included. For a cutoff search one may even take all even velocities through the cutoff as original obligations and use a budget smaller than their number, rather than guess a deletion set first. The equivalence is for the stated *local* coverage criterion, not a necessity claim for arbitrary nonlocal circle covers.

### 4. A composable block and an arithmetic collision repair

Here is a construction illustrating the role of velocity collisions in turning a local cover into a saving with distinct velocities. For \(4\mid Q\), consider original speeds
\[
Q,\quad 2Q,\quad 3Q,\quad 6Q.
\]
Use the three replacements
\[
\begin{array}{c|cc}
v&a&h\\ \hline
2Q&0&-1\\
3Q/2&1/2&1/2\\
3Q&1/2&1/2 .
\end{array}
\]
On odd numerators of either \(q=Q\) or \(q=2Q\), the zero-intercept runner covers \(0\le z\le1\). The half-intercept runner of speed \(3q/2\) covers \(-1\le z\le1/3\), since its inequality is \(|3z/2+1/2|\le1\). On odd numerators of \(q=3Q,6Q\), the runner of speed \(q/2\) covers the entire target. On even numerators it suffices that the original obligation of speed \(q/2\) is covered: it has the same center and a larger target. Such dependencies can always be checked from smaller to larger speeds.

This is **not** by itself a four-to-three distinct-velocity saving in the full baseline: \(3Q/2\) was already present. Two ways to make the block composable are:

* The incoming speed \(3Q/2\) can be a speed vacated by another block. In particular the block at \(4Q\) uses the speed \(6Q\) vacated by the block at \(Q\).
* An incoming speed can displace an original runner whose obligation is repaired by a **unit-class split**. In general, at original speed \(b\), take \(D\mid b\). The columns
  \[
  v_t=t b/D,\qquad a_t=1/D,\qquad h_t=0,
  \qquad 1\le t<D,\quad (t,D)=1
  \]
  cover every numerator \(k\) coprime to \(D\): choose \(t k\equiv-1\bmod D\), and use \(v_t/b<1\). For nonunit \(k\), it suffices to have the obligation at \(b/p\) covered for some prime \(p\mid(k,D)\). This split has no smoothness requirement on \(D\); as always, the resulting speeds must be checked for collisions.

For an explicit family, take any odd \(c\ge1\) and use \(m\) blocks at
\[
Q_i=8c\,4^i,\qquad 0\le i<m.
\]
All incoming collisions except the bottom one are resolved by the preceding block. The bottom collision is at \(b=12c\). Displace its original runner and use the \(D=4\) split: speeds \(3c,9c\), both at phase \(1/4\), cover its odd numerators; its even numerators are covered by the retained speed \(6c\).

For clarity, the other bottom dependency is \(Q_0/2=4c\), also retained. Higher up, \(Q_i/2=2Q_{i-1}\) and \(3Q_i/2=6Q_{i-1}\), so the even-numerator checks refer only to obligations already verified lower down. The two split speeds are odd and distinct. All even replacement speeds are distinct: within a block they are distinct, and the only speed brought in from the preceding block's original list is its **vacated** \(6Q_{i-1}\). Hence the count is
\[
\underbrace{4m+1}_{\text{original block speeds and }b}
-
\underbrace{(3m+2)}_{\text{block runners and split runners}}
=m-1.
\]
The largest affected velocity is \(48c\,4^{m-1}\). All the checks used the normalized interval inequalities, so the rule is uniform in \(\delta\) whenever the indicated baseline speeds are present.

At \(m=2,c=1\) the endpoint is \(192\), not strictly below it. The result for pursuing the stricter bounds is the pivot theorem: it removes the continuous search exactly while retaining arbitrary arithmetic incidences. I have not executed a cutoff search or inferred a saving from an untested branch.
