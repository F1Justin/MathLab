"""Exact checker for two short periodic witnesses found during the pilot.
Discovery used a finite MILP solely to propose assignments. This checker uses no
solver, floating point, or external packages.
"""
import json
from pathlib import Path
three=[[1,1,1,0,1],[0,0,1,1,1],[1,1,1,0,1]]
five_half=[
[0,1,1,0,0,1,1,0,1,0],
[0,0,0,1,1,0,0,0,2,0],
[1,1,0,0,0,1,1,0,0,0],
[0,0,1,1,0,0,0,1,0,1],
[1,1,0,0,1,1,0,1,0,1]]
five=[five_half[r]+five_half[4-r] for r in range(5)]
results=[]
for m,k,p,target,x in [(3,3,5,11,three),(5,2,20,46,five)]:
    assert len(x)==m and all(len(row)==p for row in x)
    assert all(isinstance(v,int) and 0<=v<=k for row in x for v in row)
    assert sum(map(sum,x))==target
    sums=[]
    for r in range(m):
        row=[]
        for c in range(p):
            total=x[r][c]+x[r][(c-1)%p]+x[r][(c+1)%p]
            if r>0: total+=x[r-1][c]
            if r+1<m: total+=x[r+1][c]
            assert total>=k
            row.append(total)
        sums.append(row)
    results.append({'m':m,'k':k,'period':p,'period_total_weight':target,'labels_by_row':x,'closed_neighborhood_sums':sums,'boundary':'horizontal periodic, vertical open; end corrections for a finite rectangle are separate','integer_verified':True})
    print(f'PERIODIC_WITNESS_PASS m={m} k={k} period={p} weight={target}')
results[1]['half_period_columns']=10
results[1]['half_period_weight']=23
results[1]['half_period_gluing']='alternate B and its vertical reflection'
out=Path(__file__).parent/'results'
(out/'periodic_witnesses.json').write_text(json.dumps(results,indent=2)+'\n')
