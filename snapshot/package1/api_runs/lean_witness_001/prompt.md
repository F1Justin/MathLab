Act as the principal Lean author. Return a complete Lean 4.35/mathlib module, not a plan, formalizing the following generic public mathematical certificate for periodic linear tracks, with no external files or private data. Use Mathlib.Tactic.Linarith, .NormNum, .Positivity, .FieldSimp, and Mathlib.Data.Real.Archimedean as needed. No sorry, axiom, native_decide. The dataset will be plugged in locally. Make your theorem generic with this fixed certificate interface:

namespace MathLab
def cellOK (T r lo hi : Nat) (p : Nat × Nat) : Bool := decide (lo ≤ hi ∧ r ≤ (p.1*lo+p.2)%T ∧ (p.1*lo+p.2)%T + p.1*(hi-lo) + r ≤ T)
-- track phase is already normalized to T, not another scale.
def sepOK (T r v : Nat) (xy : Nat × Nat) : Bool := decide (xy.1 ≤ xy.2 ∧ 2*r ≤ (v*(xy.2-xy.1))%T ∧ (v*(xy.2-xy.1))%T + 2*r ≤ T)
def Outside (T r : Nat) (value : Real) : Prop := ∀ k : Int, (r:Real) ≤ |value - (k:Real)*(T:Real)|

Prove:
1) cellOK T r lo hi p=true, T>0 implies Outside T r ((p.1:Real)*t+p.2) for every real t in [lo,hi]. Use Nat.mod_add_div, a fixed floor k0=(p.1*lo+p.2)/T, split arbitrary k <= k0 or >= k0+1. A helpful separate lemma: if k0*T+r ≤ value and value+r ≤ (k0+1)*T then Outside T r value.
2) If 2*r ≤ delta - k0*T ≤ T-2*r, then for every real base s, Outside T r s OR Outside T r (s+delta). Use triangle inequality on two alleged strictly close integer multiples and split their integer difference. Deduce for a pair xy satisfying sepOK, all phases s and any positive v, one pure real time x or y defeats the added runner. 
3) A single exported universal lower theorem. Variables (T r L H B : Nat) (seed pairs : List (Nat×Nat)). Hypotheses: 0<T, 4*r≤T, H≤T, L≤H, 2*r<(B+1)*(H-L), seed.all(cellOK T r L H)=true; and for every xy∈pairs, xy.2≤T, seed.all(cellOK T r xy.1 xy.1)=true and same for xy.2; and for all 1≤v≤B there exists xy∈pairs with sepOK T r v xy=true. Conclude: for ALL v:Nat, 0<v, ALL s:Real, ∃t:Real, 0≤t ∧ t≤T ∧ (∀p∈seed, Outside T r ((p.1:Real)*t+p.2)) ∧ Outside T r ((v:Real)*t+s). For v>B take L and L+2*r/v in [L,H], phase difference exactly 2*r, k0=0. For v≤B use 2). Keep hyp names explicit and type annotations stable. No IVT or floor on Real required. Provide module code in a single fenced block and describe any untested lemmas. Compilation will be checked locally.
