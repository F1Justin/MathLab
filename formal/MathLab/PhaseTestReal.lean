module

public import Mathlib.Tactic.Linarith
public import Mathlib.Tactic.FieldSimp
public import Mathlib.Algebra.Order.Archimedean.Real.Basic
public import Mathlib.Topology.Order.IntermediateValue
public import Mathlib.Topology.Instances.Real.Lemmas
public import MathLab.PhaseTest

@[expose] public section

namespace PhaseTest

abbrev Band (d : ℝ) (k : ℤ) (y : ℝ) : Prop :=
  (k : ℝ) - d ≤ y ∧ y ≤ (k : ℝ) + d

theorem half_gap {d : ℝ} (hd : d < 1 / 2) (k : ℤ) :
    ¬ ∃ j : ℤ, Band d j ((k : ℝ) + 1 / 2) := by
  rintro ⟨j, hjL, hjU⟩
  by_cases h : j ≤ k
  · have h' : (j : ℝ) ≤ (k : ℝ) := by exact_mod_cast h
    linarith only [hjU, h', hd]
  · have hz : k + 1 ≤ j := by omega
    have h' : (k : ℝ) + 1 ≤ (j : ℝ) := by exact_mod_cast hz
    linarith only [hjL, h', hd]

-- If every intermediate value from A to B is covered, the label at B
-- cannot be a strictly larger integer than the label at A.
private theorem no_rise {A B d : ℝ} {k l : ℤ}
    (hd : d < 1 / 2) (hk : Band d k A) (hl : Band d l B)
    (mid : ∀ y : ℝ, A ≤ y → y ≤ B → ∃ j : ℤ, Band d j y) :
    l ≤ k := by
  by_contra! h
  have hz : k + 1 ≤ l := by omega
  have hstep : (k : ℝ) + 1 ≤ (l : ℝ) := by exact_mod_cast hz
  have ha : A ≤ (k : ℝ) + 1 / 2 := by linarith only [hk.2, hd]
  have hb : (k : ℝ) + 1 / 2 ≤ B := by
    linarith only [hl.1, hstep, hd]
  exact half_gap hd k (mid _ ha hb)

theorem endpoint_winding {a b d : ℝ} {f : ℝ → ℝ}
    (hab : a ≤ b) (hd : d < 1 / 2)
    (hf : ContinuousOn f (Set.Icc a b))
    (h : ∀ x ∈ Set.Icc a b, ∃ k : ℤ, Band d k (f x)) :
    ∃ k : ℤ, Band d k (f a) ∧ Band d k (f b) := by
  obtain ⟨k, hk⟩ := h a ⟨le_rfl, hab⟩
  obtain ⟨l, hl⟩ := h b ⟨hab, le_rfl⟩
  have covered : ∀ {y : ℝ}, y ∈ f '' Set.Icc a b →
      ∃ j : ℤ, Band d j y := by
    rintro y ⟨x, hx, rfl⟩
    exact h x hx
  have hlk : l ≤ k := by
    apply no_rise hd hk hl
    intro y hA hB
    exact covered (intermediate_value_Icc hab hf ⟨hA, hB⟩)
  have hkl : k ≤ l := by
    apply no_rise hd hl hk
    intro y hB hA
    exact covered (intermediate_value_Icc' hab hf ⟨hB, hA⟩)
  have e : l = k := le_antisymm hlk hkl
  subst l
  exact ⟨k, hk, hl⟩

theorem affine_constraints {a b v s d : ℝ}
    (hab : a ≤ b) (hd : d < 1 / 2)
    (h : ∀ x ∈ Set.Icc a b, ∃ k : ℤ, Band d k (v * x + s)) :
    ∃ k : ℤ,
      (Band d k (v * a + s) ∧ Band d k (v * b + s)) ∧
      v * (b - a) ≤ 2 * d ∧
      (k : ℝ) - v * a - d ≤ s ∧ s ≤ (k : ℝ) - v * b + d := by
  obtain ⟨k, ha, hb⟩ :=
    endpoint_winding (f := fun x : ℝ => v * x + s) hab hd (by fun_prop) h
  refine ⟨k, ⟨ha, hb⟩, ?_, ?_, ?_⟩
  · nlinarith only [ha.1, hb.2]
  · linarith only [ha.1]
  · linarith only [hb.2]

-- Nonnegative slope is needed for sufficiency of THESE two inequalities.
theorem affine_iff {a b v s d : ℝ}
    (hab : a ≤ b) (hv : 0 ≤ v) (hd : d < 1 / 2) :
    (∀ x ∈ Set.Icc a b, ∃ k : ℤ, Band d k (v * x + s)) ↔
      ∃ k : ℤ, (k : ℝ) - v * a - d ≤ s ∧ s ≤ (k : ℝ) - v * b + d := by
  constructor
  · intro h
    obtain ⟨k, _, _, hL, hU⟩ := affine_constraints hab hd h
    exact ⟨k, hL, hU⟩
  · rintro ⟨k, hL, hU⟩ x hx
    refine ⟨k, ?_, ?_⟩
    · linarith only [hL, mul_le_mul_of_nonneg_left hx.1 hv]
    · linarith only [hU, mul_le_mul_of_nonneg_left hx.2 hv]

-- The SAME rounding map preserves membership in every closed window
-- with integer endpoints; no common rounding choice has to be searched.
theorem floor_in_window {i : Window} {P : ℝ}
    (hL : (i.lo : ℝ) ≤ P) (hU : P ≤ (i.hi : ℝ)) :
    InWin i ⌊P⌋ := by
  constructor
  · exact Int.le_floor.mpr hL
  · have hh : (⌊P⌋ : ℝ) ≤ (i.hi : ℝ) := (Int.floor_le P).trans hU
    exact_mod_cast hh

theorem real_fixed_iff (ws : List Window) :
    (∃ P : ℝ, ∀ i ∈ ws, (i.lo : ℝ) ≤ P ∧ P ≤ (i.hi : ℝ)) ↔
      fixedOK ws = true := by
  rw [fixedOK_spec]
  constructor
  · rintro ⟨P, h⟩
    exact ⟨⌊P⌋, fun i hi => floor_in_window (h i hi).1 (h i hi).2⟩
  · rintro ⟨p, h⟩
    refine ⟨(p : ℝ), ?_⟩
    intro i hi
    obtain ⟨hL, hU⟩ := h i hi
    exact ⟨by exact_mod_cast hL, by exact_mod_cast hU⟩

-- Time is [i.lo / D, i.hi / D], distance bound is r / D,
-- unscaled phase is s, and scaled phase is s * D.
theorem scaled_ends {D v r : ℤ} (hD : 0 < D)
    (i : Window) (k : ℤ) (s : ℝ) :
    ((k : ℝ) - (v : ℝ) * ((i.lo : ℝ) / D) - (r : ℝ) / D ≤ s ∧
      s ≤ (k : ℝ) - (v : ℝ) * ((i.hi : ℝ) / D) + (r : ℝ) / D) ↔
    (((phaseWin D v r i k).lo : ℝ) ≤ s * (D : ℝ) ∧
      s * (D : ℝ) ≤ ((phaseWin D v r i k).hi : ℝ)) := by
  have hpos : 0 < (D : ℝ) := by exact_mod_cast hD
  have eL :
      (k : ℝ) - (v : ℝ) * ((i.lo : ℝ) / D) - (r : ℝ) / D =
        ((phaseWin D v r i k).lo : ℝ) / D := by
    simp only [phaseWin, Int.cast_sub, Int.cast_mul]
    field_simp [ne_of_gt hpos]
  have eU :
      (k : ℝ) - (v : ℝ) * ((i.hi : ℝ) / D) + (r : ℝ) / D =
        ((phaseWin D v r i k).hi : ℝ) / D := by
    simp only [phaseWin, Int.cast_add, Int.cast_sub, Int.cast_mul]
    field_simp [ne_of_gt hpos]
  rw [eL, eU, div_le_iff₀ hpos, le_div_iff₀ hpos]

def RealFeasible (D v r : ℤ) (xs : List Window) : Prop :=
  ∃ s : ℝ, ∀ i ∈ xs,
    ∀ t ∈ Set.Icc ((i.lo : ℝ) / D) ((i.hi : ℝ) / D),
      ∃ k : ℤ, Band ((r : ℝ) / D) k ((v : ℝ) * t + s)

theorem realFeasible_iff_gridOK {D v r : ℤ} {xs : List Window}
    (hD : 0 < D) (hv : 0 ≤ v) (hr : 2 * r < D)
    (hxs : ∀ i ∈ xs, i.lo ≤ i.hi) :
    RealFeasible D v r xs ↔ gridOK D v r xs = true := by
  have pos : 0 < (D : ℝ) := by exact_mod_cast hD
  have vr : 0 ≤ (v : ℝ) := by exact_mod_cast hv
  have hd : (r : ℝ) / D < 1 / 2 := by
    apply (div_lt_iff₀ pos).2
    have hh : (2 : ℝ) * (r : ℝ) < (D : ℝ) := by exact_mod_cast hr
    linarith only [hh]
  have time_order (i : Window) (hi : i ∈ xs) :
      (i.lo : ℝ) / D ≤ (i.hi : ℝ) / D := by
    exact div_le_div_of_nonneg_right (by exact_mod_cast hxs i hi) pos.le
  rw [gridOK_spec hD]
  constructor
  · rintro ⟨s, hs⟩
    refine ⟨⌊s * (D : ℝ)⌋, ?_⟩
    intro i hi
    obtain ⟨k, hL, hU⟩ :=
      (affine_iff (time_order i hi) vr hd).1 (hs i hi)
    have hw := (scaled_ends (v := v) (r := r) hD i k s).1 ⟨hL, hU⟩
    exact ⟨k, floor_in_window hw.1 hw.2⟩
  · rintro ⟨p, hp⟩
    let s : ℝ := (p : ℝ) / D
    have he : s * (D : ℝ) = (p : ℝ) :=
      div_mul_cancel₀ _ (ne_of_gt pos)
    refine ⟨s, ?_⟩
    intro i hi
    apply (affine_iff (time_order i hi) vr hd).2
    obtain ⟨k, hL, hU⟩ := hp i hi
    refine ⟨k, ?_⟩
    apply (scaled_ends (v := v) (r := r) hD i k s).2
    rw [he]
    exact ⟨by exact_mod_cast hL, by exact_mod_cast hU⟩

end PhaseTest
