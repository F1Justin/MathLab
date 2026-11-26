module

public import Std

@[expose] public section

namespace MathLab

/-- The background track stays between two forbidden open bands throughout this interval. -/
def cellOK (T r lo hi : Nat) (p : Nat × Nat) : Bool :=
  decide (lo ≤ hi ∧ r ≤ (p.1 * lo + p.2) % T ∧
    (p.1 * lo + p.2) % T + p.1 * (hi-lo) + r ≤ T)

/-- A single shifted runner cannot strictly cover the two indicated times. -/
def sepOK (T r v : Nat) (xy : Nat × Nat) : Bool :=
  decide (xy.1 ≤ xy.2 ∧ 2*r ≤ (v*(xy.2-xy.1))%T ∧
    (v*(xy.2-xy.1))%T + 2*r ≤ T)

def block (f : Nat → Bool) (a : Nat) : Nat → Bool
  | 0 => f a
  | n+1 => block f a n && block f (a+2^n) n

theorem block_sound {f : Nat → Bool} {a n v : Nat}
    (h : block f a n = true) (ha : a ≤ v) (hv : v < a+2^n) : f v = true := by
  induction n generalizing a with
  | zero =>
    simp at hv
    have : a = v := by omega
    simpa [block, this] using h
  | succ n ih =>
    simp only [block, Bool.and_eq_true] at h
    rw [Nat.pow_succ] at hv
    by_cases he : v < a + 2^n
    · exact ih h.1 ha he
    · exact ih h.2 (by omega) (by omega)

end MathLab
