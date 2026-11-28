module
public import MathLab.WT.CenteredProfiles
public import MathLab.WT.ProfileNorms
public import MathLab.WT.WindowCompact
public import MathLab.WT.FinalTable
public import MathLab.WT.ErrorRates
import Mathlib.Tactic.Linarith

/-! One deterministic even window and one even table approximate both cost
budgets of the same arbitrary finite joint WT law. All constants for the
input Fourier filters are fixed before the output width is selected. -/
@[expose] public section
namespace MathLab.WT
open MeasureTheory Set Filter ErrorRates
open scoped Topology
noncomputable section

set_option maxHeartbeats 1600000 in
/-- A single continuous even pair, before final joint smoothing. The length
can exceed an arbitrary prescribed threshold. All estimates hold for this
pair, with the covering error measured at its actual half-length. -/
theorem centered_profile_realization (v α β : ℝ) (W : Witness v α β) {ε : ℝ}
    (hε : 0 < ε) (P : ℝ) : Nonempty (CenteredProfiles W ε P) := by
  let ζ := ε/8
  have hζ : 0 < ζ := by dsimp [ζ]; positivity
  obtain ⟨δ,hδ,hδζ,⟨F⟩⟩ := W.profileFilters hζ
  obtain ⟨C,hC,hVs⟩ := Window.compact_schwartz_window_profiles F.s F.even F.mass F.nonneg
  let K := (∑ i, massAbs (F.k i)) * F.B
  let Q := ∑ i, momentTwo (F.k i)
  let Z := massAbs F.s+1
  have hB : 0 ≤ F.B := zero_le_one.trans F.bound_one
  have hK : 0 ≤ K := mul_nonneg (Finset.sum_nonneg fun i _ => massAbs_nonneg _) hB
  have hQ : 0 ≤ Q := Finset.sum_nonneg fun i _ => momentTwo_nonneg _
  have hZ : 0 ≤ Z := by dsimp [Z]; linarith [massAbs_nonneg F.s]
  let τ := min ζ 1
  have hτ : 0 < τ := lt_min hζ zero_lt_one
  have hτζ : τ ≤ ζ := min_le_left ..
  have hτ₁ : τ ≤ 1 := min_le_right ..
  have hrates := eventually_joint C F.B Z K Q 1
    (max (W.σ/2) (P+1)+2*δ) (max (v/2) δ) τ hτ
  have hprod : Tendsto (fun n => windowError C n*(Z+massAbs F.s)) atTop (𝓝 0) := by
    simpa only [zero_mul] using (windowError_zero C).mul_const (Z+massAbs F.s)
  have hsmall := (deficit_zero C F.B Z K Q).eventually_lt_const hζ
  obtain ⟨n,⟨⟨⟨hn,hLmin,hr,hwe,hte⟩,hdsmall⟩,hprodsmall⟩,V,hVc,hVcompact,hVsupp,
    hVe,hVm,hVa,hVerr,hVE,hVauto⟩ :=
    (((hrates.and hsmall).and (hprod.eventually_lt_const hζ)).and hVs).exists
  let M := radius n
  let L := halfLength n
  let D := L-2*δ
  have hbase : W.σ/2 < D := by dsimp [D,L]; linarith only [hLmin,le_max_left (W.σ/2) (P+1)]
  have hmin : P+1 < D := by dsimp [D,L]; linarith only [hLmin,le_max_right (W.σ/2) (P+1)]
  have hL : W.σ/2 < L := by dsimp [D] at hbase; linarith only [hbase,hδ]
  have hM : 0 < M := by dsimp [M,radius]; nlinarith [sq_nonneg (n-1)]
  have hL0 : 0 ≤ L := by change 0 ≤ 50*M; positivity
  have hvM : v/2 ≤ M/8 := (le_max_left _ _).trans hr.le
  have hδM : δ ≤ M/8 := (le_max_right _ _).trans hr.le
  have hlen : 12*M ≤ D := by change 12*M ≤ 50*M-2*δ; linarith
  have hD : D ≤ L := by dsimp [D]; linarith
  have hgap : L-D ≤ M := by dsimp [D]; linarith
  have hVin := regular_of_continuous_compact hVc hVcompact
  have hwe₀ : 0 ≤ windowError C n := by unfold windowError; positivity
  have hdist : massAbs (fun x => V x-F.s x) ≤ windowError C n := hVerr
  have hVZ : massAbs V ≤ Z := by
    have hh := massAbs_by_difference hVin.1 F.s.integrable
    dsimp [Z]
    linarith only [hh,hdist,hwe,hτ₁]
  let t := W.inputTable L hL.le
  let U := filterSum F.k t
  let T₀ := clipTable L (M/4) U
  let e := clipError F.B Q n
  let d := deficit C F.B Z K Q n
  have hrT (i) : Regular (t i) := W.inputTable_regular L hL.le i
  have hbT (i) (x : ℝ) : |t i x| ≤ F.B := F.table_bound L hL.le i x
  have hUr : Regular U := filterSum_regular F.k t (fun i => (hrT i).1) hbT
  have hUK (x : ℝ) : |U x| ≤ K := filterSum_bound F.k t hbT x
  have hT₀ := clipTable_regular (L := L) (R := M/4) hUr
  have hKK (x : ℝ) : |T₀ x| ≤ max 1 K := by
    dsimp [T₀,clipTable]
    split_ifs
    · simp
    · exact (hUK x).trans (le_max_right ..)
    · simp only [abs_zero]; exact hK.trans (le_max_right ..)
  have he₀ : 0 ≤ e := by dsimp [e,clipError]; positivity
  have hd₀ : 0 ≤ d := by
    change 0 ≤ Z*e + windowError C n*K
    positivity
  obtain ⟨hin,hout⟩ := filterSum_shoulders F.k t hrT F.k_mass hM hvM hB hbT
    (W.inputTable_plateau L hL.le) (W.inputTable_support L hL.le)
  have hclip : ∀ x, |T₀ x-U x| ≤ e := clipTable_error he₀ hin hout
  have herr (x : ℝ) : |conv V T₀ x-conv F.s U x| ≤ d := by
    apply (conv_perturbation F.s.integrable hVin.1 hUr hT₀ hUK hclip x).trans
    exact add_le_add (mul_le_mul_of_nonneg_right hVZ he₀) (mul_le_mul_of_nonneg_right hdist hK)
  have hdef (x : ℝ) (hx : |x| < D) : 1-conv V T₀ x ≤ d := by
    have lower := (abs_le.mp (herr x)).1
    linarith only [lower,F.cover L hL.le x hx]
  obtain ⟨T,hTr,hTe,hTo,hTp,hTcv,hTen,hTprofile⟩ := patch_table_profiles hVc hVcompact hT₀ hM hlen hD hgap
    hVsupp hVe hVm hVa hVZ hKK (fun x hx => by simp [clipTable,hx])
    (fun x hx => clipTable_zero (by positivity) hx) hd₀ hdef
  have hclipCost := clipTable_energy hUr hL0 (by positivity : 0 ≤ M/4) he₀ hin
  have henergy : energy U ≤ 2*L+α := F.table_cost L hL.le
  have hTenergy : energy T ≤ 2*D+(α+ε) := by
    change 2*L*(2*e)+2*(L+5*M)*(2*(max 1 K)*(d*Z)+(d*Z)^2) < τ at hte
    change energy T₀ ≤ energy U + 2*L*(2*e) at hclipCost
    change energy T ≤ energy T₀ + 2*(L+5*M)*(2*(max 1 K)*(d*Z)+(d*Z)^2) at hTen
    change energy T ≤ 2*(L-2*δ)+(α+ε)
    dsimp [ζ] at hτζ hδζ
    linarith only [hTen,hclipCost,henergy,hte,hτζ,hδζ,hε]
  have hWenergy : energy V ≤ β+ε := by
    change energy V ≤ energy F.s + windowError C n at hVE
    have h := F.window_cost
    dsimp [ζ] at h hτζ
    linarith only [hVE,h,hwe,hτζ,hε]
  have hVV := hVin.1.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) hVin.1
  have hss : Integrable (conv F.s F.s) :=
    F.s.integrable.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) F.s.integrable
  have hsR : Regular F.s := ⟨F.s.integrable,_,SchwartzMap.norm_le_seminorm ℝ F.s⟩
  have hl₁ := (massAbs_conv_square_difference hVin hsR hdist).trans
    (mul_le_mul_of_nonneg_left (add_le_add hVZ (le_refl (massAbs F.s))) hwe₀)
  refine ⟨⟨12*M,D,V,T,by positivity,?_,hmin,hbase,hVin,hTr,?_,?_,?_,hVm,
    hWenergy,hTenergy,hVe,hTe,hVa,hTcv,?_,?_,?_⟩⟩
  · change 12*M < 50*M-2*δ
    linarith only [hδM,hM]
  · intro x hx
    exact hVsupp x (by change M < |x|; linarith)
  · intro x hx
    exact hTo x (by linarith)
  · intro x hx
    exact hTp x (by linarith)
  · intro x
    have ha : |conv V V x-conv F.s F.s x| ≤ windowError C n := hVauto x
    apply (abs_sub_le _ (conv F.s F.s x) _).trans
    have hh := F.auto_sup x
    dsimp [ζ] at hh hτζ
    linarith only [ha,hh,hwe,hτζ,hε]
  · apply (massAbs_sub_triangle (f:=conv V V) (g:=conv F.s F.s) hVV hss W.integrable_meanAutocorr).trans
    have hh : massAbs (fun x => conv F.s F.s x-W.meanAutocorr x) ≤ ζ := F.auto_l1
    dsimp [ζ] at hh hprodsmall
    linarith only [hl₁,hprodsmall,hh,hε]
  · intro x
    have hav : |evenPart (conv V T₀) x-evenPart (conv F.s U) x| ≤ d := by
      have hx := abs_le.mp (herr x)
      have hy := abs_le.mp (herr (-x))
      unfold evenPart
      exact abs_le.mpr ⟨by linarith only [hx.1,hy.1],by linarith only [hx.2,hy.2]⟩
    have hh : |evenPart (conv F.s U) x-W.reflectedCover D hbase.le x| ≤ ζ :=
      F.cover_sup L hL.le hbase.le x
    have h₁ := abs_sub_le (conv V T x) (evenPart (conv V T₀) x) (evenPart (conv F.s U) x)
    apply (abs_sub_le _ (evenPart (conv F.s U) x) _).trans
    change d < ζ at hdsmall
    dsimp [ζ] at hdsmall hh
    linarith only [h₁,hTprofile x,hav,hh,hdsmall,hε]

end
end MathLab.WT
