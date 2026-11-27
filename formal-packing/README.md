# A 476-runner shifted cover at radius 1/481

There are 476 distinct positive integer speeds and rational initial phases on a
circle of circumference one such that at every time, some runner is at distance
at most $1/481$ from the stationary observer. The usual comparison radius is
$1/477$, since the observer is an additional runner. In the companion paper's
notation this proves $E_{476}\ge 4$ by exhibiting one configuration.
[Statement](Challenge.lean) · [Proof](Solution.lean)

Start with the 480 even speeds $2,4,\ldots,960$ at phase zero. At each real time
a Dirichlet bound supplies a covering track. A covering index of least size
has a primitive integer numerator, since dividing a common divisor would
produce a smaller covering index. Installation retains the zero phase outside
the affected speeds. For each affected speed, a literal table covers the full
local interval at both possible odd residues modulo four. The proof transfers
this coverage to the least-index track and hence to every real time. Eleven
even speeds are removed, seventeen rephased, and seven odd speeds added. The
finite speed counts and distinctness are checked with kernel reduction. The
Solution converts the installed affine phases to a common denominator of
$1924=4\cdot481$.
[Local transfer](MathLab/LocalTransfer.lean) · [Replacement table](MathLab/ScaleCells.lean) · [Global cover](MathLab/Scale476.lean)

Daria Poliakova's Theorem 7 and the 24-to-21 row of her Table 1 supply the
two base rules for this instance. The recipe combines the first rule,
its reflected fivefold dilation, and the half-turn translate of the second
rule. The 27 November 2026 manuscript *Compatible local replacements for
shifted lonely runners* chooses a phase at each shared speed, then checks the
resulting local covers. Its global counting theorem and limiting bound are
separate from the concrete cover proved here. [Poliakova's preprint](https://arxiv.org/abs/2609.23952v1)

## Replay

The manifest pins Mathlib to `56a005855ea17e0b0958f73ec801ae140b0a1679` and the
toolchain selects Lean 4.35.0. With elan and a Linux host with bubblewrap and
user namespaces, run from this directory.

~~~sh
lake exe cache get Mathlib.NumberTheory.DiophantineApproximation.Basic Mathlib.Data.Int.GCD Mathlib.Data.Nat.Find Mathlib.Tactic.Linarith Mathlib.Tactic.FieldSimp Mathlib.Tactic.NormNum Mathlib.Tactic.Positivity Mathlib.Tactic.Ring
lake build Challenge Solution
lake env lean scripts/AuditAxioms.lean
lake env leanchecker --verbose Solution
lake comparator
~~~

Challenge imports only the pinned Mathlib and supplies the statement Comparator
checks. Its one proof placeholder is intentional. The Solution uses
`propext`, `Classical.choice`, and `Quot.sound`. The proof modules are included
under the MIT licence. [Configuration](comparator.json) · [Provenance](formalization.yaml) · [Licence](LICENSE) · [Registry requirements](https://github.com/PalomarRegistry/PalomarPolicy/blob/main/CONTRIBUTING.md)
