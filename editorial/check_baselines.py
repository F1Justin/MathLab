"""Replay the small exact polynomial controls in the pre-publication package."""
from pathlib import Path
import json
import sys
root = Path(__file__).resolve().parents[1] / 'snapshot' / 'package1'
sys.dont_write_bytecode = True
sys.path.insert(0, str(root))
import experiments as exp
exp.sanity_checks()
for file in sorted((root / 'results').glob('*_n*.json')):
    record = json.loads(file.read_text())
    family, j, n = (record[k] for k in ('family', 'parameter', 'max_n'))
    rows = (exp.cycle_rows(n, j) if family == 'cycles'
            else exp.partition_rows(n, j, ordered=(family=='ordered')))
    assert rows == [list(map(int,row)) for row in record['coefficients']]
    if family == 'partitions':
        assert rows == exp.partition_rows_short(n,j)
    assert all(exp.real_nonpositive(p) for p in rows[j:])
    m = record['interlacing_through_n']
    assert all(exp.interleaves(rows[k],rows[k+1]) for k in range(j,m))
    print(f'{family} j={j}: exact rows {j}..{n}, adjacent interleaving ending at {m}',flush=True)
