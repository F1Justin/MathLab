module

public import MathLab.NatChecker
public import MathLab.FrozenData

@[expose] public section

namespace MathLab.Frozen

set_option maxRecDepth 8192
set_option maxHeartbeats 0
set_option Elab.async false

private def firstPair : Nat × Nat :=
  (40825623915982436091961921950, 67085928399221587941199921950)

/-- The first pair differs by one eighth of a turn in time. Every velocity
with nonzero remainder modulo eight separates it by at least one eighth
of a turn in space. -/
private theorem first_pair_separates (v : Nat) (hv : v % 8 ≠ 0) :
    sepOK T r v firstPair = true := by
  let eighth : Nat := 26260304483239151849238000000
  have gap : firstPair.2 - firstPair.1 = eighth := by decide
  have scaled : T = 8 * eighth := by decide
  have ordered : firstPair.1 ≤ firstPair.2 := by decide
  have hlo : 1 ≤ v % 8 := Nat.one_le_iff_ne_zero.mpr hv
  have hhi : v % 8 ≤ 7 := Nat.le_of_lt_succ (Nat.mod_lt v (by decide : 0 < 8))
  have hr : 2 * r ≤ eighth := by decide
  simp only [sepOK, decide_eq_true_eq, gap, scaled, Nat.mul_mod_mul_right, ordered,
    true_and]
  constructor
  · have h := Nat.mul_le_mul_right eighth hlo
    rw [Nat.one_mul] at h
    exact Nat.le_trans hr h
  · calc
      _ ≤ 7 * eighth + eighth := Nat.add_le_add (Nat.mul_le_mul_right eighth hhi) hr
      _ = 8 * eighth := (Nat.succ_mul 7 eighth).symm

private structure ReducedPair where
  times : Nat × Nat
  numerator : Nat
  period : Nat
  scale : Nat
  minimum : Nat

/-- The fractional spatial displacement for speed `8*k` is obtained from
`k * numerator` modulo `period`, then scaled back to denominator `T`. -/
private def reducedPairs : List ReducedPair := [
  ⟨(53526143282672766590004229824, 68025517107498122154020369760), 2726193, 4937500, 42548341441197613122816, 169932⟩,
  ⟨(35988526187008986120192000000, 67085930932481383040976000000), 574304488, 484973291, 433183517040144000000, 16691075⟩,
  ⟨(75344977879052016945892416840, 102612699544874071606995132048), 266599633, 256750000, 818237335407646406208, 8836432⟩,
  ⟨(68025517191534770660832000000, 75344977503301647535680000000), 112728656, 404440861, 519439196490864000000, 13919432⟩,
  ⟨(35988526187008986120192000000, 158567356499274929335376000000), 240072136, 51431127, 4084733275743952000000, 1770079⟩
]

private def validPair (p : ReducedPair) : Bool :=
  decide (p.times ∈ pairs ∧ p.times.1 ≤ p.times.2 ∧
    8 * (p.times.2 - p.times.1) = p.numerator * p.scale ∧
    T = p.period * p.scale ∧ 2 * r ≤ p.minimum * p.scale)

private theorem reduced_pairs_valid : reducedPairs.all validPair = true := by decide

private def reducedSep (k : Nat) (p : ReducedPair) : Bool :=
  let m := (k * p.numerator) % p.period
  Nat.ble p.minimum m && Nat.ble (m + p.minimum) p.period

private theorem reduced_sep_sound (k : Nat) (p : ReducedPair)
    (hv : p ∈ reducedPairs) (hs : reducedSep k p = true) :
    ∃ xy ∈ pairs, sepOK T r (8*k) xy = true := by
  have data := List.all_eq_true.mp reduced_pairs_valid p hv
  have ⟨mem, ordered, gap, period, minimum⟩ := of_decide_eq_true data
  have scaled : (8*k) * (p.times.2 - p.times.1) = (k * p.numerator) * p.scale := by
    calc
      _ = k * (8 * (p.times.2 - p.times.1)) := by ac_rfl
      _ = (k * p.numerator) * p.scale := by rw [gap, Nat.mul_assoc]
  have residue : ((8*k) * (p.times.2 - p.times.1)) % T =
      ((k * p.numerator) % p.period) * p.scale := by
    rw [scaled, period, Nat.mul_mod_mul_right]
  simp only [reducedSep, Bool.and_eq_true, Nat.ble_eq] at hs
  have upper := Nat.mul_le_mul_right p.scale hs.2
  rw [Nat.add_mul] at upper
  refine ⟨p.times, mem, ?_⟩
  simp only [sepOK, decide_eq_true_eq, ordered, true_and, residue]
  exact ⟨Nat.le_trans minimum (Nat.mul_le_mul_right p.scale hs.1), by
    rw [period]
    exact Nat.le_trans (Nat.add_le_add_left minimum _) upper⟩

private def good (k : Nat) : Bool :=
  Nat.blt maxSpeed (8*k) || reducedPairs.any (reducedSep k)

private theorem join {a n : Nat} (h₁ : block good a n = true)
    (h₂ : block good (a + 2^n) n = true) : block good a (n+1) = true := by
  simp [block, h₁, h₂]

-- Small separate declarations bound the memory used in kernel reductions.
private theorem chunk0 : block good 1 10 = true := by decide +kernel
private theorem chunk1 : block good 1025 10 = true := by decide +kernel
private theorem chunk2 : block good 2049 10 = true := by decide +kernel
private theorem chunk3 : block good 3073 10 = true := by decide +kernel
private theorem chunk4 : block good 4097 10 = true := by decide +kernel
private theorem chunk5 : block good 5121 10 = true := by decide +kernel
private theorem chunk6 : block good 6145 10 = true := by decide +kernel
private theorem chunk7 : block good 7169 10 = true := by decide +kernel
private theorem chunk8 : block good 8193 10 = true := by decide +kernel
private theorem chunk9 : block good 9217 10 = true := by decide +kernel
private theorem chunk10 : block good 10241 10 = true := by decide +kernel
private theorem chunk11 : block good 11265 10 = true := by decide +kernel
private theorem chunk12 : block good 12289 10 = true := by decide +kernel
private theorem chunk13 : block good 13313 10 = true := by decide +kernel
private theorem chunk14 : block good 14337 10 = true := by decide +kernel
private theorem chunk15 : block good 15361 10 = true := by decide +kernel
private theorem chunk16 : block good 16385 10 = true := by decide +kernel
private theorem chunk17 : block good 17409 10 = true := by decide +kernel
private theorem chunk18 : block good 18433 10 = true := by decide +kernel
private theorem chunk19 : block good 19457 10 = true := by decide +kernel
private theorem chunk20 : block good 20481 10 = true := by decide +kernel
private theorem chunk21 : block good 21505 10 = true := by decide +kernel
private theorem chunk22 : block good 22529 10 = true := by decide +kernel
private theorem chunk23 : block good 23553 10 = true := by decide +kernel
private theorem chunk24 : block good 24577 10 = true := by decide +kernel
private theorem chunk25 : block good 25601 10 = true := by decide +kernel
private theorem chunk26 : block good 26625 10 = true := by decide +kernel
private theorem chunk27 : block good 27649 10 = true := by decide +kernel
private theorem chunk28 : block good 28673 10 = true := by decide +kernel
private theorem chunk29 : block good 29697 10 = true := by decide +kernel
private theorem chunk30 : block good 30721 10 = true := by decide +kernel
private theorem chunk31 : block good 31745 10 = true := by decide +kernel
private theorem chunk32 : block good 32769 10 = true := by decide +kernel
private theorem chunk33 : block good 33793 10 = true := by decide +kernel
private theorem chunk34 : block good 34817 10 = true := by decide +kernel
private theorem chunk35 : block good 35841 10 = true := by decide +kernel
private theorem chunk36 : block good 36865 10 = true := by decide +kernel
private theorem chunk37 : block good 37889 10 = true := by decide +kernel
private theorem chunk38 : block good 38913 10 = true := by decide +kernel
private theorem chunk39 : block good 39937 10 = true := by decide +kernel
private theorem chunk40 : block good 40961 10 = true := by decide +kernel
private theorem chunk41 : block good 41985 10 = true := by decide +kernel
private theorem chunk42 : block good 43009 10 = true := by decide +kernel
private theorem chunk43 : block good 44033 10 = true := by decide +kernel
private theorem chunk44 : block good 45057 10 = true := by decide +kernel
private theorem chunk45 : block good 46081 10 = true := by decide +kernel
private theorem chunk46 : block good 47105 10 = true := by decide +kernel
private theorem chunk47 : block good 48129 10 = true := by decide +kernel
private theorem chunk48 : block good 49153 10 = true := by decide +kernel
private theorem chunk49 : block good 50177 10 = true := by decide +kernel
private theorem chunk50 : block good 51201 10 = true := by decide +kernel
private theorem chunk51 : block good 52225 10 = true := by decide +kernel
private theorem chunk52 : block good 53249 10 = true := by decide +kernel
private theorem chunk53 : block good 54273 10 = true := by decide +kernel
private theorem chunk54 : block good 55297 10 = true := by decide +kernel
private theorem chunk55 : block good 56321 10 = true := by decide +kernel
private theorem chunk56 : block good 57345 10 = true := by decide +kernel
private theorem chunk57 : block good 58369 10 = true := by decide +kernel
private theorem chunk58 : block good 59393 10 = true := by decide +kernel
private theorem chunk59 : block good 60417 10 = true := by decide +kernel
private theorem chunk60 : block good 61441 10 = true := by decide +kernel
private theorem chunk61 : block good 62465 10 = true := by decide +kernel
private theorem chunk62 : block good 63489 10 = true := by decide +kernel
private theorem chunk63 : block good 64513 10 = true := by decide +kernel
private theorem chunk64 : block good 65537 10 = true := by decide +kernel
private theorem chunk65 : block good 66561 10 = true := by decide +kernel
private theorem chunk66 : block good 67585 10 = true := by decide +kernel
private theorem chunk67 : block good 68609 10 = true := by decide +kernel
private theorem chunk68 : block good 69633 10 = true := by decide +kernel
private theorem chunk69 : block good 70657 10 = true := by decide +kernel
private theorem chunk70 : block good 71681 10 = true := by decide +kernel
private theorem chunk71 : block good 72705 10 = true := by decide +kernel
private theorem chunk72 : block good 73729 10 = true := by decide +kernel
private theorem chunk73 : block good 74753 10 = true := by decide +kernel
private theorem chunk74 : block good 75777 10 = true := by decide +kernel
private theorem chunk75 : block good 76801 10 = true := by decide +kernel
private theorem chunk76 : block good 77825 10 = true := by decide +kernel
private theorem chunk77 : block good 78849 10 = true := by decide +kernel
private theorem chunk78 : block good 79873 10 = true := by decide +kernel
private theorem chunk79 : block good 80897 10 = true := by decide +kernel
private theorem chunk80 : block good 81921 10 = true := by decide +kernel
private theorem chunk81 : block good 82945 10 = true := by decide +kernel
private theorem chunk82 : block good 83969 10 = true := by decide +kernel
private theorem chunk83 : block good 84993 10 = true := by decide +kernel
private theorem chunk84 : block good 86017 10 = true := by decide +kernel
private theorem chunk85 : block good 87041 10 = true := by decide +kernel
private theorem chunk86 : block good 88065 10 = true := by decide +kernel
private theorem chunk87 : block good 89089 10 = true := by decide +kernel
private theorem chunk88 : block good 90113 10 = true := by decide +kernel
private theorem chunk89 : block good 91137 10 = true := by decide +kernel
private theorem chunk90 : block good 92161 10 = true := by decide +kernel
private theorem chunk91 : block good 93185 10 = true := by decide +kernel
private theorem chunk92 : block good 94209 10 = true := by decide +kernel
private theorem chunk93 : block good 95233 10 = true := by decide +kernel
private theorem chunk94 : block good 96257 10 = true := by decide +kernel
private theorem chunk95 : block good 97281 10 = true := by decide +kernel
private theorem chunk96 : block good 98305 10 = true := by decide +kernel
private theorem chunk97 : block good 99329 10 = true := by decide +kernel
private theorem chunk98 : block good 100353 10 = true := by decide +kernel
private theorem chunk99 : block good 101377 10 = true := by decide +kernel
private theorem chunk100 : block good 102401 10 = true := by decide +kernel
private theorem chunk101 : block good 103425 10 = true := by decide +kernel
private theorem chunk102 : block good 104449 10 = true := by decide +kernel
private theorem chunk103 : block good 105473 10 = true := by decide +kernel
private theorem chunk104 : block good 106497 10 = true := by decide +kernel
private theorem chunk105 : block good 107521 10 = true := by decide +kernel
private theorem chunk106 : block good 108545 10 = true := by decide +kernel
private theorem chunk107 : block good 109569 10 = true := by decide +kernel
private theorem chunk108 : block good 110593 10 = true := by decide +kernel
private theorem chunk109 : block good 111617 10 = true := by decide +kernel
private theorem chunk110 : block good 112641 10 = true := by decide +kernel
private theorem chunk111 : block good 113665 10 = true := by decide +kernel
private theorem chunk112 : block good 114689 10 = true := by decide +kernel
private theorem chunk113 : block good 115713 10 = true := by decide +kernel
private theorem chunk114 : block good 116737 10 = true := by decide +kernel
private theorem chunk115 : block good 117761 10 = true := by decide +kernel
private theorem chunk116 : block good 118785 10 = true := by decide +kernel
private theorem chunk117 : block good 119809 10 = true := by decide +kernel
private theorem chunk118 : block good 120833 10 = true := by decide +kernel
private theorem chunk119 : block good 121857 10 = true := by decide +kernel
private theorem chunk120 : block good 122881 10 = true := by decide +kernel
private theorem chunk121 : block good 123905 10 = true := by decide +kernel
private theorem chunk122 : block good 124929 10 = true := by decide +kernel
private theorem chunk123 : block good 125953 10 = true := by decide +kernel
private theorem chunk124 : block good 126977 10 = true := by decide +kernel
private theorem chunk125 : block good 128001 10 = true := by decide +kernel
private theorem chunk126 : block good 129025 10 = true := by decide +kernel
private theorem chunk127 : block good 130049 10 = true := by decide +kernel

private theorem finite_check : block good 1 17 = true :=
  join
    (join
      (join
        (join
          (join
            (join
              (join chunk0 chunk1)
              (join chunk2 chunk3))
            (join
              (join chunk4 chunk5)
              (join chunk6 chunk7)))
          (join
            (join
              (join chunk8 chunk9)
              (join chunk10 chunk11))
            (join
              (join chunk12 chunk13)
              (join chunk14 chunk15))))
        (join
          (join
            (join
              (join chunk16 chunk17)
              (join chunk18 chunk19))
            (join
              (join chunk20 chunk21)
              (join chunk22 chunk23)))
          (join
            (join
              (join chunk24 chunk25)
              (join chunk26 chunk27))
            (join
              (join chunk28 chunk29)
              (join chunk30 chunk31)))))
      (join
        (join
          (join
            (join
              (join chunk32 chunk33)
              (join chunk34 chunk35))
            (join
              (join chunk36 chunk37)
              (join chunk38 chunk39)))
          (join
            (join
              (join chunk40 chunk41)
              (join chunk42 chunk43))
            (join
              (join chunk44 chunk45)
              (join chunk46 chunk47))))
        (join
          (join
            (join
              (join chunk48 chunk49)
              (join chunk50 chunk51))
            (join
              (join chunk52 chunk53)
              (join chunk54 chunk55)))
          (join
            (join
              (join chunk56 chunk57)
              (join chunk58 chunk59))
            (join
              (join chunk60 chunk61)
              (join chunk62 chunk63))))))
    (join
      (join
        (join
          (join
            (join
              (join chunk64 chunk65)
              (join chunk66 chunk67))
            (join
              (join chunk68 chunk69)
              (join chunk70 chunk71)))
          (join
            (join
              (join chunk72 chunk73)
              (join chunk74 chunk75))
            (join
              (join chunk76 chunk77)
              (join chunk78 chunk79))))
        (join
          (join
            (join
              (join chunk80 chunk81)
              (join chunk82 chunk83))
            (join
              (join chunk84 chunk85)
              (join chunk86 chunk87)))
          (join
            (join
              (join chunk88 chunk89)
              (join chunk90 chunk91))
            (join
              (join chunk92 chunk93)
              (join chunk94 chunk95)))))
      (join
        (join
          (join
            (join
              (join chunk96 chunk97)
              (join chunk98 chunk99))
            (join
              (join chunk100 chunk101)
              (join chunk102 chunk103)))
          (join
            (join
              (join chunk104 chunk105)
              (join chunk106 chunk107))
            (join
              (join chunk108 chunk109)
              (join chunk110 chunk111))))
        (join
          (join
            (join
              (join chunk112 chunk113)
              (join chunk114 chunk115))
            (join
              (join chunk116 chunk117)
              (join chunk118 chunk119)))
          (join
            (join
              (join chunk120 chunk121)
              (join chunk122 chunk123))
            (join
              (join chunk124 chunk125)
              (join chunk126 chunk127))))))

/-- A fixed pair of rational witness times obstructs each speed in the finite range. -/
theorem separated_for_each_speed (v : Nat) (h : 1 ≤ v) (hb : v ≤ maxSpeed) :
    ∃ xy ∈ pairs, sepOK T r v xy = true := by
  by_cases hv : v % 8 = 0
  · have factor : 8 * (v / 8) = v := by
      simpa [hv] using Nat.mod_add_div v 8
    have hlo : 1 ≤ v / 8 := by omega
    have hhi : v / 8 < 1 + 2^17 := by
      simp only [maxSpeed] at hb
      omega
    have hg := block_sound finite_check hlo hhi
    obtain ⟨p, hp, passed⟩ : ∃ p ∈ reducedPairs, reducedSep (v / 8) p = true := by
      simpa [good, factor, Nat.not_lt_of_ge hb] using hg
    simpa [factor] using reduced_sep_sound (v / 8) p hp passed
  · exact ⟨firstPair, by decide, first_pair_separates v hv⟩

end MathLab.Frozen
