module
public import MathLab.WT.LowerBoundPolynomial
public import MathLab.WT.LowerBoundDual
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

@[expose] public section
namespace MathLab.WT.AveragedTest

open MeasureTheory Set

noncomputable section

/-- Expected mass omitted at a point a distance `x` from one edge. -/
def shoulder (x : ℝ) : ℝ := (Icc 0 1).indicator trimTail x

def testDensity (l x : ℝ) : ℝ :=
  (Icc 0 l).indicator (fun t => 1 - shoulder t - shoulder (l-t)) x

def tailArea (s : ℝ) : ℝ := if s ≤ 1 then ∫ x in s..1, trimTail x else 0

def tailOverlap (s : ℝ) : ℝ :=
  if s ≤ 1 then ∫ x in (0:ℝ)..(1-s), trimTail x * trimTail (x+s) else 0

theorem shoulder_bounds (x : ℝ) : 0 ≤ shoulder x ∧ shoulder x ≤ 9/20 := by
  by_cases hx : x ∈ Icc (0:ℝ) 1
  · obtain ⟨hx0,hx1⟩ := hx
    simp only [shoulder, indicator_of_mem (show x ∈ Icc (0:ℝ) 1 from ⟨hx0,hx1⟩), trimTail]
    constructor
    · positivity
    · nlinarith only [hx0, sq_nonneg x]
  · norm_num [shoulder, indicator_of_notMem hx]

theorem shoulder_measurable : Measurable shoulder := by
  exact (by unfold trimTail; fun_prop : Continuous trimTail).measurable.indicator measurableSet_Icc

theorem shoulder_integrable : Integrable shoulder := by
  apply IntegrableOn.integrable_indicator _ measurableSet_Icc
  exact (by unfold trimTail; fun_prop : Continuous trimTail).continuousOn.integrableOn_compact isCompact_Icc

theorem density_bounds (l x : ℝ) : 0 ≤ testDensity l x ∧ testDensity l x ≤ 1 := by
  by_cases hx : x ∈ Icc (0:ℝ) l
  · simp only [testDensity, indicator_of_mem hx]
    obtain ⟨hx0,hx1⟩ := shoulder_bounds x
    obtain ⟨hy0,hy1⟩ := shoulder_bounds (l-x)
    constructor <;> linarith
  · simp [testDensity, indicator_of_notMem hx]

theorem density_measurable (l : ℝ) : Measurable (testDensity l) := by
  exact ((measurable_const.sub shoulder_measurable).sub
    (shoulder_measurable.comp (measurable_const.sub measurable_id))).indicator measurableSet_Icc

theorem density_regular (l : ℝ) : Regular (testDensity l) := by
  refine ⟨?_, 1, fun x => ?_⟩
  · have hj : Integrable ((Icc (0:ℝ) l).indicator (fun _ => (1:ℝ))) := by
      apply IntegrableOn.integrable_indicator _ measurableSet_Icc
      exact (integrableOn_const (by simp))
    apply hj.mono' (density_measurable l).aestronglyMeasurable
    filter_upwards with x
    rw [Real.norm_eq_abs, abs_of_nonneg (density_bounds l x).1]
    by_cases h : x ∈ Icc (0:ℝ) l
    · simpa [indicator_of_mem h] using (density_bounds l x).2
    · simp [testDensity, indicator_of_notMem h]
  · rw [abs_of_nonneg (density_bounds l x).1]
    exact (density_bounds l x).2

theorem tailArea_polynomial {s : ℝ} (hs : s ≤ 1) :
    tailArea s = 2*s^3/25 + 21*s^2/200 - 9*s/20 + 53/200 := by
  rw [tailArea, ite_eq_left hs]
  calc
    _ = (∫ x in s..1, 9/20 + (-21/100)*x + (-6/25)*x^2 + 0*x^3 + 0*x^4) := by
      apply intervalIntegral.integral_congr
      intro x _
      unfold trimTail
      ring
    _ = _ := by rw [integral_quartic]; ring

theorem tailOverlap_polynomial {s : ℝ} (hs : s ≤ 1) :
    tailOverlap s = -6*s^5/3125 + 1587*s^3/20000 -159*s^2/2500 -81*s/800 +4371/50000 := by
  rw [tailOverlap, ite_eq_left hs]
  calc
    _ = (∫ x in (0:ℝ)..(1-s), (-27*s^2/250 - 189*s/2000 + 81/400) +
      (63*s^2/1250 - 1719*s/10000 - 189/1000)*x +
      (36*s^2/625+189*s/1250-1719/10000)*x^2 +
      (72*s/625+63/625)*x^3 + (36/625)*x^4) := by
      apply intervalIntegral.integral_congr
      intro x _
      unfold trimTail
      ring
    _ = _ := by rw [integral_quartic]; ring

theorem maximum_via_overlaps {s : ℝ} (_hs : 0 ≤ s) :
    meanMaximum s = s + 2*tailArea s - 2*tailOverlap s := by
  by_cases h : s ≤ 1
  · rw [tailArea_polynomial h, tailOverlap_polynomial h, meanMaximum, ite_eq_left h]
    unfold integratedDifferenceCDF
    ring
  · simp [meanMaximum, tailArea, tailOverlap, h]

theorem weight_in_edge_units {s : ℝ} (hs : 0 ≤ s) :
    weight s = (14/15) * (s - 2*tailArea 0 + 2*tailArea s - 2*tailOverlap s +
      2*(5/7)*(1+shoulder s) - 2*(5/7)^2*(14/15)) := by
  rw [weight, maximum_via_overlaps hs, tailArea_polynomial (s := 0) (by norm_num)]
  by_cases h : s ≤ 1
  · simp only [ite_eq_left h, shoulder, indicator_of_mem (show s ∈ Icc 0 1 from ⟨hs,h⟩)]
    ring
  · simp only [ite_eq_right h, shoulder,
      indicator_of_notMem (show s ∉ Icc 0 1 from fun c => h c.2)]
    ring

private theorem restrictInterval {a b L : ℝ} (ha : 0 ≤ a) (hab : a ≤ b) (hb : b ≤ L)
    (f g : ℝ → ℝ) (h : ∀ x ∈ Icc 0 L, f x = (Icc a b).indicator g x) :
    (∫ x in (0:ℝ)..L, f x) = ∫ x in a..b, g x := by
  rw [intervalIntegral.integral_of_le (ha.trans (hab.trans hb)), ← integral_Icc_eq_integral_Ioc,
    intervalIntegral.integral_of_le hab, ← integral_Icc_eq_integral_Ioc]
  calc
    _ = ∫ x in Icc 0 L, (Icc a b).indicator g x := setIntegral_congr_fun measurableSet_Icc h
    _ = _ := by rw [setIntegral_indicator measurableSet_Icc,
                      inter_eq_right.mpr (Icc_subset_Icc ha hb)]

theorem shoulder_zero {x : ℝ} (hx : 1 < x) : shoulder x = 0 :=
  indicator_of_notMem (fun (m : x ∈ Icc (0:ℝ) 1) => (not_le_of_gt hx) m.2) _

theorem shoulder_shift_integral {s L : ℝ} (hs : 0 ≤ s) (hL : 1 ≤ L) :
    (∫ x in (0:ℝ)..L, shoulder (x+s)) = tailArea s := by
  by_cases h : s ≤ 1
  · rw [tailArea, ite_eq_left h]
    calc
      _ = ∫ x in (0:ℝ)..(1-s), trimTail (x+s) := by
        apply restrictInterval (le_refl _) (by linarith) (by linarith)
        intro x hx
        by_cases h' : x ≤ 1-s
        · rw [indicator_of_mem (show x ∈ Icc 0 (1-s) from ⟨hx.1,h'⟩)]
          exact indicator_of_mem (show x+s ∈ Icc (0:ℝ) 1 from ⟨by linarith [hx.1],by linarith⟩) _
        · rw [indicator_of_notMem (fun (m : x ∈ Icc 0 (1-s)) => h' m.2)]
          exact shoulder_zero (by linarith)
      _ = _ := by rw [intervalIntegral.integral_comp_add_right]; simp
  · rw [tailArea, ite_eq_right h]
    conv_rhs => rw [← intervalIntegral.integral_zero (a:=0) (b:=L) (E:=ℝ) (μ:=volume)]
    apply intervalIntegral.integral_congr
    intro x hx
    rw [uIcc_of_le (by linarith : 0 ≤ L)] at hx
    exact shoulder_zero (by linarith [hx.1])

theorem shoulder_overlap_integral {s L : ℝ} (hs : 0 ≤ s) (hL : 1 ≤ L) :
    (∫ x in (0:ℝ)..L, shoulder x * shoulder (x+s)) = tailOverlap s := by
  by_cases h : s ≤ 1
  · rw [tailOverlap, ite_eq_left h]
    apply restrictInterval (le_refl _) (by linarith) (by linarith)
    intro x hx
    by_cases h' : x ≤ 1-s
    · rw [indicator_of_mem (show x ∈ Icc 0 (1-s) from ⟨hx.1,h'⟩)]
      simp only [shoulder, indicator_of_mem (show x ∈ Icc (0:ℝ) 1 from ⟨hx.1,by linarith⟩),
        indicator_of_mem (show x+s ∈ Icc (0:ℝ) 1 from ⟨by linarith [hx.1],by linarith⟩)]
    · rw [indicator_of_notMem (fun (m : x ∈ Icc 0 (1-s)) => h' m.2), shoulder_zero (x:=x+s) (by linarith), mul_zero]
  · rw [tailOverlap, ite_eq_right h]
    conv_rhs => rw [← intervalIntegral.integral_zero (a:=0) (b:=L) (E:=ℝ) (μ:=volume)]
    apply intervalIntegral.integral_congr
    intro x hx
    rw [uIcc_of_le (by linarith : 0 ≤ L)] at hx
    change shoulder x * shoulder (x+s) = 0
    rw [shoulder_zero (x:=x+s) (by linarith [hx.1]), mul_zero]

private def edgeLoss (s x : ℝ) := shoulder x + shoulder (x+s) - shoulder x * shoulder (x+s)

private theorem shoulder_regular : Regular shoulder := by
  refine ⟨shoulder_integrable, 9/20, fun x => ?_⟩
  rw [abs_of_nonneg (shoulder_bounds x).1]
  exact (shoulder_bounds x).2

private theorem edgeLoss_integrable (s : ℝ) : Integrable (edgeLoss s) := by
  have hr : Regular (fun x => shoulder (x+s)) :=
    ⟨shoulder_integrable.comp_add_right s, 9/20, fun x => by
      rw [abs_of_nonneg (shoulder_bounds (x+s)).1]; exact (shoulder_bounds _).2⟩
  exact (shoulder_integrable.add hr.1).sub (reg_mul shoulder_regular hr)

private theorem edgeLoss_integral {s L : ℝ} (hs : 0 ≤ s) (hL : 1 ≤ L) :
    (∫ x in (0:ℝ)..L, edgeLoss s x) = tailArea 0 + tailArea s - tailOverlap s := by
  have hr : Regular (fun x => shoulder (x+s)) :=
    ⟨shoulder_integrable.comp_add_right s, 9/20, fun x => by
      rw [abs_of_nonneg (shoulder_bounds (x+s)).1]; exact (shoulder_bounds _).2⟩
  unfold edgeLoss
  rw [intervalIntegral.integral_sub (f:=fun x => shoulder x + shoulder (x+s)) ((shoulder_integrable.add hr.1).intervalIntegrable ..)
      ((reg_mul shoulder_regular hr).intervalIntegrable ..),
    intervalIntegral.integral_add (shoulder_integrable.intervalIntegrable ..) (hr.1.intervalIntegrable ..),
    shoulder_shift_integral hs hL, shoulder_overlap_integral hs hL]
  rw [show (∫ x in (0:ℝ)..L, shoulder x) = tailArea 0 from by
    simpa using shoulder_shift_integral (s := 0) (by norm_num) hL]

theorem density_reflect (l x : ℝ) : testDensity l (l-x) = testDensity l x := by
  by_cases h : x ∈ Icc (0:ℝ) l
  · simp only [testDensity, indicator_of_mem h, indicator_of_mem (show l-x ∈ Icc 0 l from
      ⟨by linarith [h.2], by linarith [h.1]⟩), sub_sub_cancel]
    ring
  · simp only [testDensity, indicator_of_notMem h, indicator_of_notMem (show l-x ∉ Icc 0 l from
      fun m => h ⟨by linarith [m.2],by linarith [m.1]⟩)]

theorem testDensity_mass {l : ℝ} (hl : 1 ≤ l) : (∫ x, testDensity l x) = l - 2*tailArea 0 := by
  unfold testDensity
  rw [integral_indicator measurableSet_Icc, integral_Icc_eq_integral_Ioc,
    ← intervalIntegral.integral_of_le (by linarith : 0 ≤ l)]
  have hi := shoulder_integrable.intervalIntegrable (a:=0) (b:=l)
  have hr := (shoulder_integrable.comp_sub_left l).intervalIntegrable (a:=0) (b:=l)
  rw [intervalIntegral.integral_sub ((intervalIntegrable_const).sub hi) hr,
    intervalIntegral.integral_sub intervalIntegrable_const hi, intervalIntegral.integral_comp_sub_left,
    intervalIntegral.integral_const]
  have hus : (∫ x in (0:ℝ)..l, shoulder x) = tailArea 0 := by
    simpa using shoulder_shift_integral (s:=0) (by norm_num) hl
  simp only [sub_self, sub_zero, smul_eq_mul, mul_one, hus]
  ring

theorem density_overlap {l s : ℝ} (hs : 0 ≤ s) (hl : 2+s < l) :
    (∫ x, testDensity l x * testDensity l (x+s)) =
      l-s - 2*tailArea 0 - 2*tailArea s + 2*tailOverlap s := by
  have hL : 1 ≤ l-s := by linarith
  have hb : 0 ≤ l-s := by linarith
  have zero_out (x : ℝ) (hx : x ∉ Icc 0 (l-s)) : testDensity l x * testDensity l (x+s) = 0 := by
    by_cases hx' : 0 ≤ x
    · have hz : x+s ∉ Icc 0 l := fun m => hx ⟨hx',by linarith [m.2]⟩
      simp [testDensity, indicator_of_notMem hz]
    · simp [testDensity, indicator_of_notMem (show x ∉ Icc 0 l from fun m => hx' m.1)]
  rw [← setIntegral_eq_integral_of_forall_compl_eq_zero zero_out,
    integral_Icc_eq_integral_Ioc, ← intervalIntegral.integral_of_le hb]
  calc
    _ = ∫ x in (0:ℝ)..(l-s), 1 - edgeLoss s x - edgeLoss s (l-s-x) := by
      apply intervalIntegral.integral_congr
      intro x hx
      rw [uIcc_of_le hb] at hx
      simp only [testDensity, indicator_of_mem (show x ∈ Icc 0 l from ⟨hx.1,by linarith [hx.2]⟩),
        indicator_of_mem (show x+s ∈ Icc 0 l from ⟨by linarith [hx.1],by linarith [hx.2]⟩), edgeLoss,
        show l-(x+s) = l-s-x by ring, show l-s-x+s = l-x by ring]
      by_cases h : x ≤ 1
      · rw [shoulder_zero (x:=l-s-x) (by linarith), shoulder_zero (x:=l-x) (by linarith)]
        ring
      · rw [shoulder_zero (x:=x) (by linarith), shoulder_zero (x:=x+s) (by linarith)]
        ring
    _ = _ := by
      have eint := (edgeLoss_integrable s).intervalIntegrable (a:=0) (b:=l-s)
      have rint := ((edgeLoss_integrable s).comp_sub_left (l-s)).intervalIntegrable (a:=0) (b:=l-s)
      rw [intervalIntegral.integral_sub ((intervalIntegrable_const).sub eint) rint,
        intervalIntegral.integral_sub intervalIntegrable_const eint,
        intervalIntegral.integral_comp_sub_left, intervalIntegral.integral_const]
      simp only [sub_self, sub_zero, smul_eq_mul, mul_one, edgeLoss_integral hs hL]
      ring
end

end MathLab.WT.AveragedTest
