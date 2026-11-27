module

public import MathLab.PhaseNeighbourhood.Definitions
public import Mathlib.Data.Int.GCD
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

@[expose] public section

namespace MathLab.PhaseNeighbourhood

theorem circleDist_le_abs_sub (x : ℝ) (m : ℤ) : circleDist x ≤ |x - (m : ℝ)| :=
  round_le x m

theorem circleDist_le_half (x : ℝ) : circleDist x ≤ 1 / 2 := abs_sub_round x

theorem circleDist_eq_abs {x : ℝ} (hx : |x| < 1 / 2) : circleDist x = |x| := by
  obtain ⟨hl, hu⟩ := abs_lt.mp hx
  have hround : round x = 0 :=
    round_eq_zero_iff.mpr ⟨hl.le, hu⟩
  simp [circleDist, hround]

@[simp] theorem circleDist_add_int (x : ℝ) (m : ℤ) :
    circleDist (x + (m : ℝ)) = circleDist x := by
  rw [circleDist, circleDist, round_add_intCast, Int.cast_add]
  congr 1
  ring

@[simp] theorem circleDist_neg (x : ℝ) : circleDist (-x) = circleDist x := by
  have bound (y : ℝ) : circleDist (-y) ≤ circleDist y := by
    calc
      circleDist (-y) ≤ |-y - ((-round y : ℤ) : ℝ)| := circleDist_le_abs_sub _ _
      _ = circleDist y := by rw [Int.cast_neg, neg_sub_neg, abs_sub_comm, circleDist]
  exact le_antisymm (bound x) (by simpa only [neg_neg] using bound (-x))

theorem circleDist_le_add_abs (x v : ℝ) : circleDist x ≤ circleDist (x + v) + |v| := by
  have h := circleDist_le_abs_sub x (round (x + v))
  calc
    circleDist x ≤ |x - (round (x + v) : ℝ)| := h
    _ = |(x + v - (round (x + v) : ℝ)) + (-v)| := by congr 1; ring
    _ ≤ circleDist (x + v) + |v| := by
      simpa [circleDist] using (abs_add_le (x + v - (round (x + v) : ℝ)) (-v))

theorem circleDist_div_congr {D : ℕ} (hD : 0 < D) {m n : ℤ}
    (hc : m ≡ n [ZMOD (D : ℤ)]) (v : ℝ) :
    circleDist ((m : ℝ) / D + v) = circleDist ((n : ℝ) / D + v) := by
  obtain ⟨z, hz⟩ := Int.modEq_iff_add_fac.mp hc.symm
  have hd : (D : ℝ) ≠ 0 := by exact_mod_cast hD.ne'
  have h : (m : ℝ) / D + v = (n : ℝ) / D + v + (z : ℝ) := by
    rw [hz]
    push_cast
    field_simp
    ring
  rw [h, circleDist_add_int]

theorem circleDist_at_residue {D j : ℕ} {k s : ℤ} (hD : 0 < D)
    (hc : (j : ℤ) * k ≡ s [ZMOD (D : ℤ)]) (v : ℝ) :
    circleDist ((j : ℝ) * ((k : ℝ) / D) + v) =
      circleDist ((s : ℝ) / D + v) := by
  simpa only [Int.cast_mul, Int.cast_natCast, mul_div_assoc] using
    circleDist_div_congr hD hc v

theorem residue_of_circleDist_lt {D : ℕ} (hD : 0 < D) {m L : ℤ}
    (hc : circleDist ((m : ℝ) / D) < (L : ℝ) / D) :
    ∃ s : ℤ, |s| < L ∧ m ≡ s [ZMOD (D : ℤ)] := by
  let z := round ((m : ℝ) / D)
  refine ⟨m - (D : ℤ) * z, ?_, ?_⟩
  · have hd : 0 < (D : ℝ) := by exact_mod_cast hD
    have he : (↑(m - (D : ℤ) * z) : ℝ) =
        ((m : ℝ) / D - (z : ℝ)) * D := by
      push_cast
      field_simp
    have hc' : |(↑(m - (D : ℤ) * z) : ℝ)| < (L : ℝ) := by
      rw [he, abs_mul, abs_of_pos hd]
      exact (lt_div_iff₀ hd).mp hc
    exact_mod_cast hc'
  · rw [Int.modEq_iff_dvd]
    exact ⟨-z, by ring⟩

theorem inverse_mod_of_coprime {a D : ℕ} (hc : a.Coprime D) :
    ∃ k : ℤ, (a : ℤ) * k ≡ 1 [ZMOD (D : ℤ)] := by
  refine ⟨Nat.gcdA a D, ?_⟩
  rw [Int.modEq_iff_add_fac]
  refine ⟨Nat.gcdB a D, ?_⟩
  simpa [Nat.Coprime.gcd_eq_one hc] using Nat.gcd_eq_gcd_ab (x := a) (y := D)

theorem strip_inverse {D a j : ℕ} {k s : ℤ}
    (hk : (a : ℤ) * k ≡ 1 [ZMOD (D : ℤ)])
    (hj : (j : ℤ) * k ≡ s [ZMOD (D : ℤ)]) :
    (j : ℤ) ≡ (a : ℤ) * s [ZMOD (D : ℤ)] := by
  have h1 : (j : ℤ) * ((a : ℤ) * k) ≡ j [ZMOD (D : ℤ)] := by
    simpa using hk.mul_left (j : ℤ)
  have h2 : (j : ℤ) * ((a : ℤ) * k) ≡ (a : ℤ) * s [ZMOD (D : ℤ)] := by
    convert hj.mul_left (a : ℤ) using 1
    ring
  exact h1.symm.trans h2

theorem congr_nat_unique {D i j : ℕ} (hi : i < D) (hj : j < D)
    (h : (i : ℤ) ≡ (j : ℤ) [ZMOD (D : ℤ)]) : i = j := by
  have h' : i ≡ j [MOD D] := Int.natCast_modEq_iff.mp h
  simpa [Nat.ModEq, Nat.mod_eq_of_lt hi, Nat.mod_eq_of_lt hj] using h'

theorem complement_mod {D a : ℕ} (ha : a ≤ D) :
    ((D - a : ℕ) : ℤ) ≡ -(a : ℤ) [ZMOD (D : ℤ)] := by
  rw [Nat.cast_sub ha, Int.modEq_iff_dvd]
  exact ⟨-1, by ring⟩

theorem complement_inverse {D a : ℕ} {k : ℤ} (ha : a ≤ D)
    (hk : (a : ℤ) * k ≡ 1 [ZMOD (D : ℤ)]) :
    ((D-a : ℕ) : ℤ) * k ≡ -1 [ZMOD (D : ℤ)] := by
  have h := (complement_mod ha).mul_right k
  rw [neg_mul] at h
  exact h.trans hk.neg

/-- Off the two inverse residues the nominal distance is at least two units. -/
theorem other_runner_nominal {D a j : ℕ} {k : ℤ} (ha : a < D) (hj : j < D)
    (hj0 : 0 < j) (hja : j ≠ a) (hjb : j ≠ D - a)
    (ha0 : 0 < a) (hk : (a : ℤ) * k ≡ 1 [ZMOD (D : ℤ)]) :
    2 / (D : ℝ) ≤ circleDist ((j : ℝ) * ((k : ℝ) / D)) := by
  by_contra! h
  rw [← mul_div_assoc, ← Int.cast_natCast (R := ℝ) j, ← Int.cast_mul] at h
  obtain ⟨s, hs, hmod⟩ := residue_of_circleDist_lt
    (D := D) (m := (j : ℤ) * k) (L := 2) (by omega) (by simpa only [Int.cast_ofNat] using h)
  have hjmod := strip_inverse hk hmod
  have hs' : s = -1 ∨ s = 0 ∨ s = 1 := by
    obtain ⟨hl, hu⟩ := abs_lt.mp hs
    omega
  rcases hs' with hs' | hs' | hs'
  · rw [hs', mul_neg_one] at hjmod
    exact hjb (congr_nat_unique hj (by omega) (hjmod.trans (complement_mod ha.le).symm))
  · rw [hs', mul_zero] at hjmod
    exact hj0.ne' (congr_nat_unique hj (by omega) hjmod)
  · rw [hs', mul_one] at hjmod
    exact hja (congr_nat_unique hj ha hjmod)

theorem gap_le_runner {p j : ℕ} (hp : 1 < p) (u : ℕ → ℝ) (t : ℝ)
    (hj : j ∈ speeds p) : gap hp u t ≤ circleDist ((j : ℝ) * t + u j) :=
  Finset.inf'_le (fun j : ℕ => circleDist ((j : ℝ) * t + u j)) hj

theorem le_gap {p : ℕ} (hp : 1 < p) {u : ℕ → ℝ} {t w : ℝ}
    (h : ∀ j ∈ speeds p, w ≤ circleDist ((j : ℝ) * t + u j)) :
    w ≤ gap hp u t :=
  (Finset.le_inf'_iff (speeds_nonempty hp) _).mpr h

theorem gap_le_loneliness {p : ℕ} (hp : 1 < p) (u : ℕ → ℝ) (t : ℝ) :
    gap hp u t ≤ loneliness hp u := by
  unfold loneliness
  apply le_csSup ?_ (Set.mem_range_self t)
  refine ⟨1 / 2, ?_⟩
  rintro _ ⟨v, rfl⟩
  exact (gap_le_runner hp u v (show 1 ∈ speeds p from Finset.mem_Ioo.mpr ⟨by decide, hp⟩)).trans
    (circleDist_le_half _)

theorem loneliness_le {p : ℕ} (hp : 1 < p) {u : ℕ → ℝ} {c : ℝ}
    (h : ∀ t, gap hp u t ≤ c) : loneliness hp u ≤ c := by
  unfold loneliness
  apply csSup_le (Set.range_nonempty _)
  rintro _ ⟨t, rfl⟩
  exact h t

end MathLab.PhaseNeighbourhood
