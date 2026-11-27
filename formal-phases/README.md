# A sharp phase neighbourhood for consecutive lonely runners

For prime `p ≥ 7`, set the speeds to `1, …, p − 1`. At a given time, the
nearest runner's distance to the integers is the instantaneous gap.
Loneliness is the largest such gap over a full turn.

- `MathLab.PhaseNeighbourhood.sharp_phase_neighbourhood` gives the exact
  loneliness on the closed cube of radius `1 / (2 Q (p + 1))` about zero
  phases, with `Q` the largest odd integer below `(p + 1)/2`. The value is
  `1/p` plus the maximum absolute complementary-pair phase functional.
  Every larger centred cube contains a phase vector whose loneliness
  strictly exceeds this formula.
- `MathLab.PhaseNeighbourhood.odd_order_phase_neighbourhood` gives the
  lower bound `1/p` on the wider closed tube of radius
  `2(p + 1) / (p (3p − 1))` around the common-start orbit when the order
  of two modulo sign is odd. The tube distance minimizes the maximum
  circular coordinate displacement over a shared time shift.

The inputs are arbitrary real phases. `Geometry.lean` verifies attainment of
both time extrema on `[0, 1]` and equality of the all-index and half-index
complementary-pair maxima. `Tube.lean` proves that the odd-order condition is
equivalent to the existence of an odd positive `n` with `2^n ≡ ±1 (mod p)`.
The tube radius is a sufficient bound. The sharp threshold for a strict
improvement over `1/p` and global phase minimizers are separate questions.

`Challenge.lean` contains the two target statements and the definitions
needed to read them, using only Mathlib imports. Its two `sorry` terms mark
the Comparator targets. The default build checks `MathLab.lean` and
`Solution.lean`, with complete proofs for both statements. The implementation
proves the Farey interval property by finite mediant refinement. The cube
proof combines the original complementary peaks with a bound for the first
competing Farey intervals and an explicit strict witness beyond the boundary.
The tube proof excludes strict improvements by forcing signs to alternate
under doubling, which contradicts an odd closed orbit.

With Lean 4.35.0 and the pinned Mathlib, run from this directory:

```sh
lake build
lake env lean scripts/AuditAxioms.lean
lake env leanchecker -v MathLab Solution
lake comparator
```

The axiom audit includes private declarations and permits only `propext`,
`Quot.sound` and `Classical.choice`. The Comparator setup runs Lean's default
kernel and the independent NanoDa kernel on the same verified statements.

The companion paper was first released with MathLab v1.0.0. The earlier
upstream discussion identified the tight Farey points and the opposite
orientations of complementary runners. The linked prior reports describe
that mechanism and the local sign obstruction. The sharp radius, exact
function and odd-order tube are the MathLab theorems formalized here.
[Original manuscript](https://github.com/F1Justin/MathLab/blob/ef98c0707e3a9e1b6b66f905aadd24ea6e38cadc/papers/phases/phases.pdf) ·
[Farey tight points](https://github.com/1337isnot1337/solved-conjectures/issues/110#issuecomment-7049825074) ·
[Opposite orientations](https://github.com/1337isnot1337/solved-conjectures/issues/110#issuecomment-7051219544).
