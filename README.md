# MathLab

Research on the zeros of set-partition polynomials and the shifted lonely runner problem by Chengyi Fang, with AI-generated derivations, software, formal proofs and manuscripts.

| Paper | Mathematical question |
|---|---|
| [Zeros of threshold-four set-partition polynomials](papers/partitions/partitions.pdf) | How do all the roots move between rows, including at the two extreme scales? |
| [Compatible replacements](papers/runners/compatible-replacements.pdf) | How many runners can be saved by overlapping local rules at compatible integer scales? |
| [One-runner extension and phase stability](papers/runners/frozen-extension.pdf) | What is the best possible 58th runner when a particular published 57-runner seed is fixed? |
| [A sharp phase neighbourhood for consecutive lonely runners](papers/phases/phases.pdf) | How does loneliness vary with small shifts of the starting positions at prime modulus? |

The articles include the natural-language proofs. The [downloadable dyadic interval certificate](certificates/partitions) contains all 501,501 roots of the finite partition rows with an independent sign-and-order verifier. The [Lean project](formal) gives the formal statements, pinned dependencies, build instructions and verification scope. Mathematical exchanges, unsuccessful routes and evidence used during discovery are in [the source archive](snapshot). The [independent AI referee reports](editorial/referees) record the inputs that each reviewer actually saw. Each report should be read with the corresponding author response and reproduction evidence.

Use [the partition instructions](papers/partitions/reproduction/README.md), [the runner instructions](papers/runners/README.md) and [the phase verifier](papers/phases/README.md) to reproduce the calculations independently. The exact root computations and the unrestricted optimization over one additional runner answer different mathematical questions from an all-row proof and an unconstrained 58-runner counterexample. The accompanying papers specify the quantifiers.

**Contributions.** Chengyi Fang is an undergraduate outside mathematics who initiated the project, funded the reasoning calls, set the goals, supervised the research process and arranged dissemination. OpenAI GPT-6.2-Astra and Codex carried out the main mathematical work, code, formalization, review and writing. Publication subagents used GPT-6.2-Sol at maximum reasoning effort. The human contributor understands aspects of the research but has not independently checked any part of the proofs. No external human peer review is claimed. Prior results, including Poliakova's local rules and the upstream shifted-runner certificates, are credited to their contributors in the articles.

[中文研究说明](研究成果说明.md) · [Citation metadata](CITATION.cff) · [Research cost ledger](editorial/costs.json) · [Licensing](RIGHTS.md)
