module
public import MathLab.WT.CenteredProfiles
public import MathLab.WT.ProfileSmoothing
public import MathLab.WT.TightBudgets
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Topology.Order.LiminfLimsup
import Mathlib.Tactic.Linarith

/-! A common sequence of actual smooth deterministic, symmetric WT witnesses,
with the input's actual energies and both input correlation profiles. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Filter
open scoped ContDiff Topology
noncomputable section

variable {v α β : ℝ}

/-- The selected atom is the sole atom in the finite output law. The window
and table are in the original coordinates of the WT definition. -/
structure SmoothProfileWitness (W : Witness v α β) (ε P : ℝ) where
  width : ℝ
  D : ℝ
  width_lt : width < D
  length_gt : P < D
  expands : W.σ/2 ≤ D
  witness : Witness width (W.tableExcess+ε) (W.windowEnergy+ε)
  deterministic : witness.Deterministic
  symmetric : witness.Symmetric
  length : witness.σ = 2*D
  i : Fin witness.n
  smooth_window : ContDiff ℝ ∞ (witness.w i) ∧ HasCompactSupport (witness.w i)
  smooth_table : ContDiff ℝ ∞ (witness.t i) ∧ HasCompactSupport (witness.t i)
  auto_sup : ∀ x, |conv (witness.w i) (rev (witness.w i)) x - W.meanAutocorr x| ≤ ε
  auto_l1 : massAbs (fun x => conv (witness.w i) (rev (witness.w i)) x - W.meanAutocorr x) ≤ ε
  cover_sup : ∀ x, |conv (witness.w i) (witness.t i) (x+D) - W.reflectedCover D expands x| ≤ ε
  energy_error : |energy (witness.w i) - W.windowEnergy| ≤ ε
  table_error : energy (witness.t i)-2*D ≤ W.tableExcess+ε

abbrev CenteredProfileRealization : Prop :=
  ∀ (v α β : ℝ) (W : Witness v α β) {ε : ℝ}, 0<ε → ∀ P : ℝ, Nonempty (CenteredProfiles W ε P)

theorem Witness.smoothProfile_of_realization (W : Witness v α β) (hreal : CenteredProfileRealization)
    {ε : ℝ} (hε : 0 < ε) (P : ℝ) : Nonempty (SmoothProfileWitness W ε P) := by
  let e := ε/4
  have he : 0 < e := by dsimp [e]; positivity
  obtain ⟨C⟩ := hreal v W.tableExcess W.windowEnergy W.tight he P
  have ha := add_pos W.actual_costs_pos.1 he
  have hb := add_pos W.actual_costs_pos.2 he
  obtain ⟨ρ,hρ,hs⟩ := W.tight.smooth_profile_pair he C.width_pos C.width_lt C.expands ha hb
    C.window_regular C.table_regular C.window_support C.table_support C.plateau C.mass C.window_cost
    C.table_cost C.even_window C.even_table C.autocorrelation C.cover C.auto_sup C.auto_l1 C.cover_sup
  let m := min ρ (min e 1)
  let r := min m ((C.D-C.u)/4)/4
  have hm : 0 < m := lt_min hρ (lt_min he zero_lt_one)
  have hgap : 0 < (C.D-C.u)/4 := by linarith [C.width_lt]
  have hr : 0 < r := div_pos (lt_min hm hgap) (by norm_num)
  have h4m : 4*r ≤ m := by dsimp [r]; linarith [min_le_left m ((C.D-C.u)/4)]
  have h4gap : 4*r ≤ (C.D-C.u)/4 := by dsimp [r]; linarith [min_le_right m ((C.D-C.u)/4)]
  have hsmall : r < min ρ (min e 1) := by
    change r < m
    linarith
  have hre : 4*r ≤ e := h4m.trans ((min_le_right _ _).trans (min_le_left _ _))
  have hr₁ : 4*r ≤ 1 := h4m.trans ((min_le_right _ _).trans (min_le_right _ _))
  obtain ⟨M⟩ := mollifier_exists hr
  obtain ⟨hd,S,errors⟩ := hs hr (lt_min_iff.mp hsmall).1 M
  let D := C.D-2*r
  have width_lt : C.u+6*r < D := by dsimp [D]; linarith
  have dgt : P < D := by dsimp [D]; linarith [C.length_gt]
  have htab : S.witness.tableExcess ≤ W.tableExcess+ε := by
    have h := S.witness.tableExcess_le
    change S.witness.tableExcess ≤ W.tableExcess+e+4*r at h
    dsimp [e] at hre h
    linarith
  have hwin : S.witness.windowEnergy ≤ W.windowEnergy+ε := by
    have h := S.witness.windowEnergy_le
    change S.witness.windowEnergy ≤ W.windowEnergy+e at h
    dsimp [e] at h
    linarith
  let O := S.witness.withBudgets (W.tableExcess+ε) (W.windowEnergy+ε)
    (add_pos W.actual_costs_pos.1 hε) (add_pos W.actual_costs_pos.2 hε) htab hwin
  have index : 0 < S.witness.n := by rw [S.deterministic]; decide
  let i : Fin S.witness.n := ⟨0,index⟩
  obtain ⟨supA,l1A,supC⟩ := errors i
  have two : 2*e ≤ ε := by dsimp [e]; linarith
  refine ⟨⟨C.u+6*r,D,width_lt,dgt,hd,O,S.deterministic,S.symmetric,S.length,i,S.smooth_window i,S.smooth_table i,
    fun x => (supA x).trans two,l1A.trans two,fun x => (supC x).trans two,?_,?_⟩⟩
  · have h := (supA 0).trans two
    change |conv (S.witness.w i) (rev (S.witness.w i)) 0 - W.meanAutocorr 0| ≤ ε at h
    change |energy (S.witness.w i) - W.windowEnergy| ≤ ε
    simpa only [conv,rev,zero_sub,neg_neg,←sq,energy,W.meanAutocorr_zero_eq_windowEnergy] using h
  · have h := (S.table_contraction i).trans C.table_cost
    change energy (S.witness.t i) ≤ 2*C.D+(W.tableExcess+e) at h
    change energy (S.witness.t i)-2*(C.D-2*r) ≤ W.tableExcess+ε
    dsimp [e] at hre h
    linarith

def profileTolerance (n : ℕ) : ℝ := 1/((n:ℝ)+1)

theorem profileTolerance_pos (n : ℕ) : 0 < profileTolerance n := by unfold profileTolerance; positivity

theorem profileTolerance_zero : Tendsto profileTolerance atTop (𝓝 0) :=
  tendsto_one_div_add_atTop_nhds_zero_nat

namespace SmoothProfileWitness
variable {W : Witness v α β} {ε P : ℝ}

def autocorr (Q : SmoothProfileWitness W ε P) := conv (Q.witness.w Q.i) (rev (Q.witness.w Q.i))
def coverError (Q : SmoothProfileWitness W ε P) (x : ℝ) :=
  conv (Q.witness.w Q.i) (Q.witness.t Q.i) (x+Q.D)-W.reflectedCover Q.D Q.expands x
def windowNormSq (Q : SmoothProfileWitness W ε P) := energy (Q.witness.w Q.i)
def tableSurplus (Q : SmoothProfileWitness W ε P) := energy (Q.witness.t Q.i)-2*Q.D

theorem tableSurplus_pos (Q : SmoothProfileWitness W ε P) : 0 < Q.tableSurplus := by
  let O := Q.witness
  let i := Q.i
  have hi : Subsingleton (Fin O.n) := by change Subsingleton (Fin Q.witness.n); rw [Q.deterministic]; infer_instance
  have same (j : Fin O.n) : energy (O.t j) = energy (O.t i) :=
    congrArg (fun z => energy (O.t z)) (hi.elim j i)
  have h := O.actual_costs_pos.1
  simp only [Witness.tableExcess, expectation, same, ← Finset.sum_mul, O.total_weight, one_mul] at h
  simpa only [O, i, Q.length, tableSurplus] using h

end SmoothProfileWitness

structure SmoothProfileSequence (W : Witness v α β) where
  pair : ∀ n : ℕ, SmoothProfileWitness W (profileTolerance n) n
  growing : Tendsto (fun n => (pair n).D) atTop atTop
  autocorr_uniform : TendstoUniformly (fun n => (pair n).autocorr) W.meanAutocorr atTop
  autocorr_l1 : Tendsto (fun n => massAbs (fun x => (pair n).autocorr x-W.meanAutocorr x)) atTop (𝓝 0)
  covering_uniform : TendstoUniformly (fun n => (pair n).coverError) (fun _ => 0) atTop
  window_energy : Tendsto (fun n => (pair n).windowNormSq) atTop (𝓝 W.windowEnergy)
  table_energy : limsup (fun n => (pair n).tableSurplus) atTop ≤ W.tableExcess

/-- All three modes of convergence and both energy conclusions use one
sequence. The covering target changes with the actual half-length. -/
def SmoothProfileSequence.ofPairs (W : Witness v α β)
    (Q : ∀ n : ℕ, SmoothProfileWitness W (profileTolerance n) n) : SmoothProfileSequence W := by
  have ha (n : ℕ) (x : ℝ) : |(Q n).autocorr x-W.meanAutocorr x| ≤ profileTolerance n :=
    (Q n).auto_sup x
  have hc (n : ℕ) (x : ℝ) : |(Q n).coverError x| ≤ profileTolerance n := (Q n).cover_sup x
  have hn (n : ℕ) : |(Q n).windowNormSq-W.windowEnergy| ≤ profileTolerance n := (Q n).energy_error
  have htop := tendsto_atTop_mono (fun n => (Q n).length_gt.le) tendsto_natCast_atTop_atTop
  refine ⟨Q,htop,?_,?_,?_,?_,?_⟩
  · rw [Metric.tendstoUniformly_iff]
    intro e he
    filter_upwards [profileTolerance_zero.eventually_lt_const he] with n h
    intro x; rw [Real.dist_eq,abs_sub_comm]; exact (ha n x).trans_lt h
  · exact tendsto_of_tendsto_of_tendsto_of_le_of_le tendsto_const_nhds profileTolerance_zero
      (fun n => massAbs_nonneg _) (fun n => (Q n).auto_l1)
  · rw [Metric.tendstoUniformly_iff]
    intro e he
    filter_upwards [profileTolerance_zero.eventually_lt_const he] with n h
    intro x; simp only [Real.dist_eq,zero_sub,abs_neg]; exact (hc n x).trans_lt h
  · apply tendsto_iff_dist_tendsto_zero.mpr
    exact tendsto_of_tendsto_of_tendsto_of_le_of_le tendsto_const_nhds profileTolerance_zero
      (fun n => dist_nonneg) hn
  · have ht : Tendsto (fun n => W.tableExcess+profileTolerance n) atTop (𝓝 W.tableExcess) := by
      simpa only [add_zero] using tendsto_const_nhds.add profileTolerance_zero
    have hh := limsup_le_limsup (Eventually.of_forall (fun n => (Q n).table_error))
      (isCoboundedUnder_le_of_le atTop (fun n => (Q n).tableSurplus_pos.le)) ht.isBoundedUnder_le
    exact hh.trans_eq ht.limsup_eq

theorem Witness.profileSequence_of_realization (W : Witness v α β) (hreal : CenteredProfileRealization) :
    Nonempty (SmoothProfileSequence W) :=
  ⟨SmoothProfileSequence.ofPairs W (fun n =>
    (W.smoothProfile_of_realization hreal (profileTolerance_pos n) n).some)⟩

end
end MathLab.WT
