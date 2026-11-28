module
public import MathLab.WT.Derandomization
import Mathlib.Tactic.Linarith

/-! Extension of the WT input class to possibly unbounded atoms. Integrability
of each square is explicit. A compact probability mollifier, applied after
inserting a small unit plateau, gives bounded atoms with the same joint law. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set Filter Spectral
open scoped SchwartzMap
noncomputable section

structure L2Input (v α β : ℝ) where
  n : ℕ
  σ : ℝ
  p : Fin n → ℝ
  w : Fin n → ℝ → ℝ
  t : Fin n → ℝ → ℝ
  width_pos : 0 < v
  alpha_pos : 0 < α
  beta_pos : 0 < β
  width_le : 2*v ≤ σ
  weight_nonneg : ∀ i, 0 ≤ p i
  total_weight : ∑ i, p i = 1
  window_L1 : ∀ i, Integrable (w i)
  table_L1 : ∀ i, Integrable (t i)
  window_L2 : ∀ i, Integrable (fun x => w i x ^ 2)
  table_L2 : ∀ i, Integrable (fun x => t i x ^ 2)
  window_support : ∀ i, Function.support (w i) ⊆ Icc 0 v
  table_support : ∀ i, Function.support (t i) ⊆ Icc (-v) σ
  plateau : ∀ i x, x ∈ Ioo 0 (σ-v) → t i x = 1
  mass : ∀ i, ∫ x, w i x = 1
  table_cost : expectation p (fun i => energy (t i)) ≤ σ+α
  window_cost : expectation p (fun i => energy (w i)) ≤ β
  autocorrelation : ∀ x, 0 ≤ expectation p (fun i => conv (w i) (rev (w i)) x)
  covering : ∀ x, x ∈ Ioo 0 σ → 1 ≤ expectation p (fun i => conv (w i) (t i) x)

/-- Every original convolution integral converges absolutely at every evaluation point. -/
theorem square_integrable_product {f g : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g)
    (hf₂ : Integrable (fun y => f y ^ 2)) (hg₂ : Integrable (fun y => g y ^ 2)) (x : ℝ) :
    Integrable (fun y => f y * g (x-y)) := by
  have hh : Integrable (fun y => (f y ^ 2 + g (x-y)^2)/2) :=
    (hf₂.add (hg₂.comp_sub_left x)).div_const _
  apply hh.mono' (hf.aestronglyMeasurable.mul (hg.comp_sub_left x).aestronglyMeasurable)
  filter_upwards with y
  change |f y * g (x-y)| ≤ _
  rw [abs_mul]
  nlinarith [sq_nonneg (|f y|-|g (x-y)|),sq_abs (f y),sq_abs (g (x-y))]

namespace L2Input
variable {v α β r : ℝ}

theorem atom_integrands (P : L2Input v α β) (i : Fin P.n) (x : ℝ) :
    Integrable (fun y => P.w i y * rev (P.w i) (x-y)) ∧
    Integrable (fun y => P.w i y * P.t i (x-y)) :=
  ⟨square_integrable_product (P.window_L1 i) (P.window_L1 i).comp_neg (P.window_L2 i)
      (P.window_L2 i).comp_neg x,
    square_integrable_product (P.window_L1 i) (P.table_L1 i) (P.window_L2 i) (P.table_L2 i) x⟩

theorem smoothed_integrand (M : Mollifier r) {f : ℝ → ℝ} (hf : Integrable f) (x : ℝ) :
    Integrable (fun y => M.φ y * f (x-y)) :=
  (hf.comp_sub_left x).bdd_mul M.φ.continuous.aestronglyMeasurable
    (Eventually.of_forall (SchwartzMap.norm_le_seminorm ℝ M.φ))

theorem smoothed_regular (M : Mollifier r) {f : ℝ → ℝ} (hf : Integrable f) :
    Regular (conv M.φ f) := by
  refine ⟨M.φ.integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hf,
    massAbs f * SchwartzMap.seminorm ℝ 0 0 M.φ, ?_⟩
  intro x
  rw [conv_comm]
  exact conv_abs_bound hf (SchwartzMap.norm_le_seminorm ℝ M.φ) x

theorem smoothed_energy (M : Mollifier r) {f : ℝ → ℝ} (hf : Integrable f)
    (hf₂ : Integrable (fun x => f x ^ 2)) : energy (conv M.φ f) ≤ energy f := by
  have bound (x : ℝ) : (conv M.φ f x)^2 ≤ conv M.φ (fun z => f z^2) x := by
    let m := conv M.φ f x
    have hi := smoothed_integrand M hf x
    have hi₂ := smoothed_integrand M hf₂ x
    have h := integral_mono ((hi.const_mul (2*m)).sub (M.φ.integrable.const_mul (m^2))) hi₂
      (fun y => by
        change 2*m*(M.φ y*f (x-y))-m^2*M.φ y ≤ M.φ y*f (x-y)^2
        nlinarith only [mul_nonneg (M.nonneg y) (sq_nonneg (f (x-y)-m))])
    change (∫y, 2*m*(M.φ y*f (x-y))-m^2*M.φ y) ≤ _ at h
    rw [integral_sub (hi.const_mul _) (M.φ.integrable.const_mul _), integral_const_mul,
      integral_const_mul, M.mass] at h
    change 2*m*m-m^2*1 ≤ conv M.φ (fun z => f z^2) x at h
    change m^2 ≤ _
    linarith
  have hd : Integrable (conv M.φ (fun y => f y^2)) :=
    M.φ.integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hf₂
  exact (integral_mono (smoothed_regular M hf).integrable_square hd bound).trans_eq (by
    rw [show (∫ x, conv M.φ (fun y => f y^2) x) = _ from conv_mass M.φ.integrable hf₂,
      M.mass,one_mul]; rfl)

theorem smoothed_assoc (M : Mollifier r) {f g : ℝ → ℝ}
    (hf : Integrable f) (hg : Integrable g) :
    conv (conv M.φ f) g = conv M.φ (conv f g) := by
  have com (u v : ℝ → ℝ) := funext (conv_comm u v)
  calc
    _ = conv g (conv f M.φ) := by rw [com M.φ f, com (conv f M.φ) g]
    _ = conv (conv g f) M.φ := funext fun x => (conv_assoc_bounded hg hf M.φ.integrable
      M.φ.continuous.measurable (SchwartzMap.norm_le_seminorm ℝ M.φ) x).symm
    _ = _ := by rw [com (conv g f) M.φ,com g f]

theorem smoothed_pair (M : Mollifier r) {f g : ℝ → ℝ}
    (hf : Integrable f) (hg : Integrable g) :
    conv (conv M.φ f) (conv M.φ g) = conv M.φ (conv M.φ (conv f g)) := by
  have com (u v : ℝ → ℝ) := funext (conv_comm u v)
  rw [smoothed_assoc M hf (smoothed_regular M hg).1, com f (conv M.φ g),
    smoothed_assoc M hg hf, com g f]

theorem smoothed_rev (M : Mollifier r) (f : ℝ → ℝ) :
    rev (conv M.φ f) = conv M.φ (rev f) := by
  have he : mirror 0 M.φ = M.φ := funext fun x => by simp [mirror,M.even]
  have hr : mirror 0 f = rev f := funext fun x => by simp [mirror,rev]
  funext x
  simpa only [he,hr,zero_add,zero_sub,rev] using (conv_mirror 0 0 M.φ f x).symm

theorem smoothed_mean {n : ℕ} (M : Mollifier r) (p : Fin n → ℝ) {f : Fin n → ℝ → ℝ}
    (hf : ∀ i, Integrable (f i)) :
    conv M.φ (weighted p f) = weighted p (fun i => conv M.φ (f i)) := by
  funext x
  simp only [weighted,conv,Finset.mul_sum,show ∀ i y, M.φ y*(p i*f i (x-y)) =
    p i*(M.φ y*f i (x-y)) by intros; ring]
  rw [integral_finsetSum _ (fun i _ => (smoothed_integrand M (hf i) x).const_mul _)]
  simp only [integral_const_mul]

theorem twice_mean {n : ℕ} (M : Mollifier r) (p : Fin n → ℝ)
    {f g : Fin n → ℝ → ℝ} (hf : ∀ i, Integrable (f i)) (hg : ∀ i, Integrable (g i)) :
    weighted p (fun i => conv (conv M.φ (f i)) (conv M.φ (g i))) =
    conv M.φ (conv M.φ (weighted p (fun i => conv (f i) (g i)))) := by
  have h (i) : Integrable (conv (f i) (g i)) :=
    (hf i).integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) (hg i)
  rw [smoothed_mean M p h,smoothed_mean M p (fun i => (smoothed_regular M (h i)).1)]
  simp_rw [smoothed_pair M (hf _) (hg _)]

theorem shift_free_cover (M : Mollifier r) {a b : ℝ} {g : ℝ → ℝ} (hg : Integrable g)
    (h : ∀ x, x ∈ Ioo a b → 1 ≤ g x) (x : ℝ) (hx : x ∈ Ioo (a+r) (b-r)) :
    1 ≤ conv M.φ g x := by
  rw [← M.mass]
  apply integral_mono M.φ.integrable (smoothed_integrand M hg x)
  intro y
  change M.φ y ≤ M.φ y*g (x-y)
  by_cases hy : |y| < r
  · obtain ⟨hl,hr⟩ := abs_lt.mp hy
    exact le_mul_of_one_le_right (M.nonneg _) (h _ ⟨by linarith [hx.1],by linarith [hx.2]⟩)
  · simp [M.outside _ (le_of_not_gt hy)]

theorem smooth_support {f : ℝ → ℝ} {a b : ℝ}
    (M : Mollifier r) (hs : Function.support f ⊆ Icc a b) :
    Function.support (conv M.φ f) ⊆ Icc (a-r) (b+r) := by
  intro x hx
  by_contra ho
  apply hx
  apply integral_eq_zero_of_ae (Eventually.of_forall ?_)
  intro y
  by_cases hy : |y| < r
  · have hh : f (x-y) = 0 := by
      by_contra hn
      obtain ⟨hl,hr⟩ := hs hn
      obtain ⟨hy₁,hy₂⟩ := abs_lt.mp hy
      exact ho ⟨by linarith,by linarith⟩
    simp [hh]
  · simp [M.outside y (le_of_not_gt hy)]

theorem insert_square {f : ℝ → ℝ} {d : ℝ} (hd : 0 ≤ d)
    (h : Integrable (fun y => f y^2)) :
    Integrable (fun x => (insertPlateau d f x)^2) ∧ energy (insertPlateau d f)=energy f+d := by
  have he : (fun x => (insertPlateau d f x)^2) = insertPlateau d (fun y => f y ^ 2) := by
    funext x; unfold insertPlateau; split_ifs <;> simp
  exact ⟨he ▸ insert_integrable hd h, by unfold energy; rw [he,integral_insert hd h]⟩

theorem insert_support (P : L2Input v α β) {d : ℝ} (hd : 0 ≤ d) (i : Fin P.n) :
    Function.support (insertPlateau d (P.t i)) ⊆ Icc (-v) (P.σ+d) := by
  intro x hx
  change insertPlateau d (P.t i) x ≠ 0 at hx
  by_cases hn : x ≤ 0
  · simp only [insertPlateau,hn,ite_true] at hx
    obtain ⟨hl,hr⟩ := P.table_support i hx
    exact ⟨hl,by linarith⟩
  · refine ⟨by linarith [P.width_pos],?_⟩
    by_cases hx' : x ≤ d
    · linarith [P.width_pos,P.width_le]
    · simp only [insertPlateau,hn,hx',ite_false] at hx
      linarith [(P.table_support i hx).2]

theorem inserted_one (P : L2Input v α β) {d : ℝ} (i : Fin P.n)
    {x : ℝ} (h : x ∈ Ioo 0 (P.σ+d-v)) : insertPlateau d (P.t i) x=1 := by
  simp only [insertPlateau,not_le.mpr h.1,ite_false]
  split_ifs with h'
  · rfl
  · exact P.plateau i _ ⟨by linarith,by linarith [h.2]⟩

theorem inserted_cover (P : L2Input v α β) {d : ℝ} (hd : 0 ≤ d)
    (x : ℝ) (hx : x ∈ Ioo 0 (P.σ+d)) :
    1 ≤ weighted P.p (fun i => conv (P.w i) (insertPlateau d (P.t i))) x := by
  by_cases left : x < v
  · have e (i : Fin P.n) : conv (P.w i) (insertPlateau d (P.t i)) x = conv (P.w i) (P.t i) x := by
      apply conv_window_congr (P.window_support i)
      intro y hy
      by_cases h : x-y ≤ 0
      · simp [insertPlateau,h]
      · rw [inserted_one P i ⟨by linarith,by linarith [hy.1,P.width_le]⟩,
          P.plateau i _ ⟨by linarith,by linarith [hy.1,P.width_le]⟩]
    simpa only [weighted,e,expectation] using P.covering x ⟨hx.1,by linarith [P.width_le,P.width_pos]⟩
  · by_cases mid : x ≤ v+d
    · have e (i : Fin P.n) : conv (P.w i) (insertPlateau d (P.t i)) x=1 := by
        rw [conv_window_congr (w := P.w i) (g := fun _ => 1) (z := x) (P.window_support i)
          (fun y hy => inserted_one P i ⟨by linarith [hy.2],by linarith [hy.1,P.width_le]⟩)]
        simpa only [conv,mul_one] using P.mass i
      simp [weighted,e,P.total_weight]
    · have e (i : Fin P.n) : conv (P.w i) (insertPlateau d (P.t i)) x =
          conv (P.w i) (P.t i) (x-d) := by
        apply conv_window_congr (P.window_support i)
        intro y hy
        have h : ¬ x-y ≤ d := by linarith [hy.2]
        simp [insertPlateau,h,show ¬x-y ≤ 0 by linarith,show x-y-d=x-d-y by ring]
      simpa only [weighted,e,expectation] using P.covering (x-d)
        ⟨by linarith [P.width_pos],by linarith [hx.2]⟩

/-- Keep the original finite joint probabilities. The new declared parameters are
`v+6r` and `σ+12r`. Only the table surplus pays `4r` for erosion of the cover. -/
def bounded (P : L2Input v α β) (M : Mollifier r) (hr : 0 < r) :
    Witness (v+6*r) (α+4*r) β := by
  let d := 16*r
  have hd : 0 ≤ d := by dsimp [d]; positivity
  let T (i : Fin P.n) := insertPlateau d (P.t i)
  have ht (i) : Integrable (T i) := insert_integrable hd (P.table_L1 i)
  have hT₂ (i) := insert_square hd (P.table_L2 i)
  let w (i : Fin P.n) := conv M.φ (P.w i)
  let t (i : Fin P.n) := conv M.φ (T i)
  refine {
    n := P.n, σ := P.σ+12*r, p := P.p,
    w := fun i => shift (3*r) (w i),
    t := fun i => shift (-5*r) (t i),
    width_pos := by linarith [P.width_pos],
    alpha_pos := by linarith [P.alpha_pos],
    beta_pos := P.beta_pos, width_le := by linarith [P.width_le],
    weight_nonneg := P.weight_nonneg, total_weight := P.total_weight,
    window_regular := fun i => (smoothed_regular M (P.window_L1 i)).shift _,
    table_regular := fun i => (smoothed_regular M (ht i)).shift _,
    window_support := ?_, table_support := ?_, plateau := ?_,
    mass := ?_, table_cost := ?_, window_cost := ?_, autocorrelation := ?_, covering := ?_ }
  · intro i x hx
    obtain ⟨hl,hu⟩ := shift_support (3*r) (smooth_support M (P.window_support i)) hx
    exact ⟨by linarith,by linarith⟩
  · intro i x hx
    obtain ⟨hl,hu⟩ := shift_support (-5*r) (smooth_support M (insert_support P hd i)) hx
    dsimp only [d] at hu
    exact ⟨by linarith,by linarith⟩
  · intro i x hx
    change (∫ y, M.φ y*T i (x- -5*r-y)) = 1
    rw [← M.mass]
    apply integral_congr_ae (Eventually.of_forall ?_)
    intro y
    by_cases hy : |y| < r
    · obtain ⟨hl,hu⟩ := abs_lt.mp hy
      have h : T i (x- -5*r-y)=1 := inserted_one P i
        ⟨by linarith [hx.1],by dsimp [d]; linarith [hx.2]⟩
      rw [h,mul_one]
    · simp [M.outside y (le_of_not_gt hy)]
  · intro i
    rw [integral_shift,show (∫ y,w i y)=_ from conv_mass M.φ.integrable (P.window_L1 i),
      M.mass,P.mass i,one_mul]
  · simp only [expectation,energy_shift]
    have h (i) : P.p i * energy (t i) ≤ P.p i*(energy (P.t i)+d) := by
      apply mul_le_mul_of_nonneg_left _ (P.weight_nonneg _)
      exact (smoothed_energy M (ht i) (hT₂ i).1).trans_eq (hT₂ i).2
    apply (Finset.sum_le_sum fun i _ => h i).trans
    simp only [mul_add,Finset.sum_add_distrib,← Finset.sum_mul,P.total_weight,one_mul]
    have orig := P.table_cost
    unfold expectation at orig
    dsimp only [d]
    linarith
  · simp only [expectation,energy_shift]
    exact (Finset.sum_le_sum (fun i _ => mul_le_mul_of_nonneg_left
      (smoothed_energy M (P.window_L1 i) (P.window_L2 i)) (P.weight_nonneg i))).trans P.window_cost
  · intro x
    simp only [autocorr_shift]
    have hrw (i) : rev (w i) = conv M.φ (rev (P.w i)) := smoothed_rev M _
    simp only [hrw]
    change 0 ≤ weighted P.p (fun i => conv (conv M.φ (P.w i)) (conv M.φ (rev (P.w i)))) x
    rw [twice_mean M P.p (g := fun i => rev (P.w i)) P.window_L1
      (fun i => (P.window_L1 i).comp_neg)]
    exact conv_nonneg M.nonneg (conv_nonneg M.nonneg P.autocorrelation) x
  · intro x hx
    simp only [conv_shift,show 3*r+ -5*r = -(2*r) by ring,sub_neg_eq_add]
    change 1 ≤ weighted P.p (fun i => conv (conv M.φ (P.w i)) (conv M.φ (T i))) (x+2*r)
    rw [twice_mean M _ P.window_L1 ht]
    let c := weighted P.p (fun i => conv (P.w i) (T i))
    have hi : Integrable c := weighted_integrable _ (fun i => (P.window_L1 i).integrable_convolution
      (ContinuousLinearMap.mul ℝ ℝ) (ht i))
    have hinner (y : ℝ) (hy : y ∈ Ioo (0+r) (P.σ+d-r)) : 1 ≤ conv M.φ c y :=
      shift_free_cover M hi (inserted_cover P hd) y hy
    exact shift_free_cover M (smoothed_regular M hi).1 hinner _ ⟨by linarith [hx.1],
      by dsimp only [d]; linarith [hx.2]⟩

@[simp] theorem bounded_length (P : L2Input v α β) (M : Mollifier r) (hr : 0 < r) :
    (P.bounded M hr).σ = P.σ+12*r := rfl

@[simp] theorem bounded_weights (P : L2Input v α β) (M : Mollifier r) (hr : 0 < r) :
    (P.bounded M hr).p = P.p := rfl

/-- Joint budget approximation also holds for possibly unbounded square-integrable
atoms satisfying the pointwise WT conditions. -/
theorem cost_derandomization (P : L2Input v α β) {ε : ℝ} (hε : 0 < ε) :
    ∃ v' : ℝ, ∃ W : Witness v' (α+ε) (β+ε), W.Deterministic ∧ W.Symmetric := by
  let r := ε/8
  have hr : 0 < r := by dsimp [r]; positivity
  obtain ⟨M⟩ := mollifier_exists hr
  let B := P.bounded M hr
  let E : Witness (v+6*r) (α+4*r) (β+4*r) :=
    {B with beta_pos := by linarith [P.beta_pos],
            window_cost := B.window_cost.trans (by linarith)}
  have ht := simultaneous_approximation _ _ _ E (ε/2) (by positivity)
  have hα : α+4*r+ε/2=α+ε := by dsimp [r]; ring
  have hβ : β+4*r+ε/2=β+ε := by dsimp [r]; ring
  rw [hα,hβ] at ht
  exact ht

#print axioms cost_derandomization
end L2Input
end
end MathLab.WT
