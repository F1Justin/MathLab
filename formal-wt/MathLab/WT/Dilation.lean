module
public import MathLab.WT.Basic
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith

/-! The dilation of Lemma 2.8 of Carter--O'Bryant--Tao, including the
Jacobian in the window and the separate changes in the two energy budgets. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set
noncomputable section

def scaleFun (k c : ℝ) (f : ℝ → ℝ) (x : ℝ) := c * f (k * x)

theorem integral_scaleFun (k c : ℝ) (hk : 0 < k) (f : ℝ → ℝ) :
    ∫ x, scaleFun k c f x = (c / k) * ∫ x, f x := by
  simp only [scaleFun, integral_const_mul, Measure.integral_comp_mul_left,
    abs_of_pos (inv_pos.mpr hk), smul_eq_mul, div_eq_mul_inv, mul_assoc]

theorem energy_scaleFun (k c : ℝ) (hk : 0 < k) (f : ℝ → ℝ) :
    energy (scaleFun k c f) = (c ^ 2 / k) * energy f := by
  simpa [energy, scaleFun, mul_pow] using
    integral_scaleFun k (c ^ 2) hk (fun x => (f x) ^ 2)

theorem conv_scaleFun (k c d : ℝ) (hk : 0 < k) (f g : ℝ → ℝ) (x : ℝ) :
    conv (scaleFun k c f) (scaleFun k d g) x = (c * d / k) * conv f g (k * x) := by
  unfold conv
  rw [← integral_scaleFun k (c * d) hk (fun y => f y * g (k * x - y))]
  apply integral_congr_ae
  filter_upwards with y
  simp only [scaleFun, mul_sub]
  ring

theorem rev_scaleFun (k c : ℝ) (f : ℝ → ℝ) :
    rev (scaleFun k c f) = scaleFun k c (rev f) := by
  funext x
  simp [rev, scaleFun]

theorem Regular.scaleFun {f : ℝ → ℝ} (hf : Regular f) {k : ℝ} (hk : 0 < k) (c : ℝ) :
    Regular (scaleFun k c f) := by
  obtain ⟨hi, B, hB⟩ := hf
  refine ⟨(hi.comp_mul_left' hk.ne').const_mul c, |c| * B, ?_⟩
  intro x
  rw [MathLab.WT.scaleFun, abs_mul]
  exact mul_le_mul_of_nonneg_left (hB _) (abs_nonneg c)

theorem expectation_const_mul {n : ℕ} (p f : Fin n → ℝ) (c : ℝ) :
    expectation p (fun i => c * f i) = c * expectation p f := by
  simp only [expectation, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i _
  ring

theorem scaleFun_support {f : ℝ → ℝ} {a b k c : ℝ} (hk : 0 < k)
    (hs : Function.support f ⊆ Icc a b) :
    Function.support (scaleFun k c f) ⊆ Icc (a / k) (b / k) := by
  intro x hx
  have hf : f (k * x) ≠ 0 := by
    intro h
    exact hx (by simp [scaleFun, h])
  obtain ⟨hl, hr⟩ := hs hf
  exact ⟨(div_le_iff₀ hk).mpr (mul_comm k x ▸ hl), (le_div_iff₀ hk).mpr (mul_comm k x ▸ hr)⟩

variable {v α β : ℝ}

def Witness.dilate (W : Witness v α β) (k : ℝ) (hk : 0 < k) :
    Witness (v / k) (α / k) (k * β) where
  n := W.n
  σ := W.σ / k
  p := W.p
  w := fun i => scaleFun k k (W.w i)
  t := fun i => scaleFun k 1 (W.t i)
  width_pos := div_pos W.width_pos hk
  alpha_pos := div_pos W.alpha_pos hk
  beta_pos := mul_pos hk W.beta_pos
  width_le := by simpa [mul_div_assoc] using (div_le_div_iff_of_pos_right hk).mpr W.width_le
  weight_nonneg := W.weight_nonneg
  total_weight := W.total_weight
  window_regular := fun i => (W.window_regular i).scaleFun hk _
  table_regular := fun i => (W.table_regular i).scaleFun hk _
  window_support := fun i => by simpa using scaleFun_support (c := k) hk (W.window_support i)
  table_support := fun i => by simpa only [neg_div] using scaleFun_support (c := 1) hk (W.table_support i)
  plateau := by
    intro i x hx
    have h : x < (W.σ - v) / k := by simpa only [sub_div] using hx.2
    rw [scaleFun, one_mul]
    apply W.plateau i
    exact ⟨mul_pos hk hx.1, mul_comm x k ▸ (lt_div_iff₀ hk).mp h⟩
  mass := by
    intro i
    rw [integral_scaleFun k k hk, div_self hk.ne', W.mass, one_mul]
  table_cost := by
    simp_rw [energy_scaleFun k 1 hk]
    rw [expectation_const_mul]
    simp only [one_pow, one_div]
    have h := mul_le_mul_of_nonneg_left W.table_cost (inv_nonneg.mpr hk.le)
    convert h using 1
    ring
  window_cost := by
    simp_rw [energy_scaleFun k k hk]
    rw [expectation_const_mul, show k ^ 2 / k = k by field_simp]
    exact mul_le_mul_of_nonneg_left W.window_cost hk.le
  autocorrelation := by
    intro x
    simp_rw [rev_scaleFun, conv_scaleFun k k k hk]
    rw [expectation_const_mul, show k * k / k = k by field_simp]
    exact mul_nonneg hk.le (W.autocorrelation _)
  covering := by
    intro x hx
    have hh : k * x < W.σ := mul_comm x k ▸ (lt_div_iff₀ hk).mp hx.2
    simpa only [conv_scaleFun k k 1 hk, mul_one, div_self hk.ne', one_mul] using
      W.covering (k * x) ⟨mul_pos hk hx.1, hh⟩

theorem Witness.normalized (W : Witness v α β) :
    Nonempty (Witness (v * β) (α * β) 1) := by
  simpa only [div_inv_eq_mul, inv_mul_cancel₀ W.beta_pos.ne'] using
    (Nonempty.intro (W.dilate β⁻¹ (inv_pos.mpr W.beta_pos)))

end
end MathLab.WT
