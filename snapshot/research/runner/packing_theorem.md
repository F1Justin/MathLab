# Mixed-scale lower bounds for the shifted lonely-runner excess

Let E_n be defined by inf gamma=1/(n+1+E_n), with n moving runners, mutually distinct positive integer speeds and arbitrary starting phases. The following bounds follow by combining three of Daria Poliakova's existing rules:

    E_n >= floor(n/167) for every n >= 1,
    liminf E_n/n >= 76897/10858103 = 1/141.2032...

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
|9720|C1, C25, A45, B81|9|

At each row the individual supports are disjoint, as direct integer set intersection verifies. Every velocity in the component has the form c times a product of powers of 2,3,5. Its prime-to-30 part recovers c, so distinct components also have disjoint supports.

The triple A1, A9, A81 has gain three and threshold 7776. It has disjoint supports because 9 is the only multiple of 9 in the support of A and 1 is absent. Every velocity in this triple is prime to 5. Thus any valid bundle of gain g and threshold t extends to gain g+3 at threshold max(7776,5t) by multiplying the existing bundle by 5 and adjoining this triple. Starting with rows seven through nine gives all further thresholds in increasing order. After the first six thresholds the list consists of the triples 5^j (5400,5832,9720) for j >= 0.

Let C(y) count positive c <= y coprime to 30. For each finite prefix T of the threshold list the guaranteed saving is G(N)=sum over t in T of C(N/t). Select the highest available bundle separately for each c. Each reached threshold contributes one unit of saving. The residues 1,7,11,13,17,19,23,29 modulo 30 give C(y) >= 4y/15 - 14/15 by taking the maximum deficit just before each residue. Thus G(N) >= a N - D for a=(4/15) sum 1/t and the fixed D=14|T|/15. For n runners choose h=max(0,floor((a n-D)/(1-a))) and N=n+h. If h>0 the construction saves at least h. Pad the configuration to exactly n with unused distinct positive speeds. Its covering radius is at most 1/(N+1), giving E_n >= h. Applying this argument separately to each finite prefix and then taking the supremum proves the asymptotic bound. Indeed the infinite sum gives a=(4/15)(1/96+1/120+1/216+1/864+1/1080+1/3000+(5/4)(1/5400+1/5832+1/9720))=76897/10935000.

For the all-n floor, set h=floor(n/167). Since n+h>=168h it suffices to show G(168h)>=h. The first three terms sum to at least (707/675)h-14/5>h-3, hence at least h-2 by integrality. For h>=7 the fourth and fifth thresholds each contribute at least one. For h from 1 through 6 the exact counts are 2,3,3,4,5,6. For h=0 the even-speed starting configuration suffices.

Source: Daria Poliakova, *More (shifted) runners, less loneliness*, Definition 5, Theorem 7 and Table 1, https://arxiv.org/html/2609.23952v1 .
