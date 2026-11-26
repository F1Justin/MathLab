# Research task: four-element threshold in ordinary set partitions

Status checked: 2026-11-26. Research budget and execution are controlled by the
parent task; this file authorizes no paid API call by itself.

## Target and provenance

Let `Pi_n` be the set of partitions of `{1,...,n}` into nonempty, unordered
blocks. Put

\[
 P_{n,j}(t)=\sum_{\pi\in\Pi_n}t^{\#\{B\in\pi:|B|\ge j\}}.
\]

Our target is real-rootedness and directed adjacent interleaving of `P_{n,4}`
for every `n`. A nonzero constant has no roots and satisfies the root condition.
For increasing root lists, the convention `f << g` is `f_1 <= g_1 <= f_2 <=
g_2 <= ...` at equal degree, and `g_1 <= f_1 <= g_2 <= ... <= f_d <= g_(d+1)`
when `deg(g)=deg(f)+1`. Multiplicities are retained.

The current [SymCat problem list](https://www.symmetricfunctions.com/realRootedOpenProblems.htm)
lists threshold four as open and thresholds two and three as proved. The general
interleaving question already appears in Jack Zhan's
[2023 thesis](https://kurser.math.su.se/pluginfile.php/16103/mod_folder/content/0/2023/2023_K17_report.pdf?forcedownload=1),
page 13; use this historical attribution, rather than calling it newly posed in
2026. Recheck these sources before any eventual novelty claim.

## Exact representation

Use ascending integer coefficient arrays. The empty partition gives `P_0=1`;
for threshold four, `P_1=1`, `P_2=2`, `P_3=5`. Selecting the block containing
the largest label gives the independent coefficient specification

\[
 P_{n+1,j}(t)=\sum_{r=1}^{n+1}\binom n{r-1}
 t^{[r\ge j]}P_{n+1-r,j}(t).
\]

Insertion into an existing large block instead gives Zhan's short recurrence,
specialized here:

\[
 P_{n+1,4}=(1+t\partial_t)P_{n,4}+nP_{n-1,4}
 +\binom n2P_{n-2,4}+t\binom n3P_{n-3,4}.
\]

Terms with negative indices are zero. Reconcile the two recurrences before
using either to support a conjectured identity. Small checkpoints are
`P_4=14+t`, `P_5=46+6t`, and `P_8=2780+1325t+35t^2`.

## First bounded experiment

From the project directory run:

```bash
python experiments.py --family partitions --parameters 4 --n 80 --interlace-n 20 --self-check
```

The script checks both recurrences, performs small definition-level enumeration,
and counts roots exactly. The arguments deliberately bound real-root tests and
adjacent-pair tests separately; inspect the JSON to report their actual ranges.
Saved coefficients and checks are finite evidence. For a suspected failure,
regenerate that row independently, preserve exact coefficients, and obtain an
exact root count or isolated-root ordering certificate.

## Paid reasoning target

Concentrate on a sufficient invariant for the four-term recurrence, rather than
requesting an unrestricted essay about real-rootedness. Ask the model to give a
precise lemma involving a short window of rows and, if useful, their derivatives
or an auxiliary refinement by small-block counts. It must explain how that
lemma implies the desired next interleaving relation, specify all four residue
classes of `n mod 4`, and expose an exact finite test of the proposed lemma.

The model may choose another route, including a counterexample search, a
multivariate refinement, a matching interpretation, or an ordered-block
transformation. Every route should first produce a falsifiable mathematical
statement or executable experiment. Treat generic closure claims as separate
lemmas: a positive sum of real-rooted polynomials requires additional hypotheses
to preserve real-rootedness. Read the actual hypotheses of any cited theorem.

## Deliverable and stopping decision

Return the exact candidate lemma, its proof status, a dependency list, the next
executable check, and either a proof or the precise remaining implication. Record
a failed strengthened conjecture with its smallest verified witness; this saves
future calls from repeating that route. Continue funding a branch when it adds
an independently checkable reduction, a verified obstruction, or a new proved
subcase. After two calls that repeat the same gap, return the branch to the
coordinator with its evidence and resume another route. Formalization follows a
complete mathematical argument or a compact exact counterexample certificate.
