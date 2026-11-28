module
public import MathLab.WT.LowerBound
public import MathLab.WT.Profiles
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith

/-! The exact table surplus and window energy of a feasible joint law are
strictly positive. They can be declared as budgets without changing any
atom, probability, length or correlation profile. -/
@[expose] public section
namespace MathLab.WT.Witness
open MeasureTheory
noncomputable section
variable {v α β : ℝ}

def tableExcess (W : Witness v α β) : ℝ := expectation W.p (fun i => energy (W.t i)) - W.σ
def windowEnergy (W : Witness v α β) : ℝ := expectation W.p (fun i => energy (W.w i))

theorem tableExcess_le (W : Witness v α β) : W.tableExcess ≤ α := by
  dsimp [tableExcess]
  linarith [W.table_cost]

theorem windowEnergy_le (W : Witness v α β) : W.windowEnergy ≤ β := W.window_cost

/-- Change the declared budgets while retaining the full joint law. -/
def withBudgets (W : Witness v α β) (a b : ℝ) (ha : 0 < a) (hb : 0 < b)
    (ht : W.tableExcess ≤ a) (hw : W.windowEnergy ≤ b) : Witness v a b :=
  { W with
    alpha_pos := ha, beta_pos := hb, window_cost := hw,
    table_cost := by change expectation W.p (fun i => energy (W.t i))-W.σ ≤ a at ht; linarith }

/-- If a cost could be nonpositive, taking its budget to be one half divided
by the other positive budget would contradict the universal product bound. -/
theorem actual_costs_pos (W : Witness v α β) : 0 < W.tableExcess ∧ 0 < W.windowEnergy := by
  have positive (cost other : ℝ) (ho : 0 < other)
      (trial : ∀ t : ℝ, 0 < t → cost ≤ t → 495709/562500 ≤ t*other) : 0 < cost := by
    by_contra! h
    have ht : 0 < 1/(2*other) := by positivity
    have hlow := trial _ ht (h.trans ht.le)
    rw [show 1/(2*other)*other = 1/2 by field_simp] at hlow
    norm_num at hlow
  constructor
  · apply positive _ β W.beta_pos
    intro a ha ht
    exact (W.withBudgets a β ha W.beta_pos ht W.windowEnergy_le).universal_product_lower
  · apply positive _ α W.alpha_pos
    intro b hb hw
    simpa only [mul_comm b α] using
      (W.withBudgets α b W.alpha_pos hb W.tableExcess_le hw).universal_product_lower

def tight (W : Witness v α β) : Witness v W.tableExcess W.windowEnergy :=
  W.withBudgets _ _ W.actual_costs_pos.1 W.actual_costs_pos.2 le_rfl le_rfl

@[simp] theorem tight_length (W : Witness v α β) : W.tight.σ = W.σ := rfl
@[simp] theorem tight_n (W : Witness v α β) : W.tight.n = W.n := rfl
@[simp] theorem tight_weights (W : Witness v α β) : W.tight.p = W.p := rfl
@[simp] theorem tight_windows (W : Witness v α β) : W.tight.w = W.w := rfl
@[simp] theorem tight_tables (W : Witness v α β) : W.tight.t = W.t := rfl
@[simp] theorem tight_meanAutocorr (W : Witness v α β) : W.tight.meanAutocorr = W.meanAutocorr := rfl
@[simp] theorem tight_reflectedCover (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L) :
    W.tight.reflectedCover L hL = W.reflectedCover L hL := rfl

theorem meanAutocorr_zero_eq_windowEnergy (W : Witness v α β) :
    W.meanAutocorr 0 = W.windowEnergy := W.meanAutocorr_zero

theorem actual_product_lower (W : Witness v α β) :
    (495709/562500 : ℝ) ≤ W.tableExcess * W.windowEnergy := W.tight.universal_product_lower

#print axioms actual_product_lower
end
end MathLab.WT.Witness
