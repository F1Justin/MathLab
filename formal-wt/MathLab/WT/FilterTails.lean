module
public import MathLab.WT.ConvolutionBounds
public import MathLab.WT.Compression
import Mathlib.Tactic.Linarith

/-! Bounds independent of table length for the fixed Schwartz filters.
A second absolute moment suffices for clipping an interval whose length is
proportional to the window radius. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Filter Set
open scoped SchwartzMap
noncomputable section

def momentTwo (k : 𝓢(ℝ,ℝ)) := ∫ y, |y|^2 * |k y|

lemma integrable_momentTwo (k : 𝓢(ℝ,ℝ)) : Integrable (fun y : ℝ => |y|^2 * |k y|) := by
  simpa only [Real.norm_eq_abs] using k.integrable_pow_mul volume 2

theorem momentTwo_nonneg (k : 𝓢(ℝ,ℝ)) : 0 ≤ momentTwo k :=
  integral_nonneg fun _ => mul_nonneg (sq_nonneg _) (abs_nonneg _)

theorem filter_deviation (k : 𝓢(ℝ,ℝ)) {t : ℝ → ℝ} (ht : Regular t) {x c B R : ℝ}
    (hR : 0 < R) (hB : 0 ≤ B) (hb : ∀ z, |t z-c| ≤ B)
    (hl : ∀ y, |y| < R → t (x-y) = c) :
    |conv k t x - (∫ y, k y)*c| ≤ B/R^2 * momentTwo k := by
  have h1 := conv_integrand_mem k.integrable ht x
  have he : conv k t x - (∫ y, k y)*c = ∫ y, k y*(t (x-y)-c) := by
    simp_rw [mul_sub, integral_sub h1 (k.integrable.mul_const c), integral_mul_const, conv]
  rw [he]
  calc
    _ ≤ ∫ y, |k y*(t (x-y)-c)| := abs_integral_le_integral_abs
    _ ≤ ∫ y : ℝ, (B/R^2) * (|y|^2*|k y|) := by
      apply integral_mono_of_nonneg (Eventually.of_forall fun _ => abs_nonneg _)
        ((integrable_momentTwo k).const_mul _)
      apply Eventually.of_forall
      intro y
      change |k y * (t (x-y)-c)| ≤ (B/R^2) * (|y|^2 * |k y|)
      rw [abs_mul]
      by_cases hy : |y| < R
      · rw [hl y hy, sub_self, abs_zero, mul_zero]
        positivity
      · have hs := pow_le_pow_left₀ hR.le (le_of_not_gt hy) 2
        have hR2 : 0 < R^2 := by positivity
        have hm : B ≤ B / R^2 * |y|^2 := by
          rw [div_mul_eq_mul_div, le_div_iff₀ hR2]
          exact mul_le_mul_of_nonneg_left hs hB
        calc
          _ ≤ |k y| * (B / R^2 * |y|^2) :=
            mul_le_mul_of_nonneg_left ((hb _).trans hm) (abs_nonneg _)
          _ = _ := by ring
    _ = _ := integral_const_mul _ _

variable {ι : Type*} [Fintype ι]

def filterSum (K : ι → 𝓢(ℝ,ℝ)) (t : ι → ℝ → ℝ) (x : ℝ) := ∑ i, conv (K i) (t i) x

theorem filterSum_bound (K : ι → 𝓢(ℝ,ℝ)) (t : ι → ℝ → ℝ) {B : ℝ}
    (hB : ∀ i x, |t i x| ≤ B) (x : ℝ) :
    |filterSum K t x| ≤ (∑ i, massAbs (K i)) * B := by
  rw [Finset.sum_mul]
  exact (Finset.abs_sum_le_sum_abs _ _).trans
    (Finset.sum_le_sum fun i _ => conv_abs_bound (K i).integrable (hB i) x)

theorem filterSum_regular (K : ι → 𝓢(ℝ,ℝ)) (t : ι → ℝ → ℝ) {B : ℝ}
    (ht : ∀ i, Integrable (t i)) (hB : ∀ i x, |t i x| ≤ B) : Regular (filterSum K t) :=
  ⟨integrable_finsetSum _ (fun i _ => (K i).integrable.integrable_convolution
    (ContinuousLinearMap.mul ℝ ℝ) (ht i)), _, filterSum_bound K t hB⟩

theorem filterSum_deviation (K : ι → 𝓢(ℝ,ℝ)) (t : ι → ℝ → ℝ) (ht : ∀ i, Regular (t i))
    (hm : ∑ i, (∫ y, K i y) = 1) {x c B R : ℝ} (hR : 0 < R) (hB : 0 ≤ B)
    (hb : ∀ i z, |t i z-c| ≤ B) (hl : ∀ i y, |y| < R → t i (x-y)=c) :
    |filterSum K t x-c| ≤ B/R^2 * ∑ i, momentTwo (K i) := by
  have eq : filterSum K t x-c = ∑ i, (conv (K i) (t i) x - (∫ y, K i y)*c) := by
    simp only [Finset.sum_sub_distrib, ← Finset.sum_mul, hm, one_mul, filterSum]
  rw [eq, Finset.mul_sum]
  exact (Finset.abs_sum_le_sum_abs _ _).trans
    (Finset.sum_le_sum fun i _ => filter_deviation (K i) (ht i) hR hB (hb i) (hl i))

/-- Use radius M/8 in each kernel to sample only the input plateau (inside)
or only its zero extension (outside). -/
theorem filterSum_shoulders (K : ι → 𝓢(ℝ,ℝ)) (t : ι → ℝ → ℝ) (ht : ∀ i, Regular (t i))
    (hm : ∑ i, (∫ y, K i y) = 1) {L M a B : ℝ} (hM : 0 < M) (ha : a ≤ M/8)
    (hB : 0 ≤ B) (hb : ∀ i x, |t i x| ≤ B)
    (hi : ∀ i x, |x| < L-a → t i x=1) (ho : ∀ i x, L+a < |x| → t i x=0) :
    (∀ x, |x| ≤ L-M/4 → |filterSum K t x-1| ≤
      (B+1)/(M/8)^2 * ∑ i, momentTwo (K i)) ∧
    ∀ x, L+M/4 < |x| → |filterSum K t x| ≤
      (B+1)/(M/8)^2 * ∑ i, momentTwo (K i) := by
  have hr : 0 < M/8 := by positivity
  have hh : 0 ≤ B+1 := by linarith
  constructor
  · intro x hx
    apply filterSum_deviation K t ht hm hr hh
    · intro i z
      have h := abs_sub_le (t i z) 0 1
      norm_num at h
      linarith [hb i z]
    · intro i y hy
      have h : |x-y| ≤ |x|+|y| := by
        simpa only [sub_eq_add_neg, abs_neg] using abs_add_le x (-y)
      exact hi i _ (by linarith)
  · intro x hx
    simpa only [sub_zero] using filterSum_deviation K t ht hm (x := x) (c := 0) hr hh
      (fun i z => by simpa only [sub_zero] using (hb i z).trans (by linarith : B ≤ B+1))
      (fun i y hy => by
        have h : |x| ≤ |x-y|+|y| := by
          simpa only [sub_add_cancel] using abs_add_le (x-y) y
        apply ho i
        linarith)

end
end MathLab.WT
