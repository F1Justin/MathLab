Put \(\rho=r+u\), \(w_+=u+iy\), and \(L=ry^3\). Use the **increasing phase** \(\Theta=-G\). With the principal argument in \(G\), this is
\[
\boxed{\displaystyle
\Theta(y)=\frac32 r y(1-u)-2uy-\frac{\pi}{4}
               +\frac12\arctan\!\frac{1-u}{y}.}
\]
For \(0<y\le y_0\) with \(y_0\) sufficiently small and \(L\) sufficiently large, the two-saddle error is \(O(L^{-1/10})\) times the single-saddle amplitude. In particular, the sign at \(\Theta=j\pi\) is \((-1)^j\). We prove also that, starting at a large fixed Airy cutoff \(K\), there is **exactly one simple real zero** in each completed interval \(j\pi<\Theta<(j+1)\pi\), and it is the \((j+1)\)-st real zero counted from zero.

### Uniform saddle bound

Take the positive Cauchy prefactor
\[
C_{n,y}=\frac{n!e^{A(r)}}{2\pi\rho\,r^n},\qquad
E(v)=A(z)-xB(z)-A(r)-n\log(\rho/r)-inv/\rho,\quad z=\rho e^{iv/\rho}.
\]
Thus \(P_n(-x)=C_{n,y}\int_{-\pi\rho}^{\pi\rho}e^{E(v)}\,dv\). Write
\[
m=\Re S_c(w_+),\qquad a=S_c''(w_+)=\tfrac32(1-u-iy),\qquad
\mathcal A=C_{n,y}e^{rm+\Re T(y)}\sqrt{\frac{2\pi}{r|a|}} .
\]
Here \(\mathcal A\) is the single-saddle amplitude. We will use the following weighted form of the bound:
\[
\frac{C_{n,y}}{2\mathcal A}\int_{-\pi\rho}^{\pi\rho}e^{E(v)}p(v)\,dv
=\Re\!\left(p(y)e^{iG}\right)+O(L^{-1/10}). \tag{1}
\]
It suffices that \(p(-v)=\overline{p(v)}\) and, for a small fixed \(\delta>2y_0\),
\[
|p(v)|\le C(1+|v|/y),\qquad |p'(v)|\le C/y\qquad (|v|\le\delta),
\]
with \(|p|\le Cr^M\) elsewhere for fixed \(M\). The case \(p=1\) gives the sign estimate; the weights below give uniqueness and the row difference.

**Exterior arcs.** On \(\delta\le |v|\le V\) for fixed \(V\), \(\Re S_c(u+iv)\le m-\eta\) uniformly for small \(y_0\): at \(y=0\) the gap is \(\frac34 v^2-\frac32(1-\cos v)>0\). On \(|v|\ge V\) we can use an absolute bound even with the weight. In fact \(A(\rho)-A(r)-n\log(\rho/r)=O(r)\) and \(x|B(z)|=O(r)\). For \(\theta=v/\rho\) in a small fixed neighborhood of zero,
\[
A(\rho)-\Re A(z)\ \ge\ \tfrac16\rho^3(1-\cos 3\theta)\ \gtrsim\ rv^2 .
\]
On the rest of \([-\pi,\pi]\) the loss is \(\gtrsim r^2\), since \(1-\cos 2\theta\) and \(1-\cos 3\theta\) have no common zero there. Choosing \(V\) large gives an absolute integrated tail \(O(e^{-Dr})\) for prescribed \(D\), absorbing the polynomial weight. Since \(m\to-3/4\), these exterior bounds are negligible on the scale of (1).

**Oscillatory localization.** By symmetry consider \(0\le v\le\delta\). Put \(q=ce^u=\frac32 y/\sin y\) and \(\phi(v)=\Im S_c(u+iv)\). Then
\[
\phi'(v)=q(\cos y-\cos v),\qquad
\frac{d}{dv}\Re S_c(u+iv)=-\tfrac32 v+q\sin v .
\]
The first derivative \(\phi'\) is increasing. The real part increases up to \(y\) and then decreases, by monotonicity of \(\sin v/v\). Consequently \(e^{r(\Re S_c-m)}\) has supremum at most one and total variation at most two. The other unweighted amplitude factor \(e^{E-rS_c}\) is bounded in \(C^1\) by the supplied expansion.

Set
\[
h=(ry)^{-1/2}=y/\sqrt L,\qquad R=L^{1/10},\qquad H=Rh .
\]
For large \(L\), \(H<y/2\). On \([0,y-H]\) and \([y+H,2y]\), \(|\phi'|\gtrsim yH\), and the amplitude after extraction of \(e^{rm}\), including \(p\), has bounded supremum and variation. Integration by parts against \(d(e^{ir\phi})/(ir\phi')\) therefore bounds the two integrals by \(O(e^{rm}/(ryH))=O(e^{rm}h/R)\); here monotonicity bounds the variation of \(1/\phi'\) by \(1/\inf|\phi'|\) on each interval. On a dyadic interval \([d,2d]\subset[2y,\delta]\), allowing truncation at \(\delta\), one has \(\phi'\gtrsim d^2\), and the amplitude supremum plus variation is \(O(d/y)\) after the same extraction. The resulting bounds sum to
\[
O\!\left(\frac{e^{rm}}{r y^2}\right)=O(e^{rm}h/\sqrt L).
\]
Thus localization on the scale \(H\) has used oscillation, not real Gaussian decay.

For \(|v-y|\le H\), the saddle equation gives
\[
E(v)=r S_c(w_+)-\tfrac12 r a(v-y)^2+T(y)+O(rH^3+H+r^{-1}).
\]
Also \(p(v)=p(y)+O(H/y)\). Since \(\Re a>0\), replacing the integrand by its weighted quadratic approximation costs, in units of \(e^{rm}h\),
\[
O\!\left(R(rH^3+H+r^{-1}+H/y)\right)=O(L^{-1/10});
\]
in particular \(RrH^3=R^4/\sqrt L\). Extending the quadratic integral to the full line costs \(O(h/R)\) before its prefactor: integration by parts gives a tail bound \(O(1/(r|a|H))\) since \(|a|\asymp y\). The full Gaussian equals \(\sqrt{2\pi/(r|a|)}\,e^{-i\arg(a)/2}\). Adding the conjugate contribution proves (1). This bound needs no lower bound on \(ry^4\).

At \(w_+\), \(\Im S_c=\frac32 y(u-1)\) and \(T(y)=w_+^2\). Thus the positive-\(v\) Gaussian contributes phase \(G=-\Theta\) with \(\Theta\) as displayed above; in particular its Gaussian phase tends to \(+\pi/4\), not \(-\pi/4\).

### Integer matching and count

The small-\(y\) expansions are
\[
\frac{c}{c_*}=1+\frac{y^2}{2}+O(y^4),\qquad
\Theta=\frac12 r y^3-\frac\pi4+O(ry^5+y),\qquad
\Theta'=\frac32 r y^2+O(ry^4+1).
\]
Hence \(c\) and \(\Theta\) are strictly increasing in the range \(y\le y_0,\ L\ge L_0\) for small \(y_0\) and large fixed \(L_0\). Write \(y_{n,j}\) for the solution of \(\Theta=j\pi\) in this range when it exists. Take \(L_0\) large enough to make the errors in (1) for the sign and derivative tests below smaller than \(1/4\), and then take \(K\) sufficiently large **but fixed**. The point \(y_{n,K}\) exists for large \(r\), and
\[
r^{1/3}y_{n,K}\longrightarrow [2\pi(K+1/4)]^{1/3}.
\]
Indeed at \(y=\alpha r^{-1/3}\) the phase tends to \(\alpha^3/2-\pi/4\). Consequently at this integer point
\[
b\lambda\longrightarrow s_K
=\frac b2[2\pi(K+1/4)]^{2/3}
=\left[\frac{3\pi}{2}(K+1/4)\right]^{2/3},
\]
using \(b/2=(3/4)^{2/3}\). The **indexed** Airy-zero asymptotic, with \(d_1\) the first zero, is
\[
\tfrac23 d_j^{3/2}=\pi(j-1/4)+O(j^{-1}).
\]
Thus \(d_K<s_K<d_{K+1}\) for all sufficiently large \(K\). By the given fixed-index Airy result and exclusion of smaller stray roots, there are exactly \(K\) real roots from zero up to the point \(x(y_{n,K})\). This uses compact Airy convergence only *after* fixing \(K\).

By (1) with \(p=1\),
\[
\frac{P_n(-x)}{2\mathcal A}=\cos\Theta+O(L^{-1/10}).
\]
All subsequent integer points in the range therefore have sign \((-1)^j\), supplying one sign change per completed phase interval with no index offset.

For exactness of the real-root count, let \(F(c)=P_n(-c r e^{-r})\). Differentiate the coefficient before choosing its Cauchy radius. Then \((F'(c)+r e^u\cos y\,F(c))/(r e^u\sin y)\) is the same integral with multiplier
\[
p(v)=\frac{e^u\cos y-e^{-r}B(z)}{e^u\sin y}.
\]
This satisfies the bounds of (1): \(p(0)=O(1)\), and \(|(e^{-r}B(z))'|\) with derivative in \(v\) is bounded. At \(v=y\), \(z=r+u+iy+O(y^2/r)\), so \(p(y)=-i+O(y/r+r^3 e^{-r}/y)\). It follows that
\[
\frac{F'(c)+r e^u\cos y\,F(c)}{2\mathcal A\, r e^u\sin y}
=-\sin\Theta+O(L^{-1/10}). \tag{2}
\]
At any zero, \(|\cos\Theta|<1/4\); hence (2) makes the zero simple with derivative sign \(\operatorname{sgn}(-\sin\Theta)\). All zeros in one open integer interval would therefore cross in the same direction, so there can be at most one. The endpoint signs give at least one. In particular the number of real roots from zero through \(x(y_{n,j})\) is **\(j\)** for every \(j\ge K\) in range, uniformly without any further Airy approximation at growing index.

### Scaled \(n+1\) difference

At the same \(x\), the exact Cauchy multiplier for \(\rho P_{n+1}(-x)/(n+1)\) relative to the \(n\)-row integral is \(e^{-iv/\rho}\). Thus the cosine-centered difference has multiplier \(p(v)=(e^{-iv/\rho}-\cos(y/\rho))/\sin(y/\rho)\), satisfying (1) with \(p(y)=-i\) exactly. This gives
\[
\boxed{\displaystyle
\frac{\rho P_{n+1}(-x)/(n+1)-\cos(y/\rho)P_n(-x)}
     {2\mathcal A\,\sin(y/\rho)}
=\sin G+O(L^{-1/10})
=-\sin\Theta+O(L^{-1/10}).}
\]
