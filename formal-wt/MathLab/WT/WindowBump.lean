module
public import MathLab.WT.WindowRepair
public import MathLab.WT.Dilation
public import Mathlib.Analysis.Calculus.BumpFunction.Normed
public import Mathlib.Analysis.Calculus.BumpFunction.InnerProduct
public import Mathlib.Analysis.Calculus.Deriv.Support
public import Mathlib.Analysis.Calculus.Deriv.CompMul
public import Mathlib.Analysis.Calculus.ContDiff.Deriv
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

@[expose] public section
namespace MathLab.WT.Window
open MeasureTheory Set Filter Function Metric
open scoped ContDiff
noncomputable section

def unitBump : ContDiffBump (0:ℝ) := ⟨3/4,1,by norm_num,by norm_num⟩
def bump (x : ℝ) : ℝ := unitBump.normed volume x
def centerHeight : ℝ := (∫ x, unitBump x)⁻¹

theorem centerHeight_pos : 0 < centerHeight := inv_pos.mpr unitBump.integral_pos
theorem bump_mass : ∫ x, bump x = 1 := unitBump.integral_normed
theorem bump_even (x : ℝ) : bump (-x) = bump x := unitBump.normed_neg _
theorem bump_nonneg (x : ℝ) : 0 ≤ bump x := unitBump.nonneg_normed _
theorem bump_compact : HasCompactSupport bump := unitBump.hasCompactSupport_normed
theorem bump_cont : Continuous bump := unitBump.continuous_normed
theorem bump_smooth : ContDiff ℝ ∞ bump := unitBump.contDiff_normed
theorem bump_bound (x : ℝ) : bump x ≤ centerHeight := by
  change unitBump x / (∫ y, unitBump y) ≤ _
  rw [div_eq_mul_inv]
  exact mul_le_of_le_one_left centerHeight_pos.le unitBump.le_one
theorem bump_plateau (x : ℝ) (hx : |x| ≤ 3/4) : bump x = centerHeight := by
  have h : x∈closedBall (0:ℝ) unitBump.rIn := by simpa [unitBump,Real.dist_eq] using hx
  rw [bump,ContDiffBump.normed_def,unitBump.one_of_mem_closedBall h,one_div]
  rfl
theorem bump_out (x : ℝ) (hx : 1 < |x|) : bump x=0 := by
  have h : unitBump.rOut ≤ dist x 0 := by simpa [unitBump,Real.dist_eq] using hx.le
  simp [bump,ContDiffBump.normed_def,unitBump.zero_of_le_dist h]

theorem compact_of_zero_outside {f : ℝ → ℝ} {R : ℝ} (h : ∀ x, R < |x| → f x=0) :
    HasCompactSupport f :=
  HasCompactSupport.intro isCompact_Icc fun x (hx : x∉Icc (-R) R) =>
    h x (by by_contra hn; exact hx (abs_le.mp (le_of_not_gt hn)))

def wide (R : ℝ) (x : ℝ) : ℝ := R⁻¹ * bump (R⁻¹*x)

theorem wide_cont (R : ℝ) : Continuous (wide R) :=
  continuous_const.mul (bump_cont.comp (continuous_const.mul continuous_id))
theorem wide_mass {R : ℝ} (hR : 0<R) : ∫ x, wide R x = 1 := by
  change (∫ x, scaleFun R⁻¹ R⁻¹ bump x) = 1
  rw [integral_scaleFun _ _ (inv_pos.mpr hR), div_self (inv_ne_zero hR.ne'), bump_mass, one_mul]
theorem wide_even (R x : ℝ) : wide R (-x) = wide R x := by simp [wide,bump_even]
theorem wide_nonneg {R : ℝ} (hR : 0<R) (x : ℝ) : 0 ≤ wide R x :=
  mul_nonneg (inv_nonneg.mpr hR.le) (bump_nonneg _)
theorem wide_out {R : ℝ} (hR : 0<R) (x : ℝ) (hx : R < |x|) : wide R x=0 := by
  have h : 1 < |R⁻¹*x| := by
    rw [abs_mul, abs_of_pos (inv_pos.mpr hR), ← div_eq_inv_mul, lt_div_iff₀ hR, one_mul]
    exact hx
  simp [wide,bump_out _ h]
theorem wide_compact {R : ℝ} (hR : 0<R) : HasCompactSupport (wide R) :=
  compact_of_zero_outside (wide_out hR)

theorem wide_diff (R : ℝ) : Differentiable ℝ (wide R) := by
  have h := bump_smooth.differentiable (by norm_num)
  unfold wide
  fun_prop
theorem dwide (R : ℝ) :
    deriv (wide R) = fun x => R⁻¹^2 * deriv bump (R⁻¹*x) := by
  funext x
  change deriv (fun z => R⁻¹*bump (R⁻¹*z)) x = _
  rw [deriv_const_mul_field,deriv_comp_mul_left, smul_eq_mul]
  ring
theorem wide_diff' (R : ℝ) : Differentiable ℝ (deriv (wide R)) := by
  rw [dwide]
  have h := (contDiff_infty_iff_deriv.mp bump_smooth).2.differentiable (by norm_num)
  fun_prop
theorem dwide2 (R x : ℝ) :
    deriv (deriv (wide R)) x = R⁻¹^3 * deriv (deriv bump) (R⁻¹*x) := by
  simp only [dwide,deriv_const_mul_field,deriv_comp_mul_left, smul_eq_mul]
  ring

theorem derivative_bound : ∃ D : ℝ, 0≤D ∧
    ∀ R, 0<R → ∀ x, ‖deriv (deriv (wide R)) x‖ ≤ D/R^3 := by
  have hc : Continuous (deriv (deriv bump)) :=
    (contDiff_infty_iff_deriv.mp (contDiff_infty_iff_deriv.mp bump_smooth).2).2.continuous
  obtain ⟨D,hd⟩ := hc.bounded_above_of_compact_support bump_compact.deriv.deriv
  refine ⟨D, (norm_nonneg _).trans (hd 0), ?_⟩
  intro R hR x
  rw [dwide2, norm_mul, Real.norm_eq_abs, abs_of_nonneg (by positivity : 0≤R⁻¹^3)]
  calc
    _ ≤ R⁻¹^3 * D := mul_le_mul_of_nonneg_left (hd _) (by positivity)
    _ = _ := by rw [inv_pow, div_eq_inv_mul]

/-- Both factors are constant on an interval of length R/4 about x/2. -/
theorem wide_self_lower {R x : ℝ} (hR : 0<R) (hx : |x| ≤ 5*R/4) :
    (centerHeight^2/4)/R ≤ conv (wide R) (wide R) x := by
  let S := Icc (x/2-R/8) (x/2+R/8)
  have hp (z : ℝ) (hz : |z| ≤ 3*R/4) : wide R z = R⁻¹*centerHeight := by
    unfold wide
    rw [bump_plateau]
    rw [abs_mul, abs_of_pos (inv_pos.mpr hR), ← div_eq_inv_mul, div_le_iff₀ hR]
    linarith
  have atS (z : ℝ) (hz : z∈S) : wide R z*wide R (x-z) = (R⁻¹*centerHeight)^2 := by
    obtain ⟨h₁,h₂⟩ := abs_le.mp hx
    rw [hp z (abs_le.mpr ⟨by linarith [hz.1],by linarith [hz.2]⟩),
      hp (x-z) (abs_le.mpr ⟨by linarith [hz.1,hz.2],by linarith [hz.1,hz.2]⟩), sq]
  have hi : Integrable (fun y => wide R y * wide R (x-y)) :=
    ((wide_cont R).mul ((wide_cont R).comp (continuous_const.sub continuous_id))).integrable_of_hasCompactSupport
    (wide_compact hR).mul_right
  calc
    _ = ∫ z, S.indicator (fun _ => (R⁻¹*centerHeight)^2) z := by
      rw [integral_indicator_const _ measurableSet_Icc]
      simp only [Measure.real,Real.volume_Icc,smul_eq_mul]
      rw [ENNReal.toReal_ofReal (by linarith : 0 ≤ x/2+R/8-(x/2-R/8))]
      field_simp; ring
    _ ≤ _ := by
      apply integral_mono ((integrable_indicator_iff measurableSet_Icc).mpr
        (integrableOn_const isCompact_Icc.measure_ne_top)) hi
      intro z
      change S.indicator (fun _ => (R⁻¹*centerHeight)^2) z ≤ wide R z*wide R (x-z)
      by_cases hz : z∈S
      · rw [indicator_of_mem hz, atS z hz]
      · rw [indicator_of_notMem hz]
        exact mul_nonneg (wide_nonneg hR _) (wide_nonneg hR _)

end
end MathLab.WT.Window
