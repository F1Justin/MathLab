# Sources and scope

Checked 26 November 2026.

- Jack Zhan develops the block-counting polynomials, proves the short recurrence in Theorem 3.3, gives the threshold-four examples in Section 3.1.1, and explicitly conjectures interlacing after Table 4 on printed page 13. [Stockholm University report](https://kurser.math.su.se/pluginfile.php/16103/mod_folder/content/0/2023/2023_K17_report.pdf?forcedownload=1)
- Per Alexandersson explicitly asks for interlacing over all gaps through the threshold in January 2024 using the polynomials with a common factor $t$. The MathLab theorem is the threshold-four eventually strict version with that common factor removed. [MathOverflow question 462360](https://mathoverflow.net/questions/462360/set-partitions-with-big-blocks-real-rooted-polynomials)
- The Symmetric Functions Catalog currently lists consecutive interlacing and real-rootedness for ordinary unrestricted partitions at threshold four as open. It records thresholds two and three and the separately solved restrictions to only large blocks or to singleton and large blocks. It also lists the distinct problem of ordered set partitions. [Open problems](https://www.symmetricfunctions.com/realRootedOpenProblems.htm) and [set-partition examples](https://www.symmetricfunctions.com/realRootedSetPartitions.htm)
- The threshold-two connection uses the real-rootedness and interlacing of run-sorted permutation descent polynomials. [Alexandersson and Nabawanda, 2022](https://doi.org/10.54550/ECA2022V2S2R2)
- The Bóna–Mező comparison fixes a different family by forbidding singleton blocks and counting all remaining blocks. Their left-edge analysis is relevant precedent for asymptotics of extreme roots. [European Journal of Combinatorics paper](https://doi.org/10.1016/j.ejc.2015.07.021)
- The Airy integral, zero location, and zero asymptotics use the standard normalizations in Chapter 9. [NIST DLMF §9.5](https://dlmf.nist.gov/9.5) and [§9.9](https://dlmf.nist.gov/9.9)

The literature check used the author's original public question, the thesis, the catalog maintained by the question's author, and the indexed literature on unrestricted big-block counts, real-rootedness, and extreme-root asymptotics. Nearby work treats several different statistics called large blocks. No priority or exhaustiveness claim is made.

## Archived work

| Result | Source in the frozen snapshot |
| --- | --- |
| Absolute outer rank and uniform outer transition | [Indexing](../../snapshot/research/partitions/outer_index.md) and [centered derivative](../../snapshot/research/partitions/outer_transition.md) |
| Bulk phase and limiting distribution | [Bulk analysis](../../snapshot/research/partitions/bulk_theorem.md), [all radii](../../snapshot/research/partitions/density_one.md), and [interval checker](../../snapshot/research/partitions/saddle_certificate.py) |
| Fixed outer ranks and effective five-root certificate | [Asymptotics](../../snapshot/research/partitions/edge_theorem.md), [effective windows](../../snapshot/research/partitions/effective_outer.md), and [checker](../../snapshot/research/partitions/effective_outer.py) |
| Airy limit, displacement and real zero-free interval | [Airy proof](../../snapshot/research/partitions/airy_theorem.md), [positivity proof](../../snapshot/research/partitions/effective_inner.md), and [checker](../../snapshot/research/partitions/effective_inner.py) |
| Degree saturation and five-row theorem | [Bridge](../../snapshot/research/partitions/full_saddle_bridge.md), [adjacent theorem](../../snapshot/research/partitions/eventual_interlacing.md), and [lag-four refinement](../../snapshot/research/partitions/four_row_window.md) |
| Algebraic coefficient order and failed factorial lift | [All-threshold inequality](../../snapshot/research/partitions/coefficient_ladder.md) and [discriminant witness](../../snapshot/research/partitions/ordered_lift_obstruction.md) |
| Earlier exploration and diagnostics | [Frozen research collection](../../snapshot/research/partitions), [research summary](../../snapshot/research/README.md), and [baseline results](../../snapshot/package1/results) |

The earlier exact baseline treats ordinary thresholds $4,5,6$ through $n=100$ and ordered thresholds $2,3,4$ through $n=50$, with separately bounded weak interlacing checks through the pair ending at $15$. Its [generator](../../snapshot/package1/experiments.py) includes a separate recurrence and object-level small checks. For ordered partitions, the coefficient counts multiply each unordered object's contribution by the factorial of its **total** number of blocks. The factorial obstruction in this paper orders only the **marked** large blocks. The two families are distinct.

The exploratory inner-root refinement at $r\ge10^{24}$, the conditional residue bounds from the algebraic induction investigation, and wider-threshold or ordered-partition conjectures have no theorem status in the paper. They remain in the frozen notes and budgeted responses.
