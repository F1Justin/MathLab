module
public import MathLab.WT.ProfileTheorem
public import MathLab.WT.EnergyBump
import MathLab.WT.FinalTable
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Recovering a prescribed actual table energy using two smooth bumps
outside the old table. The original covering interval sees neither bump. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set Filter
open scoped ContDiff
noncomputable section

private theorem expectation_single {v α β : ℝ} {X : Witness v α β}
    (h : X.Deterministic) (i : Fin X.n) (f : Fin X.n → ℝ) : expectation X.p f = f i := by
  have hs : Subsingleton (Fin X.n) := by
    change X.n = 1 at h
    rw [h]
    infer_instance
  have eqn (j : Fin X.n) : f j = f i := congrArg f (hs.elim j i)
  simp only [expectation, eqn, ← Finset.sum_mul, X.total_weight, one_mul]

theorem fill_profile_energy {v α β : ℝ} {W : Witness v α β} {e : ℝ}
    (he : 0 < e) (P : ℝ) (Q : SmoothProfileWitness W e P) :
    ∃ Q' : SmoothProfileWitness W (2*e) P, W.tableExcess ≤ Q'.tableSurplus := by
  let V := Q.witness.centerWindow Q.i
  let T := Q.witness.centerTable Q.i
  let u := (Q.width+Q.D)/2
  let l := Q.D+Q.width/2
  let r := Q.D+u/2
  let d := max 0 (W.tableExcess-Q.tableSurplus)
  have hwidth := Q.witness.width_pos
  have hu : Q.width < u := by dsimp [u]; linarith [Q.width_lt]
  have hD : u < Q.D := by dsimp [u]; linarith [Q.width_lt]
  have hl : 0 < l := by dsimp [l]; linarith
  have hlr : l < r := by dsimp [l,r]; linarith
  have vreg : Regular V := (Q.witness.window_regular Q.i).shift _
  have treg : Regular T := (Q.witness.table_regular Q.i).shift _
  obtain ⟨B,hB⟩ := vreg.2
  have hB₀ : 0 ≤ B := (abs_nonneg _).trans (hB 0)
  have hB₁ : 0 < 1+B := by linarith
  obtain ⟨b,bsm,bc,be,bz,ben,bsmall⟩ :=
    shoulder_energy_bump hl hlr (show 0 ≤ d from le_max_left _ _) (div_pos he hB₁)
  let U (x : ℝ) := T x + b x
  have breg := regular_of_continuous_compact bsm.continuous bc
  have vm : (∫ x, V x) = 1 := (integral_shift _ _).trans (Q.witness.mass Q.i)
  have vsm : ContDiff ℝ ∞ V := Q.smooth_window.1.comp (contDiff_id.sub contDiff_const)
  have tsm : ContDiff ℝ ∞ T := Q.smooth_table.1.comp (contDiff_id.sub contDiff_const)
  have usm : ContDiff ℝ ∞ U := tsm.add bsm
  have ve (x : ℝ) : V (-x) = V x := by
    change Q.witness.w Q.i (-x-(-Q.width/2)) = Q.witness.w Q.i (x-(-Q.width/2))
    rw [show -x-(-Q.width/2) = Q.width-(x-(-Q.width/2)) by ring]
    exact (Q.symmetric Q.i _).1
  have te (x : ℝ) : T (-x) = T x := by
    let c := -(Q.witness.σ-Q.width)/2
    change Q.witness.t Q.i (-x-c) = Q.witness.t Q.i (x-c)
    rw [show -x-c = Q.witness.σ-Q.width-(x-c) by dsimp [c]; ring]
    exact (Q.symmetric Q.i _).2
  have ue (x : ℝ) : U (-x) = U x := by simp only [U,te,be]
  have vzero (x : ℝ) (hx : Q.width/2 < |x|) : V x = 0 := by
    by_contra hn
    obtain ⟨ha,hb⟩ := Q.witness.center_window_support Q.i hn
    exact hx.not_ge (abs_le.mpr ⟨by linarith,hb⟩)
  have tzero (x : ℝ) (hx : l < |x|) : T x = 0 := by
    by_contra hn
    obtain ⟨ha,hb⟩ := Q.witness.center_table_support Q.i hn
    rw [Q.length] at ha hb
    apply hx.not_ge
    apply abs_le.mpr
    dsimp [l]
    exact ⟨by linarith,by linarith⟩
  have ws : Function.support V ⊆ Icc (-u/2) (u/2) :=
    (Q.witness.center_window_support Q.i).trans (Icc_subset_Icc (by linarith) (by linarith))
  have ts : Function.support U ⊆ Icc (-Q.D-u/2) (Q.D+u/2) := by
    intro x hx
    have hh : |x| ≤ r := le_of_not_gt fun hr => hx (by
      simp only [U,tzero x (hlr.trans hr),bz x (Or.inr hr.le),add_zero])
    obtain ⟨ha,hb⟩ := abs_le.mp hh
    exact ⟨by dsimp [r] at ha; linarith,hb⟩
  have plateau (x : ℝ) (hx : |x| < Q.D-u/2) : U x = 1 := by
    have old : T x = 1 := Q.witness.center_plateau Q.i (by rw [Q.length]; linarith)
    have vanish : b x = 0 := bz x (Or.inl (by dsimp [l]; linarith))
    simp only [U,old,vanish,add_zero]
  have sqsum (x : ℝ) : U x ^ 2 = T x ^ 2 + b x ^ 2 := by
    by_cases hx : |x| ≤ l
    · simp [U,bz x (Or.inl hx)]
    · simp [U,tzero x (lt_of_not_ge hx)]
  have energy_sum : energy U = energy T+d := by
    simp only [energy,sqsum,integral_add treg.integrable_square breg.integrable_square]
    rw [show (∫ x, b x ^ 2) = d from ben]
  have et : energy T = energy (Q.witness.t Q.i) := energy_shift _ _
  have ev : energy V = energy (Q.witness.w Q.i) := energy_shift _ _
  have surplus : energy U-2*Q.D = Q.tableSurplus+d := by
    rw [energy_sum,et,SmoothProfileWitness.tableSurplus]; ring
  have low : W.tableExcess ≤ Q.tableSurplus+d := by
    dsimp [d]
    linarith [le_max_right (0:ℝ) (W.tableExcess-Q.tableSurplus)]
  have high : Q.tableSurplus+d ≤ W.tableExcess+e := by
    by_cases h : W.tableExcess ≤ Q.tableSurplus
    · simpa only [d,max_eq_left (sub_nonpos.mpr h),add_zero,SmoothProfileWitness.tableSurplus]
        using Q.table_error
    · dsimp [d]
      rw [max_eq_right (sub_nonneg.mpr (le_of_not_ge h))]
      linarith
  have wc : energy V ≤ W.windowEnergy+2*e := by
    rw [ev]; linarith [(abs_le.mp Q.energy_error).2]
  have tc : energy U ≤ 2*Q.D+(W.tableExcess+2*e) := by linarith
  have cov_orig (x : ℝ) : conv V T x = conv (Q.witness.w Q.i) (Q.witness.t Q.i) (x+Q.D) := by
    unfold V T Witness.centerWindow Witness.centerTable
    rw [conv_shift,Q.length]
    congr 1
    ring
  have cov_sum (x : ℝ) : conv V U x = conv V T x+conv V b x := by
    unfold conv
    simp only [U,mul_add]
    exact integral_add (conv_integrand_mem vreg.1 treg x) (conv_integrand_mem vreg.1 breg x)
  have bcov (x : ℝ) (hx : |x| < Q.D) : conv V b x = 0 := by
    apply integral_eq_zero_of_ae (Eventually.of_forall ?_)
    intro y
    by_cases hy : |y| ≤ Q.width/2
    · have hxy : |x-y| ≤ l := (abs_sub x y).trans (by dsimp [l]; linarith)
      simp [bz (x-y) (Or.inl hxy)]
    · simp [vzero y (lt_of_not_ge hy)]
  have cbound (x : ℝ) : |conv V b x| ≤ e := by
    rw [conv_comm V b x]
    calc
      _ ≤ massAbs b * B := conv_abs_bound breg.1 hB x
      _ ≤ (e/(1+B)) * B := mul_le_mul_of_nonneg_right bsmall hB₀
      _ ≤ (e/(1+B)) * (1+B) :=
        mul_le_mul_of_nonneg_left (by linarith) (div_pos he hB₁).le
      _ = e := div_mul_cancel₀ _ hB₁.ne'
  have aorig (x : ℝ) : conv V (rev V) x =
      conv (Q.witness.w Q.i) (rev (Q.witness.w Q.i)) x := autocorr_shift _ _ _
  have ac (x : ℝ) : 0 ≤ conv V V x := by
    have h := Q.witness.autocorrelation x
    rw [expectation_single Q.deterministic Q.i,← aorig,show rev V=V from funext ve] at h
    exact h
  have co (x : ℝ) (hx : |x| < Q.D) : 1 ≤ conv V U x := by
    rw [cov_sum,bcov x hx,add_zero,cov_orig]
    have hh := abs_lt.mp hx
    have h := Q.witness.covering (x+Q.D) ⟨by linarith [hh.1],by rw [Q.length]; linarith [hh.2]⟩
    rwa [expectation_single Q.deterministic Q.i] at h
  obtain ⟨O,od,os,olen,ow,ot⟩ := ofCenteredPair (hwidth.trans hu) hD.le
    (show 0 < W.tableExcess+2*e by linarith [W.actual_costs_pos.1])
    (show 0 < W.windowEnergy+2*e by linarith [W.actual_costs_pos.2])
    vreg (treg.add breg) ws ts plateau vm wc tc ve ue ac co
  have hn : 0 < O.n := by rw [od]; decide
  let j : Fin O.n := ⟨0,hn⟩
  have anew (x : ℝ) : conv (O.w j) (rev (O.w j)) x =
      conv (Q.witness.w Q.i) (rev (Q.witness.w Q.i)) x := by
    rw [ow j,autocorr_shift,aorig]
  have cnew (x : ℝ) : conv (O.w j) (O.t j) (x+Q.D) = conv V T x+conv V b x := by
    rw [ow j,ot j,conv_shift,show x+Q.D-(u/2+(Q.D-u/2))=x by ring,cov_sum]
  have etnew : energy (O.t j)-2*Q.D = Q.tableSurplus+d := by rw [ot j,energy_shift,surplus]
  let Q' : SmoothProfileWitness W (2*e) P := {
    width := u, D := Q.D, width_lt := hD, length_gt := Q.length_gt, expands := Q.expands
    witness := O, deterministic := od, symmetric := os, length := olen, i := j
    smooth_window := ⟨by rw [ow j]; exact vsm.comp (contDiff_id.sub contDiff_const),
      HasCompactSupport.of_support_subset_isCompact isCompact_Icc (O.window_support j)⟩
    smooth_table := ⟨by rw [ot j]; exact usm.comp (contDiff_id.sub contDiff_const),
      HasCompactSupport.of_support_subset_isCompact isCompact_Icc (O.table_support j)⟩
    auto_sup := fun x => by rw [anew]; linarith [Q.auto_sup x]
    auto_l1 := by simp only [anew]; linarith [Q.auto_l1]
    cover_sup := fun x => by
      rw [cnew,cov_orig,show ∀ a b c : ℝ, a+b-c=(a-c)+b by intros; ring]
      exact (abs_add_le _ _).trans (by linarith [Q.cover_sup x,cbound x])
    energy_error := by rw [ow j,energy_shift,ev]; linarith [Q.energy_error]
    table_error := by rw [etnew]; linarith }
  exact ⟨Q',by change W.tableExcess ≤ energy (O.t j)-2*Q.D; rwa [etnew]⟩

end
end MathLab.WT
