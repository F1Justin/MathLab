module

public import Mathlib.Algebra.Order.Archimedean.Real.Basic
public import Mathlib.Order.Interval.Set.Basic

@[expose] public section

/-!
# One-runner extension of a fixed shifted configuration

For position `v * t + s` on a circle of circumference one, being at distance at
most `d` from zero is the existence of an integer `k` with
`|v * t + s - k| ≤ d`. The original 57 speeds and phases are fixed to the data below.
The optimization ranges over one additional positive integer speed distinct from
the original speeds and over an arbitrary real phase.

The exact optimal radius is `1359451 / 79000000`, larger than the
58-runner shifted target `1 / 59`. The fourth statement gives an explicit
displacement tolerance for the fixed original speeds.
-/

namespace MathLab.Frozen

/-- Common denominator of the 57 published phase numerators in `seed`. -/
def S : Nat := 158000000

/-- Each pair is a positive integer speed and a phase numerator in units of `1 / S`.
This is the published 57-runner configuration credited upstream to tomdif. -/
def seed : List (Nat × Nat) := [
  (1, 0),
  (44, 83082878),
  (45, 65035170),
  (22, 87824616),
  (90, 57579624),
  (66, 57232972),
  (30, 128058368),
  (20, 2074540),
  (10, 104073652),
  (16, 83931338),
  (8, 67646120),
  (24, 146273872),
  (144, 26750348),
  (96, 77732208),
  (3, 72843214),
  (40, 153312614),
  (5, 91002154),
  (60, 116731506),
  (48, 151928376),
  (54, 156597592),
  (192, 147307982),
  (216, 22888196),
  (72, 4004352),
  (7, 52267190),
  (68, 52762046),
  (2, 74768602),
  (36, 42789086),
  (120, 154813140),
  (21, 83239456),
  (9, 142184674),
  (15, 101968776),
  (168, 97667542),
  (32, 149420916),
  (84, 80018468),
  (33, 84077488),
  (42, 44029702),
  (12, 42290596),
  (6, 82795792),
  (75, 20795170),
  (26, 124575100),
  (4, 85130400),
  (39, 115860768),
  (18, 8253288),
  (52, 52655238),
  (28, 19415672),
  (50, 62680970),
  (132, 75905254),
  (34, 108560220),
  (64, 35474634),
  (108, 15304828),
  (80, 87963814),
  (27, 74315616),
  (114, 47496854),
  (128, 63920006),
  (51, 48399982),
  (59, 46193512),
  (14, 2064586)
]

/-- The real lift of the position of a track at time `t`, in turns. -/
noncomputable def position (p : Nat × Nat) (t : ℝ) : ℝ :=
  (p.1 : ℝ) * t + p.2 / (S : ℝ)

/-- The audited configuration has 57 distinct positive integer speeds. -/
theorem seed_parameters :
    seed.length = 57 ∧ (seed.map Prod.fst).Nodup ∧ ∀ p ∈ seed, 0 < p.1 := by
  sorry

/-- The radii attainable by adjoining one track of distinct positive integer speed and
arbitrary real phase to the fixed configuration are exactly those at least
`1359451 / 79000000`. The coverage condition quantifies over all real times. -/
theorem optimum_on_circle (d : ℝ) :
    (∃ v : ℕ, 0 < v ∧ v ∉ seed.map Prod.fst ∧ ∃ s : ℝ, ∀ t : ℝ,
      (∃ p ∈ seed, ∃ k : ℤ, |position p t - k| ≤ d) ∨
      ∃ k : ℤ, |(v : ℝ) * t + s - k| ≤ d) ↔ 1359451 / 79000000 ≤ d := by
  sorry

/-- Adding speed `528344` with phase `4737613 / 31600000` attains the optimal radius. -/
theorem attained_by :
    (528344 : ℕ) ∉ seed.map Prod.fst ∧ ∀ t : ℝ,
      (∃ p ∈ seed, ∃ k : ℤ, |position p t - k| ≤ 1359451 / 79000000) ∨
      ∃ k : ℤ, |(528344 : ℝ) * t + 4737613 / 31600000 - k| ≤ 1359451 / 79000000 := by
  sorry

/-- Keep the original speeds and move each original phase at most
`1207609 / 4661000000` turns modulo integers. For every positive integer extra
speed and every real extra phase, there is a time when every track is at
distance at least `1 / 59` from the nearest integer. -/
theorem barrier_under_perturbations (b : {p : Nat × Nat // p ∈ seed} → ℝ)
    (h : ∀ i, ∃ m : ℤ, (|((i.val.2 : ℝ) / S) - b i - m| : ℝ) ≤
      1207609 / 4661000000) :
    ∀ v : ℕ, 0 < v → ∀ s : ℝ, ∃ t ∈ Set.Icc (0 : ℝ) 1,
      (∀ i, ∀ k : ℤ, (1 : ℝ) / 59 ≤ |(i.val.1 : ℝ) * t + b i - k|) ∧
      ∀ k : ℤ, (1 : ℝ) / 59 ≤ |(v : ℝ) * t + s - k| := by
  sorry

end MathLab.Frozen
