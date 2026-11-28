module
public import MathLab.WT.AutocorrelationProfile
public import MathLab.WT.InputFilters
import Mathlib.Tactic.Linarith

/-! A single choice of the regularization controls the two expected profiles
at once, and provides the same filters used in the WT budget theorem. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set Filter Spectral
noncomputable section

variable {v α β : ℝ}

theorem Witness.covProfile_center (W : Witness v α β) {L : ℝ} (hL : W.σ/2 ≤ L)
    (θ x : ℝ) : covProfile W.p θ W.centerWindow (W.inputTable L hL) x =
      θ * box (-L) L x + (1-θ) * (W.extendTo L hL).originalCover (x+L) := by
  rw [covProfile_apply]
  congr 2
  let U := W.extendTo L hL
  change (∑ i, W.p i * conv (shift (-v/2) (W.w i)) (shift (-(U.σ-v)/2) (U.t i)) x) =
    ∑ i, W.p i * conv (W.w i) (U.t i) (x+L)
  simp only [conv_shift, show U.σ=2*L from W.extendTo_length L hL,
    show x-(-v/2+(-(2*L-v)/2))=x+L by ring]

private theorem box_even (L x : ℝ) : box (-L) L (-x) = box (-L) L x := by
  have h (y : ℝ) : y ∈ Icc (-L) L ↔ |y| ≤ L := abs_le.symm
  simp [box, Set.indicator, h, abs_neg]

theorem Witness.covProfile_even (W : Witness v α β) {L : ℝ} (hL : W.σ/2 ≤ L)
    (θ x : ℝ) : evenPart (covProfile W.p θ W.centerWindow (W.inputTable L hL)) x =
      θ * box (-L) L x + (1-θ) * W.reflectedCover L hL x := by
  simp only [evenPart, W.covProfile_center hL, box_even, reflectedCover,
    show -x+L=L-x by ring]
  ring

private theorem conv_regular_of {w t : ℝ → ℝ} (hw : Integrable w) (ht : Regular t) :
    Regular (conv w t) := by
  obtain ⟨B,hB⟩ := ht.2
  exact ⟨hw.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) ht.1,
    massAbs w * B,conv_abs_bound hw hB⟩

theorem Witness.covProfile_regular (W : Witness v α β) {L : ℝ} (hL : W.σ/2 ≤ L) (θ : ℝ) :
    Regular (covProfile W.p θ W.centerWindow (W.inputTable L hL)) := by
  let U := W.extendTo L hL
  obtain ⟨B,hB⟩ := U.originalCover_uniformContinuous.continuous.bounded_above_of_compact_support
    U.originalCover_compact
  have h : Regular (fun x => U.originalCover (x+L)) :=
    ⟨U.originalCover_integrable.comp_add_right L,B,fun x => hB (x+L)⟩
  rw [funext (W.covProfile_center hL θ)]
  exact ((box_regular (-L) L).smul θ).add (h.smul (1-θ))

theorem Witness.reflectedCover_bound (W : Witness v α β) :
    ∃ B : ℝ, 0 ≤ B ∧ ∀ L hL x, |W.reflectedCover L hL x| ≤ B := by
  obtain ⟨T,hT⟩ := W.originalCover_uniformContinuous.continuous.bounded_above_of_compact_support
    W.originalCover_compact
  have hd (z : ℝ) : |W.edgeProfile z| ≤ T := by
    have hl : |W.edgeLeft z| ≤ T := hT _
    have hr : |W.edgeRight z| ≤ T := hT _
    rw [edgeProfile,abs_div,abs_of_pos (by norm_num : (0:ℝ)<2),div_le_iff₀ (by norm_num)]
    exact (abs_add_le _ _).trans (by linarith)
  refine ⟨2*T+1,by linarith [show 0 ≤ T from (norm_nonneg _).trans (hT 0)],?_⟩
  intro L hL x
  rw [W.reflectedCover_eq]
  have ha := hd (x+L)
  have hb := hd (L-x)
  have hab := abs_add_le (W.edgeProfile (x+L)) (W.edgeProfile (L-x))
  apply (abs_sub _ _).trans
  rw [abs_one]
  linarith

private theorem mollifier_symm_double {δ : ℝ} (M : Mollifier δ) {g : ℝ → ℝ} (hg : Regular g) :
    evenPart (conv M.φ (conv M.φ g)) = conv M.φ (conv M.φ (evenPart g)) := by
  have sym {t : ℝ → ℝ} (ht : Regular t) : evenPart (conv M.φ t) = conv M.φ (evenPart t) :=
    funext (fun x => (conv_evenPart M.φ.integrable M.even ht x).symm)
  rw [sym (conv_regular_of M.φ.integrable hg),sym hg]

theorem Witness.cover_root_control (W : Witness v α β) {ε : ℝ} (hε : 0 < ε) :
    ∃ r t : ℝ, 0 < r ∧ 0 < t ∧ ∀ {δ θ : ℝ}, 0 < δ → δ < r → 0 < θ → θ ≤ t → θ ≤ 1 →
      ∀ (M : Mollifier δ) (F : Filters (augmentedWeight W.p θ) (augmentedWindow W.centerWindow) M.φ)
        (L : ℝ) (hL : W.σ/2 ≤ L) (hD : W.σ/2 ≤ L-2*δ) (x : ℝ),
        |evenPart (conv F.s (filterSum F.k (W.inputTable L hL))) x -
          W.reflectedCover (L-2*δ) hD x| ≤ ε := by
  obtain ⟨r,hr,hvar⟩ := W.reflectedCover_uniform (ε/2) (by linarith)
  obtain ⟨B,hB,Bbound⟩ := W.reflectedCover_bound
  let t := (ε/2)/(B+1)
  have ht : 0 < t := div_pos (by linarith) (by linarith)
  refine ⟨r/4,t,by linarith,ht,?_⟩
  intro δ θ hδ hδ' hθ hθt hθ' M F L hL hD x
  let D := L-2*δ
  let c := W.reflectedCover D hD x
  let g := covProfile W.p θ W.centerWindow (W.inputTable L hL)
  have hg : Regular g := W.covProfile_regular hL θ
  have hi := (evenPart_regular hg).1
  rw [← F.asFilterSum,F.cov_identity W.weight_nonneg hθ hθ' (fun i => (W.centerWindow_regular i).1)
    (fun i => (W.inputTable_regular L hL i).1), mollifier_symm_double M hg]
  apply M.deviation (M.φ.integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hi) x
  intro y hy
  apply M.deviation hi (x-y)
  intro z hz
  let q := x-y-z
  have hclose : |W.reflectedCover L hL q-c| ≤ ε/2 := by
    apply (hvar L D hL hD q x ?_).le
    rw [show q-x= -(y+z) by dsimp [q]; ring, abs_neg,
      show L-D=2*δ by dsimp [D]; ring,abs_of_pos (by positivity : 0<2*δ)]
    linarith [abs_add_le y z]
  have hb : |box (-L) L q| ≤ 1 := by by_cases h : q ∈ Icc (-L) L <;> simp [box,h]
  have hb' : |box (-L) L q-c| ≤ B+1 := (abs_sub _ _).trans (by linarith [Bbound D hD x])
  have hcost : θ*(B+1) ≤ ε/2 := (le_div_iff₀ (by linarith)).mp hθt
  change |evenPart g q-c| ≤ ε
  rw [show evenPart g q = _ from W.covProfile_even hL θ q,
    show θ*box (-L) L q+(1-θ)*W.reflectedCover L hL q - c =
      θ*(box (-L) L q-c)+(1-θ)*(W.reflectedCover L hL q-c) by ring]
  apply (abs_add_le _ _).trans
  rw [abs_mul,abs_mul,abs_of_pos hθ,abs_of_nonneg (sub_nonneg.mpr hθ')]
  nlinarith [mul_le_mul_of_nonneg_left hb' hθ.le,mul_le_mul_of_nonneg_left hclose (sub_nonneg.mpr hθ'),
    mul_nonneg hθ.le hε.le]

structure ProfileFilters (W : Witness v α β) (δ ε : ℝ) extends PreparedFilters W δ ε where
  auto_sup : ∀ x, |conv s s x - W.meanAutocorr x| ≤ ε
  auto_l1 : (∫ x, |conv s s x - W.meanAutocorr x|) ≤ ε
  cover_sup : ∀ L hL hD x, |evenPart (conv s (filterSum k (W.inputTable L hL))) x -
    W.reflectedCover (L-2*δ) hD x| ≤ ε

/-- One set of filters controls both norms of the autocorrelation error, the
reflected full-line covering profile and both energy budgets. -/
theorem Witness.profileFilters (W : Witness v α β) {ε : ℝ} (hε : 0 < ε) :
    ∃ δ : ℝ, 0 < δ ∧ δ < ε ∧ Nonempty (ProfileFilters W δ ε) := by
  obtain ⟨r,hr,ha⟩ := W.autocorr_root_control hε
  obtain ⟨q,t,hq,ht,hc⟩ := W.cover_root_control hε
  let δ := (min ε (min q r))/2
  have hd : 0 < δ := half_pos (lt_min hε (lt_min hq hr))
  have hδ : δ < min ε (min q r) := half_lt_self (lt_min hε (lt_min hq hr))
  obtain ⟨he,hq',hr'⟩ := lt_min_iff.mp hδ |>.imp_right lt_min_iff.mp
  obtain ⟨M⟩ := mollifier_exists hd
  obtain ⟨u,hu,hu₁,hA⟩ := ha δ hd hr' M
  let θ := min t u
  have hθ : 0 < θ := lt_min ht hu
  have hθ' : θ ≤ 1 := (min_le_right t u).trans hu₁
  obtain ⟨F⟩ := augmented_filters_exist W.p W.weight_nonneg W.centerWindow
    (fun i => (W.centerWindow_regular i).1) W.centerWindow_outside M.φ M.even hθ hθ'
  obtain ⟨hs,h₁⟩ := hA hθ (min_le_right t u) F
  have masscost : energy F.s ≤ β+ε := by
    have h := (abs_le.mp (hs 0)).2
    rw [W.meanAutocorr_zero, show conv F.s F.s 0 = energy F.s by simp [conv,energy,F.even_s,sq]] at h
    linarith [W.window_cost]
  obtain ⟨B,hB,hbt⟩ := W.inputTable_uniform
  let P := PreparedFilters.ofFilters W M hθ hθ' F hB hbt masscost
  exact ⟨δ,hd,he,⟨⟨P,hs,h₁,hc hd hq' hθ (min_le_left t u) hθ' M F⟩⟩⟩

end
end MathLab.WT
