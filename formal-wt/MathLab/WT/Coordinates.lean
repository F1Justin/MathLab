module
public import MathLab.WT.Basic
import Mathlib.MeasureTheory.Group.Integral
import Mathlib.MeasureTheory.Measure.Haar.Unique
import Mathlib.Tactic.Linarith

/-! Translation to separate window and table centres, and conversion of a
single even pair on the centred intervals into an actual WT witness. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set
noncomputable section

def shift (a : ℝ) (f : ℝ → ℝ) (x : ℝ) := f (x - a)
def mirror (a : ℝ) (f : ℝ → ℝ) (x : ℝ) := f (a - x)

theorem integral_shift (a : ℝ) (f : ℝ → ℝ) : (∫ x, shift a f x) = ∫ x, f x :=
  integral_sub_right_eq_self f a

theorem integral_mirror (a : ℝ) (f : ℝ → ℝ) : (∫ x, mirror a f x) = ∫ x, f x :=
  integral_sub_left_eq_self f volume a

lemma Regular.shift {f : ℝ → ℝ} (hf : Regular f) (a : ℝ) : Regular (WT.shift a f) :=
  ⟨hf.1.comp_sub_right a, hf.2.imp fun _ h x => h (x-a)⟩

lemma Regular.mirror {f : ℝ → ℝ} (hf : Regular f) (a : ℝ) : Regular (WT.mirror a f) :=
  ⟨hf.1.comp_sub_left a, hf.2.imp fun _ h x => h (a-x)⟩

theorem energy_shift (a : ℝ) (f : ℝ → ℝ) : energy (shift a f) = energy f :=
  integral_sub_right_eq_self (fun x => f x ^ 2) a

theorem energy_mirror (a : ℝ) (f : ℝ → ℝ) : energy (mirror a f) = energy f :=
  integral_sub_left_eq_self (fun x => f x ^ 2) volume a

theorem conv_shift (a b : ℝ) (f g : ℝ → ℝ) (x : ℝ) :
    conv (shift a f) (shift b g) x = conv f g (x-(a+b)) := by
  unfold conv
  rw [← integral_sub_right_eq_self (fun y => f y * g (x - (a+b) - y)) a]
  apply integral_congr_ae (Filter.Eventually.of_forall ?_)
  intro y
  simp only [shift, show x-y-b=x-(a+b)-(y-a) by ring]

theorem conv_mirror (a b : ℝ) (f g : ℝ → ℝ) (x : ℝ) :
    conv (mirror a f) (mirror b g) x = conv f g (a+b-x) := by
  change (∫ y, f (a-y) * g (b-(x-y))) = ∫ y, f y * g (a+b-x-y)
  rw [← integral_sub_left_eq_self (fun y => f y * g (a+b-x-y)) volume a]
  congr 1
  ext y
  rw [show b-(x-y)=a+b-x-(a-y) by ring]

theorem autocorr_shift (a : ℝ) (f : ℝ → ℝ) (x : ℝ) :
    conv (shift a f) (rev (shift a f)) x = conv f (rev f) x := by
  have he : rev (shift a f) = shift (-a) (rev f) := by
    ext y
    simp [shift, rev, sub_eq_add_neg, add_comm]
  rw [he, conv_shift, add_neg_cancel, sub_zero]

theorem autocorr_even (f : ℝ → ℝ) (x : ℝ) :
    conv f (rev f) (-x) = conv f (rev f) x := by
  change (∫ y, f y * f (-(-x-y))) = ∫ y, f y * f (-(x-y))
  rw [← integral_add_right_eq_self (fun y => f y * f (-(x-y))) x]
  apply integral_congr_ae (Filter.Eventually.of_forall ?_)
  intro y
  rw [show -(-x-y)=y+x by ring, show -(x-(y+x))=y by ring, mul_comm]

theorem autocorr_mirror (a : ℝ) (f : ℝ → ℝ) (x : ℝ) :
    conv (mirror a f) (rev (mirror a f)) x = conv f (rev f) x := by
  have he : rev (mirror a f) = mirror (-a) (rev f) := by
    ext y
    simp [mirror, rev, sub_eq_add_neg, add_comm]
  rw [he, conv_mirror, add_neg_cancel, zero_sub, autocorr_even]

lemma shift_support {f : ℝ → ℝ} {l r : ℝ} (a : ℝ)
    (hs : Function.support f ⊆ Icc l r) :
    Function.support (shift a f) ⊆ Icc (l+a) (r+a) := by
  intro x hx
  obtain ⟨h,h'⟩ := hs (show (x-a) ∈ Function.support f from hx)
  exact ⟨by linarith, by linarith⟩

lemma mirror_support {f : ℝ → ℝ} {l r : ℝ} (a : ℝ)
    (hs : Function.support f ⊆ Icc l r) :
    Function.support (mirror a f) ⊆ Icc (a-r) (a-l) := by
  intro x hx
  obtain ⟨h,h'⟩ := hs (show (a-x) ∈ Function.support f from hx)
  exact ⟨by linarith, by linarith⟩

/-- Centre the input atoms by translation. The common centre of their
covering interval is the sum of the two translation parameters. -/
def Witness.centerWindow {v α β} (W : Witness v α β) (i : Fin W.n) := shift (-v/2) (W.w i)
def Witness.centerTable {v α β} (W : Witness v α β) (i : Fin W.n) :=
  shift (-(W.σ-v)/2) (W.t i)

theorem Witness.center_cover {v α β} (W : Witness v α β) (x : ℝ)
    (hx : x ∈ Ioo (-W.σ/2) (W.σ/2)) :
    1 ≤ expectation W.p (fun i => conv (W.centerWindow i) (W.centerTable i) x) := by
  simp only [centerWindow, centerTable, conv_shift]
  exact W.covering _ ⟨by linarith [hx.1], by linarith [hx.2]⟩

theorem Witness.center_window_support {v α β} (W : Witness v α β) (i : Fin W.n) :
    Function.support (W.centerWindow i) ⊆ Icc (-v/2) (v/2) := by
  unfold centerWindow
  convert shift_support (-v/2) (W.window_support i) using 2 <;> ring

theorem Witness.center_table_support {v α β} (W : Witness v α β) (i : Fin W.n) :
    Function.support (W.centerTable i) ⊆ Icc (-W.σ/2-v/2) (W.σ/2+v/2) := by
  unfold centerTable
  convert shift_support (-(W.σ-v)/2) (W.table_support i) using 2 <;> ring

theorem Witness.center_plateau {v α β} (W : Witness v α β) (i : Fin W.n) {x : ℝ}
    (hx : |x| < W.σ/2-v/2) : W.centerTable i x = 1 := by
  obtain ⟨h,h'⟩ := abs_lt.mp hx
  exact W.plateau i _ ⟨by linarith, by linarith⟩

/-- Assemble a single pair from centred data. Evenness, exact cover and sign
of the autocorrelation are assumptions on pointwise representatives. -/
theorem ofCentered {v D α β : ℝ} {w t : ℝ → ℝ}
    (hv : 0 < v) (hD : v ≤ D) (ha : 0 < α) (hb : 0 < β)
    (hw : Regular w) (ht : Regular t)
    (ws : Function.support w ⊆ Icc (-v/2) (v/2))
    (ts : Function.support t ⊆ Icc (-D-v/2) (D+v/2))
    (tp : ∀ x, |x| < D-v/2 → t x = 1)
    (wm : ∫ x, w x = 1) (wc : energy w ≤ β) (tc : energy t ≤ 2*D+α)
    (we : ∀ x, w (-x) = w x) (te : ∀ x, t (-x) = t x)
    (ac : ∀ x, 0 ≤ conv w w x) (cov : ∀ x, |x| < D → 1 ≤ conv w t x) :
    ∃ W : Witness v α β, W.Deterministic ∧ W.Symmetric := by
  let W : Witness v α β := {
    n := 1, σ := 2*D, p := fun _ => 1,
    w := fun _ => shift (v/2) w, t := fun _ => shift (D-v/2) t
    width_pos := hv, width_le := by linarith, alpha_pos := ha, beta_pos := hb
    weight_nonneg := by simp, total_weight := by simp
    window_regular := fun _ => hw.shift _, table_regular := fun _ => ht.shift _
    window_support := fun _ => by convert shift_support (v/2) ws using 2 <;> ring
    table_support := fun _ => by convert shift_support (D-v/2) ts using 2 <;> ring
    plateau := fun _ x h => tp _ (abs_lt.mpr ⟨by linarith [h.1],by linarith [h.2]⟩)
    mass := fun _ => (integral_sub_right_eq_self w _).trans wm
    window_cost := by simpa [expectation, energy_shift] using wc
    table_cost := by simpa [expectation, energy_shift] using tc
    autocorrelation := fun x => by
      simpa [expectation, autocorr_shift, show rev w = w from funext we] using ac x
    covering := fun x h => by
      simp only [expectation, Fin.sum_univ_one, one_mul, conv_shift]
      apply cov
      exact abs_lt.mpr ⟨by linarith [h.1], by linarith [h.2]⟩ }
  refine ⟨W, rfl, ?_⟩
  intro i x
  change w (v-x-v/2) = w (x-v/2) ∧ t (2*D-v-x-(D-v/2)) = t (x-(D-v/2))
  rw [show v-x-v/2= -(x-v/2) by ring, show 2*D-v-x-(D-v/2)= -(x-(D-v/2)) by ring,
    we, te]
  trivial

end
end MathLab.WT
