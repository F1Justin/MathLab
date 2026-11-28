import MathLab.WT.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Set
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

namespace MathLab.WT.Cells
open Set MeasureTheory
noncomputable section

/-- The unit cell with half of its trace at each endpoint. -/
def cell (a x : ℝ) : ℝ :=
  if x = a ∨ x = a + 1 then 1 / 2 else if a < x ∧ x < a + 1 then 1 else 0

theorem cell_refl (a x : ℝ) : cell a (2*a + 1 - x) = cell a x := by
  unfold cell
  split_ifs <;> first | rfl | grind

theorem cell_bounds (a x : ℝ) : 0 ≤ cell a x ∧ cell a x ≤ 1 := by
  unfold cell
  split_ifs <;> norm_num

private def closed (a b : ℝ) : ℝ → ℝ := (Icc a b).indicator (fun _ => 1)

private theorem closed_int (a b : ℝ) : Integrable (closed a b) := by
  rw [closed, integrable_indicator_iff measurableSet_Icc]
  exact integrableOn_const isCompact_Icc.measure_ne_top

private theorem closed_mass (a b : ℝ) :
    (∫ x, closed a b x) = max (b - a) 0 := by
  simp [closed, integral_indicator_const, Measure.real, Real.volume_Icc,
    ENNReal.toReal_ofReal']

private theorem cell_agrees (a x : ℝ) (ha : x ≠ a) (hb : x ≠ a+1) :
    cell a x = closed a (a+1) x := by
  simp only [closed, indicator_apply, cell]
  split_ifs <;> first | rfl | grind

private theorem cell_ae (a : ℝ) : cell a =ᵐ[volume] closed a (a+1) := by
  filter_upwards [volume.ae_ne a, volume.ae_ne (a+1)] with x hx hy
  exact cell_agrees a x hx hy

theorem cell_integrable (a : ℝ) : Integrable (cell a) :=
  (closed_int _ _).congr (cell_ae a).symm

theorem cell_mass (a : ℝ) : (∫ x, cell a x) = 1 := by
  rw [integral_congr_ae (cell_ae a), closed_mass]
  simp

private theorem box_pair_ae (a b z : ℝ) :
    (fun x => cell a x * cell b (z-x)) =ᵐ[volume]
      closed (max a (z-b-1)) (min (a+1) (z-b)) := by
  filter_upwards [volume.ae_ne a, volume.ae_ne (a+1),
    volume.ae_ne (z-b), volume.ae_ne (z-b-1)] with y h₁ h₂ h₃ h₄
  rw [cell_agrees a y h₁ h₂, cell_agrees b (z-y) (by grind) (by grind)]
  simp only [closed, indicator_apply, mem_Icc, max_le_iff, le_min_iff]
  split_ifs <;> norm_num <;> grind

theorem box_pair_integrable (a b z : ℝ) :
    Integrable (fun x => cell a x * cell b (z-x)) :=
  (closed_int _ _).congr (box_pair_ae a b z).symm

/-- The convolution of two unit cells is the cardinal linear spline. -/
theorem cell_conv (a b z : ℝ) :
    conv (cell a) (cell b) z = max (1 - |z-(a+b+1)|) 0 := by
  unfold conv
  rw [integral_congr_ae (box_pair_ae a b z), closed_mass]
  congr 1
  by_cases h : 0 ≤ z-(a+b+1)
  · rw [abs_of_nonneg h, max_eq_right (by linarith : a ≤ z-b-1),
        min_eq_left (by linarith : a+1 ≤ z-b)]
    ring
  · rw [abs_of_neg (by linarith : z-(a+b+1) < 0),
        max_eq_left (by linarith : z-b-1 ≤ a), min_eq_right (by linarith : z-b ≤ a+1)]
    ring

/-- A finite piecewise constant function, with cells starting at the indicated
integer indices plus an arbitrary common translation. -/
def synth (s : Finset ℤ) (f : ℤ → ℝ) (a x : ℝ) : ℝ :=
  ∑ i ∈ s, f i * cell ((i:ℝ)+a) x

theorem synth_integrable (s : Finset ℤ) (f : ℤ → ℝ) (a : ℝ) :
    Integrable (synth s f a) :=
  integrable_finsetSum _ fun i _ => (cell_integrable _).const_mul (f i)

theorem synth_mass (s : Finset ℤ) (f : ℤ → ℝ) (a : ℝ) :
    (∫ x, synth s f a x) = ∑ i ∈ s, f i := by
  unfold synth
  rw [integral_finsetSum _ (fun i _ => (cell_integrable _).const_mul (f i))]
  simp [integral_const_mul, cell_mass]

theorem synth_regular (s : Finset ℤ) (f : ℤ → ℝ) (a : ℝ) :
    MathLab.WT.Regular (synth s f a) := by
  refine ⟨synth_integrable .., ∑ i ∈ s, |f i|, ?_⟩
  intro x
  apply (Finset.abs_sum_le_sum_abs _ _).trans
  apply Finset.sum_le_sum
  intro i hi
  rw [abs_mul, abs_of_nonneg (cell_bounds _ _).1]
  exact mul_le_of_le_one_right (abs_nonneg _) (cell_bounds _ _).2

private theorem weighted_pair (u v a b z : ℝ) :
    Integrable (fun x => u * cell a x * (v * cell b (z-x))) := by
  have h := (box_pair_integrable a b z).const_mul (u*v)
  convert h using 1
  funext x
  ring

theorem synth_conv (s t : Finset ℤ) (f g : ℤ → ℝ) (a b z : ℝ) :
    conv (synth s f a) (synth t g b) z =
      ∑ i ∈ s, ∑ j ∈ t, f i * g j * max (1 - |z-((i:ℝ)+(j:ℝ)+a+b+1)|) 0 := by
  unfold conv synth
  simp_rw [Finset.sum_mul, Finset.mul_sum]
  rw [integral_finsetSum]
  · apply Finset.sum_congr rfl
    intro i hi
    rw [integral_finsetSum _ (fun j _ => weighted_pair ..)]
    apply Finset.sum_congr rfl
    intro j hj
    calc
      _ = ∫ x, (f i * g j) * (cell ((i:ℝ)+a) x * cell ((j:ℝ)+b) (z-x)) := by
            congr 1
            funext x
            ring
      _ = f i * g j * conv (cell ((i:ℝ)+a)) (cell ((j:ℝ)+b)) z := integral_const_mul ..
      _ = _ := by rw [cell_conv]; ring_nf
  · intro i hi
    exact integrable_finsetSum _ fun j _ => weighted_pair ..

/-- The integer node of the ordinary convolution of two finite arrays. -/
def node (s t : Finset ℤ) (f g : ℤ → ℝ) (k : ℤ) : ℝ :=
  ∑ i ∈ s, ∑ j ∈ t, if i+j=k then f i*g j else 0

private theorem hat_lerp (k j : ℤ) (u : ℝ) (h₀ : 0 ≤ u) (h₁ : u ≤ 1) :
    max (1 - |(k:ℝ)+u-j|) 0 =
    (if j=k then 1-u else 0) + (if j=k+1 then u else 0) := by
  rcases lt_trichotomy j k with h | rfl | h
  · have hh : j ≤ k-1 := by omega
    have hr : (j:ℝ) ≤ (k:ℝ)-1 := by exact_mod_cast hh
    simp only [ite_eq_right (by omega : j ≠ k), ite_eq_right (by omega : j ≠ k+1), zero_add,
      abs_of_nonneg (by linarith : 0 ≤ (k:ℝ)+u-j), max_eq_right (by linarith : 1-((k:ℝ)+u-j) ≤ 0)]
  · simp [abs_of_nonneg h₀, max_eq_left (by linarith : 0 ≤ 1-u), add_sub_cancel_left]
  · by_cases hj : j=k+1
    · subst j
      simp only [Int.cast_add, Int.cast_one, ite_true, ite_eq_right (by omega : k+1≠k),
        zero_add, abs_of_nonpos (by linarith : (k:ℝ)+u-((k:ℝ)+1) ≤ 0)]
      rw [max_eq_left (by linarith)]
      ring
    · have hh : k+2 ≤ j := by omega
      have hr : (k:ℝ)+2 ≤ j := by exact_mod_cast hh
      simp only [ite_eq_right (by omega : j≠k), ite_eq_right hj, zero_add,
        abs_of_nonpos (by linarith : (k:ℝ)+u-j ≤ 0),
        max_eq_right (by linarith : 1-(-((k:ℝ)+u-j)) ≤ 0)]

theorem synth_conv_lerp (s t : Finset ℤ) (f g : ℤ → ℝ) (a b : ℝ)
    (k : ℤ) (u : ℝ) (h₀ : 0 ≤ u) (h₁ : u ≤ 1) :
    conv (synth s f a) (synth t g b) ((k:ℝ)+u+a+b+1) =
      (1-u) * node s t f g k + u * node s t f g (k+1) := by
  rw [synth_conv]
  unfold node
  simp_rw [Finset.mul_sum]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro j hj
  rw [show (k:ℝ)+u+a+b+1-((i:ℝ)+(j:ℝ)+a+b+1) =
      (k:ℝ)+u-((i+j:ℤ):ℝ) by push_cast; ring, hat_lerp k (i+j) u h₀ h₁]
  split_ifs <;> ring

theorem node_eq (s t : Finset ℤ) (f g : ℤ → ℝ) (k : ℤ) :
    node s t f g k = ∑ i ∈ s, if k-i ∈ t then f i*g (k-i) else 0 := by
  unfold node
  apply Finset.sum_congr rfl
  intro i hi
  simp_rw [show ∀ j : ℤ, (i+j=k) ↔ j=k-i by intro j; omega]
  simp

theorem reflect_cell (a x : ℝ) : cell a (-x) = cell (-a-1) x := by
  unfold cell
  split_ifs <;> first | rfl | grind

theorem rev_synth (s : Finset ℤ) (f : ℤ → ℝ) (a : ℝ) :
    rev (synth s f a) =
      synth (s.image (fun j => -j)) (fun j => f (-j)) (-a-1) := by
  funext x
  unfold rev synth
  rw [Finset.sum_image (by intro i _ j _ h; simpa using h)]
  apply Finset.sum_congr rfl
  intro i hi
  simp only [neg_neg, Int.cast_neg, reflect_cell]
  congr 2
  ring

theorem synth_energy (s : Finset ℤ) (f : ℤ → ℝ) (a : ℝ) :
    energy (synth s f a) = ∑ i ∈ s, (f i)^2 := by
  have eq : energy (synth s f a) = conv (synth s f a) (rev (synth s f a)) 0 := by
    simp [energy, conv, rev, sq]
  rw [eq, rev_synth]
  have h := synth_conv_lerp s (s.image (fun j => -j)) f (fun j => f (-j))
    a (-a-1) 0 0 le_rfl zero_le_one
  simp only [Int.cast_zero, zero_add, sub_zero, one_mul, zero_mul, add_zero] at h
  rw [show a+(-a-1)+1=0 by ring] at h
  rw [h, node_eq]
  apply Finset.sum_congr rfl
  intro i hi
  have hm : -i ∈ s.image (fun j => -j) := Finset.mem_image.mpr ⟨i, hi, rfl⟩
  simp [hm, sq]

def read (s : Finset ℤ) (f : ℤ → ℝ) (i : ℤ) : ℝ :=
  if i ∈ s then f i else 0

private theorem cell_at (j k : ℤ) (a u : ℝ) (h₀ : 0 ≤ u) (h₁ : u < 1) :
    cell ((j:ℝ)+a) ((k:ℝ)+u+a) =
      (if j=k then (if u=0 then 1/2 else 1) else 0) +
      (if j=k-1 ∧ u=0 then 1/2 else 0) := by
  by_cases e : j=k
  · subst j
    by_cases hu : u=0 <;> unfold cell <;> split_ifs <;> norm_num <;> grind
  by_cases e' : j=k-1
  · have hr : (j:ℝ)=(k:ℝ)-1 := by exact_mod_cast e'
    by_cases hu : u=0 <;> unfold cell <;> split_ifs <;> norm_num <;> grind
  have h : j ≤ k-2 ∨ k+1 ≤ j := by omega
  rcases h with h | h
  · have hr : (j:ℝ) ≤ (k:ℝ)-2 := by exact_mod_cast h
    unfold cell
    split_ifs <;> norm_num <;> grind
  · have hr : (k:ℝ)+1 ≤ j := by exact_mod_cast h
    unfold cell
    split_ifs <;> norm_num <;> grind

/-- The value on the open cell and the mean of the traces at its left endpoint. -/
theorem synth_at (s : Finset ℤ) (f : ℤ → ℝ) (k : ℤ) (a u : ℝ)
    (h₀ : 0 ≤ u) (h₁ : u < 1) :
    synth s f a ((k:ℝ)+u+a) =
      if u=0 then (read s f k + read s f (k-1))/2 else read s f k := by
  unfold synth read
  simp_rw [cell_at _ k a u h₀ h₁, mul_add, Finset.sum_add_distrib]
  by_cases h : u=0
  · simp [h, mul_ite]
    split_ifs <;> ring
  · simp [h, mul_ite]

end
end MathLab.WT.Cells
