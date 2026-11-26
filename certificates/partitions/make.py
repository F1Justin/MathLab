"""Export every certified interval as exact binary64 endpoints in row order."""
from pathlib import Path
import gzip,struct,sys
ROOT=Path(__file__).resolve().parents[2]
sys.dont_write_bytecode=True
sys.path.insert(0,str(ROOT/'snapshot/research/partitions'))
import bracket_interlacing as finder
from collections import deque
from math import comb
from flint import fmpz_poly

def generate(out):
    rows=deque([fmpz_poly([1])],maxlen=4)
    x=fmpz_poly([0,1])
    history=deque(maxlen=8)
    for n in range(2004):
        p=rows[-1]
        q=p+x*p.derivative()
        for lag in (1,2):
            if n>=lag:q+=comb(n,lag)*rows[-lag-1]
        if n>=3:q+=comb(n,3)*x*rows[-4]
        rows.append(q)
        if n+1<4:continue
        if len(history)<8 or q.degree()<12:
            centers,bounds=finder.isolate_seed(q)
        else:
            centers,bounds,_=finder.certify(q,finder.predict(history[0],history[4],q.degree()))
        for a,b in bounds:out.write(struct.pack('<dd',a,b))
        history.append(centers)

if __name__=='__main__':
    path=Path(__file__).with_name('rows4-2004.bin.gz')
    with path.with_suffix('.tmp').open('wb') as f:
        with gzip.GzipFile(filename='',mode='wb',fileobj=f,mtime=0) as z:generate(z)
    path.with_suffix('.tmp').replace(path)
