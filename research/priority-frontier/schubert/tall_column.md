# Adding a sufficiently tall column preserves the boundary zero count

Let \(B\) be any fixed Ferrers board of height \(a\ge1\) with nonnegative column weights. Use its [boundary polynomial](rook_jacobi.md) \(H_B(s)=\sum_J w_J H_J(s)\), where \(w_J\) counts the placements with exactly these occupied rows. Suppose \(H_B\) has no zeros on the unit circle. Set
\[
 \kappa=\min_{|s|=1}|H_B(s)|,\qquad C=\sum_J 2^{|J|}w_J.
\]
For every integer \(b>a\) satisfying \(b>C(a+800a^2)/\kappa\), adjoin a leftmost column of height \(b\), with any nonnegative weight \(t\). The resulting boundary polynomial has no unit-circle zeros and has exactly the same number of open-disk zeros, counted with multiplicity, as \(H_B\). In particular disk stability propagates through arbitrarily many successive columns, provided each new height passes the test for the preceding board. These boards may have arbitrarily many distinct heights and a single cell in the bottom row.

Write \(L_b\) for the coefficient of \(t\) in the new boundary polynomial \(H_B+tL_b\), and \(m=\max J\) with \(m=0\) for the empty set. The newly inserted rook, when present, must be last in row order, so
\[
 L_b=\sum_J w_J\sum_{j=m+1}^{b} H_{J\cup\{j\}} .
\]

**Away from one.** Put \(p=|1-s|\), \(U\sim{\rm Beta}(3/2,3/2)\), \(v=1-U+Us\), \(D_k=\mathbb E v^k\). On the closed disk \(|D_k|\le1\), and every consecutive sum of the \(D_k\) has modulus at most \(2\mathbb E(1/U)/p=8/p\). Now \(H_J-H_{J\cup\{j\}}\) specifies a zero at time \(j\) while testing positivity at all times in \(J\). Inclusion–exclusion expresses it as a sum over \(I\subseteq J\), each term a product of short \(D\)'s times \(D_{j-\max I}\), using \(\max\emptyset=0\). Summing over \(j\) therefore costs at most \(2^{|J|}8/p\). Also \(|H_J|\le2^{|J|}\). It follows that
\[
 |L_b-bH_B|\le C(a+8/p).
\]
If \(p\ge1/(100a^2)\), the right side is strictly less than \(b\kappa\). On this part of the circle \(H_B+tL_b=(1+tb)H_B+t(L_b-bH_B)\) cannot vanish for any \(t\ge0\).

**Near one.** Take \(0<p\le1/(100a^2)\) on the unit circle. If \(J\ne\emptyset\), put \(i=\min J\). A path positive at \(i\) and zero at some later tested time up to \(a\) must make at least two moves by time \(a\), or, more precisely, by time \(m=\max J\). In the complex transfer \(P_s=(1+s)I/2+(1-s)B_0/2\), \(B_0\) is a stochastic birth–death matrix. Thus the sum of absolute weights of the relevant prefixes through time \(m\) is bounded by
\[
 \sum_{k\ge2}\binom mk(p/2)^k\le (ap/2)^2e^{ap/2}/2 .
\]
A remaining terminal positivity test at \(j>m\), conditional on height \(d\) at time \(m\), costs in modulus at most two. Indeed the conjugate of \(P_s\) by the height factor \(d+1\) is \(T_s=(1+s)I/2+(1-s)(S+S^*)/4\) on the discrete half-line, with \(S\) the unilateral shift. Its norm is at most one by the spectral theorem, and \((P_s^k)_{d,0}=(T_s^k)_{d,0}/(d+1)\). This bounds the final factor \(1-(P_s^{j-m})_{d,0}\). Consequently replacing \(J\) by \(\{i\}\) in either \(H_J\) or \(H_{J\cup\{j\}}\) has absolute error at most \(a^2p^2/2\).

Put \(f_i=(1-v^i)/(1-s)=U\sum_{k<i}v^k\). Then \(|f_i-iU|\le a^2p/2\), and the two-time identity is
\[
 \frac{H_{\{i,j\}}}{1-s}=\mathbb E f_i+\mathbb E[(f_i-\mathbb E f_i)v^{j-i}].
\]
Its real part is at least \(i/2-i\mathbb E|U-1/2|-3a^2p/2\ge i/4-3a^2p/2\), since the standard deviation of \(U\) is \(1/4\). Thus every nonempty \(J\) gives \(\operatorname{Re}[H_{J\cup\{j\}}/(1-s)]\ge i/4-2a^2p>1/8\), uniformly in \(j>m\). Likewise \(\operatorname{Re}[H_J/(1-s)]\ge i/2-a^2p>0\). The empty summand of \(H_B\) has real part \(1/2\) after division by \(1-s\). For the empty old row set in \(L_b\), the corresponding quotient is \(\mathbb E[U\sum_{k=0}^{b-1}(b-k)v^k]\), whose real part is at least \(b/4\) by the Fejér identity in the single-column proof. Thus \((H_B+tL_b)/(1-s)\) has positive real part here. At \(s=1\) the full polynomial is one.

The curve on the unit circle stays nonzero throughout the continuous deformation of the added column weight from zero to its final value. The argument principle proves the assertion. The hypotheses do not cover arbitrary intermediate column heights, and deciding disk stability for every Ferrers board remains open.

## A negative real part on a disk-stable irregular board

Take columns with heights \(1,40,62,63,72,104\), in right-to-left order. For these six heights, arbitrary nonnegative column weights give a boundary polynomial with no zero in the closed disk. At the weights \(2000,1,1,1,1,1\), the resulting real Ferrers board has 2000 ordinary height-one columns and five ordinary taller columns: only one height-one rook can be used. At the unit point \(s=(99+20i)/101\) its boundary polynomial satisfies the strict integer-certified inequality
\[
 -288392579 < \operatorname{Re} H(s) < -288392578 .
\]
Thus a negative real part does occur on an actual Ferrers board while the full winding is zero.

For a nonempty selection \(I\) of the six columns, let \(K_I\) be its coefficient in the boundary polynomial. The [exact verifier](verify_irregular_symbol.py) computes all these coefficients in one transfer. After multiplying each step by four and conjugating by height plus one, the step polynomials are \(2(1+s)\) for a hold and \(1-s\) for either move, with the forbidden downward move at zero discarded. At a positive height the largest-index selected column can be marked if its height reaches the current time. Restoring the terminal height factor gives the coefficients of \(4^{104}K_I\) in integers. Every nonempty selection has \(K_I(1)=0\).

For each selection the verifier proves \(\operatorname{Re}[K_I(s)/(1-s)]>0\) on the whole unit circle, using the continuous value at \(s=1\). It divides by \(1-s\) exactly, converts the real part to a polynomial in \(v=(1-\cos\theta)/2\) using Chebyshev polynomials, and subdivides \([0,1]\) dyadically until every Bernstein coefficient is positive. All 63 selections pass, with 353 certified subintervals in total and maximal subdivision depth four. The empty term contributes real part \(1/2\) to \(H/(1-s)\) away from \(s=1\), and \(H(1)=1\). Multiplying all column weights continuously by a parameter from zero to one preserves nonvanishing at every boundary point, so the disk count remains zero. The strict negative real part at the specified weights is a separate exact rational evaluation of the same transfer.
