-- Adapted from solved-conjectures, revision 60e47a0. See LICENSE-cover.
module

public import Mathlib.Tactic.Linarith
public import Mathlib.Algebra.Order.Archimedean.Real.Basic

@[expose] public section

namespace MathLab

abbrev Track := Nat × Nat

/-- The previous right endpoint in scaled time is the signed ratio left/den.
For arc (i,k) the two endpoints are (k*q-a-r)/v and (k*q-a+r)/v. -/
def cover (tracks : List Track) (q r : ℕ) (left : ℤ) (den : ℕ) :
    List (ℕ × ℕ) → Bool
  | [] => decide ((q : ℤ) * den ≤ left)
  | (i, k) :: tail =>
    match tracks[i]? with
    | none => false
    | some (v, a) =>
      let center := (k : ℤ) * q - a
      decide (0 < v ∧ (center - r) * den ≤ left * v) &&
        cover tracks q r (center + r) v tail

theorem cover_sound {tracks : List Track} {q r : ℕ} {chain : List (ℕ × ℕ)}
    {left : ℤ} {den : ℕ} (hc : cover tracks q r left den chain = true)
    (hd : 0 < den) {u : ℝ} (hl : (left : ℝ) ≤ u * den) (hu : u < q) :
    ∃ p ∈ tracks, ∃ k : ℕ, |(p.2 : ℝ) + p.1 * u - k * (q : ℝ)| ≤ r := by
  induction chain generalizing left den with
  | nil =>
    have h := of_decide_eq_true hc
    have hq : (q : ℝ) * den ≤ left := by exact_mod_cast h
    exact False.elim ((not_lt_of_ge (hq.trans hl))
      (mul_lt_mul_of_pos_right hu (by exact_mod_cast hd)))
  | cons e tail ih =>
    obtain ⟨i, k⟩ := e
    cases hget : tracks[i]? with
    | none => simp [cover, hget] at hc
    | some p =>
      obtain ⟨v, a⟩ := p
      simp only [cover, hget, Bool.and_eq_true, decide_eq_true_eq] at hc
      obtain ⟨⟨hv, hstart⟩, htail⟩ := hc
      have hs : ((k : ℝ) * q - a - r) * den ≤ (left : ℝ) * v := by exact_mod_cast hstart
      have hd' : (0 : ℝ) < den := by exact_mod_cast hd
      have hv' : (0 : ℝ) < v := by exact_mod_cast hv
      by_cases hstop : (v : ℝ) * u ≤ (k : ℝ) * q - a + r
      · refine ⟨(v, a), List.mem_of_getElem? hget, k, abs_le.mpr ⟨?_, ?_⟩⟩
        · have hstart' : (k : ℝ) * q - a - r ≤ v * u := by
            apply le_of_mul_le_mul_right _ hd'
            calc
              _ ≤ (left : ℝ) * v := hs
              _ ≤ (u * den) * v := mul_le_mul_of_nonneg_right hl hv'.le
              _ = _ := by ring
          dsimp
          linarith
        · dsimp
          linarith
      · apply ih htail hv
        push_cast
        linarith

end MathLab
