module

public import MathLab.PhaseNeighbourhood.Sharpness
public import MathLab.PhaseNeighbourhood.Tube
public import Mathlib.Topology.Defs.Basic
public import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Topology.Order.Compact
import Mathlib.Topology.Order.Lattice
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

@[expose] public section

namespace MathLab.PhaseNeighbourhood

theorem continuous_circleDist : Continuous circleDist := by
  apply continuous_iff_continuousAt.mpr
  intro x
  apply Metric.continuousAt_iff.mpr
  intro ε hε
  refine ⟨ε,hε,?_⟩
  intro y hy
  rw [Real.dist_eq] at hy ⊢
  have hxy := circleDist_le_add_abs x (y-x)
  have hyx := circleDist_le_add_abs y (x-y)
  rw [show x+(y-x) = y by ring] at hxy
  rw [show y+(x-y) = x by ring, abs_sub_comm x y] at hyx
  apply abs_lt.mpr
  constructor <;> linarith only [hxy,hyx,hy]

private theorem phase_point_representative (t : ℝ) :
    ∃ w ∈ Set.Icc (0 : ℝ) 1, ∃ z : ℤ, t = w + (z : ℝ) := by
  let z := ⌊t⌋
  let w := Int.fract t
  refine ⟨w,⟨Int.fract_nonneg t, (Int.fract_lt_one t).le⟩,z,?_⟩
  exact (Int.fract_add_floor t).symm

/-- The supremum over real times equals a maximum over one turn. -/
theorem loneliness_attained {p : ℕ} (hp : 1 < p) (u : ℕ → ℝ) :
    ∃ t ∈ Set.Icc (0 : ℝ) 1, loneliness hp u = gap hp u t := by
  have hc : Continuous (gap hp u) := by
    unfold gap
    apply Continuous.finset_inf'_apply
    intro i _
    exact continuous_circleDist.comp ((continuous_const.mul continuous_id).add continuous_const)
  obtain ⟨a,ha,hmax⟩ := isCompact_Icc.exists_isMaxOn
    (show (Set.Icc (0 : ℝ) 1).Nonempty from ⟨0,by simp⟩) hc.continuousOn
  refine ⟨a,ha,le_antisymm ?_ (gap_le_loneliness hp u a)⟩
  apply loneliness_le hp
  intro t
  obtain ⟨w,hw,z,rfl⟩ := phase_point_representative t
  rw [gap_add_int]
  exact hmax hw

private theorem farthestGap_add_int {p : ℕ} (hp : 1 < p) (u : ℕ → ℝ) (t : ℝ) (z : ℤ) :
    farthestGap hp u (t + (z : ℝ)) = farthestGap hp u t := by
  unfold farthestGap
  apply Finset.sup'_congr _ rfl
  intro j _
  have he : (j : ℝ)*(t + (z : ℝ))+u j =
      (j : ℝ)*t+u j+(((j : ℤ)*z : ℤ) : ℝ) := by push_cast; ring
  rw [he,circleDist_add_int]

theorem phaseRadius_attained {p : ℕ} (hp : 1 < p) (u : ℕ → ℝ) :
    ∃ t ∈ Set.Icc (0 : ℝ) 1, phaseRadius hp u = farthestGap hp u t := by
  have hc : Continuous (farthestGap hp u) := by
    unfold farthestGap
    apply Continuous.finset_sup'_apply
    intro i _
    exact continuous_circleDist.comp ((continuous_const.mul continuous_id).add continuous_const)
  obtain ⟨a,ha,hmin⟩ := isCompact_Icc.exists_isMinOn
    (show (Set.Icc (0 : ℝ) 1).Nonempty from ⟨0,by simp⟩) hc.continuousOn
  refine ⟨a,ha,le_antisymm ?_ ?_⟩
  · unfold phaseRadius
    apply csInf_le ?_ (Set.mem_range_self a)
    refine ⟨0,?_⟩
    rintro _ ⟨x,rfl⟩
    have hi : 1 ∈ speeds p := Finset.mem_Ioo.mpr ⟨by decide,hp⟩
    exact (abs_nonneg _).trans (Finset.le_sup' (fun j : ℕ => circleDist ((j : ℝ)*x+u j)) hi)
  · unfold phaseRadius
    apply le_csInf (Set.range_nonempty _)
    rintro _ ⟨t,rfl⟩
    obtain ⟨w,hw,z,rfl⟩ := phase_point_representative t
    rw [farthestGap_add_int]
    exact hmin hw

/-- The paper's formulation of the closed tube bound in terms of the
distance to the common-start orbit. -/
theorem odd_order_phase_tube {p : ℕ} (hp : 7 ≤ p) (hpr : p.Prime)
    (ho : Odd (twoOrderModuloSign p)) (u : ℕ → ℝ)
    (hr : phaseRadius (show 1 < p by omega) u ≤ tubeRadius p) :
    1/(p : ℝ) ≤ loneliness (show 1 < p by omega) u := by
  have hp1 : 1 < p := by omega
  obtain ⟨t,_,ht⟩ := phaseRadius_attained hp1 u
  rw [ht] at hr
  apply loneliness_widerTube_of_odd_order hp hpr ho u
  refine ⟨t,?_⟩
  intro j hj0 hj
  have hmem : j ∈ speeds p := Finset.mem_Ioo.mpr ⟨hj0,hj⟩
  rw [add_comm (u j)]
  exact (Finset.le_sup' (fun i : ℕ => circleDist ((i : ℝ)*t+u i)) hmem).trans hr

/-- The half-index version of the maximum used in the paper. -/
theorem maxForm_eq_small {p : ℕ} (hp : 7 ≤ p) (hodd : Odd p) (u : ℕ → ℝ) :
    maxForm (show 1 < p by omega) u =
      ((speeds p).filter (fun j => 2*j < p)).sup'
        (show ((speeds p).filter (fun j => 2*j < p)).Nonempty from
          ⟨1,Finset.mem_filter.mpr ⟨Finset.mem_Ioo.mpr ⟨by decide,by omega⟩,by omega⟩⟩)
        (fun j => |pairForm p u j|) := by
  apply le_antisymm
  · apply Finset.sup'_le _ _
    intro j hj
    by_cases hs : 2*j < p
    · have hmem : j ∈ (speeds p).filter (fun k : ℕ => 2*k < p) :=
        Finset.mem_filter.mpr ⟨hj,hs⟩
      exact Finset.le_sup' (fun k : ℕ => |pairForm p u k|) hmem
    · have hmem := Finset.mem_Ioo.mp hj
      obtain ⟨a,ha⟩ := hodd
      have hm : p-j ∈ (speeds p).filter (fun j => 2*j < p) := by
        refine Finset.mem_filter.mpr ⟨Finset.mem_Ioo.mpr ⟨by omega,by omega⟩,?_⟩
        omega
      have hb := Finset.le_sup' (fun k => |pairForm p u k|) hm
      rw [pairForm_complement hmem.2.le,abs_neg] at hb
      exact hb
  · apply Finset.sup'_le _ _
    intro j hj
    exact le_maxForm _ _ (Finset.mem_filter.mp hj).1

end MathLab.PhaseNeighbourhood
