import MathLab.WT.Cells
import MathLab.WT.CertificateArithmetic
import Mathlib.MeasureTheory.Group.Integral
import Mathlib.MeasureTheory.Measure.Haar.Unique

namespace MathLab.WT.ListCells
open Cells Certificate Set MeasureTheory
noncomputable section

def get (l : List ℤ) (j : ℕ) : ℤ := l[j]?.getD 0
def atInt (l : List ℤ) (j : ℤ) : ℤ := if j<0 then 0 else get l j.toNat
@[simp] theorem atInt_nat (l : List ℤ) (k : ℕ) : atInt l k = get l k := by
  simp [atInt, show ¬(k:ℤ)<0 by omega]

def indices (l : List ℤ) : Finset ℤ := (Finset.range l.length).image Int.ofNat
def height (l : List ℤ) (d : ℤ) (j : ℤ) : ℝ := (atInt l j:ℝ) / d
def pos (l : List ℤ) (d : ℤ) (a : ℝ) : ℝ → ℝ := synth (indices l) (height l d) a
def neg (l : List ℤ) (d : ℤ) (a : ℝ) : ℝ → ℝ :=
  synth ((indices l).image (fun j => -j)) (fun j => height l d (-j)) a

theorem mem_indices (l : List ℤ) (j : ℤ) :
    j ∈ indices l ↔ 0 ≤ j ∧ j < (l.length:ℤ) := by
  simp only [indices, Finset.mem_image, Finset.mem_range]
  constructor
  · rintro ⟨k, hk, rfl⟩
    change 0 ≤ (k:ℤ) ∧ (k:ℤ) < (l.length:ℤ)
    omega
  · rintro ⟨h₁, h₂⟩
    exact ⟨j.toNat, by omega, show (j.toNat:ℤ)=j by omega⟩

theorem get_out (l : List ℤ) {j : ℕ} (h : l.length ≤ j) : get l j = 0 := by
  simp [get, List.getElem?_eq_none h]

theorem atInt_out (l : List ℤ) (j : ℤ) (h : j ∉ indices l) : atInt l j = 0 := by
  rw [mem_indices] at h
  unfold atInt
  split
  · rfl
  · exact get_out _ (by omega)

theorem read_height (l : List ℤ) (d j : ℤ) :
    Cells.read (indices l) (height l d) j = height l d j := by
  by_cases h : j ∈ indices l
  · simp [Cells.read,h]
  · simp [Cells.read,h,height,atInt_out l j h]

theorem read_neg (l : List ℤ) (d j : ℤ) :
    Cells.read ((indices l).image (fun j => -j)) (fun i => height l d (-i)) j = height l d (-j) := by
  by_cases h : -j ∈ indices l
  · have h' : j ∈ (indices l).image (fun i => -i) := Finset.mem_image.mpr ⟨-j,h,by simp⟩
    simp [Cells.read,h']
  · have h' : j ∉ (indices l).image (fun i => -i) := by
      rintro h'
      obtain ⟨i,hi,e⟩ := Finset.mem_image.mp h'
      exact h (by simpa [← e] using hi)
    simp [Cells.read,h',height,atInt_out l (-j) h]

theorem get_drop (l : List ℤ) (k i : ℕ) : get (l.drop k) i = get l (k+i) := by
  simp [get, List.getElem?_drop]

theorem dot_sum (u v : List ℤ) :
    dot u v = ∑ j ∈ Finset.range u.length, get u j * get v j := by
  induction u generalizing v with
  | nil => simp [dot]
  | cons a u ih =>
    cases v with
    | nil => simp [dot, get]
    | cons b v =>
      simp only [List.length_cons, Finset.sum_range_succ', dot, ih, get,
        List.getElem?_cons_succ, List.getElem?_cons_zero, Option.getD_some]
      ring

theorem values_sum (l : List ℤ) : l.sum = ∑ j ∈ Finset.range l.length, get l j := by
  induction l with
  | nil => simp
  | cons x xs ih =>
    simp only [List.sum_cons, List.length_cons, Finset.sum_range_succ', get,
      List.getElem?_cons_succ, List.getElem?_cons_zero, Option.getD_some, ih]
    ring

theorem squares_sum (l : List ℤ) :
    ssq l = ∑ j ∈ Finset.range l.length, (get l j)^2 := by
  induction l with
  | nil => simp [ssq]
  | cons x xs ih =>
    change x*x + ssq xs = _
    rw [ih]
    simp only [List.length_cons, Finset.sum_range_succ', get,
      List.getElem?_cons_succ, List.getElem?_cons_zero, Option.getD_some]
    ring

theorem neg_mass (l : List ℤ) (d : ℤ) (a : ℝ) :
    (∫ x, neg l d a x) = (l.sum:ℝ)/d := by
  rw [neg, synth_mass, Finset.sum_image (by intro i _ j _ h; simpa using h)]
  simp only [neg_neg, indices]
  simp [height, atInt_nat, ← Finset.sum_div, values_sum]

theorem pos_energy (l : List ℤ) (d : ℤ) (a : ℝ) :
    energy (pos l d a) = (ssq l:ℝ)/(d:ℝ)^2 := by
  rw [pos, synth_energy]
  simp only [indices]
  simp [height, atInt_nat, div_pow, ← Finset.sum_div, squares_sum]

theorem neg_energy (l : List ℤ) (d : ℤ) (a : ℝ) :
    energy (neg l d a) = (ssq l:ℝ)/(d:ℝ)^2 := by
  rw [neg, synth_energy, Finset.sum_image (by intro i _ j _ h; simpa using h)]
  simp only [neg_neg, indices]
  simp [height, atInt_nat, div_pow, ← Finset.sum_div, squares_sum]

theorem neg_pos_node (u v : List ℤ) (d e : ℤ) (k : ℕ) :
    node ((indices u).image (fun j => -j)) (indices v)
      (fun j => height u d (-j)) (height v e) k =
      (dot u (v.drop k):ℝ) / ((d:ℝ)*e) := by
  rw [node_eq, Finset.sum_image (by intro i _ j _ h; simpa using h)]
  simp only [neg_neg, sub_neg_eq_add]
  have prod (i : ℤ) : (if (k:ℤ)+i ∈ indices v then height u d i*height v e (k+i) else 0) =
      height u d i*height v e (k+i) := by
    by_cases h : (k:ℤ)+i ∈ indices v
    · simp [h]
    · simp [h,height,atInt_out v _ h]
  simp_rw [prod]
  rw [indices, Finset.sum_image (by intro i _ j _ h; exact Int.ofNat_inj.mp h)]
  rw [dot_sum, Int.cast_sum, Finset.sum_div]
  apply Finset.sum_congr rfl
  intro i hi
  have eq : (k:ℤ)+(i:ℤ)=((k+i:ℕ):ℤ) := by exact_mod_cast rfl
  change ((atInt u (i:ℤ):ℝ)/d) * ((atInt v ((k:ℤ)+(i:ℤ)):ℝ)/e) =
    ((get u i * get (v.drop k) i : ℤ):ℝ) / ((d:ℝ)*e)
  rw [eq, atInt_nat, atInt_nat, get_drop, Int.cast_mul, div_mul_div_comm]

theorem rev_neg (l : List ℤ) (d : ℤ) (a : ℝ) : rev (neg l d a) = pos l d (-a-1) := by
  rw [neg, rev_synth]
  simp [pos, Finset.image_image]

theorem cross_lerp (l t : List ℤ) (d e : ℤ) (a b : ℝ)
    (k : ℕ) (u : ℝ) (h₀ : 0 ≤ u) (h₁ : u ≤ 1) :
    conv (neg l d a) (pos t e b) ((k:ℝ)+u+a+b+1) =
    (1-u)*((dot l (t.drop k):ℝ)/((d:ℝ)*e)) +
      u*((dot l (t.drop (k+1)):ℝ)/((d:ℝ)*e)) := by
  have eq := synth_conv_lerp ((indices l).image (fun j => -j)) (indices t)
    (fun j => height l d (-j)) (height t e) a b (k:ℤ) u h₀ h₁
  rw [neg_pos_node, show (k:ℤ)+1=((k+1:ℕ):ℤ) by simp, neg_pos_node] at eq
  simpa only [neg, pos, Int.cast_natCast] using eq

theorem auto_lerp (l : List ℤ) (d : ℤ) (a : ℝ)
    (k : ℕ) (u : ℝ) (h₀ : 0 ≤ u) (h₁ : u ≤ 1) :
    conv (neg l d a) (rev (neg l d a)) ((k:ℝ)+u) =
    (1-u)*((dot l (l.drop k):ℝ)/((d:ℝ)*d)) +
      u*((dot l (l.drop (k+1)):ℝ)/((d:ℝ)*d)) := by
  rw [rev_neg]
  have eq := cross_lerp l l d d a (-a-1) k u h₀ h₁
  rwa [show (k:ℝ)+u+a+(-a-1)+1=(k:ℝ)+u by ring] at eq

private theorem cell_zero (a x : ℝ) (hx : x<a ∨ a+1<x) : cell a x=0 := by
  unfold cell
  split_ifs <;> first | rfl | grind

theorem pos_support (l : List ℤ) (d : ℤ) (a : ℝ) :
    Function.support (pos l d a) ⊆ Icc a (a+l.length) := by
  intro x hx
  by_contra h
  apply hx
  unfold pos synth
  apply Finset.sum_eq_zero
  intro j hj
  obtain ⟨h₀,h₁⟩ := (mem_indices l j).mp hj
  have hr : (j:ℝ)+1 ≤ l.length := by exact_mod_cast (by omega : j+1≤(l.length:ℤ))
  have hn : (0:ℝ) ≤ j := by exact_mod_cast h₀
  rw [cell_zero _ _ (by simp [mem_Icc] at h; grind)]
  simp

theorem neg_support (l : List ℤ) (d : ℤ) (a : ℝ) :
    Function.support (neg l d a) ⊆ Icc (a-l.length+1) (a+1) := by
  intro x hx
  have hh : -x ∈ Function.support (rev (neg l d a)) := by simpa [rev] using hx
  rw [rev_neg] at hh
  obtain ⟨h₀,h₁⟩ := pos_support l d (-a-1) hh
  exact ⟨by linarith, by linarith⟩

private theorem reflect_shift (a c x : ℝ) : cell a (c-x) = cell (c-a-1) x := by
  unfold cell
  split_ifs <;> first | rfl | grind

theorem pos_symmetric (l : List ℤ) (d : ℤ) (a : ℝ) (hp : l.reverse=l) (x : ℝ) :
    pos l d a (2*a+l.length-x) = pos l d a x := by
  unfold pos synth
  let mirror : ℤ → ℤ := fun j => l.length-1-j
  have self (j : ℤ) (h : j ∈ indices l) : mirror j ∈ indices l := by
    rw [mem_indices] at *
    dsimp [mirror]
    omega
  apply Finset.sum_nbij' mirror mirror self self
  · intro j hj; dsimp [mirror]; ring
  · intro j hj; dsimp [mirror]; ring
  · intro j hj
    have hj' := (mem_indices _ _).mp hj
    have hm := (mem_indices _ _).mp (self j hj)
    have old : (get l.reverse j.toNat) = get l j.toNat := by rw [hp]
    rw [get, List.getElem?_reverse (by omega)] at old
    have he : (mirror j).toNat = l.length-1-j.toNat := by dsimp [mirror]; omega
    have hs : height l d j = height l d (mirror j) := by
      simp only [height, atInt, ite_eq_right (by omega : ¬j<0),
        ite_eq_right (by omega : ¬mirror j<0), he, get]
      exact congrArg (fun y : ℤ => (y:ℝ)/d) old.symm
    rw [hs, reflect_shift]
    congr 2
    dsimp [mirror]
    push_cast
    ring

theorem neg_symmetric (l : List ℤ) (d : ℤ) (a : ℝ) (hp : l.reverse=l) (x : ℝ) :
    neg l d a (2*a+2-l.length-x) = neg l d a x := by
  have h := pos_symmetric l d (-a-1) hp (-x)
  rw [← rev_neg] at h
  unfold rev at h
  convert h using 2 <;> ring

theorem auto_even (f : ℝ → ℝ) (x : ℝ) : conv f (rev f) (-x) = conv f (rev f) x := by
  unfold conv rev
  have h := integral_add_right_eq_self (μ := volume) (fun y : ℝ => f y * f (y-x)) x
  simpa [mul_comm, sub_eq_add_neg, add_comm, add_left_comm, add_assoc] using h

theorem cross_reflect (f g : ℝ → ℝ) (c d : ℝ)
    (hf : ∀ y, f (c-y)=f y) (hg : ∀ y, g (d-y)=g y) (x : ℝ) :
    conv f g (c+d-x) = conv f g x := by
  unfold conv
  have h := integral_sub_left_eq_self (fun y : ℝ => f y*g (x-y)) volume c
  rw [← h]
  apply integral_congr_ae
  filter_upwards with y
  rw [hf, ← hg (x-(c-y))]
  congr 2
  ring

end
end MathLab.WT.ListCells
