module
public import MathLab.WT.Coordinates
public import MathLab.WT.Extension
public import MathLab.WT.WindowRepair
import Mathlib.Tactic.Linarith

/-! Two separated shoulder bands. A piecewise-constant cutoff suffices for the
WT function space. The change in squared energy is estimated in Lebesgue
measure, including the cross term and the loss in covering length. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set Filter
noncomputable section

def shoulderBand (L R : ℝ) := {x : ℝ | abs (|x| - L) ≤ R}
def shoulderMask (L R : ℝ) := (shoulderBand L R).indicator (fun _ : ℝ => (1 : ℝ))

theorem measurable_shoulderBand (L R : ℝ) : MeasurableSet (shoulderBand L R) :=
  measurableSet_le (by fun_prop) measurable_const

theorem shoulderMask_measurable (L R : ℝ) : Measurable (shoulderMask L R) :=
  measurable_const.indicator (measurable_shoulderBand L R)

theorem shoulderMask_range (L R x : ℝ) : shoulderMask L R x ∈ Icc 0 1 := by
  by_cases h : x ∈ shoulderBand L R <;> simp [shoulderMask, h]

lemma shoulderBand_subset (L R : ℝ) : shoulderBand L R ⊆ Icc (-(L+R)) (L+R) := by
  intro x hx
  have h := (abs_le.mp (show abs (|x| - L) ≤ R from hx)).2
  exact abs_le.mp (by linarith)

theorem shoulderMask_integrable (L R : ℝ) : Integrable (shoulderMask L R) :=
  (integrable_indicator_iff (measurable_shoulderBand L R)).mpr (integrableOn_const
    (measure_ne_top_of_subset (shoulderBand_subset L R) isCompact_Icc.measure_ne_top))

theorem shoulderMask_even (L R x : ℝ) : shoulderMask L R (-x) = shoulderMask L R x := by
  have h : -x ∈ shoulderBand L R ↔ x ∈ shoulderBand L R := by
    change abs (|-x| - L) ≤ R ↔ abs (|x| - L) ≤ R
    rw [abs_neg]
  by_cases hx : x ∈ shoulderBand L R
  · simp [shoulderMask, hx, h.mpr hx]
  · simp [shoulderMask, hx, h.not.mpr hx]

lemma bandDist_lipschitz (L x y : ℝ) : abs (|x-y| - L) ≤ abs (|x| - L) + |y| := by
  have h := abs_sub_le |x-y| |x| L
  have h' := abs_abs_sub_abs_le_abs_sub (x-y) x
  rw [sub_sub_cancel_left, abs_neg] at h'
  linarith

lemma abs_sub_le_sum (x y : ℝ) : |x-y| ≤ |x|+|y| := by
  simpa only [sub_eq_add_neg, abs_neg] using abs_add_le x (-y)

theorem conv_mask_supported {V : ℝ → ℝ} {L R M : ℝ}
    (hV : ∀ y, M < |y| → V y = 0) {x : ℝ} (hx : R+M < abs (|x| - L)) :
    conv V (shoulderMask L R) x = 0 := by
  apply integral_eq_zero_of_ae (Eventually.of_forall ?_)
  intro y
  by_cases hy : M < |y|
  · simp [hV y hy]
  · have h := bandDist_lipschitz L (x-y) (-y)
    simp only [sub_neg_eq_add, sub_add_cancel, abs_neg] at h
    have hz : x-y ∉ shoulderBand L R := fun hz => by
      change abs (|x-y| - L) ≤ R at hz
      linarith [le_of_not_gt hy]
    simp [shoulderMask, hz]

theorem conv_even_pair {f g : ℝ → ℝ} (hf : ∀ x, f (-x) = f x) (hg : ∀ x, g (-x) = g x)
    (x : ℝ) : conv f g (-x) = conv f g x := by
  have hfm : mirror 0 f = f := funext fun y => by simp [mirror, hf]
  have hgm : mirror 0 g = g := funext fun y => by simp [mirror, hg]
  simpa only [hfm, hgm, add_zero, zero_sub] using (conv_mirror 0 0 f g x).symm

theorem conv_on_plateau {f t : ℝ → ℝ} {M R : ℝ}
    (hs : ∀ y, M < |y| → f y = 0) (hm : ∫ y, f y = 1)
    (hp : ∀ y, |y| ≤ R → t y = 1) {x : ℝ} (hx : |x| ≤ R-M) : conv f t x = 1 := by
  rw [← hm]
  apply integral_congr_ae (Eventually.of_forall ?_)
  intro y
  by_cases hy : M < |y|
  · simp [hs y hy]
  · have h : |x-y| ≤ R := by linarith [abs_sub_le_sum x y, le_of_not_gt hy]
    rw [hp _ h, mul_one]

def clipTable (L R : ℝ) (U : ℝ → ℝ) (x : ℝ) :=
  if |x| ≤ L-R then 1 else if |x| ≤ L+R then U x else 0

theorem clipTable_even {U : ℝ → ℝ} (h : ∀ x, U (-x) = U x) (L R x : ℝ) :
    clipTable L R U (-x) = clipTable L R U x := by simp [clipTable, h]

theorem clipTable_zero {U : ℝ → ℝ} {L R x : ℝ} (hR : 0 ≤ R) (hx : L+R < |x|) :
    clipTable L R U x = 0 := by
  simp [clipTable, not_le.mpr hx, show ¬ |x| ≤ L-R by linarith]

theorem clipTable_regular {U : ℝ → ℝ} (hU : Regular U) {L R : ℝ} : Regular (clipTable L R U) := by
  let S := Icc (-(L-R)) (L-R)
  let T := Icc (-(L+R)) (L+R)
  have eq : clipTable L R U = S.indicator (fun _ : ℝ => (1 : ℝ)) +
      T.indicator (Sᶜ.indicator U) := by
    ext x
    have s : x ∈ S ↔ |x| ≤ L-R := abs_le.symm
    have t : x ∈ T ↔ |x| ≤ L+R := abs_le.symm
    by_cases hs : x ∈ S <;> by_cases ht : x ∈ T <;>
      simp [clipTable, Set.indicator, hs, ht, ← s, ← t, Pi.add_apply]
  have hi : Integrable (S.indicator (fun _ : ℝ => (1 : ℝ))) :=
    (integrable_indicator_iff measurableSet_Icc).mpr (integrableOn_const isCompact_Icc.measure_ne_top)
  obtain ⟨h, B, hB⟩ := hU
  refine ⟨eq ▸ hi.add ((h.indicator (s := Sᶜ) measurableSet_Icc.compl).indicator
    (s := T) measurableSet_Icc), max 1 B, ?_⟩
  intro x
  dsimp [clipTable]
  split_ifs
  · simp
  · exact (hB x).trans (le_max_right ..)
  · simp only [abs_zero]; exact (zero_le_one' ℝ).trans (le_max_left ..)

theorem clipTable_error {U : ℝ → ℝ} {L R e : ℝ} (he : 0 ≤ e)
    (hi : ∀ x, |x| ≤ L-R → |U x-1| ≤ e) (ho : ∀ x, L+R < |x| → |U x| ≤ e)
    (x : ℝ) : |clipTable L R U x - U x| ≤ e := by
  unfold clipTable
  split_ifs with hx h'
  · rw [abs_sub_comm]; exact hi _ hx
  · simpa using he
  · simpa using ho _ (lt_of_not_ge h')

lemma energy_compare_interval {f g : ℝ → ℝ} (hf : Regular f) (hg : Regular g) {S e : ℝ}
    (hS : 0 ≤ S) (_he : 0 ≤ e) (hi : ∀ x, |x| ≤ S → f x ^ 2 - g x ^ 2 ≤ e)
    (ho : ∀ x, S < |x| → f x ^ 2 ≤ g x ^ 2) :
    energy f ≤ energy g + 2*S*e := by
  let b := (Icc (-S) S).indicator (fun _ : ℝ => e)
  have hb : Integrable b := (integrable_indicator_iff measurableSet_Icc).mpr
    (integrableOn_const isCompact_Icc.measure_ne_top)
  have h := integral_mono (hf.integrable_square.sub hg.integrable_square) hb
    (fun x => (show f x^2-g x^2 ≤ b x by
      by_cases hx : |x| ≤ S
      · simpa [b, abs_le.mp hx] using hi x hx
      · have hxin : x ∉ Icc (-S) S := fun hh => hx (abs_le.mpr hh)
        simpa [b, hxin] using sub_nonpos.mpr (ho x (lt_of_not_ge hx))))
  simp only [Pi.sub_apply, integral_sub hf.integrable_square hg.integrable_square] at h
  change _ ≤ ∫ x, (Icc (-S) S).indicator (fun _ => e) x at h
  rw [integral_indicator_const _ measurableSet_Icc, Real.volume_real_Icc_of_le (by linarith),
    smul_eq_mul] at h
  unfold energy
  linarith

theorem clipTable_energy {U : ℝ → ℝ} (hU : Regular U) {L R e : ℝ} (hL : 0 ≤ L)
    (hR : 0 ≤ R) (he : 0 ≤ e) (hi : ∀ x, |x| ≤ L-R → |U x-1| ≤ e) :
    energy (clipTable L R U) ≤ energy U + 2*L*(2*e) := by
  apply energy_compare_interval (clipTable_regular hU) hU hL (by positivity)
  · intro x _
    unfold clipTable
    split_ifs with h h'
    · have hb := (abs_le.mp (hi x h)).1
      nlinarith [sq_nonneg (U x-1)]
    · linarith
    · nlinarith [sq_nonneg (U x)]
  · intro x hx
    unfold clipTable
    have h : ¬ |x| ≤ L-R := by linarith
    simp only [h, ite_false]
    split_ifs <;> nlinarith [sq_nonneg (U x)]

end
end MathLab.WT
