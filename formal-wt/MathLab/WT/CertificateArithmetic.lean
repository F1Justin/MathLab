import MathLab.WT.CertificateData
import Mathlib.Data.Int.Basic

namespace MathLab.WT.Certificate

def dw : ℤ := 10 ^ 25
def dt : ℤ := 250000000000 * dw
def w : List ℤ := half.tail.reverse ++ half

private def partialSums (acc : ℤ) : List ℤ → List ℤ
  | [] => []
  | v :: rest => (acc+v) :: partialSums (acc+v) rest

/-- Corrected table, ascending offsets -3099 through 2009 at the right edge.
The left and right ramps are convolutions of w with the repair interval. -/
def strip : List ℤ :=
  (partialSums 0 w).map (·+dt) ++ List.replicate 1390 (dt+dw) ++
  transition.map (fun z => z * (dt / 10^14) + dw) ++ List.replicate 301 dw ++
  ((partialSums 0 w).take 1298).map (dw-·)

/-- Rightward table slices, starting 1298 cells inside the left edge of the strip. -/
def rows : List ℤ := List.replicate 1298 dt ++ strip

def dot : List ℤ → List ℤ → ℤ
  | x :: xs, y :: ys => x*y + dot xs ys
  | _, _ => 0

def scans (weights : List ℤ) (threshold : ℤ) (heights : List ℤ) : ℕ → Bool
  | 0 => true
  | n+1 => decide (threshold ≤ dot weights heights) &&
    scans weights threshold heights.tail n

private theorem scans_at {u v : List ℤ} {b : ℤ} {n i : ℕ}
    (h : scans u b v n = true) (hi : i < n) : b ≤ dot u (v.drop i) := by
  induction n generalizing v i with
  | zero => omega
  | succ n ih =>
    simp only [scans, Bool.and_eq_true, decide_eq_true_eq] at h
    cases i with
    | zero => simpa using h.1
    | succ i =>
      have aux := ih h.2 (by omega : i<n)
      simpa only [List.drop_tail] using aux

def Segment (u : List ℤ) (b : ℤ) (v : List ℤ) (start count : ℕ) : Prop :=
  ∀ i, start ≤ i → i < start+count → b ≤ dot u (v.drop i)

theorem segment_of_scans {u v : List ℤ} {b : ℤ} {start count : ℕ}
    (h : scans u b (v.drop start) count = true) : Segment u b v start count := by
  intro i h₀ h₁
  have aux := scans_at h (i := i-start) (by omega)
  rwa [List.drop_drop, show start+(i-start)=i by omega] at aux

theorem segment_join {u v : List ℤ} {b : ℤ} {s n m : ℕ}
    (h : Segment u b v s n) (h' : Segment u b v (s+n) m) : Segment u b v s (n+m) := by
  intro k lo hi
  by_cases hk : k<s+n
  · exact h k lo hk
  · exact h' k (by omega) (by omega)

def ssq (v : List ℤ) : ℤ := (v.map (fun x => x*x)).sum

set_option maxRecDepth 20000 in
theorem data_properties : w.length = 1299 ∧ strip.length = 5109 ∧ w.sum = dw ∧
    ssq w = 4706290131138176544921808787408653268320550189754 := by decide +kernel

end MathLab.WT.Certificate
