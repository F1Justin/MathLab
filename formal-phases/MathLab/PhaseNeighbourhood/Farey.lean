module

public import MathLab.PhaseNeighbourhood.Core
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

@[expose] public section

namespace MathLab.PhaseNeighbourhood

private theorem refine_interval (N fuel : ℕ) (x : ℝ) {P q R h : ℕ}
    (hq : 0 < q) (hh : 0 < h) (hqN : q ≤ N) (hhN : h ≤ N)
    (hdet : q * R = h * P + 1) (hleft : (P : ℝ) / q ≤ x)
    (hright : x ≤ (R : ℝ) / h) (hfuel : N + 1 ≤ q + h + fuel) :
    ∃ P q R h : ℕ, 0 < q ∧ 0 < h ∧ q ≤ N ∧ h ≤ N ∧ q * R = h * P + 1 ∧
      N < q + h ∧ (P : ℝ) / q ≤ x ∧ x ≤ (R : ℝ) / h := by
  induction fuel generalizing P q R h with
  | zero => exact ⟨P, q, R, h, hq, hh, hqN, hhN, hdet, by omega, hleft, hright⟩
  | succ fuel ih =>
      by_cases hstop : N < q + h
      · exact ⟨P, q, R, h, hq, hh, hqN, hhN, hdet, hstop, hleft, hright⟩
      · by_cases hm : x ≤ ((P + R : ℕ) : ℝ) / (q + h : ℕ)
        · exact ih (R := P+R) (h := q+h) hq (by omega) hqN (by omega)
            (by nlinarith only [hdet]) hleft hm (by omega)
        · exact ih (P := P+R) (q := q+h) (by omega) hh (by omega) hhN
            (by nlinarith only [hdet]) (le_of_not_ge hm) hright (by omega)

/-- Mediant refinement finds two enclosing fractions of bounded denominator
with determinant one and a sum of denominators above the prescribed order. -/
theorem farey_tile {N : ℕ} (hN : 1 ≤ N) {x : ℝ} (hx₀ : 0 ≤ x) (hx₁ : x ≤ 1) :
    ∃ P q R h : ℕ, 0 < q ∧ 0 < h ∧ q ≤ N ∧ h ≤ N ∧ q * R = h * P + 1 ∧
      N < q + h ∧ (P : ℝ) / q ≤ x ∧ x ≤ (R : ℝ) / h := by
  exact refine_interval N N x (P := 0) (q := 1) (R := 1) (h := 1)
    (by decide) (by decide) hN hN (by decide)
    (by simpa using hx₀) (by simpa using hx₁) (by omega)

theorem smallDenominator_shape {p : ℕ} (hp : 7 ≤ p) (hodd : Odd p) :
    p = 2 * smallDenominator p + 1 ∨ p = 2 * smallDenominator p + 3 := by
  obtain ⟨a, ha⟩ := hodd
  unfold smallDenominator
  omega

theorem smallDenominator_odd (p : ℕ) : Odd (smallDenominator p) :=
  ⟨(p - 3) / 4, by simp [smallDenominator, two_mul]⟩

theorem smallDenominator_ge_three {p : ℕ} (hp : 7 ≤ p) : 3 ≤ smallDenominator p := by
  unfold smallDenominator
  omega

theorem exceptional_farey_denominator {p P q R h : ℕ}
    (hp : 7 ≤ p) (hodd : Odd p) (hdet : q * R = h * P + 1 ∨ h * P = q * R + 1)
    (hgap : q + h = p + 1) (hqh : q ≤ h) : q ≤ smallDenominator p := by
  have hne : q ≠ h := by
    intro he
    rw [← he] at hdet
    have hd : q ∣ 1 := by
      rcases hdet with hdet | hdet
      · have hdiv : q ∣ q * R - q * P := Nat.dvd_sub (dvd_mul_right q R) (dvd_mul_right q P)
        rwa [show q * R - q * P = 1 by omega] at hdiv
      · have hdiv : q ∣ q * P - q * R := Nat.dvd_sub (dvd_mul_right q P) (dvd_mul_right q R)
        rwa [show q * P - q * R = 1 by omega] at hdiv
    have h1 := Nat.dvd_one.mp hd
    rcases hdet with hdet | hdet <;> omega
  obtain hp' | hp' := smallDenominator_shape hp hodd
  · omega
  · by_contra! hbad
    obtain ⟨k, hk⟩ := smallDenominator_odd p
    have hqe : q % 2 = 0 := by omega
    have hhe : h % 2 = 0 := by omega
    have hqprod : (q * R) % 2 = 0 := by rw [Nat.mul_mod, hqe]; simp
    have hhprod : (h * P) % 2 = 0 := by rw [Nat.mul_mod, hhe]; simp
    omega

theorem sharpRadius_pos {p : ℕ} (hp : 7 ≤ p) : 0 < sharpRadius p := by
  have hq := smallDenominator_ge_three hp
  unfold sharpRadius
  positivity

theorem four_mul_sharpRadius_le {p : ℕ} (hp : 7 ≤ p) :
    4 * sharpRadius p ≤ 1 / (p : ℝ) := by
  have hq : (3 : ℝ) ≤ (smallDenominator p : ℝ) := by exact_mod_cast smallDenominator_ge_three hp
  have hp' : (7 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
  have hd : 0 < (p : ℝ) := by linarith
  have hden : 0 < 2 * (smallDenominator p : ℝ) * ((p : ℝ) + 1) := by positivity
  rw [sharpRadius, mul_one_div]
  apply (div_le_div_iff₀ hden hd).mpr
  nlinarith [mul_nonneg (sub_nonneg.mpr hq) (show 0 ≤ (p : ℝ) by positivity)]

theorem sharpRadius_le_far {p : ℕ} (hp : 7 ≤ p) (hodd : Odd p) :
    1 / ((p : ℝ) + 2) + sharpRadius p ≤ 1 / (p : ℝ) := by
  have hq : (3 : ℝ) ≤ (smallDenominator p : ℝ) := by exact_mod_cast smallDenominator_ge_three hp
  have hp' : (7 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
  have hb : (p : ℝ) - 3 ≤ 2 * (smallDenominator p : ℝ) := by
    have hn : p ≤ 2 * smallDenominator p + 3 := (smallDenominator_shape hp hodd).elim
      (by omega) (by omega)
    have : (p : ℝ) ≤ 2 * (smallDenominator p : ℝ) + 3 := by exact_mod_cast hn
    linarith
  have hpr : 0 < (p : ℝ) := by linarith
  have hp2 : 0 < (p : ℝ) + 2 := by linarith
  have hden : 0 < 2 * (smallDenominator p : ℝ) * ((p : ℝ) + 1) := by positivity
  have hsplit : 1 / (p : ℝ) - 1 / ((p : ℝ) + 2) = 2 / ((p : ℝ) * ((p : ℝ) + 2)) := by
    field_simp
    ring
  rw [add_comm, ← le_sub_iff_add_le, hsplit, sharpRadius]
  apply (div_le_div_iff₀ hden (mul_pos hpr hp2)).mpr
  nlinarith [mul_nonneg (sub_nonneg.mpr hb) (show 0 ≤ (p : ℝ) + 1 by positivity),
    sq_nonneg ((p : ℝ) - 7)]

theorem sharpRadius_eq_exceptional {p : ℕ} (hp : 7 ≤ p) :
    1 / ((p : ℝ) + 1) + 2 * (smallDenominator p : ℝ) * sharpRadius p / (p : ℝ) =
      1 / (p : ℝ) := by
  have hq : 0 < (smallDenominator p : ℝ) := by
    exact_mod_cast (show 0 < smallDenominator p from lt_of_lt_of_le (by decide) (smallDenominator_ge_three hp))
  have hp' : 0 < (p : ℝ) := by exact_mod_cast (show 0 < p by omega)
  unfold sharpRadius
  field_simp

end MathLab.PhaseNeighbourhood
