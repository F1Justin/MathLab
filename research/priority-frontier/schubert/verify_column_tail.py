"""Exact adjacent-rank checks for all one-column heights up to a supplied rank.

Requires python-flint. Uses the integer signed remainder sequence of each
pair. Jacobi parity makes every quotient a constant times x.
"""
import argparse

from flint import fmpq_poly, fmpz_poly


def check(max_rank):
    x = fmpq_poly([0, 1])
    x_integral = fmpz_poly([0, 1])
    jacobi = [fmpq_poly([1]), x]
    for rank in range(2, max_rank + 2):
        jacobi.append(((2 * rank + 1) * x * jacobi[-1]
                       - (rank - 1) * jacobi[-2]) / (rank + 2))

    checked = 0
    for rank in range(2, max_rank + 1):
        older = jacobi[rank]
        later = jacobi[rank + 1]
        for height in range(1, rank):
            older = older + jacobi[rank] - jacobi[height] * jacobi[rank - height]
            later = later + jacobi[rank + 1] - jacobi[height] * jacobi[rank + 1 - height]
            high, low = later.numer(), older.numer()
            if high.leading_coefficient() <= 0 or low.leading_coefficient() <= 0:
                raise ValueError((rank, height, 'leading sign'))
            while low.degree() > 0:
                neg = high.leading_coefficient() * x_integral * low - low.leading_coefficient() * high
                if neg.degree() != low.degree() - 1 or neg.leading_coefficient() <= 0:
                    raise ValueError((rank, height, low.degree(), 'signed remainder'))
                high, low = low, neg // neg.content()
            checked += 1
    print(f'Strict adjacent-rank interlacing at all {checked} heights/ranks with 2 <= n <= {max_rank}.')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--max-rank', type=int, default=40)
    check(parser.parse_args().max_rank)
