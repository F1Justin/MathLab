# The optimal extension of a fixed shifted-runner configuration

Keep the published speeds and initial phases of 57 runners fixed. On a circle of circumference one, append a runner of a distinct positive integer speed and any real initial phase. The least attainable covering radius is

$$d_* = \frac{1359451}{79000000}.$$

At every real time some runner lies within $d_*$ of the origin for speed $528344$ and phase $4737613/31600000$. For each choice of extra runner there is a time when all 58 distances from the origin are at least $d_*$. The statements concern this fixed seed. [Audited statements](Challenge.lean) · [Lean proofs](Solution.lean) · [57-runner data](data/seed-57.json)

Keeping all 57 original speeds fixed, independently moving each original phase by at most $1207609/4661000000$ turns on the circle still gives a time when all 58 distances are at least $1/59$, for any positive integer extra speed and any real extra phase. The tolerance equals $d_* - 1/59$. The proof uses the same obstruction time with a triangle inequality for each perturbed phase. [Perturbation proof](MathLab/FrozenStability.lean)

## Proof

The upper bound uses a chain of closed rational time intervals. On each interval one track stays within $d_*$ of an integer. The chain covers a full period and the solution carries it to every real time using the integral speeds.

For the lower bound, six pairs of rational times have every original track at distance at least $d_*$. For each speed through $820800$, at least one of the pairs puts the two positions of the extra runner at cyclic distance at least $2d_*$. No real phase places both positions strictly within $d_*$. The first pair has time difference $1/8$ and covers every speed with nonzero remainder modulo eight. A finite kernel computation checks the remaining speeds. For greater speeds, one certified interval keeps all original distances at least $d_*$, and it contains two times separated by $2d_*/v$. [Interval-chain proof](MathLab/FrozenUpper.lean) · [Finite sieve](MathLab/FrozenSieve.lean) · [Lower-bound certificate proof](MathLab/Witness.lean)

A separate exact integer enumeration gives the unique attaining speed and the full closed interval of attaining phases modulo one. Lean establishes the optimum, the stated attaining configuration, and the stability bound. The additional library results are a generic phase-grid equivalence for ordered rational time intervals and the discrepancy and saving inequalities for the integer counting function in periodic rule packing. [Phase-grid proof](MathLab/PhaseTestReal.lean) · [Periodic counting proof](MathLab/PeriodicPacking.lean)

## Reproduce

With Python 3.10 or later and elan, run from this directory. The toolchain and manifest select Lean 4.35.0 and pin the Mathlib dependency graph.

```sh
python3 scripts/rebuild_frozen_data.py
lake exe cache get Mathlib.Tactic.Ring Mathlib.Tactic.NormNum Mathlib.Tactic.Positivity Mathlib.Tactic.FieldSimp Mathlib.Tactic.Linarith Mathlib.Topology.Order.IntermediateValue Mathlib.Topology.Instances.Real.Lemmas
lake build
lake env lean scripts/AuditAxioms.lean
lake env leanchecker -v MathLab Solution
```

Run `lake comparator` on Linux with bubblewrap and user namespaces available. Comparator builds the statements independently, compares them with the proved solution, and replays the export through Lean and NanoDa. The four intentional `sorry` placeholders belong to the Challenge. [Configuration](comparator.json) · [Palomar submission standard](https://github.com/PalomarRegistry/PalomarPolicy/blob/main/CONTRIBUTING.md)

The original development is MIT-licensed. The fixed 57-runner configuration was contributed by tomdif. The closed-interval checker is adapted from the upstream MIT-licensed formalization. Chengyi Fang directed the work and maintains the release. The proof development and review used automated assistance, with complete human proof understanding recorded as none. [Chengyi Fang](https://orcid.org/0009-0006-1237-7763) · [Original license](LICENSE) · [Upstream license](LICENSE-cover) · [Upstream formalization](https://github.com/1337isnot1337/solved-conjectures/blob/60e47a0419d97deb104e72eb23692232430ce35f/results/shifted-lonely-runner-counterexamples/FORMALIZATION.md) · [Provenance](formalization.yaml)
