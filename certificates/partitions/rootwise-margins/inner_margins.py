"""Interval checks of Q(r)/(r P'(r)) for the two innermost roots; python-flint 0.9.0."""
import argparse
import gzip
import struct
from math import comb
from pathlib import Path
from flint import arb, arb_poly, ctx, fmpz_poly


def evaluate_pair(n, p, q, bounds):
    with ctx.workprec(512):
        P, Q = arb_poly(p), arb_poly(q)
        derivative = P.derivative()
        for k in (1, 2):
            left, right = map(arb, bounds[-k])
            sign = (-1)**k
            if not (sign*P(left)>0 and sign*P(right)<0):
                raise ArithmeticError("Uncertified input bracket")
            for _ in range(100):
                mid = (left+right)/2
                value = sign*P(mid)
                if value>0:
                    left = mid
                elif value<0:
                    right = mid
                else:
                    break
            root = left.union(right)
            margin = Q(root)/(root*derivative(root))
            if not margin.is_finite() or margin.rel_accuracy_bits() < 45:
                raise ArithmeticError("Insufficient enclosure precision")
            print(n,k,margin.str(12))


def run(certificate):
    rows = [fmpz_poly([1])]
    x = fmpz_poly([0,1])
    with gzip.open(certificate,'rb') as stream:
        for n in range(2001):
            p = rows[-1]
            q = p + x*p.derivative()
            for j in range(1,min(3,n)+1):
                term = comb(n,j)*rows[-1-j]
                q += x*term if j==3 else term
            if n>=4:
                data = stream.read(16*(n//4))
                if n in (100,300,600,1200,2000):
                    evaluate_pair(n,p,q,list(struct.iter_unpack('<dd',data)))
            rows = (rows+[q])[-4:]


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('certificate',type=Path)
    run(parser.parse_args().certificate)
