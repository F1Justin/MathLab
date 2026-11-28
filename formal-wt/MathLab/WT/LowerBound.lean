module
public import MathLab.WT.LowerBoundMeasure
public import MathLab.WT.Dilation
public import MathLab.WT.Extension
public import MathLab.WT.Infima
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

@[expose] public section
namespace MathLab.WT

open MeasureTheory Set
open AveragedTest

noncomputable section

private theorem density_on_short_lags {l s : ℝ} (hs : s ≠ 0) (hl : 2+|s| < l) :
    testDensity l s + testDensity l (-s) = 1 - shoulder |s| := by
  have pos (x : ℝ) (hx : 0 < x) (hx' : 2+x < l) :
      testDensity l x = 1-shoulder x ∧ testDensity l (-x) = 0 := by
    simp [testDensity, indicator_of_mem (show x ∈ Icc 0 l from ⟨hx.le,by linarith⟩),
      indicator_of_notMem (show -x ∉ Icc 0 l from fun h => by linarith [h.1]),
      shoulder_zero (x:=l-x) (by linarith)]
  rcases lt_or_gt_of_ne hs with h | h
  · rw [abs_of_neg h] at *
    have h' := pos (-s) (by linarith) hl
    rw [neg_neg] at h'
    simp [h'.1,h'.2]
  · rw [abs_of_pos h] at *
    obtain ⟨h₁,h₂⟩ := pos s h hl
    simp [h₁,h₂]

private theorem symmetrized_density {v α β : ℝ} (W : Witness v α β) (l : ℝ) :
    Integrable (fun s => W.meanAutocorr s * (testDensity l s + testDensity l (-s))) ∧
    (∫ s, W.meanAutocorr s * (testDensity l s + testDensity l (-s))) =
      2 * ∫ s, W.meanAutocorr s ∂bodyMeasure l := by
  have h₁ : Integrable (fun s => W.meanAutocorr s * testDensity l s) := by
    apply W.integrable_meanAutocorr.mul_bdd (density_measurable l).aestronglyMeasurable
    exact Filter.Eventually.of_forall (density_regular l).2.choose_spec
  have h₂ : Integrable (fun s => W.meanAutocorr s * testDensity l (-s)) := by
    simpa only [W.meanAutocorr_even] using h₁.comp_neg
  have equ : (∫ s, W.meanAutocorr s * testDensity l (-s)) =
      ∫ s, W.meanAutocorr s * testDensity l s := by
    rw [← integral_neg_eq_self (fun s => W.meanAutocorr s * testDensity l (-s)) volume]
    simp only [W.meanAutocorr_even, neg_neg]
  simp_rw [mul_add]
  refine ⟨h₁.add h₂, ?_⟩
  rw [integral_add h₁ h₂, equ, body_integral]
  simp only [mul_comm (testDensity l _) (W.meanAutocorr _)]
  ring

/-- The dual test on an interval of length `l` whose two tips lie in the
open covering range after translating the table a distance `δ`. -/
theorem Witness.interior_lower_test {v α β l δ : ℝ} (W : Witness v α β)
    (hβ : β ≤ 14/15) (hl : 2 + v < l) (hδ : 0 < δ) (hσ : l+δ < W.σ) :
    (495709/562500 : ℝ) ≤ (14/15)*(α + W.σ - l) := by
  let R := W.meanAutocorr
  let q := tailArea 0
  let b : ℝ := 5/7
  let B : ℝ := 14/15
  let c : ℝ := 495709/562500
  let C := bodyCorrelation l
  let F := fun s => testDensity l s + testDensity l (-s)
  let T := l - 4*q + 4*b - 2*b^2*B
  have hf : Integrable (fun s => R s * F s) := (symmetrized_density W l).1
  have hc : Integrable (fun s => R s * C s) := (body_energy l W.integrable_meanAutocorr).1
  have hr : Integrable R := W.integrable_meanAutocorr
  have hfinal : c ≤ B*(T - (∫ s, R s * C s) - 2*b*(∫ s, R s * F s)) := by
    have hA : Integrable (fun s => R s*T - R s*C s) := (hr.mul_const T).sub hc
    have hF : Integrable (fun s => 2*b*(R s*F s)) := hf.const_mul (2*b)
    have hyp : ∀ᵐ s : ℝ, R s*c ≤ B * ((R s*T-R s*C s)-2*b*(R s*F s)) := by
      filter_upwards [volume.ae_ne (0:ℝ)] with s hs
      by_cases hv : |s| ≤ v
      · have hg : 2+|s| < l := by linarith
        have hc' : C s = l-|s| - 2*tailArea 0 - 2*tailArea |s| + 2*tailOverlap |s| := by
          rw [show C s = bodyCorrelation l |s| from bodyCorrelation_abs l s]
          exact density_overlap (abs_nonneg s) hg
        have hf' : F s = 1-shoulder |s| := density_on_short_lags hs hg
        have hn := weight_ge (abs_nonneg s)
        rw [weight_in_edge_units (abs_nonneg s)] at hn
        have hw : c ≤ B*(T-C s-2*b*F s) := by
          rw [hc',hf']
          dsimp [c,B,T,q,b]
          linarith
        calc
          _ ≤ R s * (B*(T-C s-2*b*F s)) := mul_le_mul_of_nonneg_left hw (W.autocorrelation s)
          _ = _ := by ring
      · have hz : R s = 0 := W.meanAutocorr_support (lt_of_not_ge hv)
        simp [hz]
    have h := integral_mono_ae (hr.mul_const c) ((hA.sub hF).const_mul B) hyp
    change (∫ s, R s*c) ≤ ∫ s, B*((R s*T - R s*C s) - 2*b*(R s*F s)) at h
    rw [integral_mul_const, integral_const_mul, integral_sub hA hF,
      integral_sub (hr.mul_const T) hc, integral_mul_const, integral_const_mul,
      show (∫s, R s) = 1 from W.mass_meanAutocorr, one_mul, one_mul] at h
    exact h
  have dual := W.dual_shift (edgeMeasure l) δ (by
    filter_upwards [edge_support (l:=l) (by linarith [W.width_pos])] with z hz
    exact ⟨by linarith [hz.1],by linarith [hz.2]⟩)
  rw [edge_mass (by linarith [W.width_pos]), edge_energy W (by linarith)] at dual
  have hzero : R 0 ≤ β := by
    change W.meanAutocorr 0 ≤ β
    rw [W.meanAutocorr_zero]
    exact W.window_cost
  have fx := (symmetrized_density W l).2
  change (∫s, R s*F s) = 2*∫s, R s ∂bodyMeasure l at fx
  dsimp [q,b,B,T,c] at hfinal
  change 2*(l-2*tailArea 0+2*(5/7)) -
    ((∫s, R s*C s) + 4*(5/7)*(∫s, R s ∂bodyMeasure l) + 2*(5/7)^2*R 0) ≤ W.σ+α at dual
  linarith only [hfinal, dual, fx, hzero, hβ]

private theorem normalized_product_lower {v α : ℝ} (W : Witness v α (14/15)) :
    (495709/562500 : ℝ) ≤ (14/15)*α := by
  by_contra! hf
  let δ := (495709/562500 - (14/15)*α)/4
  have hp : 0 < δ := by dsimp [δ]; linarith
  let d := 3+v+2*δ
  let U := W.extend d (by dsimp [d]; linarith [W.width_pos])
  have hu : U.σ = W.σ+d := rfl
  have hσ : 0 < W.σ := by linarith [W.width_pos,W.width_le]
  have h := U.interior_lower_test (l:=U.σ-2*δ) (δ:=δ) (le_refl _) (by
    rw [hu]; dsimp [d]; linarith) hp (by linarith)
  dsimp [δ] at h
  linarith

/-- A rational, independently checkable lower certificate for every finite WT law. -/
theorem Witness.universal_product_lower {v α β : ℝ} (W : Witness v α β) :
    (495709/562500 : ℝ) ≤ α*β := by
  let k := (14/15)/β
  have hk : 0 < k := div_pos (by norm_num) W.beta_pos
  have hβ : k*β = 14/15 := by dsimp [k]; field_simp [W.beta_pos.ne']
  have U := W.dilate k hk
  rw [hβ] at U
  have h := normalized_product_lower U
  have he : 14/15*(α/k) = α*β := by
    dsimp [k]
    field_simp
  rwa [he] at h

theorem Witness.universal_objective_lower {v α β : ℝ} (W : Witness v α β) :
    Real.sqrt 495709 / 375 ≤ 2*Real.sqrt (α*β) :=
  objective_bound W.universal_product_lower

theorem universal_infimum_lower (k : Kind) : Real.sqrt 495709 / 375 ≤ infimum k := by
  apply le_csInf (values_nonempty k)
  rintro _ ⟨v,α,β,W,_,rfl⟩
  exact W.universal_objective_lower

end

end MathLab.WT
