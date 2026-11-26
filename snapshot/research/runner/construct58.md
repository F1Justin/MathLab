# Research design request: an exact shifted-runner certificate at n = 58

You are advising a computation-led mathematical research project. Produce a small set of high-value, executable experiments. The local Codex process will inspect your mathematics, implement the experiments, run them under CPU limits, and verify any candidate using exact arithmetic. Your response is a research proposal, not a report of experiments you have run.

## Exact target

For n distinct positive integer speeds v_i and rational starting shifts s_i in R/Z, define

    gamma(v,s) = max_{t in R/Z} min_i ||s_i + v_i t||,

where ||x|| is distance to the nearest integer. Find a configuration for n=58 with gamma(v,s) < 1/59. The stationary observer at 0 is not included in n. Arbitrary distinct positive integer speeds are allowed. A finite rational certificate suffices; an all-n proof would be a separate stronger result.

Known published and repository context, checked on 2026-11-26:

- Blanco–Criado–Santos: shifted counterexamples for 5<=n<=17, arXiv:2603.24784.
- Poliakova: counterexamples for every n>=95, arXiv:2609.23952.
- The repository 1337isnot1337/solved-conjectures at commit 75a0b27a1b3e76715a45704865454b14f8f1c63d contains exact certificates for every 18<=n<=57. Its latest result directory and Issue #110 leave 58<=n<=94 open.
- These are results about the shifted problem. The first concrete new deliverable is one uncovered n, not a new disproof of the already disproved universal shifted conjecture.
- Existing data/search contributions are credited upstream to aadrianvv (18..54) and tomdif (55..57).

Primary source URLs:

https://arxiv.org/abs/2603.24784
https://arxiv.org/html/2609.23952v1
https://arxiv.org/abs/2608.13599
https://github.com/1337isnot1337/solved-conjectures/blob/75a0b27a1b3e76715a45704865454b14f8f1c63d/results/shifted-lonely-runner-counterexamples/PROOF.md

All facts needed for this first design task are supplied below. Treat source URLs as provenance unless browsing tools are actually available. If a theorem beyond these facts would be useful, identify its exact required hypotheses and mark it for verification.

## Available implementation and validation

The existing solver uses:

1. A pool of certified (n-1)-runner configurations.
2. Adding a new speed and shift chosen to cover the largest fraction of uncovered sampled times.
3. A C heat-bath annealer that can change both speed and shift. At each occasional speed-change move it chooses among unused speeds <=4n.
4. A sequential linear-programming minimax polish using SciPy/HiGHS.
5. Rounding shifts to denominator 10^6 and exact verification.

The relevant existing files are a3chain3.py, a3s.c, hyb.py, addone.py, gam.py; optional beam.py maintains several bases per n. NumPy, SciPy and a C compiler are sufficient. a3chain3.py and beam.py require adaptation of two old absolute paths (HERE and OFF). The exploratory program may change; the exact acceptance rule is fixed.

For a rational configuration f(t)=min_i ||s_i+v_i*t|| is continuous piecewise linear. A maximum occurs among the finite times satisfying

    (v_i+v_j)*t + s_i+s_j is an integer, for some i<=j.

The i=j case includes a runner's half-integer turning point. Enumerating those times and evaluating f using rational arithmetic gives the exact maximum. A second complete certificate chooses rational delta<1/(n+1), constructs all arcs where some runner satisfies ||s_i+v_i*t||<=delta, and proves by rational interval union that these arcs cover [0,1]. Float scores and grid coverage are used only to guide search.

The local independent verifier already accepts the supplied n=57 seed by rational arc coverage. The pinned upstream verifier additionally recomputed its exact maximum as 43021/2500000. All 40 upstream certificates passed the upstream quick rational-cover replay. These are reproduced existing results, not new results.

For a new certificate the pinned upstream function check(c, exact=True) can be used directly. Its command-line main also enforces that the complete input list is precisely n=18..57, so a new n=58 certificate uses a separate wrapper calling check. The acceptance checker will not be weakened to make a candidate pass.

## Score, bottlenecks, and previous evidence

Define E=1/gamma-(n+1). E>0 certifies the current n. The supplied n=57 seed has E approximately 0.1112. A 57-runner seed with E>1 can be padded by an additional distinct speed with any shift to certify n=58; smaller positive E may still be a useful warm start, but does not establish that padding claim.

The upstream logs reported the following empirical pattern. An n=56 base with E approximately 0.027 yielded no n=57 certificate after 56 tries over about 2.3 hours. Once a different n=56 base with E approximately 0.6675 was available, the next n=57 attempt succeeded. This motivates improving and diversifying n=57 bases before spending heavily on extension to n=58. E>=0.5 is a heuristic quality target, not a proved threshold for extension.

Previously useful settings were speed limit 4n, MULT=0.6 (2.4 times the original default annealing length), seeds SO=1007,2007,3007, starting temperatures 16,24,8, and a small probability of speed-changing updates. The original driver occasionally kicks three randomly chosen runners to new speeds and shifts when a candidate is pinned near E=0. For a fair baseline, local Codex can disable automatic regeneration of previous-n bases and run equal CPU time for each strategy.

Previously unsuccessful approaches include simple superposition of certificates at different scales; freezing large-speed shifts at 0; quadratic chirp shifts; shifts restricted to halves or quarters; truncations of Poliakova's rule. Several restricted Poliakova-type speed/shift menus were proven infeasible, while other menus reached time limits. A new attempt at these ideas should specify which restriction or mechanism changes.

Many successful speed sets remove numbers with larger prime factors and add smooth speeds such as 60,72,84,90,96,108,120. This is an observed pattern, not a theorem. Blindly fixing a smooth set was not consistently useful. Earlier LP analyses exposed bottlenecks supported by two or three runners. Coordinated updates informed by active maxima or LP dual information are plausible alternatives to a random kick.

A prior n=35 search had zero uncovered grid cells while six narrow continuous-time peaks still exceeded the threshold. Any proposed faster objective must retain an exact final acceptance check. The integer NumPy helper is fast at current small speed and denominator bounds; changing those bounds requires an overflow analysis or arbitrary-precision fallback.

## Requested output

Give at most three genuinely different experiments, ranked by their expected information gained per CPU hour and per further API call. The first local round has approximately two CPU hours; exact validation and profiling are included in that budget. Prefer a targeted change to the existing search over rebuilding the solver.

For each experiment supply:

1. The mathematical or algorithmic mechanism and the specific obstacle it targets.
2. A concrete baseline and treatment, the variables changed, a reproducible seed plan, and an equal-CPU comparison.
3. Implementable pseudocode or a small pure function implementing the key change. Separate exact mathematical statements from heuristic choices.
4. The minimal metrics and saved artifacts, including how to capture active-constraint information if used.
5. What observed result would reject the proposed mechanism or justify another round.

Cover improving n=57 bases and attempting n=58. Consider both quality and diversity of the base pool. If proposing a symmetry reduction, prove that it preserves gamma under the fixed-origin problem; do not silently identify arbitrary global shifts of all runners with a symmetry.

Finish with a precise next-call packet schema: the small summary of measured results that local Codex should bring back to the API. Any explicit candidate configuration must come from a described computation and is only a candidate until the local exact verifier passes it. This first response should focus on research strategy and checkable derivations rather than inventing 58 speeds and shifts.

## Exact existing n=57 seed

The following certificate is copied from the pinned upstream data. It is an input for replication and warm starts, with attribution as above.

```json
{
  "n": 57,
  "speeds": [1,44,45,22,90,66,30,20,10,16,8,24,144,96,3,40,5,60,48,54,192,216,72,7,68,2,36,120,21,9,15,168,32,84,33,42,12,6,75,26,4,39,18,52,28,50,132,34,64,108,80,27,114,128,51,59,14],
  "shift_den": 1000000,
  "shift_num": [0,525841,411615,555852,364428,362234,810496,13130,658694,531211,428140,925784,169306,491976,461033,970333,575963,738807,961572,991124,932329,144862,25344,330805,333937,473219,270817,979830,526832,899903,645372,618149,945702,506446,532136,278669,267662,524024,131615,788450,538800,733296,52236,333261,122884,396715,480413,687090,224523,96866,556733,470352,300613,404557,306329,292364,13067],
  "gamma": "43021/2500000"
}
```


## New observations from the live run; override the generic first-round instructions above

At radius exactly 1/59 the published n=57 base leaves 207 positive-width time gaps. Its longest has length 26269/295000000. Exactly intersecting allowable phase arcs for the four widest gaps excludes EVERY single new speed; the longest gap bounds it by 380. More strongly, even two additional runners with arbitrary real phases and positive integer velocities (duplicates allowed) cannot cover the base's gaps. A length-L interval bounds the slower speed by 4δ/((1-4δ)L), here 816. We partitioned its phase into 32 closed bins, retained the widest 20 gap midpoints for which this runner misses the whole gap throughout a bin, and tested the residual runner against its width bound and the necessary midpoint-difference conditions ||v(t_i-t_j)||<=2δ. All 26112 boxes failed. Thus at least two original runners must be changed to reach 58 by extension. Original a3chain3 SO=1007 MULT=.6 four attempts produced E=-1.0000,-2.1974,-5.2548,-1.5725.

Seek a mathematically constructive new route to n=58, including designs based on the entire [58,94] interval and known local uniform rules (Poliakova). Think especially about a short proof or finite optimization that exploits the near-critical times of a comparatively simple symmetric base and makes coordinated adjustments of multiple runners. Give concrete parameterizations, actual bounds, mathematical justification and an executable discriminator. If your approach yields an explicit finite witness, give all required data. Do not report invented computations. Do not repeat the original simulated-annealing design. A single strong route with enough detail to implement is preferred.
