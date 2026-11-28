module
public import MathLab.WT.ProfileTheorem
import Mathlib.Tactic.Ring

/-! A common sequence preserving both WT profiles and converging to both actual costs. -/
@[expose] public section
namespace MathLab.WT
open Filter
open scoped Topology
noncomputable section

variable {v α β : ℝ}

structure MatchedProfileSequence (W : Witness v α β) where
  sequence : SmoothProfileSequence W
  table_energy_tendsto :
    Tendsto (fun n => (sequence.pair n).tableSurplus) atTop (𝓝 W.tableExcess)

abbrev ProfileEnergyFilling : Prop :=
  ∀ {v α β : ℝ} {W : Witness v α β} {e : ℝ}, 0 < e → ∀ P : ℝ,
    SmoothProfileWitness W e P →
    ∃ Q : SmoothProfileWitness W (2*e) P, W.tableExcess ≤ Q.tableSurplus

theorem Witness.matchedProfile_of_realization (W : Witness v α β)
    (hreal : CenteredProfileRealization) (hfill : ProfileEnergyFilling) {ε : ℝ}
    (hε : 0 < ε) (P : ℝ) :
    ∃ Q : SmoothProfileWitness W ε P, W.tableExcess ≤ Q.tableSurplus := by
  have he : 0 < ε/2 := half_pos hε
  obtain ⟨Q⟩ := W.smoothProfile_of_realization hreal he P
  let good (d : ℝ) := ∃ T : SmoothProfileWitness W d P, W.tableExcess ≤ T.tableSurplus
  exact (congrArg good (show 2*(ε/2) = ε by ring)).mp (hfill he P Q)

theorem Witness.matchedProfileSequence_of_realization (W : Witness v α β)
    (hreal : CenteredProfileRealization) (hfill : ProfileEnergyFilling) :
    Nonempty (MatchedProfileSequence W) := by
  choose Q hQ using fun n : ℕ =>
    W.matchedProfile_of_realization hreal hfill (profileTolerance_pos n) n
  refine ⟨⟨SmoothProfileSequence.ofPairs W Q, ?_⟩⟩
  change Tendsto (fun n => (Q n).tableSurplus) atTop (𝓝 W.tableExcess)
  have upper : Tendsto (fun n => W.tableExcess+profileTolerance n) atTop (𝓝 W.tableExcess) := by
    simpa only [add_zero] using tendsto_const_nhds.add profileTolerance_zero
  exact tendsto_of_tendsto_of_tendsto_of_le_of_le tendsto_const_nhds upper hQ (fun n => (Q n).table_error)

end
end MathLab.WT
