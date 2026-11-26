"""Extract finite lower bounds for the normalized rootwise margins of RealRooted #1773.

Input format and sign/degree verification: MathLab v1.0.0 certificates/partitions.
All comparisons and bounds after decoding the dyadic endpoints use integers.
"""
import argparse
from fractions import Fraction
import gzip
from math import comb, factorial, isfinite
from pathlib import Path
from struct import iter_unpack


def read_row(stream, n):
    size = 16 * (n // 4)
    data = stream.read(size)
    if len(data) != size:
        raise ValueError(f"Truncated row {n}")
    row = []
    for left, right in iter_unpack("<dd", data):
        if not (isfinite(left) and left < right < 0):
            raise ValueError(f"Invalid interval in row {n}")
        row.append((left.as_integer_ratio(), right.as_integer_ratio()))
    return row


def leading_correction(n):
    # [z^r] exp(A) (24 B/z^4)^d through r=3.
    d, r = divmod(n, 4)
    small = [1, 1, 1, Fraction(5, 6)]
    power = [1, Fraction(d, 5),
             Fraction(d, 30) + Fraction(comb(d, 2), 25),
             Fraction(d, 210) + Fraction(d * (d - 1), 150) + Fraction(comb(d, 3), 125)]
    return sum(a*b for a, b in zip(small[:r+1], reversed(power[:r+1])))


def leading_ratio(n):
    ratio = (n+1) * Fraction(leading_correction(n+1), leading_correction(n))
    if n % 4 == 3:
        ratio /= (n//4 + 1)*factorial(4)
    return ratio


def row_bound(n, old, new):
    scale = max(den for row in (old, new) for pair in row for _, den in pair)
    def lift(row):
        return [(a*(scale//b), c*(scale//d)) for (a,b),(c,d) in row]
    p, q = lift(old), lift(new)
    grows = len(q) == len(p)+1
    first, second = (q,p) if grows else (p,q)
    if any(h >= l for (_,h),(l,_) in zip(first,second)) or any(
        h >= l for (_,h),(l,_) in zip(second,first[1:])
    ):
        raise ValueError(f"Intervals do not strictly alternate in row pair {n},{n+1}")
    best = None
    for i,(lo,hi) in enumerate(p):
        if grows:
            num = (lo-q[i][1])*(q[i+1][0]-hi)
            den = -lo*scale
        else:
            num, den = q[i][0]-hi, -lo
            if i:
                num *= lo-q[i-1][1]
                den *= hi-p[0][0]
        if best is None or num*best[1] < best[0]*den:
            best = (num, den, i+1)
    num, den, rank = best
    return Fraction(num, den)*leading_ratio(n), n, rank


def run(path):
    minima = {}
    count = 0
    with gzip.open(path,'rb') as stream:
        old = read_row(stream,4)
        for n in range(4,2004):
            new = read_row(stream,n+1)
            result = row_bound(n,old,new)
            key = n % 4
            if key not in minima or result < minima[key]:
                minima[key] = result
            count += len(old)
            old = new
        if stream.read(1):
            raise ValueError("Unexpected trailing data")
    print(f"{count} rootwise margins for n=4..2003")
    if min(entry[0] for entry in minima.values()) <= Fraction(1, 10**15):
        raise ValueError("The claimed uniform finite bound was not certified")
    for residue, (bound, n, rank) in sorted(minima.items()):
        print(f"n mod 4 = {residue}: lower bound {bound}; limiting certified interval at n={n}, rank={rank}")
    return minima


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("certificate",type=Path)
    run(parser.parse_args().certificate)
