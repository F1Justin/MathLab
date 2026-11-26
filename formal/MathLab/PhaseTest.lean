module

public import Std

@[expose] public section

namespace PhaseTest

-- A closed window. We do NOT build lo ≤ hi into the type:
-- an inverted phase window should cause the test to fail.
structure Window where
  lo : Int
  hi : Int
  deriving Repr, DecidableEq

abbrev InWin (w : Window) (p : Int) : Prop :=
  w.lo ≤ p ∧ p ≤ w.hi

def Common (ws : List Window) (p : Int) : Prop :=
  ∀ w ∈ ws, InWin w p

-- Includes the diagonal i = j.
def Cross (ws : List Window) : Prop :=
  ∀ i ∈ ws, ∀ j ∈ ws, i.lo ≤ j.hi

-- Maximum of z and all lower endpoints.
def peak (z : Int) : List Window → Int
  | [] => z
  | w :: ws => max w.lo (peak z ws)

theorem peak_le_iff (z b : Int) (ws : List Window) :
    peak z ws ≤ b ↔ z ≤ b ∧ ∀ w ∈ ws, w.lo ≤ b := by
  induction ws with
  | nil => simp [peak]
  | cons w ws ih =>
    simp [peak, Int.max_le, ih, and_left_comm]

-- In the nonempty case do not seed the maximum with zero:
-- all windows might be strictly negative.
def point : List Window → Int
  | [] => 0
  | w :: ws => peak w.lo ws

theorem cross_of_common {ws : List Window} {p : Int}
    (hp : Common ws p) : Cross ws := by
  intro i hi j hj
  exact Int.le_trans (hp i hi).1 (hp j hj).2

theorem point_common_of_cross {ws : List Window} (h : Cross ws) :
    Common ws (point ws) := by
  cases ws with
  | nil => simp [Common]
  | cons w ws =>
    intro j hj
    change j.lo ≤ peak w.lo ws ∧ peak w.lo ws ≤ j.hi
    have lower :=
      (peak_le_iff w.lo (peak w.lo ws) ws).1 (Int.le_refl _)
    constructor
    · rcases List.mem_cons.mp hj with e | ht
      · subst j
        exact lower.1
      · exact lower.2 j ht
    · apply (peak_le_iff w.lo j.hi ws).2
      exact ⟨h w (by simp) j hj,
        fun i hi => h i (by simp [hi]) j hj⟩

theorem cross_iff (ws : List Window) :
    Cross ws ↔ ∃ p : Int, Common ws p := by
  constructor
  · intro h
    exact ⟨point ws, point_common_of_cross h⟩
  · rintro ⟨p, hp⟩
    exact cross_of_common hp

def fixedOK (ws : List Window) : Bool :=
  let p := point ws
  ws.all fun w => decide (w.lo ≤ p ∧ p ≤ w.hi)

theorem fixedOK_spec (ws : List Window) :
    fixedOK ws = true ↔ ∃ p : Int, Common ws p := by
  have hb : fixedOK ws = true ↔ Common ws (point ws) := by
    simp [fixedOK, Common, InWin, List.all_eq_true]
  rw [hb]
  constructor
  · intro h
    exact ⟨point ws, h⟩
  · rintro ⟨p, hp⟩
    exact point_common_of_cross (cross_of_common hp)

-- i.lo = a and i.hi = b are the scaled time coordinates.
def phaseWin (D v r : Int) (i : Window) (k : Int) : Window :=
  ⟨k * D - v * i.lo - r, k * D - v * i.hi + r⟩

theorem width_bound {D v r k p : Int} {i : Window}
    (h : InWin (phaseWin D v r i k) p) :
    v * (i.hi - i.lo) ≤ 2 * r := by
  simp only [InWin, phaseWin] at h
  rw [Int.mul_sub]
  omega

-- Eliminate the common p between two chosen windings.
theorem separation {D v r ki kj p : Int} {i j : Window}
    (hi : InWin (phaseWin D v r i ki) p)
    (hj : InWin (phaseWin D v r j kj) p) :
    v * (i.hi - j.lo) - 2 * r ≤ (ki - kj) * D ∧
      (ki - kj) * D ≤ v * (i.lo - j.hi) + 2 * r := by
  simp only [InWin, phaseWin] at hi hj
  simp only [Int.mul_sub, Int.sub_mul]
  omega

-- In particular, moving to a strictly higher winding needs this gap.
theorem higher_winding_gap {D v r ki kj p : Int} {i j : Window}
    (hD : 0 ≤ D) (hij : ki < kj)
    (hi : InWin (phaseWin D v r i ki) p)
    (hj : InWin (phaseWin D v r j kj) p) :
    D - 2 * r ≤ v * (j.lo - i.hi) := by
  have hu := (separation hj hi).2
  have hm := Int.mul_le_mul_of_nonneg_right
    (show (1 : Int) ≤ kj - ki by omega) hD
  rw [Int.one_mul] at hm
  omega

-- Euclidean division, including for negative numerators.
private theorem split_mod (n D : Int) :
    n % D + (n / D) * D = n := by
  exact Int.emod_add_ediv_mul n D

theorem quot_bounds {D : Int} (hD : 0 < D) (n : Int) :
    (n / D) * D ≤ n ∧ n < (n / D) * D + D := by
  have he := split_mod n D
  have h0 := Int.emod_nonneg n (show D ≠ 0 by omega)
  have ht := Int.emod_lt_of_pos n hD
  omega

-- Integer-window lifting: is there a multiple of D in [L,U]?
-- It suffices to try the greatest multiple at or below U.
theorem multiple_in_window {D : Int} (hD : 0 < D) (L U : Int) :
    (∃ k : Int, L ≤ k * D ∧ k * D ≤ U) ↔ L ≤ (U / D) * D := by
  obtain ⟨hlo, hhi⟩ := quot_bounds hD U
  constructor
  · rintro ⟨k, hL, hU⟩
    by_cases h : k ≤ U / D
    · exact Int.le_trans hL
        (Int.mul_le_mul_of_nonneg_right h (show 0 ≤ D by omega))
    · have hstep : U / D + 1 ≤ k := by omega
      have hm := Int.mul_le_mul_of_nonneg_right hstep
        (show 0 ≤ D by omega)
      rw [Int.add_mul, Int.one_mul] at hm
      omega
  · intro h
    exact ⟨U / D, h, hlo⟩

theorem in_phase_iff (D v r : Int) (i : Window) (k p : Int) :
    InWin (phaseWin D v r i k) p ↔
      p + v * i.hi - r ≤ k * D ∧ k * D ≤ p + v * i.lo + r := by
  simp only [InWin, phaseWin]
  omega

def winding (D v r : Int) (i : Window) (p : Int) : Int :=
  (p + v * i.lo + r) / D

def oneOK (D v r : Int) (i : Window) (p : Int) : Bool :=
  decide (p + v * i.hi - r ≤ winding D v r i p * D)

-- Certificate reconstruction: this particular k works if the bit is true.
theorem winding_spec {D : Int} (hD : 0 < D) (v r : Int)
    (i : Window) (p : Int) :
    oneOK D v r i p = true ↔
      InWin (phaseWin D v r i (winding D v r i p)) p := by
  rw [in_phase_iff]
  simp only [oneOK, decide_eq_true_eq]
  have hu := (quot_bounds hD (p + v * i.lo + r)).1
  exact ⟨fun h => ⟨h, hu⟩, fun h => h.1⟩

theorem oneOK_spec {D : Int} (hD : 0 < D) (v r : Int)
    (i : Window) (p : Int) :
    oneOK D v r i p = true ↔
      ∃ k : Int, InWin (phaseWin D v r i k) p := by
  unfold oneOK
  rw [decide_eq_true_eq]
  simpa only [winding, in_phase_iff] using
    (multiple_in_window hD (p + v * i.hi - r) (p + v * i.lo + r)).symm

def Fits (D v r : Int) (xs : List Window) (p : Int) : Prop :=
  ∀ i ∈ xs, ∃ k : Int, InWin (phaseWin D v r i k) p

-- Reduce the phase modulo D, changing EVERY winding by the same offset.
theorem fits_mod {D v r p : Int} {xs : List Window}
    (hp : Fits D v r xs p) : Fits D v r xs (p % D) := by
  intro i hi
  obtain ⟨k, hk⟩ := hp i hi
  refine ⟨k - p / D, ?_⟩
  simp only [InWin, phaseWin] at hk ⊢
  simp only [Int.sub_mul]
  have he := split_mod p D
  omega

def gridOK (D v r : Int) (xs : List Window) : Bool :=
  (List.range D.toNat).any fun n =>
    xs.all fun i => oneOK D v r i (n : Int)

theorem gridOK_spec {D : Int} (hD : 0 < D) (v r : Int)
    (xs : List Window) :
    gridOK D v r xs = true ↔ ∃ p : Int, Fits D v r xs p := by
  simp only [gridOK, List.any_eq_true, List.mem_range, List.all_eq_true,
    oneOK_spec hD]
  constructor
  · rintro ⟨n, hn, hf⟩
    exact ⟨(n : Int), hf⟩
  · rintro ⟨p, hp⟩
    have h0 := Int.emod_nonneg p (show D ≠ 0 by omega)
    have ht := Int.emod_lt_of_pos p hD
    have he : ((p % D).toNat : Int) = p % D := by omega
    refine ⟨(p % D).toNat, by omega, ?_⟩
    rw [he]
    exact fits_mod hp

end PhaseTest
