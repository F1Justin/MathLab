module

public import MathLab.PhaseNeighbourhood.Cube
import Mathlib.Data.Nat.GCD.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

public section

namespace MathLab.PhaseNeighbourhood

theorem pairForm_complement {p a : ℕ} (ha : a ≤ p) (u : ℕ → ℝ) :
    pairForm p u (p-a) = -pairForm p u a := by
  unfold pairForm
  rw [show p-(p-a) = a by omega]
  ring

private theorem coprime_smallDenominator {p : ℕ} (hp : 7 ≤ p) (hpodd : Odd p) :
    (smallDenominator p).Coprime (p+1) := by
  have h2 := Nat.coprime_two_right.mpr (smallDenominator_odd p)
  have h4 : (smallDenominator p).Coprime 4 := by
    simpa using (h2.pow_right 2)
  rcases smallDenominator_shape hp hpodd with h | h
  · rw [show p+1=2+2*smallDenominator p by omega,
      Nat.coprime_add_mul_right_right]
    exact h2
  · rw [show p+1=4+2*smallDenominator p by omega,
      Nat.coprime_add_mul_right_right]
    exact h4

/-- Every larger centred cube contains phases violating the local formula.
The construction has a strictly higher peak than that formula predicts. -/
theorem sharp_cube_maximal {p : ℕ} (hp : 7 ≤ p) (hprime : p.Prime) {R : ℝ}
    (hR : sharpRadius p < R) :
    ∃ v : ℕ → ℝ, (∀ j ∈ speeds p, |v j| ≤ R) ∧
      1/(p : ℝ) + maxForm (show 1 < p by omega) v <
        loneliness (show 1 < p by omega) v := by
  have hp1 : 1 < p := by omega
  have hp7 : (7 : ℝ) ≤ p := by exact_mod_cast hp
  have hp' : 0 < (p : ℝ) := by linarith
  have hodd := hprime.odd_of_ne_two (by omega)
  let q := smallDenominator p
  let D := p+1
  let h := D-q
  let b := p-q
  let c := p-h
  have hq3 : 3 ≤ q := smallDenominator_ge_three hp
  have hqR : (3 : ℝ) ≤ q := by exact_mod_cast hq3
  have hq0 : 0 < q := by omega
  have hshape : p = 2*q+1 ∨ p = 2*q+3 := smallDenominator_shape hp hodd
  have hqP : q < p := by omega
  have hord : 0 < c ∧ c < q ∧ q < b ∧ b < h ∧ h < p := by
    dsimp [D,h,b,c]
    omega
  have hqD : q < D := by dsimp [D]; omega
  have hpD : p < D := by dsimp [D]; omega
  have hD : 0 < D := by omega
  have hDR : (D : ℝ) = (p : ℝ)+1 := by simp [D]
  have hDRpos : 0 < (D : ℝ) := by exact_mod_cast hD
  have hhR : 0 < (h : ℝ) := by exact_mod_cast (show 0 < h by omega)
  have hqRpos : 0 < (q : ℝ) := by exact_mod_cast hq0
  let r := min R (1 / (2 * (D : ℝ)))
  have hrBound : r ≤ 1 / (2 * (D : ℝ)) := min_le_right _ _
  have hcap : sharpRadius p < 1 / (2 * (D : ℝ)) := by
    rw [sharpRadius, ← hDR]
    apply one_div_lt_one_div_of_lt (by positivity)
    change 2*(D : ℝ) < 2*(q : ℝ)*(D : ℝ)
    nlinarith only [mul_pos (show 0 < (q : ℝ)-1 by linarith) hDRpos]
  have hrLower : sharpRadius p < r := lt_min hR hcap
  have hr : 0 ≤ r := (lt_trans (sharpRadius_pos hp) hrLower).le
  let v (j : ℕ) : ℝ :=
    if j=q ∨ j=b then r else if j=h then -r else
      if j=c then -(c : ℝ)/(h : ℝ)*r else 0
  have hVq : v q = r := by simp [v]
  have hVb : v b = r := by simp [v]
  have hVh : v h = -r := by simp [v, show h ≠ q by omega, show h ≠ b by omega]
  have hVc : v c = -(c : ℝ)/(h : ℝ)*r := by
    simp [v, show c ≠ q by omega, show c ≠ b by omega, show c ≠ h by omega]
  have hcH : (c : ℝ)/(h : ℝ) ≤ 1 := by
    apply (div_le_iff₀ hhR).mpr
    simpa using (show (c : ℝ) ≤ (h : ℝ) by exact_mod_cast (show c ≤ h by omega))
  have hvBound (j : ℕ) : |v j| ≤ r := by
    classical
    by_cases hqb : j=q ∨ j=b
    · simp [v,hqb,abs_of_nonneg hr]
    by_cases hjh : j=h
    · rw [hjh, hVh, abs_neg, abs_of_nonneg hr]
    by_cases hjc : j=c
    · rw [hjc, hVc, neg_div, neg_mul, abs_neg, abs_of_nonneg (by positivity)]
      simpa using mul_le_mul_of_nonneg_right hcH hr
    simpa [v,hqb,hjh,hjc] using hr
  refine ⟨v, fun j _ => (hvBound j).trans (min_le_left _ _), ?_⟩
  let m : ℝ := ((b : ℝ)-q)*r/(p : ℝ)
  have hm : 0 ≤ m := by
    have hbq : (q : ℝ) ≤ (b : ℝ) := by exact_mod_cast (show q ≤ b by omega)
    dsimp [m]
    positivity
  have eqQ : pairForm p v q = m := by
    change ((b : ℝ)*v q-(q : ℝ)*v b)/(p : ℝ) = m
    rw [hVq,hVb]
    dsimp [m]
    ring
  have eqB : pairForm p v b = -m := by
    change pairForm p v (p-q) = -m
    rw [pairForm_complement hqP.le,eqQ]
  have eqH : pairForm p v h = 0 := by
    change ((c : ℝ)*v h-(h : ℝ)*v c)/(p : ℝ) = 0
    rw [hVh,hVc]
    field_simp
    ring
  have eqC : pairForm p v c = 0 := by
    change pairForm p v (p-h) = 0
    rw [pairForm_complement (show h ≤ p by omega),eqH,neg_zero]
  have hmMax : maxForm hp1 v ≤ m := by
    apply Finset.sup'_le _ _
    intro j hj
    by_cases hJq : j=q
    · rw [hJq,eqQ,abs_of_nonneg hm]
    by_cases hJb : j=b
    · rw [hJb,eqB,abs_neg,abs_of_nonneg hm]
    by_cases hJh : j=h
    · rw [hJh,eqH,abs_zero]; exact hm
    by_cases hJc : j=c
    · rw [hJc,eqC,abs_zero]; exact hm
    have hJ := (Finset.mem_Ioo.mp hj).2
    have hvJ : v j = 0 := by simp [v,hJq,hJb,hJh,hJc]
    have hvC : v (p-j) = 0 := by
      simp [v, show p-j ≠ q by dsimp [b] at hJb; omega,
        show p-j ≠ b by dsimp [b]; omega,
        show p-j ≠ h by dsimp [c] at hJc; omega,
        show p-j ≠ c by dsimp [c]; omega]
    simp [pairForm,hvJ,hvC,hm]
  obtain ⟨k,hqk⟩ := inverse_mod_of_coprime (coprime_smallDenominator hp hodd)
  have hhk : (h : ℤ)*k ≡ -1 [ZMOD (D : ℤ)] := complement_inverse hqD.le hqk
  let t : ℝ := (k : ℝ)/(D : ℝ)
  let s : ℝ := 1 / (D : ℝ) + r
  have hlinear : |s| < 1/2 := by
    have hsd : 0 ≤ s := by dsimp [s]; positivity
    rw [abs_of_nonneg hsd]
    have hd : (8 : ℝ) ≤ D := by linarith [hDR]
    have h1 : 1/(D : ℝ) ≤ 1/8 := one_div_le_one_div_of_le (by norm_num) hd
    have hcap' : 2*r ≤ 1/(D : ℝ) := by
      have he : 1/(2*(D : ℝ))=(1/(D : ℝ))/2 := by field_simp
      linarith only [hrBound,he]
    dsimp [s]
    linarith only [h1,hcap']
  have hs0 : 0 ≤ s := by dsimp [s]; positivity
  have hw : s ≤ gap hp1 v t := by
    apply le_gap hp1
    intro j hj
    have hj' := Finset.mem_Ioo.mp hj
    by_cases hjq : j=q
    · subst j
      rw [hVq,circleDist_at_residue hD hqk r,Int.cast_one,
        circleDist_eq_abs hlinear,abs_of_nonneg hs0]
    by_cases hjh : j=h
    · subst j
      rw [hVh,circleDist_at_residue hD hhk (-r),Int.cast_neg,Int.cast_one]
      rw [show (-1 : ℝ)/(D : ℝ)+(-r) = -s by dsimp [s]; ring,
        circleDist_neg,circleDist_eq_abs hlinear,abs_of_nonneg hs0]
    have hnom := other_runner_nominal hqD (lt_trans hj'.2 hpD) hj'.1 hjq hjh hq0 hqk
    have h1 := circleDist_le_add_abs ((j : ℝ)*t) (v j)
    have hcap' : (2:ℝ)*r ≤ 1/(D : ℝ) := by
      have he : 1/(2*(D : ℝ))=(1/(D : ℝ))/2 := by field_simp
      linarith only [hrBound,he]
    have hn : 2*(1/(D : ℝ)) ≤ circleDist ((j : ℝ)*t) := by
      simpa only [mul_one_div, mul_one] using hnom
    dsimp only [s]
    linarith only [hn, h1, hvBound j, hcap']
  have hstrict : 1/(p : ℝ)+m < s := by
    have hmain : 2*(q : ℝ)*sharpRadius p/(p : ℝ) < 2*(q : ℝ)*r/(p : ℝ) :=
      div_lt_div_of_pos_right (mul_lt_mul_of_pos_left hrLower (by positivity)) hp'
    have he : m = r - 2*(q : ℝ)*r/(p : ℝ) := by
      dsimp only [m,b]
      rw [Nat.cast_sub hqP.le]
      field_simp
      ring
    have hcut : 1 / (D : ℝ) + 2*(q : ℝ)*sharpRadius p/(p : ℝ) = 1/(p : ℝ) := by
      rw [hDR]
      exact sharpRadius_eq_exceptional hp
    dsimp only [s]
    linarith only [hcut, hmain, he]
  have hSum : 1/(p : ℝ)+maxForm hp1 v ≤ 1/(p : ℝ)+m := by linarith only [hmMax]
  exact hSum.trans_lt (hstrict.trans_le (hw.trans (gap_le_loneliness hp1 v t)))

end MathLab.PhaseNeighbourhood
