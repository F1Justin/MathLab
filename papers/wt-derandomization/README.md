# A single even signed window for WT witnesses

The input is any finite joint WT law, with its actual two correlation profiles and energy budgets. The output uses one signed window and one table, both smooth, compactly supported and even about their prescribed centres. The covering length and the declared width may change. The paper proves approximation for that individual input and identifies the infimum over the smooth deterministic symmetric class. [Paper](single-even-window.pdf) · [LaTeX source](single-even-window.tex) · [Lean statements and replay](../../formal-wt/README.md)

Akwei and Williams had already identified the unrestricted, deterministic and atomwise symmetric infima. Their deterministic approximants use an asymmetric window and their symmetric approximants use a mixture. Their lower bound for a single nonnegative symmetric window explains the signed-window hypothesis. [Akwei–Williams v05](https://doi.org/10.5281/zenodo.24326518)

The two examples in Section 4 are independent integer arrays. Their convolutions interpolate linearly between grid nodes. The Python verifier checks all necessary node inequalities, supports, symmetries, masses and costs in exact arithmetic. The first array is also linked to a WT witness on the real line in Lean. From the reproduction directory run

```sh
python3 verify.py symmetric_witness.json
python3 verify.py regenerated.json
```

To regenerate the second array, give the script the directory containing the four original files `G.txt`, `H.txt`, `p.txt` and `upsilon.txt`. It checks the input matrices against their pinned hashes and rederives the rational input costs. The resulting JSON has SHA-256 `bab7515bdc143e90d7e70a8da2d4cfbc7ae7a77d0a70f621a68d7f58887592f7`. [Carter–O'Bryant–Tao source data](https://github.com/dcartermath/sidon-error/tree/ff5b032fc3745140549777a96a9ec3ba7f8dd954/asymptotic)

```sh
python3 regenerate.py /path/to/sidon-error/asymptotic --output /tmp/wt-regenerated.json
python3 verify.py /tmp/wt-regenerated.json
```
