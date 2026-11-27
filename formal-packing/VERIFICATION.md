# Kanako verification

The 27 November 2026 run used Lean 4.35.0, compiler commit `eb6cafb7290e8bd5f2937522d8d804f58f02bafc`. All nine Mathlib dependency commits matched the manifest. The closed-radius statement uses only Lean core and `Mathlib.Algebra.Order.Archimedean.Real.Basic`.

The clean build of Challenge and Solution succeeded. The only diagnostic was the declared Challenge placeholder. The Solution's axiom audit returned `propext`, `Classical.choice`, and `Quot.sound`. Stock leanchecker replayed Solution.

With its standard bubblewrap isolation, `lake comparator` built both modules and compared `MathLab.Packing476.exists_cover`. NanoDa and Lean's default kernel each accepted the exported proof. Comparator exited zero.

The Kanako build and local source digests agree.

~~~text
ea87ddfd7e9a817cd94b35248882fe6ea39a6cba087926a3d40a678605c59c4f  Challenge.lean
4498c95f6ee2c1d83546da955e9758a879250cb91d745dc1f7e06a818c120c84  Solution.lean
cb87765d7048923eb7b6489d2ed53ffeda02b2b6cfe14625adc2f0afa8fa409d  comparator.json
48830e749c6230f026b451f411419079f61f30cdf8c1dfbd212a7661b93ff031  MathLab/LocalTransfer.lean
831a39a7d89e3c39b83a75a2d0fe59e6bbf1f002b891497481573a6ef4c58f1b  MathLab/ScaleCells.lean
4f297b6020cdb4c8b5960b9f67f5a2399614002950633b72ab20a5e9e1bbba3b  MathLab/Scale476.lean
175fe03dada8c9eaa58ae5da5984ceff1c718191e3af82e65caa4d1236f6a9aa  lakefile.toml
600b777e298d47dc3f163f2bb2c50323f80935ba6b1309c7572c4fe3ac8decb6  lake-manifest.json
ca5f1f601d34c49079e38d7e7041eb0f2a9c227fbc1df0f404820069a052330c  lean-toolchain
17b1496ae500beee20c5b26c051153747f1e65b934bca5c0b0bd72b2babe0450  LICENSE
2bcec7d16980c54bbfaba227593ef52c7f2c1bbd7e18bd59448cddfed7db2a61  scripts/AuditAxioms.lean
~~~
