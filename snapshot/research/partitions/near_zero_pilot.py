"""Measure the nearest negative real root against the proposed asymptotic scale."""
from collections import deque
from math import comb, exp
from flint import ctx, fmpz_poly
from scipy.optimize import brentq

ctx.prec = 96
x = fmpz_poly([0, 1])
rows = deque([fmpz_poly([1])], maxlen=4)
targets = {64, 128, 256, 512, 1024}
for n in range(max(targets)):
    p = rows[-1]
    q = p + x*p.derivative()
    if n >= 1:
        q += n*rows[-2]
    if n >= 2:
        q += comb(n, 2)*rows[-3]
    if n >= 3:
        q += comb(n, 3)*x*rows[-4]
    rows.append(q)
    if n+1 in targets:
        roots = q.complex_roots()
        assert all(m == 1 and z.imag.is_zero() and z.real < 0 for z,m in roots)
        nearest = min(-z.real for z,m in roots)
        r = brentq(lambda t: t+t*t+t**3/2-n-1, 0, n+1)
        print(n+1, float(nearest), float(nearest)/(r*exp(-r)), flush=True)
