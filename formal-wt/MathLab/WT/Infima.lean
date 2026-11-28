module
public import MathLab.WT.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Set
import Mathlib.Tactic.Linarith

/-! A concrete common witness prevents vacuous real infima. The order argument
uses continuity of the product objective with the *same* error in both budgets. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set Filter Topology
noncomputable section

def box (a b : ℝ) : ℝ → ℝ := (Icc a b).indicator (fun _ => 1)

lemma box_integral {a b : ℝ} (h : a ≤ b) : ∫ x, box a b x = b - a := by
  change ∫ x, (Icc a b).indicator (1 : ℝ → ℝ) x = _
  rw [integral_indicator_one measurableSet_Icc, Real.volume_real_Icc_of_le h]

lemma box_energy {a b : ℝ} (h : a ≤ b) : energy (box a b) = b - a := by
  rw [← box_integral h]
  apply integral_congr_ae
  filter_upwards with x
  by_cases hx : x ∈ Icc a b <;> simp [box, hx]

lemma box_regular (a b : ℝ) : Regular (box a b) := by
  refine ⟨(integrable_indicator_iff measurableSet_Icc).mpr
    (integrableOn_const isCompact_Icc.measure_ne_top), 1, ?_⟩
  intro x
  by_cases hx : x ∈ Icc a b <;> simp [box, hx]

lemma box_support (a b : ℝ) : Function.support (box a b) ⊆ Icc a b := by
  intro x hx
  by_contra h
  exact hx (by simp [box, h])

lemma box_reflect (a b x : ℝ) : box a b (a + b - x) = box a b x := by
  have equiv : a + b - x ∈ Icc a b ↔ x ∈ Icc a b := by
    simp only [mem_Icc]
    constructor <;> rintro ⟨h, h'⟩ <;> constructor <;> linarith
  simp [box, Set.indicator, equiv]

lemma box_nonneg (a b x : ℝ) : 0 ≤ box a b x := by
  by_cases hx : x ∈ Icc a b <;> simp [box, hx]

def classic : Witness 1 1 1 where
  n := 1
  σ := 2
  p := fun _ => 1
  w := fun _ => box 0 1
  t := fun _ => box (-1) 2
  width_pos := by norm_num
  alpha_pos := by norm_num
  beta_pos := by norm_num
  width_le := by norm_num
  weight_nonneg := by simp
  total_weight := by simp
  window_regular := fun _ => box_regular _ _
  table_regular := fun _ => box_regular _ _
  window_support := fun _ => box_support _ _
  table_support := fun _ => box_support _ _
  plateau := by
    intro i x hx
    have h : x ∈ Icc (-1 : ℝ) 2 := ⟨by linarith [hx.1], by linarith [hx.2]⟩
    simp [box, h]
  mass := by simp [box_integral (zero_le_one : (0 : ℝ) ≤ 1)]
  table_cost := by norm_num [expectation, box_energy (by norm_num : (-1 : ℝ) ≤ 2)]
  window_cost := by norm_num [expectation, box_energy (by norm_num : (0 : ℝ) ≤ 1)]
  autocorrelation := by
    intro x
    simp only [expectation, Fin.sum_univ_one, one_mul]
    exact integral_nonneg (fun y => mul_nonneg (box_nonneg _ _ _) (box_nonneg _ _ _))
  covering := by
    intro x hx
    simp only [expectation, Fin.sum_univ_one, one_mul]
    have key (y : ℝ) : box 0 1 y * box (-1) 2 (x - y) = box 0 1 y := by
      by_cases hy : y ∈ Icc (0 : ℝ) 1
      · have hz : x - y ∈ Icc (-1 : ℝ) 2 :=
          ⟨by linarith [hx.1, hy.2], by linarith [hx.2, hy.1]⟩
        simp [box, hz]
      · simp [box, hy]
    simpa only [conv, key, box_integral zero_le_one, sub_zero] using (le_refl (1 : ℝ))

theorem classic_symmetric : classic.Symmetric := by
  intro i x
  constructor
  · change box 0 1 (1 - x) = box 0 1 x
    simpa only [zero_add] using box_reflect 0 1 x
  · change box (-1) 2 (2 - 1 - x) = box (-1) 2 x
    convert box_reflect (-1) 2 x using 2
    norm_num

private lemma accepts_classic (k : Kind) : k.accepts classic := by
  cases k with
  | unrestricted => trivial
  | deterministic => rfl
  | symmetric => exact classic_symmetric
  | both => exact ⟨rfl, classic_symmetric⟩
  | symmetricMeans => exact classic_symmetric.means

theorem values_nonempty (k : Kind) : (values k).Nonempty :=
  ⟨_, 1, 1, 1, classic, accepts_classic k, rfl⟩

theorem values_bddBelow (k : Kind) : BddBelow (values k) := by
  refine ⟨0, ?_⟩
  rintro _ ⟨_, α, β, _, _, rfl⟩
  exact mul_nonneg (by norm_num) (Real.sqrt_nonneg _)

private lemma both_accepts {v α β : ℝ} {W : Witness v α β}
    (h : Kind.both.accepts W) (k : Kind) : k.accepts W := by
  cases k with
  | unrestricted => trivial
  | deterministic => exact h.1
  | symmetric => exact h.2
  | both => exact h
  | symmetricMeans => exact h.2.means

/-- A subclass realizing both enlarged budgets is cofinal for the WT objective. -/
theorem sInf_eq_of_approx_values {S : Set ℝ} (hsub : S ⊆ values .unrestricted)
    (happ : ∀ (v α β : ℝ), Witness v α β → ∀ e : ℝ, 0 < e → objective (α+e) (β+e) ∈ S) :
    sInf S = infimum .unrestricted := by
  have hne : S.Nonempty := ⟨_,happ 1 1 1 classic 1 zero_lt_one⟩
  have hb : BddBelow S := (values_bddBelow .unrestricted).mono hsub
  apply le_antisymm
  · apply le_csInf (values_nonempty .unrestricted)
    rintro _ ⟨v, α, β, W, _, rfl⟩
    have hp : Tendsto (fun e : ℝ => objective (α + e) (β + e)) (𝓝[>] 0)
        (𝓝 (objective α β)) := by
      have hc : Continuous (fun e : ℝ => objective (α + e) (β + e)) := by
        unfold objective
        fun_prop
      simpa only [add_zero] using
        (hc.continuousAt.tendsto (x := (0 : ℝ))).mono_left
          (nhdsWithin_le_nhds (s := Ioi (0 : ℝ)))
    apply ge_of_tendsto hp
    filter_upwards [self_mem_nhdsWithin] with e he
    exact csInf_le hb (happ v α β W e he)
  · apply le_csInf hne
    exact fun x hx => csInf_le (values_bddBelow .unrestricted) (hsub hx)

theorem infimum_eq_of_approximation (approx : SimultaneousApproximation) (k : Kind) :
    infimum k = infimum .unrestricted := by
  apply sInf_eq_of_approx_values (S:=values k)
  · rintro _ ⟨v,α,β,W,_,rfl⟩
    exact ⟨v,α,β,W,trivial,rfl⟩
  · intro v α β W e he
    obtain ⟨v',W',hd,hs⟩ := approx v α β W e he
    exact ⟨v',_,_,W',both_accepts ⟨hd,hs⟩ k,rfl⟩

theorem not_conjecture71_of_approximation (approx : SimultaneousApproximation) :
    ¬ conjecture71 := by
  intro h
  exact (ne_of_lt h.1) (infimum_eq_of_approximation approx .deterministic).symm

end
end MathLab.WT
