module
public import Mathlib.Analysis.Real.Sqrt
public import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

@[expose] public section
namespace MathLab.WT

namespace AveragedTest

noncomputable section

open MeasureTheory

theorem integral_quartic (a b c₀ c₁ c₂ c₃ c₄ : ℝ) :
    (∫ x in a..b, c₀ + c₁*x + c₂*x^2 + c₃*x^3 + c₄*x^4) =
      c₀*(b-a) + c₁*(b^2-a^2)/2 + c₂*(b^3-a^3)/3 +
      c₃*(b^4-a^4)/4 + c₄*(b^5-a^5)/5 := by
  repeat' rw [intervalIntegral.integral_add (by apply Continuous.intervalIntegrable; fun_prop)
    (by apply Continuous.intervalIntegrable; fun_prop)]
  rw [intervalIntegral.integral_const_mul c₁ (fun x : ℝ => x), integral_id]
  simp only [intervalIntegral.integral_const_mul, integral_pow,
    intervalIntegral.integral_const, smul_eq_mul]
  norm_num
  ring

/-- Density of the continuous part of the trimming law, conditional on a positive trim. -/
def trimDensity (x : ℝ) : ℝ := (7 + 16 * x) / 15

/-- Tail probability of `X` on `[0,1]`. The atom of mass `11/20` is at zero. -/
def trimTail (r : ℝ) : ℝ := 3 * (1 - r) * (8 * r + 15) / 100

/-- Distribution function of the absolute difference of two independent trims on `[0,1]`. -/
def differenceCDF (r : ℝ) : ℝ := (192 * r^4 + 39 * r^2 + 6744 * r + 3025) / 10000

/-- The antiderivative of the difference CDF, zero at the origin. -/
def integratedDifferenceCDF (r : ℝ) : ℝ :=
  ((192/5 : ℝ) * r^5 + 13 * r^3 + 3372 * r^2 + 3025 * r) / 10000

theorem density_mass : (∫ x in (0:ℝ)..1, trimDensity x) = 1 := by
  calc
    _ = (∫ x in (0:ℝ)..1, (7/15) + (16/15)*x + 0*x^2 + 0*x^3 + 0*x^4) := by
      apply intervalIntegral.integral_congr
      intro x _
      unfold trimDensity
      ring
    _ = _ := by rw [integral_quartic]; norm_num

theorem trim_mean : 9/20 * (∫ x in (0:ℝ)..1, x * trimDensity x) = 53/200 := by
  have heq : (∫ x in (0:ℝ)..1, x * trimDensity x) = 53 / 90 := by
    calc
      _ = (∫ x in (0:ℝ)..1, 0 + (7/15)*x + (16/15)*x^2 + 0*x^3 + 0*x^4) := by
        apply intervalIntegral.integral_congr
        intro x _
        unfold trimDensity
        ring
      _ = _ := by rw [integral_quartic]; norm_num
  rw [heq]
  norm_num

theorem trim_tail_integral (r : ℝ) : 9/20 * (∫ x in r..1, trimDensity x) = trimTail r := by
  have e : (∫ x in r..1, trimDensity x) =
      (∫ x in r..1, 7/15 + 16/15*x + 0*x^2 + 0*x^3 + 0*x^4) := by
    apply intervalIntegral.integral_congr
    intro x _
    unfold trimDensity
    ring
  rw [e, integral_quartic]
  unfold trimTail
  ring

/-- The two continuous draws contribute a convolution; exactly one positive draw
contributes the separate `2pqg` term in the distance density. -/
theorem difference_density (r : ℝ) :
    2 * (11/20) * (9/20) * trimDensity r + 2 * (9/20)^2 *
        (∫ y in (0:ℝ)..(1-r), trimDensity y * trimDensity (y+r)) =
      (768*r^3 + 78*r + 6744)/10000 := by
  have e : (∫ y in (0:ℝ)..(1-r), trimDensity y * trimDensity (y+r)) =
    (∫ y in (0:ℝ)..(1-r), (49+112*r)/225 + ((224+256*r)/225)*y +
        256/225*y^2 + 0*y^3 + 0*y^4) := by
    apply intervalIntegral.integral_congr
    intro x _
    unfold trimDensity
    ring
  rw [e, integral_quartic]
  unfold trimDensity
  ring

theorem difference_cdf_integral (r : ℝ) :
    (11/20)^2 + (∫ y in (0:ℝ)..r, (768*y^3 + 78*y + 6744)/10000) = differenceCDF r := by
  have e : (∫ y in (0:ℝ)..r, (768*y^3 + 78*y + 6744)/10000) =
    (∫ y in (0:ℝ)..r, 6744/10000 + 78/10000*y + 0*y^2 + 768/10000*y^3 + 0*y^4) := by
    apply intervalIntegral.integral_congr
    intro x _
    ring
  rw [e, integral_quartic]
  unfold differenceCDF
  ring

theorem integral_difference_cdf (r : ℝ) :
    (∫ x in (0:ℝ)..r, differenceCDF x) = integratedDifferenceCDF r := by
  have e : (∫ x in (0:ℝ)..r, differenceCDF x) =
    (∫ x in (0:ℝ)..r, 3025/10000 + 6744/10000*x + 39/10000*x^2 + 0*x^3 + 192/10000*x^4) := by
    apply intervalIntegral.integral_congr
    intro x _
    unfold differenceCDF
    ring
  rw [e, integral_quartic]
  unfold integratedDifferenceCDF
  ring

theorem mean_difference : (∫ r in (0:ℝ)..1, 1 - differenceCDF r) = 8879/25000 := by
  rw [intervalIntegral.integral_sub (by apply Continuous.intervalIntegrable; fun_prop)
    (by apply Continuous.intervalIntegrable; unfold differenceCDF; fun_prop),
    intervalIntegral.integral_const, integral_difference_cdf]
  norm_num [integratedDifferenceCDF]

/-- Expected maximum of `r` and the distance between the two trims, for `0 ≤ r`. -/
def meanMaximum (r : ℝ) : ℝ :=
  if r ≤ 1 then 8879/25000 + integratedDifferenceCDF r else r

/-- Weight acting on one nonnegative lag in the square-distance dual test. -/
def weight (r : ℝ) : ℝ :=
  14/15 * (meanMaximum r - 2 * (53/200)) +
    2 * (2/3) * (1 + if r ≤ 1 then trimTail r else 0) - 2 * (2/3)^2

theorem weight_polynomial {r : ℝ} (hr : r ≤ 1) :
    weight r = (991418 + r * (4032*r^4 + 1365*r^2 - 5940*r + 2625)) / 1125000 := by
  simp only [weight, meanMaximum, ite_eq_left hr, integratedDifferenceCDF, trimTail]
  ring

theorem weight_after_one {r : ℝ} (hr : 1 < r) :
    weight r = weight 1 + 14/15 * (r-1) := by
  rw [weight_polynomial (r := 1) (by norm_num)]
  simp only [weight, meanMaximum, ite_eq_right (not_le_of_gt hr)]
  ring

/-- Positivity uses the tangent to `x⁴` at `5/8` and a positive quadratic. -/
theorem quartic_pos (r : ℝ) : 0 < 4032*r^4 + 1365*r^2 - 5940*r + 2625 := by
  have ht : 0 ≤ (r - 5/8)^2 * ((r + 5/8)^2 + 2*(5/8)^2) := by positivity
  have hq : 0 ≤ (11648*r - 8544)^2 := sq_nonneg _
  nlinarith only [ht, hq]

theorem weight_ge {r : ℝ} (hr : 0 ≤ r) : 495709/562500 ≤ weight r := by
  by_cases h : r ≤ 1
  · rw [weight_polynomial h]
    nlinarith only [mul_nonneg hr (quartic_pos r).le]
  · have h1 : weight 1 ≥ (495709 / 562500 : ℝ) := by
      rw [weight_polynomial (r := 1) (by norm_num)]
      norm_num
    rw [weight_after_one (lt_of_not_ge h)]
    linarith

theorem objective_bound {a b : ℝ} (h : (495709/562500 : ℝ) ≤ a*b) :
    Real.sqrt 495709 / 375 ≤ 2 * Real.sqrt (a*b) := by
  have hab : 0 ≤ a*b := by linarith
  have hnum := Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 495709)
  have hden := Real.sq_sqrt hab
  have hn := Real.sqrt_nonneg 495709
  have hd := Real.sqrt_nonneg (a*b)
  apply le_of_pow_le_pow_left₀ (by decide : (2 : ℕ) ≠ 0) (by positivity)
  nlinarith only [hnum, hden, h]

end

end AveragedTest

end MathLab.WT
