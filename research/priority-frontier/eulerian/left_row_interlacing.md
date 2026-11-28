# Every sufficiently large Eulerian square row interlaces its successor up to any fixed modulus

Write \(t_{n,k}\) for the logarithm of the modulus of the \(k\)-th smallest nonzero root of the ordinary Eulerian square row \(H_n\), counting by modulus. For every fixed \(b\in\mathbb R\), all sufficiently large \(n\) satisfy
\[
             t_{n+1,k}<t_{n,k}<t_{n+1,k+1}
             \qquad\text{for every }t_{n,k}\le b.                  \tag{1}
\]
In particular this includes *all* roots of modulus at most one. The [cross-row bulk theorem](bulk_row_interlacing.md) handles fixed compact intervals. The work is to control the entire remaining tail \(t\to-\infty\), where the phase movement between ranks tends to zero.

## A two-factor formula for comparing the rows

Keep \(G_n=zS_n\) and \(S_n=n!\prod_{j=1}^n(z+\lambda_j)\) from the [factorial-row theorem](factorial_symbol.md). Set \(a_j=z/(z+\lambda_j),\ b_j=\lambda_j/(z+\lambda_j)\). The recurrence used for the [cross-row ratio limit](bulk_row_interlacing.md) gives the following exact identity:
\[
 Q(z)=\frac{G_{n+1}(z)}{G_n(z)}
 =\sum_j a_j+(n+1)z+z\sum_{j\ne k}a_jb_k.                         \tag{2}
\]
Indeed \((1+\sum a_j)(1+\sum b_j)-\sum a_jb_j=n+1+\sum_{j\ne k}a_jb_k\). With \(y=1/z\), this becomes a sum with nonnegative coefficients
\[
 Q(1/y)=\sum_j\frac1{1+\lambda_j y}
       +\frac{n+1}{y}
       +\sum_{j\ne k}\frac{\lambda_k}{(1+\lambda_jy)(1+\lambda_ky)}.
\]

At \(x=-e^{-T}\) put \(N_T=1+e^{-T}\), \(a=T/N_T\), \(b_0=\pi/N_T\), and \(z_l=1/(a-i(2l+1)b_0)\). Thus \(z_0\) is the upper principal pole and \(z_{-1}=\overline{z_0}\). For all \(T\ge1\),
\[
 |Q(z_l)-\Re Q(z_0)|\le C(1+|2l+1|)\Im Q(z_0),\qquad \Im Q(z_0)>0. \tag{3}
\]
To prove this, normalize each nonzero summand at \(y=a\). It is \(C_j\prod_{h=1}^d(1-ib t_h)^{-1}\) at \(y=a-ib\), with \(C_j>0,\ d\le2,\ 0\le t_h\le1/a\). Allow a second factor with \(t_2=0\) in the one-factor case. At \(b=b_0\) its imaginary part equals
\[
 \frac{C_j b_0(t_1+t_2)}{(1+b_0^2t_1^2)(1+b_0^2t_2^2)}
 \ \ge\ \frac{C_j b_0(t_1+t_2)}{(1+\pi^2)^2}.
\]
The difference from its value at zero is at most \(C_j |b|(t_1+t_2)\) for any real \(b\), by telescoping the factors of modulus at most one. Sum these two bounds to obtain (3). The term \((n+1)/y\) gives strict positivity. Also the argument of every summand at \(z_0\) lies between zero and \(2\arg z_0=2\arctan(\pi/T)<\pi\). Its normalized lifted argument therefore satisfies
\[
                 0<\Phi_{n+1}(-T)-\Phi_n(-T)<2\arctan(\pi/T).
 \tag{4}
\]
Indeed the lifted branch is obtained by increasing \(b\) from zero to \(b_0\), starting with a positive real sum. This is the same slit-plane logarithm used to define the individual phases.

## The two principal poles, including the square-root transition

Take a sufficiently small absolute \(c>0\) and \(10\le T\le c\sqrt n\). Put \(Q_l=Q(z_l)\). By the [counted-disk pole bound, (2)](left_disk.md), uniformly
\[
 \sum_{l\ne0,-1}
 \frac{|(Q_l-\Re Q_0)G_n(z_l)|}{\Im Q_0\, |G_n(z_0)|}<1/4,qquad
 \sum_{l\ne0,-1}\frac{|G_n(z_l)|}{|G_n(z_0)|}<1/4.                \tag{5}
\]
For the first assertion use (3) on \(|l|\le T\); the sum is bounded by \(C'\sum_{j\ge1}(j+1)e^{-c' n j^2/T^2}\), as small as desired by choosing \(c\) small. For \(|l|>T\) use the uniform bound \(|Q_l-\Re Q_0|\le2Q(1/a)\ll n^2\), obtained by comparison at \(y=a\), since \(a\gg1\). Meanwhile \(\Im Q_0\ge(n+1)\Im z_0\gg n/T^2\). The sum of the squared pole ratios is \(O(T)\) and the exponential factor on this range is \(e^{-c''n}\). The second bound in (5) is the same argument without the multiplier.

Suppose \(t=-T=t_{n,k}\). Its phase is in the cell \((k\pi,(k+1)\pi)\) by the absolute [counted-disk theorem](left_disk.md), and \(|\cos\Phi_n(t)|<1/8\) by (5) and the exact pole sum. The sine therefore has sign \((-1)^k\) and modulus greater than \(0.99\). At this zero subtract \((\Re Q_0)H_n(x)\) from \(H_{n+1}(x)\). The two principal terms give \(-2(\Im Q_0)|G_n(z_0)|\sin\Phi_n(t)\), and (5) leaves their sign unchanged. Thus \(H_{n+1}(-e^t)\) has sign \((-1)^{k+1}\). By (4), \(\Phi_{n+1}(t)\) also belongs to \((k\pi,(k+1)\pi)\): the distance of the old phase from its cell center is at most \(\arcsin(1/8)\), and \(2\arctan(\pi/10)<0.61\).

The row-\(n+1\) cell has one simple root of rank \(k\), and the sign at its right endpoint is \((-1)^{k+1}\) by (5). This places \(t\) strictly after that root and before the next. In using the counted-disk theorem at the endpoints of the present range, take \(c\) smaller than half its available constant. The adjacent cell boundaries lie within the larger allowed range: the derivative bound
\(\Phi'_n(-T)\ge [\pi/(T^2+\pi^2)]\sum_j (|z_0|/(|z_0|+\lambda_j))^2\gg n/(1+T^2)\)
follows from its formula in the factorial-row theorem and estimate (1) of the counted-disk proof. This also justifies the root-to-cell indexing at both ends.

## Comparing the innermost root of each scale

Put \(g(u)=(u-1)/\log u\), with \(g(1)=1\). For each fixed \(C\), uniformly for \(1\le k\le C\sqrt n\),
\[
 t_{n+1,k}-t_{n,k}
          =-\log(g(k+1)/g(k))\,(1+o_C(1)).                        \tag{6}
\]
For bounded \(k\) this follows by subtracting the two [fixed-rank location estimates](paired_edge.md). Consider any sequence \(k\to\infty\) in the range, and pass to a subsequence with \(k/\sqrt n\to\tau\in[0,C]\). Write \(a_{n,j}=[x^j]H_n\), \(b_{n,j}=n!g(j)^{n+1}\) and \(r_{n,k}=b_{n,k}/b_{n,k+1}\). Uniformly for \(1\le j\le(C+2)\sqrt n\),
\[
 a_{n,j}=b_{n,j}(1+O_C(e^{-c_C\sqrt n})).
\]
Indeed the compared binning term in the [innermost-root estimate](paired_edge.md) costs at most \(j(n+1)[g(j-1)/g(j)]^{n+1}\) for \(j\ge2\), exponentially small because \((\log g)'(v)\gg1/v\) for \(v\ge1\). The uniform nonprincipal-pole correction at positive integer arguments is even smaller. On all indices the same proof gives \(a_{n,j}\le2b_{n,j}\).

At radius \(r=r_{n,k}\) normalize
\[
 F(z)=\frac{H_n(rz)}{b_{n,k}r^k z^k},
 \qquad F^+(z)=\frac{H_{n+1}(rz)}{(n+1)g(k)b_{n,k}r^k z^k}.
\]
On compact annuli about \(z=-1\) we have, with \(D=z\partial_z\),
\[
             F^+(z)=F(z)+\frac{g'(k)}{g(k)}DF(z)+O_C(k^{-2}).       \tag{7}
\]
To see this, the normalized reference coefficient at offset \(h=j-k\) in row \(n+1\) equals its row-\(n\) counterpart multiplied by \(g(k+h)/g(k)\). For \(|h|\le k/2\) this multiplier is \(1+h g'(k)/g(k)+O(h^2/k^2)\), since \(|g''(u)|/g(k)\ll k^{-2}\) there by the integral \(g(u)=\int_0^1 u^v\,dv\). At any admissible offset it is positive and at most \(1+|h|\), from the same integral. The Gaussian domination in the [innermost-root estimate](paired_edge.md) bounds every fixed absolute moment of these offset weights uniformly, with bounds valid on any chosen compact annulus. On indices beyond \((C+1)\sqrt n\), the relative weight is exponentially small in \(n\) at the start of that tail and then decreases at geometric ratio \(O(e^{-c_C\sqrt n})\), by the same reference ratios. These bounds justify replacing the actual coefficients by their references in (7), including the possible extra top term in row \(n+1\); indices outside each actual support contribute zero. They also absorb all offsets \(|h|>k/2\) at order \(o(k^{-2})\) by the uniform higher moments. Cauchy gives the same estimate after a fixed number of derivatives on a smaller annulus.

Both \(F,F^+\) converge locally to the same function with a simple zero at \(-1\), either \(1+z\) or the bilateral theta function of the innermost-root estimate. Their respective roots here, \(\xi,\xi^+\), are the \(k\)-th ones for their rows: the row-\(n+1\) reference radius divided by \(r\) is \(g(k)/g(k+1)\to1\). At \(\xi\), (7) reads \(F^+(\xi)=(g'(k)/g(k))\xi F'(\xi)+O_C(k^{-2})\), with the derivative bounded away from zero along the subsequence. The real mean-value theorem and convergence of the derivatives thus give \(\xi^+/\xi=1-g'(k)/g(k)+o(1/k)\). Taking logarithms proves (6) since \(g'(k)/g(k)\sim\log(g(k+1)/g(k))\sim 1/k\).

There is also room before the next root: the original gap is bounded below along any sequence \(k\le C\sqrt n\) with \(k\to\infty\), because the reference log-radius difference between \(k+1\) and \(k\) is \((n+1)(-(\log g)''(v))\) for some \(v\in(k,k+2)\), with \(- (\log g)''(v)\sim1/v^2\), and the location error is \(o(1)\). For bounded \(k\) the gap tends to infinity by strict log-concavity of \(g\). Together with (6) this gives both inequalities in (1) on these ranks.

Finally \(\Phi_n(-c\sqrt n)\le(n+1)\arctan(\pi/(c\sqrt n))=O_c(\sqrt n)\). The first counted disk above this point has \(O_c(\sqrt n)\) zeros including zero. Choose a fixed \(C\) above this bound to cover all roots left of the middle range by (6). The middle comparison and the compact-interval theorem cover the remaining roots with \(t\le b\).
