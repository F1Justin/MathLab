"""Regenerate a deterministic symmetric WT pair from the Appendix A.3 data.

A fresh construction, using the first difference of the reflected edge coverage
and a deterministic integer fixed-point Fourier transform. Python standard library.
The final mathematical certificate is checked independently in verify.py.
"""

import argparse
import hashlib
import json
from fractions import Fraction as Q
from math import isqrt, lcm
from pathlib import Path

from verify import product, report, require, verify


# dcartermath/sidon-error, ff5b032fc3745140549777a96a9ec3ba7f8dd954, asymptotic/.
HASHES = {
    "G": "bfd7fbf4b93be3484c51f8b50c8419b6ab9cd07f6a9065b1ccb3c8bbe0d8cb4c",
    "H": "cfaf69e83f34860761fb67faa832bea3eae0372787fbd5042efbec31e308ad03",
    "p": "895a88c77c3a8b17473c5ba8b863e0aac41dfa1a58c7d1e8f7760684da97d9ed",
}
# The two rational values displayed in Appendix A.3, Claim 6 of arXiv:2610.36207v1.
PAPER_ALPHA = Q(
    int("24534927811575735074232072732714727979451900637084863352122"
        "68095831410090107899954872437715855867237470270581061955550"
        "70756187862800085525830942972173964247560024026270654818106"
        "70864505766255992189006831208767880323636547985259235591445"
        "13867197246825055699735993342348910137052272035579462663787"),
    int("25968024015819018585255749413962888050874260032839104696162"
        "07527338283601181039792274031559691376644227380078582776222"
        "47583366127645288213594143153013277322919052741726652238862"
        "15485406618227891413397956115521280961039716282295125506672"
        "24642669840915160749996375246335775289250052685000000000000"))
PAPER_BETA = Q(1772130384572488116897712811968136530510904755768535954960651,
               1882725390027397260273972602940280969126497650532485399838720)


def integer_row(row):
    denominator = lcm(*(x.denominator for x in row))
    return [int(x * denominator) for x in row], denominator


def input_kernels(data_dir):
    rows = {}
    require(Q((data_dir / "upsilon.txt").read_bytes().decode().strip()) == 10, "source width")
    for key, known_hash in HASHES.items():
        raw = (data_dir / (key + ".txt")).read_bytes()
        require(hashlib.sha256(raw).hexdigest() == known_hash, "source " + key)
        rows[key] = [[Q(x) for x in row.split(",")]
                     for row in raw.decode().splitlines()]
    probabilities, = rows["p"]
    require(sum(probabilities) == 1 and min(probabilities) > 0, "source probabilities")
    n = len(rows["G"][0])
    require(n == 200 and len(probabilities) == len(rows["G"]) == len(rows["H"]) == 6,
            "source dimensions")
    mesh = Q(10, n)
    norm_t = norm_w = Q()
    correlation = [Q()] * (2 * n - 1)
    coverage = [Q()] * (4 * n - 1)
    for p, heights, reversed_table in zip(probabilities, rows["G"], rows["H"]):
        require(len(heights) == n and len(reversed_table) == 3*n, "source row sizes")
        w, d = integer_row([mesh*x for x in heights])
        t, e = integer_row(reversed_table[::-1])
        require(sum(w) == d and min(w) >= 0 and min(t) >= 0, "source strong window-table")
        require(t[n:2*n] == [e]*n, "source plateau")
        norm_w += p * sum(x*x for x in w) / (mesh*d*d)
        norm_t += p * sum(x*x for x in t) * mesh / (e*e)
        for j, x in enumerate(product(w, w[::-1])):
            correlation[j] += p*x / (d*d)
        for j, x in enumerate(product(w, t)):
            coverage[j] += p*x / (d*e)
    alpha = norm_t - 2*n*mesh
    require(min(correlation) >= 0 and min(coverage[n-1:3*n]) >= 1, "source WT inequalities")
    require((alpha, norm_w) == (PAPER_ALPHA, PAPER_BETA), "comparison with typeset Appendix A.3, Claim 6")
    # In original coordinates, node x has coefficient x+n-1. Right covering
    # edge at x=2n is paired with its reflection at x=0.
    def at(x):
        i = x + n - 1
        return coverage[i] if 0 <= i < len(coverage) else Q()
    edge = [(at(2*n+k) + at(-k))/2 for k in range(-n, n+1)]
    require(edge[0] == 1 and edge[-1] == 0, "source edge normalization")
    differences = [y-x for x,y in zip([Q(1)] + edge[:-1], edge)]
    return n, correlation, differences


ONE = 1 << 160


def fft(re, im, inverse=False):
    """In-place radix-two transform. All coordinates are integers in units 2^-160."""
    length = len(re)
    j = 0
    for i in range(1, length):
        bit = length // 2
        while j & bit:
            j ^= bit
            bit //= 2
        j ^= bit
        if i < j:
            re[i], re[j] = re[j], re[i]
            im[i], im[j] = im[j], im[i]
    # cos(pi), sin(pi). Each stage uses half-angle formulas.
    cosine, sine = -ONE, 0
    span = 2
    while span <= length:
        c, s = ONE, 0
        root_im = sine if inverse else -sine
        for k in range(span//2):
            for i in range(k, length, span):
                j = i + span//2
                x = (re[j]*c-im[j]*s) // ONE
                y = (re[j]*s+im[j]*c) // ONE
                re[j], im[j] = re[i]-x, im[i]-y
                re[i] += x
                im[i] += y
            c, s = (c*cosine-s*root_im)//ONE, (c*root_im+s*cosine)//ONE
        cosine, sine = (isqrt(ONE*(ONE+cosine)//2),
                        isqrt(ONE*(ONE-cosine)//2))
        span *= 2
    if inverse:
        for i in range(length):
            re[i] //= length
            im[i] //= length


def spectrum(values, first, length):
    re = [0] * length
    im = [0] * length
    for k, value in enumerate(values, start=first):
        re[k % length] = round(value*ONE)
    fft(re, im)
    return re, im


def generate(data_dir):
    n, auto, diff = input_kernels(data_dir)
    length = 4096
    power_re, _ = spectrum(auto, 1-n, length)
    # Root at each frequency chosen positive. Delta t = Delta C / sqrt(A).
    require(min(power_re) > 0, "positive source spectrum on the Fourier grid")
    root = [isqrt(ONE*x) for x in power_re]
    re, im = spectrum(diff, -n, length)
    re = [x*ONE//s for x,s in zip(re, root)]
    im = [y*ONE//s for y,s in zip(im, root)]
    fft(re, im, inverse=True)
    fft(root, [0]*length, inverse=True)

    # Truncate the spectral window and add a smooth probability mass. The
    # integer normalization enforces mass one regardless of numerical errors.
    cut, radius, power = 360, 680, 8
    mixture = Q(1, 250_000_000_000)
    den_w = 10**25
    bump = [(radius*radius-j*j)**power for j in range(radius+1)]
    bump_mass = 2*sum(bump)-bump[0]
    mass = Q(root[0] + 2*sum(root[1:cut+1]))
    half = []
    for j, val in enumerate(bump):
        value = mixture * val / bump_mass
        if j <= cut:
            value += (1-mixture)*root[j]/mass
        half.append(round(den_w*value))
    half[0] += den_w - 2*sum(half) + half[0]

    # Integrate the edge first differences from the unit plateau. The
    # surface of the table is determined by these few hundred cells.
    bound = 410
    den_t = 10**14
    integral = ONE
    transition = []
    for k in range(-length//2 + 1, bound+1):
        integral += re[k % length]
        if k >= -bound:
            transition.append(round(Q(integral*den_t, ONE)))
    # On both ends fix an exact plateau or zero beyond the archived band.
    edge = 6800
    return {
        "cells_per_unit": 20, "cover_half_length": edge,
        "window_denominator": den_w, "window_center_to_right": half,
        "table_denominator": den_t, "table_left_offset": -bound,
        "table_right_edge": transition, "repair_inverse": 250_000_000_000,
        "repair_left_offset": -bound-3*radius, "repair_right_offset": 2*radius,
        "width_cells": 2*(bound+4*radius+4)+1,
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("data_dir", type=Path, help="directory with the four original Appendix A.3 files")
    parser.add_argument("--output", type=Path, help="save regenerated integer certificate")
    args = parser.parse_args()
    pair = generate(args.data_dir)
    alpha, beta, min_cover = verify(pair)
    require(4*alpha*beta < Q("1.88606746")**2 < 4*PAPER_ALPHA*PAPER_BETA,
            "strict comparison with Appendix A.3")
    if args.output:
        args.output.write_text(json.dumps(pair, separators=(",", ":")) + "\n")
    print("Carter--O'Bryant--Tao, Appendix A.3, Claim 6 (exact fractions recovered)")
    report(PAPER_ALPHA, PAPER_BETA, Q(10))
    print("Independently generated pair; minimum covering knot =", min_cover)
    report(alpha, beta, Q(pair["width_cells"], pair["cells_per_unit"]))
