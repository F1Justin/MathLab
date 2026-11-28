# The sharp width threshold for Jacobi extrema to interlace a full hook

Let \(A_n=P_n^{(1,1)}/(n+1)\). Take one Ferrers column of height \(n-1\) and additional columns of height one, where \(n\ge2\). Give the tall column weight \(w\ge0\), and let \(c\ge0\) be the sum of the short-column weights. Let \(F_n\) be the normalized Schubert polynomial in \(x=(1+t)/(1-t)\) from the [Motzkin–rook model](https://www.symmetricfunctions.com/schubertMatroidZ.htm). Write \(r_n\) for the largest zero of \(A_n'\), \(u_n=1-r_n^2\), and \(q_n=n(n+1)/(n+4)\). Then \(A_n'\) strictly interlaces \(F_n\) exactly when
\[
       1+wq_n+c\left[(1+(n-1)w)u_n-\frac{3nw}{n+4}\right]>0.        \tag{1}
\]
This gives a finite-rank necessary and sufficient condition for every pair of weights. The [full-hook theorem](full_column.md#a-full-hook-at-every-rank) supplies the common interlacer \(A_{n-1}\) for every such hook.

For any fixed \(w>0\), the coefficient of \(c\) in (1) is eventually negative. Write \(c_*(n,w)\) for the \(c\) at which the left side vanishes. If \(\xi\) is the first positive zero of \(J_2\), then
\[
 c_*(n,w)=\frac n3+\frac{1}{3w}+\frac13+\frac{\xi^2}{9}+o(1).
\]
In particular, for every sufficiently large \(n\), a genuine unweighted hook with \(c\) short columns admits \(A_n'\) as a strict interlacer exactly when
\[
                  c\le\left\lfloor\frac{n+10}{3}\right\rfloor .      \tag{2}
\]
The choice \(w=1,\ n=10,\ c=40\) already fails the extrema test.

## Computation at the extrema

For a single time put \(F_{n,\{1\}}=A_n-xA_{n-1}\). The convolution \(C_n=\sum_{j=0}^n A_j A_{n-j}\) equals \((A_{n+2}-xA_{n+1})/y\), with \(y=(x^2-1)/4\), by the Motzkin first-return recurrence. Write \(G_n=(n+1)A_n-C_n\) for the contribution of a single tall rook. The two-rook contribution from the two types of columns is \(G_n-xG_{n-1}-F_{n,\{1\}}\), by removing the initial horizontal step from the paths which fail the first-time condition. Thus
\[
 F_n=A_n+wG_n+cF_{n,\{1\}}+cw(G_n-xG_{n-1}-F_{n,\{1\}}).
\]
At any zero \(x\) of \(A_n'\), the Gegenbauer derivative identity gives \(A_{n-1}=xA_n\); the three-term recurrence then gives \(A_{n+1}=xA_n\). Substituting in the identity for \(C\) yields
\[
 C_{n-1}=0,\qquad C_n/A_n=4(n+1)/(n+4),\qquad G_{n-1}/A_n=nx .
\]
It follows that \(F_n/A_n=1+wq_n+c[(1+(n-1)w)(1-x^2)-3nw/(n+4)]\) at every such node. This is smallest at the two outermost nodes. Both \(F_n\) and \(A_n\) have endpoint values \(1,(-1)^n\) at \(1,-1\). Alternating signs give one simple root in each of the \(n\) intervals cut out by the \(n-1\) extrema. Conversely, strict interlacing forces exactly these signs, since [all the hook roots lie inside \((-1,1)\)](full_column.md#a-full-hook-at-every-rank). This proves (1), including failure of strictness at equality.

For the stated finite example, \(A_{10}'(9/10)=-4829224023/51200000000<0\) and \(A_{10}'(1)=65/2\), so \(r_{10}^2>81/100>1131/1400\). Formula (1) with \(w=1,c=40\) is negative precisely when \(r_{10}^2>1131/1400\).

## Passage to integer widths

The derivative \(A_n'\) is a positive multiple of \(P_{n-1}^{(2,2)}\). The Jacobi Mehler–Heine limit at the right endpoint gives \(n^2u_n\longrightarrow\xi^2\). Indeed the normalized functions of \(z\) at \(x=\cos(z/(n-1))\) converge locally uniformly to a positive constant times \(J_2(z)/z^2\); its value at zero and simplicity at the first positive zero identify the first zero of the approximants. Expanding (1) at equality now gives the displayed asymptotic for \(c_*(n,w)\). [Mehler–Heine formula](https://dlmf.nist.gov/18.11.E5)

To justify the rounding in (2), it suffices to show \(24<\xi^2<27\). The Bessel product and the first three Taylor coefficients of \(8J_2(z)/z^2\) give \(\sum_{k\ge1}j_{2,k}^{-4}=1/576\), hence \(j_{2,1}^2>24\). At \(z=\sqrt{27}\), the series has terms \(2(-27/4)^k/[k!(k+2)!]\), decreasing in absolute value from \(k=1\). The sum through \(k=6\) is \(-794203/146800640<0\), an upper bound for the full sum. The normalized function is positive at zero, proving the upper bound. At \(w=1\) the constant term in \(c_*\) consequently lies strictly between \(10/3\) and \(11/3\). Taking the three residues of \(n\) modulo three gives (2). [Bessel product](https://dlmf.nist.gov/10.21.E15)
