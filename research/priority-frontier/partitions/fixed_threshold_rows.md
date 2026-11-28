# Eventual strict interlacing at every fixed block threshold at least four

Let \(P_{n,j}(t)\) enumerate set partitions of \([n]\) by the number of blocks of size at least \(j\). For every fixed integer \(j\ge4\) there exists an \(n_0(j)\) such that for every \(n\ge n_0(j)\) the entire row \(P_{n,j}\) has \(\lfloor n/j\rfloor\) simple negative zeros and interlaces each \(P_{n+l,j}\), \(1\le l\le j\), strictly. In positive root magnitudes the order, starting at zero, is \(x_{n+l,1}<x_{n,1}<x_{n+l,2}<x_{n,2}<\cdots\), ending when the available ranks are exhausted.

The hypothesis needed below is angular condition (1) of the [Poisson saddle lemma](poisson_saddle.md) at every positive radius. It holds for \(j=4\) by the [threshold-four certificate and phase-counting theorem](https://hexagonmath.org/2611.01129v2), for \(5\le j\le8\) by the [small-threshold certificate](small_threshold_saddles.md), for \(9\le j\le127\) by the [four-moment and angular certificates](medium_threshold_saddles.md), and for \(j\ge128\) by the [explicit mean bound](poisson_explicit.md). The argument below gives the passage from the angular condition to an entire row, including an absolute indexing of the exponential-section zeros. This answers the fixed-threshold eventual part of [Alexandersson's question](https://mathoverflow.net/questions/462360/set-partitions-with-big-blocks-real-rooted-polynomials). Constants and the row threshold may depend on \(j\).

Write \(p=j-1\), \(A(z)=\sum_{a=1}^p z^a/a!\), \(B(z)=e^z-1-A(z)\), \(h=zA'\), \(H=zB'\), \(K=zH'\), \(m=\lfloor n/j\rfloor\), \(s=n-jm\). For \(t=-x<0\), put
\[
 E(z)=A(z)-xB(z)-n\log z .
\]
The coefficient integral \(I=(2\pi i)^{-1}\oint e^{E(z)}dz/z\) equals \(P_{n,j}(-x)/n!\). Let \(I_l\) be the same integral with a multiplier \((R/z)^l\), where \(R>0\) is the modulus of the upper saddle. It equals \(R^lP_{n+l,j}(-x)/(n+l)!\). We use positive normalizers throughout.

### Absolute indexing at the outer cut

By the [outer-edge theorem](fixed_threshold_edge.md), the reversed polynomial in the variable \(u=c m^{j+1}/t\), \(c=j!/(j+1)^j\), converges after constant normalization locally uniformly to \(s!\mathcal E_s(u)\), where \(\mathcal E_s(u)=\sum_{k\ge0}u^k/(jk+s)!\). Its zeros are simple negative. For every sufficiently large fixed integer \(T\), put
\[
 Y_T=\frac{(T+s/j)\pi}{\sin(\pi/j)} .
\]
The disk \(|u|<Y_T^j\) contains **exactly \(T\)** zeros of \(\mathcal E_s\). Indeed, parameterize its upper semicircle by \(u=z^j,\ z=Y_Te^{iv},\ 0\le v\le\pi/j\). The roots-of-unity filter gives
\[
 \mathcal E_s(u)=\frac{e^z}{j z^s}
 \left[1+\omega^{-s}e^{(\omega-1)z}+O_j(e^{-c_jY_T})\right],
 \qquad \omega=e^{-2\pi i/j}.
\]
The other roots of unity lose a fixed positive fraction of \(Y_T\) in real exponent uniformly on this compact angular interval. Put \(d=\pi/j-v\). The displayed second term has modulus \(e^{-2Y_T\sin(\pi/j)\sin d}\) and argument \(2\pi s/j-2Y_T\sin(\pi/j)\cos d\). If \(d\ge C/Y_T\) its modulus is less than \(1/2\) for a suitable fixed \(C\). If \(d<C/Y_T\) its argument is \(-2T\pi+O_j(C^2/Y_T)\). The bracket therefore remains in the open right half-plane and is positive real at both ends, since \(\mathcal E_s\) and the extracted factor are real there. The unwrapped argument change is exactly \(T\pi\) on the upper semicircle. Conjugation and the argument principle give the count, with no boundary zeros.

### Compact radii and the small-radius join

At a pure saddle \(z=\rho e^{i\theta}\) as in (1), put \(\tau=-1/H(z)\), \(x=n\tau\), and
\[
 G=n(\Im B/H-\theta)+\Im A(z)-\tfrac12\arg(-\tau K(z)).
\tag{1}
\]
The angular exponent \(-n\tau B-in\theta\) is stationary there. Its angular curvature is \(n\tau K\) and \(\Re(\tau K)<0\). On compact radius intervals the two conjugate saddles are separated from the rest by a strict height gap outside their neighborhoods. Taylor expansion on scale \(n^{-1/2}\), with bounded third derivatives of the normalized exponent and Gaussian domination, gives for some \(C_n(x)>0\)
\[
 I/C_n=\cos G+o(1),\qquad
 \frac{I_l-\cos(l\theta)I}{C_n\sin(l\theta)}=\sin G+o(1).
\tag{2}
\]
The second assertion inserts a multiplier with value \(-i\) at the upper saddle. The sine denominator is positive by \(0<\theta<\pi/j\).

Near zero the scaled series \(j!B/\rho^j=e^{ijv}(1+\rho e^{iv}/(j+1)+O_j(\rho^2))\) holds in every fixed angular derivative. Of the \(j\) maxima of the negative leading cosine, the first correction at the point with angle \(\alpha=(2b+1)\pi/j\) is proportional to \(\rho\cos\alpha\). Only the nearest pair survives, with a height advantage \(\ge c_j n\rho\) over every other local maximum. All curvatures divided by \(n\) remain bounded away from zero in modulus and have strictly negative real part there. Other maxima of the **real** exponent need not be complex stationary points: an upper bound from their real Gaussian envelopes suffices. Off these neighborhoods the loss is of order \(n\). This gives (2) with error \(o_n(1)+O_j(e^{-c_j n\rho})\), uniformly from any \(\rho\asymp T/n\) to a small fixed radius, for \(l<j\).

For \(l=j\), the identity from integrating the logarithmic angular derivative is
\[
 (n+j)I_j=I\!\left[(\rho/z)^jh(z)-x\rho^jH(z)/z^j\right].
\]
Here \(I[f]\) denotes insertion of \(f\). Call the bracket divided by \(n+j\) the weight \(V(z)\). At a zero of \(I\), subtract \(\Re V(z_*)\) at the upper saddle \(z_*\) and divide by \(\rho\). The resulting weight and its first angular derivative are bounded uniformly as \(\rho\downarrow0\): \(H/z^j=1/(j-1)!+z/j!+O(\rho^2)\), \(h=O(\rho)\), and \(x\rho^j/(n+j)=(j-1)!(1+O(\rho+1/n))\). The weight at the upper saddle is \(-i(\sin(\pi/j)/j+O(\rho+1/n))\). Thus at a zero of \(I\) the sign of \(I_j\) is the sign of \(\sin G\) whenever \(|\sin G|\ge1/2\), for the same small-error regime as (2).

Stationarity and the expansion of \(H\) give
\[
 \theta=\pi/j-\rho\sin(\pi/j)/j^2+O(\rho^2),\qquad
 \Im B/H-\theta=-\pi/j+\frac{\rho\sin(\pi/j)}{j(j+1)}+O(\rho^2).
\]
The remaining phase in (1) is \(O(\rho)\). Choose
\[
 \rho_T=j(j+1)Y_T/n .
\]
Then the outer cut has \(G=(-m+T)\pi+o(1)\), while \(c m^{j+1}/x\to Y_T^j\). The absolute count just proved and the outer-edge theorem give exactly \(T\) simple real roots further to the left than this cut. In particular the cut has the sign of \(\cos G\) for sufficiently large fixed \(T\) followed by sufficiently large \(n\).

### Exact saddles between bounded radii and the double saddle

Let \(r>0\) solve \(h(r)=n\), and choose large fixed constants \(P,M\). For every \(P\le b\le r-M\), set \(N=n-h(b)\). Convexity gives \(N\ge Mh'(b)\). There is a unique saddle \(z=b+iy\) in \(|y-\pi|\le1/2\) with \(x=(h(z)-n)/H(z)>0\). Indeed solve
\[
 y+\arg z+\Im\log(1-h(z)/(ze^z))-\arg(n-h(z))=\pi .
\]
The left side is \(y+O(1/b+b^{p-1}e^{-b}+b^{p-1}/N)\); its \(y\)-derivative is one plus the same error. These estimates follow from \(h(z)-h(b)=O(b^{p-1})\) in this strip and \(H=ze^z-h\). The logarithmic derivative of \((h-n)/H\) is \(-1\) plus the same error. The real derivative of \(\log x\) along the branch parameterized by \(b=\Re z\) equals the squared modulus of the logarithmic derivative divided by its real part; hence \(x\) decreases strictly.

Write \(\Lambda=xe^b\asymp N/b\), \(q=1/b+(1+x)b^{p-2}/\Lambda\). Then \(|y-\pi|\le Cq\), \(q\) is uniformly small for large \(P,M\), and \(\Lambda\to\infty\) uniformly with \(n\). For the angle estimate one uses \(b^{p-1}e^{-b}=O(1/b)\) for large \(b\). At this exact saddle put \(D=z(h'-xH')=z^2E''\),
\[
 G=\Im E(z)-\tfrac12\arg D,\qquad R=|z|,\qquad \theta=\arg z .
\tag{3}
\]
Equation (2) holds uniformly here. To see this, parameterize the right part of the circle by \(v=\Im z'\). Up to a constant the real exponent is \((1+x)\Re A(z')-x e^{\Re z'}\cos v\). Its upper envelope \((1+x)\Re A(z')+x e^{\Re z'}\) exceeds its value at the saddle by \(O(\Lambda q^2)\). From \(v=y\) to \(v=2\pi\) the envelope drops by at least \(c[(1+x)b^{p-2}+\Lambda/b]\). For the polynomial term differentiate \(R^a\cos(a\arg z')/a!\) on this arc: all angular derivatives have the same sign and the top power drops by \(\gg b^{p-2}\). The real coordinate drops by \(\gg1/b\), giving the exponential loss. The envelope decreases further up to a small fixed positive angle. Beyond that angle its exponential term is \(O(\Lambda e^{-c'b})\) and \(A(R)-\Re A(z)=O(b^{p-2})\). For \(0\le v\le2\pi\) away from a fixed small neighborhood of \(\pi\), the cosine alone costs \(c\Lambda\), since \(R-b=O(1/b)\). Conjugation handles the other half. The separated arcs therefore lose at least \(c\Lambda q\), and \(\Lambda q\ge\max(\Lambda/b,b^{p-2})\ge\sqrt\Lambda\), since \(p\ge3\). Also \(b^{p-2}=O(\Lambda)\); polynomial factors from the length and weights are harmless.

In arclength \(R(\arg z'-\theta)\) the second derivative of \(E\) at the saddle is \(-D/R^2\). Its real part is \(\le-c\Lambda\) throughout a fixed small neighborhood of the saddle: the term \(x(z'+z'^2)e^{z'}/R^2\) has this sign near \(v=\pi\), and polynomial terms are \(O((1+x)b^{p-2})=O(q\Lambda)\). Third arclength derivatives are \(O(\Lambda)\). The usual Gaussian scaling gives (2) with (3) and \(\Re D>0\). The normalized sine multiplier has arclength derivative \(O_l(1)\) since \(R\sin(l\theta)\asymp_l y\) for \(P\) large.

The pure and exact regions overlap at a fixed large \(b\) near \(P\), where \(x/n\) stays bounded above and away from zero. Divide the last height bounds by \(n\) and pass to a convergent subsequence. The limiting circle has the same unique upper global maximum as in the angular condition. Nonvanishing \(H'\) and the saddle equation place the exact saddle within \(O(1/n)\) of the pure saddle at the same \(x/n\). Since \(-xB-n\log z\) is stationary at the pure saddle, its value changes by \(O(1/n)\); the change in \(A\) also has that order. The two curvature arguments agree to \(o(1)\), since \(D/n=-\tau K+O(1/n)\), using the principal logarithm of the upper saddles and principal curvature arguments. Thus the real unwrapped phases can be joined with error \(o(1)\) on this overlap.

### The two merging saddles

In this section \(X=(h-n)/H\), \(L=h'(r)/r\asymp r^{p-2}\). The [inner-edge expansion](fixed_threshold_inner.md) used with index parameter \(n\) gives, locally with all derivatives,
\[
 \frac{X(r+w)}{Le^{-r}}\longrightarrow we^{-w},\qquad
 \frac{E(r+w)-E(r)}{L}
   = w^2/2-\frac{xe^r}{L}(e^w-1)+o(1)
\tag{4}
\]
uniformly for bounded \(xe^r/L\). We keep the **exact** saddle in \(E\) and in its phase. The \(o(1)\) error in the normalized phase need not be small after multiplication by \(L\).

On every fixed \(0\le y\le y_1<\pi\), the real-saddle condition has a smooth branch \(z=r+u_n(y)+iy\), where \(u_n(y)\to u(y)=y\cot y\), \(u(0)=1\), with convergence of each fixed derivative. Divide \(\Im X(r+v+iy)\) by \(yLe^{-r}\) with its continuous value at zero. Its limit is \(e^{-v}(\cos y-v\sin(y)/y)\), whose \(v\)-derivative at the zero is strictly negative throughout the compact interval. The analytic implicit function theorem and conjugation prove the assertion, including evenness of \(u_n\). At \(y=0\) the point \(a=r+u_n(0)\) is the exact double saddle, \(x_*=X(a)>0\). For \(y>0\), \(x_n(y)=X(z)\) increases: after scaling its limit is \(y e^{-u}/\sin y\), with logarithmic derivative \(((1-y\cot y)^2+y^2)/y>0\). At \(y=0\), \(x_n'(y)/y\) after the same scaling tends uniformly near zero to the corresponding positive limiting quotient. Choose \(y_1\) with \(u(y_1)<-M-1\). The overlap around \(\Re z=r-M\) consists of the same exact branch as in the previous section, since the limiting \(y\) there is near \(\pi\) for large \(M\) and the large-coordinate branch was unique.

On any compact \(y\)-interval in \((0,y_1]\), integrate vertically through \(z\) and its conjugate, as in the [inner-edge contour](fixed_threshold_inner.md). The limiting real part on this line at height \(v\), up to an additive constant, is \(-v^2/2-(y/\sin y)\cos v\). Reducing \(v\) to \([-\pi,\pi]\) decreases its square; on \([0,\pi]\) strict decrease of \(\sin v/v\) shows that the sole maximum is \(v=y\) with negative second derivative. The remote connectors and circle have a loss \(cL\) by the inner-edge contour estimates with the bounded parameters in (4). Local Gaussian integration gives (2) with the phase (3): in vertical coordinates it is \(\Im E-\arg z-\arg E''/2\), since the measure is \(dz/z\) and \(\Re E''/L\to1-y\cot y>0\). On the overlap this is the same unwrapped argument as in (3), as \(\arg z=o(1)\) and \(\Re E''/L\) is bounded away from zero there. The normalized sine weight has local derivative \(O_l(1/y)\).

For \(y\downarrow0\) we need errors small whenever \(Ly^3\) is large. Put \(L_3=-E'''(a,x_*)\sim L\), with \(x\) shown explicitly in this notation. Exact real analytic expansion at the critical point gives, uniformly for small \(y\),
\[
 z=a+iy+O(y^2),\quad
 x_n(y)=x_*-\tfrac12X''(a)y^2+O(x_* y^4),\quad
 E''(z,x_n(y))=-iL_3 y+O(Ly^2),\quad E'''(z,x_n(y))=-L_3+O(Ly).
\tag{5}
\]
These uniform remainders follow from (4), its differentiated forms, evenness of \(u_n,x_n\), and \(B'(a)X''(a)=-L_3\). In the upper half replace \(0\le v\le\epsilon\) of the vertical line with the line \(z'=r+u_n(y)+\delta(y-v)+iv,\ \delta=1/2\), connecting horizontally at \(v=\epsilon\). Use its conjugate below. Write \(d=v-y\). By (5) the real exponent difference from the saddle equals
\[
 L_3d^2\left[-\delta y-\frac{3\delta-\delta^3}{6}\,d+O(y^2+y|d|+d^2)\right]
 \le-c L d^2(y+|d|),
\]
on a sufficiently small fixed arc, since \(d\ge-y\). For \(y\to0\) the horizontal connector stays below saddle height: at \(\Im(z'-r)=\epsilon\) the scaled real derivative in its real direction tends to \((\epsilon^2-(\Re(z'-r)-1)^2)/2+O(\epsilon^3)>0\) on the connector. Its highest endpoint, on the original line, has strict limiting loss by \(1-\cos\epsilon<\epsilon^2/2\). The remaining bounded and remote arcs satisfy the same bounds as in the inner-edge proof. In the scaled variable \(d\sqrt{Ly}\), the omitted Gaussian tail beyond \(v=0\) starts at \(-\sqrt{Ly^3}\). The cubic Taylor error is \(O(|d\sqrt{Ly}|^3/\sqrt{Ly^3})\). Both the exact and quadratic integrands have Gaussian absolute majorants, so integration of their difference gives \(O((Ly^3)^{-1/2})\) relative to a single peak, using \(|e^v-e^w|\le |v-w|\max(e^{\Re v},e^{\Re w})\). The normalized sine weight varies by \(O_l(|d|/y)\) near that peak. Its global bound is \(O_l(r/y)\), harmless on separated arcs because \(Ly^3\) is bounded below and \(L\asymp r^{p-2}\). Along the tilted contour the oriented Gaussian uses the same branch of \(\sqrt{E''}\): \((1+i\delta)\sqrt{E''/|E''|}\) has positive real part for small \(y\) by (5). Thus both signs in (2) persist to this range, with errors \(O((Ly^3)^{-1/2})+o(1)\).

Fix a sufficiently large integer \(U\), and cut at \(Ly^3=3\pi(U+1/4)\). From (5) and stationarity at the real fold, \(\Im E(z,x_n(y))=-L_3 y^3/3+O(Ly^4)\), while \(\arg E''\to-\pi/2\). Hence \(G=-U\pi+o(1)\) there. Its Airy coordinate \((x_n(y)-x_*)/\Delta\), with the scale of the inner-edge theorem, tends to \([(3\pi/2)(U+1/4)]^{2/3}\). Indeed \(\Delta=1/(\ell B'(a))\) and \(\ell=(2/L_3)^{1/3}\). Replacing the coefficient parameter \(n\) used here by \(n+1\) in that theorem changes \(x_*\) by \(O(1/H(a))=o(\Delta)\) and changes \(\Delta\) by a factor \(1+o(1)\), by its parameter derivative. The [indexed Airy-zero asymptotic](https://dlmf.nist.gov/9.9.iv) puts the limit strictly between \(d_U\) and \(d_{U+1}\) for large \(U\). Thus exactly \(U\) simple real roots lie between this cut and zero.

### Counting to the degree and finding the signs of the other rows

Choose \(T,U\) large enough that the uniform cosine and centered sine errors at the two moving cuts and between them are smaller than \(1/8\) (smaller than the fixed leading sine constant for the outer \(l=j\) test). Next take \(n\) sufficiently large. As \(t=-x\) increases from the outer to the inner cut, a continuous unwrapped phase runs from \((-m+T)\pi+o(1)\) to \(-U\pi+o(1)\). Each branch is parameterized monotonically in \(x\); on the compact overlap interpolate the unwrapped phases, which differ by \(o(1)\). Successive first hits of the intermediate integral multiples of \(\pi\) have alternating signs of \(I\), including the two cut endpoints. Thus the middle provides at least \(m-T-U\) distinct real zeros. Adding the \(T+U\) edge roots reaches the entire degree. Every zero is simple.

In a middle cell going from \(a\pi\) to \((a+1)\pi\), use the first hit of \((a+5/6)\pi\) and the last preceding hit of \((a+1/6)\pi\) (with endpoint phase errors allowed in the first and last cells). Signs at these points are opposite, so the unique root occurs between them. There \(\sin G\) has sign \((-1)^a\) and modulus \(\ge1/2\). Equation (2) and the small-radius centered test therefore give \(\operatorname{sgn}P_{n+l,j}(t_k)=(-1)^{m-k+1}\) at the \(k\)th root from the left. For the fixed numbers of outer and inner roots this same sign follows from the directed fixed-rank results in the [outer-edge proof](fixed_threshold_edge.md) and [inner-edge proof](fixed_threshold_inner.md), using one extra rank where needed. Every gap between successive roots of row \(n\) and its final gap to zero thus contains a root of the later row. If its degree rises, its leading sign supplies a root before the first as well. The degree difference is at most one for \(l\le j\), proving the stated strict interlacing.
