module
public import MathLab.WT.Basic
import Mathlib.MeasureTheory.Group.Integral
import Mathlib.MeasureTheory.Integral.Bochner.Set
import Mathlib.Tactic.Linarith

/-! Inserting a segment of unit height into the plateau preserves the excess
energy and the two boundary covers. The proof works with pointwise
representatives, without fixing the value of the input table at zero. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set
noncomputable section

def insertPlateau (d : ℝ) (f : ℝ → ℝ) (x : ℝ) : ℝ :=
  if x ≤ 0 then f x else if x ≤ d then 1 else f (x - d)

private lemma insert_parts {d : ℝ} (hd : 0 ≤ d) (f : ℝ → ℝ) (x : ℝ) :
    insertPlateau d f x = (Iic 0).indicator f x + (Ioc 0 d).indicator (fun _ => 1) x +
      (Ioi 0).indicator f (x - d) := by
  by_cases hn : x ≤ 0
  · have hz : ¬0 < x - d := by linarith
    simp [insertPlateau, Set.indicator, hn, not_lt.mpr hn, hz]
  · by_cases hx : x ≤ d
    · have hz : ¬0 < x - d := by linarith
      simp [insertPlateau, Set.indicator, hn, lt_of_not_ge hn, hx, hz]
    · have hz : 0 < x - d := by linarith
      simp [insertPlateau, Set.indicator, hn, hx, hz]

private lemma strip_integrable (d : ℝ) :
    Integrable ((Ioc (0 : ℝ) d).indicator (fun _ => (1 : ℝ))) :=
  (integrable_indicator_iff measurableSet_Ioc).mpr
    (integrableOn_const (measure_ne_top_of_subset Ioc_subset_Icc_self isCompact_Icc.measure_ne_top))

theorem insert_integrable {d : ℝ} (hd : 0 ≤ d) {f : ℝ → ℝ} (hf : Integrable f) :
    Integrable (insertPlateau d f) := by
  have he := ((hf.indicator (s := Iic (0 : ℝ)) measurableSet_Iic).add (strip_integrable d)).add
    ((hf.indicator (s := Ioi (0 : ℝ)) measurableSet_Ioi).comp_sub_right d)
  simpa only [funext (insert_parts hd f), Pi.add_def] using he

theorem integral_insert {d : ℝ} (hd : 0 ≤ d) {f : ℝ → ℝ} (hf : Integrable f) :
    ∫ x, insertPlateau d f x = (∫ x, f x) + d := by
  have hl := hf.indicator (s := Iic (0 : ℝ)) measurableSet_Iic
  have hr := hf.indicator (s := Ioi (0 : ℝ)) measurableSet_Ioi
  have hBoth : Integrable (fun x => (Iic 0).indicator f x +
      (Ioc 0 d).indicator (fun _ => (1 : ℝ)) x) := hl.add (strip_integrable d)
  have hparts : (∫ x, (Iic 0).indicator f x) + (∫ x, (Ioi 0).indicator f x) = ∫ x, f x := by
    rw [← integral_add hl hr]
    apply integral_congr_ae
    filter_upwards with x
    by_cases hx : x ≤ 0 <;> simp [Set.indicator, hx, not_lt.mpr, lt_of_not_ge]
  simp_rw [insert_parts hd f]
  rw [integral_add hBoth (hr.comp_sub_right d),
    integral_add hl (strip_integrable d), integral_sub_right_eq_self,
    integral_indicator_const _ measurableSet_Ioc, Real.volume_real_Ioc_of_le hd,
    sub_zero, smul_eq_mul, mul_one]
  linarith

theorem Regular.integrable_square {f : ℝ → ℝ} (hf : Regular f) :
    Integrable (fun x => (f x) ^ 2) := by
  obtain ⟨hi, B, hB⟩ := hf
  simpa only [sq] using hi.mul_bdd hi.aestronglyMeasurable
    (Filter.Eventually.of_forall (fun x => (show ‖f x‖ ≤ B from hB x)))

lemma energy_insert {d : ℝ} (hd : 0 ≤ d) {f : ℝ → ℝ} (hf : Regular f) :
    energy (insertPlateau d f) = energy f + d := by
  unfold energy
  rw [← integral_insert hd hf.integrable_square]
  apply integral_congr_ae
  filter_upwards with x
  unfold insertPlateau
  split_ifs <;> simp

lemma Regular.insertPlateau {f : ℝ → ℝ} (hf : Regular f) {d : ℝ} (hd : 0 ≤ d) :
    Regular (WT.insertPlateau d f) := by
  obtain ⟨hi, B, hB⟩ := hf
  refine ⟨insert_integrable hd hi, max B 1, ?_⟩
  intro x
  unfold WT.insertPlateau
  split_ifs
  · exact (hB _).trans (le_max_left ..)
  · simp
  · exact (hB _).trans (le_max_left ..)

private lemma within_window_ae {w : ℝ → ℝ} {v : ℝ} (hs : Function.support w ⊆ Icc 0 v) :
    ∀ᵐ y, w y = 0 ∨ y ∈ Ioo 0 v := by
  filter_upwards [volume.ae_ne (0 : ℝ), volume.ae_ne v] with y hy₀ hyv
  by_cases hw : w y = 0
  · exact Or.inl hw
  · obtain ⟨ha, hb⟩ := hs hw
    exact Or.inr ⟨ha.lt_of_ne hy₀.symm, hb.lt_of_ne hyv⟩

theorem conv_window_congr {w f g : ℝ → ℝ} {v x z : ℝ}
    (hs : Function.support w ⊆ Icc 0 v)
    (h : ∀ y ∈ Ioo 0 v, f (x-y) = g (z-y)) : conv w f x = conv w g z := by
  apply integral_congr_ae
  filter_upwards [within_window_ae hs] with y hy
  rcases hy with he | hi
  · simp [he]
  · rw [h _ hi]

variable {v α β : ℝ}

def Witness.extend (W : Witness v α β) (d : ℝ) (hd : 0 ≤ d) : Witness v α β where
  n := W.n
  σ := W.σ + d
  p := W.p
  w := W.w
  t := fun i => insertPlateau d (W.t i)
  width_pos := W.width_pos
  alpha_pos := W.alpha_pos
  beta_pos := W.beta_pos
  width_le := by linarith [W.width_le]
  weight_nonneg := W.weight_nonneg
  total_weight := W.total_weight
  window_regular := W.window_regular
  table_regular := fun i => (W.table_regular i).insertPlateau hd
  window_support := W.window_support
  table_support := by
    intro i x hx
    change insertPlateau d (W.t i) x ≠ 0 at hx
    by_cases hn : x ≤ 0
    · simp only [insertPlateau, hn, ite_true] at hx
      obtain ⟨hl, hr⟩ := W.table_support i hx
      exact ⟨hl, by linarith⟩
    · refine ⟨by linarith [W.width_pos], ?_⟩
      by_cases hx' : x ≤ d
      · linarith [W.width_pos, W.width_le]
      · simp only [insertPlateau, hn, hx', ite_false] at hx
        linarith [(W.table_support i hx).2]
  plateau := by
    intro i x hx
    simp only [insertPlateau, not_le.mpr hx.1, ite_false]
    split_ifs with h
    · rfl
    · exact W.plateau i _ ⟨by linarith, by linarith [hx.2]⟩
  mass := W.mass
  window_cost := W.window_cost
  table_cost := by
    simp_rw [energy_insert hd (W.table_regular _)]
    simp only [expectation, mul_add, Finset.sum_add_distrib, ← Finset.sum_mul, W.total_weight,
      one_mul]
    change (expectation W.p fun i => energy (W.t i)) + d ≤ _
    linarith [W.table_cost]
  autocorrelation := W.autocorrelation
  covering := by
    intro x hx
    by_cases left : x < v
    · have eq (i : Fin W.n) :
          conv (W.w i) (insertPlateau d (W.t i)) x = conv (W.w i) (W.t i) x := by
        apply conv_window_congr (W.window_support i)
        intro y hy
        by_cases hz : x-y ≤ 0
        · simp [insertPlateau, hz]
        · have hOld := W.plateau i (x-y) ⟨by linarith, by linarith [hy.1, W.width_le]⟩
          simp only [insertPlateau, hz, ite_false, hOld]
          split_ifs with hm
          · rfl
          · exact W.plateau i _ ⟨by linarith, by linarith [hy.1, W.width_le]⟩
      simpa only [eq] using W.covering x ⟨hx.1, by linarith [W.width_pos, W.width_le]⟩
    · by_cases mid : x ≤ v + d
      · have eq (i : Fin W.n) : conv (W.w i) (insertPlateau d (W.t i)) x = 1 := by
          rw [← W.mass i]
          apply integral_congr_ae
          filter_upwards [within_window_ae (W.window_support i)] with y hy
          rcases hy with he | hi
          · simp [he]
          · have hz : ¬ x-y ≤ 0 := by linarith [hi.2]
            simp only [insertPlateau, hz, ite_false]
            split_ifs with hm
            · simp
            · rw [W.plateau i _ ⟨by linarith, by linarith [hi.1, W.width_le]⟩, mul_one]
        simp [expectation, eq, W.total_weight]
      · have eq (i : Fin W.n) : conv (W.w i) (insertPlateau d (W.t i)) x =
            conv (W.w i) (W.t i) (x-d) := by
          apply conv_window_congr (W.window_support i)
          intro y hy
          have hz : ¬ x-y ≤ d := by linarith [hy.2]
          have hpos : ¬ x-y ≤ 0 := by linarith
          simp [insertPlateau, hz, hpos, show x-y-d=x-d-y by ring]
        simpa only [eq] using W.covering (x-d) ⟨by linarith [W.width_pos], by linarith [hx.2]⟩

end
end MathLab.WT
