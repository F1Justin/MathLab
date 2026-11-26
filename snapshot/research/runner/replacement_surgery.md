# Deleting any two runners and inserting one

Two complete replacement tests at the original strict target gave the following exclusions.

| Target | Starting configuration | Removed pairs checked | Largest necessary new speed | Successful replacements |
|---:|---|---:|---:|---:|
| 58 | Speeds 1 to 59, all at phase zero | 1,711 | 170 | 0 |
| 94 | Poliakova's 95-runner construction, using its phases at $\delta=1/97$ | 4,465 | 580 | 0 |

In each row *any* two of the original runners can be removed. The inserted runner can have any positive integer speed distinct from the surviving speeds and any real phase, including one of the deleted speeds at a different phase. The speed bounds are derived separately for each pair. These exclusions apply to the indicated fixed phases of the survivors.

At target $d=1/(n+1)$ form the open arcs in the time circle of the starting system. Sweep their endpoints and record every open cell and every single endpoint covered by at most two original runners. For an endpoint, first remove the arcs ending there, record its current coverage, and only then insert the arcs starting there. Deleting a pair $i,j$ leaves exactly the recorded pieces whose previous coverage was contained in $\{i,j\}$. Merge their closures. If the largest residual interval has length $w>0$, the new speed must be at most $\lfloor2d/w\rfloor$. A new runner at speed $v$ must put its phase in the *open* window $(-va-d,-vb+d)$ modulo one for every residual $[a,b]$, including isolated points. Intersect those windows after normalization by the first left endpoint, as in the [sharp fixed-seed optimization](optimal_extension.md). The calculation uses integer and rational arithmetic. It covers the continuum and addresses strict improvement, even if a deletion pattern admits equality.

**Reflection reduction.** More generally, if the residual set $H$ is symmetric about time zero and $d<1/4$, a single extra runner that strictly covers $H$ at phase $s$ can be put instead at phase $0$ or $1/2$. For any $t\in H$ both $s+vt$ and $s-vt$ are within $d$ of integers $k,l$. Thus $s$ is within $d$ of $(k+l)/2$. Modulo one this choice between $0$ and $1/2$ is unique and independent of $t$. After recentering, both $s-(k+l)/2$ and $vt-(k-l)/2$ are obtained by adding or subtracting the two signed errors and dividing by two. Indeed their absolute values sum to the maximum absolute error. The new phase therefore covers every $t$, with at least the same slack. A time translation gives the version for any reflection center. This simplification applies to the first test; the verifier treats continuous phases directly in both tests.

[Exact verifier](single_replacement.py) · [full configurations and results](single_replacement.json) · [Poliakova's source construction](https://arxiv.org/html/2609.23952v1).

## Three deletions and two unrestricted replacements

Tested twelve triples in each starting configuration, allowing both new runners to choose distinct positive integer speeds and arbitrary real phases. To select the triples reproducibly, rank them by the number of positive-length cells exposed before merging, breaking ties by seed order. All 24 tests exclude strict improvement for the specified survivors. For example, deleting speeds 1, 2 and 6 from the 59-runner seed leaves eight intervals. Deleting speeds 2, 3 and 9 from the 95-runner seed leaves twelve. These results concern only the listed triples.

For slower speed $v$ and faster speed $w$, a component of the residual cannot span two slow bands, since a complete gap between them is longer than any fast band. Thus a residual component of length $L$ requires $L<2d/v+4d/w$. Testing its two end portions gives a necessary circular interval for the slow phase, shrinking as $w$ grows. The solver returns a global exclusion only when a length bound or an empty intersection rules out all higher speeds. Its fallback speed cap was 2500. None of the 24 results depended on truncation.

For each surviving speed pair the solver partitions the two-dimensional phase space into rectangles where the relevant winding indices are fixed. A missed time is a common point of three closed intervals: a residual component and one gap of each runner. Their pairwise intersection conditions give closed forbidden intervals for the single coordinate $ws-vb$, where $s,b$ are the two phases. A strict cover of a compact set persists under small phase perturbations, so testing the open phase rectangles suffices, including when a residual time component is a singleton.

[Astra's search implementation](two_speed_search.py) · [reproduce the selected triples](triple_replacement.py) · [results by triple](triple_replacement.json).
