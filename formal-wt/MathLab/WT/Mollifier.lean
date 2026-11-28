module
public import MathLab.WT.Spectral
public import Mathlib.Analysis.Calculus.BumpFunction.Normed
import Mathlib.Tactic.Linarith

/-! Unit-mass even Schwartz mollifiers of any prescribed positive radius and
the exact inner coverage of one and two convolutions. -/
@[expose] public section
namespace MathLab.WT

open MeasureTheory Set Filter
open Spectral
open scoped SchwartzMap
noncomputable section

structure Mollifier (δ : ℝ) where
  φ : RealSchwartz
  nonneg : ∀ x, 0 ≤ φ x
  mass : ∫ x, φ x = 1
  even : ∀ x, φ (-x) = φ x
  outside : ∀ x, δ ≤ |x| → φ x = 0

theorem mollifier_exists {δ : ℝ} (hδ : 0 < δ) : Nonempty (Mollifier δ) := by
  let b : ContDiffBump (0:ℝ) := ⟨δ/2,δ,by linarith,by linarith⟩
  let φ := (b.hasCompactSupport_normed (μ:=volume)).toSchwartzMap b.contDiff_normed
  refine ⟨⟨φ,b.nonneg_normed,b.integral_normed,b.normed_neg,?_⟩⟩
  intro x hx
  change b.normed volume x = 0
  by_contra h
  have hm : x ∈ Function.support (b.normed volume) := h
  rw [b.support_normed_eq, Metric.mem_ball, dist_zero_right, Real.norm_eq_abs] at hm
  exact (not_lt_of_ge hx) hm

theorem Mollifier.cover_once {δ L : ℝ} (M : Mollifier δ) {t : ℝ → ℝ}
    (ht : Integrable t) (h : ∀ x, |x| < L → 1 ≤ t x) (x : ℝ) (hx : |x| < L-δ) :
    1 ≤ conv M.φ t x := by
  have hi : Integrable (fun y => M.φ y * t (x-y)) :=
    (ht.comp_sub_left x).bdd_mul M.φ.continuous.aestronglyMeasurable
      (Eventually.of_forall (SchwartzMap.norm_le_seminorm ℝ M.φ))
  rw [← M.mass]
  apply integral_mono M.φ.integrable hi
  intro y
  change M.φ y ≤ M.φ y * t (x-y)
  by_cases hy : |y| ≤ δ
  · have hz : |x-y| < L := (abs_sub x y).trans_lt (by linarith)
    exact le_mul_of_one_le_right (M.nonneg _) (h _ hz)
  · simp [M.outside y (lt_of_not_ge hy).le]

theorem Mollifier.cover_twice {δ L : ℝ} (M : Mollifier δ) {t : ℝ → ℝ}
    (ht : Integrable t) (h : ∀ x, |x| < L → 1 ≤ t x) (x : ℝ) (hx : |x| < L-2*δ) :
    1 ≤ conv M.φ (conv M.φ t) x :=
  M.cover_once (M.φ.integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) ht)
    (M.cover_once ht h) x (by linarith)

end
end MathLab.WT
