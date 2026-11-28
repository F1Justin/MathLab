module
public import MathLab.WT.WindowBump
public import Mathlib.Analysis.Distribution.SchwartzSpace.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

@[expose] public section
namespace MathLab.WT.Window
open MeasureTheory Set Filter Function
open scoped SchwartzMap
noncomputable section

def distance (f g : ℝ → ℝ) : ℝ := ∫ x, |f x - g x|
def secondAbs (f : ℝ → ℝ) : ℝ := ∫ x, |f x| * x^2

def mask (n x : ℝ) := unitBump (x/(2*n))
theorem mask_range (n x : ℝ) : 0 ≤ mask n x ∧ mask n x ≤ 1 :=
  ⟨unitBump.nonneg,unitBump.le_one⟩
theorem mask_cont (n : ℝ) : Continuous (mask n) :=
  unitBump.continuous.comp (continuous_id.div_const (2*n))
theorem mask_even (n x : ℝ) : mask n (-x)=mask n x := by simpa only [mask,neg_div] using unitBump.neg (x/(2*n))
theorem mask_in {n : ℝ} (hn : 0<n) (x : ℝ) (hx : |x| ≤n) : mask n x = 1 := by
  apply unitBump.one_of_mem_closedBall
  change dist (x/(2*n)) 0 ≤ 3/4
  rw [Real.dist_eq,sub_zero,abs_div,abs_of_pos (by positivity : 0<2*n), div_le_iff₀ (by positivity)]
  linarith
theorem mask_out {n : ℝ} (hn : 0<n) (x : ℝ) (hx : 2*n < |x|) : mask n x=0 := by
  apply unitBump.zero_of_le_dist
  change 1 ≤ dist (x/(2*n)) 0
  rw [Real.dist_eq,sub_zero,abs_div,abs_of_pos (by positivity : 0<2*n), le_div_iff₀ (by positivity),one_mul]
  exact hx.le

structure Cut (s : ℝ → ℝ) (n A H J : ℝ) where
  f : ℝ → ℝ
  continuous : Continuous f
  compact : HasCompactSupport f
  support : ∀ x, 2*n < |x| → f x=0
  even : ∀ x, f (-x)=f x
  mass : ∫ x, f x=1
  sup : ∀ x, |f x| ≤H
  second : secondAbs f ≤ J
  close : distance f s ≤ A/n^10

set_option maxHeartbeats 1500000 in
theorem cuts (s : 𝓢(ℝ,ℝ)) (hse : ∀ x, s (-x)=s x) (hsm : ∫ x, s x=1) :
    ∃ A H J : ℝ, 0<A ∧ 0<H ∧ 0<J ∧ ∀ n, 1≤n → Nonempty (Cut s n A H J) := by
  let A : ℝ := ∫ x, |x|^10 * |s x|
  let H : ℝ := SchwartzMap.seminorm ℝ 0 0 s
  let J : ℝ := secondAbs s
  let K : ℝ := secondAbs bump
  have hA : 0≤A := integral_nonneg (fun _ => by positivity)
  have hJ : 0≤J := integral_nonneg (fun _ => by positivity)
  have hK : 0≤K := integral_nonneg (fun _ => by positivity)
  have hH (x : ℝ) : |s x| ≤ H := by simpa [H,Real.norm_eq_abs] using SchwartzMap.norm_le_seminorm ℝ s x
  have hH' : 0≤H := (abs_nonneg _).trans (hH 0)
  have iA : Integrable (fun x => |x|^10 * |s x|) := by
    simpa only [Real.norm_eq_abs] using s.integrable_pow_mul volume 10
  have iJ : Integrable (fun x => |s x| * x^2) := by
    simpa only [Real.norm_eq_abs,sq_abs,mul_comm] using s.integrable_pow_mul volume 2
  have hbabs : HasCompactSupport (fun x => |bump x|) := by
    simpa only [Real.norm_eq_abs] using bump_compact.norm
  have iK : Integrable (fun x => |bump x| * x^2) :=
    (bump_cont.abs.mul (continuous_id.pow 2)).integrable_of_hasCompactSupport hbabs.mul_right
  have hcenter := centerHeight_pos
  refine ⟨2*A+1,H+A*centerHeight+1,J+A*K+1,by positivity,by positivity,by positivity,?_⟩
  intro n hn
  have hn' : 0<n := by linarith
  have hn1 : 1≤n^10 := one_le_pow₀ hn
  let q (x : ℝ) := mask n x * s x
  have cq : Continuous q := (mask_cont n).mul s.continuous
  have sq_out (x : ℝ) (hx : 2*n < |x|) : q x=0 := by simp [q,mask_out hn' _ hx]
  have hq : HasCompactSupport q := compact_of_zero_outside sq_out
  have iq : Integrable q := cq.integrable_of_hasCompactSupport hq
  have ib : Integrable bump := bump_cont.integrable_of_hasCompactSupport bump_compact
  have is₀ : Integrable (s:ℝ→ℝ) := s.integrable
  have hqs (x : ℝ) : |q x| ≤|s x| := by
    dsimp [q]
    rw [abs_mul,abs_of_nonneg (mask_range n x).1]
    exact mul_le_of_le_one_left (abs_nonneg _) (mask_range n x).2
  have err₀ : distance q s ≤ A/n^10 := by
    rw [le_div_iff₀ (by positivity),distance, ← integral_mul_const]
    apply integral_mono ((iq.sub is₀).abs.mul_const _) iA
    intro x
    change |q x - s x| *n^10 ≤ |x|^10 * |s x|
    by_cases hx : |x| ≤n
    · simp [q,mask_in hn' _ hx]; positivity
    · have hpow := pow_le_pow_left₀ hn'.le (le_of_not_ge hx) 10
      have low : 0≤1-mask n x := sub_nonneg.mpr (mask_range n x).2
      rw [show q x-s x = -((1-mask n x)*s x) by dsimp [q]; ring, abs_neg,abs_mul,abs_of_nonneg low]
      calc
        _ ≤ |s x| *n^10 := mul_le_mul_of_nonneg_right (mul_le_of_le_one_left (abs_nonneg _)
          (by linarith [(mask_range n x).1])) (by positivity)
        _ ≤ _ := by rw [mul_comm]; exact mul_le_mul_of_nonneg_right hpow (abs_nonneg _)
  let δ : ℝ := 1-∫ x, q x
  have hδ : |δ| ≤distance q s := by
    have h : (∫ x, q x - s x) = -δ := by rw [integral_sub iq is₀,hsm]; dsimp [δ]; ring
    calc
      _ = |∫ x, q x-s x| := by rw [h,abs_neg]
      _ ≤ _ := abs_integral_le_integral_abs
  have hδ' : |δ| ≤A := (hδ.trans err₀).trans (div_le_self hA hn1)
  let f (x : ℝ) := q x + δ*bump x
  have cf : Continuous f := cq.add (continuous_const.mul bump_cont)
  have fs (x : ℝ) (hx : 2*n < |x|) : f x=0 := by simp [f,sq_out _ hx,bump_out _ (by linarith)]
  have mag (x : ℝ) : |f x| ≤ |s x| + A * |bump x| := by
    exact (abs_add_le _ _).trans (add_le_add (hqs _) (by
      rw [abs_mul]; exact mul_le_mul_of_nonneg_right hδ' (abs_nonneg _)))
  refine ⟨⟨f,cf,compact_of_zero_outside fs,fs,?_,?_,?_,?_,?_⟩⟩
  · intro x; simp [f,q,mask_even,hse,bump_even]
  · change (∫ x, q x + δ*bump x) = 1
    rw [integral_add iq (ib.const_mul _),integral_const_mul,bump_mass,mul_one]
    dsimp [δ]; ring
  · intro x
    have h := mag x
    rw [abs_of_nonneg (bump_nonneg _)] at h
    linarith [add_le_add (hH x) (mul_le_mul_of_nonneg_left (bump_bound x) hA)]
  · have hInt : Integrable (fun x => |s x| *x^2 + A*(|bump x| *x^2)) := iJ.add (iK.const_mul A)
    have h : secondAbs f ≤ ∫ x, |s x| *x^2 + A*(|bump x| *x^2) := by
      apply integral_mono_of_nonneg (Eventually.of_forall fun x => mul_nonneg (abs_nonneg _) (sq_nonneg _))
        hInt (Eventually.of_forall ?_)
      intro x
      convert mul_le_mul_of_nonneg_right (mag x) (sq_nonneg x) using 1
      ring
    rw [integral_add iJ (iK.const_mul A),integral_const_mul] at h
    change secondAbs f ≤ J+A*K at h
    linarith only [h]
  · have h : distance f s ≤ ∫ x, |q x-s x| + |δ| * bump x := by
      apply integral_mono_of_nonneg (Eventually.of_forall fun x => abs_nonneg _)
        ((iq.sub is₀).abs.add (ib.const_mul |δ|)) (Eventually.of_forall ?_)
      intro x
      change |f x-s x| ≤ |q x-s x| + |δ| * bump x
      rw [show f x-s x=(q x-s x)+δ*bump x by dsimp [f]; ring]
      exact (abs_add_le _ _).trans_eq (by rw [abs_mul,abs_of_nonneg (bump_nonneg _)])
    have iq' : Integrable (fun x => |q x-s x|) := (iq.sub is₀).abs
    rw [integral_add iq' (ib.const_mul _),integral_const_mul,bump_mass,mul_one] at h
    change distance f s ≤ distance q s + |δ| at h
    apply (h.trans (add_le_add err₀ (hδ.trans err₀))).trans
    rw [← add_div]
    exact div_le_div_of_nonneg_right (by linarith) (by positivity)

end
end MathLab.WT.Window
