module
public import MathLab.WT.Derandomization
public import MathLab.WT.SmoothPair
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Smooth, compactly supported deterministic symmetric WT witnesses for
each error tolerance of each finite input law, including minimal table length. -/
@[expose] public section
namespace MathLab.WT

open MeasureTheory Set
open scoped ContDiff
noncomputable section

def Witness.SmoothCompact {v α β : ℝ} (W : Witness v α β) : Prop :=
  ∀ i, (ContDiff ℝ ∞ (W.w i) ∧ HasCompactSupport (W.w i)) ∧
    (ContDiff ℝ ∞ (W.t i) ∧ HasCompactSupport (W.t i))

private theorem one_atom {v α β : ℝ} (W : Witness v α β) (hd : W.Deterministic) :
    ∃ i : Fin W.n, ∀ f : Fin W.n → ℝ, expectation W.p f = f i := by
  have hn : W.n = 1 := hd
  let i : Fin W.n := ⟨0,by omega⟩
  have unique (j : Fin W.n) : j = i := by
    apply Fin.ext
    have hz := j.isLt
    change j.val = 0
    omega
  refine ⟨i,?_⟩
  intro f
  calc
    _ = ∑ j, W.p j * f i := by
      unfold expectation
      apply Finset.sum_congr rfl
      intro j _
      rw [unique j]
    _ = _ := by rw [← Finset.sum_mul,W.total_weight,one_mul]

/-- Extending first by `16r` creates exactly the margin needed by the
two-sided smoothing operation even when the initial length is `2v`.
Taking the even part of the extended table also handles its endpoint values. -/
theorem Witness.smooth_with_slack {v α β r : ℝ} (W : Witness v α β)
    (hd : W.Deterministic) (hs : W.Symmetric) (hr : 0 < r) {γ : ℝ} (hγ : β ≤ γ) :
    ∃ U : Witness (v+6*r) (α+4*r) γ, U.Deterministic ∧ U.Symmetric ∧ U.SmoothCompact := by
  let X := W.extend (16*r) (by positivity)
  let D := X.σ/2
  have ex : X.σ = W.σ+16*r := rfl
  have hD : v+8*r ≤ D := by dsimp [D]; rw [ex]; linarith [W.width_le]
  obtain ⟨i,ea⟩ := one_atom X (show X.Deterministic from hd)
  let w := X.centerWindow i
  let t := X.centerTable i
  have wr : Regular w := (X.window_regular i).shift _
  have tr : Regular t := (X.table_regular i).shift _
  have we (x : ℝ) : w (-x) = w x := by
    change W.w i (-x-(-v/2)) = W.w i (x-(-v/2))
    rw [show -x-(-v/2) = v-(x-(-v/2)) by ring]
    exact (hs i _).1
  have ws (x : ℝ) (hx : v/2 < |x|) : w x = 0 := by
    by_contra h
    obtain ⟨h₁,h₂⟩ := X.center_window_support i h
    rcases lt_abs.mp hx with h | h <;> linarith
  have t0 (x : ℝ) (hx : D+v/2 < |x|) : t x = 0 := by
    by_contra h
    obtain ⟨h₁,h₂⟩ := X.center_table_support i h
    change X.σ/2+v/2 < |x| at hx
    rcases lt_abs.mp hx with h | h <;> linarith
  have ts (x : ℝ) (hx : D+v/2 < |x|) : evenPart t x = 0 := by
    simp [evenPart,t0 x hx,t0 (-x) (by simpa only [abs_neg] using hx)]
  have tp (x : ℝ) (hx : |x| < D-v/2) : evenPart t x = 1 := by
    have hp (y : ℝ) (hy : |y| < D-v/2) : t y = 1 := X.center_plateau i hy
    rw [evenPart,hp x hx,hp (-x) (by simpa only [abs_neg] using hx)]
    norm_num
  have wm : (∫ x, w x) = 1 := (integral_shift _ (X.w i)).trans (X.mass i)
  have wc : energy w ≤ γ := by
    have e := X.window_cost
    rw [ea] at e
    exact (energy_shift _ (X.w i)).le.trans (e.trans hγ)
  have tc : energy (evenPart t) ≤ 2*D+α := by
    have e := X.table_cost
    rw [ea] at e
    have en : energy t = energy (X.t i) := energy_shift _ _
    dsimp [D]
    linarith [energy_evenPart tr]
  have ac (x : ℝ) : 0 ≤ conv w w x := by
    have h := X.autocorrelation x
    rw [ea] at h
    have hw : conv w (rev w) x = conv (X.w i) (rev (X.w i)) x := autocorr_shift _ _ _
    rwa [← hw, show rev w=w from funext we] at h
  have cov (x : ℝ) (hx : |x| < D) : 1 ≤ conv w (evenPart t) x := by
    have raw (y : ℝ) (hy : |y| < D) : 1 ≤ conv w t y := by
      obtain ⟨h₁,h₂⟩ := abs_lt.mp hy
      have h := X.center_cover y (show y ∈ Ioo (-X.σ/2) (X.σ/2) from
        ⟨by dsimp [D] at h₁; linarith, h₂⟩)
      rw [ea] at h
      exact h
    rw [conv_evenPart wr.1 we tr x]
    linarith [raw x hx,raw (-x) (by simpa only [abs_neg] using hx)]
  obtain ⟨M⟩ := mollifier_exists hr
  obtain ⟨S⟩ := M.smooth_pair hr W.width_pos hD W.alpha_pos (W.beta_pos.trans_le hγ) wr
    (evenPart_regular tr) ws ts tp wm wc tc we (evenPart_even t) ac cov
  exact ⟨S.witness,S.deterministic,S.symmetric,fun j => ⟨S.smooth_window j,S.smooth_table j⟩⟩

/-- Both enlarged costs belong to the same smooth compactly supported pair. -/
theorem smooth_simultaneous_approximation (v α β : ℝ) (W : Witness v α β) {ε : ℝ} (hε : 0 < ε) :
    ∃ (v' : ℝ) (U : Witness v' (α+ε) (β+ε)), U.Deterministic ∧ U.Symmetric ∧ U.SmoothCompact := by
  obtain ⟨v',U,hd,hs⟩ := simultaneous_approximation v α β W (ε/2) (by linarith)
  have h := U.smooth_with_slack hd hs (r:=ε/8) (by linarith)
    (show β+ε/2 ≤ β+ε by linarith)
  rw [show α+ε/2+4*(ε/8) = α+ε by ring] at h
  exact ⟨_,h⟩

/-- Objective values of one atom whose window and table are both symmetric,
smooth, and compactly supported. -/
def smoothValues : Set ℝ :=
  {x | ∃ (v α β : ℝ) (W : Witness v α β),
    W.Deterministic ∧ W.Symmetric ∧ W.SmoothCompact ∧ x = objective α β}

theorem smooth_infimum_eq : sInf smoothValues = infimum .unrestricted := by
  apply sInf_eq_of_approx_values
  · rintro _ ⟨v,α,β,W,_,_,_,rfl⟩
    exact ⟨v,α,β,W,trivial,rfl⟩
  · intro v α β W ε hε
    obtain ⟨v',U,hd,hs,hc⟩ := smooth_simultaneous_approximation v α β W hε
    exact ⟨v',_,_,U,hd,hs,hc,rfl⟩

end
end MathLab.WT
