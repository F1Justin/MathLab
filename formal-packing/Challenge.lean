module

public import Mathlib.Algebra.Order.Archimedean.Real.Basic

/-!
An explicit-size cover for shifted lonely runners on a circle of circumference one.
A pair stores a positive integer speed and the numerator of an initial phase
with common denominator 1924. Distance to the observer is distance to an integer.
-/

namespace MathLab.Packing476

/-- There are 476 distinct positive integer speeds with rational initial phases
such that at every real time at least one runner is within 1/481 of the origin. -/
public theorem exists_cover :
    ∃ runners : List (ℕ × ℤ),
      runners.length = 476 ∧
      (runners.map Prod.fst).Nodup ∧
      (∀ runner ∈ runners, 0 < runner.1) ∧
      ∀ t : ℝ, ∃ runner ∈ runners, ∃ k : ℤ,
        |(runner.1 : ℝ) * t + (runner.2 : ℝ) / 1924 - (k : ℝ)| ≤ 1 / 481 := by
  sorry

end MathLab.Packing476
