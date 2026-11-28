import MathLab.WT.CertificateChecks
import MathLab.WT.CertificateBridge

/-! The original integer certificate as one actual, everywhere symmetric,
deterministic witness of Carter--O'Bryant--Tao's Definition 2.1. -/
namespace MathLab.WT.Certificate
open Set MeasureTheory
noncomputable section
attribute [local irreducible] wf tf w table strip half

def physical : Witness (6269/20) (alphaGrid/20) (20*betaGrid) :=
  (gridWitness autoChecked coverChecked).dilate 20 (by norm_num)

theorem physical_length : physical.σ=1056 := by
  change (21120:ℝ)/20=1056
  norm_num

theorem physical_deterministic : physical.Deterministic := rfl

theorem physical_symmetric : physical.Symmetric := by
  intro i x
  dsimp only [physical, Witness.dilate, gridWitness, scaleFun]
  constructor
  · change 20*wf (20*(6269/20-x)) = 20*wf (20*x)
    exact congrArg (fun y : ℝ => 20*y) ((congrArg wf
      (show 20*(6269/20-x)=6269-20*x by ring)).trans (symmetric_w (20*x)))
  · change 1*tf (20*(21120/20-6269/20-x)) = 1*tf (20*x)
    exact congrArg (fun y : ℝ => 1*y) ((congrArg tf
      (show 20*(21120/20-6269/20-x)=14851-20*x by ring)).trans (symmetric_t (20*x)))

theorem physical_bound : objective (alphaGrid/20) (20*betaGrid) < 188606746/100000000 := by
  have h : 4*(alphaGrid/20*(20*betaGrid)) < (188606746/100000000:ℝ)^2 := by
    norm_num [alphaGrid, betaGrid, dt, dw, wenergy, excess]
  have e := Real.sq_sqrt (show 0≤alphaGrid/20*(20*betaGrid) by
    norm_num [alphaGrid, betaGrid, dt, dw, wenergy, excess])
  unfold objective
  nlinarith

theorem certified_witness :
    ∃ W : Witness (6269/20) (alphaGrid/20) (20*betaGrid),
      W.Deterministic ∧ W.Symmetric ∧ W.σ=1056 ∧
      objective (alphaGrid/20) (20*betaGrid)<188606746/100000000 :=
  ⟨physical, physical_deterministic, physical_symmetric, physical_length, physical_bound⟩

/-- The two exact fractions in Carter--O'Bryant--Tao, Appendix A.3, Claim 6. -/
def appendixAlpha : ℝ :=
  2453492781157573507423207273271472797945190063708486335212268095831410090107899954872437715855867237470270581061955550707561878628000855258309429721739642475600240262706548181067086450576625599218900683120876788032363654798525923559144513867197246825055699735993342348910137052272035579462663787 /
  2596802401581901858525574941396288805087426003283910469616207527338283601181039792274031559691376644227380078582776222475833661276452882135941431530132773229190527417266522388621548540661822789141339795611552128096103971628229512550667224642669840915160749996375246335775289250052685000000000000

def appendixBeta : ℝ :=
  1772130384572488116897712811968136530510904755768535954960651 /
  1882725390027397260273972602940280969126497650532485399838720

/-- Each rational budget of the signed one-atom pair strictly improves the
corresponding exact budget in Appendix A.3, Claim 6. -/
theorem budgets_below_appendix_A3 :
    alphaGrid/20 < appendixAlpha ∧ 20*betaGrid < appendixBeta := by
  norm_num [alphaGrid, betaGrid, dt, dw, wenergy, excess, appendixAlpha, appendixBeta]

/-- Strict comparison with the typeset rational parameters, including digits
lost in the rounded headline objective. -/
theorem below_appendix_A3 :
    objective (alphaGrid/20) (20*betaGrid) < objective appendixAlpha appendixBeta := by
  apply physical_bound.trans
  unfold objective
  have hs : (188606746/100000000:ℝ)/2 < Real.sqrt (appendixAlpha*appendixBeta) := by
    apply Real.lt_sqrt_of_sq_lt
    norm_num [appendixAlpha, appendixBeta]
  linarith

#print axioms certified_witness
#print axioms budgets_below_appendix_A3
#print axioms below_appendix_A3
end
end MathLab.WT.Certificate
