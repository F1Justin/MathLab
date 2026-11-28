module
public import MathLab.WT.MollifiedInput
public import MathLab.WT.ConvolutionBounds
import Mathlib.MeasureTheory.Function.ContinuousMapDense
import Mathlib.Topology.UniformSpace.HeineCantor
import Mathlib.Tactic.Linarith

/-! The full-line covering profile of a lengthened witness. A single
uniformly continuous function gives both ends after averaging reflection. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set Filter Spectral
noncomputable section

theorem conv_continuous_regular {w t : ℝ → ℝ} (hw : Integrable w) (ht : Regular t) :
    Continuous (conv w t) := by
  obtain ⟨B,hB⟩ := ht.2
  have hb : 0 ≤ B := (abs_nonneg _).trans (hB 0)
  apply continuous_iff_continuousAt.mpr
  intro x
  rw [Metric.continuousAt_iff]
  intro ε hε
  let e := ε / (4*(B+1))
  have he : 0 < e := div_pos hε (by positivity)
  obtain ⟨g,hgc,hfg,hg,hi⟩ := hw.exists_hasCompactSupport_integral_sub_le he
  have hcont : Continuous (conv g t) :=
    hgc.continuous_convolution_left (ContinuousLinearMap.mul ℝ ℝ) hg ht.1.locallyIntegrable
  have hdist (y : ℝ) : |conv w t y - conv g t y| ≤ ε/4 := by
    have h0 := conv_perturbation (f := g) (F := w) hi hw ht ht hB
      (e := 0) (fun y => by simp) y
    have h₁ : massAbs (fun z => w z - g z) ≤ e := hfg
    have h₂ : e * (B + 1) = ε/4 := by
      dsimp [e]; field_simp
    calc
      _ ≤ massAbs (fun z => w z-g z) * B := by simpa using h0
      _ ≤ e * B := mul_le_mul_of_nonneg_right h₁ hb
      _ ≤ e * (B+1) := mul_le_mul_of_nonneg_left (by linarith) he.le
      _ = ε/4 := h₂
  obtain ⟨r,hr,hd⟩ := (Metric.continuousAt_iff.mp (hcont.continuousAt (x := x)))
    (ε/2) (by linarith)
  refine ⟨r,hr,?_⟩
  intro y hy
  have hh := dist_triangle4 (conv w t y) (conv g t y) (conv g t x) (conv w t x)
  have hx' := hdist x
  rw [abs_sub_comm] at hx'
  simp only [Real.dist_eq] at hh hd ⊢
  linarith [hd (by simpa only [Real.dist_eq] using hy), hdist y]

variable {v α β : ℝ}

def Witness.originalCover (W : Witness v α β) (x : ℝ) :=
  expectation W.p (fun i => conv (W.w i) (W.t i) x)

theorem Witness.originalCover_compact (W : Witness v α β) : HasCompactSupport W.originalCover := by
  apply HasCompactSupport.intro (K := Icc (-v) (W.σ+v)) isCompact_Icc
  intro x hx
  have zero (i : Fin W.n) : conv (W.w i) (W.t i) x = 0 := by
    apply integral_eq_zero_of_ae (Eventually.of_forall ?_)
    intro y
    by_cases hy : W.w i y = 0
    · simp [hy]
    · have hw := W.window_support i hy
      have hn : W.t i (x-y) = 0 := by
        by_contra h
        obtain ⟨hl,hr⟩ := W.table_support i h
        exact hx ⟨by linarith [hw.1], by linarith [hw.2]⟩
      simp [hn]
  simp [originalCover,expectation,zero]

theorem Witness.originalCover_uniformContinuous (W : Witness v α β) :
    UniformContinuous W.originalCover :=
  W.originalCover_compact.uniformContinuous_of_continuous
    (weighted_continuous W.p (fun i => conv_continuous_regular (W.window_regular i).1 (W.table_regular i)))

private lemma full_atom {w t : ℝ → ℝ} {x : ℝ} (hs : Function.support w ⊆ Icc 0 v)
    (hm : ∫ y, w y = 1) (h : ∀ y ∈ Ioo 0 v, t (x-y) = 1) : conv w t x = 1 := by
  rw [conv_window_congr (w := w) (g := fun _ => 1) (z := x) hs h]
  simpa [conv] using hm

theorem Witness.originalCover_inner (W : Witness v α β) {x : ℝ} (hx : v ≤ x)
    (hx' : x ≤ W.σ-v) : W.originalCover x = 1 := by
  have hi (i : Fin W.n) : conv (W.w i) (W.t i) x = 1 := by
    apply full_atom (W.window_support i) (W.mass i)
    intro y hy
    exact W.plateau i _ ⟨by linarith [hy.2],by linarith [hy.1]⟩
  simp [originalCover,expectation,hi,W.total_weight]

def Witness.edgeLeft (W : Witness v α β) (z : ℝ) := W.originalCover (min z v)
def Witness.edgeRight (W : Witness v α β) (z : ℝ) := W.originalCover (W.σ-min z v)
def Witness.edgeProfile (W : Witness v α β) (z : ℝ) := (W.edgeLeft z+W.edgeRight z)/2

theorem Witness.edgeProfile_uniformContinuous (W : Witness v α β) :
    UniformContinuous W.edgeProfile := by
  have hm : UniformContinuous (fun z : ℝ => min z v) := (LipschitzWith.id.min_const v).uniformContinuous
  have he : W.edgeProfile = (fun t : ℝ => (1/2)*t) ∘ (fun z => W.edgeLeft z + W.edgeRight z) := by
    funext z; dsimp [edgeProfile]; ring
  rw [he]
  exact Real.uniformContinuous_const_mul.comp ((W.originalCover_uniformContinuous.comp hm).add
    (W.originalCover_uniformContinuous.comp (uniformContinuous_const.sub hm)))

private theorem originalCover_extend_left (W : Witness v α β) {d : ℝ} (hd : 0 ≤ d)
    (x : ℝ) (hx : x ≤ v) : (W.extend d hd).originalCover x = W.originalCover x := by
  change (∑ i, W.p i * conv (W.w i) (insertPlateau d (W.t i)) x) =
    ∑ i, W.p i * conv (W.w i) (W.t i) x
  apply Finset.sum_congr rfl
  intro i _
  congr 1
  apply conv_window_congr (w := W.w i) (W.window_support i)
  intro y hy
  by_cases h : x-y ≤ 0
  · simp [insertPlateau,h]
  · have he := W.plateau i (x-y) ⟨lt_of_not_ge h,by linarith [hy.1,W.width_le]⟩
    simp only [insertPlateau,h,ite_false,he]
    split_ifs with h'
    · rfl
    · apply W.plateau
      exact ⟨by linarith [lt_of_not_ge h'],by linarith [hy.1,W.width_le]⟩

private theorem originalCover_extend_right (W : Witness v α β) {d : ℝ} (hd : 0 ≤ d)
    (x : ℝ) (hx : W.σ+d-v ≤ x) : (W.extend d hd).originalCover x = W.originalCover (x-d) := by
  change (∑ i, W.p i * conv (W.w i) (insertPlateau d (W.t i)) x) =
    ∑ i, W.p i * conv (W.w i) (W.t i) (x-d)
  apply Finset.sum_congr rfl
  intro i _
  congr 1
  apply conv_window_congr (w := W.w i) (W.window_support i)
  intro y hy
  have h₁ : ¬x-y ≤ 0 := by linarith [hy.2,W.width_le]
  have h₂ : ¬x-y ≤ d := by linarith [hy.2,W.width_le]
  simp [insertPlateau,h₁,h₂,show x-y-d=x-d-y by ring]

theorem Witness.two_ends (W : Witness v α β) {d : ℝ} (hd : 0 ≤ d) (x : ℝ) :
    (W.extend d hd).originalCover x = W.edgeLeft x + W.edgeRight (W.σ+d-x)-1 := by
  have he₁ := W.originalCover_inner (x := v) (le_refl _) (by linarith [W.width_le])
  have he₂ := W.originalCover_inner (x := W.σ-v) (by linarith [W.width_le]) (le_refl _)
  by_cases hl : x ≤ v
  · have hr : v ≤ W.σ+d-x := by linarith [W.width_le]
    simp [edgeLeft,edgeRight,min_eq_left hl,min_eq_right hr,he₂,originalCover_extend_left W hd x hl]
  · have hl' := le_of_lt (lt_of_not_ge hl)
    by_cases hr : W.σ+d-v ≤ x
    · have hr' : W.σ+d-x ≤ v := by linarith
      simp [edgeLeft,edgeRight,min_eq_right hl', min_eq_left hr',he₁,
        show W.σ-(W.σ+d-x)=x-d by ring,originalCover_extend_right W hd x hr]
    · have hr' : v ≤ W.σ+d-x := by linarith [lt_of_not_ge hr]
      rw [(W.extend d hd).originalCover_inner hl' (by exact le_of_lt (lt_of_not_ge hr))]
      simp [edgeLeft,edgeRight,min_eq_right hl',min_eq_right hr',he₁,he₂]

/-- Reflect the actual extended covering about its midpoint. This formula
holds outside as well as inside the original covering interval. -/
def Witness.reflectedCover (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L) (x : ℝ) : ℝ :=
  ((W.extendTo L hL).originalCover (x+L) + (W.extendTo L hL).originalCover (L-x))/2

theorem Witness.reflectedCover_eq (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L) (x : ℝ) :
    W.reflectedCover L hL x = W.edgeProfile (x+L) + W.edgeProfile (L-x) - 1 := by
  let d := 2*L-W.σ
  have hd : 0 ≤ d := by dsimp [d]; linarith
  change ((W.extend d hd).originalCover (x+L)+(W.extend d hd).originalCover (L-x))/2 = _
  rw [W.two_ends hd,W.two_ends hd]
  rw [show W.σ+d-(x+L)=L-x by dsimp [d]; ring,
    show W.σ+d-(L-x)=x+L by dsimp [d]; ring]
  unfold edgeProfile
  ring

/-- Equicontinuity on the whole line, jointly under a change in location
and half-length of the enlarged table. -/
theorem Witness.reflectedCover_uniform (W : Witness v α β) (ε : ℝ) (hε : 0 < ε) :
    ∃ r : ℝ, 0 < r ∧ ∀ (L D : ℝ) (hL : W.σ/2 ≤ L) (hD : W.σ/2 ≤ D) x y,
      |x-y| + |L-D| < r → |W.reflectedCover L hL x - W.reflectedCover D hD y| < ε := by
  obtain ⟨r,hr,h⟩ := Metric.uniformContinuous_iff.mp W.edgeProfile_uniformContinuous (ε/2) (by linarith)
  refine ⟨r,hr,?_⟩
  intro L D hL hD x y hxy
  have hm (s t : ℝ) (hs : |s-t| < r) : |W.edgeProfile s-W.edgeProfile t| < ε/2 :=
    h (by simpa only [Real.dist_eq] using hs)
  have h₁ := hm (x+L) (y+D) (by rw [show x+L-(y+D)=(x-y)+(L-D) by ring]; exact (abs_add_le _ _).trans_lt hxy)
  have h₂ := hm (L-x) (D-y) (by
    rw [show L-x-(D-y)=(L-D)-(x-y) by ring]
    exact (abs_sub _ _).trans_lt (by simpa only [add_comm] using hxy))
  rw [W.reflectedCover_eq,W.reflectedCover_eq]
  have hsum := abs_add_le (W.edgeProfile (x+L)-W.edgeProfile (y+D))
    (W.edgeProfile (L-x)-W.edgeProfile (D-y))
  rw [show W.edgeProfile (x+L)+W.edgeProfile (L-x)-1-(W.edgeProfile (y+D)+W.edgeProfile (D-y)-1) =
    (W.edgeProfile (x+L)-W.edgeProfile (y+D))+(W.edgeProfile (L-x)-W.edgeProfile (D-y)) by ring]
  linarith

theorem Witness.originalCover_integrable (W : Witness v α β) : Integrable W.originalCover :=
  weighted_integrable W.p (fun i => (W.window_regular i).1.integrable_convolution
    (ContinuousLinearMap.mul ℝ ℝ) (W.table_regular i).1)

theorem Witness.reflectedCover_integrable (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L) :
    Integrable (W.reflectedCover L hL) := by
  have hi := (W.extendTo L hL).originalCover_integrable
  exact ((hi.comp_add_right L).add (hi.comp_sub_left L)).div_const 2

theorem Mollifier.deviation {δ e c : ℝ} (M : Mollifier δ) {t : ℝ → ℝ} (ht : Integrable t)
    (x : ℝ) (hb : ∀ z, |z| < δ → |t (x-z)-c| ≤ e) :
    |conv M.φ t x - c| ≤ e := by
  have hi : Integrable (fun z => M.φ z * t (x-z)) := (ht.comp_sub_left x).bdd_mul
    M.φ.continuous.aestronglyMeasurable
    (Eventually.of_forall (SchwartzMap.norm_le_seminorm ℝ M.φ))
  have eq : conv M.φ t x - c = ∫ z, M.φ z * (t (x-z)-c) := by
    simp_rw [mul_sub,integral_sub hi (M.φ.integrable.mul_const c),integral_mul_const,M.mass,one_mul]
    rfl
  rw [eq]
  calc
    _ ≤ ∫ z, |M.φ z * (t (x-z)-c)| := abs_integral_le_integral_abs
    _ ≤ ∫ z, M.φ z * e := by
      apply integral_mono_of_nonneg (Eventually.of_forall (fun z => abs_nonneg _))
        (M.φ.integrable.mul_const e) (Eventually.of_forall ?_)
      intro z
      by_cases hz : |z| < δ
      · simpa only [abs_mul,abs_of_nonneg (M.nonneg z)] using mul_le_mul_of_nonneg_left (hb z hz) (M.nonneg z)
      · simp [M.outside z (le_of_not_gt hz)]
    _ = e := by rw [integral_mul_const,M.mass,one_mul]

/-- A convolution by the two unit-mass kernels and shortening the table
may be performed together, uniformly for all choices of both long tables. -/
theorem Witness.reflectedCover_smoothing (W : Witness v α β) (ε : ℝ) (hε : 0 < ε) :
    ∃ r : ℝ, 0 < r ∧ ∀ (δ L D : ℝ) (M : Mollifier δ) (hL : W.σ/2 ≤ L) (hD : W.σ/2 ≤ D),
      2*δ + |L-D| < r → ∀ x, |conv M.φ (conv M.φ (W.reflectedCover L hL)) x -
        W.reflectedCover D hD x| ≤ ε := by
  obtain ⟨r,hr,he⟩ := W.reflectedCover_uniform ε hε
  refine ⟨r,hr,?_⟩
  intro δ L D M hL hD hδ x
  have hi := W.reflectedCover_integrable L hL
  apply M.deviation (M.φ.integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hi) x
  intro y hy
  apply M.deviation hi (x-y)
  intro z hz
  apply (he L D hL hD (x-y-z) x ?_).le
  rw [show x-y-z-x = -(y+z) by ring,abs_neg]
  linarith [abs_add_le y z]

end
end MathLab.WT
