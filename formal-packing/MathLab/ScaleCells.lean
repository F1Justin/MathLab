module

public import Mathlib.Tactic.Linarith
public import Mathlib.Tactic.NormNum
public import Mathlib.Algebra.Order.Archimedean.Real.Basic

/-! Literal replacement table and closed local interval certificates for the 476-runner cover. -/

@[expose] public section

namespace MathLab.ScaleRule

abbrev Entry := Nat × Int × Int
def entries : List Entry := [(3, 3, -1), (5, 3, 1), (8, 0, -4), (9, 3, 1), (12, 2, 2), (15, 3, 0), (24, 2, 2), (27, 3, 0), (32, 0, -6), (45, 3, -1), (48, 2, 2), (60, 2, -2), (80, 0, 4), (81, 3, -1), (96, 2, 2), (108, 2, -2), (120, 2, -2), (128, 0, -4), (144, 0, 4), (192, 2, 2), (216, 2, -2), (240, 2, -2), (320, 0, 4), (480, 2, -2)]
def changed : List Nat := [4, 8, 12, 16, 20, 24, 32, 36, 40, 48, 60, 64, 72, 80, 96, 108, 120, 128, 144, 160, 192, 216, 240, 320, 384, 432, 480, 960]

def Serves (q r : Nat) (z : ℝ) : Prop :=
  ∃ p ∈ entries, ∃ b c : ℤ,
    (p.1 : ℝ) * 4 / q = b ∧
    (p.1 : ℝ) * r / q + p.2.1 / 4 = c ∧
    |(p.1 : ℝ) / q * z + p.2.2 / 4| ≤ 1

private theorem hit4_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 4 1 z := by
  by_cases e0 : z ≤ (3 : ℝ)/5
  · refine ⟨(5,3,1), by decide, 5, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(8,0,-4), by decide, 8, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit4_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 4 3 z := by
  refine ⟨(3,3,-1), by decide, 3, 3, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit8_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 8 1 z := by
  by_cases e0 : z ≤ (1 : ℝ)/3
  · refine ⟨(12,2,2), by decide, 6, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(8,0,-4), by decide, 4, 1, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit8_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 8 3 z := by
  by_cases e0 : z ≤ (1 : ℝ)/3
  · refine ⟨(12,2,2), by decide, 6, 5, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(8,0,-4), by decide, 4, 3, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit12_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 12 1 z := by
  refine ⟨(3,3,-1), by decide, 1, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit12_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 12 3 z := by
  refine ⟨(9,3,1), by decide, 3, 3, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit16_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 16 1 z := by
  by_cases e0 : z ≤ (1 : ℝ)/3
  · refine ⟨(24,2,2), by decide, 6, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(32,0,-6), by decide, 8, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit16_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 16 3 z := by
  by_cases e0 : z ≤ (1 : ℝ)/3
  · refine ⟨(24,2,2), by decide, 6, 5, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(32,0,-6), by decide, 8, 6, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit20_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 20 1 z := by
  refine ⟨(5,3,1), by decide, 1, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit20_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 20 3 z := by
  refine ⟨(15,3,0), by decide, 3, 3, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit24_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 24 1 z := by
  refine ⟨(12,2,2), by decide, 2, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit24_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 24 3 z := by
  refine ⟨(12,2,2), by decide, 2, 2, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit32_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 32 1 z := by
  by_cases e0 : z ≤ (1 : ℝ)/3
  · refine ⟨(48,2,2), by decide, 6, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  ·
    by_cases e1 : z ≤ (1 : ℝ)/2
    · refine ⟨(128,0,-4), by decide, 16, 4, by norm_num, by norm_num, ?_⟩
      rw [abs_le]; constructor <;> norm_num <;> linarith
    · refine ⟨(32,0,-6), by decide, 4, 1, by norm_num, by norm_num, ?_⟩
      rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit32_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 32 3 z := by
  by_cases e0 : z ≤ (1 : ℝ)/3
  · refine ⟨(48,2,2), by decide, 6, 5, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  ·
    by_cases e1 : z ≤ (1 : ℝ)/2
    · refine ⟨(128,0,-4), by decide, 16, 12, by norm_num, by norm_num, ?_⟩
      rw [abs_le]; constructor <;> norm_num <;> linarith
    · refine ⟨(32,0,-6), by decide, 4, 3, by norm_num, by norm_num, ?_⟩
      rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit36_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 36 1 z := by
  refine ⟨(9,3,1), by decide, 1, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit36_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 36 3 z := by
  refine ⟨(27,3,0), by decide, 3, 3, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit40_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 40 1 z := by
  by_cases e0 : z ≤ (0 : ℝ)/1
  · refine ⟨(80,0,4), by decide, 8, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(60,2,-2), by decide, 6, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit40_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 40 3 z := by
  by_cases e0 : z ≤ (0 : ℝ)/1
  · refine ⟨(80,0,4), by decide, 8, 6, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(60,2,-2), by decide, 6, 5, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit48_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 48 1 z := by
  refine ⟨(24,2,2), by decide, 2, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit48_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 48 3 z := by
  refine ⟨(24,2,2), by decide, 2, 2, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit60_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 60 1 z := by
  refine ⟨(15,3,0), by decide, 1, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit60_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 60 3 z := by
  refine ⟨(45,3,-1), by decide, 3, 3, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit64_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 64 1 z := by
  by_cases e0 : z ≤ (1 : ℝ)/3
  · refine ⟨(96,2,2), by decide, 6, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(128,0,-4), by decide, 8, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit64_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 64 3 z := by
  by_cases e0 : z ≤ (1 : ℝ)/3
  · refine ⟨(96,2,2), by decide, 6, 5, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(128,0,-4), by decide, 8, 6, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit72_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 72 1 z := by
  by_cases e0 : z ≤ (0 : ℝ)/1
  · refine ⟨(144,0,4), by decide, 8, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(108,2,-2), by decide, 6, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit72_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 72 3 z := by
  by_cases e0 : z ≤ (0 : ℝ)/1
  · refine ⟨(144,0,4), by decide, 8, 6, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(108,2,-2), by decide, 6, 5, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit80_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 80 1 z := by
  by_cases e0 : z ≤ (0 : ℝ)/1
  · refine ⟨(80,0,4), by decide, 4, 1, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(120,2,-2), by decide, 6, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit80_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 80 3 z := by
  by_cases e0 : z ≤ (0 : ℝ)/1
  · refine ⟨(80,0,4), by decide, 4, 3, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(120,2,-2), by decide, 6, 5, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit96_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 96 1 z := by
  refine ⟨(48,2,2), by decide, 2, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit96_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 96 3 z := by
  refine ⟨(48,2,2), by decide, 2, 2, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit108_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 108 1 z := by
  refine ⟨(27,3,0), by decide, 1, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit108_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 108 3 z := by
  refine ⟨(81,3,-1), by decide, 3, 3, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit120_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 120 1 z := by
  refine ⟨(60,2,-2), by decide, 2, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit120_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 120 3 z := by
  refine ⟨(60,2,-2), by decide, 2, 2, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit128_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 128 1 z := by
  by_cases e0 : z ≤ (1 : ℝ)/3
  · refine ⟨(192,2,2), by decide, 6, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(128,0,-4), by decide, 4, 1, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit128_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 128 3 z := by
  by_cases e0 : z ≤ (1 : ℝ)/3
  · refine ⟨(192,2,2), by decide, 6, 5, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(128,0,-4), by decide, 4, 3, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit144_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 144 1 z := by
  by_cases e0 : z ≤ (0 : ℝ)/1
  · refine ⟨(144,0,4), by decide, 4, 1, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(216,2,-2), by decide, 6, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit144_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 144 3 z := by
  by_cases e0 : z ≤ (0 : ℝ)/1
  · refine ⟨(144,0,4), by decide, 4, 3, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(216,2,-2), by decide, 6, 5, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit160_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 160 1 z := by
  by_cases e0 : z ≤ (0 : ℝ)/1
  · refine ⟨(320,0,4), by decide, 8, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(240,2,-2), by decide, 6, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit160_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 160 3 z := by
  by_cases e0 : z ≤ (0 : ℝ)/1
  · refine ⟨(320,0,4), by decide, 8, 6, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(240,2,-2), by decide, 6, 5, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit192_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 192 1 z := by
  refine ⟨(96,2,2), by decide, 2, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit192_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 192 3 z := by
  refine ⟨(96,2,2), by decide, 2, 2, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit216_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 216 1 z := by
  refine ⟨(108,2,-2), by decide, 2, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit216_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 216 3 z := by
  refine ⟨(108,2,-2), by decide, 2, 2, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit240_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 240 1 z := by
  refine ⟨(120,2,-2), by decide, 2, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit240_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 240 3 z := by
  refine ⟨(120,2,-2), by decide, 2, 2, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit320_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 320 1 z := by
  by_cases e0 : z ≤ (0 : ℝ)/1
  · refine ⟨(320,0,4), by decide, 4, 1, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(480,2,-2), by decide, 6, 2, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit320_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 320 3 z := by
  by_cases e0 : z ≤ (0 : ℝ)/1
  · refine ⟨(320,0,4), by decide, 4, 3, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith
  · refine ⟨(480,2,-2), by decide, 6, 5, by norm_num, by norm_num, ?_⟩
    rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit384_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 384 1 z := by
  refine ⟨(192,2,2), by decide, 2, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit384_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 384 3 z := by
  refine ⟨(192,2,2), by decide, 2, 2, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit432_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 432 1 z := by
  refine ⟨(216,2,-2), by decide, 2, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit432_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 432 3 z := by
  refine ⟨(216,2,-2), by decide, 2, 2, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit480_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 480 1 z := by
  refine ⟨(240,2,-2), by decide, 2, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit480_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 480 3 z := by
  refine ⟨(240,2,-2), by decide, 2, 2, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit960_1 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 960 1 z := by
  refine ⟨(480,2,-2), by decide, 2, 1, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

private theorem hit960_3 (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves 960 3 z := by
  refine ⟨(480,2,-2), by decide, 2, 2, by norm_num, by norm_num, ?_⟩
  rw [abs_le]; constructor <;> norm_num <;> linarith

theorem serves (q r : Nat) (hq : q ∈ changed) (hr : r=1 ∨ r=3)
    (z : ℝ) (lo : -1 ≤ z) (hi : z ≤ 1) : Serves q r z := by
  simp only [changed, List.mem_cons, List.not_mem_nil, or_false] at hq
  rcases hq with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  all_goals rcases hr with rfl | rfl
  all_goals first
    | exact hit4_1 z lo hi
    | exact hit4_3 z lo hi
    | exact hit8_1 z lo hi
    | exact hit8_3 z lo hi
    | exact hit12_1 z lo hi
    | exact hit12_3 z lo hi
    | exact hit16_1 z lo hi
    | exact hit16_3 z lo hi
    | exact hit20_1 z lo hi
    | exact hit20_3 z lo hi
    | exact hit24_1 z lo hi
    | exact hit24_3 z lo hi
    | exact hit32_1 z lo hi
    | exact hit32_3 z lo hi
    | exact hit36_1 z lo hi
    | exact hit36_3 z lo hi
    | exact hit40_1 z lo hi
    | exact hit40_3 z lo hi
    | exact hit48_1 z lo hi
    | exact hit48_3 z lo hi
    | exact hit60_1 z lo hi
    | exact hit60_3 z lo hi
    | exact hit64_1 z lo hi
    | exact hit64_3 z lo hi
    | exact hit72_1 z lo hi
    | exact hit72_3 z lo hi
    | exact hit80_1 z lo hi
    | exact hit80_3 z lo hi
    | exact hit96_1 z lo hi
    | exact hit96_3 z lo hi
    | exact hit108_1 z lo hi
    | exact hit108_3 z lo hi
    | exact hit120_1 z lo hi
    | exact hit120_3 z lo hi
    | exact hit128_1 z lo hi
    | exact hit128_3 z lo hi
    | exact hit144_1 z lo hi
    | exact hit144_3 z lo hi
    | exact hit160_1 z lo hi
    | exact hit160_3 z lo hi
    | exact hit192_1 z lo hi
    | exact hit192_3 z lo hi
    | exact hit216_1 z lo hi
    | exact hit216_3 z lo hi
    | exact hit240_1 z lo hi
    | exact hit240_3 z lo hi
    | exact hit320_1 z lo hi
    | exact hit320_3 z lo hi
    | exact hit384_1 z lo hi
    | exact hit384_3 z lo hi
    | exact hit432_1 z lo hi
    | exact hit432_3 z lo hi
    | exact hit480_1 z lo hi
    | exact hit480_3 z lo hi
    | exact hit960_1 z lo hi
    | exact hit960_3 z lo hi

end MathLab.ScaleRule
