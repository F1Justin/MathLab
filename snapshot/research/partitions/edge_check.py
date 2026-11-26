"""Exact verification of brackets suggested by the large-modulus asymptotic."""
import json
import sys
from pathlib import Path

import mpmath as mp

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "package1"))
from experiments import partition_rows_short


def limiting_x(r, k):
    if r == 0:
        return (k-mp.mpf("0.5"))*mp.pi
    if r == 2:
        return k*mp.pi
    if r == 1:
        return mp.findroot(lambda x: mp.tan(x)+mp.tanh(x), (k-mp.mpf(".25"))*mp.pi)
    return mp.findroot(lambda x: mp.tan(x)-mp.tanh(x), (k+mp.mpf(".25"))*mp.pi)


def evaluate(row, t):
    value = 0
    for coeff in reversed(row):
        value = value*t+coeff
    return value


def tail_variations(row, bound):
    # Descartes on P(-bound-x), x>0, counts with multiplicity up to an even deficit.
    shift = list(row)
    for i in range(1,len(shift)):
        for j in range(len(shift)-2,i-2,-1):
            shift[j] -= bound*shift[j+1]
    signs = [((1 if c>0 else -1) * (-1)**i) for i,c in enumerate(shift) if c]
    return sum(a != b for a,b in zip(signs,signs[1:]))


def brackets(row, n, K):
    # Search in |t|, retain disjoint sign changes. Certify count in the outer tail.
    m,r = divmod(n,4)
    scale = mp.mpf(24)*m**5/625
    preds = [scale/(4*limiting_x(r,k)**4) for k in range(1,K+2)]
    upper = int(max(16*preds[0], 16*row[-2]//row[-1]))+1
    while tail_variations(row,upper):
        upper *= 2
    points = [upper]
    while len(points) < 3000 and points[-1] > 1:
        points.append(max(1,int(points[-1]*99//100)))
        if points[-1]==points[-2]:
            points[-1] -= 1
    intervals = []
    last = evaluate(row,-points[0])
    for hi,lo in zip(points,points[1:]):
        val = evaluate(row,-lo)
        if last*val < 0:
            a,b=lo,hi
            while b-a>1:
                mid=(a+b)//2
                if evaluate(row,-a)*evaluate(row,-mid)>0:
                    a=mid
                else:
                    b=mid
            assert evaluate(row,-a)*evaluate(row,-b)<0
            intervals.append([a,b])
            if len(intervals)==K:
                assert tail_variations(row,lo)==K
                return dict(n=n, magnitudes=intervals,
                            observed_over_prediction=[float(sum(iv)/(2*p)) for iv,p in zip(intervals,preds)])
        last=val
    raise ValueError(f"Could not isolate {K} roots at n={n}")


if __name__ == "__main__":
    mp.mp.dps=40
    records=[]
    for m in [20,50,100,200]:
        window=4*m
        rows=partition_rows_short(window+4,4)
        block=[brackets(rows[n],n,2) for n in range(window,window+5)]
        for i in range(4):
            a,b=block[i]["magnitudes"],block[i+1]["magnitudes"]
            first,second=(a,b) if i<3 else (b,a)
            assert first[0][0]>second[0][1]>second[0][0]>first[1][1]
            assert first[1][0]>second[1][1]
        records.extend(block)
    print(json.dumps(records,indent=2))
