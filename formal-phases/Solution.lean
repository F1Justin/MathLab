module

public import MathLab

public section

namespace MathLab.PhaseNeighbourhood

/-- The exact closed-cube formula and its sharpness. -/
theorem sharp_phase_neighbourhood {p : ℕ} (hp : 7 ≤ p) (hpr : p.Prime) :
    (∀ u : ℕ → ℝ, (∀ j ∈ speeds p, |u j| ≤ sharpRadius p) →
      loneliness (one_lt_of_seven_le hp) u = 1/(p : ℝ) + maxForm (one_lt_of_seven_le hp) u) ∧
    (∀ R : ℝ, sharpRadius p < R → ∃ u : ℕ → ℝ, (∀ j ∈ speeds p, |u j| ≤ R) ∧
      1/(p : ℝ) + maxForm (one_lt_of_seven_le hp) u < loneliness (one_lt_of_seven_le hp) u) :=
  ⟨fun u hu => sharp_cube_formula hp hpr u hu, fun _ hR => sharp_cube_maximal hp hpr hR⟩

/-- The lower bound on the wider closed tube. -/
theorem odd_order_phase_neighbourhood {p : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    (ho : Odd (twoOrderModuloSign p)) (u : ℕ → ℝ)
    (hr : phaseRadius (one_lt_of_seven_le hp) u ≤ tubeRadius p) :
    1/(p : ℝ) ≤ loneliness (one_lt_of_seven_le hp) u :=
  odd_order_phase_tube hp hpr ho u hr

end MathLab.PhaseNeighbourhood
