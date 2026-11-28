module
public import MathLab.WT.Compression
public import MathLab.WT.Extension
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Plancherel and the two WT energy budgets after scalar spectral compression. -/
@[expose] public section
namespace MathLab.WT.Spectral

open MeasureTheory Set Filter FourierTransform
open scoped FourierTransform SchwartzMap
noncomputable section

/-- Jensen's inequality for the square, retaining the pointwise choice of
representative in the definition of convolution. -/
theorem smooth_square_le {φ f : ℝ → ℝ} (hφ : Integrable φ) (hn : ∀ x, 0 ≤ φ x)
    (hm : ∫ x, φ x = 1) (hf : Regular f) (x : ℝ) :
    (conv φ f x)^2 ≤ conv φ (fun z => f z ^ 2) x := by
  obtain ⟨B,hB⟩ := hf.2
  let m := conv φ f x
  have hz := hf.1.comp_sub_left x
  have hi : Integrable (fun y => φ y * f (x-y)) := hφ.mul_bdd hz.aestronglyMeasurable
    (Eventually.of_forall fun y => hB (x-y))
  have hi₂ : Integrable (fun y => φ y * (f (x-y))^2) := by
    apply hφ.mul_bdd (hz.aestronglyMeasurable.pow 2)
    apply Eventually.of_forall
    intro y
    change |f (x-y)^2| ≤ B^2
    rw [abs_pow]
    exact pow_le_pow_left₀ (abs_nonneg _) (hB _) _
  have h := integral_mono (((hi.const_mul (2*m)).sub (hφ.const_mul (m^2)))) hi₂ (fun y => by
    change 2*m*(φ y*f (x-y))-m^2*φ y ≤ φ y*f (x-y)^2
    nlinarith only [mul_nonneg (hn y) (sq_nonneg (f (x-y)-m))])
  change (∫y, 2*m*(φ y*f (x-y))-m^2*φ y) ≤ _ at h
  rw [integral_sub (hi.const_mul _) (hφ.const_mul _), integral_const_mul, integral_const_mul, hm] at h
  change 2*m*m-m^2*1 ≤ conv φ (fun z => f z^2) x at h
  change m^2 ≤ _
  linarith

theorem smooth_energy_le {φ f : ℝ → ℝ} (hφ : Integrable φ) (hn : ∀ x, 0 ≤ φ x)
    (hm : ∫ x, φ x = 1) (hf : Regular f) : energy (conv φ f) ≤ energy f := by
  have hd : Integrable (conv φ (fun x => f x^2)) :=
    hφ.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hf.integrable_square
  have hc : Integrable (conv φ f) :=
    hφ.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hf.1
  have hs : Integrable (fun x => (conv φ f x)^2) := by
    apply hd.mono' (hc.aestronglyMeasurable.pow 2)
    apply Eventually.of_forall
    intro x
    rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
    exact smooth_square_le hφ hn hm hf x
  exact (integral_mono hs hd (smooth_square_le hφ hn hm hf)).trans_eq (by
    rw [conv_mass hφ hf.integrable_square, hm, one_mul]; rfl)

/-- Scalar Plancherel with exactly the real energy used in the WT definition. -/
theorem schwartz_plancherel (f : RealSchwartz) : (∫ ξ, ‖ft f ξ‖^2) = energy f := by
  have h := SchwartzMap.integral_norm_sq_fourier (liftReal f)
  change (∫ ξ, ‖ft f ξ‖^2) = ∫ x, ‖liftReal f x‖^2 at h
  simpa only [liftReal_apply, Complex.norm_real, Real.norm_eq_abs, sq_abs, energy] using h

theorem integrable_schwartz_spectral_energy (f : RealSchwartz) :
    Integrable (fun x => ‖ft f x‖^2) := by
  let g := smoothFrequency f
  have hr : Regular (fun x => ‖g x‖) :=
    ⟨g.integrable.norm, SchwartzMap.seminorm ℝ 0 0 g, fun x => by
      rw [abs_of_nonneg (norm_nonneg _)]; exact SchwartzMap.norm_le_seminorm ℝ g x⟩
  exact hr.integrable_square

theorem compact_ft_temperate {f : ℝ → ℝ} (hf : Integrable f) {r : ℝ}
    (hs : ∀ x, r < ‖x‖ → f x = 0) : (ft f).HasTemperateGrowth := by
  apply compact_fourier_temperate (complexify_integrable hf) (R:=r)
  intro x hx
  simp [complexify, hs x hx]

variable {ι : Type*} [Fintype ι]

theorem Filters.table_energy_smoothed {p : ι → ℝ} (hp : ∀ i, 0 ≤ p i)
    {W : ι → ℝ → ℂ} {φ : RealSchwartz} (F : Filters p W φ)
    (hfloor : ∀ ξ, 0 < powerFn p W ξ) {t : ι → ℝ → ℝ} (ht : ∀ i, Integrable (t i))
    (hft : ∀ i, (ft (t i)).HasTemperateGrowth) :
    energy (F.output t) ≤ ∑ i, p i * energy (conv φ (t i)) := by
  obtain ⟨u, hu⟩ := F.output_schwartz ht hft
  choose g hg using fun i => filter_schwartz φ (ht i) (hft i)
  have spec (ξ : ℝ) : ft u ξ = cross p (fun i => W i ξ) (fun i => ft (g i) ξ) /
      (Real.sqrt (powerFn p W ξ) : ℂ) := by
    rw [← hu, F.output_ft ht, cross, cross, div_eq_mul_inv, div_eq_mul_inv, Finset.sum_mul,
      Finset.sum_mul]
    simp_rw [← hg, ft_conv φ.integrable (ht _) ξ]
    simp only [Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro i _
    ring
  have pos (ξ : ℝ) : ‖ft u ξ‖ ^ 2 ≤ ∑ i, p i * ‖ft (g i) ξ‖^2 := by
    rw [spec]
    exact projected_energy_le p hp _ _ (hfloor ξ)
  have hints (i : ι) := (integrable_schwartz_spectral_energy (g i)).const_mul (p i)
  have h := integral_mono (integrable_schwartz_spectral_energy u)
    (integrable_finsetSum Finset.univ (fun i _ => hints i)) pos
  rw [schwartz_plancherel, integral_finsetSum Finset.univ (fun i _ => hints i)] at h
  simp only [integral_const_mul, schwartz_plancherel] at h
  simpa only [hu, hg] using h

theorem Filters.table_energy {p : ι → ℝ} (hp : ∀ i, 0 ≤ p i)
    {W : ι → ℝ → ℂ} {φ : RealSchwartz} (F : Filters p W φ)
    (hfloor : ∀ ξ, 0 < powerFn p W ξ) (hn : ∀ x, 0 ≤ φ x) (hm : ∫ x, φ x = 1)
    {t : ι → ℝ → ℝ} (ht : ∀ i, Regular (t i)) {r : ℝ}
    (hs : ∀ i x, r < ‖x‖ → t i x = 0) :
    energy (F.output t) ≤ ∑ i, p i * energy (t i) := by
  refine (F.table_energy_smoothed hp hfloor (fun i => (ht i).1)
    (fun i => compact_ft_temperate (ht i).1 (hs i))).trans ?_
  apply Finset.sum_le_sum
  intro i _
  exact mul_le_mul_of_nonneg_left (smooth_energy_le φ.integrable hn hm (ht i)) (hp i)

theorem Filters.window_energy_smoothed {p : ι → ℝ} (hp : ∀ i, 0 ≤ p i) {θ : ℝ}
    (hθ : θ ∈ Icc 0 1) {w : ι → ℝ → ℝ} (hw : ∀ i, Integrable (w i))
    (hft : ∀ i, (ft (w i)).HasTemperateGrowth) {φ : RealSchwartz}
    (F : Filters (augmentedWeight p θ) (augmentedWindow w) φ) :
    energy F.s = θ*energy φ + (1-θ)* ∑ i, p i * energy (conv φ (w i)) := by
  choose g hg using fun i => filter_schwartz φ (hw i) (hft i)
  have nonneg := augmentedWeight_nonneg hp hθ
  have spec (ξ : ℝ) : ‖ft F.s ξ‖^2 = θ*‖ft φ ξ‖^2 +
      (1-θ)* ∑ i, p i * ‖ft (g i) ξ‖^2 := by
    rw [F.root, norm_mul, mul_pow, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg (Real.sqrt_nonneg _), powerFn,
      Real.sq_sqrt (power_nonneg _ nonneg _), power, Fintype.sum_option]
    simp only [augmentedWeight, augmentedWindow, norm_one, one_pow, mul_one, ← hg,
      ft_conv φ.integrable (hw _) ξ, norm_mul, mul_pow, Finset.mul_sum, add_mul, Finset.sum_mul]
    congr 1
    apply Finset.sum_congr rfl
    intro i _
    ring
  rw [← schwartz_plancherel F.s]
  simp_rw [spec]
  have hi (i : ι) := (integrable_schwartz_spectral_energy (g i)).const_mul (p i)
  rw [integral_add ((integrable_schwartz_spectral_energy φ).const_mul θ)
    ((integrable_finsetSum Finset.univ (fun i _ => hi i)).const_mul (1-θ)),
    integral_const_mul, integral_const_mul, integral_finsetSum Finset.univ (fun i _ => hi i)]
  simp only [integral_const_mul, schwartz_plancherel, hg]

theorem Filters.window_energy {p : ι → ℝ} (hp : ∀ i, 0 ≤ p i) {θ : ℝ}
    (hθ : θ ∈ Icc 0 1) {w : ι → ℝ → ℝ} (hw : ∀ i, Regular (w i))
    {r : ℝ} (hs : ∀ i x, r < ‖x‖ → w i x = 0) {φ : RealSchwartz}
    (F : Filters (augmentedWeight p θ) (augmentedWindow w) φ)
    (hn : ∀ x, 0 ≤ φ x) (hm : ∫ x, φ x = 1) :
    energy F.s ≤ θ*energy φ + (1-θ)* ∑ i, p i * energy (w i) := by
  rw [F.window_energy_smoothed hp hθ (fun i => (hw i).1)
    (fun i => compact_ft_temperate (hw i).1 (hs i))]
  apply add_le_add_right
  apply mul_le_mul_of_nonneg_left _ (sub_nonneg.mpr hθ.2)
  apply Finset.sum_le_sum
  intro i _
  exact mul_le_mul_of_nonneg_left (smooth_energy_le φ.integrable hn hm (hw i)) (hp i)

end
end MathLab.WT.Spectral
