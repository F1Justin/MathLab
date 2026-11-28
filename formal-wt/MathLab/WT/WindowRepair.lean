module
public import MathLab.WT.ContinuousRepair
public import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Centered signed windows, the second-order error of convolution with a
wide smooth bump, and the resulting positivity of the repaired autocorrelation. -/

@[expose] public section
namespace MathLab.WT

open MeasureTheory Set Filter
noncomputable section

/-- A uniform second derivative bound yields a quadratic first-order remainder.
The constant one is sufficient for the subsequent wide-bump estimate. -/
theorem quadratic_remainder {g : ℝ → ℝ} (hg : Differentiable ℝ g)
    (hg' : Differentiable ℝ (deriv g)) {B : ℝ} (hB : 0 ≤ B)
    (hbound : ∀ x, ‖deriv (deriv g) x‖ ≤ B) (x y : ℝ) :
    |g (x - y) - g x + y * deriv g x| ≤ B * y ^ 2 := by
  let F (z : ℝ) := g z - g x - (z - x) * deriv g x
  have hF (z : ℝ) : HasDerivAt F (deriv g z - deriv g x) z := by
    simpa [F, Pi.sub_def] using (((hg z).hasDerivAt.sub_const (g x)).sub
      (((hasDerivAt_id z).sub_const x).mul_const (deriv g x)))
  have lip (z : ℝ) : ‖deriv g z - deriv g x‖ ≤ B * ‖z - x‖ :=
    Convex.norm_image_sub_le_of_norm_deriv_le (fun z _ => hg' z)
      (fun z _ => hbound z) (convex_univ : Convex ℝ (univ : Set ℝ)) (mem_univ x) (mem_univ z)
  let J := Icc (x - |y|) (x + |y|)
  have hx : x ∈ J := ⟨by linarith [abs_nonneg y], by linarith [abs_nonneg y]⟩
  have hxy : x - y ∈ J := ⟨by linarith [le_abs_self y], by linarith [neg_le_abs y]⟩
  have hb (z : ℝ) (hz : z ∈ J) : ‖deriv F z‖ ≤ B * |y| := by
    rw [(hF z).deriv]
    apply (lip z).trans (mul_le_mul_of_nonneg_left ?_ hB)
    rw [Real.norm_eq_abs, abs_le]
    exact ⟨by linarith [hz.1], by linarith [hz.2]⟩
  have h := Convex.norm_image_sub_le_of_norm_deriv_le (fun z _ => (hF z).differentiableAt)
    hb (convex_Icc _ _) hx hxy
  have hs : |y| * |y| = y ^ 2 := by rw [← pow_two, sq_abs]
  simpa [F, Real.norm_eq_abs, sub_eq_add_neg, mul_assoc, hs, pow_two] using h

private theorem integrable_compact_mul {f g : ℝ → ℝ} (hf : Continuous f)
    (hc : HasCompactSupport f) (hg : Continuous g) : Integrable (fun x => f x * g x) :=
  (hf.mul hg).integrable_of_hasCompactSupport hc.mul_right

theorem moment_one_even {f : ℝ → ℝ} (he : ∀ y, f (-y) = f y) :
    (∫ y, f y * y) = 0 := by
  have h := MeasureTheory.integral_neg_eq_self (fun y : ℝ => f y * y) volume
  simp only [he, mul_neg, integral_neg] at h
  linarith

/-- The kernel may change sign. Its unit mass and evenness remove the constant
and linear Taylor terms; the remaining error is controlled by its absolute
second moment. -/
theorem convolution_second_moment {f g : ℝ → ℝ} (hf : Continuous f) (hc : HasCompactSupport f)
    (hmass : ∫ y, f y = 1) (he : ∀ y, f (-y) = f y) (hg : Differentiable ℝ g)
    (hg' : Differentiable ℝ (deriv g)) {B : ℝ} (hB : 0 ≤ B)
    (hbound : ∀ x, ‖deriv (deriv g) x‖ ≤ B) (x : ℝ) :
    |conv f g x - g x| ≤ B * ∫ y, |f y| * y ^ 2 := by
  let r (y : ℝ) := g (x - y) - g x + y * deriv g x
  have hrc : Continuous r := (hg.continuous.comp (continuous_const.sub continuous_id)).sub
    continuous_const |>.add (continuous_id.mul continuous_const)
  have hir := integrable_compact_mul hf hc hrc
  have hfg : Integrable (fun y => f y * g (x - y)) :=
    integrable_compact_mul hf hc (hg.continuous.comp (continuous_const.sub continuous_id))
  have hfi : Integrable f := hf.integrable_of_hasCompactSupport hc
  have hfy : Integrable (fun y => f y * y) := integrable_compact_mul hf hc continuous_id
  have hcancel : (∫ y, f y * r y) = conv f g x - g x := by
    calc
      _ = ∫ y, (f y * g (x - y) - f y * g x) + (f y * y) * deriv g x := by
        apply integral_congr_ae (Eventually.of_forall ?_)
        intro y; dsimp [r]; ring
      _ = _ := by
        have split := integral_add (hfg.sub (hfi.mul_const (g x))) (hfy.mul_const (deriv g x))
        simp only [Pi.sub_def] at split
        rw [split, integral_sub hfg (hfi.mul_const _), integral_mul_const, integral_mul_const,
          hmass, moment_one_even he]
        simp [conv]
  have habs : HasCompactSupport (fun y => |f y|) := by simpa [Real.norm_eq_abs] using hc.norm
  have hmoment : Integrable (fun y => |f y| * y ^ 2) :=
    integrable_compact_mul hf.abs habs (continuous_id.pow 2)
  calc
    _ = |∫ y, f y * r y| := by rw [hcancel]
    _ ≤ ∫ y, |f y * r y| := abs_integral_le_integral_abs
    _ ≤ ∫ y, (|f y| * y ^ 2) * B := by
      apply integral_mono hir.abs (hmoment.mul_const B)
      intro y
      change |f y * r y| ≤ |f y| * y ^ 2 * B
      rw [abs_mul]
      calc
        _ ≤ |f y| * (B * y ^ 2) := mul_le_mul_of_nonneg_left
          (quadratic_remainder hg hg' hB hbound x y) (abs_nonneg _)
        _ = _ := by ring
    _ = _ := by rw [integral_mul_const, mul_comm]

theorem conv_zero_outside {f g : ℝ → ℝ} {R S : ℝ}
    (hf : ∀ y, R < |y| → f y = 0) (hg : ∀ y, S < |y| → g y = 0)
    {x : ℝ} (hx : R + S < |x|) : conv f g x = 0 := by
  apply integral_eq_zero_of_ae
  apply Eventually.of_forall
  intro y
  by_cases hy : R < |y|
  · simp [hf y hy]
  · have htri : |x| ≤ |y| + |x - y| := by simpa using abs_add_le y (x - y)
    have hshift : S < |x - y| := by linarith [le_of_not_gt hy]
    simp [hg _ hshift]

/-- Expanding an actual real convolution, with the two cross terms identified
by commutativity. -/
theorem conv_mixture_self {f g : ℝ → ℝ} (hf : Continuous f) (hc : HasCompactSupport f)
    (hg : Continuous g) (hcg : HasCompactSupport g) (a b x : ℝ) :
    conv (fun y => a * f y + b * g y) (fun y => a * f y + b * g y) x =
      a ^ 2 * conv f f x + 2 * a * b * conv f g x + b ^ 2 * conv g g x := by
  have hf' : Continuous (fun y => f (x-y)) := hf.comp (continuous_const.sub continuous_id)
  have hg' : Continuous (fun y => g (x-y)) := hg.comp (continuous_const.sub continuous_id)
  have ff := (integrable_compact_mul hf hc hf').const_mul (a ^ 2)
  have fg := (integrable_compact_mul hf hc hg').const_mul (a * b)
  have gf := (integrable_compact_mul hg hcg hf').const_mul (a * b)
  have gg := (integrable_compact_mul hg hcg hg').const_mul (b ^ 2)
  calc
    _ = ∫ y, a ^ 2 * (f y * f (x-y)) + (a*b) * (f y * g (x-y)) +
        (a*b) * (g y * f (x-y)) + b ^ 2 * (g y * g (x-y)) := by
      apply integral_congr_ae (Eventually.of_forall ?_)
      intro y; ring
    _ = a ^ 2 * conv f f x + (a*b) * conv f g x +
        (a*b) * conv g f x + b ^ 2 * conv g g x := by
      have split₁ := integral_add ((ff.add fg).add gf) gg
      have split₂ := integral_add (ff.add fg) gf
      simp only [Pi.add_def] at split₁ split₂
      rw [split₁, split₂, integral_add ff fg]
      simp only [conv, integral_const_mul]
    _ = _ := by rw [conv_comm g f x]; ring

/-- The negative autocorrelation and cross-convolution errors of the signed
truncation are absorbed by the wide bump on the whole region where they can
contribute. Outside that region, only the nonnegative bump term survives. -/
theorem wide_bump_nonnegative {f g : ℝ → ℝ} (hf : Continuous f) (hc : HasCompactSupport f)
    (hg : Continuous g) (hcg : HasCompactSupport g) (hgpos : ∀ y, 0 ≤ g y)
    {R S ε δ c a b : ℝ} (hRS : R ≤ S) (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hfs : ∀ y, R < |y| → f y = 0) (hgs : ∀ y, S < |y| → g y = 0)
    (hff : ∀ x, -ε ≤ conv f f x) (hfg : ∀ x, -δ ≤ conv f g x)
    (hgg : ∀ x, |x| ≤ R + S → c ≤ conv g g x)
    (hmargin : a ^ 2 * ε + 2 * a * b * δ ≤ b ^ 2 * c) (x : ℝ) :
    0 ≤ conv (fun y => a * f y + b * g y) (fun y => a * f y + b * g y) x := by
  rw [conv_mixture_self hf hc hg hcg]
  by_cases h : |x| ≤ R + S
  · have h₁ := mul_le_mul_of_nonneg_left (hff x) (sq_nonneg a)
    have h₂ := mul_le_mul_of_nonneg_left (hfg x) (show 0 ≤ 2 * a * b by positivity)
    have h₃ := mul_le_mul_of_nonneg_left (hgg x h) (sq_nonneg b)
    linarith only [h₁, h₂, h₃, hmargin]
  · have hff0 := conv_zero_outside hfs hfs (show R + R < |x| by linarith [lt_of_not_ge h])
    have hfg0 := conv_zero_outside hfs hgs (lt_of_not_ge h)
    rw [hff0, hfg0]
    have hgg0 : 0 ≤ conv g g x := integral_nonneg (fun y => mul_nonneg (hgpos y) (hgpos _))
    simpa using mul_nonneg (sq_nonneg b) hgg0

end
end MathLab.WT
