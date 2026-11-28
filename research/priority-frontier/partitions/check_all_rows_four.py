"""Threshold-four fold certificate. Requires python-flint 0.9.0.

All pass/fail decisions use outward-rounded Arb bounds. Binary endpoints only
generate a cover. See all_rows_four.md for the normalization and definitions.
"""

import math
from collections import Counter
from flint import arb, acb, ctx

ctx.prec = 72
ONE = arb(1)
ZERO = arb(0)
I = acb(0, 1)
PI = arb.pi()


def box(a, b):
    return arb(a).union(arb(b))


def pos(z):
    return max(z.lower(), ZERO).union(max(z.upper(), ZERO))


def horner(c, z):
    t = c[-1]
    for a in reversed(c[:-1]):
        t = a + t * z
    return t


def abserr(t):
    return acb(arb(0, t), arb(0, t))


SINC = [(-1) ** i * ONE / math.factorial(2 * i + 1) for i in range(12)]
DCOS = [(-1) ** i * (2 * i + 2) * ONE / math.factorial(2 * i + 3) for i in range(12)]
ER1 = arb(0, PI**24 / math.factorial(25))
ER2 = arb(0, 26 * PI**24 / math.factorial(27))
E3 = [ONE / math.factorial(3 + i) for i in range(25)]
ER3 = abserr(2 * arb(7) ** 25 / math.factorial(28))
L3 = [(-1) ** i * ONE / (i + 3) for i in range(30)]
ER4 = abserr((ONE * 11 / 20) ** 30 / (33 * (1 - ONE * 11 / 20)))


# All remainder bounds are for |b|<=7 and |b/z|<=11/20; below algebraically or checked.
def parameters(p, y):
    y2 = y * y
    ss = horner(SINC, y2) + ER1
    sc = horner(DCOS, y2) + ER2
    sy, cy = y.sin(), y.cos()
    z = 1 + I * p * y
    den = 3 * ONE / 2 + 2 * p + p * p * (1 - y2 / 2)
    d0 = (p * cy + ss) / den
    d = p * d0
    Q = ss - (1 + p) * d0
    curvature_over_y = (sc - 2 * Q * p * p / (1 + (p * y) ** 2)) * y + I * (
        d - ss - 2 * p * Q / (1 + (p * y) ** 2)
    )
    # Q is positive, but checking a superset of the true stationary domain is fine.
    expo = acb(cy, sy)
    G1 = d / 6
    G2 = -expo
    G3 = -p * Q * z.conjugate() / z**2
    delta = pos(1 - y / (14 * ONE / 5)) / 2
    return z, curvature_over_y, G1, G2, G3, p / z, delta, d, Q


def cubic_factor(b, A, B, C, pz):
    w = b * pz
    if not (abs(b) < 7 and abs(w) < 11 * ONE / 20):
        raise ValueError(("series domain", abs(b), abs(w)))
    e = horner(E3, b) + ER3
    return A + B * e + C * (horner(L3, w) + ER4)


def profile(ad):
    if ad.upper() <= 1:
        return ONE, ONE
    if ad.lower() >= 2:
        return ZERO, ZERO
    # profile factor and negative displacement slope
    if ad.lower() >= 1 and ad.upper() <= 2:
        return 2 / ad - 1, -ONE
    if ad.lower() >= 1:
        return pos(2 / ad - 1), box(-1, 0)
    if ad.upper() <= 2:
        v = box(1, ad.upper())
        return (2 / v - 1).union(ONE), box(-1, 1)
    return box(0, 1), box(-1, 1)


def envelope(p_range, y_range, offset_range, negative_offset):
    p = box(*p_range)
    y = box(*y_range)
    x = box(*offset_range)
    z, C, A, B, L, pz, D, bb, Q = parameters(p, y)
    if bb < 0:
        return True
    if negative_offset:
        dr = -y * x
    else:
        dr = x
        if dr.lower() + y.lower() > 6:
            return True
    k, _ = profile(abs(dr))
    t = I - D * k
    b = dr * t
    try:
        g = cubic_factor(b, A, B, L, pz)
    except ValueError:
        return False
    a = (C * t * t / 2).real
    b3 = (t**3 * g).real
    if negative_offset:
        return a - x * b3 < -ONE / 40
    if b3 <= 0 and a < -ONE / 40:
        return True
    return (a + ONE / 40) * y + dr * b3 < 0


def envelope_cover():
    co = Counter()
    for negative_offset in (True, False):
        st = [
            (
                (0, 1 / 12 + 1e-15),
                (0, math.pi + 1e-15),
                (0, 1 if negative_offset else 6),
            )
        ]
        while st:
            seg = st.pop()
            if envelope(*seg, negative_offset):
                co["boxes"] += 1
                continue
            weights = [7, 1, 2.3 if negative_offset else 0.8]
            idx = max(range(3), key=lambda i: (seg[i][1] - seg[i][0]) * weights[i])
            a, b = seg[idx]
            m = (a + b) / 2
            if b - a < 1e-5:
                raise ArithmeticError(("envelope", seg, negative_offset))
            for w in ((a, m), (m, b)):
                st.append(seg[:idx] + (w,) + seg[idx + 1 :])
    print("envelope", dict(co), flush=True)


def beta(p, d):
    if p.lower() <= 0:
        e = box(0, (-1 / p.upper()).exp().upper())
    else:
        e = (-1 / p).exp()
    return d - e


def central_integral(seg, sn=8):
    p, y, h = [box(*a) for a in seg]
    z, C, A, B, L, pz, D, d, Q = parameters(p, y)
    bta = beta(p, d)
    eta = h * y
    if (
        bta < 0
        or bta.upper() < (y**3 * h**2).lower()
        or bta.lower() > (y**3 * h**2).upper()
    ):
        return "empty"
    if not (12 * eta + y < 6):
        return None
    lowest = arb(0)
    for j in range(-12 * sn, 12 * sn):
        s = arb(2 * j + 1, 1) / (2 * sn)
        vcheck = 1 + h * s
        if vcheck.upper() < 0:
            continue
        ad = abs(s * eta)
        k, sl = profile(ad)
        sc = (I - D * k) * s
        b = sc * eta
        try:
            g = cubic_factor(b, A, B, L, pz)
        except ValueError:
            return None
        H = C * sc**2 / 2 + h * sc**3 * g
        e = H.real
        emax = (-(s**2) / 40).upper()
        # global envelope certificate allows this one-sided clipping
        if e.upper() > emax:
            e = box(min(e.lower(), emax), emax)
        amp = (1 + I * D * sl) / (z + p * b)
        val = (amp.real * H.imag.cos() - amp.imag * H.imag.sin()) * e.exp()
        lo = val.lower()
        if vcheck.lower() < 0:
            lo = min(ZERO, lo)
        lowest += lo
    return lowest / sn


def integral_cover(N=8):
    co = Counter()
    st = [((0, 1 / 12 + 1e-15), (0, math.pi + 1e-15), (0, 0.52000000000001))]
    while st:
        seg = st.pop()
        v = central_integral(seg, N)
        if v == "empty":
            co["empty"] += 1
            continue
        if v is not None and v > ONE / 2:
            co["integral"] += 1
            continue
        weights = [10, 1, 3.5]
        idx = max(range(3), key=lambda i: (seg[i][1] - seg[i][0]) * weights[i])
        a, b = seg[idx]
        m = (a + b) / 2
        if b - a < 1e-5:
            raise ArithmeticError(("int", seg, v))
        for w in ((a, m), (m, b)):
            st.append(seg[:idx] + (w,) + seg[idx + 1 :])
        co["split"] += 1
    print("integral", dict(co), flush=True)


def remote_arcs():
    p = box(0, ONE / 12)
    for ymax, goal in [(ONE * 23 / 10, 6 * ONE), (PI, 5 * ONE / 2)]:
        y = box(0, ymax)
        w = (1 + (p * y) ** 2).sqrt()
        for i in range(1600):
            theta = PI * (ONE / 3 + (2 * ONE / 3) * box(i, i + 1) / 1600)
            c1, c2, c3 = theta.cos(), (2 * theta).cos(), (3 * theta).cos()
            # These three nonnegative coefficients are multiplied by 1, a, a^2.
            q1, q2, q3 = pos(1 - c1), pos(1 - c2), pos(1 - c3)
            correction = (
                ONE / 2
                + (w * w + w + 1) * c3 / (6 * (w + 1))
                + p * (1 + c2) / 2
                + p**2 * c1 / (w + 1)
            )
            loss = q1 + 6 * q2 + 24 * q3 - y**2 * correction
            assert loss > goal, (i, ymax, loss)
    assert (23 * ONE / 10) / (23 * ONE / 20).tan() < 11 * ONE / 10
    assert 12 * (1 - (-13 * ONE / 12).exp()) > 78 * ONE / 10
    assert 241 * (-arb(12)).exp() < ONE / 500
    assert (PI + 1) * PI.sqrt() * 12 ** (3 * ONE / 2) * (-72 * ONE / 10).exp() / (
        10 * ONE.exp()
    ).sqrt() < ONE / 20
    assert (arb(24) / 23) * (5 * ONE / 4).sqrt() * arb(40) / 12 * (
        -144 * ONE / 40
    ).exp() < 11 * ONE / 100
    print("Remote-arc and omitted Gaussian-tail bounds verified.")


if __name__ == "__main__":
    assert arb(1 / 12 + 1e-15) > ONE / 12 and arb(math.pi + 1e-15) > PI
    assert arb(0.52000000000001) > 13 * ONE / 25
    remote_arcs()
    envelope_cover()
    integral_cover()
