module

public import MathLab.Cover
public import MathLab.FrozenData
public import Mathlib.Tactic.NormNum
public import Mathlib.Tactic.FieldSimp

@[expose] public section

namespace MathLab.Frozen

set_option maxRecDepth 10000

/-- The phase of a seed track is stored as a numerator with denominator S. -/
noncomputable def position (p : Nat × Nat) (t : ℝ) : ℝ :=
  (p.1 : ℝ) * t + p.2 / (S : ℝ)

noncomputable def radius : ℝ := 1359451 / 79000000

private theorem chain_valid : cover (seed ++ [extra]) S smallR 0 1 chain = true := by
  decide +kernel

theorem frozen_upper (t : ℝ) (ht : 0 ≤ t) (ht' : t ≤ 1) :
    ∃ p ∈ seed ++ [extra], ∃ k : ℤ, |position p t - k| ≤ radius := by
  have hS : (0 : ℝ) < S := by norm_num [S]
  have hR : radius * (S : ℝ) = smallR := by norm_num [radius, S, smallR]
  rcases lt_or_eq_of_le ht' with lt | rfl
  · obtain ⟨p, hp, k, hk⟩ := cover_sound chain_valid (by decide)
        (u := t * S) (by simpa using mul_nonneg ht hS.le)
        (by simpa using mul_lt_mul_of_pos_right lt hS)
    refine ⟨p, hp, k, ?_⟩
    have he : (position p t - k) * (S : ℝ) =
        p.2 + p.1 * (t * S) - k * (S : ℝ) := by
      unfold position
      field_simp [hS.ne']
      ring
    apply le_of_mul_le_mul_right _ hS
    push_cast
    calc
      _ = |(position p t - k) * (S : ℝ)| := by rw [abs_mul, abs_of_pos hS]
      _ ≤ smallR := by rwa [he]
      _ = _ := hR.symm
  · refine ⟨(1,0), List.mem_append_left _ (by decide), 1, ?_⟩
    norm_num [position, radius]

theorem extra_parameters :
    extra.1 = 528344 ∧ (extra.2 : ℝ) / S = 4737613 / 31600000 := by
  norm_num [extra, S]

end MathLab.Frozen
