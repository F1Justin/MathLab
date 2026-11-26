#!/usr/bin/env python3
"""Exact, offline baselines for three polynomial research families.

Coefficient arrays are in ascending order. No model/API calls are made.
References and the status of conjectures are in README.md / tasks/.
"""
import argparse
import hashlib
import itertools
import json
import math
import platform
import time
from pathlib import Path

import sympy as sp

X = sp.Symbol("x")


def add_scaled(dst, src, scale=1, shift=0):
    while len(dst) < len(src) + shift:
        dst.append(0)
    for i, v in enumerate(src):
        dst[i + shift] += scale * v


def trim(p):
    while len(p) > 1 and p[-1] == 0:
        p.pop()
    return p


def multiply(a, b):
    c = [0] * (len(a) + len(b) - 1)
    for i, u in enumerate(a):
        add_scaled(c, b, u, i)
    return trim(c)


def partition_rows(N, j, ordered=False):
    """Choose the block containing 1, or the first block if ordered."""
    rows = [[1]]
    for n in range(1, N + 1):
        row = [0]
        for m in range(1, n + 1):
            weight = math.comb(n if ordered else n - 1, m if ordered else m - 1)
            add_scaled(row, rows[n - m], weight, int(m >= j))
        rows.append(trim(row))
    return rows


def partition_rows_short(N, j):
    """Independent insertion/derivative recurrence from Zhan 2023."""
    rows = [[1]]
    for n in range(N):
        row = [i * a for i, a in enumerate(rows[n])]
        for i in range(min(n, j - 2) + 1):
            add_scaled(row, rows[n - i], math.comb(n, i))
        if n >= j - 1:
            add_scaled(row, rows[n - j + 1], math.comb(n, j - 1), 1)
        rows.append(trim(row))
    return rows


def eulerian_rows(N):
    rows = [[1]]
    for n in range(1, N + 1):
        row = [0] * n
        for d in range(n):
            if d < len(rows[-1]):
                row[d] += (d + 1) * rows[-1][d]
            if d:
                row[d] += (n - d) * rows[-1][d - 1]
        rows.append(row)
    return rows


def cycle_rows(N, k):
    """No cycles shorter than k; weight by number of excedances."""
    A = eulerian_rows(N)
    rows = [[1]]
    for n in range(1, N + 1):
        row = [0]
        for m in range(k, n + 1):
            add_scaled(row, multiply([0] + A[m - 1], rows[n - m]),
                       math.comb(n - 1, m - 1))
        rows.append(trim(row))
    return rows


def brute_partition_row(n, j, ordered=False):
    """Enumerate restricted-growth strings; independent of recurrences."""
    counts = [0] * (n // j + 1)
    def visit(sizes, left):
        if left == 0:
            counts[sum(s >= j for s in sizes)] += math.factorial(len(sizes)) if ordered else 1
            return
        for i in range(len(sizes)):
            sizes[i] += 1
            visit(sizes, left - 1)
            sizes[i] -= 1
        visit(sizes + [1], left - 1)
    visit([], n)
    return trim(counts)


def brute_cycle_row(n, k):
    counts = [0] * max(n, 1)
    for p in itertools.permutations(range(n)):
        seen = set()
        valid = True
        for i in range(n):
            if i in seen:
                continue
            v, length = i, 0
            while v not in seen:
                seen.add(v)
                length += 1
                v = p[v]
            if length < k:
                valid = False
                break
        if valid:
            counts[sum(v > i for i, v in enumerate(p))] += 1
    return trim(counts)


def poly(coeffs):
    return sp.Poly.from_list(coeffs[::-1], X, domain=sp.ZZ)


def real_nonpositive(coeffs):
    f = poly(coeffs)
    if f.is_zero:
        return None
    q = f.sqf_part()
    return bool(q.count_roots(-sp.oo, 0) == q.degree())


def interleaves(a, b):
    """Exact directed weak interleaving, SymCat convention.

    Joint rational isolating intervals order distinct roots, and their
    multiplicity dictionaries identify common roots without floats.
    """
    f, g = poly(a), poly(b)
    if f.is_zero or g.is_zero:
        return True
    d, e = f.degree(), g.degree()
    if e not in (d, d + 1):
        return False
    roots = [[], []]
    for rank, (_, mults) in enumerate(sp.intervals([f.as_expr(), g.as_expr()])):
        for which, multiplicity in mults.items():
            roots[which].extend([rank] * multiplicity)
    if [len(r) for r in roots] != [d, e]:
        return False
    r, s = roots
    if e == d:
        return all(r[i] <= s[i] for i in range(d)) and all(s[i] <= r[i+1] for i in range(d-1))
    return all(s[i] <= r[i] <= s[i+1] for i in range(d))


def sanity_checks():
    # Include non-real, common-root, multiplicity, and wrong-direction controls.
    assert real_nonpositive([1, 0, 1]) is False
    assert real_nonpositive([1, 2, 1]) is True
    assert real_nonpositive([-1, 1]) is False
    assert interleaves([2, 3, 1], [3, 4, 1]) is False
    assert interleaves([3, 4, 1], [2, 3, 1]) is True
    assert interleaves([1, 2, 1], [2, 3, 1]) is False
    assert interleaves([2, 3, 1], [1, 2, 1]) is True
    assert interleaves([1, 0, 1], [1, 2, 1]) is False
    for j in (2, 3, 4):
        rows = partition_rows(7, j)
        assert rows == partition_rows_short(7, j)
        for ordered in (False, True):
            rs = partition_rows(7, j, ordered)
            for n in range(8):
                assert rs[n] == brute_partition_row(n, j, ordered)
        rs = cycle_rows(7, j)
        for n in range(8):
            assert rs[n] == brute_cycle_row(n, j)


def run(family, j, N, interlace_n, out):
    started = time.perf_counter()
    rows = cycle_rows(N, j) if family == 'cycles' else partition_rows(N, j, family == 'ordered')
    if family == 'partitions':
        assert rows == partition_rows_short(N, j), 'Independent coefficient generators disagree'
    failures, root_tests, pair_tests = [], 0, 0
    for n in range(j, N + 1):
        if n % 20 == 0:
            print(json.dumps({'progress': family, 'parameter': j, 'n': n,
                              'elapsed_seconds': round(time.perf_counter()-started, 3)}), flush=True)
        root_tests += 1
        if real_nonpositive(rows[n]) is not True:
            failures.append({'n': n, 'property': 'real_nonpositive'})
        if n < min(N, interlace_n):
            pair_tests += 1
            if not interleaves(rows[n], rows[n + 1]):
                failures.append({'n': n, 'property': 'directed_weak_interleaving'})
    data = {'family': family, 'parameter': j, 'max_n': N,
            'root_tests': root_tests, 'interlacing_pairs': pair_tests,
            'interlacing_through_n': min(N, interlace_n), 'failures': failures,
            'elapsed_seconds': round(time.perf_counter() - started, 3),
            'coefficients_order': 'ascending',
            'coefficients': [[str(c) for c in r] for r in rows],
            'sympy_version': sp.__version__, 'python_version': platform.python_version(),
            'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'scope': 'Finite exact computation only; no general proof or novelty claim.'}
    path = out / f'{family}_{j}_n{N}.json'
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps({k:v for k,v in data.items() if k != 'coefficients'}), flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--family', choices=['partitions', 'ordered', 'cycles'], default='partitions')
    parser.add_argument('--parameters', type=int, nargs='+', default=[4])
    parser.add_argument('--n', type=int, default=80)
    parser.add_argument('--interlace-n', type=int, default=15)
    parser.add_argument('--out', type=Path, default=Path('results'))
    parser.add_argument('--self-check', action='store_true')
    args = parser.parse_args()
    if args.self_check:
        sanity_checks()
        print('Definition-level and exact-verifier controls passed.', flush=True)
    if args.n < 1 or any(j < 2 for j in args.parameters):
        parser.error('Use n >= 1 and parameters >= 2')
    args.out.mkdir(parents=True, exist_ok=True)
    for j in args.parameters:
        run(args.family, j, args.n, args.interlace_n, args.out)


if __name__ == '__main__':
    main()
