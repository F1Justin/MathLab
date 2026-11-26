Order the two new speeds as \(v<w\). The useful asymmetry is that **a whole gap of the slow runner cannot be filled by the fast runner**. This gives a finite bound on \(v\), a phase-intersection screen for each \(v\), and a constructive resolution of the case where the screen allows unbounded \(w\).

For the speed pairs that survive, there is an exact \(O(m\log m)\) phase test, where \(m\) is the number of components of \(H\). It does not trace the \(w\) bands around the circle. There is also an integer-linear alternative to testing a long range of \(w\)'s individually.

### 1. The slow speed bound and the length screen

Merge \(H\) into connected components, using an ordinary real lift \([a_i,b_i]\) for each arc, including one that crosses the circle cut. Write \(L_i=b_i-a_i\), \(c_i=(a_i+b_i)/2\). Retain isolated points as components of length zero. The whole circle is impossible by measure; if \(H\) consists only of rational points, a single speed divisible by all their denominators, with phase zero, suffices.

Let \(A_v(s)=\{x:\|vx+s\|<d\}\) and put \(B=2d/w\), the length of one fast band. In a real lift, the slow bands have length \(2d/v\) and the closed gaps between them have length \((1-2d)/v>B\). Thus, in a solution, a component of \(H\) cannot intersect two distinct slow bands: it would contain the entire gap between them. If it intersects one slow band, the portions left at its two ends must each have length strictly less than \(B\). If it intersects none, the whole component must have length strictly less than \(B\). Consequently, with \(L_{\max}>0\),
\[
 L_{\max}<\frac{2d}{v}+\frac{4d}{w},
 \qquad
 \boxed{\ v<\frac{6d}{L_{\max}}\ } . \tag{1}
\]

For a stronger test, define \(F_v(B)\) by intersecting the following constraints on the **one** circular variable \(s\):
\[
 \boxed{\quad
 \|s+vc_i\|<d+vB-\frac{vL_i}{2}
 \qquad\text{for every }i\text{ with }L_i\ge B .
 \quad} \tag{2}
\]
A nonpositive right side means infeasible. This is a **necessary screen for coverage**, and is **exact for the relaxation** that every component of \(H\setminus A_v(s)\) must have length \(<B\), without requiring a common fast phase.

Indeed, when \(L_i\ge B\), a slow band \((p,q)\) must meet the interval and leave end pieces of length \(<B\). The conditions are precisely
\[
 p<a_i+B,\qquad q>b_i-B.
\]
Substituting \(p=(k-s-d)/v,\ q=(k-s+d)/v\) gives (2). Conversely, those inequalities give the required length bound on the leftover pieces. Components with \(L_i<B\) need no test. Each constraint in (2), if nonempty, is a proper open arc: its width is at most \(2d+vB<4d<1\).

In particular, **one empty intersection \(F_v(2d/W)\) rules out every \(w\ge W\)**, for \(W>v\), by monotonicity of the length relaxation. Testing \(W=v+1\) first can discard a slow speed without trying any fast speeds.

An optional additional bound on \(v\) uses clusters of intervals. For any test arc \(J\), let \(\Delta_J=|H\cap J|-4d|J|\). If \(\Delta_J>0\), coverage requires
\[
 v<\frac{4d(1-2d)}{\Delta_J}.
\]
In fact a speed \(u\) covers at most \(2d|J|+2d(1-2d)/u\) of \(J\), by splitting \(u|J|\) into full periods and a remainder \(r\), whose contribution in scaled coordinates is at most \(\min(r,2d)\). Sum for \(v,w\) and use \(w>v\). The best \(\Delta_J\) can be found as a maximum circular subarc sum using density \(\mathbf 1_H-4d\).

### 2. Unbounded fast speeds: an exact dichotomy

For each remaining \(v\), test the **closed** arc intersection
\[
 C_v=\bigcap_{i:L_i>0}
 \left\{s:\ \|s+vc_i\|\le d-\frac{vL_i}{2}\right\}, \tag{3}
\]
where a negative right side gives the empty set. Do **not** impose this test on the isolated points.

* **If \(C_v\ne\varnothing\), there is a constructive solution.** Take any \(s\in C_v\). Every positive-length interval lies in one *closed* slow band, so the open slow bands can miss only interval endpoints and isolated points. Choose \(w>v\) divisible by all denominators of those points (using all input endpoints is fine), and \(t=0\). This gives an entire family of fast speeds.
* **If \(C_v=\varnothing\), doubling \(W\) starting at \(v+1\) until \(F_v(2d/W)=\varnothing\) terminates.** Otherwise, take a convergent subsequence of phases from the nonempty screens as \(W\to\infty\). Every positive-length interval eventually participates in (2), and the limit phase satisfies (3), a contradiction.

Thus (3) is **necessary and sufficient for solutions with arbitrarily large \(w\) at that \(v\)**. Its failure does not rule out bounded \(w\). In that case the first empty screen gives a proved finite cutoff, which can be tightened by bisection.

### 3. Reflection symmetry: a two-phase screen, not a two-phase ansatz

Suppose \(H\) is invariant under \(x\mapsto h-x\). The length screen is invariant under \(s\mapsto-vh-s\). If all participating arcs of (2) have width \(<1/2\), their intersection, when nonempty, is connected: on lifting one arc, at most one translate of each other arc can intersect it. A nonempty proper arc invariant under reflection contains a fixed point. Hence to decide **nonemptiness of the screen**, it suffices to test
\[
 s_0=-vh/2,\qquad s_1=-vh/2+1/2\pmod 1 .
\]
The same shortcut always applies to (3), whose arcs are short and closed.

In particular, **for \(d\le 1/8\)** the width condition for (2) holds for every \(w>v\), since \(2d+vB<4d\). This gives a direct cutoff with no doubling. Compute
\[
 D_j=\max\{\text{component length of }H\setminus A_v(s_j)\},
 \qquad D_*=\min(D_0,D_1),
\]
with maximum zero for an empty residual. Then:

* \(D_*=0\) gives the constructive endpoint solution above.
* For \(D_*>0\), **every solution at this \(v\) requires \(w<2d/D_*\)**. Indeed, nonemptiness of the length screen is exactly \(D_*<2d/w\).

This costs a scan of the components per slow speed: by (1), \(vL_i<6d\), so there are only constantly many slow band edges to examine per component. The shortcut does **not** say that the slow phase of an actual two-runner solution can be fixed to \(s_0\) or \(s_1\). It is the *length relaxation* that has that symmetry reduction.

### 4. Exact phase test for a surviving pair \((v,w)\)

Use a real lift \(0\le s<1\) and two circular coordinates for the fast phase:
\[
 t,\qquad u=t-\frac{w}{v}s\pmod 1 .
\]
The reason for \(u\) is that **all moving endpoints of the slow residual are stationary constraints in \(u\)**.

First require \(s\in F_v(2d/w)\). The remaining conditions are as follows.

1. For each input endpoint or isolated point \(e\), whenever \(\|ve+s\|\ge d\), activate the arc constraint
   \[
   \|t+we\|<d .
   \]
2. For each positive-length \([a_i,b_i]\) and slow band edge \(x=(k+\epsilon d-s)/v\), \(\epsilon\in\{-1,1\}\), activate
   \[
   \left\|u+\frac{w}{v}(k+\epsilon d)\right\|<d
   \]
   on the **closed** range
   \[
   k+\epsilon d-vb_i\ \le s\le\ k+\epsilon d-va_i .
   \]
   Only generate \(k\)'s whose range meets \([0,1)\).

These conditions test the fast band at every endpoint of every closed component of \(H\setminus A_v(s)\). They are **sufficient as well as necessary** after the length screen: a residual component has length \(<2d/w\), and if both endpoints are fast-covered they must be in the same lifted fast band, since the fast gap \((1-2d)/w\) exceeds \(2d/w\). A singleton simply requires coverage at that point.

Sweep \(s\) over the range boundaries from 1 and 2 and the arc boundaries from (2). Include singleton event cells, using the indicated strict or closed comparisons. On each surviving cell \(S\), let \(T\) be the intersection of the active \(t\)-arcs and \(U\) that of the active \(u\)-arcs; no constraints means the whole circle. If neither is empty, the **exact final test** is
\[
 \boxed{\qquad ((w/v)S\bmod 1)\ \cap\ (T-U)\ne\varnothing .\qquad} \tag{4}
\]
This just enforces the relation between \(t\) and \(u\). Each constrained nonempty intersection is a single open arc, so (4) is an integer-translate interval test by floors/ceilings, even if \((w/v)S\) traverses the circle many times. A witness can be recovered by choosing \(s\) in the successful intersection test and then \(t\in T\cap (U+(w/v)s)\). Rational interval arithmetic suffices.

There are \(O(m)\) events, again because \(vL_i<6d\). For an \(O(m\log m)\) implementation, maintain the active arc centers for each of \(T,U\) in circular sorted order with their largest gap. For a nonempty center set, open arcs of radius \(d\) have common intersection exactly when the largest gap is **strictly greater** than \(1-2d\) (gap \(1\) for a single center). Cutting there gives the two extreme centers and hence the intersection arc. Insertions and deletions cost \(O(\log m)\) with multiplicities. The stated complexity is in rational arithmetic operations, not independent of input bit lengths.

### 5. Alternative when the proved range of \(w\) is very long

One can batch the fast speeds by **exact mixed integer linear feasibility**, still with \(v\) fixed. Split \([0,1)\) only at \(s=\pm d-ve\bmod 1\) for input endpoints and points, retaining event cells. On each such cell \(S\), the closed components of \(H\setminus A_v(s)\) have endpoints of fixed affine form
\[
 [\alpha_j+\beta_j s,\ \gamma_j+\eta_j s],
 \qquad \beta_j,\eta_j\in\{0,-1/v\}.
\]
This follows because the slow band edges move in parallel and their order relative to the input endpoints does not change on the cell. Use the actual residual on singleton cells.

Take integer variables \(w>v,k_j\), real variables \(z,t\), and impose \(0\le t<1\) and \(z/w\in S\), the latter by multiplying the cell bounds by \(w>0\). Impose for each component
\[
 k_j-d<\alpha_j w+\beta_j z+t,\qquad
 \gamma_j w+\eta_j z+t<k_j+d .
\]
These are linear: \(z\) stands for \(ws\), and \(s\) is recovered as \(z/w\). They say exactly that the component lies in one open fast band. Thus this version can search an entire range of integer \(w\), even without a cutoff, in one system per cell. For a purely exact decision procedure, the two real variables can be projected out with strict rational linear elimination, then the remaining integer inequalities cleared of denominators and tested by integer linear feasibility.

A practical order is therefore: bound \(v\), apply the length screen or the symmetric \(D_*\) cutoff, take the constructive closed-fit solution whenever available, and use (4) on short remaining speed ranges or the linear systems on long ones. The screens alone, except for the constructive case, do not certify coverage. None of the steps depends on a phase mesh or on an assumed velocity ceiling specific to \(n=58\) or \(94\).
