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
