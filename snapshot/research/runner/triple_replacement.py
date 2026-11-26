"""Scan selected three-deletion, two-insertion problems using the exact two-speed solver."""
import json
from fractions import Fraction
from heapq import nsmallest
from itertools import combinations
from pathlib import Path

from single_replacement import low_coverage, merge, poliakova
from two_speed_search import search


def subsets(triple):
    for size in range(4):
        yield from combinations(triple, size)


def trial(seed, count=12, cap=2500):
    target = len(seed) - 1
    d = Fraction(1, len(seed))
    bins = low_coverage(seed, d, max_removed=3)
    cells = {ids: sum(a < b for a, b in items) for ids, items in bins.items()}
    choices = nsmallest(count, combinations(range(len(seed)), 3),
                        key=lambda ids: (sum(cells.get(s, 0) for s in subsets(ids)), ids))
    results = []
    for ids in choices:
        H = merge([interval for s in subsets(ids) for interval in bins[s]])
        survivors = [p for i, p in enumerate(seed) if i not in ids]
        result = search(H, d, [v for v, _ in survivors], cap)
        if result['status'] == 'FOUND':
            extra = [(result['v'], result['s']), (result['w'], result['b'])]
            assert not low_coverage(survivors + extra, d, max_removed=0)[()]
        results.append(dict(removed=[seed[i][0] for i in ids], components=len(H),
                            longest=str(max(b-a for a,b in H)), **result))
    return dict(target=target, radius=str(d), cases=results)


if __name__ == '__main__':
    runs = [trial([(v, Fraction(0)) for v in range(1, 60)]), trial(poliakova())]
    out = Path(__file__).with_suffix('.json')
    out.write_text(json.dumps(runs, default=str, indent=2) + '\n')
    for row in runs:
        from collections import Counter
        print(row['target'], dict(Counter(c['status'] for c in row['cases'])))
