module
public import Mathlib.Algebra.MonoidAlgebra.Basic
public import Mathlib.Algebra.Order.BigOperators.Group.Finset
public import Mathlib.Basic.Real.Basic
public import Mathlib.Data.Finsupp.Indicator
import Mathlib.Tactic.Linarith

/-!
# Exact covering repair for a signed finite window

The coefficient of a product in `AddMonoidAlgebra ℝ ℤ` is the usual discrete
convolution on the whole integer line. For a mass-one window `w`, adding
`d • (reverse w * band I)` to the table adds `d` to its covering wherever
`I` contains the translate of the entire autocorrelation support. A nonnegative
autocorrelation makes this change nonnegative at every other integer. Neither
the window nor the original table needs to have nonnegative coefficients.
-/

@[expose] public section
namespace MathLab.WT.Grid

noncomputable section

abbrev Signal := AddMonoidAlgebra ℝ ℤ

/-- Evaluation of the Laurent polynomial at one, i.e. total mass. -/
def mass : Signal →ₐ[ℝ] ℝ := AddMonoidAlgebra.lift ℝ ℝ ℤ 1

lemma mass_eq_sum (f : Signal) : mass f = ∑ k ∈ f.coeff.support, f.coeff k := by
  simp [mass, AddMonoidAlgebra.lift_apply', Finsupp.sum]

def reverse (w : Signal) : Signal :=
  .ofCoeff (w.coeff.equivMapDomain (Equiv.neg ℤ))

@[simp] lemma reverse_coeff (w : Signal) (k : ℤ) : (reverse w).coeff k = w.coeff (-k) := rfl

@[simp] lemma mass_reverse (w : Signal) : mass (reverse w) = mass w := by
  rw [mass_eq_sum, mass_eq_sum]
  change ∑ k ∈ w.coeff.support.map (Equiv.neg ℤ).toEmbedding, w.coeff (-k) = _
  simp

/-- The unit-height indicator of a finite set of shifts. -/
def band (I : Finset ℤ) : Signal := .ofCoeff (Finsupp.indicator I fun _ _ ↦ (1 : ℝ))

@[simp] lemma band_coeff (I : Finset ℤ) (k : ℤ) :
    (band I).coeff k = if k ∈ I then 1 else 0 := by
  simp [band, AddMonoidAlgebra.coeff_ofCoeff, Finsupp.indicator_apply]

lemma conv_band_nonneg {a : Signal} (ha : ∀ k, 0 ≤ a.coeff k) (I : Finset ℤ) (x : ℤ) :
    0 ≤ (a * band I).coeff x := by
  rw [AddMonoidAlgebra.coeff_mul_apply_left, Finsupp.sum]
  apply Finset.sum_nonneg
  intro k _
  apply mul_nonneg (ha k)
  simp only [band_coeff]
  split <;> norm_num

lemma conv_band_full (a : Signal) (I : Finset ℤ) (x : ℤ)
    (hI : ∀ k ∈ a.coeff.support, x - k ∈ I) : (a * band I).coeff x = mass a := by
  rw [AddMonoidAlgebra.coeff_mul_apply_left, Finsupp.sum, mass_eq_sum]
  apply Finset.sum_congr rfl
  intro k hk
  have hs : -k + x ∈ I := by simpa only [sub_eq_neg_add] using hI k hk
  simp [hs]

/-- The correction improves the covering everywhere and covers the target
exactly up to the prescribed lower bound, including deficient target points. -/
theorem repair_cover (w t : Signal) (I : Finset ℤ) (target : Set ℤ) (d : ℝ)
    (hmass : mass w = 1) (hd : 0 ≤ d)
    (ha : ∀ k, 0 ≤ (w * reverse w).coeff k)
    (hdef : ∀ x ∈ target, 1 - (w * t).coeff x ≤ d)
    (hband : ∀ x ∈ target, (w * t).coeff x < 1 →
      ∀ k ∈ (w * reverse w).coeff.support, x - k ∈ I) :
    (∀ x, (w * t).coeff x ≤ (w * (t + d • (reverse w * band I))).coeff x) ∧
      ∀ x ∈ target, 1 ≤ (w * (t + d • (reverse w * band I))).coeff x := by
  have expand (x : ℤ) : (w * (t + d • (reverse w * band I))).coeff x =
      (w * t).coeff x + d * ((w * reverse w) * band I).coeff x := by
    simp [mul_add, ← mul_assoc, AddMonoidAlgebra.coeff_add]
  have rises (x : ℤ) : (w * t).coeff x ≤ (w * (t + d • (reverse w * band I))).coeff x := by
    rw [expand]
    exact le_add_of_nonneg_right (mul_nonneg hd (conv_band_nonneg ha I x))
  refine ⟨rises, ?_⟩
  intro x hx
  by_cases already : 1 ≤ (w * t).coeff x
  · exact already.trans (rises x)
  · rw [expand, conv_band_full _ _ _ (hband x hx (lt_of_not_ge already)),
      map_mul, mass_reverse, hmass]
    linarith [hdef x hx]

end

end MathLab.WT.Grid
