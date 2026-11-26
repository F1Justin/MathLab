# Runner verification record

The two runner manuscripts were checked against the frozen MathLab sources dated 26 November 2026. Proof deductions and solver verdicts use their stated speed, phase, and radius hypotheses.

## Arithmetic and formal scope

- The construction starts with the smallest covering seed speed. The primitive residue check uses the half-speed in the coprimality test. The two overlapping bundles are combined after checking agreement of their affine phases and counting deletion conflicts exactly. Every applied speed belongs to exactly one prime-to-30 core.
- The saving profile counts reached gain units, with multiplicity at 1944 and 9720. The periodic integer check gives period 17496000 and discrepancy maximum 4335269. The expanded construction adds all admissible powers of nine in each layer, giving saved fraction $513079/69984000$ and excess coefficient $513079/69470921$.
- The frozen optimum is checked directly at the published rational radius, without rerunning the candidate search. The exact enumeration reproduces 11 positive gaps, speed bound 820800, one surviving speed and one closed phase interval. The independently checked strict-residual enumeration includes 12 components and has an empty weak-cover hit list. A direct rational witness at the isolated component proves sharpness.
- The weighted obstruction was replayed by two methods with the supplied 207 nonnegative integer weights, of which 121 are positive, and the same exact finite and analytic tail bounds. The seven-addition conclusion holds with repeated speeds, relative to the specified seed.
- The phase-box suites use the exact nominal phases stored in the certificates. Both larger integer SMT verdicts were reproduced as UNSAT. The smaller standard box was independently reproduced by the 203-endpoint real encoding. These are solver verdicts on the stated encodings, with the mathematical reduction proved in the paper. The seven fixed menu verdicts at the 58-runner target are at the declared smaller rational radius and apply to their inputs only.
- The Lean files verify the frozen exact radius, the attaining configuration, the local perturbation bound, and the stated integer discrepancy and counting consequences. The unique optimal speed, all its phases, the weighted obstruction, the affine-rule exclusion and the larger SMT cases are checked by their respective replays.

## Astra review

The separate model review was submitted once using the shared project ledger. It completed with \$0.939344 in recorded usage. The review independently analyzed the local rule, periodic counting, all-speed limitation, residue measure, insertion search and integer difference-constraint deductions. Its report did not execute the verifiers or browse the cited sources. [Referee report](../../../editorial/referees/runner/report.md) · [Accounting](../../../editorial/referees/runner/usage.json)

Changes after review include direct verification at the proposed rational optimum, explicit assertions for the empty strict-residual hit list and for the two seed speed equalities, source-rule distinctness and gain checks, exact nominal input phases for SMT replication, and explicit scope for all computed verdicts. The frozen sources were left intact. The reproducible data and code are linked from the manuscripts. [Replay logs](replay) · [Runner bibliography and inventory](../README.md)
