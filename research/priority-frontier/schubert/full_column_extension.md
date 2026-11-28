# Extending a full single column by a new last cell

For a Schubert board consisting of one column at its full available height, the normalized row of rank \(n\) is
\[
 F_n=A_n+\sum_{j=1}^{n-1}(A_n-A_j A_{n-j}),\qquad
 A_n=P_n^{(1,1)}/(n+1).
\]
For every \(n\ge2\), \(F_{n-1}\) strictly interlaces \(F_n\). Here the old column has height \(n-2\) and the new one height \(n-1\), so the last cut is new. Together with the [fixed-column transfer theorem](discrete_cut_interlacing.md), this answers Alexandersson's row-extension question for all partitions whose Schubert board has at most one column, equivalently \(\lambda_2\le2\) when a second part exists. If the last part is one the column is unchanged, and if it is two all parts after the first must equal two. In the original variable \(Q_n=(Z_n-(1+t)Z_{n-1})/t\) strictly interlaces \(Z_{n-1}\), by evaluation at the negative zeros of \(Z_{n-1}\) and degree at most \(n-2\). [Alexandersson's question](https://www.symmetricfunctions.com/schubertMatroidZ.htm#adding-a-row-and-real-rootedness)

In fact an arbitrary nonnegative new last-cut weight can be added to any nonnegative weights on the earlier cuts. Let \(F_n^0\) be the new row with old weights carried forward, before adding the last cut, and let \(s\) be any zero of the old row \(F_{n-1}\). By the [fixed-cut interlacing theorem](discrete_cut_interlacing.md), \(F_n^0(s)\) has the opposite sign to \(A'_{n-1}(s)\): at the largest old root the new degree-\(n\) polynomial is negative between its two largest roots, while \(A'_{n-1}\) is positive beyond its largest zero. The signs alternate at earlier old roots because both interlacings are strict. The new last-cut term is
\[
 w(A_n-xA_{n-1})=-\frac{w(1-x^2)}{n+2}A'_{n-1},\qquad w\ge0 .
\]
It has the same sign as \(F_n^0\) at every old root whenever \(w>0\). The two endpoint values stay \(1,(-1)^n\), so all \(n\) gaps, including the two outside gaps, contain simple roots. This proves the full nonnegative cut-weight extension. For rank two the same argument follows directly from \(F_1=x\) and the last-cut expression. The following independent calculation treats the unit-weight full column.

The unrestricted normalized Motzkin generating function \(M(s)=\sum_{n\ge0} A_ns^n\) satisfies
\[
 M=1+xs M+\tfrac14(x^2-1)s^2M^2
\]
by first-step decomposition. With the normalized Jacobi recurrence and derivative identities this gives
\[
 [s^n]M^2=\frac{4(A_{n+2}-xA_{n+1})}{x^2-1}=\frac4{n+4} A'_{n+1},
 \qquad
 A'_{n+1}=(n+1)A_n+\frac{n+1}{n+3}xA'_n .
\]
The second identity follows by applying \((1-x^2)A'_i=i(A_{i-1}-xA_i)\) at consecutive indices and the three-term recurrence. Consequently \(F_n=(n+2)A_n-4A'_{n+1}/(n+4)\) is a positive multiple of
\[
          a_n A_n-xA'_n,\qquad a_n=\frac{(n^2+2n+4)(n+3)}{4(n+1)} .
\]

Let \(r\ne0\) be a root of \(F_n\), and write \(h=a_n/n>1\). The identities
\[
 A_{n-1}=xA_n+(1-x^2)A'_n/n,\qquad
 (1-x^2)A'_{n-1}=(n+2)(xA_{n-1}-A_n)
\]
show that \(F_{n-1}(r)\) is a positive multiple of \(A_n(r)/r\) times
\[
 H(r)=h a_{n-1}-(h-1)(a_{n-1}+n+2)r^2 .
\]
Here \(A_n(r)/r=A'_n(r)/a_n\). To control the last factor, \(F_n(1)=1\) and Jacobi differentiation give
\[
 S=F'_n(1)=\frac{n(n+3)}4+\frac12\sum_{j=1}^{n-1}j(n-j)
            =\frac{n(n^2+3n+8)}{12}.
\]
The [single-cut real-rootedness theorem](single_cut.md) gives all simple roots of \(F_n\) in \((-1,1)\) and the strict common interlacer \(A'_n\). Opposite roots \(\pm r\) contribute \(2/(1-r^2)\) to the logarithmic derivative at one, with all remaining contributions positive. Thus \(1-r^2\ge2/S\), and
\[
 \begin{split}
 S H(r)&\ge S\big(a_{n-1}-(n+2)(h-1)\big)+2(h-1)(a_{n-1}+n+2)\\
 &=\frac{(n+2)(n+3)(n^4+n^3+6n^2+36n+24)}{16n^2(n+1)}>0 .
 \end{split}
\]
At the possible root \(r=0\) (odd \(n\)), \(A'_n(0)=nA_{n-1}(0)\) gives the same sign conclusion directly. Thus \(F_{n-1}\) has the sign of \(A'_n\) at every root of \(F_n\). These signs alternate, and the degree gives exactly one simple zero in every gap, as required.
