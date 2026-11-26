**Verdict on Theorem 1: correct, including equality on the closed cube and sharpness of its radius.** Here “larger centred cube” means a larger \(\ell_\infty\)-ball in the stated phase coordinates. The sharpness example makes \(F(u)\) **larger** than \(1/p+M(u)\); it is not an example with \(F(u)<1/p\).

**Verdict on Theorem 2: correct, including the endpoint of the tube, under the standing assumption that \(p\ge7\) is prime and the order of \([2]\) modulo sign is odd.** The order condition is sufficient; the proof gives neither a converse nor a sharp tube radius. I would restate the prime and size assumptions in Theorem 2 itself.

I find no substantive proof repair necessary. Here is my independent check, including the estimates where a sign reversal or a lost strict inequality would change the result.

## Theorem 1: exact formula and first competing peak

Put \(d=1/p\) and \(r=\max_j|u_j|\). Two useful numerical checks are
\[
4r_0<d,\qquad \frac1{p+2}+r_0<d.
\]
The first follows from \(Q\ge3\). For the second, \(2Q\ge p-3\), so it suffices to check
\[
\frac1{(p-3)(p+1)}<\frac{2}{p(p+2)}.
\]
After clearing denominators this is \(p^2-6p-6>0\), which already holds at \(p=7\), with value \(1\). Thus the exclusion of denominator sums at least \(p+2\) has **strict** slack even on the boundary.

### Lower bound

Choose a pair \(a,b=p-a\) attaining \(M\), and let \(ka\equiv1\pmod p\). At the two times
\[
t=\pm k/p-(u_a+u_b)/p
\]
the signed residues for \(a,b\), before taking distance to the integers, are
\[
\pm d+X,\qquad \mp d-X,\qquad X=(bu_a-au_b)/p.
\]
Choose the sign to agree with \(X\). Both distances are \(d+|X|\), with no wraparound since \(|X|\le r\) and \(d+r<1/2\).

Every other runner has nominal distance at least \(2d\): multiplication by \(k\) permutes the nonzero residues, and \(a,b\) exhaust residues \(\pm1\). Its correction has magnitude at most \((3-2/p)r\). By the \(1\)-Lipschitz property of distance to the integers, its distance is at least
\[
2d-(3-2/p)r\ \ge\ d+r\ \ge\ d+|X|.
\]
This proves \(F(u)\ge d+M(u)\). Only one sign of time is needed, chosen for the maximizing pair.

### Upper bound

Let \(P/q<S/h\) be consecutive Farey fractions of order \(p-1\). The identities used are \(qS-hP=1\) and \(q+h\ge p\). One direct check is to choose \(h\) largest at most \(p-1\) satisfying \(hP\equiv-1\pmod q\), and set \(S=(1+hP)/q\). Then \(q+h>p-1\), and any fraction \(J/\ell\) strictly between the two has
\[
\ell=h(qJ-P\ell)+q(S\ell-hJ)\ge h+q.
\]
This also covers the first interval starting at \(0/1\).

For \(t\) in the interval, set \(A=qt-P+u_q\), \(B=S-ht-u_h\). If \(A<0\), then \(|A|\le r\) since \(qt-P\ge0\); the corresponding statement for \(B<0\) uses \(S-ht\ge0\). In either case a runner is at distance at most \(r<d\). Otherwise the minimum distance is at most
\[
\min(A,B)\le\frac{hA+qB}{q+h}
=\frac{1+hu_q-qu_h}{q+h}.
\]
There is no assumption here that \(P,S\) remain the nearest integers after perturbation: using them gives an **upper** bound, which is the direction needed.

* If \(q+h=p\), the phase term is a complementary-pair form, up to sign, so the bound is at most \(d+M\).
* If \(q+h\ge p+2\), the bound is at most \(1/(p+2)+r_0<d\).
* If \(q+h=p+1\), now call the smaller denominator \(q\). Reversing endpoint order can reverse the sign of the phase numerator, but in either order it is bounded above by \(h|u_q|+qr\). Coprimality excludes equal denominators, so \(q\le(p-1)/2\). For \(p=4m+1\), the candidate \(q=2m\) would give \(h=2m+2\), both even. Thus \(q\le Q\) in both residue classes.

In the last case \(q<p/2\), so using the form indexed by \(q\) is legitimate:
\[
M\ge \frac{(p-q)|u_q|-qr}{p}.
\]
Subtracting gives
\[
\frac{h|u_q|+qr}{p+1}-M
\le \frac{q|u_q|}{p(p+1)}
  +qr\left(\frac1{p+1}+\frac1p\right)
\le \frac{2qr}{p}.
\]
The small coefficient in the first term has **positive** sign: it is \(h/(p+1)-(p-q)/p=q/[p(p+1)]\). Consequently the excess of this interval bound over \(d+M\) is at most
\[
-\frac1{p(p+1)}+\frac{2qr}{p}\le0.
\]
It is strictly negative if \(r<r_0\) or \(q<Q\). This proves the upper bound and identifies which non-\(p\) intervals could first tie it.

### Sharpness

Write \(n=p+1,\ q=Q,\ h=n-q\). Then \(n-2q\) is \(2\) or \(4\), and \(q\) is odd; hence \(\gcd(q,n)=1\). The four phase assignments in the manuscript do not collide:
\[
p-h=q-1<q<p-q<h\le p-1.
\]
The pair \(p-h,h\) contributes zero to \(M\), because \(h u_{p-h}=(p-h)u_h\). The pair \(q,p-q\) therefore gives \(M=(p-2q)r/p\).

Take \(kq\equiv1\pmod n\). At \(t=k/n\), the nominal signed residues for \(q,h\) are \(+1/n,-1/n\), respectively, so their assigned phases increase both distances to \(1/n+r\). Since \(k\) is a unit modulo \(n\), no other speed has residue \(0,\pm1\). For \(r\le1/(2n)\), every other distance is at least \(2/n-r\ge1/n+r\). Thus the **actual minimum** at this time, not just a two-runner estimate, exceeds the proposed formula by
\[
\left(\frac1n+r\right)-(d+M)
=\frac{2qr}{p}-\frac1{p(p+1)}.
\]
This is zero at \(r=r_0\) and strictly positive for \(r>r_0\). Since \(Q>1\), we have \(r_0<1/(2n)\), so such \(r\) can be chosen inside **every** larger centred cube. The competing time really does belong to the claimed Farey interval: its endpoint numerators are \((qk-1)/n\) and \((hk+1)/n\), with denominators \(q,h\) and determinant one.

## Theorem 2: the strict-sign obstruction

The minimum defining \(R\) is attained by compactness. Translate time and choose independent integer lifts so that \(r=\max_j|u_j|=R(u)\). Neither operation changes \(F\). Under the proposed tube bound,
\[
r\le \frac{2(p+1)}{3p-1}d<d.
\]
Assume \(F(u)<d\). The quantifier now available is: **at every time, some runner has distance strictly less than \(d\)**. The runner need not be the same at different times.

### Pair signs and strict slack

Consider any time-translated lifts \(v\) with \(\max_j|v_j|\le d\). At \(+k/p\), with \(ka\equiv1\pmod p\) and \(h=p-a\), only \(a,h\) can be strictly below \(d\): the others start at distance at least \(2d\). The signed nominal residues for \(a,h\) are \(+d,-d\), so strict failure requires
\[
v_a<0\quad\text{or}\quad v_h>0.
\]
At \(-k/p\) it requires \(v_a>0\) or \(v_h<0\). There is no wraparound ambiguity since \(2d<1/2\). The conjunction says exactly that \(v_a,v_h\) are both strictly positive or both strictly negative. In particular neither can vanish.

For every \(|z|\le(d-r)/(p-1)\), the lifts \(v_j=u_j+jz\) satisfy the same magnitude bound \(d\). If \(|u_j|\le j(d-r)/(p-1)\), the allowed choice \(z=-u_j/j\) would make \(v_j=0\). Hence
\[
|u_j|>j(d-r)/(p-1).
\]
The strict inequality is justified even when this choice of \(z\) would be an endpoint, because the sign argument allowed lift magnitude **equal** to \(d\).

### Forcing the opposite sign in class \([2a]\)

Choose \(a<p/2\), so \(h=p-a\ge(p+1)/2\). At times \(\pm k/p-u_h/h\), write \(\Delta_j=u_j-ju_h/h\). Runner \(h\) is exactly at distance \(d\). Choose the sign so that runner \(a\) has distance \(d+|\Delta_a|\); this is valid since \(|\Delta_a|\le2r<2d\) and \(3d<1/2\). For all \(j\),
\[
|\Delta_j|
\le (1+(p-1)/h)r
\le \frac{3p-1}{p+1}r
\le 2d.
\]
Thus a runner of nominal distance at least \(3d\) cannot be strictly below \(d\), **even at equality** in this last bound. At the selected time a runner must be strictly below \(d\); it is neither \(a\) nor \(h\), so its nominal distance is exactly \(2d\). This gives \(jk\equiv\pm2\pmod p\), or \([j]=[2a]\). Lipschitz continuity also gives \(|\Delta_j|>d\), not merely \(\ge d\).

If \(u_j,u_h\) had the same sign, then \(|\Delta_j|\) would be the absolute difference of \(|u_j|\) and \(j|u_h|/h\). The first minus the second is at most \(r<d\). In the other direction the strict slack gives
\[
j|u_h|/h-|u_j|
<\frac{j}{p-1}\big[(1+(p-1)/h)r-d\big]\le d.
\]
This contradicts \(|\Delta_j|>d\). Since complementary runners have the same strict sign, the sign is well defined on each class, and we have proved
\[
s_{[2a]}=-s_{[a]}\qquad\text{for every }[a]\in G.
\]
Multiplication by \([2]\) has cycles of length \(\operatorname{ord}_G([2])\). Alternation on an odd cycle is impossible. This proves the theorem without discarding the outer boundary of the tube.

## Small-prime checks

| \(p\) | Sharp pair \((q,h)\); test time | Boundary check for Theorem 1 | Theorem 2 |
|---|---|---|---|
| \(7\) | \((3,5)\); \(3/8\) | \(M=r/7\) in the witness. \(1/8+r=1/7+r/7\) at \(r=1/48\). The next-sum bound is \(1/9+1/48=19/144<1/7\). | Modulo sign the cycle is \([1],[2],[3]\), of length \(3\). The radius is \(4/35\); indeed \((1+6/4)(4/35)=2/7\), testing the non-strict correction bound exactly. |
| \(13\) | \((5,9)\); \(3/14\) | \((6,8)\) is inadmissible. \(M=3r/13\) in the witness, and \(1/14+r=1/13+3r/13\) at \(r=1/140\). The next-sum bound is \(1/15+1/140=31/420<1/13\). | The cycle is \([1],[2],[4],[5],[3],[6]\), of length \(6\). The theorem **does not apply**. An alternating assignment is combinatorially possible; that is not a counterexample to the tube inequality. |

The two displayed radii for \(p=59\) are also arithmetically correct.

## Scope, literature, and presentation

* **Local versus global.** Theorem 1 proves a non-strict local minimum and the stated level section **within the cube**. The pair forms are invariant under the real shift \(u_j\mapsto u_j+j\tau\), but not under arbitrary independent changes of integer representatives; \(F\) is invariant under both. Theorem 2 says that any strict improvement \(F(u)<1/p\), if one exists for a qualifying prime, must have \(R(u)\) strictly beyond its bound. Neither theorem determines \(\min_u F(u)\), or the exact infimum of \(R(u)\) over improving phases.
* **Literature positioning.** Hardy–Wright, Chapter III, is an appropriate source for the Farey facts. I have not independently verified the cited recent arXiv versions and would not certify the \(9/67\) attribution or a novelty claim from the manuscript alone. For the sentence asserting an **exact global minimum** for \(1,\ldots,6\), give a precise result locator and distinguish a phase vector attaining \(9/67\) from a matching lower bound for **all** phases of those fixed speeds. If only the former is sourced, \(\min_u F(u)\le9/67<1/7\) is the supported statement and already suffices for the introduction. Results that also change the speeds are context, not direct comparisons of local radii.
* **Computational verification.** The candidate-time principle is sound: the maximum is positive since the runner zero sets are finite. Away from a half-integer cusp, a maximum needs an increasing and a decreasing active branch; equality of their distances gives \((i+j)t+u_i+u_j\in\mathbb Z\). A half-integer cusp is covered by \(i=j\). This checks the enumeration principle, not the unseen implementation. Neither theorem needs the computation.

My recommendation is to retain both theorems, make the standing hypotheses and coordinate convention explicit, and tighten the sourcing of the global comparison.
