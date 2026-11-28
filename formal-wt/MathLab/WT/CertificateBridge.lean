import MathLab.WT.ListCells
import MathLab.WT.Dilation

namespace MathLab.WT.Certificate
open ListCells Cells Set MeasureTheory
noncomputable section

/-- Full palindromic table. The constant part is factored to make the
checked right-edge slices literally a suffix. -/
def leading : List ℤ := strip.reverse ++ List.replicate 13623 dt
def table : List ℤ := leading ++ rows
attribute [local irreducible] strip w table leading rows half

theorem table_layout : table = strip.reverse ++ (List.replicate 14921 dt ++ strip) := by
  unfold table leading rows
  rw [List.append_assoc, ← List.append_assoc (List.replicate 13623 dt) _ strip,
    ← List.replicate_add]

private theorem lent : table.length=25139 := by
  rw [table_layout]
  simp only [List.length_append, List.length_reverse, List.length_replicate, data_properties.2.1]

private theorem lens : strip.length=5109 := data_properties.2.1
private theorem lenw : w.length=1299 := data_properties.1
private theorem lenlead : leading.length=18732 := by
  simp only [leading, List.length_append, List.length_reverse, List.length_replicate, lens]

private theorem palw : w.reverse = w := by
  unfold w
  cases he : half with
  | nil => simp
  | cons x xs => simp [List.reverse_cons, List.append_assoc]

private theorem palt : table.reverse = table := by
  rw [table_layout]
  simp only [List.reverse_append, List.reverse_replicate, List.reverse_reverse, List.append_assoc]

private theorem const_cells {k : ℕ} (h₀ : 5109 ≤ k) (h₁ : k<20030) : ListCells.get table k=dt := by
  unfold ListCells.get
  rw [table_layout, List.getElem?_append_right (by simpa only [List.length_reverse,lens] using h₀)]
  rw [List.getElem?_append_left, List.getElem?_replicate_of_lt]
  · rfl
  all_goals (simp only [List.length_reverse, List.length_replicate, lens]; omega)

private theorem suffix (k : ℕ) : table.drop (18732+k)=rows.drop k := by
  rw [table, ← lenlead, List.drop_length_add_append]

private theorem strip_squares :
    ssq strip = 19430925798587437257423294385795201737659156108900709413774730809971244818128 := by
  set_option maxRecDepth 30000 in decide +kernel

theorem ssq_append (u v : List ℤ) : ssq (u++v) = ssq u + ssq v := by simp [ssq]
theorem ssq_reverse (u : List ℤ) : ssq u.reverse=ssq u := by
  simp [ssq, List.map_reverse]
theorem ssq_replicate (n : ℕ) (x : ℤ) : ssq (List.replicate n x)=(n:ℤ)*x^2 := by
  simp [ssq, sq]

def excess : ℤ := 118101597174874514846588771590403475318312217801418827549461619942489636256
def wenergy : ℤ := 4706290131138176544921808787408653268320550189754
def alphaGrid : ℝ := (excess:ℝ)/(dt:ℝ)^2
def betaGrid : ℝ := (wenergy:ℝ)/(dw:ℝ)^2
def wf := neg w dw 3783
def tf := pos table dt (-5144)

theorem table_squares : ssq table = 21120 * dt^2 + excess := by
  rw [table_layout, ssq_append, ssq_append, ssq_replicate, ssq_reverse, strip_squares]
  decide +kernel

theorem symmetric_w (x : ℝ) : wf (6269-x) = wf x := by
  have h := neg_symmetric w dw 3783 palw x
  rw [show 2*(3783:ℝ)+2-w.length=6269 by rw [lenw]; norm_num] at h
  exact h

theorem symmetric_t (x : ℝ) : tf (14851-x) = tf x := by
  have h := pos_symmetric table dt (-5144) palt x
  rw [show 2*(-5144:ℝ)+table.length=14851 by rw [lent]; norm_num] at h
  exact h

private theorem table_one (x : ℝ) (hh : x ∈ Ioo 0 14851) : tf x=1 := by
  let k : ℤ := ⌊x+5144⌋
  let u := x+5144-(k:ℝ)
  have hl : (k:ℝ) ≤ x+5144 := Int.floor_le _
  have hu : x+5144 < (k:ℝ)+1 := Int.lt_floor_add_one _
  have hlo : 5143 ≤ k := by exact_mod_cast (by linarith [hh.1] : (5143:ℝ)≤(k:ℝ))
  have hhi : k ≤ 19995 := by exact_mod_cast (by linarith [hh.2] : (k:ℝ)≤(19995:ℝ))
  have hc (j : ℤ) (hj : 5109 ≤ j) (h' : j < 20030) : height table dt j=1 := by
    unfold height atInt
    rw [ite_eq_right (by omega : ¬ j<0), const_cells (by omega) (by omega)]
    have : (dt:ℝ) ≠ 0 := by norm_num [dt,dw]
    exact div_self this
  have hat := synth_at (indices table) (height table dt) k (-5144) u
    (by dsimp [u]; linarith) (by dsimp [u]; linarith)
  rw [show (k:ℝ)+u+(-5144)=x by dsimp [u]; ring, read_height, read_height,
    hc k (by omega) (by omega), hc (k-1) (by omega) (by omega)] at hat
  simpa [tf,pos] using hat

private theorem dot_onto_plateau {k : ℕ} (hl : 5109≤k) (hu : k+1299≤20030) :
    dot w (table.drop k) = dw*dt := by
  rw [dot_sum, ← data_properties.2.2.1, values_sum, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.mem_range, lenw] at hi
  rw [get_drop, const_cells (by omega) (by omega)]

theorem coverage_at {k : ℕ} (hlo : 11920 ≤ k) (hhi : k ≤ 22480)
    (h : Segment w (dw*dt) rows 0 3749) : dw*dt ≤ dot w (table.drop k) := by
  by_cases hsmall : k<18732
  · rw [dot_onto_plateau (by omega) (by omega)]
  · have e : k=18732+(k-18732) := by omega
    rw [e, suffix]
    exact h _ (by omega) (by omega)

private theorem auto_at (k : ℕ) (hh : Segment w 0 w 0 1299) : 0 ≤ dot w (w.drop k) := by
  by_cases h : k<1299
  · exact hh k (by omega) (by omega)
  · rw [List.drop_eq_nil_of_le (by rw [lenw]; omega)]
    cases w <;> simp [dot]

private theorem witness_auto (h : Segment w 0 w 0 1299) (x : ℝ) :
    0 ≤ conv wf (rev wf) x := by
  suffices ok : ∀ y : ℝ, 0 ≤ y → 0 ≤ conv wf (rev wf) y by
    by_cases h' : 0 ≤ x
    · exact ok x h'
    · rw [← auto_even wf x]
      exact ok (-x) (by linarith)
  intro y hy
  let k := ⌊y⌋₊
  let u := y-k
  have hl : (k:ℝ)≤y := Nat.floor_le hy
  have hu : y<(k:ℝ)+1 := Nat.lt_floor_add_one _
  have h₀ : 0≤u := sub_nonneg.mpr hl
  have h₁ : u≤1 := by dsimp [u]; linarith
  have eq := auto_lerp w dw 3783 k u h₀ h₁
  rw [show (k:ℝ)+u=y by dsimp [u]; ring] at eq
  rw [wf, eq]
  have a : (0:ℝ) ≤ dot w (w.drop k) := by exact_mod_cast auto_at k h
  have b : (0:ℝ) ≤ dot w (w.drop (k+1)) := by exact_mod_cast auto_at (k+1) h
  have hd : 0≤(dw:ℝ) := by norm_num [dw]
  exact add_nonneg (mul_nonneg (by linarith) (div_nonneg a (mul_nonneg hd hd)))
    (mul_nonneg h₀ (div_nonneg b (mul_nonneg hd hd)))

private theorem witness_covers (h : Segment w (dw*dt) rows 0 3749)
    (x : ℝ) (hx : x ∈ Ioo 0 21120) : 1 ≤ conv wf tf x := by
  suffices ok : ∀ y : ℝ, 10560≤ y → y < 21120 → 1 ≤ conv wf tf y by
    by_cases mid : 10560 ≤ x
    · exact ok x mid hx.2
    · rw [← cross_reflect wf tf 6269 14851 symmetric_w symmetric_t x]
      exact ok _ (by linarith) (by linarith [hx.1])
  intro y hy₀ hy₁
  let k := ⌊y+1360⌋₊
  let u := y+1360-k
  have hl : (k:ℝ)≤y+1360 := Nat.floor_le (by linarith)
  have hu : y+1360<(k:ℝ)+1 := Nat.lt_floor_add_one _
  have k₀ : 11920≤k := by
    by_contra hc
    have hkr : (k:ℝ)≤11919 := by exact_mod_cast (by omega : k≤11919)
    linarith
  have k₁ : k<22480 := by exact_mod_cast (by linarith : (k:ℝ)<22480)
  have h₀ : 0≤u := sub_nonneg.mpr hl
  have h₁ : u≤1 := by dsimp [u]; linarith
  have eq := cross_lerp w table dw dt 3783 (-5144) k u h₀ h₁
  rw [show (k:ℝ)+u+3783+(-5144)+1=y by dsimp [u]; ring] at eq
  rw [wf, tf, eq]
  have ratio (i : ℕ) (hi : 11920 ≤ i) (hj : i ≤ 22480) :
      1 ≤ (dot w (table.drop i):ℝ)/((dw:ℝ)*dt) := by
    rw [le_div_iff₀ (by norm_num [dw,dt]), one_mul]
    exact_mod_cast coverage_at hi hj h
  have a := mul_le_mul_of_nonneg_left (ratio k k₀ k₁.le) (sub_nonneg.mpr h₁)
  have b := mul_le_mul_of_nonneg_left (ratio (k+1) (by omega) (by omega)) h₀
  linarith

def gridWitness (hA : Segment w 0 w 0 1299) (hC : Segment w (dw*dt) rows 0 3749) :
    Witness 6269 alphaGrid betaGrid where
  n := 1
  σ := 21120
  p := fun _ => 1
  w := fun _ => wf
  t := fun _ => tf
  width_pos := by norm_num
  alpha_pos := by norm_num [alphaGrid, dt, dw, excess]
  beta_pos := by norm_num [betaGrid, dw, wenergy]
  width_le := by norm_num
  weight_nonneg := by simp
  total_weight := by simp
  window_regular := fun _ => synth_regular ((indices w).image (fun j => -j))
    (fun i => height w dw (-i)) 3783
  table_regular := fun _ => synth_regular (indices table) (height table dt) (-5144)
  window_support := fun _ x hx => by
    have h := neg_support w dw 3783 hx
    norm_num [lenw] at h
    exact ⟨by linarith [h.1], by linarith [h.2]⟩
  table_support := fun _ x hx => by
    have h := pos_support table dt (-5144) hx
    norm_num [lent] at h
    exact ⟨by linarith [h.1], by linarith [h.2]⟩
  plateau := fun _ x hx => table_one x (by norm_num at hx ⊢; exact hx)
  mass := fun _ => by rw [wf,neg_mass,data_properties.2.2.1]; norm_num [dw]
  table_cost := by
    simp only [expectation, Fin.sum_univ_one, one_mul]
    rw [tf,pos_energy,table_squares,alphaGrid]
    push_cast
    have hp : (dt:ℝ)≠0 := by norm_num [dt,dw]
    field_simp
    nlinarith
  window_cost := by
    simp only [expectation, Fin.sum_univ_one, one_mul]
    rw [wf,neg_energy,data_properties.2.2.2]
    rfl
  autocorrelation := fun x => by simpa [expectation] using witness_auto hA x
  covering := fun x hx => by simpa [expectation] using witness_covers hC x hx

end
end MathLab.WT.Certificate
