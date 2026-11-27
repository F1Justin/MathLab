module

public import Mathlib.Algebra.Order.Archimedean.Real.Basic
public import Mathlib.Data.Int.GCD
public import Mathlib.Data.Nat.Find
public import Mathlib.Tactic.Linarith
public import Mathlib.Tactic.FieldSimp
public import Mathlib.Tactic.NormNum
public import Mathlib.Tactic.Positivity
public import Mathlib.Tactic.Ring

/-! Transfer from the least original even track that covers a time to a retained or replacement track. -/

@[expose] public section

namespace RunnerLocalTransfer

/-- The original phase-zero track of index `i` covers `t`. -/
def IndexCovers (N : ℕ) (d t : ℝ) (i : ℕ) : Prop :=
  1 ≤ i ∧ i ≤ N ∧
    ∃ k : ℤ, |((2 * i : ℕ) : ℝ) * t - (k : ℝ)| ≤ d

def BaseCovers (N : ℕ) (d t : ℝ) : Prop :=
  ∃ i : ℕ, IndexCovers N d t i

/-- `Installed v p` means that the final system contains speed `v` at phase `p`. -/
def FinalCovers (Installed : ℕ → ℝ → Prop) (d t : ℝ) : Prop :=
  ∃ (v : ℕ) (p : ℝ) (m : ℤ),
    Installed v p ∧ |(v : ℝ) * t + p - (m : ℝ)| ≤ d

noncomputable def firstIndex {N : ℕ} {d t : ℝ} (H : BaseCovers N d t) : ℕ := by
  classical
  exact Nat.find (show ∃ i : ℕ, IndexCovers N d t i from H)

theorem firstIndex_spec {N : ℕ} {d t : ℝ} (H : BaseCovers N d t) :
    IndexCovers N d t (firstIndex H) := by
  classical
  exact Nat.find_spec (show ∃ i : ℕ, IndexCovers N d t i from H)

theorem firstIndex_le {N : ℕ} {d t : ℝ} (H : BaseCovers N d t)
    {j : ℕ} (hj : IndexCovers N d t j) : firstIndex H ≤ j := by
  classical
  exact Nat.find_min' (show ∃ i : ℕ, IndexCovers N d t i from H) hj

theorem int_dvd_of_dvd_natAbs {g : ℕ} {k : ℤ} (hg : g ∣ k.natAbs) :
    (g : ℤ) ∣ k := by
  obtain ⟨q, hq⟩ := hg
  cases k with
  | ofNat n =>
      change n = g * q at hq
      refine ⟨(q : ℤ), ?_⟩
      change (n : ℤ) = (g : ℤ) * (q : ℤ)
      exact_mod_cast hq
  | negSucc n =>
      change n + 1 = g * q at hq
      have he : ((n + 1 : ℕ) : ℤ) = (g : ℤ) * (q : ℤ) := by
        exact_mod_cast hq
      refine ⟨-(q : ℤ), ?_⟩
      change -((n + 1 : ℕ) : ℤ) = (g : ℤ) * -(q : ℤ)
      rw [he, mul_neg]

/-- A nontrivial common divisor gives a strictly earlier hit. The new
integer witness is the exact integer quotient, also when `k` is negative. -/
theorem divide_hit {i g : ℕ} {k : ℤ} {d t : ℝ}
    (hi : 1 ≤ i) (hg : 1 < g) (hgi : g ∣ i) (hgk : g ∣ k.natAbs)
    (hk : |((2 * i : ℕ) : ℝ) * t - (k : ℝ)| ≤ d) :
    1 ≤ i / g ∧ i / g < i ∧
      |((2 * (i / g) : ℕ) : ℝ) * t - ((k / (g : ℤ) : ℤ) : ℝ)| ≤ d := by
  let j : ℕ := i / g
  let q : ℤ := k / (g : ℤ)
  have hji : j * g = i := Nat.div_mul_cancel hgi
  have hqk : q * (g : ℤ) = k :=
    Int.ediv_mul_cancel (int_dvd_of_dvd_natAbs hgk)
  have hjpos : 1 ≤ j := by
    apply Nat.pos_of_ne_zero
    intro hj0
    rw [hj0, Nat.zero_mul] at hji
    omega
  have hjlt : j < i := Nat.div_lt_self (show 0 < i from hi) hg
  refine ⟨hjpos, hjlt, ?_⟩
  change |((2 * j : ℕ) : ℝ) * t - (q : ℝ)| ≤ d
  have hjiR : (j : ℝ) * (g : ℝ) = (i : ℝ) := by
    simpa only [Nat.cast_mul] using congrArg (fun n : ℕ => (n : ℝ)) hji
  have hqkR : (q : ℝ) * (g : ℝ) = (k : ℝ) := by
    simpa only [Int.cast_mul, Int.cast_natCast] using
      congrArg (fun n : ℤ => (n : ℝ)) hqk
  have hscale :
      (((2 * j : ℕ) : ℝ) * t - (q : ℝ)) * (g : ℝ) =
        ((2 * i : ℕ) : ℝ) * t - (k : ℝ) := by
    simp only [Nat.cast_mul]
    rw [← hjiR, ← hqkR]
    ring
  have hgR : (1 : ℝ) ≤ (g : ℝ) := by exact_mod_cast (le_of_lt hg)
  have hg0R : (0 : ℝ) ≤ (g : ℝ) := by positivity
  calc
    |((2 * j : ℕ) : ℝ) * t - (q : ℝ)| =
        |((2 * j : ℕ) : ℝ) * t - (q : ℝ)| * 1 := (mul_one _).symm
    _ ≤ |((2 * j : ℕ) : ℝ) * t - (q : ℝ)| * (g : ℝ) :=
      mul_le_mul_of_nonneg_left hgR (abs_nonneg _)
    _ = |((2 * i : ℕ) : ℝ) * t - (k : ℝ)| := by
      rw [← hscale, abs_mul, abs_of_nonneg hg0R]
    _ ≤ d := hk

/-- Every integer witnessing a hit at the least covering index is primitive. -/
theorem firstIndex_coprime {N : ℕ} {d t : ℝ} (H : BaseCovers N d t)
    {k : ℤ} (hk : |((2 * firstIndex H : ℕ) : ℝ) * t - (k : ℝ)| ≤ d) :
    Nat.Coprime (firstIndex H) k.natAbs := by
  let i := firstIndex H
  have hi : IndexCovers N d t i := firstIndex_spec H
  have hi1 : 1 ≤ i := hi.1
  have hiN : i ≤ N := hi.2.1
  let g := Nat.gcd i k.natAbs
  change g = 1
  by_contra hne
  have hgi : g ∣ i := Nat.gcd_dvd_left i k.natAbs
  have hgk : g ∣ k.natAbs := Nat.gcd_dvd_right i k.natAbs
  have hg0 : g ≠ 0 := by
    intro hz
    obtain ⟨u, hu⟩ := hgi
    rw [hz, Nat.zero_mul] at hu
    omega
  have hg : 1 < g := by omega
  obtain ⟨hj1, hjlt, hjdev⟩ := divide_hit hi1 hg hgi hgk hk
  have hj : IndexCovers N d t (i / g) :=
    ⟨hj1, le_trans (le_of_lt hjlt) hiN, k / (g : ℤ), hjdev⟩
  have hle : i ≤ i / g := firstIndex_le H hj
  omega

/-- The local certificate for a removed or rephased track. The installed
replacement may depend on both the primitive center `k` and the offset `z`. -/
def LocalAt (Installed : ℕ → ℝ → Prop) (d : ℝ) (i : ℕ) : Prop :=
  ∀ k : ℤ, Nat.Coprime i k.natAbs →
    ∀ z : ℝ, -1 ≤ z → z ≤ 1 →
      ∃ (v : ℕ) (a h : ℝ) (m : ℤ),
        Installed v (a + h * d) ∧
        (v : ℝ) * (k : ℝ) / ((2 * i : ℕ) : ℝ) + a = (m : ℝ) ∧
        |(v : ℝ) / ((2 * i : ℕ) : ℝ) * z + h| ≤ 1

/-- Soundness of the certificate at a single primitive hit. -/
theorem localAt_covers {Installed : ℕ → ℝ → Prop} {d t : ℝ} {i : ℕ} {k : ℤ}
    (hd : 0 < d) (hi : 1 ≤ i) (hloc : LocalAt Installed d i)
    (hprim : Nat.Coprime i k.natAbs)
    (hk : |((2 * i : ℕ) : ℝ) * t - (k : ℝ)| ≤ d) :
    FinalCovers Installed d t := by
  let s : ℝ := ((2 * i : ℕ) : ℝ)
  have hspos : 0 < s := by
    change (0 : ℝ) < ((2 * i : ℕ) : ℝ)
    exact_mod_cast (show 0 < 2 * i by omega)
  let z : ℝ := (s * t - (k : ℝ)) / d
  have hzabs : |z| ≤ 1 := by
    change |(s * t - (k : ℝ)) / d| ≤ 1
    rw [abs_div, abs_of_pos hd]
    exact (div_le_iff₀ hd).2 (by simpa only [one_mul] using hk)
  obtain ⟨v, a, h, m, hp, hm, hb⟩ :=
    hloc k hprim z (abs_le.mp hzabs).1 (abs_le.mp hzabs).2
  change (v : ℝ) * (k : ℝ) / s + a = (m : ℝ) at hm
  change |(v : ℝ) / s * z + h| ≤ 1 at hb
  have hdev :
      (v : ℝ) * t + (a + h * d) - (m : ℝ) =
        ((v : ℝ) / s * z + h) * d := by
    rw [← hm]
    dsimp only [z]
    field_simp [ne_of_gt hspos, ne_of_gt hd]
    ring
  refine ⟨v, a + h * d, m, hp, ?_⟩
  rw [hdev, abs_mul, abs_of_pos hd]
  simpa only [one_mul] using mul_le_mul_of_nonneg_right hb hd.le

/-- Pointwise transfer does not require a base-cover theorem or a restriction
on `t`. Only the least original track covering this particular `t` is used. -/
theorem transfer {N : ℕ} {d t : ℝ}
    {Installed : ℕ → ℝ → Prop} {Changed : ℕ → Prop}
    (hd : 0 < d)
    (hkeep : ∀ i : ℕ, 1 ≤ i → i ≤ N → ¬ Changed i → Installed (2 * i) 0)
    (hnew : ∀ i : ℕ, 1 ≤ i → i ≤ N → Changed i → LocalAt Installed d i)
    (H : BaseCovers N d t) : FinalCovers Installed d t := by
  classical
  let i := firstIndex H
  obtain ⟨hi1, hiN, k, hk⟩ :=
    (show IndexCovers N d t i from firstIndex_spec H)
  by_cases hc : Changed i
  · exact localAt_covers hd hi1 (hnew i hi1 hiN hc) (firstIndex_coprime H hk) hk
  · refine ⟨2 * i, 0, k, hkeep i hi1 hiN hc, ?_⟩
    simpa only [add_zero] using hk

/-- Unit-interval coverage, with the original system's coverage supplied
separately from the local replacement hypotheses. -/
theorem transfer_unit {N : ℕ} {d : ℝ}
    {Installed : ℕ → ℝ → Prop} {Changed : ℕ → Prop}
    (hd : 0 < d)
    (hkeep : ∀ i : ℕ, 1 ≤ i → i ≤ N → ¬ Changed i → Installed (2 * i) 0)
    (hnew : ∀ i : ℕ, 1 ≤ i → i ≤ N → Changed i → LocalAt Installed d i)
    (hbase : ∀ t : ℝ, 0 ≤ t → t ≤ 1 → BaseCovers N d t) :
    ∀ t : ℝ, 0 ≤ t → t ≤ 1 → FinalCovers Installed d t := by
  intro t ht0 ht1
  exact transfer (Changed := Changed) hd hkeep hnew (hbase t ht0 ht1)

end RunnerLocalTransfer
