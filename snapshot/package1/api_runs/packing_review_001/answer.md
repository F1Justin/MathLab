**Both proposed bounds hold for the rules as transcribed.** The local obligations admit a hand check, and the all-\(n\) inequality needs only the values \(h=1,\ldots,6\), rather than a calculation through \(94\). There is also a short refinement: one additional bundle and a scaling recurrence give
\[
\boxed{\displaystyle \liminf_{n\to\infty}\frac{E_n}{n}
\ \ge\ \frac{76897}{10858103}
\ =\ \frac1{141.2032\ldots}.}
\]

### 1. Local obligations

The circular-gap argument gives the original cover, including when points coincide. Suppose the smallest originally covering speed is \(qb\), and write \(qbt=k+dz\), \(|z|\le1\). If \(p>1\) divides both \(k\) and \(q/2\), then \(qb/p\) is a smaller original even speed and covers at distance at most \(d/p\). Thus \(\gcd(k,q/2)=1\). In fact all affected \(q\) are divisible by \(4\), so this is equivalent to \(\gcd(k,q)=1\); in particular \(k\) is odd.

For a replacement with data \((v,a,h)\), the two sufficient tests are exactly
\[
vk/q+a\in\mathbb Z,\qquad |(v/q)z+h|\le1.
\]
Here is a compression of the interval check. Three patterns handle all but five rule–speed pairs:

- **Half:** \(v=q/2\) has \(a=1/2\) and \(|h|=1/2\), so it covers all \(z\).
- **Three-halves:** \(v=3q/2\) has \(a=1/2,\ h=1/2\), covering \([-1,1/3]\), and a speed \(q\) or \(2q\) has \(a=0,\ h=-1\), covering \([0,1]\). The sign-reversed version works by reflection.
- **Quarters:** \(q/4\) and \(3q/4\) have the same constant phase, either \(1/4\) or \(3/4\), and both have \(|h|\le1/4\). For either odd class of \(k\bmod4\), one passes the integrality test and covers all \(z\).

The entries below are the original affected speeds \(q\), before multiplication by \(b\).

| Pattern | \(A\) | \(B\) | \(C\) |
|---|---|---|---|
| Half | 24,48,96,192 | 24,48,96,120,192,216,240 | 24,48,96,120,192,216,240,384,432 |
| Three-halves | 8,16,32,64 | 8,16,32,40,64,80 | 8,40,64,72,80,128,144 |
| Quarters | 12 | 12,36,60,180 | 12,20,36,60,108 |
| Remaining | — | 72,108 | 4,16,32 |

The five remaining checks, with intervals clipped to \([-1,1]\), are:

| Rule, \(q\) | Coverage |
|---|---|
| \(B,72\) | Speeds \(108,216\) cover \([-1,1/3]\), \([1/3,1]\). |
| \(B,108\) | For \(k\equiv3\bmod4\), speed \(27\) suffices. For \(k\equiv1\), speeds \(135,216\) cover \([-1,3/5]\), \([1/2,1]\). |
| \(C,4\) | For \(k\equiv1\bmod4\), speed \(3\) suffices. For \(k\equiv3\), speeds \(5,8\) cover \([-1,3/5]\), \([0,1]\). |
| \(C,16\) | Speeds \(24,32\) cover \([-1,1/3]\), \([1/4,1]\). |
| \(C,32\) | Speeds \(48,128,32\) cover \([-1,1/3]\), \([0,1/2]\), \([1/2,1]\). |

This verifies locality without sampling \(t\) or relying on a search. Summing \(\varphi(q)\) over the respective columns gives **184, 536, 882** residue obligations. The rules remove \(3,8,10\) speeds and introduce \(2,6,7\) odd speeds, so their net savings are \(1,2,3\). Their maximum affected even speeds give precisely the thresholds \(96b,120b,216b\).

### 2. Disjointness of the eight recipes

Let \(V_A,V_B,V_C\) include the full supports: removed, rephased, and added speeds. The following facts from the lists suffice:

- Every speed in \(V_A\) is prime to \(5\); speeds in \(V_B,V_C\) have \(5\)-adic valuation \(0\) or \(1\).
- The only multiple of \(9\) in \(V_A\) is \(9\). Neither \(V_A\) nor \(V_B\) contains \(1\) or \(5\).

In the displayed bundles, the \(5\)-adic valuations separate all pairs except for comparisons of a scale-\(9\) or scale-\(27\) copy with \(A_1\) or \(A_5\). A scale-\(9\) collision would have to occur at \(9\) or \(45\), requiring \(1\) or \(5\) in the scale-\(9\) rule, which is \(A\) or \(B\). A scale-\(27\) collision is impossible because neither \(V_A\) nor \(5V_A\) contains a multiple of \(27\).

Across components, stripping all factors \(2,3,5\) recovers \(c\). Also, all scales used are odd, so an added odd speed cannot coincide with an untouched original even speed. Thus an originally responsible speed either remains unchanged or is covered by a local substitution whose replacements survive every other substitution.

### 3. Density, padding, and the finite inequality

Write \(C(y)=\#\{1\le c\le y:(c,30)=1\}\). The recipes need not be nested: at a given \(c\) one uses **only the highest available row**. Its saving equals the number of thresholds reached, so the layer count
\[
G(N)=\sum_{t\in T}C(N/t)
\]
is correct.

A useful sharpening of the prefix estimate is
\[
C(y)\ge \frac4{15}y-\frac{14}{15}.
\]
Indeed, for \(R=(1,7,11,13,17,19,23,29)\), the largest deficit within a period is obtained as a left limit at a residue: \(\max_{r\in R}(4r/15-\#\{s\in R:s<r\})=14/15\), at \(r=11\). In particular the proposed bound \(G(N)\ge\alpha N-16\) is valid, with
\[
\alpha=\frac4{15}\sum_{t\in T}\frac1t=\frac{38131}{5467500}.
\]

The padding goes in the correct direction. For \(N=n+h\), if \(G(N)\ge h\), the covered configuration has \(N-G(N)\le n\) runners. Adding unused distinct positive speeds cannot destroy coverage, so the radius is still at most \(1/(n+h+1)\), giving \(E_n\ge h\). The proposed positive choice of \(h\) satisfies \(\alpha(n+h)-16\ge h\); when \(h=0\) the original cover suffices. This verifies the proposed asymptotic coefficient \(\alpha/(1-\alpha)=38131/5429369\).

For the **all-\(n\)** bound, take \(h=\lfloor n/167\rfloor\), so \(n+h\ge168h\). The first three terms of \(G(168h)\) alone sum to at least
\[
\frac4{15}\left(\frac74+\frac75+\frac79\right)h-3\frac{14}{15}
=\frac{707}{675}h-\frac{14}{5}>h-3.
\]
Their sum is an integer, hence at least \(h-2\). For \(h\ge7\), the thresholds \(864\) and \(1080\) each contribute at least one more. That leaves just
\[
\begin{array}{c|rrrrrr}
h&1&2&3&4&5&6\\ \hline
G(168h)&2&3&3&4&5&6 .
\end{array}
\]
Thus \(G(168h)\ge h\) for every \(h\ge0\), proving \(\boxed{E_n\ge\lfloor n/167\rfloor}\). The denominator is tight for this particular threshold test: replacing \(167\) by \(166\) would require \(G(668)\ge4\), whereas \(G(668)=3\). This is not an obstruction for \(E_n\) itself.

### 4. A further packing refinement

First append a ninth row:
\[
\begin{array}{c|c|c}
\text{Threshold}&\text{Bundle}&\text{Saving}\\ \hline
9720&C_1,\ C_{25},\ A_{45},\ B_{81}&9 .
\end{array}
\]
The threshold is \(120\cdot81\). The \(C_{25}\) copy is separated from the other three by \(5\)-adic valuation. In \(V_C\), the only multiple of \(45\) is \(45\), and the only multiple of \(81\) is \(81\), so \(C_1\) misses both \(A_{45}\) and \(B_{81}\). Finally, the only multiple of \(81\) in \(45V_A\) is \(405=81\cdot5\), and \(5\notin V_B\).

Now use a recurrence: **any bundle saving \(r\) at threshold \(t\) gives one saving \(r+3\) at threshold \(5t\), provided \(5t\ge7776\).** Multiply the entire bundle by \(5\) within the same component, and add \(A_1,A_9,A_{81}\). These three copies are prime to \(5\), and they are pairwise disjoint because the only multiple of \(9\) in \(V_A\) is \(9\) and \(1\notin V_A\). Their largest threshold is \(96\cdot81=7776\).

Consequently, after the first six thresholds one may use the triples
\[
5^j(5400,\ 5832,\ 9720),\qquad j=0,1,2,\ldots,
\]
in increasing order, gaining one layer at each threshold. The resulting saving density is
\[
\alpha_*=\frac4{15}\left(
\sum_{i=1}^{6}\frac1{t_i}
+\frac54\left(\frac1{5400}+\frac1{5832}+\frac1{9720}\right)\right)
=\frac{76897}{10935000}.
\]
No uniform error estimate for an infinite threshold list is needed: apply the density and padding proof to each **finite truncation**, then take the supremum of its asymptotic lower bounds. This gives \(\alpha_* /(1-\alpha_*)=76897/10858103\) as claimed. The refinement uses only the three supplied local rules and makes no optimality or priority claim.
