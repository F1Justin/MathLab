module

public import MathLab.PhaseNeighbourhood.Core
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Tauto

@[expose] public section

namespace MathLab.PhaseNeighbourhood

noncomputable section

private theorem ms_symm {p : ℕ} {x y : ℤ} (e : ModSign p x y) :
    ModSign p y x := by
  rcases e with e | e
  · exact Or.inl e.symm
  · exact Or.inr (by simpa only [neg_neg] using e.symm.neg)

private theorem ms_trans {p : ℕ} {x y z : ℤ}
    (e : ModSign p x y) (f : ModSign p y z) : ModSign p x z := by
  rcases e with e | e <;> rcases f with f | f
  · exact Or.inl (e.trans f)
  · exact Or.inr (e.trans f)
  · exact Or.inr (e.trans (f.neg))
  · exact Or.inl (by simpa only [neg_neg] using e.trans (f.neg))

private theorem ms_mul {p : ℕ} {x y : ℤ} (e : ModSign p x y) (z : ℤ) :
    ModSign p (x * z) (y * z) := by
  rcases e with e | e
  · exact Or.inl (e.mul_right z)
  · exact Or.inr (by simpa only [neg_mul] using e.mul_right z)

private abbrev mesh (p : ℕ) : ℝ := 1 / (p : ℝ)

private abbrev Box (p : ℕ) (u : ℕ → ℝ) (r : ℝ) : Prop :=
  ∀ i : ℕ, 0 < i → i < p → |u i| ≤ r

private abbrev Cover (p : ℕ) (u : ℕ → ℝ) : Prop :=
  ∀ t : ℝ, ∃ j : ℕ, 0 < j ∧ j < p ∧ circleDist ((j : ℝ) * t + u j) < mesh p

private theorem mul_mesh (c : ℝ) (p : ℕ) : c * mesh p = c / (p : ℝ) := by
  unfold mesh
  ring

private theorem mesh_bounds {p : ℕ} (hp : 7 ≤ p) :
    0 < mesh p ∧ 3 * mesh p < 1 / 2 := by
  have h : (7 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
  have h' : 0 < (p : ℝ) := by linarith
  exact ⟨one_div_pos.mpr h', by
    rw [mul_mesh]
    exact (div_lt_iff₀ h').2 (by linarith)⟩

private theorem radius_lt_mesh {p : ℕ} (hp : 7 ≤ p) :
    tubeRadius p < mesh p := by
  have h : (7 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
  have h' : 0 < (p : ℝ) := by linarith
  have h'' : 0 < 3 * (p : ℝ) - 1 := by linarith
  unfold tubeRadius mesh
  apply (div_lt_div_iff₀ (mul_pos h' h'') h').2
  nlinarith [mul_pos h' (show 0 < (p : ℝ) - 3 by linarith)]

/-- The non-strict displacement budget. Equality is allowed for the smallest
possible large index `h`. -/
private theorem large_budget {p h : ℕ} (hp : 7 ≤ p) (hh : p + 1 ≤ 2 * h) :
    tubeRadius p + ((p : ℝ) - 1) * (tubeRadius p / (h : ℝ)) ≤
      2 * mesh p := by
  have hP : (7 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
  have hH : (p : ℝ) + 1 ≤ 2 * (h : ℝ) := by exact_mod_cast hh
  have h0 : 0 < (h : ℝ) := by linarith
  have hp0 : 0 < (p : ℝ) := by linarith
  have h3 : 0 < 3 * (p : ℝ) - 1 := by linarith
  let K : ℝ := (p : ℝ) * (3 * (p : ℝ) - 1)
  have hK : 0 < K := mul_pos hp0 h3
  have hscale : tubeRadius p / (h : ℝ) ≤ 4 / K := by
    apply (div_le_iff₀ h0).2
    calc
      tubeRadius p = 2 * ((p : ℝ) + 1) / K := rfl
      _ ≤ (4 * (h : ℝ)) / K :=
        div_le_div_of_nonneg_right (by linarith) hK.le
      _ = (4 / K) * (h : ℝ) := by ring
  calc
    _ ≤ tubeRadius p + ((p : ℝ) - 1) * (4 / K) := by
      have hterm := mul_le_mul_of_nonneg_left hscale (show 0 ≤ (p : ℝ)-1 by linarith)
      linarith only [hterm]
    _ = (2*((p : ℝ)+1)+4*((p : ℝ)-1))/K := by
      dsimp only [tubeRadius, K]
      ring
    _ = 2 * mesh p := by
      rw [show 2*((p : ℝ)+1)+4*((p : ℝ)-1) = 2*(3*(p : ℝ)-1) by ring, mul_mesh]
      dsimp only [K]
      exact mul_div_mul_right 2 (p : ℝ) h3.ne'

private theorem inverse_at {p a : ℕ} (hp : p.Prime) (ha0 : 0 < a) (ha : a < p) :
    ∃ k : ℤ, (a : ℤ) * k ≡ 1 [ZMOD (p : ℤ)] := by
  exact inverse_mod_of_coprime (Nat.coprime_of_lt_prime ha0.ne' ha hp).symm


private theorem away_plus {d v : ℝ} (hd : 0 ≤ d) (hs : 3*d < 1/2)
    (hv : 0 ≤ v) (hv' : v ≤ 2*d) : d ≤ circleDist (d + v) := by
  have h0 : 0 ≤ d + v := by linarith
  have h : |d + v| < 1/2 := by rw [abs_of_nonneg h0]; linarith
  rw [circleDist_eq_abs h, abs_of_nonneg h0]
  linarith

private theorem away_minus {d v : ℝ} (hd : 0 ≤ d) (hs : 3*d < 1/2)
    (hv : v ≤ 0) (hv' : -(2*d) ≤ v) : d ≤ circleDist (-d + v) := by
  rw [show -d + v = -(d + -v) by ring, circleDist_neg]
  exact away_plus hd hs (by linarith) (by linarith)

/-- At the inverse of `a`, a strict hit forces one of these strict signs. -/
private theorem one_side {p a : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    {u : ℕ → ℝ} (hc : Cover p u) (hb : Box p u (mesh p))
    (ha0 : 0 < a) (ha : a < p) : u a < 0 ∨ 0 < u (p-a) := by
  obtain ⟨hd, hs⟩ := mesh_bounds hp
  obtain ⟨k, hk⟩ := inverse_at hpr ha0 ha
  obtain ⟨j, hj0, hj, hn⟩ := hc ((k : ℝ) / p)
  have bj := hb j hj0 hj
  by_cases hnA : u a < 0
  · exact Or.inl hnA
  right
  by_contra hnB
  have hA : 0 ≤ u a := le_of_not_gt hnA
  have hB : u (p-a) ≤ 0 := le_of_not_gt hnB
  by_cases ej : j = a
  · subst j
    rw [circleDist_at_residue (by omega) hk] at hn
    simp only [Int.cast_one] at hn
    exact (not_lt_of_ge (away_plus hd.le hs hA (by linarith [(abs_le.mp bj).2]))) hn
  by_cases ej' : j = p-a
  · subst j
    rw [circleDist_at_residue (by omega) (complement_inverse ha.le hk)] at hn
    simp only [Int.cast_neg, Int.cast_one, neg_div] at hn
    exact (not_lt_of_ge (away_minus hd.le hs hB (by linarith [(abs_le.mp bj).1]))) hn
  have lo := other_runner_nominal ha hj hj0 ej ej' ha0 hk
  rw [← mul_mesh 2 p] at lo
  have lip := circleDist_le_add_abs ((j : ℝ) * ((k : ℝ) / p)) (u j)
  linarith

private theorem paired {p a : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    {u : ℕ → ℝ} (hc : Cover p u) (hb : Box p u (mesh p))
    (ha0 : 0 < a) (ha : a < p) :
    (0 < u a ∧ 0 < u (p-a)) ∨ (u a < 0 ∧ u (p-a) < 0) := by
  have x := one_side hp hpr hc hb ha0 ha
  have y := one_side (a := p-a) hp hpr hc hb (by omega) (by omega)
  rw [show p - (p-a) = a by omega] at y
  rcases x with x | x <;> rcases y with y | y
  · exact Or.inr ⟨x, y⟩
  · linarith
  · linarith
  · exact Or.inl ⟨y, x⟩

private theorem pair_iff {p a : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    {u : ℕ → ℝ} (hc : Cover p u) (hb : Box p u (mesh p))
    (ha0 : 0 < a) (ha : a < p) :
    0 < u a ↔ 0 < u (p-a) := by
  rcases paired hp hpr hc hb ha0 ha with h | h
  · exact ⟨fun _ => h.2, fun _ => h.1⟩
  · exact ⟨fun hx => False.elim ((not_lt_of_ge h.1.le) hx),
           fun hx => False.elim ((not_lt_of_ge h.2.le) hx)⟩

private theorem index_bound {p j : ℕ} (hj : j < p) : (j : ℝ) ≤ (p : ℝ) - 1 := by
  have h : (j : ℝ) + 1 ≤ (p : ℝ) := by exact_mod_cast (Nat.succ_le_of_lt hj)
  linarith

/-- At the *closed* time-shift budget one can still apply `paired`. Thus
the lower bound for the size of an individual phase is strict. -/
private theorem shift_slack {p j : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    {u : ℕ → ℝ} {r s : ℝ} (hc : Cover p u) (hb : Box p u r)
    (hbudget : r + ((p : ℝ) - 1)*s ≤ mesh p) (hs : 0 ≤ s)
    (hj0 : 0 < j) (hj : j < p) : (j : ℝ)*s < |u j| := by
  by_contra! he
  have hjR : 0 < (j : ℝ) := by exact_mod_cast hj0
  let z : ℝ := -u j / (j : ℝ)
  let w : ℕ → ℝ := fun i => u i + (i : ℝ)*z
  have hz : |z| ≤ s := by
    dsimp [z]
    rw [abs_div, abs_neg, abs_of_pos hjR, div_le_iff₀ hjR]
    linarith
  have bw : Box p w (mesh p) := by
    intro i hi0 hi
    calc
      |w i| ≤ |u i| + |(i : ℝ)*z| := abs_add_le _ _
      _ = |u i| + (i : ℝ)*|z| := by
        rw [abs_mul, abs_of_nonneg (show 0 ≤ (i : ℝ) by positivity)]
      _ ≤ r + ((p : ℝ)-1)*s :=
        add_le_add (hb i hi0 hi)
          ((mul_le_mul_of_nonneg_left hz (Nat.cast_nonneg i)).trans
            (mul_le_mul_of_nonneg_right (index_bound hi) hs))
      _ ≤ _ := hbudget
  have cw : Cover p w := by
    intro t
    obtain ⟨i, hi0, hi, hn⟩ := hc (t+z)
    refine ⟨i, hi0, hi, ?_⟩
    rwa [show (i : ℝ)*t + w i = (i : ℝ)*(t+z) + u i by dsimp [w]; ring]
  have hw : w j = 0 := by
    dsimp [w, z]
    field_simp [hjR.ne']
    ring
  rcases paired hp hpr cw bw hj0 hj with h | h <;> rw [hw] at h <;> linarith [h.1]

private theorem classify_two {p a j : ℕ} {k : ℤ}
    (ha0 : 0 < a) (ha : a < p) (hj0 : 0 < j) (hj : j < p) (nja : j ≠ a) (njb : j ≠ p-a)
    (hk : (a : ℤ)*k ≡ 1 [ZMOD (p : ℤ)])
    (h3 : circleDist ((j : ℝ)*((k : ℝ)/p)) < 3*mesh p) :
    ModSign p (j : ℤ) ((a : ℤ)*2) := by
  rw [mul_mesh] at h3
  obtain ⟨s, hs, hm⟩ := residue_of_circleDist_lt
    (D := p) (m := (j : ℤ)*k) (L := 3) (by omega)
    (by simpa only [Int.cast_mul, Int.cast_natCast, Int.cast_ofNat, mul_div_assoc] using h3)
  have e := strip_inverse hk hm
  obtain ⟨hl, hu⟩ := abs_lt.mp hs
  have cases_s : s = -2 ∨ s = -1 ∨ s = 0 ∨ s = 1 ∨ s = 2 := by omega
  rcases cases_s with H | H | H | H | H <;> subst s
  · exact Or.inr (by simpa only [mul_neg] using e)
  · rw [mul_neg_one] at e
    exact False.elim (njb (congr_nat_unique hj (by omega)
      (e.trans (complement_mod ha.le).symm)))
  · rw [mul_zero] at e
    exact False.elim (hj0.ne' (congr_nat_unique hj (by omega) e))
  · rw [mul_one] at e
    exact False.elim (nja (congr_nat_unique hj ha e))
  · exact Or.inl e

private theorem incompatible {x y d : ℝ} (hx : |x| ≤ d)
    (hy : |y| ≤ d + |x|) (hh : d < |x-y|) :
    ¬ ((0 ≤ x ∧ 0 ≤ y) ∨ (x ≤ 0 ∧ y ≤ 0)) := by
  intro h
  apply (not_le_of_gt hh)
  rcases h with ⟨h1,h2⟩ | ⟨h1,h2⟩
  · rw [abs_of_nonneg h1] at hx hy
    rw [abs_of_nonneg h2] at hy
    exact abs_le.mpr ⟨by linarith, by linarith⟩
  · rw [abs_of_nonpos h1] at hx hy
    rw [abs_of_nonpos h2] at hy
    exact abs_le.mpr ⟨by linarith, by linarith⟩

/-- The midpoint argument with `a` the smaller representative. -/
private theorem small_step {p a : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    {u : ℕ → ℝ} (hc : Cover p u) (hb : Box p u (tubeRadius p))
    (ha0 : 0 < a) (has : a < p-a) :
    ∃ j : ℕ, 0 < j ∧ j < p ∧ ModSign p (j : ℤ) ((a : ℤ)*2) ∧
      (0 < u j ↔ ¬ 0 < u a) := by
  let h := p-a
  have ha : a < p := by omega
  have hh0 : 0 < h := by dsimp [h]; omega
  have hh : h < p := by dsimp [h]; omega
  have hhR : 0 < (h : ℝ) := by exact_mod_cast hh0
  have hP : (7 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
  let M : ℝ := (p : ℝ)-1
  have hM : 0 < M := by dsimp [M]; linarith
  let r := tubeRadius p
  let d := mesh p
  obtain ⟨hd, h3d⟩ := mesh_bounds hp
  have hrd : r < d := radius_lt_mesh hp
  have bd : Box p u d := fun i hi0 hi => (hb i hi0 hi).trans hrd.le
  have budget : r + M*(r/(h : ℝ)) ≤ 2*d :=
    large_budget hp (by dsimp [h]; omega)
  let s := (d-r)/M
  have hs : 0 ≤ s := div_nonneg (sub_nonneg.mpr hrd.le) hM.le
  have hMs : M*s = d-r := by
    dsimp [s]
    field_simp [hM.ne']
  let b := u h / (h : ℝ)
  let v : ℕ → ℝ := fun i => u i - (i : ℝ)*b
  have hab : |b| ≤ r/(h : ℝ) := by
    dsimp [b]
    rw [abs_div, abs_of_pos hhR]
    exact div_le_div_of_nonneg_right (hb h hh0 hh) hhR.le
  have hrh : 0 ≤ r/(h : ℝ) := (abs_nonneg b).trans hab
  have bdisp (i : ℕ) (hi0 : 0 < i) (hi : i < p) : |v i| ≤ 2*d := by
    calc
      |v i| ≤ |u i| + |(i : ℝ)*b| := by
        simpa only [v, sub_eq_add_neg, abs_neg] using
          abs_add_le (u i) (-((i : ℝ)*b))
      _ = |u i| + (i : ℝ)*|b| := by
        rw [abs_mul, abs_of_nonneg (show 0 ≤ (i : ℝ) by positivity)]
      _ ≤ r + M*(r/(h : ℝ)) :=
        add_le_add (hb i hi0 hi)
          ((mul_le_mul_of_nonneg_left hab (Nat.cast_nonneg i)).trans
            (mul_le_mul_of_nonneg_right (index_bound hi) hrh))
      _ ≤ _ := budget
  have vh : v h = 0 := by
    dsimp [v, b]
    field_simp [hhR.ne']
    ring
  obtain ⟨k, hk⟩ := inverse_at hpr ha0 ha
  have hkH : (h : ℤ)*k ≡ -1 [ZMOD (p : ℤ)] := complement_inverse ha.le hk
  have choose_time : ∃ l : ℤ, (l = k ∨ l = -k) ∧
      d ≤ circleDist ((a : ℝ)*((l : ℝ)/p) + v a) := by
    by_cases hv : 0 ≤ v a
    · refine ⟨k, Or.inl rfl, ?_⟩
      rw [circleDist_at_residue (by omega) hk]
      simpa only [Int.cast_one] using
        (away_plus hd.le h3d hv (abs_le.mp (bdisp a ha0 ha)).2)
    · refine ⟨-k, Or.inr rfl, ?_⟩
      have hk' : (a : ℤ)*(-k) ≡ -1 [ZMOD (p : ℤ)] := by
        simpa only [mul_neg] using hk.neg
      rw [circleDist_at_residue (by omega) hk']
      simpa only [Int.cast_neg, Int.cast_one, neg_div] using
        (away_minus hd.le h3d (le_of_lt (lt_of_not_ge hv))
          (abs_le.mp (bdisp a ha0 ha)).1)
  obtain ⟨l, hl, goodA⟩ := choose_time
  have reflect_nom (i : ℕ) :
      circleDist ((i : ℝ)*((l : ℝ)/p)) = circleDist ((i : ℝ)*((k : ℝ)/p)) := by
    rcases hl with e | e
    · rw [e]
    · rw [e, Int.cast_neg, neg_div, mul_neg, circleDist_neg]
  have goodH : d ≤ circleDist ((h : ℝ)*((l : ℝ)/p) + v h) := by
    rw [vh, add_zero, reflect_nom]
    have e := circleDist_at_residue (by omega : 0 < p) hkH (0 : ℝ)
    simp only [add_zero, Int.cast_neg, Int.cast_one, neg_div, circleDist_neg] at e
    rw [e]
    change d ≤ circleDist d
    have hd0 : 0 < d := hd
    have hsmall : 3*d < 1/2 := h3d
    rw [circleDist_eq_abs (by rw [abs_of_pos hd0]; linarith), abs_of_pos hd0]
  obtain ⟨j, hj0, hj, hn⟩ := hc ((l : ℝ)/p - b)
  rw [show (j : ℝ)*((l : ℝ)/p-b) + u j =
      (j : ℝ)*((l : ℝ)/p) + v j by dsimp [v]; ring] at hn
  have nja : j ≠ a := by rintro rfl; exact (not_lt_of_ge goodA) hn
  have njh : j ≠ h := by rintro rfl; exact (not_lt_of_ge goodH) hn
  have lip := circleDist_le_add_abs ((j : ℝ)*((l : ℝ)/p)) (v j)
  rw [reflect_nom] at lip
  have lo := other_runner_nominal ha hj hj0 nja njh ha0 hk
  rw [← mul_mesh 2 p] at lo
  change 2*d ≤ _ at lo
  change _ < d at hn
  have big : d < |v j| := by linarith
  have nom3 : circleDist ((j : ℝ)*((k : ℝ)/p)) < 3*d := by
    linarith [bdisp j hj0 hj]
  have cls := classify_two ha0 ha hj0 hj nja njh hk nom3
  have sl : (j : ℝ)*s < |u j| := shift_slack hp hpr hc hb
    (show r + M*s ≤ d by linarith [hMs]) hs hj0 hj
  have jM : (j : ℝ) ≤ M := index_bound hj
  have jR : 0 ≤ (j : ℝ) := Nat.cast_nonneg j
  have hscale : (j : ℝ)*(r/(h : ℝ)-s) ≤ d := by
    by_cases hpos : 0 ≤ r/(h : ℝ)-s
    · have hb' : M*(r/(h : ℝ)-s) ≤ d := by rw [mul_sub]; linarith
      exact (mul_le_mul_of_nonneg_right jM hpos).trans hb'
    · exact (mul_nonpos_of_nonneg_of_nonpos jR (le_of_lt (lt_of_not_ge hpos))).trans hd.le
  have hy : |(j : ℝ)*b| ≤ d + |u j| := by
    rw [abs_mul, abs_of_nonneg jR]
    rw [mul_sub] at hscale
    linarith [mul_le_mul_of_nonneg_left hab jR]
  have diff := incompatible (bd j hj0 hj) hy big
  have notsame : ¬ (0 < u j ↔ 0 < u h) := by
    intro e
    by_cases hx : 0 < u j
    · exact diff (Or.inl ⟨hx.le, mul_nonneg jR (div_nonneg (e.mp hx).le hhR.le)⟩)
    · have hhx : u h ≤ 0 := le_of_not_gt (fun hhx => hx (e.mpr hhx))
      exact diff (Or.inr ⟨le_of_not_gt hx,
        mul_nonpos_of_nonneg_of_nonpos jR (div_nonpos_of_nonpos_of_nonneg hhx hhR.le)⟩)
  have e : 0 < u a ↔ 0 < u h := pair_iff hp hpr hc bd ha0 ha
  exact ⟨j, hj0, hj, cls, by tauto⟩

private theorem any_step {p a : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    {u : ℕ → ℝ} (hc : Cover p u) (hb : Box p u (tubeRadius p))
    (ha0 : 0 < a) (ha : a < p) :
    ∃ j : ℕ, 0 < j ∧ j < p ∧ ModSign p (j : ℤ) ((a : ℤ)*2) ∧
      (0 < u j ↔ ¬ 0 < u a) := by
  by_cases h : a < p-a
  · exact small_step hp hpr hc hb ha0 h
  have hn : ¬ 2 ∣ p := by
    intro hh
    rcases (Nat.dvd_prime hpr).mp hh with H | H <;> omega
  have hne : a ≠ p-a := by
    intro e
    exact hn ⟨a, by omega⟩
  have he : p - (p-a) = a := by omega
  obtain ⟨j, hj0, hj, cls, flip⟩ := small_step (a := p-a) hp hpr hc hb
    (by omega) (by omega)
  have base : ModSign p ((p-a : ℕ) : ℤ) (a : ℤ) := Or.inr (complement_mod ha.le)
  have bd : Box p u (mesh p) := fun i hi0 hi =>
    (hb i hi0 hi).trans (radius_lt_mesh hp).le
  have same := pair_iff hp hpr hc bd ha0 ha
  exact ⟨j, hj0, hj, ms_trans cls (ms_mul base 2), by tauto⟩

private abbrev Node (p : ℕ) (u : ℕ → ℝ) (x : ℤ) (P : Prop) : Prop :=
  ∃ j : ℕ, 0 < j ∧ j < p ∧ ModSign p (j : ℤ) x ∧ (0 < u j ↔ P)

private theorem cover_impossible {p n : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    {u : ℕ → ℝ} (hb : Box p u (tubeRadius p)) (hn : Odd n)
    (hend : ModSign p ((2 : ℤ)^n) 1) : ¬ Cover p u := by
  classical
  intro hc
  have next {x : ℤ} {P : Prop} (nd : Node p u x P) : Node p u (x*2) (¬ P) := by
    obtain ⟨a, ha0, ha, cls, he⟩ := nd
    obtain ⟨j, hj0, hj, cls', flip⟩ := any_step hp hpr hc hb ha0 ha
    exact ⟨j, hj0, hj, ms_trans cls' (ms_mul cls 2), by tauto⟩
  have even_walk (m : ℕ) : Node p u ((2 : ℤ)^(m+m)) (0 < u 1) := by
    induction m with
    | zero =>
      exact ⟨1, by decide, by omega, Or.inl (by norm_num [Int.ModEq]), Iff.rfl⟩
    | succ m ih =>
      have h := next (next ih)
      rw [show m.succ + m.succ = (m+m+1)+1 by omega, pow_succ, pow_succ]
      simpa only [not_not] using h
  obtain ⟨m, hm⟩ := hn
  have en : n = (m+m)+1 := by omega
  have hit : Node p u ((2 : ℤ)^n) (¬ 0 < u 1) := by
    rw [en, pow_succ]
    exact next (even_walk m)
  obtain ⟨j, hj0, hj, cls, flip⟩ := hit
  have bd : Box p u (mesh p) := fun i hi0 hi =>
    (hb i hi0 hi).trans (radius_lt_mesh hp).le
  have same : 0 < u j ↔ 0 < u 1 := by
    rcases ms_trans cls hend with H | H
    · have ej : j = 1 := congr_nat_unique hj (by omega) H
      rw [ej]
    · have e := complement_mod (D := p) (a := 1) (by omega)
      have ej : j = p-1 := congr_nat_unique hj (by omega) (H.trans e.symm)
      rw [ej]
      exact (pair_iff (a := 1) hp hpr hc bd (by decide) (by omega)).symm
  tauto

/-- One common time works for every runner. -/
theorem exists_time_widerCube {p n : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    (hn : Odd n)
    (hend : (2 : ℤ)^n ≡ 1 [ZMOD (p : ℤ)] ∨ (2 : ℤ)^n ≡ -1 [ZMOD (p : ℤ)])
    (u : ℕ → ℝ) (hb : ∀ j, 0 < j → j < p → |u j| ≤ tubeRadius p) :
    ∃ t : ℝ, ∀ j : ℕ, 0 < j → j < p →
      1 / (p : ℝ) ≤ circleDist ((j : ℝ)*t + u j) := by
  classical
  by_contra! hc
  exact cover_impossible hp hpr hb hn hend hc

theorem loneliness_widerCube {p n : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    (hn : Odd n)
    (hend : (2 : ℤ)^n ≡ 1 [ZMOD (p : ℤ)] ∨ (2 : ℤ)^n ≡ -1 [ZMOD (p : ℤ)])
    (u : ℕ → ℝ) (hb : ∀ j, 0 < j → j < p → |u j| ≤ tubeRadius p) :
    1 / (p : ℝ) ≤ loneliness (p := p) (by omega) u := by
  obtain ⟨t, ht⟩ := exists_time_widerCube hp hpr hn hend u hb
  apply le_trans _ (gap_le_loneliness (p := p) (by omega) u t)
  apply le_gap
  intro j hj
  obtain ⟨hj0, hjp⟩ := Finset.mem_Ioo.mp hj
  exact ht j hj0 hjp

theorem loneliness_widerTube_lifts {p n : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    (hn : Odd n)
    (hend : (2 : ℤ)^n ≡ 1 [ZMOD (p : ℤ)] ∨ (2 : ℤ)^n ≡ -1 [ZMOD (p : ℤ)])
    (u : ℕ → ℝ) (τ : ℝ) (m : ℕ → ℤ)
    (hb : ∀ j : ℕ, 0 < j → j < p →
      |u j + (j : ℝ)*τ - (m j : ℝ)| ≤ tubeRadius p) :
    1 / (p : ℝ) ≤ loneliness (p := p) (by omega) u := by
  let v : ℕ → ℝ := fun j => u j + (j : ℝ)*τ - (m j : ℝ)
  obtain ⟨t, ht⟩ := exists_time_widerCube hp hpr hn hend v hb
  apply le_trans _ (gap_le_loneliness (p := p) (by omega) u (t+τ))
  apply le_gap
  intro j hj
  obtain ⟨hj0, hjp⟩ := Finset.mem_Ioo.mp hj
  rw [show (j : ℝ)*(t+τ) + u j = ((j : ℝ)*t + v j) + (m j : ℝ) by
    dsimp [v]; ring, circleDist_add_int]
  exact ht j hj0 hjp

/-- Existential tube, written without representatives. Rounding gives
independent integer lifts at the same `τ`, also on the closed boundary. -/
theorem loneliness_widerTube {p n : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    (hn : Odd n)
    (hend : (2 : ℤ)^n ≡ 1 [ZMOD (p : ℤ)] ∨ (2 : ℤ)^n ≡ -1 [ZMOD (p : ℤ)])
    (u : ℕ → ℝ) (htube : ∃ τ : ℝ, ∀ j : ℕ, 0 < j → j < p →
      circleDist (u j + (j : ℝ)*τ) ≤ tubeRadius p) :
    1 / (p : ℝ) ≤ loneliness (p := p) (by omega) u := by
  obtain ⟨τ, hτ⟩ := htube
  exact loneliness_widerTube_lifts hp hpr hn hend u τ
    (fun j => round (u j + (j : ℝ)*τ)) hτ

private theorem sub_return {p a b : ℕ} (hle : a ≤ b)
    (ha : ModSign p ((2 : ℤ)^a) 1) (hb : ModSign p ((2 : ℤ)^b) 1) :
    ModSign p ((2 : ℤ)^(b-a)) 1 := by
  have h := ms_mul ha ((2 : ℤ)^(b-a))
  rw [one_mul, ← pow_add, show a + (b-a) = b by omega] at h
  exact ms_trans (ms_symm h) hb

theorem odd_twoOrderModuloSign_iff (p : ℕ) :
    Odd (twoOrderModuloSign p) ↔ ∃ n : ℕ, 0 < n ∧ Odd n ∧
      ((2 : ℤ)^n ≡ 1 [ZMOD (p : ℤ)] ∨ (2 : ℤ)^n ≡ -1 [ZMOD (p : ℤ)]) := by
  classical
  by_cases ex : ∃ n : ℕ, 0 < n ∧ ModSign p ((2 : ℤ)^n) 1
  · rw [twoOrderModuloSign, dite_eq_left ex]
    let q := Nat.find ex
    have hq : 0 < q ∧ ModSign p ((2 : ℤ)^q) 1 := Nat.find_spec ex
    constructor
    · intro ho
      exact ⟨q, hq.1, ho, hq.2⟩
    · rintro ⟨n, hn0, hodd, hn⟩
      change Odd q
      let A (i : ℕ) : Prop := Odd i ∧ ModSign p ((2 : ℤ)^i) 1
      have E : ∃ i, A i := ⟨n, hodd, hn⟩
      let b := Nat.find E
      have hB : Odd b ∧ ModSign p ((2 : ℤ)^b) 1 := Nat.find_spec E
      obtain ⟨w, hw⟩ := hB.1
      have hb0 : 0 < b := by omega
      have leqb : q ≤ b := Nat.find_min' ex ⟨hb0, hB.2⟩
      by_contra hnot
      have hqm : q % 2 = 0 := by
        by_contra hh
        exact hnot ⟨q/2, by omega⟩
      have odd_diff : Odd (b-q) := ⟨(b-q)/2, by omega⟩
      have smaller : A (b-q) := ⟨odd_diff, sub_return leqb hq.2 hB.2⟩
      have bad : b ≤ b-q := Nat.find_min' E smaller
      have := hq.1
      omega
  · rw [twoOrderModuloSign, dite_eq_right ex]
    constructor
    · rintro ⟨k, hk⟩
      omega
    · rintro ⟨n, hn0, _, hn⟩
      exact False.elim (ex ⟨n, hn0, hn⟩)

theorem loneliness_widerTube_of_odd_order {p : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    (ho : Odd (twoOrderModuloSign p)) (u : ℕ → ℝ)
    (htube : ∃ τ : ℝ, ∀ j : ℕ, 0 < j → j < p →
      circleDist (u j + (j : ℝ)*τ) ≤ tubeRadius p) :
    1 / (p : ℝ) ≤ loneliness (p := p) (by omega) u := by
  obtain ⟨n, _, hn, hend⟩ := (odd_twoOrderModuloSign_iff p).mp ho
  exact loneliness_widerTube hp hpr hn hend u htube

end

end MathLab.PhaseNeighbourhood
