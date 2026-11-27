module

public import MathLab.PhaseNeighbourhood.Farey
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

@[expose] public section

namespace MathLab.PhaseNeighbourhood

theorem le_maxForm {p a : ℕ} (hp : 1 < p) (u : ℕ → ℝ) (ha : a ∈ speeds p) :
    |pairForm p u a| ≤ maxForm hp u :=
  Finset.le_sup' (fun a => |pairForm p u a|) ha

theorem maxForm_nonneg {p : ℕ} (hp : 1 < p) (u : ℕ → ℝ) :
    0 ≤ maxForm hp u := by
  obtain ⟨a, ha⟩ := speeds_nonempty hp
  exact (abs_nonneg _).trans (le_maxForm hp u ha)

theorem gap_add_int {p : ℕ} (hp : 1 < p) (u : ℕ → ℝ) (x : ℝ) (z : ℤ) :
    gap hp u (x + (z : ℝ)) = gap hp u x := by
  unfold gap
  apply Finset.inf'_congr _ rfl
  intro j hj
  have he : (j : ℝ) * (x + (z : ℝ)) + u j =
      (j : ℝ) * x + u j + (((j : ℤ) * z : ℤ) : ℝ) := by push_cast; ring
  rw [he, circleDist_add_int]

private theorem abs_difference_bound {x y A B r : ℝ}
    (hA : 0 ≤ A) (hB : 0 ≤ B) (hy : |y| ≤ r) :
    |A*x - B*y| ≤ A*|x| + B*r := by
  calc
    |A*x - B*y| ≤ |A*x| + |B*y| := by
      simpa only [sub_eq_add_neg, abs_neg] using abs_add_le (A*x) (-(B*y))
    _ ≤ A*|x|+B*r := by
      rw [abs_mul, abs_mul, abs_of_nonneg hA, abs_of_nonneg hB]
      linarith only [mul_le_mul_of_nonneg_left hy hB]

private theorem exceptional_phase {p q h : ℕ} (hp : 7 ≤ p) (u : ℕ → ℝ)
    (hgap : q+h = p+1) (hq : q ∈ speeds p) (hh : h ∈ speeds p)
    (hQ : q ≤ smallDenominator p)
    (hphase : ∀ j ∈ speeds p, |u j| ≤ sharpRadius p) :
    (1 + |(h : ℝ)*u q - (q : ℝ)*u h|) / ((p : ℝ)+1) ≤
      1 / (p : ℝ) + maxForm (show 1 < p by omega) u := by
  have hp1 : 1 < p := by omega
  let r := sharpRadius p
  let M := maxForm hp1 u
  let X := |u q|
  have hp' : 0 < (p : ℝ) := by exact_mod_cast (show 0 < p by omega)
  have hh' : (h : ℝ) = (p : ℝ) + 1 - q := by
    have h := congrArg (fun n : ℕ => (n : ℝ)) hgap
    push_cast at h
    linarith
  have hpos : 0 < (p : ℝ) + 1 := by positivity
  have hqle : q ≤ p := (Finset.mem_Ioo.mp hq).2.le
  have hm : |(((p : ℝ) - q) * u q - (q : ℝ)*u (p-q)) / (p : ℝ)| ≤ M := by
    simpa only [pairForm, Nat.cast_sub hqle] using le_maxForm hp1 u hq
  have hm1 : |((p : ℝ) - q) * u q - (q : ℝ)*u (p-q)| ≤ M * (p : ℝ) := by
    rw [abs_div, abs_of_pos hp'] at hm
    exact (div_le_iff₀ hp').mp hm
  have hqa := Finset.mem_Ioo.mp hq
  have hpq : p-q ∈ speeds p := Finset.mem_Ioo.mpr ⟨by omega, by omega⟩
  have hc : ((p : ℝ)-q)*X ≤ (p : ℝ)*M + (q : ℝ)*r := by
    have hq' : 0 ≤ (p : ℝ)-q := by
      exact sub_nonneg.mpr (by exact_mod_cast hqle)
    calc
      ((p : ℝ)-q)*X = |((p : ℝ)-q)*u q| := by
        rw [abs_mul, abs_of_nonneg hq']
      _ = |(((p : ℝ)-q)*u q - (q : ℝ)*u (p-q)) + (q : ℝ)*u (p-q)| := by
        congr 1
        ring
      _ ≤ |((p : ℝ)-q)*u q - (q : ℝ)*u (p-q)| + |(q : ℝ)*u (p-q)| :=
        abs_add_le _ _
      _ ≤ (p : ℝ)*M + (q : ℝ)*r := by
        rw [abs_mul, abs_of_nonneg (show 0 ≤ (q : ℝ) by positivity)]
        exact add_le_add (by simpa [mul_comm] using hm1)
          (mul_le_mul_of_nonneg_left (hphase (p-q) hpq) (by positivity))
  have hmul := mul_le_mul_of_nonneg_right hc hpos.le
  have hqx : (q : ℝ)*X ≤ (q : ℝ)*r :=
    mul_le_mul_of_nonneg_left (hphase q hq) (by positivity)
  have hmain : ((h : ℝ)*X + (q : ℝ)*r) / ((p : ℝ)+1) ≤ M + 2*(q : ℝ)*r/(p : ℝ) := by
    have he : M + 2*(q : ℝ)*r/(p : ℝ) =
        ((p : ℝ)*M+2*(q : ℝ)*r)/(p : ℝ) := by field_simp
    rw [he]
    apply (div_le_div_iff₀ hpos hp').mpr
    rw [hh']
    nlinarith only [hmul, hqx]
  have hcontrib : |(h : ℝ)*u q - (q : ℝ)*u h| ≤ (h : ℝ)*X + (q : ℝ)*r :=
    abs_difference_bound (by positivity) (by positivity) (hphase h hh)
  have hqr : 2*(q : ℝ)*r/(p : ℝ) ≤ 2*(smallDenominator p : ℝ)*r/(p : ℝ) := by
    have hqQ : (q : ℝ) ≤ (smallDenominator p : ℝ) := by exact_mod_cast hQ
    have hr : 0 ≤ r := (sharpRadius_pos hp).le
    exact div_le_div_of_nonneg_right
      (mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hqQ (by norm_num)) hr)
      hp'.le
  calc
    (1 + |(h : ℝ)*u q - (q : ℝ)*u h|) / ((p : ℝ)+1)
        ≤ 1 / ((p : ℝ)+1) + ((h : ℝ)*X+(q : ℝ)*r)/((p : ℝ)+1) := by
      rw [← add_div]
      exact div_le_div_of_nonneg_right (by linarith [hcontrib]) hpos.le
    _ ≤ 1 / ((p : ℝ)+1) + (M + 2*(smallDenominator p : ℝ)*r/(p : ℝ)) := by
      linarith only [hmain, hqr]
    _ = 1 / (p : ℝ) + M := by linarith only [sharpRadius_eq_exceptional hp]

private theorem gap_upper_unit {p : ℕ} (hp : 7 ≤ p) (hodd : Odd p) (u : ℕ → ℝ)
    (hphase : ∀ j ∈ speeds p, |u j| ≤ sharpRadius p) {x : ℝ} (hx₀ : 0 ≤ x) (hx₁ : x ≤ 1) :
    gap (show 1 < p by omega) u x ≤ 1 / (p : ℝ) + maxForm (show 1 < p by omega) u := by
  have hp1 : 1 < p := by omega
  let d := 1 / (p : ℝ)
  let M := maxForm hp1 u
  let r := sharpRadius p
  have hm : 0 ≤ M := maxForm_nonneg hp1 u
  have hr : 0 ≤ r := (sharpRadius_pos hp).le
  have hsmall : r ≤ d := by linarith only [four_mul_sharpRadius_le hp, hr]
  obtain ⟨P,q,R,h,hq0,hh0,hqp,hhp,hdet,hlen,hxL,hxR⟩ :=
    farey_tile (N := p-1) (by omega) hx₀ hx₁
  have hq : q ∈ speeds p := Finset.mem_Ioo.mpr ⟨hq0,by omega⟩
  have hh : h ∈ speeds p := Finset.mem_Ioo.mpr ⟨hh0,by omega⟩
  let A := (q : ℝ)*x - P + u q
  let B := (R : ℝ) - (h : ℝ)*x - u h
  have hA : gap hp1 u x ≤ |A| := by
    exact (gap_le_runner hp1 u x hq).trans
      (by convert circleDist_le_abs_sub ((q : ℝ)*x+u q) (P : ℤ) using 1; push_cast; congr 1; ring)
  have hB : gap hp1 u x ≤ |B| := by
    have he : B = -((h : ℝ)*x+u h - (R : ℝ)) := by dsimp [B]; ring
    rw [he, abs_neg]
    exact (gap_le_runner hp1 u x hh).trans
      (by simpa only [Int.cast_natCast] using circleDist_le_abs_sub ((h : ℝ)*x+u h) (R : ℤ))
  have hq' : 0 < (q : ℝ) := by exact_mod_cast hq0
  have hh' : 0 < (h : ℝ) := by exact_mod_cast hh0
  by_cases hAn : A < 0
  · have hx := (div_le_iff₀ hq').mp hxL
    have hu := abs_le.mp (hphase q hq)
    rw [abs_of_neg hAn] at hA
    dsimp only [A] at hA
    linarith only [hA, hx, hu.1, hsmall, hm]
  by_cases hBn : B < 0
  · have hx := (le_div_iff₀ hh').mp hxR
    have hu := abs_le.mp (hphase h hh)
    rw [abs_of_neg hBn] at hB
    dsimp only [B] at hB
    linarith only [hB, hx, hu.2, hsmall, hm]
  rw [abs_of_nonneg (le_of_not_gt hAn)] at hA
  rw [abs_of_nonneg (le_of_not_gt hBn)] at hB
  have hsumPos : 0 < (q : ℝ) + h := by positivity
  have hdetReal : (q : ℝ)*R = (h : ℝ)*P + 1 := by exact_mod_cast hdet
  have hpeak : gap hp1 u x ≤ (1 + (h : ℝ)*u q - (q : ℝ)*u h)/((q : ℝ)+h) := by
    apply (le_div_iff₀ hsumPos).mpr
    have h1 := mul_le_mul_of_nonneg_right hA hh'.le
    have h2 := mul_le_mul_of_nonneg_right hB hq'.le
    dsimp only [A, B] at h1 h2
    nlinarith only [h1, h2, hdetReal]
  have hpeak' : gap hp1 u x ≤ (1 + |(h : ℝ)*u q - (q : ℝ)*u h|)/((q : ℝ)+h) := by
    apply hpeak.trans
    apply div_le_div_of_nonneg_right _ hsumPos.le
    linarith only [le_abs_self ((h : ℝ)*u q - (q : ℝ)*u h)]
  by_cases hpSum : q+h = p
  · have hd : (q : ℝ)+h = (p : ℝ) := by exact_mod_cast hpSum
    have hsub : p-q = h := by omega
    have hpos : 0 < (p : ℝ) := by linarith only [hd, hsumPos]
    have hm' := le_maxForm hp1 u hq
    rw [pairForm, hsub, abs_div, abs_of_pos hpos] at hm'
    rw [hd, add_div] at hpeak'
    linarith only [hpeak', hm']
  by_cases hpSum' : q+h = p+1
  · have hd : (q : ℝ)+h = (p : ℝ)+1 := by exact_mod_cast hpSum'
    rw [hd] at hpeak'
    rcases le_total q h with hqh | hhq
    · exact hpeak'.trans (exceptional_phase hp u hpSum' hq hh
        (exceptional_farey_denominator hp hodd (Or.inl hdet) hpSum' hqh) hphase)
    · have hSmall : h ≤ smallDenominator p :=
        exceptional_farey_denominator hp hodd (Or.inr hdet) (by omega) hhq
      have hs : |(h : ℝ)*u q - (q : ℝ)*u h| = |(q : ℝ)*u h - (h : ℝ)*u q| := abs_sub_comm _ _
      rw [hs] at hpeak'
      exact hpeak'.trans (exceptional_phase hp u (by omega) hh hq hSmall hphase)
  · have hk : (p : ℝ)+2 ≤ (q : ℝ)+h := by exact_mod_cast (show p+2 ≤ q+h by omega)
    have hfar : |(h : ℝ)*u q - (q : ℝ)*u h| ≤ ((q : ℝ)+h)*r := by
      have h0 := abs_difference_bound (x := u q) hh'.le hq'.le (hphase h hh)
      have h1 := mul_le_mul_of_nonneg_left (hphase q hq) hh'.le
      nlinarith only [h0,h1]
    have hn : (1+|(h : ℝ)*u q-(q : ℝ)*u h|)/((q : ℝ)+h) ≤
        1/((q : ℝ)+h)+r := by
      rw [add_div]
      have hscaled : |(h : ℝ)*u q - (q : ℝ)*u h| / ((q : ℝ)+h) ≤ r := by
        apply (div_le_iff₀ hsumPos).mpr
        rw [mul_comm r]
        exact hfar
      linarith only [hscaled]
    have hdiv := one_div_le_one_div_of_le (show 0 < (p : ℝ)+2 by positivity) hk
    have hrFar := sharpRadius_le_far hp hodd
    linarith only [hpeak', hn, hdiv, hrFar, hm]

theorem sharp_cube_upper {p : ℕ} (hp : 7 ≤ p) (hprime : p.Prime)
    (u : ℕ → ℝ) (hphase : ∀ j ∈ speeds p, |u j| ≤ sharpRadius p) :
    loneliness (show 1 < p by omega) u ≤ 1 / (p : ℝ) + maxForm (show 1 < p by omega) u := by
  have hp1 : 1 < p := by omega
  apply loneliness_le hp1
  intro t
  let z := ⌊t⌋
  let x : ℝ := t - (z : ℝ)
  have hx : 0 ≤ x := sub_nonneg.mpr (Int.floor_le t)
  have hxx : x ≤ 1 := (Int.fract_lt_one t).le
  have he : t = x + (z : ℝ) := by dsimp [x]; ring
  rw [he, gap_add_int]
  exact gap_upper_unit hp (hprime.odd_of_ne_two (by omega)) u hphase hx hxx

private theorem positive_pair_peak {p a : ℕ} (hp : 7 ≤ p) (hprime : p.Prime)
    (u : ℕ → ℝ) (ha : a ∈ speeds p)
    (hphase : ∀ j ∈ speeds p, |u j| ≤ sharpRadius p)
    (hs : 0 ≤ pairForm p u a) :
    ∃ t : ℝ, ∀ j ∈ speeds p,
      1/(p : ℝ) + pairForm p u a ≤ circleDist ((j : ℝ)*t+u j) := by
  have hpNat : 0 < p := by omega
  have hp' : 0 < (p : ℝ) := by exact_mod_cast hpNat
  have h7 : (7 : ℝ) ≤ p := by exact_mod_cast hp
  obtain ⟨ha0, hpa⟩ := Finset.mem_Ioo.mp ha
  let b := p-a
  have hb : b ∈ speeds p := Finset.mem_Ioo.mpr ⟨by dsimp [b]; omega, by dsimp [b]; omega⟩
  have hbCast : (b : ℝ) = (p : ℝ)-a := Nat.cast_sub hpa.le
  let r := sharpRadius p
  let d : ℝ := 1/(p : ℝ)
  let X := pairForm p u a
  have hr : 0 ≤ r := (sharpRadius_pos hp).le
  have hd : 0 < d := one_div_pos.mpr hp'
  have hr4 : 4*r ≤ d := four_mul_sharpRadius_le hp
  have hsmall : d+r < 1/2 := by
    have hdp : d ≤ 1/7 := one_div_le_one_div_of_le (by norm_num) h7
    linarith only [hdp, hr4]
  have hX : X ≤ r := by
    have hv := abs_difference_bound (A := (b : ℝ)) (B := (a : ℝ))
      (x := u a) (by positivity) (by positivity) (hphase b hb)
    have hh := mul_le_mul_of_nonneg_left (hphase a ha) (show 0 ≤ (b : ℝ) by positivity)
    unfold X pairForm
    apply (div_le_iff₀ hp').mpr
    change (b : ℝ)*u a - (a : ℝ)*u b ≤ r*(p : ℝ)
    have he : (b : ℝ)*u a-(a : ℝ)*u b ≤ |(b : ℝ)*u a-(a : ℝ)*u b| := le_abs_self _
    rw [hbCast] at hv hh he
    rw [hbCast]
    nlinarith only [hv, hh, he]
  obtain ⟨k,hka⟩ := inverse_mod_of_coprime (Nat.coprime_of_lt_prime ha0.ne' hpa hprime).symm
  have hkb : (b : ℤ)*k ≡ -1 [ZMOD (p : ℤ)] := complement_inverse hpa.le hka
  let τ : ℝ := (k : ℝ)/(p : ℝ) - (u a+u b)/(p : ℝ)
  refine ⟨τ, ?_⟩
  intro j hj
  by_cases hjA : j = a
  · subst j
    have he : (a : ℝ)*τ+u a = (a : ℝ)*((k : ℝ)/(p : ℝ))+X := by
      dsimp only [τ, X, pairForm]
      rw [← show ((p-a : ℕ) : ℝ) = (b : ℝ) from rfl, hbCast]
      field_simp
      ring
    rw [he, circleDist_at_residue hpNat hka X, Int.cast_one]
    rw [circleDist_eq_abs (by rw [abs_of_nonneg (by linarith only [hd, hs])]; linarith only [hsmall,hX]),
      abs_of_nonneg (by linarith only [hd, hs])]
  by_cases hjB : j = b
  · subst j
    have he : (b : ℝ)*τ+u b = (b : ℝ)*((k : ℝ)/(p : ℝ))+(-X) := by
      dsimp only [τ, X, pairForm]
      change (b : ℝ)*((k : ℝ)/(p : ℝ)-(u a+u b)/(p : ℝ))+u b =
        (b : ℝ)*((k : ℝ)/(p : ℝ))+ -(((b : ℝ)*u a-(a : ℝ)*u b)/(p : ℝ))
      rw [hbCast]
      field_simp
      ring
    rw [he, circleDist_at_residue hpNat hkb (-X), Int.cast_neg, Int.cast_one]
    have he' : (-1 : ℝ)/(p : ℝ)+(-X) = -(d+X) := by dsimp [d]; ring
    rw [he', circleDist_neg, circleDist_eq_abs (by
      rw [abs_of_nonneg (by linarith only [hd, hs])]
      linarith only [hsmall,hX]), abs_of_nonneg (by linarith only [hd,hs])]
  have hj0 := Finset.mem_Ioo.mp hj
  have hnom := other_runner_nominal hpa hj0.2 hj0.1 hjA hjB ha0 hka
  let v : ℝ := u j - ((j : ℝ)/(p : ℝ))*(u a+u b)
  have hv : |v| ≤ 3*r := by
    have hsum : |u a+u b| ≤ 2*r := by
      linarith only [abs_add_le (u a) (u b),hphase a ha,hphase b hb]
    have hprod : 0 ≤ (j : ℝ)/(p : ℝ) := by positivity
    have htri := abs_difference_bound (A := (1:ℝ)) (B := (j : ℝ)/(p:ℝ))
      (x := u j) (by norm_num) hprod hsum
    have hjle : (j : ℝ)/(p : ℝ) ≤ 1 := by
      apply (div_le_iff₀ hp').mpr
      simpa using (show (j : ℝ) ≤ (p : ℝ) by exact_mod_cast hj0.2.le)
    have hscale := mul_le_mul_of_nonneg_right hjle (show 0 ≤ 2*r by positivity)
    simp only [one_mul] at htri hscale
    dsimp only [v]
    linarith only [htri,hscale,hphase j hj]
  have htime : (j : ℝ)*τ+u j = (j : ℝ)*((k : ℝ)/(p : ℝ))+v := by
    dsimp only [τ,v]
    field_simp
    ring
  rw [htime]
  have hl := circleDist_le_add_abs ((j : ℝ)*((k : ℝ)/(p : ℝ))) v
  have hnom' : 2*d ≤ circleDist ((j : ℝ)*((k : ℝ)/(p : ℝ))) := by
    simpa only [d, mul_one_div, mul_one] using hnom
  linarith only [hl,hv,hnom',hr4,hX]

theorem sharp_cube_lower {p : ℕ} (hp : 7 ≤ p) (hprime : p.Prime)
    (u : ℕ → ℝ) (hphase : ∀ j ∈ speeds p, |u j| ≤ sharpRadius p) :
    1/(p : ℝ) + maxForm (show 1 < p by omega) u ≤ loneliness (show 1 < p by omega) u := by
  have hp1 : 1 < p := by omega
  obtain ⟨a,ha,he⟩ := Finset.exists_mem_eq_sup' (speeds_nonempty hp1)
    (fun a => |pairForm p u a|)
  change maxForm hp1 u = |pairForm p u a| at he
  rw [he]
  by_cases hX : 0 ≤ pairForm p u a
  · rw [abs_of_nonneg hX]
    obtain ⟨t, ht⟩ := positive_pair_peak hp hprime u ha hphase hX
    exact (le_gap hp1 ht).trans (gap_le_loneliness hp1 u t)
  · let v := fun j => -(u j)
    have hXv : pairForm p v a = -(pairForm p u a) := by
      unfold pairForm v
      ring
    have hv : ∀ j ∈ speeds p, |v j| ≤ sharpRadius p := by
      simpa only [v,abs_neg] using hphase
    obtain ⟨t, ht⟩ := positive_pair_peak hp hprime v ha hv
      (by rw [hXv]; linarith)
    rw [abs_of_neg (lt_of_not_ge hX)]
    apply le_trans (le_gap (t := -t) hp1 ?_) (gap_le_loneliness hp1 u (-t))
    intro j hj
    rw [show (j : ℝ)*(-t)+u j = -((j : ℝ)*t+v j) by dsimp [v]; ring, circleDist_neg]
    simpa only [hXv] using ht j hj

/-- The exact phase formula on the closed sharp cube. -/
theorem sharp_cube_formula {p : ℕ} (hp : 7 ≤ p) (hprime : p.Prime)
    (u : ℕ → ℝ) (hphase : ∀ j ∈ speeds p, |u j| ≤ sharpRadius p) :
    loneliness (show 1 < p by omega) u = 1/(p : ℝ) + maxForm (show 1 < p by omega) u :=
  le_antisymm (sharp_cube_upper hp hprime u hphase) (sharp_cube_lower hp hprime u hphase)

end MathLab.PhaseNeighbourhood
