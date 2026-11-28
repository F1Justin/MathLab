module
public import MathLab.WT.ProfileFilters

/-! A feasible centred pair and the errors of its two correlation profiles. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory
noncomputable section

structure CenteredProfiles {v α β : ℝ} (W : Witness v α β) (ε P : ℝ) where
  u : ℝ
  D : ℝ
  V : ℝ → ℝ
  T : ℝ → ℝ
  width_pos : 0 < u
  width_lt : u < D
  length_gt : P+1 < D
  expands : W.σ/2 < D
  window_regular : Regular V
  table_regular : Regular T
  window_support : ∀ x, u/2 < |x| → V x=0
  table_support : ∀ x, D+u/2 < |x| → T x=0
  plateau : ∀ x, |x| < D-u/2 → T x=1
  mass : ∫ x, V x=1
  window_cost : energy V ≤ β+ε
  table_cost : energy T ≤ 2*D+(α+ε)
  even_window : ∀ x, V (-x)=V x
  even_table : ∀ x, T (-x)=T x
  autocorrelation : ∀ x, 0≤conv V V x
  cover : ∀ x, |x| < D → 1≤conv V T x
  auto_sup : ∀ x, |conv V V x-W.meanAutocorr x| ≤ ε
  auto_l1 : massAbs (fun x => conv V V x-W.meanAutocorr x) ≤ ε
  cover_sup : ∀ x, |conv V T x-W.reflectedCover D expands.le x| ≤ ε

end
end MathLab.WT
