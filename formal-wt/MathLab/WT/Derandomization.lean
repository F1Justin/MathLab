module
public import MathLab.WT.ProfileRealization
import Mathlib.Tactic.Ring

/-! Realize the same two centred functions as one joint WT atom in the
original left-endpoint coordinates. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set
noncomputable section

private lemma support_of_radius {f : ℝ → ℝ} {R : ℝ} (h : ∀ x, R < |x| → f x=0) :
    Function.support f ⊆ Icc (-R) R := by
  intro x hx
  exact abs_le.mp (le_of_not_gt (fun hh => hx (h x hh)))

theorem simultaneous_approximation : SimultaneousApproximation := by
  intro v α β W ε hε
  obtain ⟨S⟩ := centered_profile_realization v α β W hε 0
  refine ⟨S.u, ofCentered S.width_pos S.width_lt.le (add_pos W.alpha_pos hε)
    (add_pos W.beta_pos hε) S.window_regular S.table_regular ?_ ?_ S.plateau S.mass
    S.window_cost S.table_cost S.even_window S.even_table S.autocorrelation S.cover⟩
  · rw [neg_div]
    exact support_of_radius S.window_support
  · convert support_of_radius S.table_support using 2
    ring

end
end MathLab.WT
