module
public import MathLab.WT.ProjectionEnergy
public import MathLab.WT.Coordinates
public import MathLab.WT.Infima
public import MathLab.WT.Mollifier
import Mathlib.Tactic.Linarith

/-! A compactly supported even probability kernel, and the entire family
of centred input tables on long intervals for one fixed finite WT law. -/
@[expose] public section
namespace MathLab.WT

open MeasureTheory Set Filter
open Spectral
open scoped SchwartzMap
noncomputable section

variable {v α β : ℝ}

def Witness.extendTo (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L) : Witness v α β :=
  W.extend (2*L-W.σ) (by linarith)

theorem Witness.extendTo_length (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L) :
    (W.extendTo L hL).σ = 2*L := by
  change W.σ + (2*L-W.σ) = 2*L
  ring

def Witness.inputTable (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L) :
    Option (Fin W.n) → ℝ → ℝ
  | none => box (-L) L
  | some i => (W.extendTo L hL).centerTable i

theorem Witness.inputTable_regular (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L)
    (j : Option (Fin W.n)) : Regular (W.inputTable L hL j) := by
  cases j with
  | none => exact box_regular _ _
  | some i => exact ((W.extendTo L hL).table_regular i).shift _

theorem Witness.inputTable_plateau (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L)
    (j : Option (Fin W.n)) (x : ℝ) (hx : |x| < L-v/2) : W.inputTable L hL j x = 1 := by
  cases j with
  | none =>
    obtain ⟨h₁,h₂⟩ := abs_lt.mp hx
    simp [inputTable,box,indicator_of_mem (show x ∈ Icc (-L) L from
      ⟨by linarith [W.width_pos],by linarith [W.width_pos]⟩)]
  | some i =>
    apply (W.extendTo L hL).center_plateau
    rw [W.extendTo_length]
    linarith

theorem Witness.inputTable_support (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L)
    (j : Option (Fin W.n)) (x : ℝ) (hx : L+v/2 < |x|) : W.inputTable L hL j x = 0 := by
  by_contra h
  cases j with
  | none =>
    have hy := box_support (-L) L h
    rcases lt_abs.mp hx with hh | hh <;> linarith [hy.1,hy.2,W.width_pos]
  | some i =>
    have hy := (W.extendTo L hL).center_table_support i h
    rw [W.extendTo_length] at hy
    rcases lt_abs.mp hx with hh | hh <;> linarith [hy.1,hy.2]

theorem Witness.centerWindow_regular (W : Witness v α β) (i : Fin W.n) :
    Regular (W.centerWindow i) := (W.window_regular i).shift _

theorem Witness.centerWindow_outside (W : Witness v α β) (i : Fin W.n)
    (x : ℝ) (hx : v/2 < ‖x‖) : W.centerWindow i x = 0 := by
  by_contra h
  obtain ⟨hl,hr⟩ := W.center_window_support i h
  rw [Real.norm_eq_abs] at hx
  rcases lt_abs.mp hx with hh | hh <;> linarith

theorem Witness.centerWindow_mass (W : Witness v α β) (i : Fin W.n) :
    (∫ x, W.centerWindow i x) = 1 := by rw [centerWindow,integral_shift,W.mass]

theorem Witness.centerWindow_energy (W : Witness v α β) :
    (∑ i, W.p i*energy (W.centerWindow i)) ≤ β := by
  simp only [centerWindow,energy_shift]
  exact W.window_cost

/-- The bound is chosen before the plateau length. -/
theorem Witness.inputTable_uniform (W : Witness v α β) :
    ∃ B : ℝ, 1 ≤ B ∧ ∀ (L : ℝ) (hL : W.σ/2 ≤ L) j x, |W.inputTable L hL j x| ≤ B := by
  choose b hb using fun i => (W.table_regular i).2
  let B := 1 + ∑ i, max (b i) 0
  have hpos : 1 ≤ B := by
    simpa [B] using (Finset.sum_nonneg (s:=Finset.univ) (fun i _ => le_max_right (b i) 0))
  have hj (i : Fin W.n) : b i ≤ B := by
    have h₁ := Finset.single_le_sum (s:=Finset.univ) (fun j _ => le_max_right (b j) 0)
      (Finset.mem_univ i)
    dsimp [B]
    linarith [le_max_left (b i) 0]
  refine ⟨B,hpos,?_⟩
  intro L hL j x
  cases j with
  | none =>
    by_cases hx : x ∈ Icc (-L) L
    · simpa [inputTable,box,hx] using hpos
    · simp only [inputTable,box,indicator_of_notMem hx,abs_zero]
      linarith
  | some i =>
    change |insertPlateau _ (W.t i) _| ≤ _
    unfold insertPlateau
    split_ifs
    · exact (hb i _).trans (hj i)
    · simpa using hpos
    · exact (hb i _).trans (hj i)

theorem Witness.inputTable_energy (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L)
    {θ : ℝ} (hθ : θ ∈ Icc 0 1) :
    (∑ i, augmentedWeight W.p θ i * energy (W.inputTable L hL i)) ≤ 2*L + (1-θ)*α := by
  let U := W.extendTo L hL
  have hσ := W.extendTo_length L hL
  have pos : 0 ≤ L := by linarith [W.width_pos,W.width_le]
  have ht : (∑i, W.p i * energy (U.centerTable i)) ≤ 2*L+α := by
    simp only [Witness.centerTable,energy_shift]
    have hc := U.table_cost
    change (∑ i, W.p i * energy (U.t i)) ≤ U.σ + α at hc
    rwa [show U.σ = 2*L from hσ] at hc
  rw [Fintype.sum_option]
  simp only [augmentedWeight,inputTable, box_energy (by linarith : -L ≤ L)]
  simp_rw [mul_assoc (1-θ)]
  rw [← Finset.mul_sum]
  have h := mul_le_mul_of_nonneg_left ht (sub_nonneg.mpr hθ.2)
  change θ*(L- -L)+(1-θ)*(∑ i, W.p i * energy (U.centerTable i)) ≤ _
  nlinarith only [h]

theorem Witness.input_cover (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L)
    {θ : ℝ} (hθ : θ ∈ Icc 0 1) (x : ℝ) (hx : |x| < L) :
    1 ≤ covProfile W.p θ W.centerWindow (W.inputTable L hL) x := by
  let U := W.extendTo L hL
  have ec := W.extendTo_length L hL
  have h : 1 ≤ expectation W.p (fun i => conv (W.centerWindow i) (U.centerTable i) x) := by
    apply U.center_cover
    rw [show U.σ = 2*L from ec]
    obtain ⟨h₁,h₂⟩ := abs_lt.mp hx
    exact ⟨by linarith,by linarith⟩
  have hc := abs_lt.mp hx
  have hs : x ∈ Icc (-L) L := ⟨hc.1.le,hc.2.le⟩
  rw [covProfile,weighted,Fintype.sum_option]
  simp only [augmentedWeight,channelApply,inputTable,box,indicator_of_mem hs,mul_one]
  simp_rw [mul_assoc (1-θ)]
  rw [← Finset.mul_sum]
  have hh := mul_le_mul_of_nonneg_left h (sub_nonneg.mpr hθ.2)
  change 1 ≤ θ +(1-θ)*expectation W.p (fun i => conv (W.centerWindow i) (U.centerTable i) x)
  linarith

theorem Witness.input_profile_integrable (W : Witness v α β) (L : ℝ)
    (hL : W.σ/2 ≤ L) (θ : ℝ) : Integrable (covProfile W.p θ W.centerWindow (W.inputTable L hL)) := by
  apply weighted_integrable
  intro j
  cases j with
  | none => exact (W.inputTable_regular L hL none).1
  | some i =>
    exact (W.centerWindow_regular i).1.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ)
      (W.inputTable_regular L hL (some i)).1

theorem Witness.filtered_cover (W : Witness v α β) (L : ℝ) (hL : W.σ/2 ≤ L)
    {θ δ : ℝ} (hθ : 0 < θ) (hθ' : θ ≤ 1) (M : Mollifier δ)
    (F : Filters (augmentedWeight W.p θ) (augmentedWindow W.centerWindow) M.φ)
    (x : ℝ) (hx : |x| < L-2*δ) : 1 ≤ conv F.s (F.output (W.inputTable L hL)) x := by
  rw [F.cov_identity W.weight_nonneg hθ hθ' (fun i => (W.centerWindow_regular i).1)
    (fun j => (W.inputTable_regular L hL j).1)]
  exact M.cover_twice (W.input_profile_integrable L hL θ)
    (W.input_cover L hL ⟨hθ.le,hθ'⟩) x hx

theorem Witness.filtered_auto (W : Witness v α β) {θ δ : ℝ} (hθ : 0 < θ) (hθ' : θ ≤ 1)
    (M : Mollifier δ)
    (F : Filters (augmentedWeight W.p θ) (augmentedWindow W.centerWindow) M.φ) (x : ℝ) :
    0 ≤ conv F.s F.s x := by
  rw [F.auto_identity W.weight_nonneg hθ hθ' (fun i => (W.centerWindow_regular i).1)]
  apply autoProfile_nonneg ⟨hθ.le,hθ'⟩ M.nonneg
  intro z
  simpa only [weighted,Witness.centerWindow, autocorr_shift, expectation] using W.autocorrelation z

end
end MathLab.WT
