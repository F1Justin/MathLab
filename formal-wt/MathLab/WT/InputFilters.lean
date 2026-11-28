module
public import MathLab.WT.MollifiedInput
public import MathLab.WT.FilterTails
import Mathlib.Tactic.Linarith

/-! Choose all filters and all uniform constants before selecting the
covering length. The two costs below hold for the very same filters. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set Spectral
noncomputable section

variable {v α β : ℝ}

structure PreparedFilters (W : Witness v α β) (δ ε : ℝ) where
  s : RealSchwartz
  k : Option (Fin W.n) → RealSchwartz
  B : ℝ
  bound_one : 1 ≤ B
  even : ∀ x, s (-x) = s x
  mass : ∫ x, s x = 1
  k_mass : (∑ i, ∫ x, k i x) = 1
  nonneg : ∀ x, 0 ≤ conv s s x
  window_cost : energy s ≤ β + ε
  table_bound : ∀ L hL i x, |W.inputTable L hL i x| ≤ B
  table_cost : ∀ L hL, energy (filterSum k (W.inputTable L hL)) ≤ 2*L + α
  cover : ∀ L hL x, |x| < L - 2*δ → 1 ≤ conv s (filterSum k (W.inputTable L hL)) x

theorem Spectral.Filters.asFilterSum {ι : Type*} [Fintype ι] {p : ι → ℝ} {w : ι → ℝ → ℂ}
    {φ : RealSchwartz} (F : Filters p w φ) (t : ι → ℝ → ℝ) : F.output t = filterSum F.k t := by
  funext x; simp only [Filters.output, filterSum, weighted, one_mul]

def PreparedFilters.ofFilters (W : Witness v α β) {δ θ ε B : ℝ} (M : Mollifier δ)
    (hθ : 0 < θ) (hθ' : θ ≤ 1)
    (F : Filters (augmentedWeight W.p θ) (augmentedWindow W.centerWindow) M.φ)
    (hB : 1 ≤ B) (hbound : ∀ L hL i x, |W.inputTable L hL i x| ≤ B)
    (hw : energy F.s ≤ β+ε) : PreparedFilters W δ ε := by
  have hP := augmentedWeight_sum W.total_weight θ
  have hM := F.masses hP (augmentedWindow_zero W.centerWindow_mass) M.mass
  have hθ₀ : θ ∈ Icc 0 1 := ⟨hθ.le,hθ'⟩
  refine ⟨F.s,F.k,B,hB,F.even_s,hM.1,?_,W.filtered_auto hθ hθ' M F,hw,hbound,?_,?_⟩
  · simpa only [hM.2] using hP
  · intro L hL
    rw [← F.asFilterSum]
    have ht := F.table_energy (augmentedWeight_nonneg W.weight_nonneg hθ₀)
      (augmented_floor W.weight_nonneg hθ hθ' W.centerWindow) M.nonneg M.mass
      (W.inputTable_regular L hL) (r := L+v/2) (W.inputTable_support L hL)
    exact (ht.trans (W.inputTable_energy L hL hθ₀)).trans (by nlinarith [mul_nonneg hθ.le W.alpha_pos.le])
  · intro L hL x hx
    rw [← F.asFilterSum]
    exact W.filtered_cover L hL hθ hθ' M F x hx

theorem Witness.preparedFilters (W : Witness v α β) {δ ε : ℝ} (hδ : 0 < δ) (hε : 0 < ε) :
    Nonempty (PreparedFilters W δ ε) := by
  obtain ⟨M⟩ := mollifier_exists hδ
  let D := energy M.φ + ε + 1
  have hE : 0 ≤ energy M.φ := integral_nonneg (fun x => sq_nonneg _)
  have hD : 0 < D := by dsimp [D]; linarith
  let θ := ε / D
  have hθ : 0 < θ := div_pos hε hD
  have hθ' : θ ≤ 1 := (div_le_one hD).mpr (by dsimp [D]; linarith)
  have hθ₀ : θ ∈ Icc 0 1 := ⟨hθ.le,hθ'⟩
  have hπε : θ * energy M.φ ≤ ε := calc
    _ ≤ θ * D := mul_le_mul_of_nonneg_left (by dsimp [D]; linarith) hθ.le
    _ = ε := div_mul_cancel₀ _ hD.ne'
  obtain ⟨F⟩ := augmented_filters_exist W.p W.weight_nonneg W.centerWindow
    (fun i => (W.centerWindow_regular i).1) W.centerWindow_outside M.φ M.even hθ hθ'
  obtain ⟨B,hB,hbound⟩ := W.inputTable_uniform
  refine ⟨PreparedFilters.ofFilters W M hθ hθ' F hB hbound ?_⟩
  apply (F.window_energy W.weight_nonneg hθ₀ W.centerWindow_regular W.centerWindow_outside
    M.nonneg M.mass).trans
  nlinarith [mul_le_mul_of_nonneg_left W.centerWindow_energy (sub_nonneg.mpr hθ'),
    mul_nonneg hθ.le W.beta_pos.le]

end
end MathLab.WT
