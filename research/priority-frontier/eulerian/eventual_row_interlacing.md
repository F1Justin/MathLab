# Eventual strict interlacing of consecutive ordinary Eulerian square rows

Let \(H_n(x)=\sum_{j,k}A(n,j)A(j,k)x^k\), where \(A(n,j)=E(n,j-1)\) is the shifted Eulerian triangle. After removing the common zero, all sufficiently large consecutive rows strictly interlace. More precisely, write \(t_{n,k}\) for the logarithm of the modulus of the \(k\)-th nonzero root, ordered by increasing modulus. Then for all sufficiently large \(n\),
\[
       t_{n+1,k}<t_{n,k}<t_{n+1,k+1}\qquad(1\le k\le n-1).
\]
The [eventual real-rootedness result](cube_root_transition.md) gives simple negative nonzero roots. The [left and positive-middle interlacing results](right_row_interlacing.md) already prove the displayed inequalities for \(t_{n,k}\le c\sqrt n\) with some absolute \(c>0\). We compare roots outside this range, including the scales at which two leading factors have coincident limiting roots.

## The local movement at large positive log-modulus

Fix \(c_0>0\). Consider any sequence of roots at log-modulus \(T\ge c_0\sqrt n\) with \(s=n/T\to\infty\). Then row \(n+1\) has a root at log-modulus
\[
                            T+(1+o(1))/s .                          \tag{1}
\]
If another row-\(n\) root occurs at \(T'>T\), its distance satisfies \((T'-T)s\to\infty\) uniformly in this sequential regime. Thus the root in (1) precedes the next row-\(n\) root.

To prove this use the [exterior expansion](exterior.md) for the reversed polynomial \(R_n(w)=w^nH_n(1/w)\). The center \((P,Q)\) maximizes \(W(A,B)=A^n B^{n-A+1}e^{-T(A+B-2)}\) on its integer triangle and satisfies \(P,Q\sim s\). Write \(w=-e^{-T+y}\), \(i=A-P,\ j=B-Q\), and normalize
\[
 F(y)=\frac{R_n(w)}{W(P,Q)(-e^y)^{P+Q-2}},\qquad
 F^+(y)=\frac{R_{n+1}(w)}{PQ\,W(P,Q)(-e^y)^{P+Q-2}} .
\]
In particular \(F(0)=0\). Write \(U,V\) below for the two local factors of the exterior expansion evaluated at \(-e^y\), with primes denoting \(y\)-derivatives. That expansion gives
\[
                         F=UV-Q^{-1}U'V'+O(s^{-2}).                \tag{2}
\]
All estimates here hold uniformly on fixed small complex disks in \(y\), including derivatives on a slightly smaller disk.

Under increasing \(n\) by one, each **model** weight at fixed \(T,A,B\) is multiplied by \(AB\). Put
\[
 \delta=\tfrac12(P^{-1}+Q^{-1})\sim1/s,\qquad
 \eta=\tfrac12(P^{-1}-Q^{-1})=o(1/s).
\]
The same local expansion and tails give
\[
 F^+-F=\delta F'
        +\eta\big(U'V-UV'+O(s^{-1})\big)+O(s^{-2}).                \tag{3}
\]
In detail, if \(f_{ij}\) is the signed normalized model summand at these fixed centers, then \(\sum(i+j)f_{ij}\) equals \(F'\) up to the exponentially small replacement error. The mixed factor in the model is \(\exp[-i\log(1+j/Q)]\), where \(i,j\) are integer offsets. Replacing it by one in \(\sum(i-j)f_{ij}\) costs \(O(s^{-1})\) by the Gaussian absolute moment bounds in the exterior proof, and leaves \(U'V-UV'\). Also \(\sum ij f_{ij}=O(1)\). Now multiply by
\[
 AB/(PQ)=1+\delta(i+j)+\eta(i-j)+ij/(PQ).
\]
On \(s/2\le A,B\le2s\), replacing the true Eulerian factors by powers in either row costs \(O(n^2 e^{-c_1n/s})\) times the positive radial sum, which is bounded at each fixed local disk. Outside this rectangle the true and model contributions, including the extra cells of rank \(n+1\), are \(e^{-\Omega(n)}\) up to polynomial factors by the exterior tail bound (applied on the rank-\(n+1\) triangle and using the same scalar envelope). Multiplication by \(AB/(PQ)\) or any fixed power of the offsets costs at most a polynomial in \(n\) on the actual triangles. Local scalar extensions beyond them have tails smaller than every fixed power of \(s^{-1}\). These bounds justify (3) for the genuine rows.

Pass to a subsequence where \(U,V\) have the theta or binomial limits in the [exterior proof](exterior.md). If only one limiting factor vanishes at zero, then \(|F'(0)|\) stays bounded away from zero and there are no other row-\(n\) roots tending to the same point. The bracket in (3) is bounded, so \(F^+(0)=\delta F'(0)(1+o(1))\).

If both limiting factors vanish, write \(a,b\) for their respective finite simple real zeros near zero and set \(g=((a-b)^2/4+1/Q)^{1/2}\). The exterior splitting calculation gives the two roots of \(F\) near zero at \((a+b)/2\pm g(1+o(1))\). There are exactly two counting multiplicity. One of them is zero, so \(|a|+|b|=O(g)\) and the other root has distance \((2+o(1))g\). The derivatives of \(U,V\) near zero approach nonzero constants. Differentiating (2), the leading derivative at zero is \(U'(0)V(0)+U(0)V'(0)\), whose quotient by \(U'(a)V'(b)\) equals \(-a-b+o(g)=\pm(2+o(1))g\). The mixed correction costs \(O(s^{-1})=o(g)\). Consequently \(|F'(0)|\asymp g\) and \(|U'(0)V(0)-U(0)V'(0)|=O(g)\). Since \(g\ge Q^{-1/2}\), both errors in (3) at zero are \(o(\delta|F'(0)|)\), including the potentially unbalanced \(\eta\)-term. This again proves \(F^+(0)=\delta F'(0)(1+o(1))\), and every other old root is farther than order \(1/s\) from zero.

In both cases \((F^+)'(0)=F'(0)+O(s^{-1})=F'(0)(1+o(1))\) by differentiating (3), and higher derivatives stay bounded. For bounded real \(v\),
\[
                 F^+(\delta v)/(\delta F'(0))=1+v+o(1),
\]
because \(\delta=o(|F'(0)|)\). Opposite signs at \(v=-1\pm\epsilon\), for every fixed \(\epsilon>0\), and the derivative estimate give a unique zero there with \(y=-(1+o(1))/s\). Log-modulus in the original variable is \(T-y\), proving (1). The argument applies to every subsequential limit, including \(n/s^2\to\infty\).

## The fixed extreme ranks and the degree count

If \(T\ge c_0\sqrt n\) is a logarithmic root modulus along a sequence with bounded \(s\), the end of the exterior proof reduces, after subsequence extraction, to the tied cells \(L,L+1\) for some fixed \(L\ge1\). Other scales admit no root. The two absolute exterior ranks and their asymptotics are given by the [paired-edge theorem](paired_edge.md). In the reciprocal variable they have moduli \(\rho^n (z_-+o(1)),\rho^n (z_++o(1))\), where \(\rho=L/(L+1)\) and \(0<z_-<z_+\). Their strict \(\rho\)-separation means \(z_-/\rho<z_+\), as proved there by the positive-root recursion for \(Q_{2,L}\). Thus in the original variable, both corresponding roots of row \(n+1\) move to the right in log-modulus by \(\log(1/\rho)+o(1)\), strictly less than the limiting gap between the two. Gaps between different fixed clusters grow linearly in \(n\). This places a later-row root strictly inside every old gap beginning in this regime and places one beyond the largest old root.

It remains to count. For consecutive old roots at logs \(a<b\) with \(b\le c\sqrt n\), the previous interlacing result supplies a new root in the open gap. If \(b>c\sqrt n\), then \(a\ge(c/2)\sqrt n\) for all sufficiently large \(n\). Indeed the positive-middle phase derivative is \(\gg n/T^2\) through the interval \([(c/2)\sqrt n,c\sqrt n]\) after reducing \(c\) within the proved range, so many full phase cells, each with a root, lie there. Now apply the local movement and spacing result with \(T=a, c_0=c/2\), or the bounded-\(s\) result just proved. A subsequence of hypothetical failing gaps always belongs to one of these two cases. Thus every old gap contains a new root. The left-side theorem puts one new root below the smallest old one; the fixed extreme calculation puts one above the largest. These \(n\) disjoint intervals account for every nonzero root of row \(n+1\), which has degree \(n+1\) and a simple zero at zero. This proves eventual strict interlacing.

The [finite checker](check_bulk_row_interlacing.py) separately verifies genuine strict interlacing, using exact rational isolation, for every adjacent pair through rank 55. The eventual proof does not supply an effective starting rank; the all-rank interlacing statement and the original all-rank real-rootedness conjecture remain open.
