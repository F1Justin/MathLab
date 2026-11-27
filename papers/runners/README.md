# Shifted lonely runners

| Manuscript | Results |
| --- | --- |
| [Compatible local replacements](compatible-replacements.pdf) · [LaTeX](compatible-replacements.tex) | For every $n$, $E_n\ge\max\{\lfloor n/150\rfloor,\lfloor(8011n-3241770)/1085489\rfloor\}$. The expanded construction gives $\liminf E_n/n\ge513079/69470921$. A finite decision procedure covers affine local rules with real phase parameters and all odd added speeds. |
| [One-runner extension and phase stability](frozen-extension.pdf) · [LaTeX](frozen-extension.tex) | With the public 57-runner seed fixed, the exact extension optimum is $1359451/79000000$ at the unique new speed $528344$. The paper gives all optimal phases, a stability radius and a weighted obstruction to seven additions. |

The first paper builds configurations for the infimum over distinct positive integer speeds and arbitrary phases. The second optimizes and modifies specified seeds, and covers several stated phase boxes and finite menus. The prime-orbit phase result has a separate manuscript in this release. The 58-runner target concerns the unrestricted global inequality $\Gamma(58)<1/59$, which remains open in the cited sources.

## Reproduction

Run from the publication package root. The launcher verifies outputs against the frozen certificates and uses a temporary copy for scripts that write JSON.

~~~sh
python3 papers/runners/replay.py packing
python3 papers/runners/replay.py frozen
python3 papers/runners/replay.py boxes
python3 papers/runners/replay.py menus
~~~

The packing checks use Python's standard library. The frozen checks use NumPy for the residual measures. Z3 runs the phase-box suite and PySAT runs the finite-menu suite. The publication replay used Python 3.14.0, NumPy 2.4.2, Z3 5.4.1.0 and python-sat 1.9.dev25. The two larger phase-box computations can take minutes. Their SMT results are expected to be `unsat`. An `unknown` or a timeout does not exhaust a box.

Compile the manuscripts from their directory with `latexmk -pdf compatible-replacements.tex frozen-extension.tex`. The Lean project and its replay instructions are in [formal](../../formal/README.md).

## Frozen research inventory

| Work | Evidence and scope |
| --- | --- |
| Disjoint, then compatible local rules | [Disjoint construction](../../snapshot/research/runner/packing_theorem.md), [merged construction](../../snapshot/research/runner/overlap_packing.md), [periodic profile and expanded layers](../../snapshot/research/runner/periodic_packing.md). The local replacement ingredients are Poliakova's. Every merge and integer discrepancy is certified by exact arithmetic. |
| Finite decision problem and small exclusions | [Finite speed and phase reductions](../../snapshot/research/runner/bounded_local_rules.md), [pivot search](../../snapshot/research/runner/local_pivot.py). The computation rules out positive gain at all even cutoffs through 12 in the affine class. |
| Exact frozen optimum and local stability | [Sharp phase window and unique speed](../../snapshot/research/runner/optimal_extension.json), [Lean theorem](../../formal/MathLab/FrozenOptimum.lean), [Lean perturbation bound](../../formal/MathLab/FrozenStability.lean). The optimum and perturbation bound are formalized. The unique speed and full phase interval are obtained by Python enumeration. |
| One- and two-runner baseline exclusions, then weighted obstruction | [Direct gap proof](../../snapshot/research/runner/frozen_obstruction.md), [unweighted measure](../../snapshot/research/runner/residual_mass.json), [weighted measure proof](../../snapshot/research/runner/residual_measure.md), [integer weights](../../snapshot/research/runner/residual_weights.json). The last bound applies even with repeated speeds among additions. |
| Deletions with frozen survivors | [Proof and protocol](../../snapshot/research/runner/replacement_surgery.md), [all deletion pairs](../../snapshot/research/runner/single_replacement.json), [24 selected triples](../../snapshot/research/runner/triple_replacement.json). The 58-runner and 94-runner targets use different fixed seeds and exact strict inequalities. |
| Coordinated phase changes | [Continuous-time reduction](../../snapshot/research/runner/endpoint_boxes.md), [standard box](../../snapshot/research/runner/standard58_box.json), [search-candidate box](../../snapshot/research/runner/chain58_box.json), [203-endpoint cross-check](../../snapshot/research/runner/standard58_core.json). The larger boxes are solver-backed. |
| Fixed-radius phase menus | [Five menus at $K=59$](../../snapshot/research/runner/direct_rule_search.log), [extended cases at $K=59,91,\ldots,95$](../../snapshot/research/runner/direct_rule_frontier.log). The tested radius is $64/(64K+1)$. Eligibility is fixed by each row's smooth speed, phase and runner-count constraints. |
| Search diagnostics | [Upstream baseline](../../snapshot/research/runner/baseline_1007.log), [cyclic chain](../../snapshot/research/runner/chain_search.log), [peak repair](../../snapshot/research/runner/repair_peaks.log), [stopped upstream SAT job](../../snapshot/research/runner/local_59_sat.log). The best recorded chain excess was approximately $-0.666671$. The [Farey quotient tests](../../snapshot/research/runner/farey_scout.log), [additional Farey trials](../../snapshot/research/runner/farey_remainders.log) and phase-box projections are exploratory restrictions and results are scoped to the tested inputs. |
| Exact prior-art replay | [Replay manifest](../../snapshot/package1/results/slr_upstream_replay_manifest.json) pins the upstream verifier and records 40 exact covers, with a full exact maximum replay for the 57-runner seed. The seed is available as [rational data](../../snapshot/package1/results/known_slr_57.json). |

## Attribution and source check

- The shifted problem goes back to Beck, Hoşten and Schymura. Blanco, Criado and Santos establish counterexamples through 17 in Theorem 1.8. Their arXiv version 4 was current on 26 November 2026. [Lonely Runner Polyhedra](https://arxiv.org/abs/1606.01783v4) · [Coloopless zonotopes and counterexamples](https://arxiv.org/abs/2603.24784v4)
- Poliakova's version 1 was current. It proves $E_n\ge\lfloor n/287\rfloor$ and $E_n\ge1$ from $n=95$. Its Definition 5 and Theorem 6 supply the local rule framework, and Theorem 7 and Table 1 supply the three replacement rules. Table 1 lists $1/224$ as the largest coefficient for one listed rule. [More (shifted) runners, less loneliness](https://arxiv.org/html/2609.23952v1)
- Zhang's version 3 asks the global inequality for every $n\ge5$ and asks for minimizers in Question 8.5. The related finite-checking and short-relation papers address different classes of constraints. [Tight instances of the Lonely Runner Conjecture](https://arxiv.org/html/2608.13599v3#S8) · [Linearly-exponential checking](https://arxiv.org/abs/2411.06903v2) · [Lonely Runner Relations](https://arxiv.org/abs/2609.06259v3)
- The public repository credits `aadrianvv` for 18–54 and `tomdif` for 55–57. The issue's later comments supersede its original range. Merged PR 755 verifies the published 18–57 certificates and their exact maxima in Lean. MathLab's formal extension and perturbation address a different theorem. [Issue 110](https://github.com/1337isnot1337/solved-conjectures/issues/110) · [Upstream formalization at the checked checkout](https://github.com/1337isnot1337/solved-conjectures/blob/60e47a0419d97deb104e72eb23692232430ce35f/results/shifted-lonely-runner-counterexamples/FORMALIZATION.md)
- A targeted literature and upstream search found no earlier statement of the compatible packing bounds or the fixed-seed optimum and weighted obstruction. The priority comparison covers the sources above. General rational interval and difference-constraint techniques precede these specific applications.

The revised compatible-replacement paper uses [sixteen recipes and a strict checker](compatible-replay). The [independent audit and repair](compatible-audit/response.md) explain the handling of changed shared speeds. The frozen-extension paper has a separate [weighted obstruction reproduction](../../certificates/fixed-57).
