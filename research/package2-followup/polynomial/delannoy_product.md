# Simple negative zeros for products of weighted Delannoy triangles

Let \(D_c(n,j)\) be the sum of path weights from \((0,0)\) to \((n-j,j)\), using east and north steps of weight one and northeast steps of weight \(c\). Write \(T_n^{(c)}(x)=\sum_jD_c(n,j)x^j\). For an ordinary matrix product let
\[
 Q_n(x)=\sum_{j=0}^n D_c(n,j)T_j^{(d)}(x).
\]

**Theorem.** For every \(c>0\), \(d\ge 1/3\), and \(n\ge1\), the \(n\) zeros of \(Q_n\) are simple and strictly negative. For \(c=d=1\), they all belong to
\[
 (-4-3\sqrt 2,\, -3+2\sqrt 2).
\]
The smallest and largest zeros converge to the two displayed endpoints as the degree grows. Row zero is 1. The specialization \(c=d=1\) gives the Delannoy clause of Mao and Wang's conjecture on ordinary matrix squares. Their Eulerian clause concerns a separate matrix. [Mao and Wang, Section 4](https://arxiv.org/html/2607.01572v1)

In October 2026, trureturing publicly recorded a complete ordinary proof candidate for the unweighted square. Its route combines a circle argument, real Chebyshev samples and a residual linear factor. The subsequent Lean contribution gives the unweighted divided difference, the exclusion of an ordinary-row zero at its positive fixed point, and the upper-circle count. Its public blueprint proposes adding alternating real Chebyshev samples. Below the envelope inequality verifies those signs, and a sign comparison across the two intervals yields simplicity and the stated location. We give the argument for weighted matrices, including fixed points that coincide with a zero. This is a local research proof. Its priority has had a targeted source check and this proof has no Lean build or external referee report. [Original issue](https://github.com/the-omega-institute/trureturing/issues/15051) · [Public proof blueprint](https://github.com/the-omega-institute/trureturing/commit/2374ab7dfe261a95d3a90a574ae6e7d1e73bfc37) · [Project's remaining obligations](https://the-omega-institute.github.io/trureturing-mdbook/Problems/mao-wang-2026-delannoy-square-negative-roots.html) Chen and Mao prove multivariate stability for a single Delannoy path row. Their theorem supplies a related stability result for the factor triangles. [Chen and Mao, Theorem 1.2](https://arxiv.org/html/2611.27395v1)

### A divided difference for the actual product

The last step gives \(T_0=1,\ T_1=1+x\) and
\[
 T_{m+2}^{(c)}=(1+x)T_{m+1}^{(c)}+cxT_m^{(c)}.
\]
Reflection of paths gives \(T_n^{(c)}(x)=x^nT_n^{(c)}(1/x)\). The row is monic. For \(s>0\) the recurrence also gives
\[
 T_n^{(c)}(-s)=(cs)^{n/2}U_n\!\left(\frac{1-s}{2\sqrt{cs}}\right),
\]
where \(U_n(\cos\theta)=\sin((n+1)\theta)/\sin\theta\). The function \((1-s)/(2\sqrt{cs})\) decreases strictly from \(+\infty\) to \(-\infty\), so \(T_n^{(c)}(-s)\) has \(n\) distinct positive zeros \(r_1<\cdots<r_n\). The angle \(\theta(s)=\arccos((1-s)/(2\sqrt{cs}))\) increases from 0 to \(\pi\) between the points \(L_c=(\sqrt{1+c}-\sqrt c)^2\) and \(1/L_c\). In particular \(\theta(r_j)=j\pi/(n+1)\).

Put \(P_n(y)=(-1)^nQ_n(-y)\) and \(H(s)=T_n^{(c)}(-s)/s^{n+1}\). Take nonzero distinct \(u,v\) with \(u+v+uv=1/d\), and let \(y=1/(duv)\). Then
\[
 dy(v-u)P_n(y)=H(u)-H(v). \tag{1}
\]
Indeed, \(-1/u,-1/v\) have sum \(1-y\) and product \(dy\), so the second-order recurrence represents \(T_j^{(d)}(-y)\) as the divided difference of the \((j+1)\)-st powers at those two numbers. Summing with weights \(D_c(n,j)\) gives the divided difference of \(z T_n^{(c)}(z)\). Reciprocity yields (1).

### Signs from the upper circle

Set \(R=\sqrt{1+1/d}\), \(a=R-1\), and \(b=R+1\). Write \(k=\#\{j:r_j<a\}\). On \(u=-1+Re^{i\phi}\), \(0<\phi<\pi\), take \(v=\bar u\). Then \(y=1/(d|u|^2)\) decreases strictly from \(1/(da^2)\) to \(1/(db^2)\). Formula (1) gives
\[
 \operatorname{sgn}P_n(y)=-\operatorname{sgn}\Im H(u).
\]
Use \(H(u)=\prod_j(r_j-u)/u^{n+1}\). Choose each numerator factor's argument in \((-\pi,0)\) and the argument of \(u\) in \((0,\pi)\). Their difference, with the denominator argument counted \(n+1\) times, is a continuous argument of \(H\). As \(\phi\downarrow0\) its limit is \(-k\pi\) when \(a\) differs from all the roots. If \(a=r_j\) its limit is \(-k\pi-\pi/2\), since \(a-u=R(1-e^{i\phi})\) and the ordinary roots are simple. As \(\phi\uparrow\pi\) its limit is \(-(n+1)\pi\).

The intermediate value theorem supplies successive parameters at which the argument equals \(-(k+j+3/4)\pi\), \(0\le j\le n-k\). They may be chosen in increasing order by restarting the intermediate value argument from each previous parameter. This yields \(n-k+1\) samples in decreasing order of \(y\), whose signs for \(P_n(y)\) are \((-1)^{k+j}\). In particular the largest \(y\) in this list has sign \((-1)^k\).

### Signs from the real interval

If \(k=0\), the circle already gives \(n+1\) alternating samples. Suppose \(k>0\). For \(j=0,\ldots,k-1\), choose \(u_j\) by
\[
 \theta(u_j)=(j+1/2)\pi/(n+1).
\]
These points increase and satisfy \(L_c<u_j<r_k<a\le1\), where the last inequality uses \(d\ge1/3\).

For any of these \(u=u_j\), put \(v=(1/d-u)/(1+u)\). We have \(v>u>0\) because \((1+u)^2<(1+a)^2=1+1/d\). The product \(u v\) is strictly increasing for \(0<u<a\), its derivative being \((1/d-2u-u^2)/(1+u)^2\), and its endpoint value is \(a^2\le1\). Thus \(u<v<1/u\). Since
\[
 \cos\theta(1/u)=-\cos\theta(u),
\]
the angle \(\theta(v)\) lies strictly between \(\theta(u)\) and \(\pi-\theta(u)\). In particular it exists and \(\sin\theta(v)\ge\sin\theta(u)>0\). On this interval
\[
 H(s)=c^{n/2}s^{-(n+2)/2}
       \frac{\sin((n+1)\theta(s))}{\sin\theta(s)} .
\]
The numerator sine is \((-1)^j\) at \(u_j\), and its modulus at \(v\) is at most one. The factor \(v^{(n+2)/2}>u_j^{(n+2)/2}\) and the sine inequality give \(|H(v)|<|H(u_j)|\). As \(dy(v-u)>0\), (1) shows that the sign of \(P_n(1/(du_jv))\) is \((-1)^j\).

These \(k\) real samples have \(y>1/(da^2)\) and decrease in \(y\) with \(j\). Their last sign is \((-1)^{k-1}\), opposite to the first circle sign. The concatenated list has \(n+1\) alternating samples in strictly decreasing positive \(y\). The \(n\) disjoint open gaps therefore contain \(n\) distinct zeros of the monic degree-\(n\) polynomial \(P_n\). Each zero is simple.

### Location in the original square

For \(c=d=1\) every circle sample lies in \(3-2\sqrt2<y<3+2\sqrt2\). If any real samples occur, they satisfy \(u>L_1=3-2\sqrt2\). The product \(u(1-u)/(1+u)\) increases up to \(a\), so their \(y\) values are strictly below
\[
 \frac{1+L_1}{L_1(1-L_1)}=4+3\sqrt2.
\]
All the intervening roots satisfy the same outer bounds. Reflecting \(y\) to \(x=-y\) proves the assertion.

Both bounds are attained as limits. For the large positive \(y\) end, the first two real samples exist for every sufficiently large \(n\), since \(L_1<a\). Their angles \(\pi/(2(n+1))\) and \(3\pi/(2(n+1))\) tend to zero, so their \(y\)'s both approach \(4+3\sqrt2\) and enclose a root.

For the small \(y\) end, fix \(\phi_0<\pi\) arbitrarily close to \(\pi\), with \(\Re u(\phi_0)<0\). Put \(\delta=\pi-\arg u(\phi_0)>0\) and \(\epsilon(r)=-\arg(r-u(\phi_0))\). Since \(\epsilon(r)=\arctan(\Im u/(r-\Re u))\), one has \(0<\epsilon(r_j)\le\epsilon(L_1)<\delta\). At \(\phi_0\) the lifted phase exceeds its final limit \(-(n+1)\pi\) by
\[
 (n+1)\delta-\sum_j\epsilon(r_j)
 \ \ge\ \delta+n\big(\delta-\epsilon(L_1)\big).
\]
For sufficiently large \(n\) this exceeds \(2\pi\), giving two opposite-sign phase samples between \(\phi_0\) and \(\pi\). A root then has \(3-2\sqrt2<y<1/|u(\phi_0)|^2\). Letting \(\phi_0\uparrow\pi\) proves convergence of the smallest positive \(y\)-root to \(3-2\sqrt2\).
