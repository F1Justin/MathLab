"""Cross-check the shifted Hankel certificate using the block containing label 1."""
from fractions import Fraction
from math import comb, factorial


def partition_rows(limit):
    rows = [[1]]
    for n in range(1, limit+1):
        row = [0]*(n//4+1)
        for k in range(1, n+1):
            multiplicity = comb(n-1, k-1)
            for j, count in enumerate(rows[n-k]):
                row[j+int(k>=4)] += multiplicity*count
        rows.append(row)
    return rows


def normalized(row, degree, n):
    scale = Fraction(24**degree*factorial(degree), factorial(n))
    return [row[degree-j]*scale if 0<=degree-j<len(row) else 0 for j in range(5)]


def signs(rows, n):
    d = n//4
    p = normalized(rows[n],d,n)
    q = normalized(rows[n+1],d+1,n+1)
    c = []
    for i,v in enumerate(q):
        c.append((v-sum(p[h]*c[i-h] for h in range(1,i+1)))/p[0])
    return (-c[2]*p[0]**3,c[3]*p[0]**4,(c[2]*c[4]-c[3]**2)*p[0]**8)


def newton_column(values):
    col = []
    while values:
        col.append(values[0])
        values = [b-a for a,b in zip(values,values[1:])]
    return col


if __name__=='__main__':
    rows = partition_rows(232)
    for s in range(4):
        L = 8*s+24
        all_signs = [signs(rows,4*d+s) for d in range(2,58)]
        for j,column in enumerate(zip(*all_signs)):
            differences = newton_column(column[:L+1])
            for shift in range(len(column)):
                expected = sum(comb(shift,k)*v for k,v in enumerate(differences) if k<=shift)
                if expected!=column[shift] or expected<=0:
                    raise ArithmeticError('Interpolation or positivity failed')
            for d0 in range(2,58-L):
                start = d0-2
                coeffs = newton_column(list(column[start:start+L+1]))
                if min(coeffs)>=0 and coeffs[0]>0:
                    print(f'n mod 4 = {s}, sign {j+1}: positive Newton expansion at d = {d0}')
                    break
            else:
                raise ArithmeticError('No nonnegative Newton column')
