import MathLab.WT.Derandomization
import MathLab.WT.Infima
import MathLab.WT.LowerBound
import MathLab.WT.Certificate
import MathLab.WT.SmoothCorollary
import MathLab.WT.ProfileTheorem
import MathLab.WT.L2Input
import MathLab.WT.TableEnergyFill
import MathLab.WT.MatchedProfiles
import MathLab.WT.CostPairs

/-! Unconditional theorems for Carter, O'Bryant and Tao, Conjecture 7.1.
The finite example is linked to its exact rational arrays in WT.Certificate. -/
namespace MathLab.WT

theorem Witness.smooth_profile_approximation {v α β : ℝ} (W : Witness v α β)
    {ε : ℝ} (hε : 0 < ε) (P : ℝ) : Nonempty (SmoothProfileWitness W ε P) :=
  W.smoothProfile_of_realization centered_profile_realization hε P

theorem Witness.smooth_profile_sequence {v α β : ℝ} (W : Witness v α β) :
    Nonempty (SmoothProfileSequence W) :=
  W.profileSequence_of_realization centered_profile_realization

theorem Witness.matched_profile_approximation {v α β : ℝ} (W : Witness v α β)
    {ε : ℝ} (hε : 0 < ε) (P : ℝ) :
    ∃ Q : SmoothProfileWitness W ε P, W.tableExcess ≤ Q.tableSurplus :=
  W.matchedProfile_of_realization centered_profile_realization fill_profile_energy hε P

/-- Theorem 1. One sequence of genuine smooth, deterministic, symmetric pairs
converges to both correlation profiles and to both actual input costs. -/
theorem Witness.matched_profile_sequence {v α β : ℝ} (W : Witness v α β) :
    Nonempty (MatchedProfileSequence W) :=
  W.matchedProfileSequence_of_realization centered_profile_realization fill_profile_energy

/-- Actual costs are the table excess and window energy of the same witness. -/
theorem actual_cost_closures_equal :
    closure actualCostPairs = closure smoothSymmetricCostPairs :=
  cost_pair_closures_of_matched (fun W => W.matched_profile_sequence)

theorem cost_derandomization {v α β : ℝ} (W : Witness v α β) {ε : ℝ} (hε : 0 < ε) :
    ∃ v' : ℝ, ∃ V : Witness v' (α+ε) (β+ε), V.Deterministic ∧ V.Symmetric :=
  simultaneous_approximation v α β W ε hε

theorem all_infima_equal (k : Kind) : infimum k = infimum .unrestricted :=
  infimum_eq_of_approximation simultaneous_approximation k

theorem both_strict_inequalities_false :
    ¬ infimum .unrestricted < infimum .deterministic ∧
    ¬ infimum .unrestricted < infimum .symmetric := by
  rw [all_infima_equal .deterministic, all_infima_equal .symmetric]
  exact ⟨lt_irrefl _, lt_irrefl _⟩

theorem conjecture71_false : ¬ conjecture71 :=
  not_conjecture71_of_approximation simultaneous_approximation

theorem common_infimum_bounds (k : Kind) :
    Real.sqrt 495709 / 375 ≤ infimum k ∧ infimum k < 188606746/100000000 := by
  refine ⟨universal_infimum_lower k, ?_⟩
  obtain ⟨W, _, _, _, hbound⟩ := Certificate.certified_witness
  rw [all_infima_equal k]
  exact lt_of_le_of_lt (csInf_le (values_bddBelow .unrestricted)
    ⟨_, _, _, W, trivial, rfl⟩) hbound

end MathLab.WT
