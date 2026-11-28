module
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Lebesgue.Basic
public import Mathlib.Analysis.Real.Sqrt

/-! Carter, O'Bryant and Tao, §2.1 and Definition 2.1 (arXiv:2610.36207v1).
Functions here are actual real functions. The support, plateau, symmetry and
covering statements can therefore be read pointwise. Both expectations in the
convolution constraints use the same finite joint law. -/
@[expose] public section
namespace MathLab.WT

open MeasureTheory Set

noncomputable section

def energy (f : ℝ → ℝ) : ℝ := ∫ x, (f x) ^ 2

def rev (f : ℝ → ℝ) (x : ℝ) : ℝ := f (-x)

def conv (f g : ℝ → ℝ) (x : ℝ) : ℝ := ∫ y, f y * g (x - y)

def expectation {n : ℕ} (p f : Fin n → ℝ) : ℝ := ∑ i, p i * f i

def Regular (f : ℝ → ℝ) : Prop :=
  Integrable f ∧ ∃ B : ℝ, ∀ x, |f x| ≤ B

structure Witness (v α β : ℝ) where
  n : ℕ
  σ : ℝ
  p : Fin n → ℝ
  w : Fin n → ℝ → ℝ
  t : Fin n → ℝ → ℝ
  width_pos : 0 < v
  alpha_pos : 0 < α
  beta_pos : 0 < β
  width_le : 2 * v ≤ σ
  weight_nonneg : ∀ i, 0 ≤ p i
  total_weight : ∑ i, p i = 1
  window_regular : ∀ i, Regular (w i)
  table_regular : ∀ i, Regular (t i)
  window_support : ∀ i, Function.support (w i) ⊆ Icc 0 v
  table_support : ∀ i, Function.support (t i) ⊆ Icc (-v) σ
  plateau : ∀ i x, x ∈ Ioo 0 (σ - v) → t i x = 1
  mass : ∀ i, ∫ x, w i x = 1
  table_cost : expectation p (fun i => energy (t i)) ≤ σ + α
  window_cost : expectation p (fun i => energy (w i)) ≤ β
  autocorrelation : ∀ x, 0 ≤ expectation p (fun i => conv (w i) (rev (w i)) x)
  covering : ∀ x, x ∈ Ioo 0 σ → 1 ≤ expectation p (fun i => conv (w i) (t i) x)

variable {v α β : ℝ}

def Witness.Deterministic (W : Witness v α β) : Prop := W.n = 1

def Witness.Symmetric (W : Witness v α β) : Prop :=
  ∀ i x, W.w i (v - x) = W.w i x ∧ W.t i (W.σ - v - x) = W.t i x

def Witness.SymmetricMeans (W : Witness v α β) : Prop :=
  ∀ x, expectation W.p (fun i => W.w i (v - x)) = expectation W.p (fun i => W.w i x) ∧
    expectation W.p (fun i => W.t i (W.σ - v - x)) = expectation W.p (fun i => W.t i x)

def Witness.Strong (W : Witness v α β) : Prop :=
  ∀ i x, 0 ≤ W.w i x ∧ 0 ≤ W.t i x

theorem Witness.Symmetric.means {W : Witness v α β} (h : W.Symmetric) :
    W.SymmetricMeans := by
  intro x
  constructor <;> unfold expectation <;> apply Finset.sum_congr rfl
  · intro i _
    exact congrArg (W.p i * ·) (h i x).1
  · intro i _
    exact congrArg (W.p i * ·) (h i x).2

def IsTriple (v α β : ℝ) : Prop := Nonempty (Witness v α β)

inductive Kind
  | unrestricted | deterministic | symmetric | both | symmetricMeans
  deriving DecidableEq

def Kind.accepts (k : Kind) (W : Witness v α β) : Prop :=
  match k with
  | .unrestricted => True
  | .deterministic => W.Deterministic
  | .symmetric => W.Symmetric
  | .both => W.Deterministic ∧ W.Symmetric
  | .symmetricMeans => W.SymmetricMeans

def objective (α β : ℝ) : ℝ := 2 * Real.sqrt (α * β)

def values (k : Kind) : Set ℝ :=
  {b | ∃ (v α β : ℝ) (W : Witness v α β), k.accepts W ∧ b = objective α β}

def infimum (k : Kind) : ℝ := sInf (values k)

def conjecture71 : Prop :=
  infimum .unrestricted < infimum .deterministic ∧
  infimum .unrestricted < infimum .symmetric

/-- The budgets on the right are attached to a single new witness. -/
def SimultaneousApproximation : Prop :=
  ∀ (v α β : ℝ), Witness v α β → ∀ ε : ℝ, 0 < ε →
    ∃ (v' : ℝ) (W : Witness v' (α + ε) (β + ε)), W.Deterministic ∧ W.Symmetric

end
end MathLab.WT
