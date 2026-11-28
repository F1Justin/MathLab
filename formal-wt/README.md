# A single even signed WT witness

For every finite joint window–table law of Carter, O'Bryant and Tao, a single sequence of deterministic, atomwise symmetric, smooth compactly supported pairs approximates its autocorrelation in both the uniform and \(L^1\) norms. It approximates its reflected, extended covering uniformly on the whole line. Every output satisfies the original pointwise WT inequalities. The actual window energy converges to the input window energy, the limsup of the table surplus is bounded by the actual input surplus, and the covering lengths can tend to infinity. [English manuscript](../papers/wt-derandomization/single-even-window.pdf) · [Original WT definitions](https://arxiv.org/html/2610.36207v1#S2.SS2)

The formal entry points are `Witness.smooth_profile_approximation` for an arbitrary positive tolerance and lower length bound, and `Witness.smooth_profile_sequence` for all limits on the same sequence. The structure `SmoothProfileWitness` uses the original uncentered coordinates in its output and evaluates the covering target at the actual output half-length. [Input and feasibility](MathLab/WT/Basic.lean) · [Witness and sequence fields](MathLab/WT/ProfileTheorem.lean) · [Unconditional theorems](MathLab/WT.lean)

`smooth_infimum_eq` identifies the infimum over smooth deterministic symmetric pairs with the unrestricted infimum. The value \(4\sqrt2/3\) and the three previously studied infima are due to Akwei and Williams. The formal lower bound in this repository is \(\alpha\beta\ge495709/562500\). The identification with the sharp value in the manuscript invokes their analytic theorem. [Akwei–Williams v05](https://doi.org/10.5281/zenodo.24326518) · [15 audited declarations](verification/official-axioms.log)

With Lean 4.35.0 installed, run the following commands from this directory. The manifest pins mathlib. The replay command builds the project, exports the requested theorem declarations, checks which axioms occur, then feeds the export to Lean's standard kernel in an empty environment.

```sh
lake exe cache get
lake build
python3 replay.py
```

An independent cold build compiled the frozen project, including the integer certificate. All 51 project modules and entry points were replayed in the standard kernel. The two unconditional profile theorems, the smooth infimum equality and the elementary universal product bound were also exported together with their transitive dependencies and checked from an empty kernel environment. The 15 audited statements use only `propext`, `Classical.choice` and `Quot.sound`. [Frozen source hashes](verification/formal-sha256.json) · [Module replays](verification/module-kernel.tsv) · [Empty-environment replay](verification/profile-export-kernel.log)
