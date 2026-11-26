module

public import Mathlib.Tactic.Linarith
public import Mathlib.Algebra.Order.Archimedean.Real.Basic

@[expose] public section

namespace AffineCircleTracks

variable {I : Type*}

/-- At one time in `[0,1]`, every indexed track and the extra track
are at distance at least `d` from every integer. -/
def ObstructedAt (v a : I → ℝ) (d : ℝ) (w : ℕ) (s : ℝ) : Prop :=
  ∃ t : ℝ, 0 ≤ t ∧ t ≤ 1 ∧
    (∀ (i : I) (k : ℤ), d ≤ |v i * t + a i - (k : ℝ)|) ∧
    (∀ k : ℤ, d ≤ |(w : ℝ) * t + s - (k : ℝ)|)

/-- The witness time may depend on the positive speed `w` and the phase `s`. -/
def Obstructed (v a : I → ℝ) (d : ℝ) : Prop :=
  ∀ w : ℕ, 0 < w → ∀ s : ℝ, ObstructedAt v a d w s

/-- The shifts differ by at most `ε` modulo integers, with a winding
integer chosen separately for each track. -/
def ShiftsWithin (a b : I → ℝ) (ε : ℝ) : Prop :=
  ∀ i : I, ∃ n : ℤ, |a i - b i - (n : ℝ)| ≤ ε

theorem ShiftsWithin.symm {a b : I → ℝ} {ε : ℝ}
    (hab : ShiftsWithin a b ε) : ShiftsWithin b a ε := by
  intro i
  obtain ⟨n, hn⟩ := hab i
  refine ⟨-n, ?_⟩
  have heq : b i - a i - ((-n : ℤ) : ℝ) = -(a i - b i - (n : ℝ)) := by
    rw [Int.cast_neg]
    linarith
  rw [heq, abs_neg]
  exact hn

/-- Stability for a fixed extra track. -/
theorem obstructedAt_shift_lipschitz {v a b : I → ℝ} {d ε s : ℝ} {w : ℕ}
    (hε : 0 ≤ ε) (hab : ShiftsWithin a b ε)
    (h : ObstructedAt v a d w s) : ObstructedAt v b (d - ε) w s := by
  obtain ⟨t, ht0, ht1, htracks, hextra⟩ := h
  refine ⟨t, ht0, ht1, ?_, ?_⟩
  · intro i k
    obtain ⟨n, hn⟩ := hab i
    -- Compare integer `k` for the new track with `k + n` for the old one.
    have hold := htracks i (k + n)
    have heq :
        v i * t + a i - ((k + n : ℤ) : ℝ) =
          (v i * t + b i - (k : ℝ)) + (a i - b i - (n : ℝ)) := by
      rw [Int.cast_add]
      linarith
    rw [heq] at hold
    have htri := abs_add_le (v i * t + b i - (k : ℝ))
      (a i - b i - (n : ℝ))
    linarith only [hold, htri, hn]
  · intro k
    linarith only [hextra k, hε]

/-- Uniform stability over every positive extra speed and every real phase. -/
theorem obstructed_shift_lipschitz {v a b : I → ℝ} {d ε : ℝ}
    (hε : 0 ≤ ε) (hab : ShiftsWithin a b ε)
    (h : Obstructed v a d) : Obstructed v b (d - ε) := by
  intro w hw s
  exact obstructedAt_shift_lipschitz hε hab (h w hw s)

end AffineCircleTracks
