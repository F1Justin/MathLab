# A second-order Sidon interval for fourth powers

For a nontrivial collision of fourth powers of positive integers, let $N$ be the smallest argument and $H$ the difference between the largest and smallest. Put $c_0=(2048/85)^{1/10}$. Along every sequence of collisions with $N\to\infty$,

$$
  \frac{H-c_0N^{3/5}}{N^{3/10}}\longrightarrow+\infty. \tag{1}
$$

Consequently, for every fixed $C\ge0$ and every sufficiently large integer $B$, the fourth powers of the integers in the closed interval $[B,B+c_0B^{3/5}+CB^{3/10}]$ form a Sidon set. A collision there would have $N\ge B$ and $H\le c_0N^{3/5}+CN^{3/10}$. The main exponent is still $3/5$. The proof here supplies no numerical threshold for $B$.

Garaev, Garayev and Konyagin proved an interval with leading term $cN^{3/5}$ for an absolute positive $c$. The package2 note derived the particular $c_0$, proved the lower limit bound, and identified the necessary conditions for saturation. We use their elimination and the package2 saturation lemma as inputs. The argument below resolves the endpoint by exhibiting a genus-four family. The priority search for this refinement was targeted, and wider literature comparison remains open. [GGK, Theorem 6 and §8](https://arxiv.org/html/2602.08807v2#S8) · [Published article](https://doi.org/10.1007/s10476-026-00184-y) · [package2 proof](../../../package2/phase2_work/erdos/quartic_constant_draft.md)

## The integer quotient at the endpoint

Order the pairs so $x+y>z+t$, $x\ge y$, $z\ge t$. Set $u=z+t$, $a=(x+y-u)/2$, $q=x-y$, $v=z-t$, and $k=3(v^2-q^2)/4-au$. Here $a$ is a positive integer. The package2 identities give $k>a^2$ and

$$
 D=8au+9a^2-k>0,\quad F=9(k-a^2)((k-a^2)^2+64a^4),\quad J=F/D\in\mathbb Z,\quad J\ge12.
$$

We also use $J\equiv-(k-a^2)^2\pmod8$ and the elimination equation

$$
 3q^2D=(9k-25a^2)u^2+4au(k-9a^2)+2k^2-18a^4. \tag{2}
$$

Suppose $J=12$. The congruence implies $k-a^2=2s$ with $s>0$ odd. Solving $F=12D$ gives $u=s(m+12a^3)-a$, where $m=(3s^2+1)/(4a)$. Equation (2) and the definition of $v$ give

$$
 q^2=m^2+9a^2s^2-s\big((s^2+3)/2+8a^4\big),\qquad
 v^2=m^2+9a^2s^2+s\big((s^2+3)/2+8a^4\big). \tag{3}
$$

These identities initially hold over the rationals. In the first one,

$$
 16a^2q^2=(3s^2+1)^2+144a^4s^2-8a^2s(s^2+3+16a^4).
$$

If $a$ were even, the first term on the right would have 2-adic valuation 4, while both remaining terms and the left side are divisible by 32. Thus $a$ is odd. Reduction modulo $a^2$ then gives $a\mid3s^2+1$, so $m$ is an odd integer. The congruence $4am=3s^2+1$ shows $3\nmid a$ and $m^2\equiv1\pmod3$. If $3\nmid s$, the two values in (3) reduce to $0,2$ in some order modulo 3, which is impossible. Hence $3\mid s$.

Set

$$
 d=9s-8a^2,\qquad T=(d^2+27)/(4a).
$$

Since $d^2+27\equiv27(3s^2+1)\equiv0\pmod a$, $a$ is odd and $d^2+27\equiv4\pmod8$, the parameter $T$ is a positive odd integer.

## Each fixed $T$ has finitely many collisions

Fix such a $T$. Substitute $a=(d^2+27)/(4T)$, $s=(d+8a^2)/9$ into the first equation of (3). The result is $23328T^4 q^2=P_T(d)$, where

$$
\begin{split}
 P_T(X)={}&85X(X^2+27)^4+6T^2(X^2+27)^2(31X^2-252)\\
           &+48T^4X(X^2-45)+32T^6.
\end{split}
$$

Computing the discriminant with respect to $X$ by the polynomial resultant gives

$$
 \operatorname{disc}_X(P_T)=2^{32}3^{45}5^2 17^2 T^{24}G(T),
$$

where the coefficients of $G$ in degrees $24,20,16,12,8,4,0$, in that order, are

```
256
140564160
-11743512277536
275862773645746884
-1776983635276715108556
1301614741918853844382125
13157103861667103667014520000
```

Thus $G(T)\equiv T^4\pmod2$ and the discriminant is nonzero for every positive odd $T$. The smooth projective model of $Y^2=23328P_T(X)$ has genus four by Riemann–Hurwitz, since the double cover has nine simple finite branch points and one at infinity. Every collision provides a rational point with $X=d$ and $Y=23328T^2q$. Faltings's theorem gives finitely many rational points for each fixed $T$. The pair $T,d$ recovers $a,s,u,q^2,v^2$, hence only finitely many collisions. In particular, $T\to\infty$ along every sequence on $J=12$ with $N\to\infty$. This argument requires finiteness on each individual curve and uses no uniform bound on its number of points. [Faltings (1983)](https://link.springer.com/article/10.1007/BF01388432)

## Transfer to the second-order term

If (1) failed, some sequence with $N\to\infty$ would have $H\le c_0N^{3/5}+CN^{3/10}$ for a fixed $C\ge0$. The package2 lower limit bound forces $H/N^{3/5}\to c_0$. Its saturation lemma therefore gives

$$
 u/N\to2,\quad a/u^{1/5}\to(243/2720)^{1/5},\quad
 r=(k-a^2)/a^2\to r_0=16/9,\quad J=12\quad\text{eventually}.
$$

Write $e=a/u$ and $E=8+(8-r)e$. Equations (2) and $v^2=q^2+4(au+k)/3$ become

$$
\begin{aligned}
 3E\frac{q^2}{au}&=9r-16+4(r-8)e+(2r^2+4r-16)e^2,\\
 3E\frac{v^2}{au}&=9r+16+32(1+r)e+(-2r^2+32r+16)e^2.
\end{aligned}
$$

Since $E>0$ and $r\to r_0$, the first equation gives $9r-16\ge-O(e)$. Now $a^2(9r-16)=2d$, and $a^2e=a^3/u\to0$. Hence $d\ge0$ eventually by integrality. The fixed-$T$ finiteness result gives

$$
 d/\sqrt a=\sqrt{4T-27/a}\longrightarrow\infty,
 \qquad (r-r_0)u^{3/10}=\frac{2d}{9a^2}u^{3/10}\longrightarrow\infty. \tag{4}
$$

The identity $F=JD$ gives $a^5/u=JE/[9r(r^2+64)]$. Substituting in the formula for $v^2$ gives, uniformly near $(r,e)=(r_0,0)$,

$$
 \frac{v}{u^{3/5}}=K(r)+O(e),\qquad
 K(r)=\left(\frac{12\cdot8}{9r(r^2+64)}\left(\frac{16+9r}{24}\right)^5\right)^{1/10}.
$$

The error follows from smoothness, since $r_0>0$, $E(r_0,0)=8$, and the expression under the root is positive there. One computes $K(r_0)=(32/85)^{1/10}=2^{-3/5}c_0$ and $K'(r_0)/K(r_0)=2151/27200>0$. The mean value theorem, (4), and $eu^{3/10}\to0$ yield $(v-K(r_0)u^{3/5})/u^{3/10}\to\infty$. Finally $H\ge v$ and $u\ge2N$, contradicting the assumed upper bound. This proves (1).

## A logarithmic rate for the second-order term

There is an absolute $c_1>0$ such that every sufficiently large collision satisfies

$$
 H\ge c_0N^{3/5}+c_1N^{3/10}(\log N)^{1/3936600}. \tag{5}
$$

Apply Theorem 2.2 of Bérczes, Evertse and Győry to $P_T(d)=bq^2$, with $b=23328T^4$, over $K=\mathbb Q$ and with only its real place in $S$. Both unknowns are integers, $b\ne0$, and $P_T$ is squarefree of degree $n=9$ for every admissible $T$. The number field degree, $|D_K|$, $|S|$, and the empty product $Q_S$ are all 1. The theorem gives the absolute logarithmic height bound

$$
 \log\max(1,|d|)\le 36^{212\cdot9^4}
       \exp(50\cdot9^4\,\widehat h),
 \qquad e^{\widehat h}=\max(1,|b|,\|P_T\|_\infty),
$$

where $\|P_T\|_\infty$ is its largest absolute coefficient. This maximum is at most $10^8T^6$ by the displayed formula for $P_T$. In particular, $\log\max(1,|d|)\ll T^{300\cdot9^4}$, with an absolute constant. [Bérczes–Evertse–Győry, Theorem 2.2, equation (2.6)](https://publi.math.unideb.hu/paper/1797/download/10_5486_PMD_2013_5748.pdf)

If no $c_1$ worked, one could select a sequence $N_i\to\infty$ on which $(H-c_0N^{3/5})/[N^{3/10}(\log N)^{1/3936600}]\le 1/i$, with $N=N_i$. As in the proof of (1), the leading ratio converges to $c_0$, so $J=12$ eventually, $d\ge0$, $u\sim2N$, and $a\asymp N^{1/5}$. Since $d^2=4aT-27$ and $T\ge1$, we have $\log d\gg\log N$. The height bound implies $T\gg(\log N)^{1/(300\cdot9^4)}$. Consequently

$$
 (r-r_0)u^{3/10}=\frac{2d}{9a^2}u^{3/10}
 \gg \sqrt T\gg(\log N)^{1/(600\cdot9^4)}.
$$

The positive derivative of $K$ and the error $eu^{3/10}=o(1)$ now give a positive constant lower bound for the normalized difference on this sequence, a contradiction. Since $600\cdot9^4=3936600$, this proves (5). The coefficient $c_1$ and the numerical onset in (5) have not been computed.

## A locally soluble slice with no positive integer solution

There is also an effective upper bound on $s$ for each fixed $a$ on $J=12$. Put $B=81s^2-36a^2s+640a^4+27$. Formula (3) gives

$$
 B^2-(108a q)^2=64a^2\bigl[(738a^4+243)s+6400a^6+540a^2\bigr].
$$

If $s\ge500a^6$, then $B>80s^2$, while the positive right side is at most $64(981/500+6940/500^2)s^2<128s^2$. It lies below $2B-1$, which would put $(108a q)^2$ strictly between consecutive squares. Consequently $s<500a^6$ on each fixed-$a$ slice. Testing the two squares in (3) for these $s$, reconstructing the four arguments from the sums and differences and checking their integrality and positivity gives a finite decision procedure for any specified $a$.

The fixed choice $a=1,J=12$ admits a complete integer-point exclusion. Put $B_s=81s^2-36s+667$. Completing the square in (3) gives

$$
 (108q)^2=B_s^2-64(981s+6940).
$$

For $s\ge395$, $0<64(981s+6940)<2B_s-1$. The difference at 395 is 5103 and its derivative is positive and increasing thereafter. Thus the right side lies strictly between consecutive squares. Testing the positive odd integers $s<395$ with exact integer square roots leaves only $s=1,q=0$, for which $v^2=20$. This proves global nonexistence on this slice.

At each odd prime $p$, take any positive integer $s\equiv0\pmod p$. With $a=1$, both right sides of (3) are $1/16\pmod p$, so both have roots in $\mathbb Z_p$ by Hensel's lemma. At $p=2$, use $s=39$. The two values are $4\cdot321385$ and $64\cdot21025$, each an even power of 2 times a unit congruent to 1 modulo 8. They are 2-adic squares and their roots are even. The integer $u$ is even there, giving integral 2-adic $x,y,z,t$ after halving the pair sums and differences. These properties persist for $s$ sufficiently close to 39 in $\mathbb Z_2$. The Chinese remainder theorem supplies arbitrarily large positive odd $s$ satisfying these conditions at any prescribed finite set of primes. For large $s$, the real square roots in (3) are $O(s^2)$ and $u\asymp s^3$, so all four real arguments can be chosen positive. Direct substitution of (3) gives the original quartic equality and $F=12D$ over each completion, with $D=6s(s^2+16)>0$ as a rational integer. Thus no finite congruence sieve alone rules out the slice, despite its global integer obstruction.

The existence of positive integral collisions for some $a>1,J=12$, the sharp leading constant, and an improvement in the leading exponent remain open here. From the repository root, `python3 research/package2-followup/quartic/verify.py` reproduces the symbolic identities, discriminant certificate, and finite square check with SymPy.
