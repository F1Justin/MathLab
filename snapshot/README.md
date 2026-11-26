# Research record

This directory preserves the mathematical inputs, exploratory notes, model exchanges and computational certificates used to prepare the first publication snapshot. The papers and their referee dispositions specify the accepted claims. Historical notes use the labels and conjectural assumptions of the time they were written. Some proof attempts failed and some bounds were subsequently strengthened. Two background API tasks were still running at the cut. The public transcripts retain mathematical text and token counts, with account, transport and local-environment metadata omitted.

The coefficient experiments under package1 use SymPy 1.14.0. For the restricted cycle families with minimum cycle lengths 3, 4 and 5, root tests cover all nonzero rows through 30. For ordered partitions with thresholds 2, 3 and 4 they cover rows through 50; for unrestricted partitions at thresholds 4, 5 and 6 the baseline covers rows through 100. The baseline adjacent-pair checks end at row 15 in each family. Stronger threshold-four results appear in the partition paper. A268434 is recorded as a proposed secondary task. No new theorem on A268434 is asserted here.

For a small reproducible baseline run from the release root:

```sh
python3 -m pip install sympy==1.14.0
python3 snapshot/package1/experiments.py --family ordered --parameters 2 3 4 --n 50 --interlace-n 15 --self-check --out /tmp/mathlab-ordered
```
