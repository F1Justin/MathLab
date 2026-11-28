"""Exact verification of a signed, symmetric WT grid certificate (Python 3.9+).

Coordinates here are the original left-endpoint coordinates of Definition 2.1.
The arguments contain integer cell masses for the window and cell heights for
the table. Each continuous convolution is linear between consecutive grid nodes.
"""

import argparse
import json
from decimal import Decimal, localcontext
from fractions import Fraction
from math import lcm
from pathlib import Path


def require(condition, description):
    if not condition:
        raise ValueError(description)


def product(a, b):
    """Multiply integer polynomials by ordinary big-integer multiplication.

    At base B each signed coefficient of the answer lies strictly in
    (-B/2,B/2). Centered digits recover it uniquely, including negative ones.
    """
    bound = min(max(map(abs, a)) * sum(map(abs, b)),
                max(map(abs, b)) * sum(map(abs, a)))
    width = max(1, (bound.bit_length() + 8) // 8)
    base = 1 << (8 * width)

    def pack(entries):
        pos = b"".join(max(0, x).to_bytes(width, "little") for x in entries)
        neg = b"".join(max(0, -x).to_bytes(width, "little") for x in entries)
        return int.from_bytes(pos, "little") - int.from_bytes(neg, "little")

    length = len(a) + len(b) - 1
    if bound == 0:
        return [0] * length
    digits = (pack(a) * pack(b)).to_bytes(width * length, "little", signed=True)
    result = []
    borrow = 0
    for start in range(0, len(digits), width):
        value = int.from_bytes(digits[start:start + width], "little") + borrow
        borrow = int(value >= base // 2)
        result.append(value - base * borrow)
    return result


def reflect_half(values):
    return values[:0:-1] + values


def verify(data):
    grid = data["cells_per_unit"]
    edge = data["cover_half_length"]
    width = data["width_cells"]
    half = data["window_center_to_right"]
    den_w = data["window_denominator"]
    den_base = data["table_denominator"]
    inv = data["repair_inverse"]
    trans = data["table_right_edge"]
    start = data["table_left_offset"]
    left = edge + data["repair_left_offset"]
    right = edge + data["repair_right_offset"]
    sigma = 2 * edge
    require(grid > 0 and den_w > 0 and den_base > 0 and inv > 0, "scales")
    require(width % 2 == 1 and 0 < width <= edge, "width and sigma")
    radius = len(half) - 1
    shoulder = (width - 1) // 2
    require(0 <= radius <= shoulder and sum(reflect_half(half)) == den_w,
            "window support or normalization")
    require(0 <= edge + start and start + len(trans) - 1 <= shoulder,
            "preliminary table support")
    require(0 < left <= right and right + radius <= edge + shoulder,
            "repair bands or support")

    # Full vectors on [0,width) and [-width,sigma); i indexes the cell whose
    # original left endpoint is i in the first and i-width in the second.
    w = [(half[abs(i - shoulder)] if abs(i - shoulder) <= radius else 0)
         for i in range(width)]
    base_table = []
    for i in range(sigma + width):
        offset = abs(i - (edge + shoulder)) - edge
        if offset < start:
            base_table.append(den_base)
        elif offset < start + len(trans):
            base_table.append(trans[offset - start])
        else:
            base_table.append(0)

    indicator = [int(left <= abs(k) <= right) for k in range(-right, right + 1)]
    repair = product(reflect_half(half), indicator)
    first = edge + shoulder - (right + radius)
    den_t = lcm(den_base, inv * den_w)
    table = [x * (den_t // den_base) for x in base_table]
    for i, value in enumerate(repair, start=first):
        table[i] += value * (den_t // (inv * den_w))

    require(w == w[::-1] and table == table[::-1], "symmetries")
    require(all(x == den_t for x in table[width:sigma]), "table plateau")
    autocorr = product(w, w[::-1])
    require(min(autocorr) >= 0, "negative autocorrelation knot")
    cross = product(w, table)
    knots = cross[width - 1:width + sigma]
    require(len(knots) == sigma + 1 and min(knots) >= den_w * den_t,
            "uncovered knot")
    beta = Fraction(grid * sum(x*x for x in w), den_w**2)
    alpha = Fraction(sum(x*x for x in table) - sigma * den_t**2, grid * den_t**2)
    require(alpha > 0 and beta > 0, "positive WT parameters")
    return alpha, beta, Fraction(min(knots), den_w * den_t)


def report(alpha, beta, width=None):
    def dec(x):
        return Decimal(x.numerator) / Decimal(x.denominator)
    with localcontext() as ctx:
        ctx.prec = 32
        print("alpha =", dec(alpha))
        print("beta  =", dec(beta))
        print("b     =", 2 * (dec(alpha * beta)).sqrt())
        if width:
            print("k0    =", 4 * (1 + dec(width) * dec(beta / alpha).sqrt())**2)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("file", type=Path, nargs="?",
                        default=Path(__file__).with_name("symmetric_witness.json"))
    args = parser.parse_args()
    data = json.loads(args.file.read_bytes())
    alpha, beta, min_cover = verify(data)
    require(4*alpha*beta < Fraction("1.88606746")**2, "advertised objective")
    print("minimum covering knot =", min_cover)
    report(alpha, beta, Fraction(data["width_cells"], data["cells_per_unit"]))
