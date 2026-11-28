"""Exact integer-{k} domination of P_m box P_n via full pair-column DP.

This is a research pilot, not a formal proof. The mathematical recurrence and
full-vector periodicity certificate are described in grid_certificate_notes.md.
Only integer arithmetic is used. NumPy suffix minima accelerate an exact
coordinatewise orthant query; no floating-point optimization is used.
"""
import argparse
import hashlib
import json
from pathlib import Path
from time import perf_counter

import numpy as np

INF = 1_000_000_000


def run(m, k, max_n=150, max_period=30):
    start = perf_counter()
    base = k + 1
    q = base**m
    place = base ** np.arange(m-1, -1, -1)
    cols = (np.arange(q)[:, None] // place[None, :]) % base
    weight = cols.sum(axis=1)
    vertical = cols.copy()
    vertical[:, 1:] += cols[:, :-1]
    vertical[:, :-1] += cols[:, 1:]
    # threshold[b,c] encodes the least admissible previous column a.
    threshold = (np.maximum(0, k - vertical[:, None, :] - cols[None, :, :]) * place).sum(axis=2)
    terminal = np.all(cols[:, None, :] + vertical[None, :, :] >= k, axis=2)
    d = np.full((q, q), INF, dtype=np.int64)
    d[0, :] = weight
    history = []
    values = []
    certificate = None
    certificate_vectors = None
    for n in range(1, max_n+1):
        values.append(int(np.min(d[terminal])))
        history.append(d.copy())
        if certificate is None:
            for p in range(1, min(max_period, n-1)+1):
                old = history[n-p-1]
                if not np.all(d < INF) or not np.all(old < INF):
                    continue
                inc = int(d[0, 0] - old[0, 0])
                if np.array_equal(d, old + inc):
                    certificate = {"N": n-p, "period": p, "increment": inc, "states": q*q}
                    certificate_vectors = (old.copy(), d.copy())
                    break
        # Min over a >= threshold(b,c), independently for every fixed b.
        suffix = d.reshape((*([base]*m), q))
        for axis in range(m):
            suffix = np.flip(np.minimum.accumulate(np.flip(suffix, axis=axis), axis=axis), axis=axis)
        suffix = suffix.reshape(q, q)
        d = np.minimum(INF, suffix[threshold, np.arange(q)[:, None]] + weight[None, :])
    elapsed = perf_counter() - start
    result = {
        "m": m, "k": k, "max_n": max_n, "columns": q,
        "values": values, "full_state_period_certificate": certificate,
        "elapsed_seconds": round(elapsed, 6),
        "arithmetic": "exact signed 64-bit integers; INF=10^9; finite costs <=m*k*n",
    }
    if certificate:
        for n in range(certificate["N"], max_n-certificate["period"]+1):
            assert values[n+certificate["period"]-1] == values[n-1]+certificate["increment"]
        result["finite_sanity_periodic_terminal_values"] = True
    return result, certificate_vectors


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--m", type=int, required=True)
    parser.add_argument("--k", type=int, required=True)
    parser.add_argument("--max-n", type=int, default=150)
    parser.add_argument("--out", type=Path, required=True)
    args = parser.parse_args()
    result, vectors = run(args.m, args.k, args.max_n)
    args.out.mkdir(parents=True, exist_ok=True)
    name = f"grid_m{args.m}_k{args.k}"
    if vectors:
        for label, vec in zip(("start", "end"), vectors):
            path = args.out / f"{name}_{label}.txt"
            np.savetxt(path, vec, fmt="%d")
            result[f"{label}_vector_sha256"] = hashlib.sha256(path.read_bytes()).hexdigest()
    path = args.out / f"{name}_result.json"
    path.write_text(json.dumps(result, indent=2)+"\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
