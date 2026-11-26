"""Compare the published seed to the Palomar challenge constants using only integers."""
from pathlib import Path
import json,re
root=Path(__file__).resolve().parents[1]
src=(root/'formal/Challenge.lean').read_text()
r=json.loads((root/'snapshot/package1/results/known_slr_57.json').read_text())
s=int(re.search(r'def S : Nat := (\d+)',src)[1])
data=re.search(r'def seed : List \(Nat × Nat\) := \[(.*?)\]',src,re.S)[1]
coords=[tuple(map(int,m)) for m in re.findall(r'\((\d+),\s*(\d+)\)',data)]
assert len(coords)==len(set(r['speeds']))==57
assert [v for v,_ in coords]==r['speeds']
for (_,a),b in zip(coords,r['shift_num'],strict=True):
    assert (a*r['shift_den'] - b*s) % (s*r['shift_den'])==0
print('All 57 ordered speeds and all 57 phase classes in Challenge.lean match the frozen input exactly.')
