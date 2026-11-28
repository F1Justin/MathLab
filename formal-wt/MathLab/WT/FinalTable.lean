module
public import MathLab.WT.Shoulders
public import MathLab.WT.ConvolutionBounds
import Mathlib.MeasureTheory.Measure.Haar.Unique
import Mathlib.Tactic.Linarith

/-! Complete table repair from uniform clipping and covering estimates. The
final reflection takes place after the pointwise repair, so the input table
and its filters need no reflection-invariance hypothesis. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set Filter
noncomputable section

theorem regular_of_continuous_compact {f : ℝ → ℝ} (h : Continuous f) (hc : HasCompactSupport f) :
    Regular f := by
  refine ⟨h.integrable_of_hasCompactSupport hc, ?_⟩
  obtain ⟨B,hB⟩ := h.norm.bddAbove_range_of_hasCompactSupport hc.norm
  exact ⟨B, fun x => hB (mem_range_self x)⟩

theorem patch_table_profiles {V T₀ : ℝ → ℝ} (hw : Continuous V) (hc : HasCompactSupport V)
    (ht : Regular T₀) {M L D d Z K : ℝ}
    (hM : 0 < M) (hlen : 12*M ≤ D) (hD : D ≤ L) (hgap : L-D ≤ M)
    (hs : ∀ y, M < |y| → V y = 0) (he : ∀ y, V (-y) = V y)
    (hm : ∫ y, V y = 1) (ha : ∀ y, 0 ≤ conv V V y)
    (hz : massAbs V ≤ Z) (hK : ∀ x, |T₀ x| ≤ K)
    (hplat : ∀ x, |x| ≤ L-M/4 → T₀ x = 1) (hout : ∀ x, L+M/4 < |x| → T₀ x = 0)
    (hd : 0 ≤ d) (hdef : ∀ x, |x| < D → 1-conv V T₀ x ≤ d) :
    ∃ T : ℝ → ℝ, Regular T ∧ (∀ x, T (-x) = T x) ∧
      (∀ x, D+6*M < |x| → T x = 0) ∧ (∀ x, |x| < D-6*M → T x = 1) ∧
      (∀ x, |x| < D → 1 ≤ conv V T x) ∧
      energy T ≤ energy T₀ + 2*(L+5*M)*(2*K*(d*Z)+(d*Z)^2) ∧
      ∀ x, |conv V T x - evenPart (conv V T₀) x| ≤ d := by
  let b := shoulderMask L (4*M)
  let r (x : ℝ) := d * conv V b x
  let t (x : ℝ) := T₀ x + r x
  have hrev : rev V = V := funext he
  have hV := regular_of_continuous_compact hw hc
  have hZ := (massAbs_nonneg V).trans hz
  have hK₀ := (abs_nonneg (T₀ 0)).trans (hK 0)
  have hP := mul_nonneg hd hZ
  have hb := shoulderMask_integrable L (4*M)
  have hrb (x : ℝ) : |r x| ≤ d*Z := by
    have h := abs_conv_le_mass_abs hV.1 (b := b)
      (fun y => by rw [abs_of_nonneg (shoulderMask_range L (4*M) y).1]
                   exact (shoulderMask_range L (4*M) y).2) x
    unfold r
    rw [abs_mul, abs_of_nonneg hd]
    exact mul_le_mul_of_nonneg_left (h.trans hz) hd
  have hreg : Regular r := ⟨(hV.1.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hb).const_mul d,
    _, hrb⟩
  have htr : Regular t := ht.add hreg
  have hr0 (x : ℝ) (hx : 5*M < abs (|x|-L)) : r x = 0 := by
    simp [r, b, conv_mask_supported hs (show 4*M+M < abs (|x|-L) by linarith)]
  have hout' (x : ℝ) (hx : D+6*M < |x|) : t x = 0 := by
    have hd' : 5*M < abs (|x|-L) := by linarith [le_abs_self (|x|-L)]
    simp [t, hout x (by linarith), hr0 x hd']
  have hplate (x : ℝ) (hx : |x| < D-6*M) : t x = 1 := by
    have hd' : 5*M < abs (|x|-L) := by linarith [neg_le_abs (|x|-L)]
    simp [t, hplat x (by linarith), hr0 x hd']
  have repair := repair_cover_continuous hw hc ht.1 hb (shoulderMask_measurable L (4*M))
    (shoulderMask_range L (4*M)) hm (by simpa only [hrev] using ha)
    (target := {x : ℝ | |x| < D}) hd hdef (by
      intro x hx hbad y hy
      change |x| < D at hx
      have hdist : L-M/4-M < |x| := by
        by_contra! hcontra
        linarith [conv_on_plateau hs hm hplat hcontra]
      have hy' : |y| ≤ M+M := by
        by_contra! hn
        apply hy
        rw [hrev]
        exact conv_zero_outside hs hs hn
      have hx' : abs (|x|-L) ≤ M/4+M := abs_le.mpr ⟨by linarith, by linarith⟩
      have hbnd := bandDist_lipschitz L x y
      have hmem : x-y ∈ shoulderBand L (4*M) := by
        change abs (|x-y|-L) ≤ 4*M
        linarith
      exact indicator_of_mem hmem _)
  have hcover (x : ℝ) (hx : |x| < D) : 1 ≤ conv V t x := by
    simpa only [hrev, b, t, r] using repair.2 x hx
  have hcost : energy t ≤ energy T₀ + 2*(L+5*M)*(2*K*(d*Z)+(d*Z)^2) := by
    apply energy_compare_interval htr ht (by linarith) (by positivity)
    · intro x _
      have h₁ : T₀ x * r x ≤ K*(d*Z) := (le_abs_self _).trans (by
        rw [abs_mul]; exact mul_le_mul (hK x) (hrb x) (abs_nonneg _) hK₀)
      have h₂ := pow_le_pow_left₀ (abs_nonneg (r x)) (hrb x) 2
      rw [sq_abs] at h₂
      dsimp [t]
      nlinarith only [h₁,h₂]
    · intro x hx
      have h0 : r x = 0 := hr0 x (by linarith [le_abs_self (|x|-L)])
      simp [t, h0]
  refine ⟨evenPart t, evenPart_regular htr, evenPart_even t, ?_, ?_, ?_,
    (energy_evenPart htr).trans hcost,?_⟩
  · intro x hx
    simp [evenPart, hout' x hx, hout' (-x) (by simpa using hx)]
  · intro x hx
    rw [evenPart, hplate x hx, hplate (-x) (by simpa using hx)]
    norm_num
  · intro x hx
    rw [conv_evenPart hV.1 he htr x]
    linarith [hcover x hx, hcover (-x) (by simpa using hx)]
  · intro x
    have hi (y : ℝ) : conv V t y-conv V T₀ y ∈ Icc 0 d := by
      simpa only [hrev,b,t,r] using repair.1 y
    rw [conv_evenPart hV.1 he htr x,evenPart]
    apply abs_le.mpr
    exact ⟨by linarith [(hi x).1,(hi (-x)).1],by linarith [(hi x).2,(hi (-x)).2]⟩

theorem patch_table {V T₀ : ℝ → ℝ} (hw : Continuous V) (hc : HasCompactSupport V)
    (ht : Regular T₀) {M L D d Z K : ℝ}
    (hM : 0 < M) (hlen : 12*M ≤ D) (hD : D ≤ L) (hgap : L-D ≤ M)
    (hs : ∀ y, M < |y| → V y = 0) (he : ∀ y, V (-y) = V y)
    (hm : ∫ y, V y = 1) (ha : ∀ y, 0 ≤ conv V V y)
    (hz : massAbs V ≤ Z) (hK : ∀ x, |T₀ x| ≤ K)
    (hplat : ∀ x, |x| ≤ L-M/4 → T₀ x = 1) (hout : ∀ x, L+M/4 < |x| → T₀ x = 0)
    (hd : 0 ≤ d) (hdef : ∀ x, |x| < D → 1-conv V T₀ x ≤ d) :
    ∃ T : ℝ → ℝ, Regular T ∧ (∀ x, T (-x) = T x) ∧
      (∀ x, D+6*M < |x| → T x = 0) ∧ (∀ x, |x| < D-6*M → T x = 1) ∧
      (∀ x, |x| < D → 1 ≤ conv V T x) ∧
      energy T ≤ energy T₀ + 2*(L+5*M)*(2*K*(d*Z)+(d*Z)^2) := by
  obtain ⟨T,h₁,h₂,h₃,h₄,h₅,h₆,_⟩ :=
    patch_table_profiles hw hc ht hM hlen hD hgap hs he hm ha hz hK hplat hout hd hdef
  exact ⟨T,h₁,h₂,h₃,h₄,h₅,h₆⟩

end
end MathLab.WT
