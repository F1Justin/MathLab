module
public import MathLab.WT.Basic
public import Mathlib.Analysis.Convolution
public import Mathlib.MeasureTheory.Measure.Haar.Unique
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

@[expose] public section
namespace MathLab.WT

open MeasureTheory Set
open scoped Convolution

noncomputable section

theorem reg_mul {f g : ℝ → ℝ} (hf : Regular f) (hg : Regular g) :
    Integrable (fun x => f x * g x) := by
  obtain ⟨B, hB⟩ := hg.2
  exact hf.1.mul_bdd hg.1.aestronglyMeasurable (Filter.Eventually.of_forall hB)

private theorem reg_sq {f : ℝ → ℝ} (hf : Regular f) : Integrable (fun x => f x ^ 2) := by
  simpa [pow_two] using reg_mul hf hf

private theorem reg_rev {f : ℝ → ℝ} (hf : Regular f) : Regular (rev f) := by
  obtain ⟨B, hB⟩ := hf.2
  exact ⟨hf.1.comp_neg, B, fun x => hB (-x)⟩

private theorem reg_sub {f : ℝ → ℝ} (hf : Regular f) (z : ℝ) :
    Regular (fun x => f (z - x)) := by
  obtain ⟨B, hB⟩ := hf.2
  exact ⟨hf.1.comp_sub_left z, B, fun x => hB (z-x)⟩

private theorem conv_eq (f g : ℝ → ℝ) : conv f g = f ⋆[ContinuousLinearMap.mul ℝ ℝ] g := rfl

theorem eval_conv_symm (f g : ℝ → ℝ) : conv f g = conv g f := by
  funext x
  unfold conv
  rw [← integral_sub_left_eq_self (fun y => g y * f (x-y)) volume x]
  simp only [sub_sub_cancel]
  apply integral_congr_ae
  filter_upwards with y
  ring

/-- Expected autocorrelation of the finite law as an actual function of the lag. -/
def Witness.meanAutocorr {v α β : ℝ} (W : Witness v α β) (s : ℝ) : ℝ :=
  expectation W.p (fun i => conv (W.w i) (rev (W.w i)) s)

theorem Witness.integrable_meanAutocorr {v α β : ℝ} (W : Witness v α β) :
    Integrable W.meanAutocorr := by
  unfold Witness.meanAutocorr expectation
  apply integrable_finsetSum _
  intro i _
  apply Integrable.const_mul
  change Integrable (conv (W.w i) (rev (W.w i)))
  rw [conv_eq]
  exact (W.window_regular i).1.integrable_convolution _ (reg_rev (W.window_regular i)).1

theorem Witness.mass_meanAutocorr {v α β : ℝ} (W : Witness v α β) :
    (∫ s, W.meanAutocorr s) = 1 := by
  unfold Witness.meanAutocorr expectation
  rw [integral_finsetSum]
  · calc
      _ = ∑ i, W.p i := by
        apply Finset.sum_congr rfl
        intro i _
        rw [integral_const_mul]
        change W.p i * (∫ a, conv (W.w i) (rev (W.w i)) a) = _
        rw [conv_eq,
          integral_convolution _ (W.window_regular i).1 (reg_rev (W.window_regular i)).1]
        change W.p i * ((∫ x, W.w i x) * ∫ x, W.w i (-x)) = W.p i
        simp [integral_neg_eq_self, W.mass]
      _ = 1 := W.total_weight
  · intro i _
    apply Integrable.const_mul
    change Integrable (conv (W.w i) (rev (W.w i)))
    rw [conv_eq]
    exact (W.window_regular i).1.integrable_convolution _ (reg_rev (W.window_regular i)).1

theorem Witness.meanAutocorr_zero {v α β : ℝ} (W : Witness v α β) :
    W.meanAutocorr 0 = expectation W.p (fun i => energy (W.w i)) := by
  unfold Witness.meanAutocorr expectation
  apply Finset.sum_congr rfl
  intro i _
  simp [conv, rev, energy, pow_two]

theorem Witness.meanAutocorr_support {v α β : ℝ} (W : Witness v α β) {s : ℝ} (hs : v < |s|) :
    W.meanAutocorr s = 0 := by
  unfold Witness.meanAutocorr expectation
  apply Finset.sum_eq_zero
  intro i _
  suffices h : conv (W.w i) (rev (W.w i)) s = 0 from by simp [h]
  unfold conv rev
  apply integral_eq_zero_of_ae
  filter_upwards with y
  by_contra hp
  obtain ⟨h₁, h₂⟩ := mul_ne_zero_iff.mp hp
  have hy := W.window_support i h₁
  have hz := W.window_support i h₂
  rcases lt_abs.mp hs with h | h <;> rcases hy with ⟨hy0, hyv⟩ <;>
    rcases hz with ⟨hz0, hzv⟩ <;> linarith

/-- A finite test measure acts by averaging backward translates of a window. -/
def dualWindow (μ : Measure ℝ) (w : ℝ → ℝ) (x : ℝ) : ℝ := ∫ z, w (z-x) ∂μ

private theorem translated_integrable (μ : Measure ℝ) [IsFiniteMeasure μ]
    {w : ℝ → ℝ} (hw : Regular w) :
    Integrable (fun p : ℝ × ℝ => w (p.2-p.1)) (volume.prod μ) := by
  have hc : Integrable (fun _ : ℝ => (1:ℝ)) μ := integrable_const 1
  simpa [rev, neg_sub] using
    hc.convolution_integrand (ContinuousLinearMap.mul ℝ ℝ) (reg_rev hw).1

theorem dualWindow_regular (μ : Measure ℝ) [IsFiniteMeasure μ] {w : ℝ → ℝ} (hw : Regular w) :
    Regular (dualWindow μ w) := by
  refine ⟨(translated_integrable μ hw).integral_prod_left, ?_⟩
  obtain ⟨B, hB⟩ := hw.2
  refine ⟨B * μ.real Set.univ, ?_⟩
  intro x
  exact norm_integral_le_of_norm_le_const (μ := μ) (f := fun z => w (z-x))
    (Filter.Eventually.of_forall fun z => hB (z-x))

/-- Fubini with the endpoint atoms included. The table may be signed. -/
theorem dualWindow_adjoint (μ : Measure ℝ) [IsFiniteMeasure μ]
    {w t : ℝ → ℝ} (hw : Regular w) (ht : Regular t) :
    (∫ x, t x * dualWindow μ w x) = ∫ z, conv w t z ∂μ := by
  obtain ⟨B, hB⟩ := ht.2
  have hi : Integrable (fun p : ℝ × ℝ => t p.1 * w (p.2-p.1)) (volume.prod μ) :=
    (translated_integrable μ hw).bdd_mul ht.1.aestronglyMeasurable.comp_fst
      (Filter.Eventually.of_forall fun p => hB p.1)
  rw [eval_conv_symm w t]
  unfold dualWindow conv
  simp_rw [← integral_const_mul]
  exact integral_integral_swap hi

theorem integrable_conv_against (μ : Measure ℝ) [IsFiniteMeasure μ]
    {w t : ℝ → ℝ} (hw : Regular w) (ht : Regular t) :
    Integrable (conv w t) μ := by
  obtain ⟨B, hB⟩ := ht.2
  have hi : Integrable (fun p : ℝ × ℝ => t p.1 * w (p.2-p.1)) (volume.prod μ) :=
    (translated_integrable μ hw).bdd_mul ht.1.aestronglyMeasurable.comp_fst
      (Filter.Eventually.of_forall fun p => hB p.1)
  rw [eval_conv_symm w t]
  exact hi.integral_prod_right

private theorem translate_pair (w : ℝ → ℝ) (a b : ℝ) :
    (∫ x, w (a-x) * w (b-x)) = conv w (rev w) (a-b) := by
  unfold conv rev
  rw [← integral_sub_left_eq_self (fun y => w y * w (-(a-b-y))) volume a]
  apply integral_congr_ae
  filter_upwards with x
  congr 2
  ring

theorem Witness.meanAutocorr_even {v α β : ℝ} (W : Witness v α β) (s : ℝ) :
    W.meanAutocorr (-s) = W.meanAutocorr s := by
  unfold Witness.meanAutocorr expectation
  apply Finset.sum_congr rfl
  intro i _
  congr 1
  change conv (W.w i) (rev (W.w i)) (-s) = conv (W.w i) (rev (W.w i)) s
  rw [← show 0-s = -s by ring, ← translate_pair (W.w i) 0 s]
  conv_rhs => rw [← show s-0 = s by ring, ← translate_pair (W.w i) s 0]
  apply integral_congr_ae
  filter_upwards with x
  simp only [mul_comm]

theorem Witness.integrable_corr_slice {v α β : ℝ} (W : Witness v α β)
    (μ : Measure ℝ) [IsFiniteMeasure μ] (z : ℝ) :
    Integrable (fun b => W.meanAutocorr (z-b)) μ := by
  unfold Witness.meanAutocorr expectation
  apply integrable_finsetSum _
  intro i _
  apply Integrable.const_mul
  have e (b : ℝ) : conv (W.w i) (rev (W.w i)) (z-b) =
      conv (fun x => W.w i (z-x)) (W.w i) b := (translate_pair (W.w i) z b).symm
  simp_rw [e]
  exact integrable_conv_against μ (reg_sub (W.window_regular i) z) (W.window_regular i)

private theorem autocorr_inner (μ : Measure ℝ) [IsFiniteMeasure μ]
    {w : ℝ → ℝ} (hw : Regular w) (a : ℝ) :
    (∫ b, conv w (rev w) (a-b) ∂μ) = conv w (dualWindow μ w) a := by
  rw [eval_conv_symm w (dualWindow μ w)]
  unfold conv
  calc
    _ = ∫ b, conv w (fun x => w (a-x)) b ∂μ := by
      rw [eval_conv_symm w (fun x => w (a-x))]
      apply integral_congr_ae
      filter_upwards with b
      exact (translate_pair w a b).symm
    _ = ∫ x, w (a-x) * dualWindow μ w x := (dualWindow_adjoint μ hw (reg_sub hw a)).symm
    _ = _ := by
      apply integral_congr_ae
      filter_upwards with x
      ring

theorem Witness.integrable_corr_average {v α β : ℝ} (W : Witness v α β)
    (μ ν : Measure ℝ) [IsFiniteMeasure μ] [IsFiniteMeasure ν] :
    Integrable (fun z => ∫ b, W.meanAutocorr (z-b) ∂ν) μ := by
  have hai (i : Fin W.n) (z : ℝ) : Integrable (fun b => conv (W.w i) (rev (W.w i)) (z-b)) ν := by
    have e (b : ℝ) : conv (W.w i) (rev (W.w i)) (z-b) =
        conv (fun x => W.w i (z-x)) (W.w i) b := (translate_pair (W.w i) z b).symm
    simp_rw [e]
    exact integrable_conv_against ν (reg_sub (W.window_regular i) z) (W.window_regular i)
  unfold Witness.meanAutocorr expectation
  simp_rw [integral_finsetSum Finset.univ (fun i _ => (hai i _).const_mul (W.p i)), integral_const_mul]
  apply integrable_finsetSum _
  intro i _
  apply Integrable.const_mul
  simp_rw [autocorr_inner ν (W.window_regular i)]
  exact integrable_conv_against μ (W.window_regular i) (dualWindow_regular ν (W.window_regular i))

/-- The test-energy identity. Each of the two outside integrations uses the
same finite measure; the correlation inside is the one in WT condition (v). -/
theorem energy_dualWindow (μ : Measure ℝ) [IsFiniteMeasure μ]
    {w : ℝ → ℝ} (hw : Regular w) :
    energy (dualWindow μ w) = ∫ a, ∫ b, conv w (rev w) (a-b) ∂μ ∂μ := by
  rw [energy]
  simp_rw [pow_two]
  rw [dualWindow_adjoint μ hw (dualWindow_regular μ hw)]
  apply integral_congr_ae
  filter_upwards with a
  rw [eval_conv_symm w (dualWindow μ w)]
  unfold conv
  calc
    _ = ∫ x, w (a-x) * dualWindow μ w x := by
      apply integral_congr_ae
      filter_upwards with x
      ring
    _ = _ := by
      rw [dualWindow_adjoint μ hw (reg_sub hw a)]
      rw [eval_conv_symm w (fun x => w (a-x))]
      apply integral_congr_ae
      filter_upwards with b
      exact translate_pair w a b

theorem square_dual_bound (μ : Measure ℝ) [IsFiniteMeasure μ]
    {w t : ℝ → ℝ} (hw : Regular w) (ht : Regular t) :
    2 * (∫ z, conv w t z ∂μ) - (∫ a, ∫ b, conv w (rev w) (a-b) ∂μ ∂μ) ≤ energy t := by
  rw [← dualWindow_adjoint μ hw ht, ← energy_dualWindow μ hw, energy, energy]
  have hg := dualWindow_regular μ hw
  have bound := integral_mono
    (((reg_mul ht hg).const_mul 2).sub (reg_sq hg)) (reg_sq ht)
    (fun x => by
      change 2*(t x * dualWindow μ w x) - dualWindow μ w x ^ 2 ≤ t x ^ 2
      nlinarith only [sq_nonneg (t x-dualWindow μ w x)])
  change (∫ x, 2 * (t x * dualWindow μ w x) - dualWindow μ w x ^ 2) ≤ _ at bound
  rwa [integral_sub ((reg_mul ht hg).const_mul 2) (reg_sq hg), integral_const_mul] at bound

/-- The finite-dimensional mixing weights are applied to pairs before the
adjoint and autocorrelation evaluations. This permits correlated signed atoms. -/
theorem Witness.dual_bound_with_tables {v α β : ℝ} (W : Witness v α β)
    (tt : Fin W.n → ℝ → ℝ) (treg : ∀ i, Regular (tt i))
    (tcost : expectation W.p (fun i => energy (tt i)) ≤ W.σ + α)
    (μ : Measure ℝ) [IsFiniteMeasure μ]
    (hcover : ∀ᵐ z ∂μ, 1 ≤ expectation W.p (fun i => conv (W.w i) (tt i) z)) :
    2 * μ.real Set.univ - (∫ a, ∫ b, W.meanAutocorr (a-b) ∂μ ∂μ) ≤ W.σ + α := by
  let c := fun i => conv (W.w i) (tt i)
  let a := fun i => fun z => ∫ b, conv (W.w i) (rev (W.w i)) (z-b) ∂μ
  have hc (i : Fin W.n) : Integrable (c i) μ :=
    integrable_conv_against μ (W.window_regular i) (treg i)
  have ha (i : Fin W.n) : Integrable (a i) μ := by
    change Integrable (fun z => ∫ b, conv (W.w i) (rev (W.w i)) (z-b) ∂μ) μ
    simp_rw [autocorr_inner μ (W.window_regular i)]
    exact integrable_conv_against μ (W.window_regular i) (dualWindow_regular μ (W.window_regular i))
  have hai (i : Fin W.n) (z : ℝ) : Integrable (fun b => conv (W.w i) (rev (W.w i)) (z-b)) μ := by
    have e (b : ℝ) : conv (W.w i) (rev (W.w i)) (z-b) =
        conv (fun x => W.w i (z-x)) (W.w i) b := (translate_pair (W.w i) z b).symm
    simp_rw [e]
    exact integrable_conv_against μ (reg_sub (W.window_regular i) z) (W.window_regular i)
  have hcf : μ.real Set.univ ≤ ∑ i, W.p i * ∫ z, c i z ∂μ := by
    have h := integral_mono_ae (integrable_const (1:ℝ) (μ := μ))
        (integrable_finsetSum Finset.univ (f := fun i z => W.p i * c i z)
          (fun i _ => (hc i).const_mul _)) hcover
    simpa [integral_const, smul_eq_mul,
      integral_finsetSum Finset.univ (fun i _ => (hc i).const_mul (W.p i)), integral_const_mul] using h
  have hcorr : (∫ z, ∫ b, W.meanAutocorr (z-b) ∂μ ∂μ) = ∑ i, W.p i * ∫ z, a i z ∂μ := by
    have e (z : ℝ) : (∫ b, W.meanAutocorr (z-b) ∂μ) = ∑ i, W.p i * a i z := by
      unfold Witness.meanAutocorr expectation
      rw [integral_finsetSum]
      · simp only [integral_const_mul, a]
      · intro i _
        exact (hai i z).const_mul (W.p i)
    simp_rw [e]
    rw [integral_finsetSum Finset.univ (fun i _ => (ha i).const_mul (W.p i))]
    simp only [integral_const_mul]
  have hsum := Finset.sum_le_sum (s := Finset.univ) (fun i _ =>
    mul_le_mul_of_nonneg_left (square_dual_bound μ (W.window_regular i) (treg i))
      (W.weight_nonneg i))
  change ∑ i, W.p i * (2*(∫ z, c i z ∂μ) - (∫ z, a i z ∂μ)) ≤ _ at hsum
  have dist : (∑ i, W.p i * (2 * (∫ z, c i z ∂μ) - (∫ z, a i z ∂μ))) =
      2 * (∑ i, W.p i * ∫ z, c i z ∂μ) - ∑ i, W.p i * ∫ z, a i z ∂μ := by
    rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
    apply Finset.sum_congr rfl
    intro i _
    ring
  rw [dist] at hsum
  rw [hcorr]
  unfold expectation at tcost
  linarith

theorem Witness.dual_measure_bound {v α β : ℝ} (W : Witness v α β)
    (μ : Measure ℝ) [IsFiniteMeasure μ]
    (hcover : ∀ᵐ z ∂μ, 1 ≤ expectation W.p (fun i => conv (W.w i) (W.t i) z)) :
    2 * μ.real Set.univ - (∫ a, ∫ b, W.meanAutocorr (a-b) ∂μ ∂μ) ≤ W.σ + α :=
  W.dual_bound_with_tables W.t W.table_regular W.table_cost μ hcover

/-- Translating all tables moves the test away from the two open coverage endpoints. -/
theorem Witness.dual_shift {v α β : ℝ} (W : Witness v α β)
    (μ : Measure ℝ) [IsFiniteMeasure μ] (δ : ℝ)
    (hcover : ∀ᵐ z ∂μ, z+δ ∈ Ioo 0 W.σ) :
    2 * μ.real Set.univ - (∫ a, ∫ b, W.meanAutocorr (a-b) ∂μ ∂μ) ≤ W.σ + α := by
  let tt := fun i x => W.t i (x+δ)
  have tr (i : Fin W.n) : Regular (tt i) := by
    obtain ⟨hi,B,hB⟩ := W.table_regular i
    exact ⟨hi.comp_add_right δ, B,fun x => hB (x+δ)⟩
  have tc (i : Fin W.n) : energy (tt i) = energy (W.t i) :=
    integral_add_right_eq_self (fun x => W.t i x ^ 2) δ
  apply W.dual_bound_with_tables tt tr (by simpa only [tc] using W.table_cost) μ
  filter_upwards [hcover] with z hz
  have e (i : Fin W.n) : conv (W.w i) (tt i) z = conv (W.w i) (W.t i) (z+δ) := by
    apply integral_congr_ae
    filter_upwards with y
    simp only [tt, show z-y+δ = z+δ-y by ring]
  simpa only [e] using W.covering (z+δ) hz

end

end MathLab.WT
