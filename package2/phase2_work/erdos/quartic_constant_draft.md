# 四次幂短区间 Sidon：显式渐近常数候选

Status: a derived corollary of Garaev–Garayev–Konyagin (2026), retaining their exponent 3/5. One independent mathematical review of the full argument and two independent exact algebra checks have been completed. The review is recorded in `../graph/quartic_independent_review.md`; the algebra checks are `quartic_check.py` and `../graph/quartic_independent_check.py`. The result has not been formalized in Lean. Originality and priority remain subject to further literature review; the completed checks establish the mathematical argument at the stated scope.

Primary source: M. Z. Garaev, F. M. Garayev, S. V. Konyagin, *On Sidon sets with squares, cubes and quartics in short intervals*, arXiv:2602.08807v2, §8, https://arxiv.org/html/2602.08807v2 . Published in Analysis Mathematica 9 September 2026, DOI 10.1007/s10476-026-00184-y. Their Theorem 6 proves the existence of an absolute c>0 with a Sidon interval of length c N^(3/5); the authors explicitly did not try to improve the exponent.

## Candidate proposition

For every sequence of nontrivial positive-integer solutions

    x^4 + y^4 = z^4 + t^4,  {x,y} ≠ {z,t},

put N=min(x,y,z,t) and H=max(x,y,z,t)-N. If N tends to infinity, then

    liminf H / N^(3/5) ≥ c0,   c0 = (2048/85)^(1/10) ≈ 1.3746467279315263450 .

Equivalently, for every fixed 0<c<c0, there exists N0(c) such that for every integer N≥N0(c), the fourth powers with arguments in the closed interval [N,N+c N^(3/5)] form a Sidon set. The proof supplies an existential threshold N0(c); its numerical value remains to be extracted. Sharpness of c0 is a separate open question.

## Exact identities from GGK, rechecked independently

Reorder the two pairs so x≥y, z≥t, x+y>z+t. Equality of pair sums would force the unordered pairs to coincide by strict convexity. Parity of fourth powers gives x+y≡z+t (mod 2). Set

    u=z+t, a=(x+y-z-t)/2>0, q=x-y≥0, v=z-t≥0.

Then x+y=u+2a, and q≡u≡v (mod 2). Thus v²−q² is divisible by 4, so

    k=(3v²−4au−3q²)/4

is an integer. Substitution into the original quartic equation gives

    (u+2a)^4+6(u+2a)²q²+q⁴=u⁴+6u²v²+v⁴.                       (A)

Eliminating v², as in GGK, gives the exact relations

    3 v² = 4 a u + 3 q² + 4 k,                                     (1)
    3 q²(8 a u+9 a²-k)
      = (9 k-25 a²)u²+4au(k-9a²)+2k²-18a⁴.                       (2)

We next establish k>a² throughout the domain of positive-integer nontrivial collisions. Define

    P(w)=(u+2a)^4+6(u+2a)²q²+q⁴−u⁴−6u²w−w².

Equation (A) says P(v²)=0. The function P is strictly decreasing for w≥0. At w0=q²+4a(u+a)/3, direct factorization yields

    P(w0)=(64/9)a(a+u)(2a²+2au+3q²)>0.

Consequently v²>w0, which is exactly k>a². This argument establishes positivity before any short-interval or asymptotic restriction is imposed. Put

    D=8au+9a²-k,
    R=(9k−25a²)u²+4au(k−9a²)+2k²−18a⁴,
    F=9(k-a²)((k-a²)²+64a⁴).

Equation (2) is R=3q²D. If D≤0, then k≥8au+9a²>9a², making each of the three displayed terms of R strictly positive, whereas 3q²D≤0. This contradiction proves D>0 throughout the same domain. Since k>a², we also have F>0. The following exact polynomial identity establishes the divisibility and the integer quotient together.

## A uniform congruence strengthening

Define the integer-coefficient polynomial

    L = 192a²q²+63a⁴+200a³u+74a²k−72aku−9k².

Independent polynomial division gives the identity

    F−DL=64a²(R−3q²D).

On an actual collision the right side vanishes. Therefore

    J:=F/D=L∈Z_{>0}.                                            (L1)

Equation (1) implies k+au≡0 (mod 3). Reducing (L1) modulo 3 yields

    J ≡ 2a²(au+k) ≡ 0 (mod 3).

Reducing it modulo 8 gives

    J ≡ −(k−a²)² (mod 8) ∈ {0,4,7}.

The positive multiples of 3 smaller than 12 are 3,6,9; their residues modulo 8 are 3,6,1, all excluded. Therefore J≥12, equivalently F≥12D. The positivity arguments above make this a uniform lemma for every positive-integer nontrivial quartic collision. It strengthens the bare integrality step F≥D in GGK’s argument. Attainability of J=12 remains a separate question.

## Compactness and control of scales

It is enough to examine a subsequence on which H/N^(3/5)≤M for some fixed M. All implied constants in this section may depend on M and are uniform along this subsequence. Since H=o(N), we have u/N→2, and q,v≤H=O(u^(3/5)). Equation (1) gives a=O(u^(1/5)). Rewriting (2) gives the exact identity

    (9u²+4au+3q²)k+2k²
      =25a²u²+36a³u+18a⁴+24auq²+27a²q².                          (3)

All displayed summands are nonnegative, and a,u,k>0. Hence k=O(a²+a u^(1/5))=O(a u^(1/5)). In particular k=o(au), hence D~8au. Also F=O((k+a²)^3)=O(a³u^(3/5)). Since F≥D, we have a² ≫ u^(2/5). Thus a/u^(1/5) is bounded above and bounded away from zero, and k/u^(2/5) is bounded. Pass to a subsequence such that

    A=a/u^(1/5)→A*>0, K=k/u^(2/5)→K*,
    Q=q²/u^(6/5)→Q*≥0, V=v²/u^(6/5)→V*≥0.

For readability suppress stars in the next equations. Dividing (2) by u^(12/5) yields

    24 A Q = 9K-25A².                                            (4)

Dividing (1) by u^(6/5) yields

    V=(4/3)A+Q=(7A²+9K)/(24A).                                  (5)

Finally F≥12D, divided by u^(6/5), yields

    9(K-A²)((K-A²)²+64A⁴) ≥ 96A.                                (6)

All lower-order terms disappear because the established scale bounds hold uniformly along this subsequence. Equation (4) gives K/A²≥25/9.

## One-variable exact optimization

Write r=K/A²-1≥16/9. Inequality (6) implies

    A^5 ≥ 96 / [9 r(r²+64)].

Equation (5) therefore gives

    V^5 ≥ [(16+9r)/24]^5 · 96 / [9 r(r²+64)].                     (7)

The derivative of (16+9r)^5/[r(r²+64)] is

    2(9r+16)^4(9r³-24r²+1152r-512) / [r²(r²+64)²].

The cubic is strictly increasing: its derivative 27r²-48r+1152 is positive for every real r. At r=16/9 the cubic equals 122368/81>0. Hence (7) is minimized at r=16/9 and gives V^5≥32/85. Since H≥v and u/N→2,

    liminf H^10 / N^6 ≥ (32/85)·2^6 = 2048/85,

as claimed. A subsequence realizing any smaller liminf would be bounded and contradict this argument.

To obtain the interval statement, fix 0<c<c0. If arbitrarily large starting points B admitted a collision inside [B,B+cB^(3/5)], its actual minimum N would satisfy N≥B and H/N^(3/5)≤c. A sequence of such starting points tending to infinity would contradict the proved lower-limit bound. Thus there is a threshold N0(c) beyond which every such closed interval is Sidon.

## What this actually supplies

This isolates the continuous relaxation underlying the 3/5 exponent, combines it with a uniform congruence obstruction, and extracts an explicit asymptotic constant in that framework. The exponent remains 3/5. A putative sequence approaching c0 would require equality in every limiting step: strict monotonicity of the one-variable objective forces r=16/9, A^5=243/2720 and Q=0 at every subsequential limit. Consequently q²/u^(6/5)→0, k/a²→25/9 and the positive integer quotient F/D→12 along the entire sequence, so F/D must eventually equal 12. Exact integer and square conditions on that stratum may be substantially stronger than the continuous relaxation. Showing the quotient grows with a, or classifying its bounded levels, is an explicit structural research question.

## Finite experiment

`quartic_probe.py` enumerated every pair 1≤a≤32, floor(25a²/9)+1≤k≤4a², then every positive divisor D of F; it solved for u, checked q² and v² as exact integer squares, checked parity/positivity, and substituted into the original quartic equation. It covered 13,992 parameter pairs and 3,094,880 divisors in 1.32 CPU seconds, finding three witnesses, two primitive and one scaling. This is a bounded parameter slice, not a search over all solutions and not an optimality proof.

The primitive witnesses are 256^4+257^4=193^4+292^4 and 133^4+134^4=59^4+158^4. These are known-style equal-sum identities; no novelty is claimed for the witnesses. The experiment confirms the derived parameterization and feasibility of a small exact arithmetic exploration. A separate exact finite residue scan of the original equation modulo 3,5,7,8,9,11,13,16,17,32 corroborated the congruence obstruction. Modulo 16, J takes residues {0,12}; modulo 32, {0,12,16,28}. These scans supply no exclusion of J=12, so this round stops at the clean uniform lemma rather than pursuing more small-modulus gains.

## Originality search and limitations

Searches on 2026-11-28 for combinations of “Sidon”, “512/255”, “2048/85”, “10880”, “fourth powers short intervals constant”, and “quartics short intervals 3/5” found the GGK paper and discussions of it, and no matching explicit constant. This is an initial negative search result, not an originality certificate. The paper's original proof already contains the full elimination machinery, so attribution to GGK is essential; even if the constant is absent from the literature, the corollary's research value is modest and depends on whether it enables a structural theorem.
