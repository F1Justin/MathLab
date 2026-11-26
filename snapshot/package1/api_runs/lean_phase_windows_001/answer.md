Use one integer \(p\) for the **scaled phase**, shared by all intervals. There are two different finite tests below:

- `fixedOK` tests a list of phase windows **after** the windings have been fixed. Pairwise intersection is sufficient in this test.
- `gridOK` does **not** take windings as input. It tries \(0 \le p < D\); for each \(p\) and each interval it computes just one candidate winding, by Euclidean division. The theorem `realFeasible_iff_gridOK` is the end-to-end specification of this test.

The sign assumption for the endpoint formula in the question is \(v\ge 0\). The single-winding theorem itself does not require this assumption.

**Compilation status:** Both listings are uncompiled here. They include the proof scripts for the stated results, with no `sorry`, axioms added by the modules, or `native_decide`. I am not reporting a successful Lean run. The second listing assumes the first is available as `PhaseTest`.

### `PhaseTest.lean` — Std only

```lean
import Std

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

private def larger (x y : Int) : Int :=
  if x ≤ y then y else x

private theorem larger_le (x y b : Int) :
    larger x y ≤ b ↔ x ≤ b ∧ y ≤ b := by
  unfold larger
  split <;> omega

-- Maximum of z and all lower endpoints.
def peak (z : Int) : List Window → Int
  | [] => z
  | w :: ws => larger w.lo (peak z ws)

theorem peak_le_iff (z b : Int) (ws : List Window) :
    peak z ws ≤ b ↔ z ≤ b ∧ ∀ w ∈ ws, w.lo ≤ b := by
  induction ws with
  | nil => simp [peak]
  | cons w ws ih =>
    simp [peak, larger_le, ih, and_assoc, and_left_comm, and_comm]

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
  simpa only [Int.mul_comm, Int.add_comm] using (Int.emod_add_ediv n D)

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
  simpa only [oneOK, winding, decide_eq_true_eq, in_phase_iff] using
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
```

### `PhaseTestReal.lean` — Mathlib bridge

`Band d k y` means \(k-d\le y\le k+d\), so `∃ k, Band d k y` is the nearest-integer condition without any tie-breaking convention. The IVT argument is stated for an arbitrary continuous function. Affineness enters only when deriving the width bound and when going **back** from endpoint inequalities to a statement throughout the interval.

```lean
import Mathlib
import PhaseTest

namespace PhaseTest

abbrev Band (d : ℝ) (k : ℤ) (y : ℝ) : Prop :=
  (k : ℝ) - d ≤ y ∧ y ≤ (k : ℝ) + d

theorem half_gap {d : ℝ} (hd : d < 1 / 2) (k : ℤ) :
    ¬ ∃ j : ℤ, Band d j ((k : ℝ) + 1 / 2) := by
  rintro ⟨j, hjL, hjU⟩
  by_cases h : j ≤ k
  · have h' : (j : ℝ) ≤ (k : ℝ) := by exact_mod_cast h
    linarith only [hjU, h', hd]
  · have hz : k + 1 ≤ j := by omega
    have h' : (k : ℝ) + 1 ≤ (j : ℝ) := by exact_mod_cast hz
    linarith only [hjL, h', hd]

-- If every intermediate value from A to B is covered, the label at B
-- cannot be a strictly larger integer than the label at A.
private theorem no_rise {A B d : ℝ} {k l : ℤ}
    (hd : d < 1 / 2) (hk : Band d k A) (hl : Band d l B)
    (mid : ∀ y : ℝ, A ≤ y → y ≤ B → ∃ j : ℤ, Band d j y) :
    l ≤ k := by
  by_contra! h
  have hz : k + 1 ≤ l := by omega
  have hstep : (k : ℝ) + 1 ≤ (l : ℝ) := by exact_mod_cast hz
  have ha : A ≤ (k : ℝ) + 1 / 2 := by linarith only [hk.2, hd]
  have hb : (k : ℝ) + 1 / 2 ≤ B := by
    linarith only [hl.1, hstep, hd]
  exact half_gap hd k (mid _ ha hb)

theorem endpoint_winding {a b d : ℝ} {f : ℝ → ℝ}
    (hab : a ≤ b) (hd : d < 1 / 2)
    (hf : ContinuousOn f (Set.Icc a b))
    (h : ∀ x ∈ Set.Icc a b, ∃ k : ℤ, Band d k (f x)) :
    ∃ k : ℤ, Band d k (f a) ∧ Band d k (f b) := by
  obtain ⟨k, hk⟩ := h a ⟨le_rfl, hab⟩
  obtain ⟨l, hl⟩ := h b ⟨hab, le_rfl⟩
  have covered : ∀ {y : ℝ}, y ∈ f '' Set.Icc a b →
      ∃ j : ℤ, Band d j y := by
    rintro y ⟨x, hx, rfl⟩
    exact h x hx
  have hlk : l ≤ k := by
    apply no_rise hd hk hl
    intro y hA hB
    exact covered (intermediate_value_Icc hab hf ⟨hA, hB⟩)
  have hkl : k ≤ l := by
    apply no_rise hd hl hk
    intro y hB hA
    exact covered (intermediate_value_Icc' hab hf ⟨hB, hA⟩)
  have e : l = k := le_antisymm hlk hkl
  subst l
  exact ⟨k, hk, hl⟩

theorem affine_constraints {a b v s d : ℝ}
    (hab : a ≤ b) (hd : d < 1 / 2)
    (h : ∀ x ∈ Set.Icc a b, ∃ k : ℤ, Band d k (v * x + s)) :
    ∃ k : ℤ,
      (Band d k (v * a + s) ∧ Band d k (v * b + s)) ∧
      v * (b - a) ≤ 2 * d ∧
      (k : ℝ) - v * a - d ≤ s ∧ s ≤ (k : ℝ) - v * b + d := by
  obtain ⟨k, ha, hb⟩ :=
    endpoint_winding (f := fun x : ℝ => v * x + s) hab hd (by fun_prop) h
  refine ⟨k, ⟨ha, hb⟩, ?_, ?_, ?_⟩
  · nlinarith only [ha.1, hb.2]
  · linarith only [ha.1]
  · linarith only [hb.2]

-- Nonnegative slope is needed for sufficiency of THESE two inequalities.
theorem affine_iff {a b v s d : ℝ}
    (hab : a ≤ b) (hv : 0 ≤ v) (hd : d < 1 / 2) :
    (∀ x ∈ Set.Icc a b, ∃ k : ℤ, Band d k (v * x + s)) ↔
      ∃ k : ℤ, (k : ℝ) - v * a - d ≤ s ∧ s ≤ (k : ℝ) - v * b + d := by
  constructor
  · intro h
    obtain ⟨k, _, _, hL, hU⟩ := affine_constraints hab hd h
    exact ⟨k, hL, hU⟩
  · rintro ⟨k, hL, hU⟩ x hx
    refine ⟨k, ?_, ?_⟩
    · linarith only [hL, mul_le_mul_of_nonneg_left hx.1 hv]
    · linarith only [hU, mul_le_mul_of_nonneg_left hx.2 hv]

-- The SAME rounding map preserves membership in every closed window
-- with integer endpoints; no common rounding choice has to be searched.
theorem floor_in_window {i : Window} {P : ℝ}
    (hL : (i.lo : ℝ) ≤ P) (hU : P ≤ (i.hi : ℝ)) :
    InWin i ⌊P⌋ := by
  constructor
  · exact Int.le_floor.mpr hL
  · have hh : (⌊P⌋ : ℝ) ≤ (i.hi : ℝ) := (Int.floor_le P).trans hU
    exact_mod_cast hh

theorem real_fixed_iff (ws : List Window) :
    (∃ P : ℝ, ∀ i ∈ ws, (i.lo : ℝ) ≤ P ∧ P ≤ (i.hi : ℝ)) ↔
      fixedOK ws = true := by
  rw [fixedOK_spec]
  constructor
  · rintro ⟨P, h⟩
    exact ⟨⌊P⌋, fun i hi => floor_in_window (h i hi).1 (h i hi).2⟩
  · rintro ⟨p, h⟩
    refine ⟨(p : ℝ), ?_⟩
    intro i hi
    obtain ⟨hL, hU⟩ := h i hi
    exact ⟨by exact_mod_cast hL, by exact_mod_cast hU⟩

-- Time is [i.lo / D, i.hi / D], distance bound is r / D,
-- unscaled phase is s, and scaled phase is s * D.
theorem scaled_ends {D v r : ℤ} (hD : 0 < D)
    (i : Window) (k : ℤ) (s : ℝ) :
    ((k : ℝ) - (v : ℝ) * ((i.lo : ℝ) / D) - (r : ℝ) / D ≤ s ∧
      s ≤ (k : ℝ) - (v : ℝ) * ((i.hi : ℝ) / D) + (r : ℝ) / D) ↔
    (((phaseWin D v r i k).lo : ℝ) ≤ s * (D : ℝ) ∧
      s * (D : ℝ) ≤ ((phaseWin D v r i k).hi : ℝ)) := by
  have hpos : 0 < (D : ℝ) := by exact_mod_cast hD
  have eL :
      (k : ℝ) - (v : ℝ) * ((i.lo : ℝ) / D) - (r : ℝ) / D =
        ((phaseWin D v r i k).lo : ℝ) / D := by
    simp only [phaseWin, Int.cast_sub, Int.cast_mul]
    field_simp [ne_of_gt hpos] <;> ring
  have eU :
      (k : ℝ) - (v : ℝ) * ((i.hi : ℝ) / D) + (r : ℝ) / D =
        ((phaseWin D v r i k).hi : ℝ) / D := by
    simp only [phaseWin, Int.cast_add, Int.cast_sub, Int.cast_mul]
    field_simp [ne_of_gt hpos] <;> ring
  rw [eL, eU, div_le_iff₀ hpos, le_div_iff₀ hpos]

def RealFeasible (D v r : ℤ) (xs : List Window) : Prop :=
  ∃ s : ℝ, ∀ i ∈ xs,
    ∀ t ∈ Set.Icc ((i.lo : ℝ) / D) ((i.hi : ℝ) / D),
      ∃ k : ℤ, Band ((r : ℝ) / D) k ((v : ℝ) * t + s)

theorem realFeasible_iff_gridOK {D v r : ℤ} {xs : List Window}
    (hD : 0 < D) (hv : 0 ≤ v) (hr : 2 * r < D)
    (hxs : ∀ i ∈ xs, i.lo ≤ i.hi) :
    RealFeasible D v r xs ↔ gridOK D v r xs = true := by
  have pos : 0 < (D : ℝ) := by exact_mod_cast hD
  have vr : 0 ≤ (v : ℝ) := by exact_mod_cast hv
  have hd : (r : ℝ) / D < 1 / 2 := by
    apply (div_lt_iff₀ pos).2
    have hh : (2 : ℝ) * (r : ℝ) < (D : ℝ) := by exact_mod_cast hr
    linarith only [hh]
  have time_order (i : Window) (hi : i ∈ xs) :
      (i.lo : ℝ) / D ≤ (i.hi : ℝ) / D := by
    exact div_le_div_of_nonneg_right (by exact_mod_cast hxs i hi) pos.le
  rw [gridOK_spec hD]
  constructor
  · rintro ⟨s, hs⟩
    refine ⟨⌊s * (D : ℝ)⌋, ?_⟩
    intro i hi
    obtain ⟨k, hL, hU⟩ :=
      (affine_iff (time_order i hi) vr hd).1 (hs i hi)
    have hw := (scaled_ends (v := v) (r := r) hD i k s).1 ⟨hL, hU⟩
    exact ⟨k, floor_in_window hw.1 hw.2⟩
  · rintro ⟨p, hp⟩
    let s : ℝ := (p : ℝ) / D
    have he : s * (D : ℝ) = (p : ℝ) :=
      div_mul_cancel₀ _ (ne_of_gt pos)
    refine ⟨s, ?_⟩
    intro i hi
    apply (affine_iff (time_order i hi) vr hd).2
    obtain ⟨k, hL, hU⟩ := hp i hi
    refine ⟨k, ?_⟩
    apply (scaled_ends (v := v) (r := r) hD i k s).2
    rw [he]
    exact ⟨by exact_mod_cast hL, by exact_mod_cast hU⟩

end PhaseTest
```

The order of the two reductions matters: first fix the interval windings justified by `endpoint_winding` and round the **shared** real scaled phase down; only then reduce the integer phase modulo \(D\), translating all windings together. In the reverse direction, a successful grid point \(p\) gives the real phase \(s=p/D\), and `winding D v r i p` supplies the label for interval `i`. This avoids treating independently satisfiable pairwise winding choices as a global certificate.
