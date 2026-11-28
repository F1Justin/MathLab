module
public import MathLab.WT.WindowBump
public import MathLab.WT.ConvolutionBounds
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith

/-! A prescribed squared energy can be placed in two open, reflected
shoulder intervals with arbitrarily small absolute mass. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set Window
open scoped ContDiff
noncomputable section

private theorem unit_bump_energy_pos : 0 < energy bump := by
  have hc : HasCompactSupport (fun x => bump x ^ 2) := compact_of_zero_outside (R := 1)
    (fun x h => by simp [bump_out x h])
  apply (bump_cont.pow 2).integral_pos_of_hasCompactSupport_nonneg_nonzero (x := 0) hc
    (fun x => sq_nonneg _)
  change bump 0 ^ 2 ≠ 0
  rw [bump_plateau 0 (by norm_num)]
  exact pow_ne_zero _ centerHeight_pos.ne'

theorem shoulder_energy_bump {l r d η : ℝ} (hl : 0 < l) (hlr : l < r)
    (hd : 0 ≤ d) (hη : 0 < η) :
    ∃ b : ℝ → ℝ, ContDiff ℝ ∞ b ∧ HasCompactSupport b ∧
      (∀ x, b (-x) = b x) ∧ (∀ x, |x| ≤ l ∨ r ≤ |x| → b x = 0) ∧
      energy b = d ∧ massAbs b ≤ η := by
  let E := energy bump
  have hE : 0 < E := unit_bump_energy_pos
  let u := min ((r-l)/4) (η^2*E/(2*(d+1)))
  have hu : 0 < u := lt_min (by linarith) (by positivity)
  have hui : u ≤ (r-l)/4 := min_le_left _ _
  have hum := (le_div_iff₀ (show 0 < 2*(d+1) by positivity)).mp
    (show u ≤ η^2*E/(2*(d+1)) from min_le_right _ _)
  let a := Real.sqrt (d*u/(2*E))
  have ha : 0 ≤ a := Real.sqrt_nonneg _
  have hasq : a^2*(2*E) = d*u := (eq_div_iff (by positivity)).mp
    (Real.sq_sqrt (show 0 ≤ d*u/(2*E) by positivity))
  have hsmall : 2*a ≤ η := by
    have hs : (2*a)^2 ≤ η^2 := by
      apply le_of_mul_le_mul_right _ hE
      nlinarith only [hasq,hum,hu.le]
    exact (sq_le_sq₀ (by positivity) hη.le).mp hs
  let c := (l+r)/2
  let p (x : ℝ) := wide u (x-c)
  let b (x : ℝ) := a*(p x+p (-x))
  have ps : ContDiff ℝ ∞ p := by
    apply (contDiff_const.mul (bump_smooth.comp (contDiff_const.mul contDiff_id))).comp
      (contDiff_id.sub contDiff_const)
  have bs : ContDiff ℝ ∞ b := contDiff_const.mul (ps.add (ps.comp contDiff_neg))
  have hzero (x : ℝ) (hx : x ≤ l ∨ r ≤ x) : p x = 0 := by
    apply wide_out hu
    dsimp [c]
    rcases hx with h | h
    · linarith [neg_le_abs (x-(l+r)/2)]
    · linarith [le_abs_self (x-(l+r)/2)]
  have outside (x : ℝ) (hx : |x| ≤ l ∨ r ≤ |x|) : b x = 0 := by
    have zero (z : ℝ) (hz : |z| ≤ l ∨ r ≤ |z|) : p z=0 := by
      apply hzero
      rcases hz with h | h
      · exact Or.inl (abs_le.mp h).2
      · rcases le_abs.mp h with h' | h'
        · exact Or.inr h'
        · exact Or.inl (by linarith)
    simp [b,zero x hx,zero (-x) (by simpa only [abs_neg] using hx)]
  have pi : Integrable p := ((wide_cont u).integrable_of_hasCompactSupport (μ := volume)
    (wide_compact hu)).comp_sub_right c
  have hp₂ : Integrable (fun x => (wide u x)^2) :=
    ((wide_cont u).pow 2).integrable_of_hasCompactSupport
      (compact_of_zero_outside (R := u) (fun x h => by simp [wide_out hu x h]))
  have pi₂ : Integrable (fun x => p x^2) := hp₂.comp_sub_right c
  have hp (x : ℝ) : 0 ≤ p x := wide_nonneg hu _
  have disjoint (x : ℝ) : p x * p (-x) = 0 := by
    by_cases h : x ≤ 0
    · rw [hzero x (.inl (by linarith)),zero_mul]
    · rw [hzero (-x) (.inl (by linarith)),mul_zero]
  have pe : energy p = E/u := by
    change energy (shift c (wide u)) = E/u
    rw [energy_shift]
    change energy (scaleFun u⁻¹ u⁻¹ bump) = E/u
    rw [energy_scaleFun _ _ (inv_pos.mpr hu)]
    dsimp only [E]
    field_simp
  have pm : (∫ x, p x) = 1 := (integral_shift c (wide u)).trans (wide_mass hu)
  refine ⟨b,bs,compact_of_zero_outside (R := r) (fun x hx => outside x (.inr hx.le)),?_,outside,?_,?_⟩
  · intro x
    simp only [b,neg_neg,add_comm (p (-x))]
  · have eq (x : ℝ) : b x^2 = a^2*(p x^2+p (-x)^2) := by
      change (a*(p x+p (-x)))^2 = _
      rw [mul_pow]
      congr 1
      nlinarith only [disjoint x]
    simp only [energy,eq,integral_const_mul,integral_add pi₂ pi₂.comp_neg,
      integral_neg_eq_self (fun x => p x^2) volume]
    change a^2*(energy p+energy p)=d
    rw [pe]
    field_simp
    nlinarith only [hasq]
  · have nn (x : ℝ) : 0 ≤ b x := mul_nonneg ha (add_nonneg (hp _) (hp _))
    simp only [massAbs,abs_of_nonneg (nn _),b,integral_const_mul,integral_add pi pi.comp_neg,
      integral_neg_eq_self p volume,pm]
    linarith

#print axioms shoulder_energy_bump
end
end MathLab.WT
