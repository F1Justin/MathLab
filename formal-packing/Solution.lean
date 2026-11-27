module

public import Mathlib.Algebra.Order.Archimedean.Real.Basic
import MathLab.Scale476
import Mathlib.Tactic.Ring

/-! Convert the locally certified affine phases to a common rational denominator. -/

namespace MathLab.Packing476

public theorem exists_cover :
    ∃ runners : List (ℕ × ℤ),
      runners.length = 476 ∧
      (runners.map Prod.fst).Nodup ∧
      (∀ runner ∈ runners, 0 < runner.1) ∧
      ∀ t : ℝ, ∃ runner ∈ runners, ∃ k : ℤ,
        |(runner.1 : ℝ) * t + (runner.2 : ℝ) / 1924 - (k : ℝ)| ≤ 1 / 481 := by
  obtain ⟨size, distinct, positive, cover⟩ := ScaleRule.certificate476
  let toRunner (e : ScaleRule.Entry) : ℕ × ℤ := (e.1, 481 * e.2.1 + e.2.2)
  refine ⟨(ScaleRule.tracks 480).map toRunner, ?_, ?_, ?_, ?_⟩
  · simpa only [List.length_map] using size
  · have speed_eq : Prod.fst ∘ toRunner = Prod.fst := by
      funext entry
      rfl
    simpa only [List.map_map, speed_eq] using distinct
  · intro runner mem
    obtain ⟨entry, entry_mem, rfl⟩ := List.mem_map.mp mem
    exact positive entry entry_mem
  · intro t
    obtain ⟨entry, entry_mem, k, bound⟩ := cover t
    refine ⟨toRunner entry, List.mem_map.mpr ⟨entry, entry_mem, rfl⟩, k, ?_⟩
    have phase_eq : ((toRunner entry).2 : ℝ) / 1924 = ScaleRule.phase entry (1 / 481) := by
      simp only [toRunner, ScaleRule.phase, Int.cast_add, Int.cast_mul, Int.cast_ofNat]
      ring
    simpa only [phase_eq] using bound

end MathLab.Packing476
