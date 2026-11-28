module
public import MathLab.WT.Spectral
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! The constant auxiliary channel, Fourier synthesis, and convolution
identities for the filters in `WT.Spectral`. -/

@[expose] public section
namespace MathLab.WT.Spectral

open MeasureTheory Set Filter FourierTransform Complex
open scoped FourierTransform SchwartzMap ContDiff ComplexConjugate
noncomputable section

variable {ι : Type*} [Fintype ι]

def augmentedWeight (p : ι → ℝ) (θ : ℝ) : Option ι → ℝ
  | none => θ
  | some i => (1 - θ) * p i

def augmentedWindow (w : ι → ℝ → ℝ) : Option ι → ℝ → ℂ
  | none => fun _ => 1
  | some i => ft (w i)

omit [Fintype ι] in
lemma augmentedWeight_nonneg {p : ι → ℝ} (hp : ∀ i, 0 ≤ p i) {θ : ℝ} (hθ : θ ∈ Icc 0 1) :
    ∀ i, 0 ≤ augmentedWeight p θ i
  | none => hθ.1
  | some i => mul_nonneg (sub_nonneg.mpr hθ.2) (hp i)

lemma augmentedWeight_sum {p : ι → ℝ} (hp : ∑ i, p i = 1) (θ : ℝ) :
    ∑ i, augmentedWeight p θ i = 1 := by
  rw [Fintype.sum_option]
  simp only [augmentedWeight, ← Finset.mul_sum, hp, mul_one]; ring

omit [Fintype ι] in
lemma augmentedWindow_zero {w : ι → ℝ → ℝ} (h : ∀ i, ∫ x, w i x = 1) :
    ∀ i, augmentedWindow w i 0 = 1
  | none => rfl
  | some i => by simp [augmentedWindow, ft_zero, h i]

lemma ft_bound (f : ℝ → ℝ) (ξ : ℝ) : ‖ft f ξ‖ ≤ ∫ x, |f x| := by
  simpa only [ft, complexify, Complex.norm_real, Real.norm_eq_abs] using
    Real.norm_fourier_le_integral_norm (complexify f) ξ

/-- All filters for the smoothed input and auxiliary constant channel exist
for arbitrary real integrable compactly supported windows. -/
theorem augmented_filters_exist (p : ι → ℝ) (hp : ∀ i, 0 ≤ p i) (w : ι → ℝ → ℝ)
    (hw : ∀ i, Integrable (w i)) {R : ℝ} (hs : ∀ i x, R < ‖x‖ → w i x = 0)
    (φ : RealSchwartz) (he : ∀ x, φ (-x) = φ x) {θ : ℝ} (hθ : 0 < θ) (hθ' : θ ≤ 1) :
    Nonempty (Filters (augmentedWeight p θ) (augmentedWindow w) φ) := by
  let P := augmentedWeight p θ
  let W := augmentedWindow w
  let B : Option ι → ℝ := fun j => match j with
    | none => 1
    | some i => ∫ x, |w i x|
  have hnn := augmentedWeight_nonneg hp (show θ ∈ Icc 0 1 from ⟨hθ.le,hθ'⟩)
  have hb (j : Option ι) (x : ℝ) : ‖W j x‖ ≤ B j := by
    cases j with
    | none => simp [W, B, augmentedWindow]
    | some i => exact ft_bound (w i) x
  have lower (ξ : ℝ) : θ ≤ powerFn P W ξ := by
    rw [powerFn, power, Fintype.sum_option]
    simp only [P, W, augmentedWindow, augmentedWeight, norm_one, one_pow, mul_one]
    exact le_add_of_nonneg_right (Finset.sum_nonneg fun i _ =>
      mul_nonneg (hnn (some i)) (sq_nonneg _))
  have upper (ξ : ℝ) : powerFn P W ξ ≤ ∑ j, P j * (B j)^2 := by
    unfold powerFn power; apply Finset.sum_le_sum
    intro i _; exact mul_le_mul_of_nonneg_left
      (pow_le_pow_left₀ (norm_nonneg _) (hb i ξ) 2) (hnn i)
  refine filters_exist P W φ he ?_ ?_ (l := θ) (u := (∑ j, P j * (B j)^2) + 1) hθ ?_ ?_
  · intro j; cases j with
    | none => exact Function.HasTemperateGrowth.const _
    | some i => apply compact_fourier_temperate (complexify_integrable (hw i)) (R := R)
                intro x hx; simp [complexify, hs i x hx]
  · intro j; cases j with
    | none => intro x; simp [W, augmentedWindow]
    | some i => exact ft_hermitian (w i)
  · linarith [lower 0, upper 0]
  · rintro x ⟨ξ,rfl⟩; exact ⟨lower ξ, (upper ξ).trans (by linarith)⟩

theorem Filters.masses {p : ι → ℝ} {W : ι → ℝ → ℂ} {φ : RealSchwartz} (F : Filters p W φ)
    (hp : ∑ i, p i = 1) (hW : ∀ i, W i 0 = 1) (hφ : ∫ x, φ x = 1) :
    (∫ x, F.s x) = 1 ∧ ∀ i, (∫ x, F.k i x) = p i := by
  have hpow : powerFn p W 0 = 1 := by simp [powerFn, power, hW, hp]
  constructor
  · apply Complex.ofReal_injective
    simpa only [ft_zero, hpow, Real.sqrt_one, hφ, Complex.ofReal_one, one_mul] using F.root 0
  · intro i; apply Complex.ofReal_injective
    simpa only [ft_zero, hpow, Real.sqrt_one, hφ, hW, Complex.ofReal_one, mul_one, div_one] using F.taps i 0

/-- Fourier inversion identifies a real continuous integrable function from
a proposed Schwartz inverse, with pointwise equality at interval endpoints. -/
theorem identify {f : ℝ → ℝ} (hf : Integrable f) (hc : Continuous f) {g : RealSchwartz}
    (h : ∀ ξ, ft f ξ = ft g ξ) : f = g := by
  have hft := funext h
  have hgi : Integrable (ft g) := (𝓕 (liftReal g)).integrable
  have hfi : Integrable (ft f) := hft ▸ hgi
  have h₁ := (Complex.continuous_ofReal.comp hc).fourierInv_fourier_eq (complexify_integrable hf) hfi
  have h₂ := (Complex.continuous_ofReal.comp g.continuous).fourierInv_fourier_eq
    (complexify_integrable g.integrable) hgi
  funext x
  apply Complex.ofReal_injective
  calc
    _ = 𝓕⁻ (ft f) x := congrFun h₁.symm x
    _ = 𝓕⁻ (ft g) x := by rw [hft]
    _ = _ := congrFun h₂ x

/-- Convolution by a Schwartz function, on either side of an integrable
signed function, is continuous. -/
theorem continuous_conv_filter (g : RealSchwartz) {f : ℝ → ℝ} (hf : Integrable f) :
    Continuous (conv g f) := by
  have hbound : BddAbove (range (fun y => ‖g y‖)) :=
    ⟨SchwartzMap.seminorm ℝ 0 0 g, fun y ⟨x,hx⟩ => hx ▸ SchwartzMap.norm_le_seminorm ℝ g x⟩
  have h : Continuous (conv f g) :=
    hbound.continuous_convolution_right_of_integrable (ContinuousLinearMap.mul ℝ ℝ) hf g.continuous
  exact (funext (conv_comm g f)) ▸ h

def weighted (p : ι → ℝ) (f : ι → ℝ → ℝ) (x : ℝ) : ℝ := ∑ i, p i * f i x

theorem ft_weighted (p : ι → ℝ) {f : ι → ℝ → ℝ} (hf : ∀ i, Integrable (f i)) (ξ : ℝ) :
    ft (weighted p f) ξ = ∑ i, (p i : ℂ) * ft (f i) ξ := by
  let e (y : ℝ) := Complex.exp (↑(-2 * Real.pi * y * ξ) * Complex.I)
  have form (g : ℝ → ℝ) : ft g ξ = ∫ y, e y * (g y : ℂ) :=
    Real.fourier_real_eq_integral_exp_smul (complexify g) ξ
  have hm : Measurable e := by dsimp [e]; fun_prop
  have hn (y : ℝ) : ‖e y‖ ≤ 1 := by simp [e, Complex.norm_exp]
  have hi (i : ι) : Integrable (fun y => (p i : ℂ) * (e y * (f i y : ℂ))) :=
    ((complexify_integrable (hf i)).bdd_mul hm.aestronglyMeasurable (Eventually.of_forall hn)).const_mul _
  calc
    _ = ∫ y, ∑ i, (p i : ℂ) * (e y * (f i y : ℂ)) := by
      rw [form]; apply integral_congr_ae (Eventually.of_forall ?_)
      intro y
      simp only [weighted, Complex.ofReal_sum, Complex.ofReal_mul, Finset.mul_sum]
      apply Finset.sum_congr rfl; intro i _; ring
    _ = _ := by
      rw [integral_finsetSum Finset.univ (fun i _ => hi i)]
      simp only [integral_const_mul, ← form]

theorem weighted_integrable (p : ι → ℝ) {f : ι → ℝ → ℝ} (hf : ∀ i, Integrable (f i)) :
    Integrable (weighted p f) := integrable_finsetSum _ (fun i _ => (hf i).const_mul _)

theorem weighted_continuous (p : ι → ℝ) {f : ι → ℝ → ℝ} (hc : ∀ i, Continuous (f i)) :
    Continuous (weighted p f) := continuous_finsetSum _ (fun i _ => continuous_const.mul (hc i))

theorem ft_unique {f g : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g)
    (hfc : Continuous f) (hgc : Continuous g) (hfi : Integrable (ft f)) (h : ∀ ξ, ft f ξ = ft g ξ) :
    f = g := by
  have eq := funext h
  have hgi : Integrable (ft g) := eq ▸ hfi
  have e₁ := (Complex.continuous_ofReal.comp hfc).fourierInv_fourier_eq (complexify_integrable hf) hfi
  have e₂ := (Complex.continuous_ofReal.comp hgc).fourierInv_fourier_eq (complexify_integrable hg) hgi
  funext x; apply Complex.ofReal_injective
  calc
    _ = 𝓕⁻ (ft f) x := congrFun e₁.symm x
    _ = 𝓕⁻ (ft g) x := by rw [eq]
    _ = _ := congrFun e₂ x

theorem filter_schwartz (g : RealSchwartz) {f : ℝ → ℝ} (hf : Integrable f)
    (ht : (ft f).HasTemperateGrowth) : ∃ U : RealSchwartz, conv g f = U := by
  let h := multiplier (smoothFrequency g) (ft f)
  have spec (ξ : ℝ) : h ξ = ft f ξ * ft g ξ := multiplier_apply (smoothFrequency g) ht ξ
  have herm : Hermitian h := by intro ξ; simp [spec, ft_hermitian f ξ, ft_hermitian g ξ]
  refine ⟨realInverse h, identify (g.integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hf)
    (continuous_conv_filter g hf) ?_⟩
  intro ξ
  change ft (conv g f) ξ = ft (realInverse h) ξ
  rw [ft_conv g.integrable hf, ft_realInverse herm, spec, mul_comm]

theorem weighted_schwartz (p : ι → ℝ) (f : ι → ℝ → ℝ)
    (h : ∀ i, ∃ g : RealSchwartz, f i = g) : ∃ g : RealSchwartz, weighted p f = g := by
  choose g hg using h
  refine ⟨∑ i, p i • g i, ?_⟩; funext x
  simp [weighted, hg]

def channelApply (w : ι → ℝ → ℝ) (j : Option ι) (g : ℝ → ℝ) : ℝ → ℝ :=
  match j with
  | none => g
  | some i => conv (w i) g

def covProfile (p : ι → ℝ) (θ : ℝ) (w : ι → ℝ → ℝ) (t : Option ι → ℝ → ℝ) : ℝ → ℝ :=
  weighted (augmentedWeight p θ) (fun i => channelApply w i (t i))

def autoProfile (p : ι → ℝ) (θ : ℝ) (w : ι → ℝ → ℝ) (φ : RealSchwartz) : ℝ → ℝ :=
  fun x => θ * conv φ φ x +
    (1 - θ) * conv φ (conv φ (weighted p (fun i => conv (w i) (rev (w i))))) x

def Filters.output {p : ι → ℝ} {W : ι → ℝ → ℂ} {φ : RealSchwartz} (F : Filters p W φ)
    (t : ι → ℝ → ℝ) : ℝ → ℝ := weighted (fun _ => 1) (fun i => conv (F.k i) (t i))

theorem Filters.output_schwartz {p : ι → ℝ} {W : ι → ℝ → ℂ} {φ : RealSchwartz} (F : Filters p W φ)
    {t : ι → ℝ → ℝ} (ht : ∀ i, Integrable (t i)) (hft : ∀ i, (ft (t i)).HasTemperateGrowth) :
    ∃ u : RealSchwartz, F.output t = u :=
  weighted_schwartz _ _ (fun i => filter_schwartz (F.k i) (ht i) (hft i))

theorem Filters.output_ft {p : ι → ℝ} {W : ι → ℝ → ℂ} {φ : RealSchwartz} (F : Filters p W φ)
    {t : ι → ℝ → ℝ} (ht : ∀ i, Integrable (t i)) (ξ : ℝ) :
    ft (F.output t) ξ = cross p (fun i => W i ξ) (fun i => ft (t i) ξ) /
      (Real.sqrt (powerFn p W ξ) : ℂ) * ft φ ξ := by
  rw [Filters.output, ft_weighted (fun _ => 1) (f := fun i => conv (F.k i) (t i))
    (fun i => (F.k i).integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) (ht i))]
  simp only [Complex.ofReal_one, one_mul, ft_conv (F.k _).integrable (ht _), F.taps,
    cross, div_eq_mul_inv, Finset.sum_mul]
  apply Finset.sum_congr rfl; intro i _; ring

private theorem filter_integrable_frequency (g : RealSchwartz) : Integrable (ft g) :=
  (smoothFrequency g).integrable

private theorem integrable_ft_conv (g : RealSchwartz) {t : ℝ → ℝ} (ht : Integrable t) :
    Integrable (ft (conv g t)) := by
  rw [funext (ft_conv g.integrable ht)]
  apply (filter_integrable_frequency g).mul_bdd
  · exact (VectorFourier.fourierIntegral_continuous Real.continuous_fourierChar
      (innerSL ℝ).continuous₂ (complexify_integrable ht)).aestronglyMeasurable
  · exact Eventually.of_forall (ft_bound t)

private theorem c_integrable {f g : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g) :
    Integrable (conv f g) := hf.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hg

omit [Fintype ι] in
private theorem c_channel_integrable {w : ι → ℝ → ℝ} (hw : ∀ i, Integrable (w i))
    (j : Option ι) {g : ℝ → ℝ} (hg : Integrable g) : Integrable (channelApply w j g) := by
  cases j with
  | none => exact hg
  | some i => exact c_integrable (hw i) hg

omit [Fintype ι] in
private theorem ft_channel {w : ι → ℝ → ℝ} (hw : ∀ i, Integrable (w i))
    (j : Option ι) {g : ℝ → ℝ} (hg : Integrable g) (ξ : ℝ) :
    ft (channelApply w j g) ξ = augmentedWindow w j ξ * ft g ξ := by
  cases j with
  | none => simp [channelApply, augmentedWindow]
  | some i => exact ft_conv (hw i) hg ξ

theorem augmented_floor {p : ι → ℝ} (hp : ∀ i, 0 ≤ p i) {θ : ℝ} (hθ : 0 < θ) (hθ' : θ ≤ 1)
    (w : ι → ℝ → ℝ) (ξ : ℝ) : 0 < powerFn (augmentedWeight p θ) (augmentedWindow w) ξ := by
  rw [powerFn, power, Fintype.sum_option]
  simp only [augmentedWindow, augmentedWeight, norm_one, one_pow, mul_one]
  apply add_pos_of_pos_of_nonneg hθ
  exact Finset.sum_nonneg (fun i _ => mul_nonneg (mul_nonneg (sub_nonneg.mpr hθ') (hp i)) (sq_nonneg _))

/-- Exact identity for the compressed covering, including all real shifts. -/
theorem Filters.cov_identity {p : ι → ℝ} (hp : ∀ i, 0 ≤ p i) {θ : ℝ} (hθ : 0 < θ) (hθ' : θ ≤ 1)
    {w : ι → ℝ → ℝ} (hw : ∀ i, Integrable (w i)) {φ : RealSchwartz}
    (F : Filters (augmentedWeight p θ) (augmentedWindow w) φ)
    {t : Option ι → ℝ → ℝ} (ht : ∀ i, Integrable (t i)) :
    conv F.s (F.output t) = conv φ (conv φ (covProfile p θ w t)) := by
  have hu : Integrable (F.output t) := weighted_integrable _ (fun i => c_integrable (F.k i).integrable (ht i))
  have hcov : Integrable (covProfile p θ w t) := weighted_integrable _
    (fun i => c_channel_integrable hw i (ht i))
  have hφcov := c_integrable φ.integrable hcov
  refine ft_unique (c_integrable F.s.integrable hu) (c_integrable φ.integrable hφcov)
    (continuous_conv_filter F.s hu) (continuous_conv_filter φ hφcov) (integrable_ft_conv F.s hu) ?_
  intro ξ
  rw [ft_conv F.s.integrable hu, F.root, F.output_ft ht, ft_conv φ.integrable hφcov,
    ft_conv φ.integrable hcov, covProfile, ft_weighted _ (fun i => c_channel_integrable hw i (ht i))]
  simp only [ft_channel hw _ (ht _) ξ, cross, ← mul_assoc]
  have hne : (Real.sqrt (powerFn (augmentedWeight p θ) (augmentedWindow w) ξ) : ℂ) ≠ 0 :=
    Complex.ofReal_ne_zero.mpr (Real.sqrt_pos.2 (augmented_floor hp hθ hθ' w ξ)).ne'
  field_simp

theorem covProfile_apply (p : ι → ℝ) (θ : ℝ) (w : ι → ℝ → ℝ) (t : Option ι → ℝ → ℝ)
    (x : ℝ) : covProfile p θ w t x = θ * t none x +
      (1 - θ) * weighted p (fun i => conv (w i) (t (some i))) x := by
  simp only [covProfile, weighted, Fintype.sum_option, augmentedWeight, channelApply,
    Finset.mul_sum, mul_assoc]

theorem ft_linear_pair (a b : ℝ) {f g : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g)
    (ξ : ℝ) : ft (fun x => a * f x + b * g x) ξ = (a : ℂ) * ft f ξ + (b : ℂ) * ft g ξ := by
  let p : Bool → ℝ := fun j => if j then b else a
  let h : Bool → ℝ → ℝ := fun j => if j then g else f
  have hi (j : Bool) : Integrable (h j) := by cases j <;> assumption
  have eq : weighted p h = fun x => a * f x + b * g x := by
    funext x; simp [weighted, p, h, add_comm]
  simpa [eq, p, h, add_comm] using ft_weighted p hi ξ

/-- The square of the even, signed, compressed window is the positive
smoothing of the original *mean* autocorrelation plus the auxiliary channel. -/
theorem Filters.auto_identity {p : ι → ℝ} (hp : ∀ i, 0 ≤ p i) {θ : ℝ}
    (hθ : 0 < θ) (hθ' : θ ≤ 1) {w : ι → ℝ → ℝ} (hw : ∀ i, Integrable (w i))
    {φ : RealSchwartz} (F : Filters (augmentedWeight p θ) (augmentedWindow w) φ) :
    conv F.s F.s = autoProfile p θ w φ := by
  let A := weighted p (fun i => conv (w i) (rev (w i)))
  have hr (i : ι) : Integrable (rev (w i)) := (hw i).comp_neg
  have hi (i : ι) := c_integrable (hw i) (hr i)
  have hA : Integrable A := weighted_integrable p hi
  have hφA := c_integrable φ.integrable hA
  have hφφA := c_integrable φ.integrable hφA
  have hφφ := c_integrable φ.integrable φ.integrable
  have hauto : Integrable (autoProfile p θ w φ) := (hφφ.const_mul θ).add (hφφA.const_mul (1-θ))
  have hc : Continuous (autoProfile p θ w φ) := by
    apply Continuous.add
    · exact continuous_const.mul (continuous_conv_filter φ φ.integrable)
    · exact continuous_const.mul (continuous_conv_filter φ hφA)
  refine ft_unique (c_integrable F.s.integrable F.s.integrable) hauto
    (continuous_conv_filter F.s F.s.integrable) hc (integrable_ft_conv F.s F.s.integrable) ?_
  intro ξ
  let a := powerFn (augmentedWeight p θ) (augmentedWindow w) ξ
  have hnon : 0 ≤ a := (augmented_floor hp hθ hθ' w ξ).le
  have hs : (Real.sqrt a : ℂ) ^ 2 = (a : ℂ) := by
    rw [← Complex.ofReal_pow, Real.sq_sqrt hnon]
  have ha : (a : ℂ) = (θ : ℂ) +
      ((1-θ : ℝ) : ℂ) * ∑ i, (p i : ℂ) * (↑(‖ft (w i) ξ‖ ^ 2) : ℂ) := by
    simp only [a, powerFn, power, Fintype.sum_option, augmentedWeight, augmentedWindow,
      norm_one, one_pow, mul_one, Complex.ofReal_add, Complex.ofReal_sum, Complex.ofReal_mul,
      Finset.mul_sum, mul_assoc]
  have haf : ft A ξ = ∑ i, (p i : ℂ) * (↑(‖ft (w i) ξ‖ ^ 2) : ℂ) := by
    rw [show A = _ from rfl, ft_weighted p hi]
    apply Finset.sum_congr rfl
    intro i _
    rw [ft_conv (hw i) (hr i), ft_reverse, Complex.mul_conj, Complex.normSq_eq_norm_sq]
  rw [ft_conv F.s.integrable F.s.integrable, F.root]
  change ((Real.sqrt a : ℂ) * ft φ ξ) * ((Real.sqrt a : ℂ) * ft φ ξ) =
    ft (fun x => θ * conv φ φ x + (1 - θ) * conv φ (conv φ A) x) ξ
  rw [ft_linear_pair θ (1-θ) hφφ hφφA, ft_conv φ.integrable φ.integrable,
    ft_conv φ.integrable hφA, ft_conv φ.integrable hA, haf]
  calc
    _ = (Real.sqrt a : ℂ)^2 * ft φ ξ ^ 2 := by ring
    _ = _ := by rw [hs, ha]; ring

theorem conv_nonneg {f g : ℝ → ℝ} (hf : ∀ x, 0 ≤ f x) (hg : ∀ x, 0 ≤ g x) (x : ℝ) :
    0 ≤ conv f g x := integral_nonneg (fun y => mul_nonneg (hf y) (hg (x-y)))

theorem autoProfile_nonneg {p : ι → ℝ} {θ : ℝ} (hθ : θ ∈ Icc 0 1)
    {w : ι → ℝ → ℝ} {φ : RealSchwartz} (hφ : ∀ x, 0 ≤ φ x)
    (hA : ∀ x, 0 ≤ weighted p (fun i => conv (w i) (rev (w i))) x) (x : ℝ) :
    0 ≤ autoProfile p θ w φ x :=
  add_nonneg (mul_nonneg hθ.1 (conv_nonneg hφ hφ x))
    (mul_nonneg (sub_nonneg.mpr hθ.2) (conv_nonneg hφ (conv_nonneg hφ hA) x))

end
end MathLab.WT.Spectral
