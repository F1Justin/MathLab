# Research task: large blocks in ordered set partitions

Status checked: 2026-11-26. This is a low-cost secondary target using the same
exact verifier as the ordinary-partition task.

## Objects and question

An ordered set partition of `{1,...,n}` is a finite list of disjoint nonempty
sets whose union is `{1,...,n}`. The elements within each block are unordered;
the order of the blocks is part of the object. For `j >= 2`, define

\[
 O_{n,j}(t)=\sum_{(B_1,\ldots,B_b)}
 t^{\#\{a:|B_a|\ge j\}}.
\]

The [SymCat open-problem page](https://www.symmetricfunctions.com/realRootedOpenProblems.htm)
currently asks for real-rootedness and adjacent interleaving of this family.
Begin with fixed `j=2` or `j=3`, and confirm current status again before publishing
a claimed solution. Use the directed weak interleaving convention documented in
`tasks/partitions_j4.md`; equal-degree transitions are part of the question.

## A transparent exact generator

The empty list supplies `O_0=1`. Choose the first block: if it has `r` elements,
there are `binom(n,r)` choices and an ordered partition of the remaining labels.
Consequently,

\[
 O_{n,j}(t)=\sum_{r=1}^{n}\binom nr
 t^{[r\ge j]}O_{n-r,j}(t).
\]

This argument proves the recurrence directly from the definition. With

\[
 B_j(z,t)=\sum_{r=1}^{j-1}\frac{z^r}{r!}
       +t\sum_{r=j}^{\infty}\frac{z^r}{r!},
\]

the same list decomposition gives `sum_n O_(n,j)(t) z^n/n! = 1/(1-B_j(z,t))`.
Use both descriptions when deriving additional identities. At threshold three,
the initial rows for `n=0,...,6` are
`1, 1, 3, 12+t, 66+9t, 450+91t, 3690+973t+20t^2`.

For an independent small-instance check, enumerate ordinary set partitions and
multiply the contribution of a partition with `b` total blocks by `b!`.
Keep the number of total blocks separate from the number of large blocks.
Multiplying the coefficient of `t^k` by `k!` instead orders only the large
blocks and defines a different family. This distinction matters when comparing
with known ordered-lift arguments.

## First local run

```bash
python experiments.py --family ordered --parameters 2 3 --n 50 --interlace-n 15 --self-check
```

The script implements the first-block recurrence and checks small rows against
weighted enumeration. Its root tests use exact integer polynomials and its
pair tests retain multiplicities. Read the resulting JSON for the tested bounds,
version information, failures, and coefficient order. A numerical plot can help
choose experiments; the persisted exact tests determine the finite conclusion.

## Useful model assignment

Ask for one identity or refined recurrence that exposes insertion of a new label
into the ordered structure. A promising question is whether tracking the total
number of blocks alongside the large-block count yields a stability-preserving
operator or a compatible family after specialization. Another is whether the
geometric-series generating function can be connected to a known real-rooted
polynomial sequence through an explicitly proved transform.

Require the model to separate identities it derives from preservation theorems
it needs. For every proposed transform, give the precise coefficient action,
the domain of polynomials on which it is claimed to work, and a small adversarial
test generated from exact integer roots. If a general preservation statement
fails, preserve that witness and consider a property of this particular orbit.
An orbit-specific invariant may still be useful even when arbitrary inputs fail.

## Expected output and budget discipline

The first paid response should contain a short candidate lemma, its reason for
being sufficient, a proof or explicit unresolved step, and code for the most
informative finite check. Aim at an all-`n` result for one fixed threshold, or an
exact counterexample, before extending the parameter range. A bounded verifier
extension is an experimental output and should be described with its exact
range. Reuse the shared coefficient and root-checking infrastructure; additional
framework construction is justified by a measured obstruction. Close a branch
when successive responses merely restate its existing proof gap.
