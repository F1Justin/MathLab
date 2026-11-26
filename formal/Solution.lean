module

public import MathLab.FrozenStability
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Tactic.Ring

public section

namespace MathLab.Frozen

private theorem periodic_cover {d s : ℝ} {v : ℕ}
    (h : ∀ t ∈ Set.Icc (0 : ℝ) 1,
      (∃ p ∈ seed, ∃ k : ℤ, |position p t - k| ≤ d) ∨
      ∃ k : ℤ, |(v : ℝ) * t + s - k| ≤ d) (t : ℝ) :
    (∃ p ∈ seed, ∃ k : ℤ, |position p t - k| ≤ d) ∨
    ∃ k : ℤ, |(v : ℝ) * t + s - k| ≤ d := by
  let u := Int.fract t
  have hu : u ∈ Set.Icc (0 : ℝ) 1 :=
    ⟨Int.fract_nonneg t, (Int.fract_lt_one t).le⟩
  have shift (w : ℕ) (a : ℝ) (k : ℤ) :
      (w : ℝ) * t + a - ((k + (w : ℤ) * ⌊t⌋ : ℤ) : ℝ) = (w : ℝ) * u + a - k := by
    simp only [Int.cast_add, Int.cast_mul, Int.cast_natCast, u, Int.fract]
    ring
  rcases h u hu with ⟨p, hp, k, hk⟩ | ⟨k, hk⟩
  · exact Or.inl ⟨p, hp, k + (p.1 : ℤ) * ⌊t⌋, by simpa only [position, shift] using hk⟩
  · exact Or.inr ⟨k + (v : ℤ) * ⌊t⌋, by rwa [shift]⟩

/-- The audited configuration has 57 distinct positive integer speeds. -/
theorem seed_parameters :
    seed.length = 57 ∧ (seed.map Prod.fst).Nodup ∧ ∀ p ∈ seed, 0 < p.1 := by
  have positive : seed.all (fun p => decide (0 < p.1)) = true := by decide
  exact ⟨by decide, by decide, fun p hp => of_decide_eq_true (List.all_eq_true.mp positive p hp)⟩

/-- The radii attainable by adjoining one track of distinct positive integer speed and
arbitrary real phase to the fixed configuration are exactly those at least
`1359451 / 79000000`. The coverage condition quantifies over all real times. -/
theorem optimum_on_circle (d : ℝ) :
    (∃ v : ℕ, 0 < v ∧ v ∉ seed.map Prod.fst ∧ ∃ s : ℝ, ∀ t : ℝ,
      (∃ p ∈ seed, ∃ k : ℤ, |position p t - k| ≤ d) ∨
      ∃ k : ℤ, |(v : ℝ) * t + s - k| ≤ d) ↔ 1359451 / 79000000 ≤ d := by
  change _ ↔ radius ≤ d
  constructor
  · rintro ⟨v, hv, hnew, s, hc⟩
    exact (frozen_optimum d).1 ⟨v, hv, hnew, s, fun t _ => hc t⟩
  · intro hd
    obtain ⟨v, hv, hnew, s, hc⟩ := (frozen_optimum d).2 hd
    exact ⟨v, hv, hnew, s, periodic_cover hc⟩

/-- Adding speed `528344` with phase `4737613 / 31600000` attains the optimal radius. -/
theorem attained_by :
    (528344 : ℕ) ∉ seed.map Prod.fst ∧ ∀ t : ℝ,
      (∃ p ∈ seed, ∃ k : ℤ, |position p t - k| ≤ 1359451 / 79000000) ∨
      ∃ k : ℤ, |(528344 : ℝ) * t + 4737613 / 31600000 - k| ≤ 1359451 / 79000000 := by
  refine ⟨by decide, ?_⟩
  have coverAtRadius (t : ℝ) (ht : t ∈ Set.Icc (0 : ℝ) 1) :
      (∃ p ∈ seed, ∃ k : ℤ, |position p t - k| ≤ radius) ∨
      ∃ k : ℤ, |(extra.1 : ℝ) * t + (extra.2 : ℝ) / S - k| ≤ radius := by
    obtain ⟨p, hp, k, hk⟩ := frozen_upper t ht.1 ht.2
    rcases List.mem_append.mp hp with h | h
    · exact Or.inl ⟨p, h, k, hk⟩
    · obtain rfl := List.mem_singleton.mp h
      exact Or.inr ⟨k, hk⟩
  simpa only [radius, extra_parameters.1, extra_parameters.2, Nat.cast_ofNat] using
    periodic_cover coverAtRadius

/-- Keep the original speeds and move each original phase at most
`1207609 / 4661000000` turns modulo integers. For every positive integer extra
speed and every real extra phase, there is a time when every track is at
distance at least `1 / 59` from the nearest integer. -/
theorem barrier_under_perturbations (b : {p : Nat × Nat // p ∈ seed} → ℝ)
    (h : ∀ i, ∃ m : ℤ, (|((i.val.2 : ℝ) / S) - b i - m| : ℝ) ≤
      1207609 / 4661000000) :
    ∀ v : ℕ, 0 < v → ∀ s : ℝ, ∃ t ∈ Set.Icc (0 : ℝ) 1,
      (∀ i, ∀ k : ℤ, (1 : ℝ) / 59 ≤ |(i.val.1 : ℝ) * t + b i - k|) ∧
      ∀ k : ℤ, (1 : ℝ) / 59 ≤ |(v : ℝ) * t + s - k| := by
  intro v hv s
  obtain ⟨t, ht0, ht1, hb, hn⟩ := perturbation_barrier b h v hv s
  exact ⟨t, ⟨ht0, ht1⟩, hb, hn⟩

end MathLab.Frozen
