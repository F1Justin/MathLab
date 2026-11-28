module
public import MathLab.WT.ConvolutionBounds
public import MathLab.WT.ContinuousRepair
import Mathlib.Tactic.Ring

/-! L¹ bounds for real convolution and perturbation of its square. -/
@[expose] public section
namespace MathLab.WT

open MeasureTheory Filter
noncomputable section

theorem massAbs_sub_triangle {f g h : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g)
    (hh : Integrable h) : massAbs (fun x => f x-h x) ≤
      massAbs (fun x => f x-g x)+massAbs (fun x => g x-h x) := by
  unfold massAbs
  rw [← integral_add (f:=fun x => |f x-g x|) (g:=fun x => |g x-h x|)
    (hf.sub hg).abs (hg.sub hh).abs]
  apply integral_mono (hf.sub hh).abs ((hf.sub hg).abs.add (hg.sub hh).abs)
  intro x
  change |f x-h x| ≤ |f x-g x|+|g x-h x|
  exact abs_sub_le _ _ _

theorem massAbs_add_le {f g : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g) :
    massAbs (fun x => f x+g x) ≤ massAbs f+massAbs g := by
  unfold massAbs
  rw [← integral_add hf.abs hg.abs]
  exact integral_mono (hf.add hg).abs (hf.abs.add hg.abs) (fun x => abs_add_le _ _)

theorem massAbs_conv_le {f g : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g) :
    massAbs (conv f g) ≤ massAbs f * massAbs g := by
  have hi := hf.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hg
  have hb := hf.abs.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hg.abs
  calc
    _ ≤ ∫ x, conv (fun y => |f y|) (fun y => |g y|) x := by
      apply integral_mono hi.abs hb
      intro x
      change |∫ y, f y*g (x-y)| ≤ ∫ y, |f y| * |g (x-y)|
      simpa only [abs_mul] using
        (abs_integral_le_integral_abs (f:=fun y => f y*g (x-y)) (μ:=volume))
    _ = _ := conv_mass hf.abs hg.abs

theorem massAbs_conv_square_difference {V s : ℝ → ℝ} (hV : Regular V) (hs : Regular s)
    {η : ℝ} (hη : massAbs (fun x => V x-s x) ≤ η) :
    massAbs (fun x => conv V V x-conv s s x) ≤ η*(massAbs V+massAbs s) := by
  let f := fun x => V x-s x
  have hf : Integrable f := hV.1.sub hs.1
  have e (x : ℝ) : conv V V x-conv s s x = conv f V x + conv s f x := by
    unfold conv f
    simp only [sub_mul,mul_sub,integral_sub (conv_integrand_mem hV.1 hV x)
      (conv_integrand_mem hs.1 hV x),integral_sub (conv_integrand_mem hs.1 hV x)
      (conv_integrand_mem hs.1 hs x)]
    ring
  simp_rw [e]
  calc
    _ ≤ massAbs (conv f V)+massAbs (conv s f) := massAbs_add_le
      (hf.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hV.1)
      (hs.1.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hf)
    _ ≤ massAbs f*massAbs V+massAbs s*massAbs f :=
      add_le_add (massAbs_conv_le hf hV.1) (massAbs_conv_le hs.1 hf)
    _ = massAbs f*(massAbs V+massAbs s) := by ring
    _ ≤ _ := mul_le_mul_of_nonneg_right hη (add_nonneg (massAbs_nonneg V) (massAbs_nonneg s))

end
end MathLab.WT
