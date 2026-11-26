module

public import MathLab.NatChecker
public import Mathlib.Algebra.Order.Archimedean.Real.Basic
public import Mathlib.Tactic.Linarith
public import Mathlib.Tactic.NormNum
public import Mathlib.Tactic.Positivity
public import Mathlib.Tactic.FieldSimp
public import Mathlib.Tactic.Ring

@[expose] public section

namespace MathLab

def Outside (T r : Nat) (value : Real) : Prop :=
  ∀ k : Int, (r : Real) ≤ |value - (k : Real) * (T : Real)|

/-- The two endpoints of a single period suffice to bound the distance
to every integer multiple of the period. -/
theorem outside_of_between (T r : Nat) (k0 : Int) (value : ℝ)
    (hlo : (k0 : ℝ) * (T : ℝ) + (r : ℝ) ≤ value)
    (hhi : value + (r : ℝ) ≤ ((k0 : ℝ) + 1) * (T : ℝ)) :
    Outside T r value := by
  intro k
  have hT0 : (0 : ℝ) ≤ (T : ℝ) := by positivity
  by_cases hk : k ≤ k0
  · have hkR : (k : ℝ) ≤ (k0 : ℝ) := by exact_mod_cast hk
    have hmul := mul_le_mul_of_nonneg_right hkR hT0
    calc
      (r : ℝ) ≤ value - (k : ℝ) * (T : ℝ) := by
        linarith only [hlo, hmul]
      _ ≤ |value - (k : ℝ) * (T : ℝ)| := le_abs_self _
  · have hk1 : k0 + 1 ≤ k := by omega
    have hkR : (k0 : ℝ) + 1 ≤ (k : ℝ) := by exact_mod_cast hk1
    have hmul := mul_le_mul_of_nonneg_right hkR hT0
    calc
      (r : ℝ) ≤ -(value - (k : ℝ) * (T : ℝ)) := by
        linarith only [hhi, hmul]
      _ ≤ |value - (k : ℝ) * (T : ℝ)| := neg_le_abs _

/-- A cell certificate covers real times, including both endpoints.
The quotient used throughout the cell is the one at `lo`. -/
theorem outside_of_cellOK {T r lo hi : Nat} {p : Nat × Nat}
    (_hT : 0 < T) (hcell : cellOK T r lo hi p = true)
    {t : ℝ} (htlo : (lo : ℝ) ≤ t) (hthi : t ≤ (hi : ℝ)) :
    Outside T r ((p.1 : ℝ) * t + (p.2 : ℝ)) := by
  let a : Nat := p.1 * lo + p.2
  let m : Nat := a % T
  let q : Nat := a / T
  have hbounds : lo ≤ hi ∧ r ≤ m ∧ m + p.1 * (hi - lo) + r ≤ T := by
    simpa [cellOK, m, a] using hcell
  obtain ⟨horder, hl, hu⟩ := hbounds

  have hdecompN : m + T * q = p.1 * lo + p.2 := Nat.mod_add_div a T
  have hdecomp : (m : ℝ) + (T : ℝ) * (q : ℝ) =
      (p.1 : ℝ) * (lo : ℝ) + (p.2 : ℝ) := by
    exact_mod_cast hdecompN
  have hlR : (r : ℝ) ≤ (m : ℝ) := by exact_mod_cast hl
  have huR : (m : ℝ) + (p.1 : ℝ) * ((hi - lo : Nat) : ℝ) + (r : ℝ) ≤
      (T : ℝ) := by
    exact_mod_cast hu
  rw [Nat.cast_sub horder] at huR

  have hp0 : (0 : ℝ) ≤ (p.1 : ℝ) := by positivity
  have hleft := mul_le_mul_of_nonneg_left htlo hp0
  have hright := mul_le_mul_of_nonneg_left hthi hp0
  have hqcast : ((q : Int) : ℝ) = (q : ℝ) := by simp
  apply outside_of_between T r (q : Int) ((p.1 : ℝ) * t + (p.2 : ℝ))
  · rw [hqcast]
    nlinarith only [hdecomp, hlR, hleft]
  · rw [hqcast]
    nlinarith only [hdecomp, huR, hright]

/-- If the difference of two phases is separated from the period lattice
by `2*r`, the phases cannot both be strictly within `r` of that lattice. -/
theorem outside_or_outside_add {T r : Nat} (k0 : Int) (delta : ℝ)
    (hlo : 2 * (r : ℝ) ≤ delta - (k0 : ℝ) * (T : ℝ))
    (hhi : delta - (k0 : ℝ) * (T : ℝ) ≤ (T : ℝ) - 2 * (r : ℝ))
    (s : ℝ) :
    Outside T r s ∨ Outside T r (s + delta) := by
  classical
  have hwide : Outside T (2 * r) delta := by
    apply outside_of_between T (2 * r) k0 delta
    · push_cast
      linarith only [hlo]
    · push_cast
      nlinarith only [hhi]
  by_cases hs : Outside T r s
  · exact Or.inl hs
  · right
    change ¬ (∀ i : Int, (r : ℝ) ≤ |s - (i : ℝ) * (T : ℝ)|) at hs
    obtain ⟨i, hnoti⟩ := not_forall.mp hs
    have hi : |s - (i : ℝ) * (T : ℝ)| < (r : ℝ) := lt_of_not_ge hnoti
    intro j
    apply le_of_not_gt
    intro hj
    -- `hwide` applies the integer split of `outside_of_between` to `j - i`.
    have hfar :
        2 * (r : ℝ) ≤ |delta - ((j - i : Int) : ℝ) * (T : ℝ)| := by
      simpa using hwide (j - i)
    have hnear :
        |delta - ((j - i : Int) : ℝ) * (T : ℝ)| < 2 * (r : ℝ) := by
      calc
        |delta - ((j - i : Int) : ℝ) * (T : ℝ)| =
            |(s + delta - (j : ℝ) * (T : ℝ)) + -(s - (i : ℝ) * (T : ℝ))| := by
              apply congrArg (fun z : ℝ => |z|)
              rw [Int.cast_sub]
              ring
        _ ≤ |s + delta - (j : ℝ) * (T : ℝ)| + abs (-(s - (i : ℝ) * (T : ℝ))) :=
          abs_add_le _ _
        _ < 2 * (r : ℝ) := by
          rw [abs_neg]
          linarith only [hi, hj]
    exact (not_lt_of_ge hfar) hnear

private theorem sepOK_bounds {T r v : Nat} {xy : Nat × Nat}
    (hsep : sepOK T r v xy = true) :
    xy.1 ≤ xy.2 ∧ 2 * r ≤ (v * (xy.2 - xy.1)) % T ∧
      (v * (xy.2 - xy.1)) % T + 2 * r ≤ T := by
  simpa [sepOK] using hsep

/-- The two alternatives are evaluated at the actual real times `xy.1`
and `xy.2`, with the same arbitrary phase `s` at time zero. -/
theorem outside_pair_of_sepOK {T r v : Nat} {xy : Nat × Nat}
    (hsep : sepOK T r v xy = true) (s : ℝ) :
    Outside T r ((v : ℝ) * (xy.1 : ℝ) + s) ∨
    Outside T r ((v : ℝ) * (xy.2 : ℝ) + s) := by
  let d : Nat := v * (xy.2 - xy.1)
  let m : Nat := d % T
  let q : Nat := d / T
  have hbounds : xy.1 ≤ xy.2 ∧ 2 * r ≤ m ∧ m + 2 * r ≤ T :=
    sepOK_bounds hsep
  obtain ⟨hxy, hl, hu⟩ := hbounds
  have hdecompN : m + T * q = d := Nat.mod_add_div d T
  have hdecomp : (m : ℝ) + (T : ℝ) * (q : ℝ) = (d : ℝ) := by
    exact_mod_cast hdecompN
  have hlR : 2 * (r : ℝ) ≤ (m : ℝ) := by exact_mod_cast hl
  have huR : (m : ℝ) + 2 * (r : ℝ) ≤ (T : ℝ) := by exact_mod_cast hu
  have hlo : 2 * (r : ℝ) ≤ (d : ℝ) - (q : ℝ) * (T : ℝ) := by
    nlinarith only [hdecomp, hlR]
  have hhi : (d : ℝ) - (q : ℝ) * (T : ℝ) ≤ (T : ℝ) - 2 * (r : ℝ) := by
    nlinarith only [hdecomp, huR]

  have hor := outside_or_outside_add (T := T) (r := r) (q : Int) (d : ℝ)
    (by simpa using hlo) (by simpa using hhi) ((v : ℝ) * (xy.1 : ℝ) + s)
  have hd : (d : ℝ) = (v : ℝ) * ((xy.2 : ℝ) - (xy.1 : ℝ)) := by
    dsimp only [d]
    rw [Nat.cast_mul, Nat.cast_sub hxy]
  have hadd : (v : ℝ) * (xy.1 : ℝ) + s + (d : ℝ) =
      (v : ℝ) * (xy.2 : ℝ) + s := by
    rw [hd]
    ring
  simpa only [hadd] using hor

private theorem seed_outside_of_all {T r lo hi : Nat} {seed : List (Nat × Nat)}
    (hT : 0 < T) (hall : seed.all (cellOK T r lo hi) = true)
    {t : ℝ} (htlo : (lo : ℝ) ≤ t) (hthi : t ≤ (hi : ℝ)) :
    ∀ p ∈ seed, Outside T r ((p.1 : ℝ) * t + (p.2 : ℝ)) := by
  have hall' : ∀ p ∈ seed, cellOK T r lo hi p = true := by
    simpa only [List.all_eq_true] using hall
  intro p hp
  exact outside_of_cellOK hT (hall' p hp) htlo hthi

/-- Universal lower certificate: the finite pairs cover speeds through `B`;
the certified interval covers every larger speed. -/
theorem universal_lower (T r L H B : Nat) (seed pairs : List (Nat × Nat))
    (hT : 0 < T)
    (hfour : 4 * r ≤ T)
    (hHT : H ≤ T)
    (hLH : L ≤ H)
    (hwidth : 2 * r < (B + 1) * (H - L))
    (hcell : seed.all (cellOK T r L H) = true)
    (hpairs : ∀ xy ∈ pairs,
      xy.2 ≤ T ∧
      seed.all (cellOK T r xy.1 xy.1) = true ∧
      seed.all (cellOK T r xy.2 xy.2) = true)
    (hcover : ∀ v : Nat, 1 ≤ v → v ≤ B →
      ∃ xy ∈ pairs, sepOK T r v xy = true) :
    ∀ v : Nat, 0 < v → ∀ s : ℝ, ∃ t : ℝ,
      0 ≤ t ∧ t ≤ (T : ℝ) ∧
      (∀ p ∈ seed, Outside T r ((p.1 : ℝ) * t + (p.2 : ℝ))) ∧
      Outside T r ((v : ℝ) * t + s) := by
  intro v hv s
  by_cases hvB : v ≤ B
  · obtain ⟨xy, hmem, hsep⟩ := hcover v (by omega) hvB
    obtain ⟨hyT, hxCell, hyCell⟩ := hpairs xy hmem
    have hxy : xy.1 ≤ xy.2 := (sepOK_bounds hsep).1
    rcases outside_pair_of_sepOK hsep s with hx | hy
    · have hxTR : (xy.1 : ℝ) ≤ (T : ℝ) := by exact_mod_cast (le_trans hxy hyT)
      exact ⟨(xy.1 : ℝ), by positivity, hxTR,
        seed_outside_of_all hT hxCell (le_refl _) (le_refl _), hx⟩
    · have hyTR : (xy.2 : ℝ) ≤ (T : ℝ) := by exact_mod_cast hyT
      exact ⟨(xy.2 : ℝ), by positivity, hyTR,
        seed_outside_of_all hT hyCell (le_refl _) (le_refl _), hy⟩
  · have hBv : B + 1 ≤ v := by omega
    have hwidthN : 2 * r < v * (H - L) :=
      lt_of_lt_of_le hwidth (Nat.mul_le_mul_right (H - L) hBv)
    have hspan : 2 * (r : ℝ) < (v : ℝ) * ((H - L : Nat) : ℝ) := by
      exact_mod_cast hwidthN
    rw [Nat.cast_sub hLH] at hspan
    have hvR : (0 : ℝ) < (v : ℝ) := by exact_mod_cast hv

    let step : ℝ := 2 * (r : ℝ) / (v : ℝ)
    have hstep0 : 0 ≤ step := by
      dsimp only [step]
      positivity
    have hstep_lt : step < (H : ℝ) - (L : ℝ) := by
      dsimp only [step]
      apply (div_lt_iff₀ hvR).2
      simpa only [mul_comm] using hspan
    have hstep_mul : (v : ℝ) * step = 2 * (r : ℝ) := by
      dsimp only [step]
      field_simp [ne_of_gt hvR]

    have hL0 : (0 : ℝ) ≤ (L : ℝ) := by positivity
    have hLHR : (L : ℝ) ≤ (H : ℝ) := by exact_mod_cast hLH
    have hHTR : (H : ℝ) ≤ (T : ℝ) := by exact_mod_cast hHT
    have hstart : (L : ℝ) ≤ (L : ℝ) + step := by linarith only [hstep0]
    have hstop : (L : ℝ) + step ≤ (H : ℝ) := by linarith only [hstep_lt]

    have hfourR : 4 * (r : ℝ) ≤ (T : ℝ) := by exact_mod_cast hfour
    have hgap_hi : 2 * (r : ℝ) ≤ (T : ℝ) - 2 * (r : ℝ) := by
      linarith only [hfourR]
    have hor := outside_or_outside_add (T := T) (r := r) (0 : Int)
      (2 * (r : ℝ)) (by simp) (by simpa using hgap_hi) ((v : ℝ) * (L : ℝ) + s)
    rcases hor with hgoodL | hgoodStep
    · exact ⟨(L : ℝ), hL0, le_trans hLHR hHTR,
        seed_outside_of_all hT hcell (le_refl _) hLHR, hgoodL⟩
    · have hphase : (v : ℝ) * ((L : ℝ) + step) + s =
          (v : ℝ) * (L : ℝ) + s + 2 * (r : ℝ) := by
        rw [mul_add, hstep_mul]
        ring
      refine ⟨(L : ℝ) + step, le_trans hL0 hstart, le_trans hstop hHTR,
        seed_outside_of_all hT hcell hstart hstop, ?_⟩
      simpa only [hphase] using hgoodStep

end MathLab
