module
public import Mathlib.Topology.Algebra.Order.Field
public import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FunProp

/-! A single sequence of physical widths controls both the global window
error and the two table repairs, including their support-length factors. -/
@[expose] public section
namespace MathLab.WT.ErrorRates

open Filter Topology
noncomputable section

def radius (n : ℝ) := n^2
def halfLength (n : ℝ) := 50*radius n
def windowError (C n : ℝ) := C/n^3
def clipError (B Q n : ℝ) := ((B+1)/(radius n/8)^2)*Q
def deficit (C B Z K Q n : ℝ) := Z * clipError B Q n + windowError C n * K
def patch (C B Z K Q n : ℝ) := deficit C B Z K Q n * Z

def tableError (C B Z K Q n : ℝ) :=
  2*halfLength n*(2*clipError B Q n) +
    2*(halfLength n+5*radius n)*
      (2*(max 1 K)*patch C B Z K Q n + (patch C B Z K Q n)^2)

theorem radius_atTop : Tendsto radius atTop atTop :=
  tendsto_pow_atTop (by decide : 2 ≠ 0)

theorem halfLength_atTop : Tendsto halfLength atTop atTop :=
  radius_atTop.const_mul_atTop (by norm_num : 0 < (50:ℝ))

theorem eighth_radius_atTop : Tendsto (fun n => radius n/8) atTop atTop := by
  simpa only [div_eq_mul_inv] using
    radius_atTop.atTop_mul_const (by norm_num : 0 < (8:ℝ)⁻¹)

theorem windowError_zero (C : ℝ) : Tendsto (windowError C) atTop (𝓝 0) :=
  (tendsto_pow_atTop (α:=ℝ) (by decide : 3 ≠ 0)).const_div_atTop C

theorem clipError_zero (B Q : ℝ) : Tendsto (clipError B Q) atTop (𝓝 0) := by
  change Tendsto (fun n : ℝ => ((B+1)/(radius n/8)^2)*Q) atTop (𝓝 0)
  let h := (tendsto_pow_atTop (α:=ℝ) (by decide : 2 ≠ 0)).comp eighth_radius_atTop
  simpa [clipError] using (h.const_div_atTop (B+1)).mul_const Q

theorem deficit_zero (C B Z K Q : ℝ) : Tendsto (deficit C B Z K Q) atTop (𝓝 0) := by
  change Tendsto (fun n : ℝ => Z*clipError B Q n+windowError C n*K) atTop (𝓝 0)
  simpa [deficit] using ((clipError_zero B Q).const_mul Z).add ((windowError_zero C).mul_const K)

theorem patch_zero (C B Z K Q : ℝ) : Tendsto (patch C B Z K Q) atTop (𝓝 0) := by
  change Tendsto (fun n : ℝ => deficit C B Z K Q n*Z) atTop (𝓝 0)
  simpa [patch] using (deficit_zero C B Z K Q).mul_const Z

theorem tableError_zero (C B Z K Q : ℝ) : Tendsto (tableError C B Z K Q) atTop (𝓝 0) := by
  let a := 64*(B+1)*Q
  let b := fun u : ℝ => Z * (C*K + Z*a*u)
  let polynomial := fun u : ℝ => 200*a*u^2 + 110*(2*(max 1 K)*b u*u + (b u)^2*u^4)
  have cont : Continuous polynomial := by dsimp [polynomial,b,a]; fun_prop
  have h0 : polynomial 0 = 0 := by simp [polynomial]
  have h := (cont.continuousAt.tendsto (x:=0)).comp (tendsto_inv_atTop_zero (𝕜:=ℝ))
  rw [h0] at h
  apply h.congr'
  filter_upwards [eventually_gt_atTop (0:ℝ)] with n hn
  dsimp [Function.comp_def,polynomial,b,a,tableError,halfLength,radius,clipError,patch,
    deficit,windowError]
  field_simp [hn.ne']
  ring

theorem eventually_joint (C B Z K Q N S H ε : ℝ) (hε : 0 < ε) :
    ∀ᶠ n : ℝ in atTop, N < n ∧ S < halfLength n ∧ H < radius n/8 ∧
      windowError C n < ε ∧ tableError C B Z K Q n < ε := by
  filter_upwards [eventually_gt_atTop N, halfLength_atTop.eventually_gt_atTop S,
    eighth_radius_atTop.eventually_gt_atTop H, (windowError_zero C).eventually_lt_const hε,
    (tableError_zero C B Z K Q).eventually_lt_const hε] with n hn hs hh hw ht
  exact ⟨hn,hs,hh,hw,ht⟩

end
end MathLab.WT.ErrorRates
