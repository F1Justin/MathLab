"""Exact certificate for the sharp bound on nonperiodic three-column windows.

Only the Python standard library is used. --raw also checks the potential
inequality on every admissible ordered triple of uncompressed columns.
"""
import argparse
from itertools import product

# Each integer is a five-digit base-three column, most significant row first.
# The 20-column word is a cyclic shift of the package2 B,reflection(B) witness.
PERIOD = (4, 90, 91, 28, 30, 84, 91, 10, 108, 7,
          108, 10, 91, 84, 30, 28, 91, 90, 4, 135)
SHARP = (118, 3, 111, 28, 10, 171, 4, 54, 4, 171, 10, 28, 111, 3, 118,
         1, 120, 3, 109, 10, 90, 85, 27, 40, 81, 94, 27, 31, 84, 90,
         11, 108, 6, 108, 11, 90, 84, 31, 27, 94, 81, 40, 27, 85,
         90, 10, 109, 3, 120, 1)


def windows(word):
    for i, middle in enumerate(word):
        yield word[i - 1], middle, word[(i + 1) % len(word)]



def verify_rectangles(columns, weights, pair_id, keys, succ):
    # Lexicographic cost is (total weight, negative internal defect count).
    # Ending in state (b,need,standard_next) is legal iff a zero successor fits.
    terminal = [state for (_, need, _), state in keys.items() if not any(need)]
    column_for_state = [b for (b, _, _) in keys]
    extended = []
    for edges in succ:
        row = []
        for target, price in edges:
            w = weights[column_for_state[target]]
            bad = 5 * (10 * w - 23) - price
            row.append((target, w, bad))
        extended.append(row)

    # No internal triple is centered at either endpoint. Start with two columns.
    states = len(keys)
    values = [None] * states
    for a, middle in enumerate(columns):
        vertical = [sum(middle[max(0, i-1):i+2]) for i in range(5)]
        for b, right in enumerate(columns):
            if all(x + y >= 2 for x, y in zip(vertical, right)):
                state = pair_id[a][b]
                value = (weights[a] + weights[b], 0)
                if values[state] is None or value < values[state]:
                    values[state] = value

    exceptional = {2, 3, 5, 6, 8, 9, 12, 15, 18}
    eventual = (13, 4, 33, 17, 7, 36, 20, 10, 42, 23)
    anchor = None
    for n in range(2, 79):
        best_weight, minus_defects = min(values[s] for s in terminal if values[s] is not None)
        defects = -minus_defects
        if best_weight != (23*n + 26)//10 - (n in exceptional):
            raise ValueError(f"open-strip weight at width {n}")
        if defects > 46 or (defects == 46) != (n == 48):
            raise ValueError(f"open-strip defect extremum at width {n}")
        if n >= 49 and defects != eventual[n % 10]:
            raise ValueError(f"open-strip residue at width {n}")
        if n == 68:
            anchor = values.copy()
        if n == 78:
            break

        new = [None] * states
        for state, prefix in enumerate(values):
            if prefix is None:
                continue
            w0, d0 = prefix
            for target, w, bad in extended[state]:
                candidate = (w0 + w, d0 - bad)
                if new[target] is None or candidate < new[target]:
                    new[target] = candidate
        values = new

    for before, after in zip(anchor, values):
        if before is None or after != (before[0] + 23, before[1]):
            raise ValueError("open-strip lexicographic vector identity")
    print("Open-strip maximum defects: 46 only at n=48; "
          "for n>=49, residue table verified and F78=F68+(23,0).")


def verify(full):
    columns = list(product(range(3), repeat=5))
    weights = list(map(sum, columns))
    good = set(windows(PERIOD))
    next_column = {(a, b): c for a, b, c in good}
    if len(next_column) != 20:
        raise ValueError("two positions with the same ordered column pair")

    for word, expected_weight, expected_bad in ((PERIOD, 46, 0), (SHARP, 116, 50)):
        if sum(weights[c] for c in word) != expected_weight:
            raise ValueError("wrong witness weight")
        if sum(t not in good for t in windows(word)) != expected_bad:
            raise ValueError("wrong number of exceptional windows")
        for a, b, c in windows(word):
            for i in range(5):
                closed_sum = columns[a][i] + columns[c][i] + sum(columns[b][max(0, i-1):i+2])
                if closed_sum < 2:
                    raise ValueError("infeasible cylinder witness")

    # On input (a,b), last is the unique standard continuation c, or -1.
    # This flag retains precisely the information needed to price each window.
    keys = {}
    pair_id = []
    for a, left in enumerate(columns):
        row = []
        for b, middle in enumerate(columns):
            vertical = [sum(middle[max(0, i - 1):i + 2]) for i in range(5)]
            need = tuple(max(0, 2 - x - y) for x, y in zip(left, vertical))
            key = (b, need, next_column.get((a, b), -1))
            row.append(keys.setdefault(key, len(keys)))
        pair_id.append(row)

    # Grouping by source makes the fixed point calculation small enough
    # for ordinary Python integer arithmetic.
    succ = [[] for _ in keys]
    for (b, need, standard_next), s in keys.items():
        for c, right in enumerate(columns):
            if all(x >= y for x, y in zip(right, need)):
                cost = 5 * (10 * weights[c] - 23) - (c != standard_next)
                succ[s].append((pair_id[b][c], cost))

    potential = [0] * len(keys)
    for rounds in range(30):
        new = potential.copy()
        for s, edges in enumerate(succ):
            for t, cost in edges:
                candidate = potential[s] + cost
                if candidate < new[t]:
                    new[t] = candidate
        if new == potential:
            break
        potential = new
    else:
        raise ValueError("potential did not stabilize")

    for s, edges in enumerate(succ):
        for t, cost in edges:
            if potential[t] - potential[s] > cost:
                raise ValueError("negative reduced cost")
    stats = len(keys), sum(map(len, succ)), rounds, min(potential), max(potential)
    if stats != (1615, 163588, 28, -232, 0):
        raise ValueError(f"unexpected certificate dimensions {stats}")
    print(f"{stats[0]} states, {stats[1]} edges, {rounds} relaxation rounds")
    print("The potential inequality and the sharpness witness (n=50, W=116, D=50) hold.")

    verify_rectangles(columns, weights, pair_id, keys, succ)

    if full:
        edges = 0
        # Use closed row sums directly, without the compressed transition list.
        scaled = [5 * (10 * w - 23) for w in weights]
        for b, middle in enumerate(columns):
            vertical = [sum(middle[max(0, i-1):i+2]) for i in range(5)]
            for a, left in enumerate(columns):
                covered = [x + y for x, y in zip(vertical, left)]
                h_left = potential[pair_id[a][b]]
                for c, right in enumerate(columns):
                    if any(covered[i] + right[i] < 2 for i in range(5)):
                        continue
                    edges += 1
                    cost = scaled[c] - ((a, b, c) not in good)
                    if potential[pair_id[b][c]] - h_left > cost:
                        raise ValueError(f"failed at uncompressed triple {(a,b,c)}")
        if edges != 11929864:
            raise ValueError(f"unexpected raw transition count {edges}")
        print(f"The same inequality holds on all {edges} admissible raw triples.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--raw", action="store_true")
    verify(parser.parse_args().raw)
