# Partition certificates

Run from the directory containing [partitions.tex](../partitions.tex) with Python 3.11 or later. The recorded replay used Python 3.14, python-flint 0.9.0 and SciPy 1.17.1.

```sh
python3 -m venv /tmp/mathlab-partitions-venv
/tmp/mathlab-partitions-venv/bin/python -m pip install -r reproduction/requirements.txt
/tmp/mathlab-partitions-venv/bin/python reproduce.py --out /tmp/mathlab-partitions-replay
```

Use `--only saddle`, `--only finite`, `--only outer`, `--only inner` or `--only factorial-lift` to run one check. Replay is serial. It uses temporary copies because two historical scripts write their JSON beside their source. The full finite replay was 90.42 seconds in the frozen run. Time varies by machine. The runner checks the frozen records apart from their wall times. A toolchain with different interval software or proposal heuristics can produce a different valid cover, so use the pinned versions to compare the reports exactly.

The default source is [the frozen partition research folder](../../../snapshot/research/partitions). A differently located copy of the frozen tree can be supplied with `--snapshot`. From the frozen tree one can also check every archived file against [the manifest](../../../snapshot.sha256) using `shasum -a 256 -c ../snapshot.sha256`.

| Computation | Verified conclusion | Recorded result |
| --- | --- | --- |
| `saddle_certificate.py` | Every radius in $[1/16,32]$ has the stipulated unique upper global minimum, certified angular curvature and signs, and angle below $\pi/4$. The phase mass on $[1,32]$ is enclosed by $0.8270862\pm0.000000065$. | [Replay](saddle-certificate.json) |
| `bracket_interlacing.py 4 2004 --max-lag 4` | Every row $4\le n\le2004$ has all simple negative roots. Lag one through four has $2000,1999,1998,1997$ strict pairs. | [Frozen full run](../../../snapshot/research/partitions/finite_2004_window.json) |
| `effective_outer.py` | Entire dyadic covers for $0\le500/m\le1$, signs and a complex-modulus count for the first five ranks, plus directed displacement for gaps through four. | [Replay](effective-outer.json) |
| `effective_inner.py` | Positive Taylor coefficients under the endpoint translation through row $2004$, with explicit real-saddle constant inequalities used for $n\ge2000$. | [Replay](effective-inner.json) |
| `reproduce.py --only factorial-lift` | The first failure of real-rootedness of the factorially weighted threshold-four polynomial is $n=11$. | [Replay](factorial-lift.json) |

The new full finite replay logged a completed [row-1800 checkpoint](finite-replay-checkpoint-1800.json) before the host restarted, so it did not emit its final aggregate. A serial [overlap replay](finite-tail-2004.json) certified rows $1793$ through $2004$, with all $208$ comparisons per lag ending in rows $1797$ through $2004$. The original complete aggregate remains in the frozen archive. The other three main computations each completed in the new replay, and their recorded results match the frozen outputs byte for byte.

To reproduce the overlapping tail directly from the root of the release:

```sh
python3 snapshot/research/partitions/bracket_interlacing.py 1797 2004 --max-lag 4
```

Signs evaluated with Arb are enclosures, including those at dyadic binary64 endpoints proposed by the predictor. Opposite signs and disjoint brackets that exhaust the degree certify one simple root per bracket. Arb and FLINT are the rigorous interval and exact polynomial kernels respectively. The floating-point phase and Airy pilots in the archive provide exploratory diagnostics. Neither the saddle proofs nor the listed computations have a Lean proof.

## Build the paper

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error partitions.tex
```

The [versioned release](https://github.com/F1Justin/MathLab/tree/v1.0.0) also contains a [downloadable dyadic interval certificate and independent reader](https://github.com/F1Justin/MathLab/tree/v1.0.0/certificates/partitions). The reader rebuilt the integer polynomials, verified both endpoint signs in each of 501,501 intervals, and checked all 7,994 strict pair orders. It uses no root predictor or root-isolation routine.
