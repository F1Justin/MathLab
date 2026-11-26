module

public import MathLab.NatChecker
public import MathLab.FrozenData

@[expose] public section

namespace MathLab.Frozen

/-- The same published phases expressed with the witness-time denominator. -/
def liftTrack (p : Nat × Nat) : Nat × Nat := (p.1, p.2 * (T / S))

theorem gap_cells : (seed.map liftTrack).all (cellOK T r gapLo gapHi) = true := by
  decide +kernel

private theorem point_cells_checked :
    pairs.all (fun xy =>
      decide (xy.2 ≤ T) && (seed.map liftTrack).all (cellOK T r xy.1 xy.1) &&
      (seed.map liftTrack).all (cellOK T r xy.2 xy.2)) = true := by decide +kernel

theorem point_cells (xy : Nat × Nat) (h : xy ∈ pairs) :
    xy.2 ≤ T ∧ (seed.map liftTrack).all (cellOK T r xy.1 xy.1) = true ∧
    (seed.map liftTrack).all (cellOK T r xy.2 xy.2) = true := by
  have hp := List.all_eq_true.mp point_cells_checked xy h
  simpa only [Bool.and_eq_true, decide_eq_true_eq, and_assoc] using hp

end MathLab.Frozen
