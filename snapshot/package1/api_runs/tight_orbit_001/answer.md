For the standard speeds \(1,\ldots,58\), there is a quantitative obstruction involving **all 29 complementary speed pairs**. Put \(d=1/59\) and
\[
F(s)=\max_{t\in\mathbb R/\mathbb Z}\min_{1\le i\le58}\|it+s_i\|.
\]
Then
\[
\boxed{\quad
\min_{\tau\in\mathbb R/\mathbb Z}\max_{1\le i\le58}\|s_i+i\tau\|
\ \le\ \frac{15}{22}\,d
\quad\Longrightarrow\quad F(s)\ge d .
\quad} \tag{1}
\]
Thus even shifts of more than two-thirds of the target distance, measured from the homogeneous orbit in the sup norm, cannot give a strict escape. The obstruction is an impossible sign alternation under doubling modulo 59.

There is also a **sharp smaller neighborhood** in which \(F\) has an exact piecewise-linear formula. I give both results, followed by a finite phase-chamber test that applies outside these neighborhoods and to other speed sets. These are rigidity and search results, not a strict-escape example.

### 1. Rigidity from the doubled pairs

Write \(p=59\). By translating time, take real lifts \(u_i\) of the phases with \(|u_i|\le\rho\), where \(\rho\le 15d/22\). Suppose for contradiction that \(F(u)<d\).

**First, the two phases in each pair \(\{a,p-a\}\) must have the same strict sign.** In fact, this is necessary whenever all \(|u_i|\le d\). Choose \(k\) with \(ka\equiv1\pmod p\), and test \(t=\pm k/p\). All speeds other than \(a,p-a\) have unshifted distance at least \(2d\), so cannot give distance strictly below \(d\). At \(+k/p\) we therefore need \(u_a<0\) or \(u_{p-a}>0\); at \(-k/p\) we need \(u_a>0\) or \(u_{p-a}<0\). Together these require the same strict sign.

There is a useful magnitude consequence. For every
\[
|z|\le (d-\rho)/58
\]
all translated phases \(u_j+jz\) are still in \([-d,d]\). By the same sign test, none can vanish. Hence
\[
|u_j|>\frac{j}{58}(d-\rho)\qquad(1\le j\le58). \tag{2}
\]

Now take any complementary pair, writing \(a\le29\) and \(h=p-a\ge30\). **Anchor the larger speed** by probing at
\[
t_\pm=\pm k/p-u_h/h,\qquad ka\equiv1\pmod p.
\]
Speed \(h\) has distance exactly \(d\) at both probes. Speed \(a\) has distance at least \(d\) at one of them: choose the sign so that its residue \(\pm d\) and its phase correction \(u_a-a u_h/h\) have the same weak sign. There is no wraparound issue since \(d+2\rho<1/2\).

At this chosen probe the correction for any speed \(j\) satisfies
\[
|u_j-j u_h/h|\le (1+58/30)\rho\le 2d. \tag{3}
\]
Thus a speed with nominal distance at least \(3d\) cannot block the probe. The **only possible blockers** are the two speeds with nominal distance \(2d\), namely the pair
\[
j\equiv \pm 2a\pmod p.
\]
To block, such a speed needs \(|u_j-j u_h/h|>d\).

But this is impossible if \(u_j\) has the same sign as \(u_h\). Indeed, one direction of the difference is bounded by \(|u_j|\le\rho<d\), and the other, using (2), satisfies
\[
\frac jh|u_h|-|u_j|
<
\frac j{58}\big[(1+58/h)\rho-d\big]
\le d.
\]
Consequently the pair \(\{\pm2a\}\) must have the **opposite** sign to the pair \(\{\pm a\}\).

Doubling permutes the 29 unordered nonzero residue pairs modulo 59. A permutation of 29 objects has an odd cycle, on which strict sign alternation is impossible. This proves (1). The use of strict escape matters: an unblocked probe at distance exactly \(d\) is enough for the contradiction.

### 2. Exact local formula, with a sharp cube radius

For real phase lifts \(u_i\), put
\[
M(u)=\max_{1\le a\le29}\left|
\frac{(59-a)u_a-a u_{59-a}}{59}
\right|.
\]
Then
\[
\boxed{\qquad
\max_i |u_i|\le \frac1{3480}
\quad\Longrightarrow\quad F(u)=\frac1{59}+M(u).
\qquad} \tag{4}
\]
The radius \(1/3480\) is the largest centered sup-norm cube on which this formula holds. In particular, the local flat directions are exactly
\[
\frac{u_a}{a}=\frac{u_{59-a}}{59-a}\qquad(1\le a\le29).
\]
The pairs can undergo **independent** small time translations along this flat locus; they need not all undergo the same translation.

**Lower bound.** Take a pair \(a,b=59-a\) attaining \(M\), and \(ka\equiv1\pmod{59}\). Probe at
\[
t=\pm k/59-(u_a+u_b)/59.
\]
The corrections for \(a,b\) are now exactly \(D,-D\), where \(D=(b u_a-a u_b)/59\). At the better of the two signs their distances are both \(d+M\). Writing \(\rho=\max_i|u_i|\), every third speed has nominal distance at least \(2d\) and correction of magnitude less than \(3\rho\). Since \(4\rho\le d\) in the stated cube and \(M\le\rho\), no third speed lowers this probe below \(d+M\).

**Upper bound.** Partition \([0,1]\) by the reduced fractions of denominator at most 58. For adjacent endpoints \(P/q<R/h\), the Farey identities are \(qR-hP=1\) and \(q+h\ge59\). On that interval use the two forms
\[
A=qt-P+u_q,\qquad B=R-ht-u_h.
\]
If either is negative, its absolute value is at most \(\rho\). Otherwise the minimum distance is at most \(\min(A,B)\), hence at most their weighted average
\[
\frac{hA+qB}{q+h}
=\frac1{q+h}+\frac{h u_q-q u_h}{q+h}. \tag{5}
\]
This bounds the whole interval, not just its unshifted peak.

* If \(q+h=59\), (5) is at most \(d+M\).
* If \(q+h\ge61\), it is at most \(1/61+\rho\le d\).
* The decisive competitor is \(q+h=60\). Denote the smaller denominator by \(q\), so \(q\le29\), and the larger by \(h\). Regardless of their order as endpoints, the phase gain in (5) is at most \((h|u_q|+q\rho)/60\). Since
  \[
  M\ge\frac{(59-q)|u_q|-q\rho}{59},
  \]
  subtraction gives
  \[
  \frac{h|u_q|+q\rho}{60}-M
  \le \frac{2q}{59}\rho\le\frac{58}{59}\rho.
  \]
  Thus this competitor is harmless precisely for the bound we need:
  \[
  \frac1{60}+\frac{58}{59}\rho\le\frac1{59}
  \qquad\text{when }\rho\le\frac1{3480}.
  \]

**Sharpness of the formula radius.** Set
\[
u_{29}=u_{30}=\rho,\qquad u_{31}=-\rho,\qquad
u_{28}=-28\rho/31,
\]
and all other phases to zero. Then \(M=\rho/59\). At \(t=29/60\), speeds 29 and 31 have signed nominal residues \(+1/60,-1/60\), and both shifts point outward. Every other speed has nominal distance at least \(2/60\). Thus for \(1/3480<\rho\le1/120\),
\[
F(u)\ \ge\ 1/60+\rho\ >\ 1/59+\rho/59.
\]
So (4) fails immediately beyond its stated cube. This loss of the formula is **not** escape: it is a denominator-60 peak overtaking the denominator-59 peaks.

### 3. Exact finite phase-chamber test for a global search

For any fixed distinct positive integer speeds \(v_i\), strict escape at \(d=1/59\) has the following necessary **and sufficient** test. For every \(i\) and \(m=0,\ldots,v_i-1\), require at least one \(j\ne i\) and integer \(\ell\) satisfying
\[
\boxed{
-v_i d
<
v_j(m+d)+v_i s_j-v_j s_i-v_i\ell
<
v_i d .
} \tag{6}
\]

To see why, the bad times for runner \(i\), meaning \(\|v_i t+s_i\|<d\), are open circular arcs with right endpoints
\[
E_{i,m}=(m+d-s_i)/v_i\pmod1.
\]
A finite nonempty union of open arcs is the whole circle iff every right endpoint is covered: otherwise a right boundary of a component is an uncovered right endpoint. Condition (6) says exactly that runner \(j\) covers \(E_{i,m}\). Full coverage is equivalent to a maximum **strictly** below \(d\), by continuity and compactness.

This gives two ways to check a claim exactly:

* **Given rational phases:** for each endpoint, test \(\|v_j E_{i,m}+s_j\|<1/59\) by integer arithmetic. For \(1,\ldots,58\) there are only \(1711\) endpoints. An endpoint failing all tests is itself an exact witness against the candidate.
* **Given unknown phases:** restrict \(0\le s_i<1\); in (6) it suffices, for example, to enumerate \(|\ell|\le v_j+2\). The slab boundaries in (6) form a finite rational hyperplane arrangement, with every slab normal involving only the time-translation invariant \(v_i s_j-v_j s_i\). On each chamber all endpoint tests are constant. Equivalently, choosing a covering disjunct for each endpoint leaves a rational linear feasibility problem with strict inequalities. Any strict escape has a rational phase witness, since the strict covering conditions are open.

Thus a global search for the standard speeds can exclude the entire tube (1) about the homogeneous orbit, and any proposed escape outside it can be certified without sampling a time grid.
