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
