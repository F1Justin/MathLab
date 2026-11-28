module
public import MathLab.WT.Coordinates
import Mathlib.Tactic.Linarith

/-! Pair each input outcome with its *joint* reflection. This symmetrizes the
covering profile without separating the window from the table it belongs to. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set
noncomputable section

variable {v α β : ℝ}

def Witness.reflected (W : Witness v α β) : Witness v α β where
  n := W.n
  σ := W.σ
  p := W.p
  w := fun i => mirror v (W.w i)
  t := fun i => mirror (W.σ-v) (W.t i)
  width_pos := W.width_pos
  alpha_pos := W.alpha_pos
  beta_pos := W.beta_pos
  width_le := W.width_le
  weight_nonneg := W.weight_nonneg
  total_weight := W.total_weight
  window_regular := fun i => (W.window_regular i).mirror _
  table_regular := fun i => (W.table_regular i).mirror _
  window_support := fun i => by simpa using mirror_support v (W.window_support i)
  table_support := fun i => by convert mirror_support (W.σ-v) (W.table_support i) using 2 <;> ring
  plateau := fun i x hx => W.plateau i _ ⟨by linarith [hx.2], by linarith [hx.1]⟩
  mass := fun i => (integral_mirror v (W.w i)).trans (W.mass i)
  window_cost := by simpa only [energy_mirror] using W.window_cost
  table_cost := by simpa only [energy_mirror] using W.table_cost
  autocorrelation := fun x => by simpa only [autocorr_mirror] using W.autocorrelation x
  covering := fun x hx => by
    simp only [conv_mirror]
    apply W.covering
    exact ⟨by linarith [hx.2], by linarith [hx.1]⟩

@[simp] theorem Witness.reflected_sigma (W : Witness v α β) : W.reflected.σ = W.σ := rfl

def pairList {n m : ℕ} {E : Type*} (f : Fin n → E) (g : Fin m → E) : Fin (n+m) → E :=
  Fin.addCases f g

@[simp] lemma pairList_left {n m : ℕ} {E : Type*} (f : Fin n → E) (g : Fin m → E) (i : Fin n) :
    pairList f g (Fin.castAdd m i) = f i := Fin.addCases_left i

@[simp] lemma pairList_right {n m : ℕ} {E : Type*} (f : Fin n → E) (g : Fin m → E) (i : Fin m) :
    pairList f g (Fin.natAdd n i) = g i := Fin.addCases_right i

def halfWeights {n m : ℕ} (p : Fin n → ℝ) (q : Fin m → ℝ) :=
  pairList (fun i => (1/2 : ℝ)*p i) (fun i => (1/2 : ℝ)*q i)

theorem expectation_halfWeights {n m : ℕ} (p : Fin n → ℝ) (q : Fin m → ℝ)
    (h : Fin (n+m) → ℝ) :
    expectation (halfWeights p q) h =
      (expectation p (fun i => h (Fin.castAdd m i)) +
       expectation q (fun i => h (Fin.natAdd n i))) / 2 := by
  unfold expectation
  rw [Fin.sum_univ_add]
  simp only [halfWeights, pairList_left, pairList_right, mul_assoc, ← Finset.mul_sum]
  ring

def Witness.halfMix (A B : Witness v α β) (hs : B.σ = A.σ) : Witness v α β where
  n := A.n+B.n
  σ := A.σ
  p := halfWeights A.p B.p
  w := pairList A.w B.w
  t := pairList A.t B.t
  width_pos := A.width_pos
  alpha_pos := A.alpha_pos
  beta_pos := A.beta_pos
  width_le := A.width_le
  weight_nonneg := Fin.addCases
    (fun i => by simp only [halfWeights, pairList_left]; positivity [A.weight_nonneg i])
    (fun i => by simp only [halfWeights, pairList_right]; positivity [B.weight_nonneg i])
  total_weight := by
    rw [Fin.sum_univ_add]
    simp only [halfWeights, pairList_left, pairList_right, ← Finset.mul_sum,
      A.total_weight, B.total_weight]
    norm_num
  window_regular := Fin.addCases (fun i => by simpa using A.window_regular i)
    (fun i => by simpa using B.window_regular i)
  table_regular := Fin.addCases (fun i => by simpa using A.table_regular i)
    (fun i => by simpa using B.table_regular i)
  window_support := Fin.addCases (fun i => by simpa using A.window_support i)
    (fun i => by simpa using B.window_support i)
  table_support := Fin.addCases (fun i => by simpa using A.table_support i)
    (fun i => by simpa [hs] using B.table_support i)
  plateau := Fin.addCases (fun i => by simpa using A.plateau i)
    (fun i => by simpa [hs] using B.plateau i)
  mass := Fin.addCases (fun i => by simpa using A.mass i) (fun i => by simpa using B.mass i)
  table_cost := by
    rw [expectation_halfWeights]
    simp only [pairList_left, pairList_right]
    linarith [A.table_cost, B.table_cost]
  window_cost := by
    rw [expectation_halfWeights]
    simp only [pairList_left, pairList_right]
    linarith [A.window_cost, B.window_cost]
  autocorrelation := by
    intro x
    rw [expectation_halfWeights]
    simp only [pairList_left, pairList_right]
    linarith [A.autocorrelation x, B.autocorrelation x]
  covering := by
    intro x hx
    rw [expectation_halfWeights]
    simp only [pairList_left, pairList_right]
    linarith [A.covering x hx, B.covering x (hs ▸ hx)]

def Witness.averageReflection (W : Witness v α β) := W.halfMix W.reflected rfl

theorem Witness.averageReflection_cover (W : Witness v α β) (x : ℝ) :
    expectation W.averageReflection.p
      (fun i => conv (W.averageReflection.w i) (W.averageReflection.t i) x) =
    (expectation W.p (fun i => conv (W.w i) (W.t i) x) +
     expectation W.p (fun i => conv (W.w i) (W.t i) (W.σ-x))) / 2 := by
  unfold averageReflection halfMix
  rw [expectation_halfWeights]
  simp only [pairList_left, pairList_right, reflected, conv_mirror,
    show v + (W.σ-v)-x = W.σ-x by ring]

end
end MathLab.WT
