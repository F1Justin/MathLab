module
public import MathLab.WT.WindowCut
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

@[expose] public section
namespace MathLab.WT.Window
open MeasureTheory Set Filter Function
open scoped SchwartzMap Topology
noncomputable section

private theorem conv_sub_left_est {f s g : ℝ → ℝ} (hi : Integrable f) (hs : Integrable s)
    (hc : Continuous g) {B : ℝ} (hb : ∀ x, |g x| ≤ B) (x : ℝ) :
    |conv f g x-conv s g x| ≤ distance f s * B := by
  have intg {t : ℝ → ℝ} (ht : Integrable t) : Integrable (fun y => t y*g (x-y)) :=
    ht.mul_bdd (g := fun y : ℝ => g (x-y))
      (hc.comp (continuous_const.sub continuous_id)).aestronglyMeasurable
      (Eventually.of_forall fun y => by simpa only [Real.norm_eq_abs] using hb (x-y))
  rw [conv,conv,← integral_sub (intg hi) (intg hs),distance,← integral_mul_const]
  apply abs_integral_le_integral_abs.trans
  have he : Integrable (fun y => |f y-s y| * B) := (hi.sub hs).abs.mul_const B
  apply integral_mono_of_nonneg (Eventually.of_forall fun _ => abs_nonneg _) he
    (Eventually.of_forall ?_)
  intro y
  change |f y*g (x-y)-s y*g (x-y)| ≤ |f y-s y| * B
  rw [← sub_mul,abs_mul]
  exact mul_le_mul_of_nonneg_left (hb _) (abs_nonneg _)

theorem conv_self_est {f s : ℝ → ℝ} (hi : Integrable f) (hs : Integrable s)
    (hc : Continuous f) (hcs : Continuous s) {B S : ℝ}
    (hb : ∀ x, |f x|≤B) (hbs : ∀ x, |s x|≤S) (x : ℝ) :
    |conv f f x-conv s s x| ≤ distance f s * (B+S) := by
  calc
    _ ≤ |conv f f x-conv s f x| + |conv s f x-conv s s x| := abs_sub_le _ _ _
    _ ≤ distance f s*B + distance f s*S := by
      apply add_le_add (conv_sub_left_est hi hs hc hb x)
      rw [conv_comm s f]
      exact conv_sub_left_est hi hs hcs hbs x
    _ = _ := by ring

private theorem even_energy {f : ℝ → ℝ} (h : ∀ x, f (-x)=f x) :
    energy f=conv f f 0 := by simp only [energy,conv,zero_sub,h,sq]

private theorem mixed_distance {s f g : ℝ → ℝ} (hs : Integrable s)
    (hf : Integrable f) (hg : Integrable g) (hmg : ∫ x, g x=1) (hpg : ∀ x, 0≤g x)
    {b : ℝ} (hb : b∈Icc 0 1) :
    distance (fun y => (1-b)*f y+b*g y) s ≤
      (1-b)*distance f s + b*(1+∫ x, |s x|) := by
  have i₁ : Integrable (fun x => (1-b)*|f x - s x|) := (hf.sub hs).abs.const_mul _
  have i₂ : Integrable (fun x => b*(g x+|s x|)) := (hg.add hs.abs).const_mul _
  calc
    _ ≤ ∫ x, (1-b)*|f x-s x| + b*(g x+|s x|) := by
      apply integral_mono_of_nonneg (Eventually.of_forall fun _ => abs_nonneg _)
        (i₁.add i₂) (Eventually.of_forall ?_)
      intro x
      change |(1-b)*f x+b*g x-s x| ≤ (1-b)*|f x-s x|+b*(g x+|s x|)
      rw [show (1-b)*f x+b*g x-s x=(1-b)*(f x-s x)+b*(g x-s x) by ring]
      apply (abs_add_le _ _).trans
      rw [abs_mul,abs_mul,abs_of_nonneg (sub_nonneg.mpr hb.2),abs_of_nonneg hb.1]
      apply add_le_add le_rfl
      apply mul_le_mul_of_nonneg_left _ hb.1
      simpa only [abs_of_nonneg (hpg x)] using abs_sub (g x) (s x)
    _ = _ := by
      have ig : Integrable (fun x => g x+|s x|) := hg.add hs.abs
      rw [integral_add i₁ i₂, integral_const_mul,integral_const_mul,
        integral_add hg hs.abs, hmg]
      rfl

set_option maxHeartbeats 2000000 in
/-- Compact, even, mass-one real windows with everywhere nonnegative
autocorrelation, and simultaneous L¹ and energy control. -/
theorem compact_schwartz_window_profiles (s : 𝓢(ℝ,ℝ)) (hse : ∀ x, s (-x)=s x)
    (hsm : ∫ x, s x=1) (hpos : ∀ x, 0 ≤ conv s s x) :
    ∃ C : ℝ, 0<C ∧ ∀ᶠ n : ℝ in atTop, ∃ V : ℝ → ℝ,
      Continuous V ∧ HasCompactSupport V ∧ (∀ x, n^2 < |x| → V x=0) ∧
      (∀ x, V (-x)=V x) ∧ (∫ x, V x)=1 ∧ (∀ x, 0≤conv V V x) ∧
      (∫ x, |V x-s x|) ≤ C/n^3 ∧ energy V ≤ energy s + C/n^3 ∧
      ∀ x, |conv V V x-conv s s x| ≤ C/n^3 := by
  obtain ⟨A,H,J,hA,hH,hJ,hcut⟩ := cuts s hse hsm
  obtain ⟨D,hD,hD₂⟩ := derivative_bound
  let S := SchwartzMap.seminorm ℝ 0 0 s
  have hsB (x : ℝ) : |s x| ≤ S := by simpa [S,Real.norm_eq_abs] using SchwartzMap.norm_le_seminorm ℝ s x
  have hS : 0≤S := (abs_nonneg _).trans (hsB 0)
  let B := H+centerHeight+S
  let L := A+1+∫ x, |s x|
  let K := A*(H+S)
  let c := centerHeight^2/4
  have hIntS : 0≤∫ x, |s x| := integral_nonneg fun _ => abs_nonneg _
  have hBC := centerHeight_pos
  have hB : 0≤B := by dsimp [B]; positivity
  have hL : 0<L := by dsimp [L]; linarith
  have hK : 0≤K := by dsimp [K]; positivity
  have hcp : 0<c := by dsimp [c]; positivity
  refine ⟨L*(1+B),by positivity,?_⟩
  filter_upwards [eventually_ge_atTop (8:ℝ), eventually_ge_atTop ((K+2*D*J)/c)] with n hn hN
  have hn' : 0<n := by linarith
  have hn₁ : 1≤n := by linarith
  obtain ⟨F⟩ := hcut n hn₁
  let R := n^2
  let b := 1/n^3
  let g := wide R
  have hR : 0<R := sq_pos_of_pos hn'
  have hR₁ : 1≤R := one_le_pow₀ hn₁
  have hb : b∈Icc 0 1 := ⟨by dsimp [b]; positivity, (div_le_one (by positivity)).mpr (one_le_pow₀ hn₁)⟩
  have ha : 0≤1-b := sub_nonneg.mpr hb.2
  have hR₂ : 2*n≤R/4 := by dsimp [R]; nlinarith [mul_nonneg hn'.le (sub_nonneg.mpr hn)]
  have hi := F.continuous.integrable_of_hasCompactSupport (μ := volume) F.compact
  have hgi := (wide_cont R).integrable_of_hasCompactSupport (μ := volume) (wide_compact hR)
  have hff (x : ℝ) : -(K/n^10) ≤ conv F.f F.f x := by
    have hh := (abs_le.mp (conv_self_est hi s.integrable F.continuous s.continuous F.sup hsB x)).1
    have he := mul_le_mul_of_nonneg_right F.close (by linarith : 0≤H+S)
    have e : A/n^10*(H+S)=K/n^10 := by dsimp [K]; ring
    linarith [hpos x]
  have hfg (x : ℝ) : -(D*J/R^3) ≤ conv F.f g x := by
    have hh := (abs_le.mp (convolution_second_moment F.continuous F.compact F.mass F.even
      (wide_diff R) (wide_diff' R) (div_nonneg hD (by positivity)) (hD₂ R hR) x)).1
    have hm := mul_le_mul_of_nonneg_left F.second (div_nonneg hD (show 0≤R^3 by positivity))
    change D/R^3*(∫ y, |F.f y| * y^2) ≤ D/R^3*J at hm
    have h0 := wide_nonneg hR x
    change -(D*J/R^3) ≤ conv F.f (wide R) x
    linarith only [hh,hm,h0,show D/R^3*J=D*J/R^3 by ring]
  have margin : (1-b)^2*(K/n^10) + 2*(1-b)*b*(D*J/R^3) ≤ b^2*(c/R) := by
    have hm := (div_le_iff₀ hcp).mp hN
    have hm' : K+2*D*J*n ≤ c*n^2 := by
      have hmul := mul_le_mul_of_nonneg_left hm hn'.le
      nlinarith [mul_nonneg hK (sub_nonneg.mpr hn₁)]
    calc
      _ ≤ K/n^10 + 2*b*(D*J/R^3) := by
        apply add_le_add
        · exact mul_le_of_le_one_left (by positivity) (by nlinarith [hb.1,hb.2,mul_nonneg hb.1 ha])
        · apply mul_le_mul_of_nonneg_right _ (by positivity)
          apply mul_le_mul_of_nonneg_right _ hb.1
          linarith only [hb.1]
      _ = (K+2*D*J*n)/n^10 := by dsimp [b,R]; field_simp
      _ ≤ (c*n^2)/n^10 := (div_le_div_iff_of_pos_right (by positivity)).mpr hm'
      _ = _ := by dsimp [b,R]; field_simp
  let V (x : ℝ) := (1-b)*F.f x+b*g x
  have vcont : Continuous V := (continuous_const.mul F.continuous).add (continuous_const.mul (wide_cont R))
  have vs (x : ℝ) (hx : R < |x|) : V x=0 := by
    simp [V,g,F.support _ (by linarith),wide_out hR _ hx]
  have ve (x : ℝ) : V (-x)=V x := by simp [V,g,F.even,wide_even]
  have vg : ∀ x, |g x| ≤ centerHeight := by
    intro x
    rw [abs_of_nonneg (wide_nonneg hR x)]
    exact (mul_le_of_le_one_left (bump_nonneg _) (inv_le_one_of_one_le₀ hR₁)).trans (bump_bound _)
  have vbound (x : ℝ) : |V x| ≤ H+centerHeight := by
    apply (abs_add_le _ _).trans
    rw [abs_mul,abs_mul,abs_of_nonneg ha,abs_of_nonneg hb.1]
    exact add_le_add ((mul_le_of_le_one_left (abs_nonneg _) (by linarith [hb.1])).trans (F.sup x))
      ((mul_le_of_le_one_left (abs_nonneg _) hb.2).trans (vg x))
  have vclose : distance V s ≤ L/n^3 := by
    have h := mixed_distance s.integrable hi hgi (wide_mass hR) (wide_nonneg hR) hb
    have h₁ : (1-b)*distance F.f s ≤ A/n^10 :=
      (mul_le_of_le_one_left (integral_nonneg fun _ => abs_nonneg _) (by linarith [hb.1])).trans F.close
    have hpow : n^3≤n^10 := pow_le_pow_right₀ hn₁ (by decide)
    have h₂ : A/n^10 ≤ A/n^3 := div_le_div_of_nonneg_left hA.le (by positivity) hpow
    change distance V s ≤ _ at h
    calc
      _ ≤ A/n^3 + b*(1+∫ x, |s x|) := h.trans (add_le_add (h₁.trans h₂) le_rfl)
      _ = _ := by dsimp [b,L]; ring
  have hconv (x : ℝ) : |conv V V x-conv s s x| ≤ L*(1+B)/n^3 := by
    have h := conv_self_est (vcont.integrable_of_hasCompactSupport (compact_of_zero_outside vs))
      s.integrable vcont s.continuous vbound hsB x
    calc
      _ ≤ distance V s * B := h
      _ ≤ L/n^3*B := mul_le_mul_of_nonneg_right vclose hB
      _ = L*B/n^3 := by ring
      _ ≤ L*(1+B)/n^3 := by gcongr; linarith
  refine ⟨V,vcont,compact_of_zero_outside vs,vs,ve,?_,?_,?_,?_,hconv⟩
  · change (∫ y, (1-b)*F.f y+b*g y)=1
    rw [integral_add (hi.const_mul _) (hgi.const_mul _),integral_const_mul,integral_const_mul,
      F.mass,show (∫ y, g y)=1 from wide_mass hR]
    ring
  · intro x
    exact wide_bump_nonnegative F.continuous F.compact (wide_cont R) (wide_compact hR)
      (wide_nonneg hR) (by linarith : 2*n≤R) ha hb.1 F.support (wide_out hR) hff hfg
      (fun y hy => wide_self_lower hR (by linarith)) margin x
  · apply vclose.trans
    gcongr
    nlinarith [mul_nonneg hL.le hB]
  · have en := (abs_le.mp (hconv 0)).2
    rw [← even_energy ve,← even_energy hse] at en
    linarith

theorem compact_schwartz_window (s : 𝓢(ℝ,ℝ)) (hse : ∀ x, s (-x)=s x)
    (hsm : ∫ x, s x=1) (hpos : ∀ x, 0 ≤ conv s s x) :
    ∃ C : ℝ, 0<C ∧ ∀ᶠ n : ℝ in atTop, ∃ V : ℝ → ℝ,
      Continuous V ∧ HasCompactSupport V ∧ (∀ x, n^2 < |x| → V x=0) ∧
      (∀ x, V (-x)=V x) ∧ (∫ x, V x)=1 ∧ (∀ x, 0≤conv V V x) ∧
      (∫ x, |V x-s x|) ≤ C/n^3 ∧ energy V ≤ energy s + C/n^3 := by
  obtain ⟨C,hC,h⟩ := compact_schwartz_window_profiles s hse hsm hpos
  refine ⟨C,hC,?_⟩
  filter_upwards [h] with n hn
  obtain ⟨V,hc,hk,hs,he,hm,ha,hl,hw,_⟩ := hn
  exact ⟨V,hc,hk,hs,he,hm,ha,hl,hw⟩

#print axioms compact_schwartz_window
end
end MathLab.WT.Window
