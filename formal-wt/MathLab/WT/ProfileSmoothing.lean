module
public import MathLab.WT.AutocorrelationProfile
public import MathLab.WT.SmoothPair
public import MathLab.WT.ProfileNorms
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Post-smoothing preserves both correlation profiles. The modulus belongs to
the fixed input law and is uniform in the enlarged table half-length. -/
@[expose] public section
namespace MathLab.WT

open MeasureTheory Set Filter
noncomputable section

private theorem mollified_integrable {r : ℝ} (M : Mollifier r) {f : ℝ → ℝ} (hf : Integrable f) :
    Integrable (conv M.φ f) :=
  M.φ.integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hf

private theorem smooth_difference {r : ℝ} (M : Mollifier r) {f g : ℝ → ℝ}
    (hf : Integrable f) (hg : Integrable g) (x : ℝ) :
    conv M.φ f x - conv M.φ g x = conv M.φ (fun y => f y-g y) x := by
  have hi {t : ℝ → ℝ} (ht : Integrable t) : Integrable (fun y => M.φ y * t (x-y)) :=
    (ht.comp_sub_left x).bdd_mul M.φ.continuous.aestronglyMeasurable
      (Eventually.of_forall (SchwartzMap.norm_le_seminorm ℝ M.φ))
  unfold conv
  simp only [mul_sub,integral_sub (hi hf) (hi hg)]

theorem Mollifier.l1_contraction {r : ℝ} (M : Mollifier r) {f : ℝ → ℝ} (hf : Integrable f) :
    massAbs (conv M.φ f) ≤ massAbs f := by
  have bound (x : ℝ) : |conv M.φ f x| ≤ conv M.φ (fun y => |f y|) x := by
    change |∫ y, M.φ y * f (x-y)| ≤ ∫ y, M.φ y * |f (x-y)|
    simpa only [abs_mul,abs_of_nonneg (M.nonneg _)] using
      (abs_integral_le_integral_abs (f:=fun y => M.φ y*f (x-y)) (μ:=volume))
  calc
    _ ≤ ∫ x, conv M.φ (fun y => |f y|) x :=
      integral_mono (mollified_integrable M hf).abs (mollified_integrable M hf.abs) bound
    _ = massAbs f := by rw [conv_mass M.φ.integrable hf.abs,M.mass,one_mul,massAbs]

theorem Mollifier.l1_difference {r : ℝ} (M : Mollifier r) {f g : ℝ → ℝ}
    (hf : Integrable f) (hg : Integrable g) :
    massAbs (fun x => conv M.φ f x-conv M.φ g x) ≤ massAbs (fun y => f y-g y) := by
  simp_rw [smooth_difference M hf hg]
  exact M.l1_contraction (hf.sub hg)

theorem Mollifier.sup_difference {r e : ℝ} (M : Mollifier r) {f g : ℝ → ℝ}
    (hf : Integrable f) (hg : Integrable g) (he : ∀ y, |f y-g y| ≤ e) (x : ℝ) :
    |conv M.φ f x-conv M.φ g x| ≤ e := by
  rw [smooth_difference M hf hg]
  have m : massAbs M.φ = 1 := by simpa [massAbs,abs_of_nonneg (M.nonneg _)] using M.mass
  simpa only [m,one_mul] using conv_abs_bound M.φ.integrable he x

variable {v α β : ℝ}

private theorem Witness.smoothed_input_autocorr (W : Witness v α β) {ε : ℝ} (hε : 0 < ε) :
    ∃ ρ : ℝ, 0 < ρ ∧ ∀ {r : ℝ}, 0 < r → r < ρ → ∀ M : Mollifier r,
      (∀ x, |conv M.φ (conv M.φ W.meanAutocorr) x-W.meanAutocorr x| ≤ ε) ∧
      massAbs (fun x => conv M.φ (conv M.φ W.meanAutocorr) x-W.meanAutocorr x) ≤ ε := by
  let S := v+2
  have hS : 0 < S := by dsimp [S]; linarith [W.width_pos]
  let e := ε/(2*S+1)
  have he : 0 < e := div_pos hε (by positivity)
  have eq : e*(2*S+1) = ε := div_mul_cancel₀ _ (by positivity)
  obtain ⟨u,hu,hu'⟩ := double_smoothing_uniform W.integrable_meanAutocorr
    (W.compact_meanAutocorr.uniformContinuous_of_continuous W.continuous_meanAutocorr) he
  refine ⟨min 1 (u/2),lt_min zero_lt_one (by linarith),?_⟩
  intro r hr hr' M
  obtain ⟨hsmall,hmod⟩ := lt_min_iff.mp hr'
  have bound := hu' r M (by linarith)
  have e_le : e ≤ ε := by nlinarith [mul_nonneg he.le hS.le]
  refine ⟨fun x => (bound x).trans e_le,?_⟩
  have hsφ (x : ℝ) (hx : r < |x|) := M.outside x hx.le
  apply (integral_abs_le_of_support hS.le (fun x hx => ?_) bound).trans (by nlinarith)
  have h₁ := conv_zero_outside hsφ (fun y hy => conv_zero_outside hsφ (fun z hz => W.meanAutocorr_support hz) hy)
    (x:=x) (by dsimp [S] at hx; linarith)
  rw [h₁,W.meanAutocorr_support (by dsimp [S] at hx; linarith),sub_zero]

/-- The two input profile norms are contracted by convolution. The remaining
error is the smoothing of the fixed input and a shift of its two table ends.
The cutoff is chosen before the approximating profiles and the table length. -/
theorem Witness.profile_smoothing_radius (W : Witness v α β) {ε : ℝ} (hε : 0 < ε) :
    ∃ ρ : ℝ, 0 < ρ ∧ ∀ {r : ℝ}, 0 < r → r < ρ → ∀ (M : Mollifier r) (D : ℝ)
      (hd : W.σ/2 ≤ D) (hd' : W.σ/2 ≤ D-2*r) (A C : ℝ → ℝ),
      Integrable A → Integrable C →
      (∀ x, |A x-W.meanAutocorr x| ≤ ε) →
      massAbs (fun x => A x-W.meanAutocorr x) ≤ ε →
      (∀ x, |C x-W.reflectedCover D hd x| ≤ ε) →
      (∀ x, |conv M.φ (conv M.φ A) x-W.meanAutocorr x| ≤ 2*ε) ∧
      massAbs (fun x => conv M.φ (conv M.φ A) x-W.meanAutocorr x) ≤ 2*ε ∧
      (∀ x, |conv M.φ (conv M.φ C) x-W.reflectedCover (D-2*r) hd' x| ≤ 2*ε) := by
  obtain ⟨ρ,hρ,ha⟩ := W.smoothed_input_autocorr hε
  obtain ⟨s,hs,hc⟩ := W.reflectedCover_smoothing ε hε
  refine ⟨min ρ (s/4),lt_min hρ (by linarith),?_⟩
  intro r hr hr' M D hd hd' A C hiA hiC supA l1A supC
  obtain ⟨hu,hv⟩ := lt_min_iff.mp hr'
  obtain ⟨hAsup,hA₁⟩ := ha hr hu M
  have hCsup := hc r D (D-2*r) M hd hd' (by
    rw [show D-(D-2*r) = 2*r by ring,abs_of_pos (by linarith : 0 < 2*r)]; linarith)
  have supTwice {f g : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g)
      (b : ∀ x, |f x-g x| ≤ ε) (x : ℝ) :
      |conv M.φ (conv M.φ f) x-conv M.φ (conv M.φ g) x| ≤ ε :=
    M.sup_difference (mollified_integrable M hf) (mollified_integrable M hg)
      (M.sup_difference hf hg b) x
  have supTransfer {f g h : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g)
      (b : ∀ x, |f x-g x| ≤ ε) (bh : ∀ x, |conv M.φ (conv M.φ g) x-h x| ≤ ε) (x : ℝ) :
      |conv M.φ (conv M.φ f) x-h x| ≤ 2*ε :=
    (abs_sub_le _ (conv M.φ (conv M.φ g) x) _).trans (by linarith [supTwice hf hg b x,bh x])
  refine ⟨supTransfer hiA W.integrable_meanAutocorr supA hAsup,?_,
    supTransfer hiC (W.reflectedCover_integrable D hd) supC hCsup⟩
  have h₁ := (M.l1_difference (mollified_integrable M hiA) (mollified_integrable M W.integrable_meanAutocorr)).trans
    (M.l1_difference hiA W.integrable_meanAutocorr)
  have h₂ := massAbs_sub_triangle (mollified_integrable M (mollified_integrable M hiA))
    (mollified_integrable M (mollified_integrable M W.integrable_meanAutocorr)) W.integrable_meanAutocorr
  linarith

/-- Any sufficiently small smoothing radius gives an actual smooth WT pair
with the stated three errors, including the profile at the new physical
half-length. Strict geometric margins ensure such positive radii exist. -/
theorem Witness.smooth_profile_pair (W : Witness v α β) {ε u D a b : ℝ} (hε : 0 < ε)
    (hu : 0 < u) (hgap : u < D) (hbase : W.σ/2 < D) (ha : 0 < a) (hb : 0 < b)
    {V T : ℝ → ℝ} (hV : Regular V) (hT : Regular T)
    (vs : ∀ x, u/2 < |x| → V x=0) (ts : ∀ x, D+u/2 < |x| → T x=0)
    (tp : ∀ x, |x| < D-u/2 → T x=1) (vm : ∫ x, V x=1)
    (vc : energy V ≤ b) (tc : energy T ≤ 2*D+a)
    (ve : ∀ x, V (-x)=V x) (te : ∀ x, T (-x)=T x)
    (ac : ∀ x, 0 ≤ conv V V x) (cov : ∀ x, |x| < D → 1 ≤ conv V T x)
    (hA : ∀ x, |conv V V x-W.meanAutocorr x| ≤ ε)
    (hL₁ : massAbs (fun x => conv V V x-W.meanAutocorr x) ≤ ε)
    (hC : ∀ x, |conv V T x-W.reflectedCover D hbase.le x| ≤ ε) :
    ∃ ρ : ℝ, 0 < ρ ∧ ∀ {r : ℝ}, 0 < r → r < ρ → ∀ M : Mollifier r,
      ∃ (hd' : W.σ/2 ≤ D-2*r) (S : SmoothPairResult r u D a b M.φ V T),
        ∀ i, (∀ x, |conv (S.witness.w i) (rev (S.witness.w i)) x - W.meanAutocorr x| ≤ 2*ε) ∧
        massAbs (fun x => conv (S.witness.w i) (rev (S.witness.w i)) x-W.meanAutocorr x) ≤ 2*ε ∧
        ∀ x, |conv (S.witness.w i) (S.witness.t i) (x+(D-2*r))-
          W.reflectedCover (D-2*r) hd' x| ≤ 2*ε := by
  obtain ⟨s,hs,h⟩ := W.profile_smoothing_radius hε
  refine ⟨min s (min ((D-u)/8) ((D-W.σ/2)/2)),lt_min hs (lt_min (by linarith) (by linarith)),?_⟩
  intro r hr hr' M
  obtain ⟨hm,hh⟩ := lt_min_iff.mp hr'
  obtain ⟨hw,hd⟩ := lt_min_iff.mp hh
  have hd' : W.σ/2 ≤ D-2*r := by linarith
  obtain ⟨S⟩ := M.smooth_pair hr hu (by linarith) ha hb hV hT vs ts tp vm vc tc ve te ac cov
  obtain ⟨asup,al₁,csup⟩ := h hr hm M D hbase.le hd' (conv V V) (conv V T)
    (hV.1.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hV.1)
    (hV.1.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hT.1) hA hL₁ hC
  refine ⟨hd',S,?_⟩
  intro i
  simp only [S.autocorrelation,S.covering,add_sub_cancel_right]
  exact ⟨asup,al₁,csup⟩

end
end MathLab.WT
