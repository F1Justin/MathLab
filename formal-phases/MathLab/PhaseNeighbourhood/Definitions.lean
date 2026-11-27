module

public import Mathlib.Algebra.Order.Archimedean.Real.Basic
public import Mathlib.Algebra.Order.Round
public import Mathlib.Data.Int.ModEq
public import Mathlib.Data.Nat.Find
public import Mathlib.Data.Nat.Prime.Basic
public import Mathlib.Order.Interval.Finset.Nat
public import Mathlib.Data.Finset.Lattice.Fold

@[expose] public section

namespace MathLab.PhaseNeighbourhood

/-- The size hypothesis ensures that the set of speeds is nonempty. -/
theorem one_lt_of_seven_le {p : ℕ} (hp : 7 ≤ p) : 1 < p :=
  Nat.lt_of_lt_of_le (by decide : 1 < 7) hp

/-- The distance from a real lift to its nearest integer. -/
noncomputable def circleDist (x : ℝ) : ℝ := |x - (round x : ℝ)|

/-- The indices of the consecutive speeds. -/
def speeds (p : ℕ) : Finset ℕ := Finset.Ioo 0 p

theorem speeds_nonempty {p : ℕ} (hp : 1 < p) : (speeds p).Nonempty :=
  ⟨1, Finset.mem_Ioo.mpr ⟨by decide, hp⟩⟩

/-- Distance of the nearest runner at one time. -/
noncomputable def gap {p : ℕ} (hp : 1 < p) (u : ℕ → ℝ) (t : ℝ) : ℝ :=
  (speeds p).inf' (speeds_nonempty hp) (fun j => circleDist ((j : ℝ) * t + u j))

/-- Supremum over real time. Since the speeds are integral this is the
usual maximum over one turn. -/
noncomputable def loneliness {p : ℕ} (hp : 1 < p) (u : ℕ → ℝ) : ℝ :=
  sSup (Set.range (gap hp u))

/-- The largest odd denominator strictly below (p+1)/2 for odd p. -/
def smallDenominator (p : ℕ) : ℕ := 2 * ((p - 3) / 4) + 1

/-- Radius of the closed cube on which the local formula holds. -/
noncomputable def sharpRadius (p : ℕ) : ℝ :=
  1 / (2 * (smallDenominator p : ℝ) * ((p : ℝ) + 1))

/-- Phase functional for the complementary pair a and p−a. -/
noncomputable def pairForm (p : ℕ) (u : ℕ → ℝ) (a : ℕ) : ℝ :=
  (((p-a : ℕ) : ℝ) * u a - (a : ℝ) * u (p-a)) / (p : ℝ)

/-- The maximum over all speeds, which includes each complementary pair twice. -/
noncomputable def maxForm {p : ℕ} (hp : 1 < p) (u : ℕ → ℝ) : ℝ :=
  (speeds p).sup' (speeds_nonempty hp) (fun a => |pairForm p u a|)

/-- Sufficient radius around the common-start orbit. -/
noncomputable def tubeRadius (p : ℕ) : ℝ :=
  (2 * ((p : ℝ) + 1)) / ((p : ℝ) * (3 * (p : ℝ) - 1))

/-- Equality of residues up to sign. No group structure is needed. -/
def ModSign (p : ℕ) (x y : ℤ) : Prop :=
  x ≡ y [ZMOD (p : ℤ)] ∨ x ≡ -y [ZMOD (p : ℤ)]

/-- Order of two modulo sign, in its least-positive-exponent definition.
The value for an empty return set is zero. For a unit, the test in the
return set is exactly that its power represents the identity modulo sign. -/
noncomputable def twoOrderModuloSign (p : ℕ) : ℕ := by
  classical
  exact if h : ∃ n : ℕ, 0 < n ∧ ModSign p ((2 : ℤ)^n) 1 then Nat.find h else 0

/-- Largest phase distance from zero after a common time shift. -/
noncomputable def farthestGap {p : ℕ} (hp : 1 < p) (u : ℕ → ℝ) (t : ℝ) : ℝ :=
  (speeds p).sup' (speeds_nonempty hp) (fun j : ℕ => circleDist ((j : ℝ)*t+u j))

/-- Distance to the common-start orbit in the maximum of coordinate distances. -/
noncomputable def phaseRadius {p : ℕ} (hp : 1 < p) (u : ℕ → ℝ) : ℝ :=
  sInf (Set.range (farthestGap hp u))

end MathLab.PhaseNeighbourhood
