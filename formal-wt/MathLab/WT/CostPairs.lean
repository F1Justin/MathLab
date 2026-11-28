module
public import MathLab.WT.MatchedProfiles
public import MathLab.WT.SmoothCorollary

/-! The joint attainable costs in the Euclidean plane, in the order
(table surplus, window energy). -/
@[expose] public section
namespace MathLab.WT
open Set Filter
open scoped Topology
noncomputable section

def actualCostPairs : Set (ℝ × ℝ) :=
  {z | ∃ (v α β : ℝ) (W : Witness v α β), z = (W.tableExcess,W.windowEnergy)}

def smoothSymmetricCostPairs : Set (ℝ × ℝ) :=
  {z | ∃ (v α β : ℝ) (W : Witness v α β), W.Deterministic ∧ W.Symmetric ∧
    W.SmoothCompact ∧ z = (W.tableExcess,W.windowEnergy)}

theorem cost_pair_closures_of_matched
    (hall : ∀ {v α β : ℝ} (W : Witness v α β), Nonempty (MatchedProfileSequence W)) :
    closure actualCostPairs = closure smoothSymmetricCostPairs := by
  apply le_antisymm
  · apply closure_minimal _ isClosed_closure
    rintro _ ⟨v,α,β,W,rfl⟩
    obtain ⟨S⟩ := hall W
    apply mem_closure_of_tendsto (S.table_energy_tendsto.prodMk_nhds S.sequence.window_energy)
    apply Eventually.of_forall
    intro n
    let Q := S.sequence.pair n
    have one : Subsingleton (Fin Q.witness.n) := by rw [Q.deterministic]; infer_instance
    have sm : Q.witness.SmoothCompact := by
      intro j
      rw [one.elim j Q.i]
      exact ⟨Q.smooth_window,Q.smooth_table⟩
    have ev (f : Fin Q.witness.n → ℝ) : expectation Q.witness.p f = f Q.i := calc
      _ = ∑ j, Q.witness.p j * f Q.i := by
        apply Finset.sum_congr rfl
        intro j _
        exact congrArg (Q.witness.p j * ·) (congrArg f (one.elim j Q.i))
      _ = _ := by rw [← Finset.sum_mul,Q.witness.total_weight,one_mul]
    refine ⟨Q.width,_,_,Q.witness,Q.deterministic,Q.symmetric,sm,?_⟩
    change (Q.tableSurplus,Q.windowNormSq) = (Q.witness.tableExcess,Q.witness.windowEnergy)
    apply Prod.ext
    · change energy (Q.witness.t Q.i)-2*Q.D = expectation Q.witness.p (fun j => energy (Q.witness.t j))-Q.witness.σ
      rw [ev,Q.length]
    · change energy (Q.witness.w Q.i) = expectation Q.witness.p (fun j => energy (Q.witness.w j))
      rw [ev]
  · apply closure_mono
    rintro z ⟨v,α,β,W,_,_,_,hz⟩
    exact ⟨v,α,β,W,hz⟩

#print axioms cost_pair_closures_of_matched
end
end MathLab.WT
