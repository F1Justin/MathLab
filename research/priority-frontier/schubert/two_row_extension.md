# Appending a unit part for every Schubert board with at most two occupied rows

Take a Ferrers board confined to its first two rows, with arbitrary row lengths. At every admissible rank, its Schubert \(Z\)-polynomial strictly interlaces the polynomial obtained by appending a unit part to the partition. The theorem allows independent nonnegative weights \(u,v,w\) on the total contributions of placements with row sets \(\{1\},\{2\},\{1,2\}\), with empty weight one. In terms of the partition it covers all \(\lambda\) with \(\lambda_4\le1\) when a fourth part exists. The corresponding difference \(Q\) in [Alexandersson's add-a-row question](https://www.symmetricfunctions.com/schubertMatroidZ.htm) also strictly interlaces the preceding row.

Use the normalized variable \(x\in(-1,1)\) and \(A_k=P_k^{(1,1)}(x)/(k+1)\). They satisfy \(A_k=a_kxA_{k-1}-b_kA_{k-2}\), \(b_k=(k-1)/(k+2)\), \(a_k=1+b_k\). It suffices to compare \(F_n\) with \(F_{n-1}\) for \(n\ge4\); a board at preceding rank two has only one possible occupied row, handled by the [one-row theorem](rook_jacobi.md#strict-row-extension-for-a-one-row-board). Write \(z=1-x^2,\ y=-z/4,\ A_2=x^2+y\). The cut formula gives
\[
 F_n=c_0 A_n+c_1 A_{n-1}+c_2 A_{n-2},\qquad
 (c_0,c_1,c_2)=(1+u+v+w,-(u+w)x,-vA_2-wy).
\tag{1}
\]
The same \(c_i\) define the preceding row. In the basis \((A_n,A_{n-1})\) the first coefficient of \(F_n\) is \(U=c_0-c_2/b_n>0\), since \(A_2,y\ge-1/4\) and \(b_n>1/4\). At each root of \(A_{n-1}\), \(F_n=U A_n\). Also \(F_n(\pm1)=(\pm1)^n\). Thus \(F_n\) has \(n\) simple roots, one in each gap cut out by the roots of \(A_{n-1}\) and the endpoints.

**The two extreme roots.** Write \(\xi\) for the largest zero of \(A_n\). For \(n\ge4\), \(\xi\) exceeds the largest zero of \(A_2\), \(A_{n-1}(\xi)>0\), and \(A_{n-2}(\xi)=a_n\xi A_{n-1}(\xi)/b_n>0\). At \(\xi\) the marked contributions from the one-time row sets equal \(-\xi A_{n-1}\) and \(-A_2 A_{n-2}\), both strictly negative. The two-time contribution is \(-\xi A_{n-1}[1-z a_n/(4b_n)]<0\). Hence as soon as any weight is positive the largest zero of \(F_n\) lies in \((\xi,1)\). All-zero weights give the ordinary Jacobi interlacing directly.

For \(\xi<x<1\) every \(A_i(x)>0\) for \(i\le n\). Put \(q_i=A_{i-1}/A_i\); these increase strictly with \(i\), starting with \(q_1=1/x>x\). In fact \(1/q_i=x-b_i(q_{i-1}-x)\), and \(b_i\) increases, proving the assertion by induction. In particular \(xq_{n-1}\ge1\). Set \(\Delta_1=q_n-q_{n-1}>0\) and \(\Delta_2=q_n q_{n-1}-q_{n-1}q_{n-2}>0\). The backward recurrence gives
\[
 \Delta_2=\frac{a_n}{b_n}x\Delta_1+
 (1/b_n-1/b_{n-1})(xq_{n-1}-1)\le\frac{a_n}{b_n}x\Delta_1 .
\]
Then \(F_n/A_n-F_{n-1}/A_{n-1}=-(u+w)x\Delta_1-(vA_2+w y)\Delta_2<0\), since \(A_2>0\) and \(z a_n/(4b_n)<1\). Thus \(F_{n-1}/A_{n-1}>0\) at the largest root of \(F_n\). Parity gives the same positive ratio at the smallest.

**The interior determinant.** Write the coefficients of \(F_n,F_{n-1}\) in the basis \((A_n,A_{n-1})\) as the two rows of a matrix, and let its determinant be \(D_n\). At a zero of \(F_n\), \(F_{n-1}/A_{n-1}=D_n/U\). The denominator \(A_{n-1}\) does not vanish there by strict interlacing. Write \(d=(n-1)(n-2)\), and express
\[
 D_n=1+l_1 u+l_2 v+l_3 w
    +z\,(q_{11}u^2+q_{12}uv+q_{13}uw+q_{22}v^2+q_{23}vw+q_{33}w^2).
\]
Direct substitution of (1) into the two backward Jacobi steps yields
\[
\begin{aligned}
 l_1&=((2n+1)z-3)/(n-1),\\
 4d l_2&=(26n^2+16)z-(20n^2-5)z^2-24n,\\
 4d l_3&=(10n^2-12n-4)z-(4n^2-1)z^2-12n+24,\\
 q_{11}&=1,\\
 4d q_{12}&=16n^2-39n+26-(10n^2-15n+5)z,\\
 4d q_{13}&=8n^2-27n+22-(2n^2-3n+1)z,\\
 16(n-1)q_{22}&=64n+8-(55n+35)z,\\
 8(n-1)q_{23}&=32n-26-(23n+1)z,\\
 16(n-1)q_{33}&=16n-28-(7n-1)z .
\end{aligned}
\tag{2}
\]
For \(n\ge4\) all \(q\)'s are nonnegative on \(0\le z\le1\), as is seen at the right endpoint of their decreasing affine expressions. All three \(l_i\) are nonnegative on \(1/2\le z\le1\); their numerators are concave, so it suffices to substitute the two endpoints. On \(0\le z\le1/2,\ n\ge5\), the quadratic form in parentheses is at least \((u+2v+w)^2/2\). Indeed at \(z=1/2\), its six coefficients are at least \(1/2,2,1,2,2,1/2\), respectively, by (2). Furthermore \(l_1,l_3\ge-3n/d,\ l_2\ge-6n/d\) on this interval, by concavity and evaluation at 0 and \(1/2\). Consequently \(D_n>0\) for every nonnegative choice of \(u,v,w\) if \(z>9n^2/(2d^2)\) in this range.

At an interior root of \(F_n\), \(z\) is at least the least \(1-r_i^2\) over the roots \(r_i\) of \(A_{n-1}\), by the Jacobi interlacer. The [two endpoint derivative sums](full_column.md#a-full-hook-at-every-rank) give throughout this interval
\[
 z\ge \sqrt{\frac{192}{(n-1)(n+2)(n^2+n+18)}}.
\tag{3}
\]
For \(n\ge8\) this exceeds \(9n^2/(2d^2)\). After squaring the comparison is \(768(1-1/n)^3(1-2/n)^4>81(1+2/n)(1+1/n+18/n^2)\), which holds at 8 with the two sides respectively increasing and decreasing thereafter. For \(n=4,5,6,7\), (3) gives the respective lower bounds \(1/2,3/8,1/4,1/5\). At the applicable lower bound and at 1, all three \(l_i\) in (2) are nonnegative, hence so are they in between. This proves \(D_n>0\) at all interior roots, for every rank considered.

The signs of \(F_{n-1}\) at every root of \(F_n\) are therefore those of \(A_{n-1}\). They alternate, providing all \(n-1\) simple roots of \(F_{n-1}\) strictly between consecutive roots of \(F_n\). The variable change to the original \(Z\)-polynomials preserves this order. At a root \(t\) of \(Z_{n-1}\) the difference \(Q_n(t)=(Z_n(t)-(1+t)Z_{n-1}(t))/t\) has the sign of \(Z_n(t)/t\), which alternates. Its degree is at most \(n-2\) since both \(Z\)'s have constant and leading coefficient one. This proves the assertion about \(Q_n\) as well.
