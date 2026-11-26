"""Turn the geometric saving thresholds into a periodic finite-size bound."""
from collections import Counter
from fractions import Fraction
from math import gcd, lcm
from pathlib import Path
import json


def certificate(head, cycle, ratio):
    if ratio != 5:
        raise ValueError("The coprime-core identity below removes powers of five.")
    rows = [(30, t) for t in head] + [(6, t) for t in cycle]
    period = lcm(*(mod * t for mod, t in rows))
    jumps = Counter()
    for mod, t in rows:
        for residue in range(1, mod):
            if gcd(residue, mod) == 1:
                jumps.update(range(t * residue, period + 1, t * mod))

    def gain(N):
        result = 0
        for mod, t in rows:
            cycles, remainder = divmod(N // t, mod)
            residues = [r for r in range(1, mod) if gcd(r, mod) == 1]
            result += cycles * len(residues) + sum(r <= remainder for r in residues)
        return result

    slope = Fraction(sum(jumps.values()), period)
    p, q = slope.as_integer_ratio()
    saved, worst, witness = 0, 0, 0
    for N, increase in sorted(jumps.items()):
        deficit = p * (N - 1) - q * saved
        if deficit > worst:
            worst, witness = deficit, N - 1
        saved += increase
    assert saved == gain(period) and p * period == q * saved
    assert p * witness - q * gain(witness) == worst
    assert p * period - q * gain(period) <= worst
    return dict(head=head, cycle=cycle, period=period, period_gain=saved,
                slope=str(slope), jump_positions=len(jumps), discrepancy_numerator=worst,
                witness_N=witness, witness_gain=gain(witness),
                excess_numerator=p, excess_denominator=q-p, excess_offset=q-1-worst)


if __name__ == '__main__':
    root = Path(__file__).resolve().parent
    data = json.loads((root / 'overlap_packing.json').read_text())
    result = certificate(data['head'], data['cycle'], data['scale_ratio'])
    assert result['slope'] == data['saved_fraction']
    from packing import rule_data, rules
    threshold, gain, support, _ = rule_data(*rules[0])
    assert (threshold, gain) == (96, 1)
    assert all(v % 5 for v in support)
    assert {v for v in support if v % 9 == 0} == {9} and 1 not in support
    first_new = threshold * 9**3
    extra_density = Fraction(4, 15 * first_new) * Fraction(9, 8) * Fraction(5, 4)
    improved = Fraction(result['slope']) + extra_density
    result['extra_saved_fraction'] = str(extra_density)
    result['expanded_layer_liminf'] = str(improved / (1 - improved))
    (root / 'periodic_packing.json').write_text(json.dumps(result, indent=2) + '\n')
    print(result)
