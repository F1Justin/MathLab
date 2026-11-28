"""All four directed row-gap tests for the threshold-four polynomial.

Run with python-flint 0.9.0. The envelope and bulk tests are replayed before
they are used to certify the four normalized inner-contour insertions.
"""

import check_effective_bulk as bulk
import check_all_rows_four as f
from flint import arb, acb
import math
from collections import Counter

ONE = f.ONE
I = f.I
PI = f.PI
ZERO = f.ZERO


def verify_inner_box(seg, sn):
    p, y, h = [f.box(*iv) for iv in seg]
    z, C, A, B, L, pz, D, d, Q = f.parameters(p, y)
    bta = f.beta(p, d)
    if (
        bta < 0
        or bta.upper() < (y**3 * h**2).lower()
        or bta.lower() > (y**3 * h**2).upper()
    ):
        return "empty"
    try:
        action = f.cubic_factor(-I * y, A, B, L, pz).real - C.imag / 2
    except ValueError:
        return False
    if action.upper() < (h * h).lower():
        return "empty"
    # scalar test for terminal Theta=-1 as well as positivity of Re U.
    Eta = h * y
    Z = z.conjugate()
    v = (p * y) ** 2
    pref = [None] + [
        Z**l / (z * sl) for l, sl in enumerate([1, 1, 2, 3 - v, 4 * (1 - v)]) if l
    ]
    tots = [acb(0) for i in range(5)]
    for j in range(-16 * sn, 16 * sn):
        s = arb(2 * j + 1, 1) / (2 * sn)
        vf = 1 + h * s
        vfac = y + Eta * s
        if vf.upper() < 0 or vfac.lower() > 6:
            continue
        ad = abs(s * Eta)
        k, sl = f.profile(ad)
        T = (I - D * k) * s
        b = T * Eta
        try:
            g = f.cubic_factor(b, A, B, L, pz)
        except ValueError:
            return False
        H = C * T**2 / 2 + h * T**3 * g
        e = H.real
        emax = (-(s**2) / 40).upper()
        if e.upper() > emax:
            e = f.box(min(e.lower(), emax), emax)
        amp = (1 + I * D * sl) / (z + p * b)
        a = amp * acb(H.imag.cos(), H.imag.sin()) * e.exp()
        zinv = 1 / (1 + pz * b)
        sm = acb(0)
        poww = acb(1)
        vals = [a]
        w0 = a * T * h
        for l in (1, 2, 3, 4):
            poww *= zinv
            sm += poww
            vals.append(w0 * pref[l] * sm)
        if vf.lower() < 0 or vfac.upper() > 6:
            vals = [acb(f.box(ZERO, vi.real), f.box(ZERO, vi.imag)) for vi in vals]
        for l in range(5):
            tots[l] += vals[l]
    U = tots[0] / sn
    # Real and imaginary uncertainty of whole contour <= 0.025 for U and
    # < .20 for each root shift after removing its saddle value.
    E = arb(0, ONE / 40)
    U += acb(E, E)
    if not (U.real > 0 and (U.real * ONE.cos() + U.imag * ONE.sin()) > 0):
        return False
    # |V_l|<Re U suffices: the determinant's reference contribution is |U|^2.
    for l in (1, 2, 3, 4):
        if not abs(tots[l] / sn) + ONE / 5 < U.real:
            return False
    return True


def inner_cover():
    N = 8
    c = Counter()
    st = [((0, 1 / 12 + 1e-15), (0, math.pi + 1e-15), (0, 0.900000000001))]
    while st:
        seg = st.pop()
        ok = verify_inner_box(seg, N)
        if ok == "empty":
            c["empty"] += 1
            continue
        if ok is True:
            c["passed"] += 1
            continue
        weights = [10, 1, 3.5]
        i = max(range(3), key=lambda i: (seg[i][1] - seg[i][0]) * weights[i])
        a, b = seg[i]
        m = (a + b) / 2
        if b - a < 1e-6:
            raise ArithmeticError(seg)
        for w in ((a, m), (m, b)):
            st.append(seg[:i] + (w,) + seg[i + 1 :])
        c["split"] += 1
    print("Inner shift and terminal signs certified.", dict(c))


def tail_bounds():
    # t = Lambda/a exceeds 18/13; every factor below decreases from a=12,
    # t=18/13 over its respective range.
    a = arb(12)
    t = 18 * ONE / 13
    r = (1 + (PI / 12) ** 2).sqrt()
    shape = (24 * ONE / 23) * (5 * ONE / 4).sqrt()
    scalar_close = (
        (PI + 1)
        * PI.sqrt()
        * a ** (3 * ONE / 2)
        * (-3 * a / 5).exp()
        * t.sqrt()
        * (-5 * t).exp()
    )
    scalar_tail = shape * (40 * ONE / 16) * (-256 * ONE / 40).exp()
    assert scalar_close + scalar_tail < ONE / 40
    coeff = r**3 / (1 - (PI / 12) ** 2) * (24 * r / 23) ** 4 * (5 * ONE / 4).sqrt()
    flux_tail = shape * coeff * (9 * ONE / 10) * 40 * (-256 * ONE / 40).exp()
    flux_close = (
        2
        * r
        * (PI + 1)
        * PI.sqrt()
        * a ** (17 * ONE / 6)
        * (-3 * a / 5).exp()
        * t ** (5 * ONE / 6)
        * (-5 * t).exp()
    )
    assert flux_tail + flux_close < ONE / 5


if __name__ == "__main__":
    bulk.main(higher_shifts=True)
    f.remote_arcs()
    f.envelope_cover()
    tail_bounds()
    inner_cover()
