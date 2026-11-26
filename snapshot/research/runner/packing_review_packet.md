Check this proposed improvement of the shifted lonely runner linear excess. Independently verify local obligations, the scale disjointness, density calculation, padding, and all-n finite inequality; seek a short human-checkable refinement if there is one. Do not assert priority.

# Mixed-scale lower bounds for the shifted lonely-runner excess

Let E_n be defined by inf gamma=1/(n+1+E_n), with n moving runners, mutually distinct positive integer speeds and arbitrary starting phases. The following bounds follow by combining three of Daria Poliakova's existing rules:

    E_n >= floor(n/167) for every n >= 1,
    liminf E_n/n >= 38131/5429369 = 1/142.38727...

The construction starts from her local rules. The new calculation chooses between different rules and compatible bundles separately for each scale. This improves the asymptotic coefficient 1/224 reported in Table 1 of her September 2026 preprint. It concerns large n and supplies no certificate at n=58. Priority beyond the compared sources has not been established.

## Proof

Use N even speeds 2,4,...,2N with zero phase. Among the N+1 numbers 0,2t,...,2Nt modulo 1, two consecutive points in circular order differ by at most 1/(N+1). Their index difference gives an even speed covering t at radius d=1/(N+1). Coincident points also give a covering speed. Assign t to the smallest such speed.

Write A,B,C for Poliakova's Theorem 7, Table 1 row 19 to 17, and Table 1 row 24 to 21, respectively. Their gains are 1,2,3. Their largest affected even speeds are 192,240,432. At odd scale b they require N>=96b,120b,216b respectively. The locality property says that if the originally responsible speed is affected, one of this rule's rephased or added speeds covers t. Disjoint rule supports therefore compose.

For reproducibility an independent exact local check is in packing.py. If the responsible speed is qb, write qbt=k+d z where |z|<=1. Any common divisor p>1 of k and q/2 would supply a smaller even speed qb/p covering t. Hence gcd(k,q/2)=1. For each such k modulo q, a replacement of speed vb and phase a+hd covers all z satisfying |(v/q)z+h|<=1 whenever vk/q+a is integral. Taking unions of closed rational intervals verifies full coverage of [-1,1] for every required residue class and all three rules, at every admissible b.

Let c run through positive integers coprime to 30. Inside the component of c use the following one recipe according to the size of N/c. A multiplier following a letter indicates the scale relative to c.

| Minimum N/c | Simultaneous rules | Runners saved |
|---:|---|---:|
|96|A1|1|
|120|B1|2|
|216|C1|3|
|864|A1, B5, A9|4|
|1080|A1, A9, C5|5|
|3000|A1, A5, B9, B25|6|
|5400|A1, A5, B9, C25|7|
|5832|A1, A5, C25, C27|8|

At each row the individual supports are disjoint, as direct integer set intersection verifies. Every velocity in the component has the form c times a product of powers of 2,3,5. Its prime-to-30 part recovers c, so distinct components also have disjoint supports. If T is the list of eight thresholds and C(y) counts 1<=c<=y with gcd(c,30)=1, the total guaranteed saving is G(N)=sum_(t in T) C(N/t). This follows by taking the highest available row for each c and counting its saving one layer at a time.

Every 30 consecutive integers contain eight allowable residues. The prefix counts of 1,7,11,13,17,19,23,29 give C(y)>=4y/15-2 for every real y>=0. Hence G(N)>=alpha N-16 with alpha=(4/15)sum 1/t=38131/5467500. For given n choose N=n+h where h=max(0,floor((alpha*n-16)/(1-alpha))). For h>0 we have G(N)>=h. After the substitutions, add any unused positive integer speeds until n runners remain. The resulting radius at most 1/(N+1) gives E_n>=h. Taking the lower limit proves the asymptotic claim.

For the all-n floor, set h=floor(n/167). It is sufficient to show G(168h)>=h since n+h>=168h and G is monotone. For h>=94 the linear estimate just proved suffices. At integers 0<=h<=94 the exact period-30 prefix count gives the claimed inequality. The accompanying standard-library program performs this short calculation. Its combinatorial search is optional for the proof: the eight displayed recipes suffice.

Source: Daria Poliakova, *More (shifted) runners, less loneliness*, Definition 5, Theorem 7 and Table 1, https://arxiv.org/html/2609.23952v1 .


"""Verify three local rules from Poliakova and pack them at compatible scales.

Only integer sets and fractions enter the proof. Per coprime core, consider
multipliers 3^i*5^j and rule choices with unscaled threshold at most LIMIT.
"""
from fractions import Fraction as Q
from functools import lru_cache
from itertools import chain
from math import gcd, floor, ceil
import json

# Removed speeds and groups (speeds, constant phase, coefficient of delta).
rules = [
    ([8,32,192], [([12,24,48,96],Q(1,2),Q(1,2)),([16,64],0,-1),([3,9],Q(1,4),0)]),
    ([8,32,36,40,72,180,192,240], [([12,24,48,60,96,108,120],Q(1,2),Q(1,2)),([16,64,80],0,-1),([216],0,-2),([3,9,27],Q(1,4),Q(1,4)),([15,45,135],Q(3,4),Q(1,4))]),
    ([4,16,20,36,40,64,72,240,384,432], [([12,24,48,96,192],Q(1,2),Q(1,2)),([60,108,120,216],Q(1,2),Q(-1,2)),([8,128],0,-1),([80,144],0,1),([32],0,Q(-3,2)),([3,45,81],Q(1,4),Q(-1,4)),([5,9],Q(1,4),Q(1,4)),([15,27],Q(1,4),0)])
]
LIMIT=6000


def rule_data(removed,groups):
    replacements={v:(a,b) for speeds,a,b in groups for v in speeds}
    affected=set(removed)|{v for v in replacements if v%2==0}
    obligations=0
    for q in sorted(affected):
        for k in range(q):
            if gcd(k,q//2)!=1:
                continue
            intervals=[]
            for v,(a,b) in replacements.items():
                if (Q(v*k,q)+a).denominator==1:
                    intervals.append((Q(q,v)*(-1-b),Q(q,v)*(1-b)))
            right=-1
            for lo,hi in sorted(intervals):
                if lo>right or right>=1:
                    break
                right=max(right,hi)
            assert right>=1, (q,k)
            obligations+=1
    velocities=affected|set(replacements)
    gain=len(removed)-sum(v%2 for v in replacements)
    return max(affected)//2,gain,velocities,obligations


def packing():
    options=[]
    obligations=[]
    for index,rule in enumerate(rules):
        threshold,gain,velocities,checked=rule_data(*rule)
        obligations.append(checked)
        power3=1
        while threshold*power3<=LIMIT:
            scale=power3
            while threshold*scale<=LIMIT:
                options.append((threshold*scale,gain,{v*scale for v in velocities},index,scale))
                scale*=5
            power3*=3
    options.sort(key=lambda item:(item[0],item[3],item[4]))
    conflicts=[sum(1<<j for j,y in enumerate(options) if x[2]&y[2]) for x in options]

    @lru_cache(None)
    def choose(mask):
        if not mask:
            return 0,()
        i=mask.bit_length()-1
        skip=choose(mask^(1<<i))
        gain,members=choose(mask&~conflicts[i])
        use=gain+options[i][1],members+(i,)
        return max(skip,use,key=lambda t:t[0])

    thresholds=[]
    certificates=[]
    for i,option in enumerate(options):
        best,members=choose((1<<(i+1))-1)
        if best>len(thresholds):
            thresholds.extend([option[0]]*(best-len(thresholds)))
            certificates.append(dict(threshold=option[0],savings=best,
              rules_and_scales=[(options[j][3]+1,options[j][4]) for j in members]))
            used=set()
            for j in members:
                assert not used.intersection(options[j][2])
                used.update(options[j][2])
    alpha=Q(4,15)*sum(Q(1,t) for t in thresholds)
    D=ceil((1-alpha)/alpha)
    residual=[sum(gcd(j,30)==1 for j in range(1,r+1)) for r in range(30)]
    def count(N):
        return sum(8*((N//T)//30)+residual[(N//T)%30] for T in thresholds)
    # Each exact count of cores <= real y is >= 4y/15 - 2.
    assert max(Q(4*(r+1),15)-residual[r] for r in range(30))<=2
    # Close the all-n estimate by a finite check of h=floor(n/D).
    while True:
        end=ceil(2*len(thresholds)/(alpha*(D+1)-1))
        if all(count((D+1)*h)>=h for h in range(end+1)):
            break
        D+=1
    return dict(obligations=obligations,local_limit=LIMIT,thresholds=thresholds,certificates=certificates,
                saved_fraction=str(alpha),liminf_En_over_n=str(alpha/(1-alpha)),
                inverse_asymptotic=float((1-alpha)/alpha),all_n_floor_denominator=D,
                last_h_checked=end)

if __name__=="__main__":
    print(json.dumps(packing(),indent=2))


{
  "obligations": [
    184,
    536,
    882
  ],
  "local_limit": 6000,
  "thresholds": [
    96,
    120,
    216,
    864,
    1080,
    3000,
    5400,
    5832
  ],
  "certificates": [
    {
      "threshold": 96,
      "savings": 1,
      "rules_and_scales": [
        [
          1,
          1
        ]
      ]
    },
    {
      "threshold": 120,
      "savings": 2,
      "rules_and_scales": [
        [
          2,
          1
        ]
      ]
    },
    {
      "threshold": 216,
      "savings": 3,
      "rules_and_scales": [
        [
          3,
          1
        ]
      ]
    },
    {
      "threshold": 864,
      "savings": 4,
      "rules_and_scales": [
        [
          1,
          1
        ],
        [
          2,
          5
        ],
        [
          1,
          9
        ]
      ]
    },
    {
      "threshold": 1080,
      "savings": 5,
      "rules_and_scales": [
        [
          1,
          1
        ],
        [
          1,
          9
        ],
        [
          3,
          5
        ]
      ]
    },
    {
      "threshold": 3000,
      "savings": 6,
      "rules_and_scales": [
        [
          1,
          1
        ],
        [
          1,
          5
        ],
        [
          2,
          9
        ],
        [
          2,
          25
        ]
      ]
    },
    {
      "threshold": 5400,
      "savings": 7,
      "rules_and_scales": [
        [
          1,
          1
        ],
        [
          1,
          5
        ],
        [
          2,
          9
        ],
        [
          3,
          25
        ]
      ]
    },
    {
      "threshold": 5832,
      "savings": 8,
      "rules_and_scales": [
        [
          1,
          1
        ],
        [
          1,
          5
        ],
        [
          3,
          25
        ],
        [
          3,
          27
        ]
      ]
    }
  ],
  "saved_fraction": "38131/5467500",
  "liminf_En_over_n": "38131/5429369",
  "inverse_asymptotic": 142.38727020009966,
  "all_n_floor_denominator": 167,
  "last_h_checked": 94
}
