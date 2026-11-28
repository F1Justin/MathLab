import MathLab.WT
import Lean.Util.CollectAxioms
import Lean.Elab.Command

/-! Fail the build if any final result uses an axiom other than those
of ordinary classical mathematics in Lean's standard environment. -/
open Lean Elab Command
run_cmd do
  let allowed := #[``propext, ``Classical.choice, ``Quot.sound]
  for theoremName in #[``MathLab.WT.Witness.smooth_profile_approximation,
      ``MathLab.WT.Witness.smooth_profile_sequence, ``MathLab.WT.smooth_simultaneous_approximation,
      ``MathLab.WT.L2Input.cost_derandomization, ``MathLab.WT.cost_derandomization,
      ``MathLab.WT.all_infima_equal, ``MathLab.WT.smooth_infimum_eq,
      ``MathLab.WT.both_strict_inequalities_false, ``MathLab.WT.conjecture71_false,
      ``MathLab.WT.Witness.universal_product_lower, ``MathLab.WT.Witness.universal_objective_lower,
      ``MathLab.WT.Certificate.certified_witness, ``MathLab.WT.Certificate.budgets_below_appendix_A3,
      ``MathLab.WT.Certificate.below_appendix_A3,
      ``MathLab.WT.common_infimum_bounds] do
    let dependencies ← collectAxioms theoremName
    unless dependencies.all allowed.contains do
      throwError m!"{theoremName} uses unexpected axioms {dependencies.filter (!allowed.contains ·)}"
    logInfo m!"{theoremName} depends on {dependencies}"
