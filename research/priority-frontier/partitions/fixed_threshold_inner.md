# The innermost zeros at every fixed block threshold

For a fixed integer \(j\ge4\), let \(P_{n,j}(t)\) count partitions of an \(n\)-element set by the number of blocks of size at least \(j\). For every fixed \(k\), the \(k\) smallest-modulus zeros of \(P_{n,j}\) are eventually simple and negative. Write their positive magnitudes as \(x_{n,1}<\cdots<x_{n,k}\). For each fixed integer \(l\ge1\),
\[
 x_{n+l,k}<x_{n,k}<x_{n+l,k+1}
\]
for all sufficiently large \(n\). This extends the [threshold-four Airy and adjacent-row argument](../../../snapshot/research/partitions/zero_distribution.tex) to all fixed \(j\ge4\) by centering at the exact double saddle. The following asymptotic formulas identify the root locations and the displacement between rows in [Alexandersson's problem](https://mathoverflow.net/questions/462360/set-partitions-with-big-blocks-real-rooted-polynomials). The [outer edge](fixed_threshold_edge.md) has a different scale.

Put \(p=j-1\), \(A(z)=\sum_{i=1}^p z^i/i!\), \(B(z)=e^z-1-A(z)\), and \(N=n+1\). Define \(h(z)=zA'(z)\), \(H(z)=zB'(z)\), \(h(r)=N\) with \(r>0\), and \(L=h'(r)/r\). Thus \(L\sim pN/r^2\asymp r^{p-2}\). Put
\[
 X(z)=\frac{h(z)-N}{H(z)},\qquad
 S(z,x)=A(z)-xB(z)-N\log z .
\]
Let \(a\) be the critical point of \(X\) near \(r+1\), \(x_*=X(a)\), and set
\[
 \ell=\left(\frac{2}{-S_{zzz}(a,x_*)}\right)^{1/3},
 \qquad \Delta=\frac{1}{\ell B'(a)} .
\]
If \(d_k>0\) is the \(k\)th zero of \(\operatorname{Ai}(-d)\) in increasing order, then
\[
 x_{n,k}=x_*+(d_k+o(1))\Delta,\qquad
 x_{n+l,k}-x_{n,k}=-\frac{l}{a B'(a)}(1+o(1)).
\tag{1}
\]
The scale \(\Delta\) uses the exact critical value \(x_*\). An error of relative order \(1/r\) in this center can exceed the scale of the roots for high fixed thresholds.

## The double saddle

On every fixed complex \(w\)-disk, differentiation on smaller disks is allowed in the uniform expansions
\[
 \frac{X(r+w)}{L e^{-r}}=w e^{-w}(1+O(1/r)),\qquad
 \frac{S(r+w,0)-S(r,0)}L=\frac{w^2}{2}+O(1/r).
\tag{2}
\]
For the first expansion factor \(w\) from \(h(r+w)-h(r)\) and use \(H(r+w)=(r+w)e^{r+w}(1+O_p(r^{p-1}e^{-r}))\). For the second, the exact linear term vanishes, the second derivative is \(L\), and derivatives of order at least three on such disks are \(O_p(L/r)\). The simple zero of \((we^{-w})'\) at 1 yields a unique critical point \(a=r+1+O(1/r)\) near \(r+1\), real by conjugation. In particular \(x_*\sim L e^{-r-1}\) and \(X''(a)/x_*\to-1\). The identity \(S_z=B'(X-x)\) gives \(S_z=S_{zz}=0\) at \((a,x_*)\). Direct differentiation gives
\[
 S_{zzz}(a,x_*)\sim-L,\qquad S_{zzzz}(a,x_*)\sim-L,\qquad
 \ell\sim(2/L)^{1/3},\quad \Delta/x_*\asymp L^{-2/3}.
\tag{3}
\]

The coefficient formula is \(P_{n,j}(-x)/n!=(2\pi i)^{-1}\oint e^{S(z,x)}dz\). The integrand is single-valued since \(N\) is an integer. We use a circle of radius \(R=r+O(1)\) with its right arc replaced by the vertical segment \(R+i[-Y,Y]\) and horizontal connectors to the circle, for a sufficiently large fixed \(Y\). Here and below, saddle offsets stay bounded and \(|xe^r/L|\) stays bounded. On the circle between \(\arcsin(Y/R)\) and \(\pi/p\), or its reflection, the loss in \(\Re A\) relative to \(A(R)\) is at least \(c_p R^p\theta^2\ge c'_p L Y^2\) from the top power. On \(\pi/p\le|\theta|\le\pi\), the two powers \(p,p-1\) force a loss of at least \(c_p R^{p-1}\), since \(1-\cos(p\theta)\) and \(1-\cos((p-1)\theta)\) have no common zero there. The variation due to \(xB\) is \(O(L)\), and the logarithm has constant real part. On the connectors \(\Re z=R+O_Y(1/r)\), \(\Im z=\pm Y\). Equation (2) gives a loss of \(L(Y^2/2-O(1)-o_Y(1))\) relative to the saddle, where the \(O(1)\) is independent of \(Y\) and \(o_Y(1)\to0\) for each fixed \(Y\). This follows also from the limiting phase \(w^2/2-(xe^r/L)e^w\), whose exponential term is bounded on every such connector independently of \(Y\). Comparing the phase at \(R\) to any of the bounded saddle offsets costs \(O(L)\). Hence these remote parts, of total length \(O(r)\), are exponentially negligible relative to the saddle integrals below.

## Airy limit

Take \(x=x_*+\xi\Delta\), with \(\xi\) in a fixed compact subset of \(\mathbb C\), and \(R=a-\ell\). For bounded \(w\),
\[
 S(a+\ell w,x)-S(a,x)=-w^3/3-\xi w+o(1).
\]
Here \(S_{zz}(a,x)=O(1/\ell)\); its quadratic contribution is \(O(\ell)\). On the vertical line \(z=R+it\), Taylor expansion at \(R\) gives, for a sufficiently small fixed \(\delta>0\) and \(|t|\le\delta\),
\[
 \Re(S(R+it,x)-S(R,x))\le C|t|/\ell-c(t/\ell)^2-cLt^4 .
\tag{4}
\]
Indeed \(|S_z(R,x)|=O(1/\ell)\), \(\Re S_{zz}(R,x)\sim L\ell\), \(|\Im S_{zzz}(R,x)|=O(1/\ell)\), \(\Re S_{zzzz}(R,x)\sim-L\), and the fifth derivative is \(O(L)\) throughout this disk. The cubic error is bounded by a constant times \(|t|/\ell\). Also \(S(R,x)-S(a,x)=O(1)\). On the bounded vertical arc outside \(|t|<\delta\), the limiting real phase difference in units of \(L\) is \(1-\cos t-t^2/2<0\). This and the remote bounds justify dominated convergence on the scaled line \(\Re w=-1\). The upward orientation, followed by \(v=-w\), gives the [Airy integral](https://dlmf.nist.gov/9.5). Locally uniformly in \(\xi\),
\[
 Q_n(\xi):=\frac{P_{n,j}(-x)}{n!\ell e^{S(a,x)}}\longrightarrow
 \operatorname{Ai}(-\xi).
\tag{5}
\]

## Counting zeros by modulus

Fix \(K>0\) different from every \(d_i\). We show that the entire disk \(|x|\le x_*+K\Delta\) contains exactly one zero near each \(x_*+d_i\Delta\) for \(d_i<K\). Only reality of the zeros in bounded Airy coordinates follows directly from (5). To cover the disk, consider a sequence of points in it with \(|x-x_*|/\Delta\to\infty\). After extracting a subsequence, \(xe^r/L\to c_0\) with \(|c_0|\le1/e\).

If \(c_0\ne 1/e\), the equation \(we^{-w}=c_0\) has a solution \(|w_0|<1\). For \(|c_0|<1/e\), this follows by Rouché on \(|w|=1\). At equality take a radial limit of the inner solutions. Equality in \(|we^{-w}|\ge1/e\) on the circle occurs only at \(w=1\), which maps to \(1/e\). The root \(w_0\) is simple, so (2) gives a saddle \(z_s=r+w_0+o(1)\) with \(X(z_s)=x\). Integrate on \(\Re z=\Re z_s\) and center \(t\) at \(z_s\). The limiting phase difference divided by \(L\) is
\[
 -t^2/2-w_0(e^{it}-1-it).
\]
Its real part is at most \(-(1-|w_0|)t^2/2\) by the integral remainder bound \(|e^{it}-1-it|\le t^2/2\). Near zero \(S_{zz}(z_s,x)/L\to1-w_0\), of positive real part, and \(S_{zzz}=O(L)\). For small fixed \(\delta\), Taylor's theorem bounds the real phase difference by \(-cLt^2\) on \(|t|\le\delta\), and uniform convergence supplies a strict loss on the bounded remainder. Scaling \(t\) by \(L^{-1/2}\) gives a nonzero Gaussian integral. Its coefficient relative to \(e^{S(z_s,x)}\) is asymptotic to \(1/\sqrt{2\pi S_{zz}(z_s,x)}\), with the square root of positive real part.

If \(c_0=1/e\), put \(u=1-x/x_*\). Then \(u\to0\), \(|u|\gg L^{-2/3}\) in the sense that \(|u|L^{2/3}\to\infty\), and \(\Re u\ge-O_K(L^{-2/3})\) by the modulus bound. The principal square root satisfies \(\Re\sqrt u\ge c|\sqrt u|\). Factor exactly
\[
 1-X(a-t)/x_* =t^2g_n(t),\qquad g_n(0)\to1/2 .
\]
By (2) the analytic factors and their first derivatives are uniformly bounded on a small fixed disk, and \(g_n\) stays bounded away from zero there. Inverting \(t\sqrt{g_n(t)}\) at zero gives a saddle \(z_s=a-\zeta\) with \(|\zeta|\asymp\sqrt{|u|}\), \(\Re\zeta\ge c|\zeta|\), and \(L|\zeta|^3\to\infty\). Differentiating at the saddle gives \(S_{zz}(z_s,x)=B'(z_s)X'(z_s)\sim L\zeta\). Since the critical data are real and \(|x-x_*|=O(x_*|\zeta|^2)\), we have \(|\Im S_{zzz}(z_s,x)|=O(L|\zeta|)\), \(\Re S_{zzzz}(z_s,x)\sim-L\), and \(S^{(5)}=O(L)\). Therefore on the vertical through the saddle,
\[
 \Re(S(z_s+it,x)-S(z_s,x))\le-cL(|\zeta|t^2+t^4)
\]
for \(|t|\le\delta\), by absorbing the cubic into the quadratic and the fifth-order remainder into the quartic. On the remaining bounded vertical arc the limiting real phase difference is again \(1-\cos t-t^2/2<0\). On the Gaussian scale \((L|\zeta|)^{-1/2}\) the cubic error is \(O((L|\zeta|^3)^{-1/2})=o(1)\) on compact scaled intervals. The normalized quadratic coefficients have real part bounded below and are bounded in modulus. Gaussian integration, along any convergent subsequence of those coefficients, gives a nonzero limit.

These two exclusions force the Airy coordinates of every zero in the disk to stay bounded. Any limit satisfies \(\Re\xi\le K\) and by (5) is one of the positive \(d_i\), since [all Airy zeros are simple negative reals](https://dlmf.nist.gov/9.9). Rouché on disjoint small circles around the indicated \(d_i\) yields exactly one simple zero for each. Conjugation makes that zero real. This proves the first formula of (1), including its assertion about complex modulus ranks.

## Displacement between rows

Keep the parameters and contour of row \(n\) also for row \(n+l\), and put \(\widetilde Q_{n+l}=a^l P_{n+l,j}(-x)/((n+l)!\ell e^{S(a,x)})\). Inserting the factor \((a/z)^l\) in the integral gives
\[
 \frac{\widetilde Q_{n+l}-Q_n}{l\ell/a}\longrightarrow
 \frac{d}{d\xi}\operatorname{Ai}(-\xi)
\tag{6}
\]
locally uniformly. Indeed the difference multiplier converges to \(-w\) on compact \(w\)-sets. On \(|t|\le\delta\) it is bounded by \(C_l(1+|t|/\ell)\), which is integrable against (4) in the scaled coordinates. On the rest of the contour it is \(O_l(a/\ell)\) and the loss is exponential.

For rank matching, regard \(N\) as real in the critical equations. The implicit function theorem at the simple critical point and \(X'(a)=0\) give \(dx_*/dN=-1/H(a)\). On an interval of fixed length, \(r'(N)=1/h'(r)\), so \(a(N+l)-a(N)=o(1)\) by (2), \(H(a(N+l))/H(a(N))\to1\), and \(\Delta(N+l)/\Delta(N)\to1\). It follows that the change in \(x_*\) is \(O(1/H(a))=o(\Delta)\). The rank-\(k\) zeros of both rows consequently tend to \(d_k\) in row \(n\)'s coordinates. At the zero of \(Q_n\), (6) and convergence of \(\widetilde Q_{n+l}'\) to the nonzero limiting derivative at \(d_k\) give a displacement of \(-(l\ell/a)(1+o(1))\) in Airy coordinates by the real mean value theorem. Multiplication by \(\Delta\) proves the second formula of (1). Consecutive Airy levels are separated by \((d_{k+1}-d_k+o(1))\Delta\), which exceeds the fixed-lag displacement in magnitude for large \(n\).
