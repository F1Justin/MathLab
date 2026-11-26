module

public import MathLab.FrozenOptimum
public import MathLab.Stability

@[expose] public section

namespace MathLab.Frozen

abbrev SeedMember := {p : Nat × Nat // p ∈ seed}

noncomputable def seedSpeed (i : SeedMember) : ℝ := i.val.1
noncomputable def seedPhase (i : SeedMember) : ℝ := i.val.2 / (S : ℝ)

/-- At this displacement even an unrestricted extra runner cannot give strict
coverage at 1/59. The shifts and their winding corrections are independent. -/
theorem perturbation_barrier (b : SeedMember → ℝ)
    (h : AffineCircleTracks.ShiftsWithin seedPhase b (1207609 / 4661000000)) :
    AffineCircleTracks.Obstructed seedSpeed b (1/59) := by
  have base : AffineCircleTracks.Obstructed seedSpeed seedPhase radius := by
    intro v hv s
    obtain ⟨t, ht, hp, he⟩ := frozen_lower v hv s
    exact ⟨t, ht.1, ht.2, fun i k => hp i.val i.property k, he⟩
  have bound := AffineCircleTracks.obstructed_shift_lipschitz (by norm_num) h base
  have e : radius - (1207609 / 4661000000) = 1/59 := by norm_num [radius]
  rwa [e] at bound

end MathLab.Frozen
