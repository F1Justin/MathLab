module
public import MathLab.WT.ContinuousRepair
public import Mathlib.Analysis.Fourier.Convolution
public import Mathlib.Analysis.Fourier.LpSpace
public import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Scalar compression of a finite complex spectrum. The floor can be
obtained by appending a constant frequency channel before smoothing. We use
the Fourier convention of mathlib, with exponential `exp (-2πi x ξ)`. -/

@[expose] public section
namespace MathLab.WT.Spectral

open MeasureTheory Set Filter FourierTransform Complex
open scoped FourierTransform SchwartzMap ContDiff ComplexConjugate
noncomputable section

variable {ι : Type*} [Fintype ι]

def power (p : ι → ℝ) (z : ι → ℂ) : ℝ := ∑ i, p i * ‖z i‖ ^ 2

def cross (p : ι → ℝ) (z t : ι → ℂ) : ℂ := ∑ i, (p i : ℂ) * z i * t i

theorem power_nonneg (p : ι → ℝ) (hp : ∀ i, 0 ≤ p i) (z : ι → ℂ) : 0 ≤ power p z :=
  Finset.sum_nonneg fun i _ => mul_nonneg (hp i) (sq_nonneg _)

/-- Weighted scalar Cauchy--Schwarz, for convolution rather than Hermitian
pairing: the second frequency vector is not conjugated. -/
theorem cross_sq_le (p : ι → ℝ) (hp : ∀ i, 0 ≤ p i) (z t : ι → ℂ) :
    ‖cross p z t‖ ^ 2 ≤ power p z * power p t := by
  have h : ‖cross p z t‖ ≤ ∑ i, (p i * ‖z i‖ * ‖t i‖) := by
    calc
      _ ≤ ∑ i, ‖(p i : ℂ) * z i * t i‖ := norm_sum_le _ _
      _ = _ := by simp [abs_of_nonneg (hp _)]
  apply (pow_le_pow_left₀ (norm_nonneg _) h 2).trans
  unfold power
  apply Finset.sum_sq_le_sum_mul_sum_of_sq_le_mul Finset.univ (r := fun i => p i * ‖z i‖ * ‖t i‖)
    (f := fun i => p i * ‖z i‖ ^ 2) (g := fun i => p i * ‖t i‖ ^ 2)
  · intro i _; exact mul_nonneg (hp i) (sq_nonneg _)
  · intro i _; exact mul_nonneg (hp i) (sq_nonneg _)
  · intro i _; apply le_of_eq; ring

theorem projected_energy_le (p : ι → ℝ) (hp : ∀ i, 0 ≤ p i) (z t : ι → ℂ)
    (ha : 0 < power p z) : ‖cross p z t / (Real.sqrt (power p z) : ℂ)‖ ^ 2 ≤ power p t := by
  rw [norm_div, div_pow, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (Real.sqrt_nonneg _), Real.sq_sqrt ha.le, div_le_iff₀ ha, mul_comm]
  exact cross_sq_le p hp z t

/-- A smooth function on a compact interval composes to a temperate
multiplier whenever the inner temperate function takes its values there. -/
theorem temperate_compact_range {f g : ℝ → ℝ} {l u : ℝ} (hlu : l < u)
    (hf : f.HasTemperateGrowth) (hr : Set.range f ⊆ Icc l u)
    (hg : ContDiffOn ℝ ∞ g (Icc l u)) : (g ∘ f).HasTemperateGrowth := by
  have hu := uniqueDiffOn_Icc hlu
  apply hf.comp' hr hu hg
  intro N
  have hb (n : ℕ) : ∃ C : ℝ, 0 ≤ C ∧ ∀ x ∈ Icc l u,
      ‖iteratedFDerivWithin ℝ n g (Icc l u) x‖ ≤ C := by
    have hc := (hg.continuousOn_iteratedFDerivWithin (m := n) (by exact_mod_cast le_top) hu).norm
    obtain ⟨b, h⟩ := isCompact_Icc.bddAbove_image hc
    exact ⟨max b 0, le_max_right _ _, fun x hx => (h ⟨x, hx, rfl⟩).trans (le_max_left _ _)⟩
  choose C hC bound using hb
  refine ⟨0, ∑ i ∈ Finset.range (N+1), C i, Finset.sum_nonneg (fun i _ => hC _), ?_⟩
  intro n hn x hx
  simp only [pow_zero, mul_one]
  exact (bound n x hx).trans (Finset.single_le_sum (fun i _ => hC i) (Finset.mem_range.mpr (by omega)))

/-- The reciprocal square root and square root used in the scalar filters
have temperate growth for a bounded temperate power spectrum with a floor. -/
theorem temperate_roots {a : ℝ → ℝ} {l u : ℝ} (hl : 0 < l) (hlu : l < u)
    (ha : a.HasTemperateGrowth) (hr : Set.range a ⊆ Icc l u) :
    (fun x => Real.sqrt (a x)).HasTemperateGrowth ∧
    (fun x => (Real.sqrt (a x))⁻¹).HasTemperateGrowth := by
  have hpos (x : ℝ) (hx : x ∈ Icc l u) : 0 < x := hl.trans_le hx.1
  have hs : ContDiffOn ℝ ∞ Real.sqrt (Icc l u) :=
    fun x hx => (Real.contDiffAt_sqrt (hpos _ hx).ne').contDiffWithinAt
  have hi : ContDiffOn ℝ ∞ (fun x => (Real.sqrt x)⁻¹) (Icc l u) :=
    hs.inv (fun x hx => (Real.sqrt_pos.2 (hpos x hx)).ne')
  exact ⟨temperate_compact_range (f := a) (g := Real.sqrt) hlu ha hr hs,
    temperate_compact_range (f := a) (g := fun x => (Real.sqrt x)⁻¹) hlu ha hr hi⟩

/-- An integrable compactly supported input need not itself be smooth. All
derivatives of its Fourier transform are bounded. -/
theorem compact_fourier_temperate {f : ℝ → ℂ} (hf : Integrable f) {R : ℝ}
    (hs : ∀ x, R < ‖x‖ → f x = 0) : (𝓕 f).HasTemperateGrowth := by
  have hm (n : ℕ) : Integrable (fun x : ℝ => ‖x‖ ^ n * ‖f x‖) := by
    apply (hf.norm.const_mul (R^n)).mono' (by fun_prop)
    apply Eventually.of_forall
    intro x; by_cases hx : ‖x‖ ≤ R
    · rw [Real.norm_of_nonneg (mul_nonneg (pow_nonneg (norm_nonneg _) _) (norm_nonneg _))]
      exact mul_le_mul_of_nonneg_right (pow_le_pow_left₀ (norm_nonneg _) hx n) (norm_nonneg _)
    · simp [hs x (lt_of_not_ge hx)]
  refine ⟨Real.contDiff_fourier (fun n _ => hm n), ?_⟩
  intro n
  let k := fun v : ℝ => VectorFourier.fourierPowSMulRight (innerSL ℝ) f v n
  refine ⟨0, ∫ x, ‖k x‖, ?_⟩
  intro x
  rw [Real.iteratedFDeriv_fourier (N := ⊤) (fun n _ => hm n) hf.aestronglyMeasurable (by simp)]
  simpa only [pow_zero, mul_one] using Real.norm_fourier_le_integral_norm k x

def powerFn (p : ι → ℝ) (W : ι → ℝ → ℂ) (x : ℝ) : ℝ := power p (fun i => W i x)

theorem powerFn_temperate (p : ι → ℝ) (W : ι → ℝ → ℂ)
    (hW : ∀ i, (W i).HasTemperateGrowth) : (powerFn p W).HasTemperateGrowth := by
  unfold powerFn power
  simp only [Complex.sq_norm, Complex.normSq_apply]
  apply Function.HasTemperateGrowth.sum
  intro i _
  have hr := Complex.hasTemperateGrowth_re.comp (hW i)
  have hi := Complex.hasTemperateGrowth_im.comp (hW i)
  exact (Function.HasTemperateGrowth.const (p i)).mul ((hr.mul hr).add (hi.mul hi))

def complexify (f : ℝ → ℝ) : ℝ → ℂ := fun x => (f x : ℂ)

def ft (f : ℝ → ℝ) : ℝ → ℂ := 𝓕 (complexify f)

theorem complexify_integrable {f : ℝ → ℝ} (hf : Integrable f) : Integrable (complexify f) :=
  Complex.ofRealCLM.integrable_comp hf

theorem ft_zero (f : ℝ → ℝ) : ft f 0 = Complex.ofReal (∫ x, f x) := by
  simp only [ft, complexify, Real.fourier_real_eq, mul_zero, neg_zero, AddChar.map_zero_eq_one,
    one_smul]
  exact integral_ofReal

def Hermitian (h : ℝ → ℂ) : Prop := ∀ x, h (-x) = conj (h x)

theorem fourier_conj_reflect (f : ℝ → ℂ) (ξ : ℝ) :
    𝓕 (fun y => conj (f y)) (-ξ) = conj (𝓕 f ξ) := by
  simp only [Real.fourier_real_eq_integral_exp_smul, smul_eq_mul, ← integral_conj]
  apply integral_congr_ae (Eventually.of_forall ?_)
  intro y
  have htwo : (starRingEnd ℂ) (2 : ℂ) = (2 : ℂ) := by
    change conj ((2 : ℝ) : ℂ) = ((2 : ℝ) : ℂ)
    exact Complex.conj_ofReal _
  simp [← Complex.exp_conj, mul_assoc, htwo]

theorem fourier_reflect (f : ℝ → ℂ) (x : ℝ) :
    𝓕 (fun y => f (-y)) x = 𝓕 f (-x) :=
  Real.fourier_comp_linearIsometry (LinearIsometryEquiv.neg ℝ) f x

theorem ft_hermitian (f : ℝ → ℝ) : Hermitian (ft f) := by
  intro x
  have hc : (fun y => conj (complexify f y)) = complexify f := by funext y; simp [complexify]
  simpa only [hc, ft] using fourier_conj_reflect (complexify f) x

theorem ft_reverse (f : ℝ → ℝ) (x : ℝ) : ft (rev f) x = conj (ft f x) := by
  calc
    _ = ft f (-x) := Real.fourier_comp_linearIsometry (LinearIsometryEquiv.neg ℝ) (complexify f) x
    _ = _ := ft_hermitian f x

theorem ft_even {f : ℝ → ℝ} (he : ∀ x, f (-x) = f x) (x : ℝ) : ft f (-x) = ft f x := by
  have h : (fun y => complexify f (-y)) = complexify f := by funext y; simp [complexify, he]
  exact (fourier_reflect (complexify f) x).symm.trans (congrArg (fun j : ℝ → ℂ => 𝓕 j x) h)

theorem ft_conv {f g : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g) (ξ : ℝ) :
    ft (conv f g) ξ = ft f ξ * ft g ξ := by
  have h : complexify (conv f g) = MeasureTheory.convolution (complexify f) (complexify g)
      (ContinuousLinearMap.mul ℂ ℂ) volume := by
    funext x
    simp only [complexify, conv, MeasureTheory.convolution_def, ContinuousLinearMap.mul_apply',
      ← Complex.ofReal_mul]
    exact integral_ofReal.symm
  rw [ft, h, Real.fourier_mul_convolution_eq (complexify_integrable hf) (complexify_integrable hg)]
  rfl

theorem spectrum_even (p : ι → ℝ) (W : ι → ℝ → ℂ) (h : ∀ i, Hermitian (W i)) (x : ℝ) :
    powerFn p W (-x) = powerFn p W x := by simp [powerFn, power, h _ x]

abbrev RealSchwartz := 𝓢(ℝ, ℝ)
abbrev ComplexSchwartz := 𝓢(ℝ, ℂ)

def liftReal (φ : RealSchwartz) : ComplexSchwartz := φ.postcompCLM Complex.ofRealCLM

lemma liftReal_apply (φ : RealSchwartz) (x : ℝ) : liftReal φ x = (φ x : ℂ) := rfl

/-- The inverse Fourier transform of Hermitian Schwartz data is real at
every point. Taking its real part therefore loses no information. -/
def realInverse (h : ComplexSchwartz) : RealSchwartz := (𝓕⁻ h).postcompCLM Complex.reCLM

theorem realInverse_spec {h : ComplexSchwartz} (hh : Hermitian h) :
    complexify (realInverse h) = (𝓕⁻ h : ComplexSchwartz) := by
  funext x
  have he : conj (𝓕⁻ (h : ℝ → ℂ) x) = 𝓕⁻ (h : ℝ → ℂ) x := by
    rw [Real.fourierInv_eq_fourier_neg]
    have hf : (fun y => conj (h y)) = fun y => h (-y) := funext fun y => (hh y).symm
    simpa only [neg_neg, hf] using
      ((fourier_conj_reflect (h : ℝ → ℂ) (-x)).symm.trans (by simpa only [neg_neg, hf] using fourier_reflect (h : ℝ → ℂ) x))
  change ((𝓕⁻ h x).re : ℂ) = 𝓕⁻ h x
  rw [SchwartzMap.fourierInv_coe]
  exact Complex.conj_eq_iff_re.mp he

theorem ft_realInverse {h : ComplexSchwartz} (hh : Hermitian h) (x : ℝ) :
    ft (realInverse h) x = h x := by
  rw [ft, realInverse_spec hh]
  change (𝓕 (𝓕⁻ h) : ComplexSchwartz) x = h x
  rw [fourier_fourierInv_eq]

theorem realInverse_even {h : ComplexSchwartz} (he : ∀ x, h (-x) = h x) (x : ℝ) :
    realInverse h (-x) = realInverse h x := by
  change (𝓕⁻ h (-x)).re = (𝓕⁻ h x).re
  rw [SchwartzMap.fourierInv_coe]
  have eq : 𝓕⁻ (fun y => h (-y)) x = 𝓕⁻ (h : ℝ → ℂ) (-x) :=
    Real.fourierInv_comp_linearIsometry (LinearIsometryEquiv.neg ℝ) (h : ℝ → ℂ) x
  rw [show (fun y => h (-y)) = (h : ℝ → ℂ) by funext y; exact he y] at eq
  exact congrArg Complex.re eq.symm

def multiplier (χ : ComplexSchwartz) (m : ℝ → ℂ) : ComplexSchwartz :=
  SchwartzMap.smulLeftCLM ℂ m χ

lemma multiplier_apply (χ : ComplexSchwartz) {m : ℝ → ℂ} (hm : m.HasTemperateGrowth) (x : ℝ) :
    multiplier χ m x = m x * χ x := SchwartzMap.smulLeftCLM_apply_apply hm χ x

def smoothFrequency (φ : RealSchwartz) : ComplexSchwartz := 𝓕 (liftReal φ)

lemma smoothFrequency_apply (φ : RealSchwartz) (x : ℝ) : smoothFrequency φ x = ft φ x := rfl

/-- A real Schwartz window and real Schwartz scalar filters determined by the
input spectra and a fixed mollifier. -/
structure Filters (p : ι → ℝ) (W : ι → ℝ → ℂ) (φ : RealSchwartz) where
  s : RealSchwartz
  k : ι → RealSchwartz
  even_s : ∀ x, s (-x) = s x
  root : ∀ x, ft s x = (Real.sqrt (powerFn p W x) : ℂ) * ft φ x
  taps : ∀ i x, ft (k i) x = (p i : ℂ) * W i x / (Real.sqrt (powerFn p W x) : ℂ) * ft φ x

theorem filters_exist (p : ι → ℝ) (W : ι → ℝ → ℂ) (φ : RealSchwartz)
    (hφ : ∀ x, φ (-x) = φ x) (hW : ∀ i, (W i).HasTemperateGrowth)
    (hsym : ∀ i, Hermitian (W i)) {l u : ℝ} (hl : 0 < l) (hlu : l < u)
    (hr : Set.range (powerFn p W) ⊆ Icc l u) : Nonempty (Filters p W φ) := by
  let a := powerFn p W
  let χ := smoothFrequency φ
  obtain ⟨hs, hi⟩ := temperate_roots hl hlu (powerFn_temperate p W hW) hr
  let S := multiplier χ (fun x => (Real.sqrt (a x) : ℂ))
  let K (i : ι) := multiplier χ (fun x => (p i : ℂ) * W i x * ((Real.sqrt (a x))⁻¹ : ℝ))
  have Sspec (x : ℝ) : S x = (Real.sqrt (a x) : ℂ) * ft φ x := by
    exact multiplier_apply χ (Complex.hasTemperateGrowth_ofReal.comp hs) x
  have Kspec (i : ι) (x : ℝ) : K i x = (p i : ℂ) * W i x / (Real.sqrt (a x) : ℂ) * ft φ x := by
    have hm := ((Function.HasTemperateGrowth.const (p i : ℂ)).mul (hW i)).mul
      (Complex.hasTemperateGrowth_ofReal.comp hi)
    have hm' : (fun z => (p i : ℂ) * W i z * ((Real.sqrt (a z))⁻¹ : ℝ)).HasTemperateGrowth := by
      simpa only [Function.comp_def, Pi.mul_def] using hm
    rw [show K i x = _ from multiplier_apply χ hm' x, smoothFrequency_apply]
    simp [div_eq_mul_inv]
  have ae (x : ℝ) : a (-x) = a x := spectrum_even p W hsym x
  have sh : Hermitian S := by intro x; simp [Sspec, ae, ft_hermitian φ x]
  have kh (i : ι) : Hermitian (K i) := by
    intro x; simp [Kspec, ae, ft_hermitian φ x, hsym i x]
  refine ⟨⟨realInverse S, fun i => realInverse (K i), ?_, ?_, ?_⟩⟩
  · exact realInverse_even (fun x => by simp [Sspec, ae, ft_even hφ])
  · intro x; exact (ft_realInverse sh x).trans (Sspec x)
  · intro i x; exact (ft_realInverse (kh i) x).trans (Kspec i x)

end
end MathLab.WT.Spectral
