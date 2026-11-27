module

import all MathLab
import all MathLab.PhaseNeighbourhood.Definitions
import all MathLab.PhaseNeighbourhood.Core
import all MathLab.PhaseNeighbourhood.Farey
import all MathLab.PhaseNeighbourhood.Cube
import all MathLab.PhaseNeighbourhood.Sharpness
import all MathLab.PhaseNeighbourhood.Tube
import all MathLab.PhaseNeighbourhood.Geometry
import all Solution
meta import Lean

open Lean Elab Command in
set_option maxHeartbeats 0 in
run_cmd do
  let env := (← getEnv).setExporting false
  let modules := env.allImportedModuleNames
  let allowed := #[`propext, `Quot.sound, `Classical.choice]
  let mut checked : Nat := 0
  let mut privateChecked : Nat := 0
  let mut used : Std.HashSet Name := {}
  for (name, _) in env.constants.toList do
    let some index := env.getModuleIdxFor? name | continue
    let owner := modules[index.toNat]!
    unless (`MathLab).isPrefixOf owner || owner == `Solution do continue
    checked := checked + 1
    if isPrivateName name then privateChecked := privateChecked + 1
    for axiomName in ← collectAxioms name do
      unless allowed.contains axiomName do
        throwError "{owner}: {name} uses forbidden axiom {axiomName}"
      used := used.insert axiomName
  if checked == 0 || privateChecked == 0 then
    throwError "Expected both public and private proof declarations"
  logInfo m!"Checked {checked} declarations, including {privateChecked} private declarations."
  logInfo m!"Used axioms: {allowed.filter (fun name => used.contains name)}"
