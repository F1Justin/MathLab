module
public import MathLab.WT.Mollifier
public import MathLab.WT.ProjectionEnergy
public import MathLab.WT.Shoulders
public import MathLab.WT.WindowRepair
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Post-smoothing an already feasible centred pair. Each output is an actual
WT witness and its two correlations are identified pointwise with the
twice-smoothed original profiles. -/
@[expose] public section
namespace MathLab.WT

open MeasureTheory Set Filter Spectral
open scoped SchwartzMap ContDiff
noncomputable section

private theorem compact_smooth_filter (φ : RealSchwartz) {f : ℝ → ℝ} (hf : Integrable f)
    {R : ℝ} (hs : ∀ x, R < |x| → f x=0) :
    ∃ g : RealSchwartz, conv φ f = g :=
  filter_schwartz φ hf (compact_ft_temperate hf (fun x hx => hs x hx))

/-- All identities are for the everywhere-defined convolution. The factors
can be signed and their chosen Lebesgue representatives need not be Borel. -/
theorem mollified_pair_identity (φ : RealSchwartz) {f g : ℝ → ℝ}
    (hf : Integrable f) (hg : Integrable g) {F G : RealSchwartz}
    (hF : conv φ f = F) (hG : conv φ g = G) :
    conv F G = conv φ (conv φ (conv f g)) := by
  have hi : Integrable (conv f g) :=
    hf.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hg
  have hh : Integrable (conv φ (conv f g)) :=
    φ.integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hi
  have hft : Integrable (ft (conv F G)) := by
    rw [funext (ft_conv F.integrable G.integrable)]
    exact (smoothFrequency F).integrable.mul_bdd (smoothFrequency G).continuous.aestronglyMeasurable
      (Eventually.of_forall (SchwartzMap.norm_le_seminorm ℝ (smoothFrequency G)))
  apply ft_unique (F.integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) G.integrable)
    (φ.integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hh)
    (continuous_conv_filter F G.integrable) (continuous_conv_filter φ hh) hft
  intro ξ
  change ft (conv F G) ξ = ft (conv φ (conv φ (conv f g))) ξ
  rw [ft_conv F.integrable G.integrable, ft_conv φ.integrable hh, ft_conv φ.integrable hi,
    ft_conv hf hg, ← hF, ← hG, ft_conv φ.integrable hf, ft_conv φ.integrable hg]
  ring

structure SmoothPairResult (r v D α β : ℝ) (φ w t : ℝ → ℝ) where
  witness : Witness (v+6*r) (α+4*r) β
  deterministic : witness.Deterministic
  symmetric : witness.Symmetric
  length : witness.σ = 2*(D-2*r)
  window : ∀ i, witness.w i = shift ((v+6*r)/2) (conv φ w)
  table : ∀ i, witness.t i = shift (D-2*r-(v+6*r)/2) (conv φ t)
  smooth_window : ∀ i, ContDiff ℝ ∞ (witness.w i) ∧ HasCompactSupport (witness.w i)
  smooth_table : ∀ i, ContDiff ℝ ∞ (witness.t i) ∧ HasCompactSupport (witness.t i)
  window_contraction : ∀ i, energy (witness.w i) ≤ energy w
  table_contraction : ∀ i, energy (witness.t i) ≤ energy t
  autocorrelation : ∀ i x, conv (witness.w i) (rev (witness.w i)) x =
    conv φ (conv φ (conv w w)) x
  covering : ∀ i x, conv (witness.w i) (witness.t i) x =
    conv φ (conv φ (conv w t)) (x-(D-2*r))

theorem Mollifier.smooth_pair {r v D α β : ℝ} (M : Mollifier r) (hr : 0 < r)
    (hv : 0 < v) (hD : v+8*r ≤ D) (hα : 0 < α) (hβ : 0 < β) {w t : ℝ → ℝ}
    (hw : Regular w) (ht : Regular t) (hws : ∀ x, v/2 < |x| → w x=0)
    (hts : ∀ x, D+v/2 < |x| → t x=0) (htp : ∀ x, |x| < D-v/2 → t x=1)
    (hm : ∫ x, w x = 1) (hew : energy w ≤ β) (het : energy t ≤ 2*D+α)
    (hwe : ∀ x, w (-x)=w x) (hte : ∀ x, t (-x)=t x)
    (ha : ∀ x, 0 ≤ conv w w x) (hc : ∀ x, |x| < D → 1 ≤ conv w t x) :
    Nonempty (SmoothPairResult r v D α β M.φ w t) := by
  let n := v+6*r
  let d := D-2*r
  have hnd : n ≤ d := by dsimp [n,d]; linarith
  have nh : 0 < n := by dsimp [n]; linarith
  obtain ⟨V,hV⟩ := compact_smooth_filter M.φ hw.1 hws
  obtain ⟨T,hT⟩ := compact_smooth_filter M.φ ht.1 hts
  have vreg : Regular (V : ℝ → ℝ) :=
    ⟨V.integrable, SchwartzMap.seminorm ℝ 0 0 V, SchwartzMap.norm_le_seminorm ℝ V⟩
  have treg : Regular (T : ℝ → ℝ) :=
    ⟨T.integrable, SchwartzMap.seminorm ℝ 0 0 T, SchwartzMap.norm_le_seminorm ℝ T⟩
  have ve (x : ℝ) : V (-x) = V x := by
    rw [← hV]; exact conv_even_pair M.even hwe _
  have te (x : ℝ) : T (-x) = T x := by
    rw [← hT]; exact conv_even_pair M.even hte _
  have va : conv V V = conv M.φ (conv M.φ (conv w w)) :=
    mollified_pair_identity M.φ hw.1 hw.1 hV hV
  have co : conv V T = conv M.φ (conv M.φ (conv w t)) :=
    mollified_pair_identity M.φ hw.1 ht.1 hV hT
  have vm : (∫ x, V x) = 1 := by rw [← hV,conv_mass M.φ.integrable hw.1,M.mass,hm,mul_one]
  have wc : energy V ≤ energy w := hV ▸ smooth_energy_le M.φ.integrable M.nonneg M.mass hw
  have tc : energy T ≤ energy t := hT ▸ smooth_energy_le M.φ.integrable M.nonneg M.mass ht
  have outside (x : ℝ) (hx : r < |x|) : M.φ x=0 := M.outside x hx.le
  have ws : Function.support (V : ℝ → ℝ) ⊆ Icc (-n/2) (n/2) := by
    intro x hx
    have h : |x| ≤ n/2 := by
      by_contra! hh
      apply hx
      rw [← hV]
      exact conv_zero_outside outside hws (by dsimp [n] at hh; linarith)
    exact ⟨by linarith [(abs_le.mp h).1],(abs_le.mp h).2⟩
  have ts : Function.support (T : ℝ → ℝ) ⊆ Icc (-d-n/2) (d+n/2) := by
    intro x hx
    have h : |x| ≤ d+n/2 := by
      by_contra! hh
      apply hx
      rw [← hT]
      apply conv_zero_outside outside hts
      dsimp [d,n] at hh
      linarith
    exact ⟨by linarith [(abs_le.mp h).1],(abs_le.mp h).2⟩
  have tp (x : ℝ) (hx : |x| < d-n/2) : T x = 1 := by
    rw [← hT,← M.mass]
    apply integral_congr_ae
    filter_upwards with y
    by_cases hy : |y| ≤ r
    · have hh : |x-y| < D-v/2 := (abs_sub x y).trans_lt (by dsimp [d,n] at hx; linarith)
      rw [htp _ hh,mul_one]
    · simp [outside y (lt_of_not_ge hy)]
  have ac (x : ℝ) : 0 ≤ conv V V x := by
    rw [va]; exact conv_nonneg M.nonneg (conv_nonneg M.nonneg ha) x
  have cov (x : ℝ) (hx : |x| < d) : 1 ≤ conv V T x := by
    rw [co]
    exact M.cover_twice (hw.1.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) ht.1) hc x hx
  let W : Witness n (α+4*r) β := {
    n := 1, σ := 2*d, p := fun _ => 1,
    w := fun _ => shift (n/2) V, t := fun _ => shift (d-n/2) T
    width_pos := nh, width_le := by linarith, alpha_pos := by linarith, beta_pos := hβ
    weight_nonneg := fun _ => zero_le_one
    total_weight := by simp
    window_regular := fun _ => vreg.shift _
    table_regular := fun _ => treg.shift _
    window_support := fun _ => by convert shift_support (n/2) ws using 2 <;> ring
    table_support := fun _ => by convert shift_support (d-n/2) ts using 2 <;> ring
    plateau := fun _ x hx => tp _ (abs_lt.mpr ⟨by linarith [hx.1],by linarith [hx.2]⟩)
    mass := fun _ => (integral_shift _ _).trans vm
    window_cost := by simpa [expectation,energy_shift] using wc.trans hew
    table_cost := by
      simp only [expectation,Fin.sum_univ_one,one_mul,energy_shift]
      dsimp [d]; linarith
    autocorrelation := fun x => by
      simpa [expectation, autocorr_shift, show rev (V : ℝ → ℝ) = V from funext ve] using ac x
    covering := fun x hx => by
      simp only [expectation,Fin.sum_univ_one,one_mul,conv_shift]
      apply cov
      exact abs_lt.mpr ⟨by linarith [hx.1],by linarith [hx.2]⟩ }
  have sc (a : ℝ) (g : RealSchwartz) : ContDiff ℝ ∞ (shift a g) :=
    g.smooth'.comp (contDiff_id.sub contDiff_const)
  refine ⟨⟨W,rfl,?_,rfl,?_,?_,?_,?_,?_,?_,?_,?_⟩⟩
  · intro i x
    change V (n-x-n/2)=V (x-n/2) ∧ T (2*d-n-x-(d-n/2))=T (x-(d-n/2))
    rw [show n-x-n/2 = -(x-n/2) by ring, show 2*d-n-x-(d-n/2) = -(x-(d-n/2)) by ring, ve,te]
    trivial
  · intro i; rw [hV]
  · intro i; rw [hT]
  · intro i
    exact ⟨sc _ _,HasCompactSupport.of_support_subset_isCompact isCompact_Icc (W.window_support i)⟩
  · intro i
    exact ⟨sc _ _,HasCompactSupport.of_support_subset_isCompact isCompact_Icc (W.table_support i)⟩
  · intro i; exact (energy_shift _ _).le.trans wc
  · intro i; exact (energy_shift _ _).le.trans tc
  · intro i x
    change conv (shift (n/2) V) (rev (shift (n/2) V)) x = _
    rw [autocorr_shift, show rev (V : ℝ → ℝ) = V from funext ve, va]
  · intro i x
    change conv (shift (n/2) V) (shift (d-n/2) T) x = _
    rw [conv_shift,show n/2+(d-n/2) = d by ring,co]

end
end MathLab.WT
