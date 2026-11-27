module

public import MathLab.LocalTransfer
public import MathLab.ScaleCells
public import Mathlib.NumberTheory.DiophantineApproximation.Basic

/-! Assembly of the replacement table into a global cover and verification of the designated 476-runner instance. -/

@[expose] public section

namespace MathLab.ScaleRule

def tracks (N : Nat) : List Entry :=
  (((List.range N).map (fun i => 2*(i+1))).filter (fun v => !changed.contains v)).map
    (fun v => (v,0,0)) ++ entries

noncomputable def phase (p : Entry) (d : ℝ) : ℝ := p.2.1 / 4 + p.2.2 / 4 * d
def installed (N : Nat) (d : ℝ) (v : Nat) (s : ℝ) : Prop :=
  ∃ e ∈ tracks N, e.1 = v ∧ phase e d = s

private theorem keep {N i : Nat} {d : ℝ} (lo : 1 ≤ i) (hi : i ≤ N)
    (h : 2*i ∉ changed) : installed N d (2*i) 0 := by
  refine ⟨(2*i,0,0), List.mem_append_left _ (List.mem_map.mpr ⟨2*i, ?_, rfl⟩), rfl, ?_⟩
  · apply List.mem_filter.mpr
    constructor
    · exact List.mem_map.mpr ⟨i-1, List.mem_range.mpr (by omega), by congr 1; omega⟩
    · simpa using h
  · simp [phase]

private theorem primitive_odd {i : Nat} {k : ℤ} (hi : 2*i ∈ changed)
    (hc : Nat.Coprime i k.natAbs) : k % 2 = 1 := by
  have all4 : changed.all (fun q => decide (q % 4 = 0)) = true := by decide
  have h4 : (2*i)%4 = 0 := of_decide_eq_true (List.all_eq_true.mp all4 _ hi)
  by_contra hn
  have hd : (2:ℤ) ∣ k := Int.dvd_of_emod_eq_zero (by omega)
  have hd' : 2 ∣ k.natAbs := Int.ofNat_dvd_left.mp hd
  have dv := Nat.dvd_gcd (show 2 ∣ i by omega) hd'
  rw [hc.gcd_eq_one] at dv
  omega

private theorem local_cover {N i : Nat} {d : ℝ} (hi : 2*i ∈ changed) :
    RunnerLocalTransfer.LocalAt (installed N d) d i := by
  intro k hc z hlo hhi
  have hk := primitive_odd hi hc
  let r := (k%4).toNat
  have hr : r = 1 ∨ r = 3 := by dsimp [r]; omega
  obtain ⟨p, hp, b, c, hstep, hbase, hw⟩ := serves (2*i) r hi hr z hlo hhi
  refine ⟨p.1, (p.2.1:ℝ)/4, (p.2.2:ℝ)/4, b*(k/4)+c,
    ⟨p, List.mem_append_right _ hp, rfl, rfl⟩, ?_, hw⟩
  let j := k/4
  have hz : k = 4*j + (r:ℤ) := by dsimp [j,r]; omega
  have hzR : (k:ℝ) = 4*(j:ℝ)+(r:ℝ) := by exact_mod_cast hz
  change (p.1:ℝ) * (k:ℝ) / ((2*i:Nat):ℝ) + (p.2.1:ℝ)/4 = ((b*j+c:ℤ):ℝ)
  push_cast only [Int.cast_add, Int.cast_mul]
  rw [hzR, ← hbase, ← hstep]
  ring

/-- Every real time is covered by the configuration, including both ends of each arc. -/
theorem covers (N : Nat) (hN : 0 < N) (t : ℝ) :
    RunnerLocalTransfer.FinalCovers (installed N (1/((N:ℝ)+1))) (1/((N:ℝ)+1)) t := by
  apply RunnerLocalTransfer.transfer (Changed := fun i => 2*i ∈ changed)
      (by positivity) (fun _ l h hc => keep l h hc) (fun _ _ _ hc => local_cover hc)
  obtain ⟨i, hi, hiN, h⟩ := Real.exists_nat_abs_mul_sub_round_le (2*t) hN
  refine ⟨i, hi, hiN, round ((i:ℝ)*(2*t)), ?_⟩
  push_cast
  rwa [show (2:ℝ)*i*t=i*(2*t) by ring]

/-- 476 distinct positive speeds at radius 1/481. -/
theorem certificate476 :
    (tracks 480).length = 476 ∧ ((tracks 480).map Prod.fst).Nodup ∧
    (∀ p ∈ tracks 480, 0 < p.1) ∧
    ∀ t : ℝ, ∃ p ∈ tracks 480, ∃ k : ℤ, |(p.1:ℝ)*t + phase p (1/481) - k| ≤ 1/481 := by
  refine ⟨by decide +kernel, by decide +kernel, ?_, ?_⟩
  · have h : (tracks 480).all (fun p => decide (0 < p.1)) = true := by decide +kernel
    simpa using h
  · intro t
    have h := covers 480 (by decide) t
    norm_num at h
    obtain ⟨_,_,k,⟨p,hp,rfl,rfl⟩,hk⟩ := h
    exact ⟨p,hp,k,hk⟩

end MathLab.ScaleRule
