module
public import MathLab.WT.Coordinates
public import MathLab.WT.Extension
public import Mathlib.Analysis.Convolution
import Mathlib.MeasureTheory.Measure.Haar.Unique
import Mathlib.Tactic.Linarith

/-! Pointwise convolution error estimates and reflection of a signed table.
Integrability and bounds refer to the individual functions on ℝ. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set Filter
noncomputable section

def massAbs (f : ℝ → ℝ) := ∫ x, |f x|

lemma massAbs_nonneg (f : ℝ → ℝ) : 0 ≤ massAbs f := integral_nonneg fun _ => abs_nonneg _

theorem Regular.add {f g : ℝ → ℝ} (h : Regular f) (h' : Regular g) :
    Regular (fun x => f x + g x) := by
  obtain ⟨hi,A,hA⟩ := h
  obtain ⟨hi',B,hB⟩ := h'
  exact ⟨hi.add hi', A+B, fun x => (abs_add_le _ _).trans (add_le_add (hA x) (hB x))⟩

theorem Regular.smul {f : ℝ → ℝ} (h : Regular f) (c : ℝ) : Regular (fun x => c * f x) := by
  obtain ⟨hi,A,hA⟩ := h
  refine ⟨hi.const_mul c, |c| * A, fun x => ?_⟩
  rw [abs_mul]
  exact mul_le_mul_of_nonneg_left (hA x) (abs_nonneg c)

lemma conv_integrand_mem {f g : ℝ → ℝ} (hf : Integrable f) (hg : Regular g) (x : ℝ) :
    Integrable (fun y => f y * g (x-y)) :=
  hf.mul_bdd (hg.1.comp_sub_left x).aestronglyMeasurable
    (Eventually.of_forall fun y => (show ‖g (x-y)‖ ≤ hg.2.choose from hg.2.choose_spec _))

theorem conv_abs_bound {f g : ℝ → ℝ} (hf : Integrable f) {B : ℝ}
    (hb : ∀ y, |g y| ≤ B) (x : ℝ) : |conv f g x| ≤ massAbs f * B := by
  calc
    _ ≤ ∫ y, |f y * g (x-y)| := abs_integral_le_integral_abs
    _ ≤ ∫ y, |f y| * B := by
      apply integral_mono_of_nonneg (Eventually.of_forall fun _ => abs_nonneg _) (hf.abs.mul_const B)
      exact Eventually.of_forall fun y => (abs_mul _ _).le.trans
        (mul_le_mul_of_nonneg_left (hb (x-y)) (abs_nonneg _))
    _ = _ := integral_mul_const B _

theorem conv_perturbation {f F g G : ℝ → ℝ} (hf : Integrable f) (hF : Integrable F)
    (hg : Regular g) (hG : Regular G) {B e : ℝ}
    (hB : ∀ y, |g y| ≤ B) (he : ∀ y, |G y - g y| ≤ e) (x : ℝ) :
    |conv F G x - conv f g x| ≤ massAbs F * e + massAbs (fun y => F y-f y) * B := by
  have eq : conv F G x-conv f g x =
      conv F (fun y => G y-g y) x + conv (fun y => F y-f y) g x := by
    unfold conv
    simp_rw [mul_sub, sub_mul, integral_sub (conv_integrand_mem hF hG x) (conv_integrand_mem hF hg x),
      integral_sub (conv_integrand_mem hF hg x) (conv_integrand_mem hf hg x)]
    ring
  rw [eq]
  exact (abs_add_le _ _).trans (add_le_add (conv_abs_bound hF he x) (conv_abs_bound (hF.sub hf) hB x))

theorem massAbs_by_difference {f g : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g) :
    massAbs f ≤ massAbs g + massAbs (fun x => f x-g x) := by
  unfold massAbs
  have hi : Integrable (fun x => |f x-g x|) := (hf.sub hg).abs
  rw [← integral_add hg.abs hi]
  apply integral_mono hf.abs (hg.abs.add hi)
  intro x
  simpa [Pi.sub_apply] using abs_add_le (g x) (f x-g x)

def evenPart (t : ℝ → ℝ) (x : ℝ) := (t x + t (-x))/2

theorem evenPart_regular {t : ℝ → ℝ} (ht : Regular t) : Regular (evenPart t) := by
  have hrev : Regular (rev t) := ⟨ht.1.comp_neg, ht.2.imp fun _ b x => b (-x)⟩
  have he : evenPart t = fun y => (1/2 : ℝ) * (t y+rev t y) := by
    funext y; unfold evenPart rev; ring
  rw [he]
  exact (ht.add hrev).smul _

theorem evenPart_even (t : ℝ → ℝ) (x : ℝ) : evenPart t (-x) = evenPart t x := by
  simp [evenPart, add_comm]

theorem energy_evenPart {t : ℝ → ℝ} (ht : Regular t) : energy (evenPart t) ≤ energy t := by
  have ht2 := ht.integrable_square
  have hr : Integrable (fun x => (t (-x))^2) := ht2.comp_neg
  have h (x : ℝ) : evenPart t x ^ 2 ≤ (1/2 : ℝ)*(t x^2+(t (-x))^2) := by
    unfold evenPart
    nlinarith [sq_nonneg (t x-t (-x))]
  have hi := integral_mono (evenPart_regular ht).integrable_square ((ht2.add hr).const_mul (1/2)) h
  have he : (∫ x, t (-x)^2) = ∫ x, t x^2 := integral_neg_eq_self (fun x => t x^2) volume
  simp only [integral_const_mul, Pi.add_apply, integral_add ht2 hr, he] at hi
  unfold energy
  linarith

theorem conv_evenPart {w t : ℝ → ℝ} (hw : Integrable w) (he : ∀ x, w (-x)=w x) (ht : Regular t)
    (x : ℝ) : conv w (evenPart t) x = (conv w t x+conv w t (-x))/2 := by
  have hwm : mirror 0 w = w := funext fun y => by simp [mirror, he]
  have htm : mirror 0 t = rev t := funext fun y => by simp [mirror, rev]
  have hm : conv w (rev t) x = conv w t (-x) := by
    simpa only [hwm, htm, add_zero, zero_sub] using conv_mirror 0 0 w t x
  have hrev : Regular (rev t) := ⟨ht.1.comp_neg, ht.2.imp fun _ b y => b (-y)⟩
  rw [← hm]
  unfold conv
  change (∫ y, w y * ((t (x-y) + rev t (x-y))/2)) = _
  simp_rw [← mul_div_assoc, mul_add, integral_div, integral_add (conv_integrand_mem hw ht x)
    (conv_integrand_mem hw hrev x)]

end
end MathLab.WT
