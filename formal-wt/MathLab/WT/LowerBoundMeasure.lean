module
public import MathLab.WT.LowerBoundProfile
public import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

@[expose] public section
namespace MathLab.WT.AveragedTest

open MeasureTheory Set
open scoped ENNReal

noncomputable section

def bodyMeasure (l : ℝ) : Measure ℝ :=
  volume.withDensity (fun x => ENNReal.ofReal (testDensity l x))

instance (l : ℝ) : IsFiniteMeasure (bodyMeasure l) := by
  apply isFiniteMeasure_withDensity
  rw [← ofReal_integral_eq_lintegral_ofReal (density_regular l).1
    (Filter.Eventually.of_forall fun x => (density_bounds l x).1)]
  exact ENNReal.ofReal_ne_top

def tipMeasure (l : ℝ) : Measure ℝ :=
  (ENNReal.ofReal (5/7) : ℝ≥0∞) • (Measure.dirac 0 + Measure.dirac l)

instance (l : ℝ) : IsFiniteMeasure (tipMeasure l) := by
  unfold tipMeasure
  exact Measure.smul_finite _ ENNReal.ofReal_ne_top

def edgeMeasure (l : ℝ) : Measure ℝ := bodyMeasure l + tipMeasure l

instance (l : ℝ) : IsFiniteMeasure (edgeMeasure l) := by
  unfold edgeMeasure
  infer_instance

theorem body_integral (l : ℝ) (F : ℝ → ℝ) :
    (∫ x, F x ∂bodyMeasure l) = ∫ x, testDensity l x * F x := by
  rw [bodyMeasure, integral_withDensity_eq_integral_toReal_smul
    ((density_measurable l).ennreal_ofReal) (Filter.Eventually.of_forall fun _ => ENNReal.ofReal_lt_top)]
  simp only [ENNReal.toReal_ofReal (density_bounds l _).1, smul_eq_mul]

theorem tip_integral (l : ℝ) (F : ℝ → ℝ) :
    (∫ x, F x ∂tipMeasure l) = (5/7)*(F 0 + F l) := by
  rw [tipMeasure, integral_smul_measure, integral_add_measure (integrable_dirac (by simp))
    (integrable_dirac (by simp)), integral_dirac, integral_dirac]
  norm_num [smul_eq_mul]

theorem edge_mass {l : ℝ} (hl : 1 ≤ l) :
    (edgeMeasure l).real univ = l - 2*tailArea 0 + 2*(5/7) := by
  have h : (∫ x, (1:ℝ) ∂edgeMeasure l) =
      (∫ x, (1:ℝ) ∂bodyMeasure l) + (∫ x, (1:ℝ) ∂tipMeasure l) :=
    integral_add_measure (integrable_const _) (integrable_const _)
  rw [body_integral, tip_integral] at h
  simp only [integral_const, smul_eq_mul, mul_one, testDensity_mass hl] at h
  linarith

theorem edge_support {l : ℝ} (hl : 0 ≤ l) : ∀ᵐ x ∂edgeMeasure l, x ∈ Icc 0 l := by
  rw [edgeMeasure, ae_add_measure_iff]
  constructor
  · rw [bodyMeasure, ae_withDensity_iff ((density_measurable l).ennreal_ofReal)]
    filter_upwards with x
    intro hx
    by_contra h
    simp [testDensity, indicator_of_notMem h] at hx
  · unfold tipMeasure
    apply Measure.ae_smul_measure
    rw [ae_add_measure_iff]
    simp [hl]

/-- Scalar autocorrelation of the absolutely continuous part of the test. -/
def bodyCorrelation (l s : ℝ) : ℝ := ∫ x, testDensity l x * testDensity l (x+s)

theorem bodyCorrelation_even (l s : ℝ) : bodyCorrelation l (-s) = bodyCorrelation l s := by
  unfold bodyCorrelation
  rw [← integral_add_right_eq_self (fun x => testDensity l x * testDensity l (x + -s)) s]
  apply integral_congr_ae
  filter_upwards with x
  simp [mul_comm]

theorem bodyCorrelation_abs (l s : ℝ) : bodyCorrelation l s = bodyCorrelation l |s| := by
  rcases le_total 0 s with h | h
  · rw [abs_of_nonneg h]
  · rw [abs_of_nonpos h, bodyCorrelation_even]

/-- Change of variables for the continuous-continuous part, including
absolute integrability of the resulting lag integral. -/
theorem body_energy (l : ℝ) {R : ℝ → ℝ} (hR : Integrable R) :
    Integrable (fun s => R s * bodyCorrelation l s) ∧
    (∫ a, ∫ b, R (a-b) ∂bodyMeasure l ∂bodyMeasure l) =
      ∫ s, R s * bodyCorrelation l s := by
  let f := testDensity l
  have hf := (density_regular l).1
  have hi : Integrable (fun p : ℝ × ℝ => R p.1 * f p.2 * f (p.2-p.1)) (volume.prod volume) := by
    apply (hR.mul_prod hf).mul_bdd
    · exact ((density_measurable l).comp (measurable_snd.sub measurable_fst)).aestronglyMeasurable
    · exact Filter.Eventually.of_forall fun p => (density_regular l).2.choose_spec (p.2-p.1)
  have row (s : ℝ) : (∫ x, R s * f x * f (x-s)) = R s * bodyCorrelation l s := by
    rw [← bodyCorrelation_even l s, bodyCorrelation, ← integral_const_mul]
    apply integral_congr_ae
    filter_upwards with x
    simp only [f, sub_eq_add_neg, mul_assoc]
  constructor
  · have hj := hi.integral_prod_left
    change Integrable (fun s => ∫ x, R s * f x * f (x-s)) at hj
    simpa only [row] using hj
  · rw [body_integral]
    simp_rw [body_integral]
    calc
      _ = ∫ a, ∫ s, R s * f a * f (a-s) := by
        apply integral_congr_ae
        filter_upwards with a
        rw [← integral_sub_left_eq_self (fun b => testDensity l b * R (a-b)) volume a,
          ← integral_const_mul]
        apply integral_congr_ae
        filter_upwards with s
        simp only [sub_sub_cancel, f]
        ring
      _ = ∫ s, ∫ a, R s * f a * f (a-s) := (integral_integral_swap hi).symm
      _ = _ := by simp only [row]

theorem body_reflect (l : ℝ) (R : ℝ → ℝ) :
    (∫ x, R (l-x) ∂bodyMeasure l) = ∫ x, R x ∂bodyMeasure l := by
  rw [body_integral, body_integral,
    ← integral_sub_left_eq_self (fun x => testDensity l x * R (l-x)) volume l]
  simp only [sub_sub_cancel, density_reflect]

theorem edge_energy {v α β l : ℝ} (W : Witness v α β) (hl : v < l) :
    (∫ a, ∫ b, W.meanAutocorr (a-b) ∂edgeMeasure l ∂edgeMeasure l) =
      (∫ s, W.meanAutocorr s * bodyCorrelation l s) +
      4*(5/7)*(∫ s, W.meanAutocorr s ∂bodyMeasure l) + 2*(5/7)^2 * W.meanAutocorr 0 := by
  let R := W.meanAutocorr
  let J := fun (μ ν : Measure ℝ) => ∫ a, ∫ b, R (a-b) ∂ν ∂μ
  let m := bodyMeasure l
  let t := tipMeasure l
  have sym (a b : ℝ) : R (a-b) = R (b-a) := by
    rw [← neg_sub b a]
    exact W.meanAutocorr_even _
  have plus (μ : Measure ℝ) [IsFiniteMeasure μ] : J μ (edgeMeasure l) = J μ m + J μ t := by
    have e (a : ℝ) : (∫ b, R (a-b) ∂edgeMeasure l) =
        (∫ b, R (a-b) ∂m) + ∫ b, R (a-b) ∂t :=
      integral_add_measure (W.integrable_corr_slice m a) (W.integrable_corr_slice t a)
    unfold J
    simp_rw [e]
    exact integral_add (W.integrable_corr_average μ m) (W.integrable_corr_average μ t)
  have ir : Integrable (fun a => R a) m := by
    have hi := W.integrable_corr_slice m 0
    simpa only [zero_sub, W.meanAutocorr_even] using hi
  have ir' : Integrable (fun a => R (a-l)) m := by
    simp_rw [sym _ l]
    exact W.integrable_corr_slice m l
  have comp : (∫ a, R (a-l) ∂m) = ∫ a, R a ∂m := by
    simp_rw [sym _ l]
    exact body_reflect l R
  have jmt : J m t = 2*(5/7)*(∫ x, R x ∂m) := by
    unfold J t
    simp_rw [tip_integral, sub_zero]
    rw [integral_const_mul, integral_add ir ir', comp]
    ring
  have jtm : J t m = 2*(5/7)*(∫ x, R x ∂m) := by
    unfold J t
    rw [tip_integral]
    change (5/7)*((∫ x, W.meanAutocorr (0-x) ∂m) + ∫ x, R (l-x) ∂m) = _
    simp only [zero_sub, W.meanAutocorr_even, body_reflect, m]
    dsimp [R]
    ring
  have jtt : J t t = 2*(5/7)^2*R 0 := by
    unfold J t
    simp only [tip_integral, sub_self, zero_sub, sub_zero, R, W.meanAutocorr_even,
      W.meanAutocorr_support (s:=l) (by rwa [abs_of_pos (lt_trans W.width_pos hl)])]
    ring
  have base : J m m = ∫ s, R s * bodyCorrelation l s := (body_energy l W.integrable_meanAutocorr).2
  change J (edgeMeasure l) (edgeMeasure l) = _
  have h : J (edgeMeasure l) (edgeMeasure l) = J m (edgeMeasure l) + J t (edgeMeasure l) :=
    integral_add_measure (W.integrable_corr_average m _) (W.integrable_corr_average t _)
  rw [h, plus, plus, base, jmt, jtm, jtt]
  dsimp [R, m]
  ring

end

end MathLab.WT.AveragedTest
