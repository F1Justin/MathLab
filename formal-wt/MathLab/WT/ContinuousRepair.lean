module
public import MathLab.WT.Basic
public import Mathlib.Analysis.Convolution
public import Mathlib.MeasureTheory.Measure.Haar.Unique
import Mathlib.Tactic.Linarith

/-! Pointwise repair of WT covering on the real line. The correction can
use any integrable measurable mask between zero and one, in particular the
indicator of the two shoulder bands. All conclusions are pointwise. -/

@[expose] public section
namespace MathLab.WT

open MeasureTheory Set Filter

noncomputable section

private abbrev mulMap := ContinuousLinearMap.mul ℝ ℝ

theorem conv_comm (f g : ℝ → ℝ) (x : ℝ) : conv f g x = conv g f x := by
  calc
    _ = ∫ y, f (x - y) * g y := MeasureTheory.convolution_mul_swap
    _ = _ := by apply integral_congr_ae (Eventually.of_forall (fun y => mul_comm _ _))

/-- Absolute integrability of the scalar triple product gives associativity at
every point for a bounded measurable last factor, including a band indicator. -/
theorem conv_assoc_bounded {f g b : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g)
    (hb : Integrable b) (hbm : Measurable b) {B : ℝ} (hB : ∀ x, ‖b x‖ ≤ B) (x : ℝ) :
    conv (conv f g) b x = conv f (conv g b) x := by
  apply MeasureTheory.convolution_assoc' mulMap mulMap mulMap mulMap
    (fun a a' a'' : ℝ => mul_assoc a a' a'')
    (hf.ae_convolution_exists mulMap hg) (hg.ae_convolution_exists mulMap hb)
  have hpair : Integrable (fun p : ℝ × ℝ => f p.2 * g (p.1 - p.2))
      (volume.prod volume) := hf.convolution_integrand mulMap hg
  have hmeas : Measurable (fun p : ℝ × ℝ => b (x - p.1)) := hbm.comp (by fun_prop)
  have h := hpair.mul_bdd hmeas.aestronglyMeasurable
    (Eventually.of_forall fun p : ℝ × ℝ => hB (x - p.1))
  simpa only [Function.uncurry_def, ContinuousLinearMap.mul_apply', mul_assoc] using h

theorem conv_mass {f g : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g) :
    (∫ x, conv f g x) = (∫ x, f x) * (∫ x, g x) :=
  MeasureTheory.integral_convolution mulMap hf hg

private theorem conv_mask_bounds {a b : ℝ → ℝ} (ha : Integrable a) (hpos : ∀ x, 0 ≤ a x)
    (hbm : Measurable b) (hmask : ∀ x, b x ∈ Icc 0 1) (x : ℝ) :
    0 ≤ conv a b x ∧ conv a b x ≤ ∫ y, a y := by
  have hb (y : ℝ) : ‖b (x - y)‖ ≤ 1 := by
    rw [Real.norm_eq_abs, abs_of_nonneg (hmask _).1]; exact (hmask _).2
  have integ := ha.mul_bdd (hbm.comp (measurable_const.sub measurable_id)).aestronglyMeasurable
    (Eventually.of_forall hb)
  constructor
  · exact integral_nonneg fun y => mul_nonneg (hpos y) (hmask _).1
  · apply integral_mono integ ha
    exact fun y => mul_le_of_le_one_right (hpos y) (hmask _).2

private theorem conv_mask_full {a b : ℝ → ℝ} {x : ℝ}
    (hfull : ∀ y ∈ Function.support a, b (x - y) = 1) : conv a b x = ∫ y, a y := by
  apply integral_congr_ae (Eventually.of_forall ?_)
  intro y
  by_cases h : a y = 0
  · simp [h]
  · simp [hfull y h]

/-- Adding `d (rev w ∗ b)` to a table with deficit at most `d` recovers the
covering everywhere on `target`. The increase is between zero and `d` on ℝ.
The mask must equal one on the appropriate translates of the autocorrelation
support at deficient target points. The window and the table may change sign. -/
theorem repair_cover_continuous {w t b : ℝ → ℝ} (hw : Continuous w) (hc : HasCompactSupport w)
    (ht : Integrable t) (hb : Integrable b) (hbm : Measurable b)
    (hmask : ∀ x, b x ∈ Icc 0 1) (hmass : ∫ x, w x = 1)
    (hpos : ∀ x, 0 ≤ conv w (rev w) x) {target : Set ℝ} {d : ℝ} (hd : 0 ≤ d)
    (hdef : ∀ x ∈ target, 1 - conv w t x ≤ d)
    (hfull : ∀ x ∈ target, conv w t x < 1 →
      ∀ y ∈ Function.support (conv w (rev w)), b (x - y) = 1) :
    (∀ x, conv w (fun y => t y + d * conv (rev w) b y) x - conv w t x ∈ Icc 0 d) ∧
      ∀ x ∈ target, 1 ≤ conv w (fun y => t y + d * conv (rev w) b y) x := by
  have hi : Integrable w := hw.integrable_of_hasCompactSupport hc
  have hr : Integrable (rev w) := hi.comp_neg
  have har : Integrable (conv w (rev w)) := hi.integrable_convolution mulMap hr
  have hpatch : Integrable (conv (rev w) b) := hr.integrable_convolution mulMap hb
  have htotal : (∫ y, conv w (rev w) y) = 1 := by
    rw [conv_mass hi hr]
    simp [rev, integral_neg_eq_self, hmass]
  have heq (x : ℝ) : conv w (fun y => t y + d * conv (rev w) b y) x =
      conv w t x + d * conv (conv w (rev w)) b x := by
    have h1 := hc.convolutionExists_left mulMap hw ht.locallyIntegrable x
    have h2 := hc.convolutionExists_left mulMap hw (hpatch.const_mul d).locallyIntegrable x
    have hassoc := conv_assoc_bounded hi hr hb hbm
      (fun y => (show ‖b y‖ ≤ 1 by rw [Real.norm_eq_abs, abs_of_nonneg (hmask y).1]; exact (hmask y).2)) x
    rw [hassoc]
    calc
      _ = conv w t x + conv w (fun y => d * conv (rev w) b y) x := h1.distrib_add h2
      _ = _ := by
        unfold conv
        simp_rw [mul_left_comm (w _ ) d, integral_const_mul]
  have bounds (x : ℝ) := conv_mask_bounds har hpos hbm hmask x
  constructor
  · intro x
    rw [heq, add_sub_cancel_left]
    refine ⟨mul_nonneg hd (bounds x).1, mul_le_of_le_one_right hd ?_⟩
    simpa only [htotal] using (bounds x).2
  · intro x hx
    rw [heq]
    by_cases hold : 1 ≤ conv w t x
    · exact hold.trans (le_add_of_nonneg_right (mul_nonneg hd (bounds x).1))
    · rw [conv_mask_full (hfull x hx (lt_of_not_ge hold)), htotal, mul_one]
      linarith [hdef x hx]

/-- An arbitrary mask of height at most one yields a uniformly bounded table
patch, even when the window changes sign. -/
theorem abs_conv_le_mass_abs {f b : ℝ → ℝ} (hf : Integrable f) (hb : ∀ y, |b y| ≤ 1)
    (x : ℝ) : |conv f b x| ≤ ∫ y, |f y| := by
  calc
    _ ≤ ∫ y, |f y * b (x - y)| := abs_integral_le_integral_abs
    _ ≤ _ := by
      apply integral_mono_of_nonneg (Eventually.of_forall fun _ => abs_nonneg _) hf.abs
      apply Eventually.of_forall
      intro y
      change |f y * b (x-y)| ≤ |f y|
      rw [abs_mul]
      exact mul_le_of_le_one_right (abs_nonneg _) (hb _)

/-- The cost of a local table change is bounded by the measure of its support,
times its pointwise linear and quadratic contributions to the squared norm. -/
theorem energy_local_change {t r : ℝ → ℝ} (ht : Continuous t) (hct : HasCompactSupport t)
    (hr : Continuous r) (hcr : HasCompactSupport r) {S : Set ℝ} (hS : MeasurableSet S)
    (hfinite : volume S ≠ ⊤) (hsupp : Function.support r ⊆ S)
    {T D : ℝ} (hT : 0 ≤ T) (hD : 0 ≤ D) (htb : ∀ x, |t x| ≤ T) (hrb : ∀ x, |r x| ≤ D) :
    energy (fun x => t x + r x) ≤ energy t + volume.real S * (2*T*D + D^2) := by
  have hsq {f : ℝ → ℝ} (h : Continuous f) (h' : HasCompactSupport f) :
      Integrable (fun x => f x ^ 2) := by
    simp only [pow_two]
    exact (h.mul h).integrable_of_hasCompactSupport h'.mul_right
  have hts := hsq ht hct
  have hsum : Integrable (fun x => (t x + r x)^2) := hsq (ht.add hr) (hct.add hcr)
  let C := 2*T*D + D^2
  have hmask : Integrable (S.indicator (fun _ : ℝ => C)) :=
    (integrable_indicator_iff hS).2 (integrableOn_const hfinite)
  have hle (x : ℝ) : (t x+r x)^2 - (t x)^2 ≤ S.indicator (fun _ : ℝ => C) x := by
    by_cases hx : x ∈ S
    · rw [indicator_of_mem hx]
      have hp : t x * r x ≤ T*D := (le_abs_self _).trans (by
        rw [abs_mul]; exact mul_le_mul (htb x) (hrb x) (abs_nonneg _) hT)
      have hq := mul_le_mul (hrb x) (hrb x) (abs_nonneg _) hD
      rw [← pow_two, sq_abs] at hq
      dsimp [C]; linarith only [hp, hq]
    · have hr0 : r x = 0 := by by_contra h; exact hx (hsupp h)
      simp [indicator_of_notMem hx, hr0]
  have h := integral_mono (hsum.sub hts) hmask hle
  simp only [Pi.sub_apply, integral_sub hsum hts, integral_indicator hS, setIntegral_const,
    smul_eq_mul] at h
  unfold energy
  linarith only [h]

end
end MathLab.WT
