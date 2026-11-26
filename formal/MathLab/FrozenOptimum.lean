module

public import MathLab.FrozenCells
public import MathLab.FrozenSieve
public import MathLab.FrozenUpper
public import MathLab.Witness

@[expose] public section

namespace MathLab.Frozen

private theorem tpos : (0 : ℝ) < T := by norm_num [T]

private theorem unscale {z : ℝ} (h : Outside T r (z * T)) (k : ℤ) :
    radius ≤ |z - k| := by
  have hR : radius * (T : ℝ) = r := by norm_num [radius, T, r]
  apply le_of_mul_le_mul_right _ tpos
  calc
    _ = (r : ℝ) := hR
    _ ≤ |(z-k) * (T : ℝ)| := by rw [sub_mul]; exact h k
    _ = _ := by rw [abs_mul, abs_of_pos tpos]

/-- All positive integer speeds and all real phases for the added track. -/
theorem frozen_lower (v : ℕ) (hv : 0 < v) (s : ℝ) :
    ∃ t ∈ Set.Icc (0 : ℝ) 1,
      (∀ p ∈ seed, ∀ k : ℤ, radius ≤ |position p t - k|) ∧
      ∀ k : ℤ, radius ≤ |(v : ℝ) * t + s - k| := by
  obtain ⟨u, hu, huT, hseed, hnew⟩ := universal_lower T r gapLo gapHi maxSpeed
    (seed.map liftTrack) pairs (by decide) (by decide) (by decide) (by decide)
    (by decide) gap_cells point_cells separated_for_each_speed v hv (s * T)
  refine ⟨u / T, ⟨div_nonneg hu tpos.le, (div_le_one tpos).mpr huT⟩, ?_, ?_⟩
  · intro p hp k
    apply unscale (k := k)
    have h := hseed (liftTrack p) (List.mem_map.mpr ⟨p, hp, rfl⟩)
    have hf : ((T / S : ℕ) : ℝ) * S = T := by norm_num [T, S]
    have hs : (0 : ℝ) < S := by norm_num [S]
    have he : position p (u / T) * T =
        ((liftTrack p).1 : ℝ) * u + (liftTrack p).2 := by
      simp only [position, liftTrack, Nat.cast_mul]
      field_simp [tpos.ne', hs.ne']
      nlinarith only [congrArg (fun x : ℝ => (p.2 : ℝ) * x) hf]
    rwa [he]
  · intro k
    apply unscale (k := k)
    have he : ((v : ℝ) * (u / T) + s) * T = v * u + s * T := by
      field_simp [tpos.ne'] <;> ring
    rwa [he]

/-- Exactly the radii admitting a 58th track, with the 57 published tracks fixed. -/
theorem frozen_optimum (d : ℝ) :
    (∃ v : ℕ, 0 < v ∧ v ∉ seed.map Prod.fst ∧ ∃ s : ℝ,
      ∀ t ∈ Set.Icc (0 : ℝ) 1,
        (∃ p ∈ seed, ∃ k : ℤ, |position p t - k| ≤ d) ∨
        ∃ k : ℤ, |(v : ℝ) * t + s - k| ≤ d) ↔ radius ≤ d := by
  constructor
  · rintro ⟨v, hv, _, s, hc⟩
    obtain ⟨t, ht, hb, he⟩ := frozen_lower v hv s
    rcases hc t ht with ⟨p,hp,k,hk⟩ | ⟨k,hk⟩
    · exact (hb p hp k).trans hk
    · exact (he k).trans hk
  · intro hd
    refine ⟨extra.1, by decide, by decide, (extra.2 : ℝ) / S, ?_⟩
    intro t ht
    obtain ⟨p,hp,k,hk⟩ := frozen_upper t ht.1 ht.2
    rcases List.mem_append.mp hp with h | h
    · exact Or.inl ⟨p,h,k,hk.trans hd⟩
    · obtain rfl := List.mem_singleton.mp h
      exact Or.inr ⟨k,hk.trans hd⟩

end MathLab.Frozen
