module
public import MathLab.WT.Profiles
public import MathLab.WT.LowerBoundDual
public import MathLab.WT.WindowRepair
import Mathlib.Tactic.Linarith

/-! Approximation of the mixed input autocorrelation in sup norm and L¹ by
the actual smooth signed Fourier root, before compactification. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set Filter Spectral
noncomputable section

theorem integral_abs_le_of_support {f : ℝ → ℝ} {S e : ℝ} (hS : 0 ≤ S)
    (hf : ∀ x, S < |x| → f x=0) (h : ∀ x, |f x| ≤ e) :
    (∫ x, |f x|) ≤ (2*S)*e := by
  let b := (Icc (-S) S).indicator (fun _ : ℝ => e)
  have hi : Integrable b := (integrable_indicator_iff measurableSet_Icc).mpr
    (integrableOn_const isCompact_Icc.measure_ne_top)
  calc
    _ ≤ ∫ x, b x := by
      apply integral_mono_of_nonneg (Eventually.of_forall fun x => abs_nonneg _) hi (Eventually.of_forall ?_)
      intro x
      by_cases hx : x ∈ Icc (-S) S
      · simpa only [b,indicator_of_mem hx] using h x
      · simp [b,hx,hf x (lt_of_not_ge (fun hn => hx (abs_le.mp hn)))]
    _ = _ := by
      change (∫ x, (Icc (-S) S).indicator (fun _ : ℝ => e) x) = _
      rw [integral_indicator_const _ measurableSet_Icc, Real.volume_real_Icc_of_le (by linarith),smul_eq_mul]
      ring

theorem double_smoothing_uniform {f : ℝ → ℝ} (hi : Integrable f) (hc : UniformContinuous f)
    {e : ℝ} (he : 0 < e) : ∃ r : ℝ, 0 < r ∧ ∀ (δ : ℝ) (M : Mollifier δ),
    2*δ < r → ∀ x, |conv M.φ (conv M.φ f) x - f x| ≤ e := by
  obtain ⟨r,hr,h⟩ := Metric.uniformContinuous_iff.mp hc e he
  refine ⟨r,hr,?_⟩
  intro δ M hδ x
  apply M.deviation (M.φ.integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hi) x
  intro y hy
  apply M.deviation hi (x-y)
  intro z hz
  apply (h (a := x-y-z) (b := x) ?_).le
  rw [Real.dist_eq,show x-y-z-x= -(y+z) by ring,abs_neg]
  linarith [abs_add_le y z]

variable {v α β : ℝ}

theorem Witness.continuous_meanAutocorr (W : Witness v α β) : Continuous W.meanAutocorr := by
  apply weighted_continuous W.p
  intro i
  obtain ⟨hi,b,hb⟩ := W.window_regular i
  exact conv_continuous_regular hi ⟨hi.comp_neg,b,fun x => hb (-x)⟩

theorem Witness.compact_meanAutocorr (W : Witness v α β) : HasCompactSupport W.meanAutocorr :=
  HasCompactSupport.intro (K := Icc (-v) v) isCompact_Icc (fun _ hx =>
    W.meanAutocorr_support (lt_of_not_ge (fun h => hx (abs_le.mp h))))

theorem Witness.centered_meanAutocorr (W : Witness v α β) :
    weighted W.p (fun i => conv (W.centerWindow i) (rev (W.centerWindow i))) = W.meanAutocorr := by
  funext x; simp only [weighted,meanAutocorr,expectation,centerWindow,autocorr_shift]

/-- After selecting a fine enough smoothing radius, any unit mollifier with
that radius admits a positive auxiliary weight for which both norms of the
autocorrelation error are small. All convolutions are on the full real line. -/
theorem Witness.autocorr_root_control (W : Witness v α β) {ε : ℝ} (hε : 0 < ε) :
    ∃ r : ℝ, 0 < r ∧ ∀ (δ : ℝ), 0 < δ → δ < r → ∀ M : Mollifier δ,
      ∃ t : ℝ, 0 < t ∧ t ≤ 1 ∧ ∀ {θ : ℝ}, 0 < θ → θ ≤ t →
        ∀ F : Filters (augmentedWeight W.p θ) (augmentedWindow W.centerWindow) M.φ,
        (∀ x, |conv F.s F.s x - W.meanAutocorr x| ≤ ε) ∧
        (∫ x, |conv F.s F.s x - W.meanAutocorr x|) ≤ ε := by
  let S := v+2
  have hS : 0 < S := by dsimp [S]; linarith [W.width_pos]
  let e := ε / (2*(2*S+1))
  have he : 0 < e := div_pos hε (by positivity)
  have hεeq : e*(2*(2*S+1)) = ε := div_mul_cancel₀ _ (by positivity)
  obtain ⟨r,hr,h⟩ := double_smoothing_uniform W.integrable_meanAutocorr
    (W.compact_meanAutocorr.uniformContinuous_of_continuous W.continuous_meanAutocorr) he
  refine ⟨min 1 (r/2),lt_min (by norm_num) (by linarith),?_⟩
  intro δ hδ hδ' M
  obtain ⟨hδ₁,hδ₂⟩ := lt_min_iff.mp hδ'
  obtain ⟨B,hB⟩ := W.continuous_meanAutocorr.bounded_above_of_compact_support W.compact_meanAutocorr
  let J := SchwartzMap.seminorm ℝ 0 0 M.φ
  have hJ (x : ℝ) : |M.φ x| ≤ J := SchwartzMap.norm_le_seminorm ℝ M.φ x
  have hJ₀ : 0 ≤ J := (abs_nonneg _).trans (hJ 0)
  have hB₀ : 0 ≤ B := (norm_nonneg _).trans (hB 0)
  let D := J+B+e+1
  have hD : 0 < D := by dsimp [D]; linarith
  let t := e/D
  have ht : 0 < t := div_pos he hD
  have ht' : t ≤ 1 := (div_le_one hD).mpr (by dsimp [D]; linarith)
  refine ⟨t,ht,ht',?_⟩
  intro θ hθ hθt F
  have hθ' : θ ≤ 1 := hθt.trans ht'
  let G := conv M.φ (conv M.φ W.meanAutocorr)
  let X := conv M.φ M.φ
  have hx (x : ℝ) : |X x| ≤ J := by
    have hm : massAbs M.φ = 1 := by simpa [massAbs,abs_of_nonneg (M.nonneg _)] using M.mass
    simpa only [X,hm,one_mul] using conv_abs_bound M.φ.integrable hJ x
  have hg (x : ℝ) : |G x-W.meanAutocorr x| ≤ e := h δ M (by linarith) x
  have eq (x : ℝ) : conv F.s F.s x = θ*X x+(1-θ)*G x := by
    rw [F.auto_identity W.weight_nonneg hθ hθ' (fun i => (W.centerWindow_regular i).1)]
    simp only [autoProfile,W.centered_meanAutocorr,X,G]
  have bound (x : ℝ) : |conv F.s F.s x - W.meanAutocorr x| ≤ 2*e := by
    rw [eq,show θ*X x+(1-θ)*G x-W.meanAutocorr x =
      θ*(X x-W.meanAutocorr x)+(1-θ)*(G x-W.meanAutocorr x) by ring]
    have heq : θ*D ≤ e := (le_div_iff₀ hD).mp hθt
    have hab : |X x-W.meanAutocorr x| ≤ D := (abs_sub _ _).trans (by
      dsimp [D]; linarith [hx x,show |W.meanAutocorr x|≤B from hB x])
    apply (abs_add_le _ _).trans
    rw [abs_mul,abs_mul,abs_of_pos hθ,abs_of_nonneg (sub_nonneg.mpr hθ')]
    nlinarith [mul_le_mul_of_nonneg_left hab hθ.le,
      mul_le_mul_of_nonneg_left (hg x) (sub_nonneg.mpr hθ'),mul_nonneg hθ.le he.le]
  have small : 0 ≤ e*S := mul_nonneg he.le hS.le
  refine ⟨fun x => (bound x).trans (by nlinarith),?_⟩
  have ho (x : ℝ) (hz : S < |x|) : conv F.s F.s x-W.meanAutocorr x = 0 := by
    have hφ (y : ℝ) (hy : δ < |y|) := M.outside y hy.le
    have hG : G x = 0 := conv_zero_outside hφ (fun y hy =>
      conv_zero_outside hφ (fun z hz => W.meanAutocorr_support hz) hy) (by dsimp [S] at hz; linarith)
    have hX : X x = 0 := conv_zero_outside hφ hφ (by dsimp [S] at hz; linarith [W.width_pos])
    rw [eq,hX,hG,W.meanAutocorr_support (by dsimp [S] at hz; linarith)]
    ring
  exact (integral_abs_le_of_support hS.le ho bound).trans (by nlinarith)

end
end MathLab.WT
