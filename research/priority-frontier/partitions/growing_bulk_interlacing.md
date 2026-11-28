# A density-one interlacing window below the cube-root threshold

Let \(P_{n,j}(t)\) count partitions of \([n]\) by their number of blocks of size at least \(j\). Suppose \(n\to\infty\) along any sequence of thresholds with
\[
               (\log n)^{3/2}=o(j),\qquad j=o(\sqrt n).
\]
There is a real interval containing \((1-o(1))\lfloor n/j\rfloor\) distinct simple negative zeros of \(P_{n,j}\). Between every two consecutive zeros there, \(P_{n+l,j}\) has exactly one zero, also simple, **simultaneously for \(1\le l\le j\)**. The estimates leave \(o(n/j)\) roots outside this interlacing result. The range includes every \(j\asymp n^\alpha\) for \(0<\alpha<1/2\).

For any fixed \(0<\epsilon<1/2\) the interval below contains \((1-2\epsilon+o_\epsilon(1))n/j\) such roots. This suffices for the statement by taking \(\epsilon\) to zero sufficiently slowly. This concerns Alexandersson's [set-partition interlacing question](https://mathoverflow.net/questions/462360/set-partitions-with-big-blocks-real-rooted-polynomials). All constants in the following proof may depend on \(\epsilon\).

## The negative-axis saddle

Write \(A(z)=\sum_{i=1}^{j-1}z^i/i!\), \(B(z)=e^z-1-A(z)\), and \(D=z\,d/dz\). The exponential formula gives \(P_{n,j}(-x)/n!=[z^n]\exp(A(z)-xB(z))\). Choose a radius \(R>0\) by
\[
 R e^R=\mu n,\qquad \epsilon\le\mu\le1-\epsilon.
\]
Uniformly, \(R\sim\log n\); the whole radius interval has bounded length. Factor
\[
 B(z)=\frac{z^j}{j!}H(z),\qquad DB(z)=\frac{jz^j}{j!}H_1(z),\qquad
 H_1=H+DH/j .
\]
For \(|z|\le R\), both \(H,H_1\) are \(1+O(R/j)\), and their logarithmic derivatives \(D^q\log H,D^q\log H_1\) are \(O_q(R/j)\) for each fixed positive \(q\). Indeed the coefficient of \(z^a\) in \(H\) is \(j!/(j+a)!\le j^{-a}\), and in \(H_1\) it gains \(1+a/j\). Further, \(D^qB(z)=o(n^{-M})\) on \(|z|\le R\) for fixed \(q,M\) since \((eR/j)^j\) decays faster than every such power. Thus \(A\) and any fixed number of its angular derivatives can be replaced by those of \(e^z-1\) with this absolute error.

For \(z=Re^{i\theta}\), \(0\le\theta\le2\pi/j\), solve
\[
 f(\theta)=j\theta+\arg H_1(z)-\arg(n-DA(z))=\pi .                 \tag{1}
\]
Both small arguments use the branches from zero. The real part of \(n-DA(z)\) is \((1-\mu+o(1))n\). On this interval,
\[
 f'(\theta)=j+\frac{\mu}{1-\mu}(1+R)(1+o(1)).
\]
Indeed \(\partial_\theta\arg(n-DA)=-\Re[D^2 A/(n-DA)]\), \(D^2 A(R)=\mu n(1+R)+o(1)\), and varying the angle costs \(O(n R^2/j)\) in its numerator and \(O(nR/j)\) in its denominator. This proves uniqueness of \(\theta_*\), with
\[
 j\theta_*=\pi-\frac{\pi\mu}{1-\mu}\frac Rj(1+o(1)).
\]
Set \(z_*=Re^{i\theta_*}\), \(x=(DA(z_*)-n)/DB(z_*)>0\). Then
\[
 x B(R)=\frac{(1-\mu+o(1))n}{j},\quad
 b_*:=\Im B(z_*)/B(R)=\frac{\pi\mu}{1-\mu}\frac Rj(1+o(1)).       \tag{2}
\]
For the latter use \(\arg H(z_*)=O(R\theta_*/j)\) and \(|H(z_*)/H(R)|=1+o(1)\).

Derivatives below are with respect to \(R\), across its bounded parameter interval. We have \(\theta_*'=O(R/j^2)\). Indeed \(\partial_R\arg(n-DA)= -R^{-1}\Im[D^2A/(n-DA)]\), vanishing at \(\theta=0\). Its \(\theta\)-derivative is \(O(R)\) using the bounds on \(D^2 A,D^3 A\). The corresponding \(H_1\) term also vanishes at zero and has \(\theta\)-derivative \(O(1/j)\). Implicit differentiation in (1) proves the claim. Consequently \(x'/x=-j/R+O(1)<0\): differentiate \(\log|n-DA|-\log|DB|\), using \(DB=jz^jH_1/j!\).

Put \(K=D^2(A-xB)(z_*)\). Its real part is \((1-\mu+o(1))nj\) and its imaginary part is \(O(nR)\): \(D^2B/DB=j+O(R/j)\) and \(xDB=DA-n\). In particular \(|K|\asymp nj\), \(|K'|/|K|=O(j/R)\), the latter by differentiating and using \(|D^q A|\ll nR^{q-1}\), \(x|D^q B|\ll nj^{q-1}\) for fixed \(q\ge1\). Choose \(\arg K\) in the right half-plane. Define the continuous phase
\[
 \Psi=\Im(A(z_*)-xB(z_*))-n\theta_*-\tfrac12\arg K.
\]
Uniformly over the interval it satisfies
\[
 \Psi=-(1-\mu+o(1))\frac{\pi n}{j},\qquad \Psi'\asymp n/j>0.       \tag{3}
\]
Indeed \(\Im A(z_*)=\mu n\theta_*(1+o(1))\) by Taylor expansion, and \(x\Im B=o(n/j)\) by (2). Stationarity eliminates the derivatives of \(z_*\) exactly from the derivative of the phase, leaving \(-x'\Im B-(\arg K)'/2\). The first term is positive of order \(n/j\) by (2) and the second is \(O(j/R)=o(n/j)\).

## Isolation and integration of the conjugate pair

Write \(S(\theta)=A(Re^{i\theta})-xB(Re^{i\theta})-in\theta\). The real-part loss at \(\theta_*\) from the common upper bound \(A(R)+xB(R)\) is
\[
              (1+o(1))\,\mu n(1+R)\,\frac{\pi^2}{2j^2}.           \tag{4}
\]
For \(A\) use its real angular Taylor expansion, whose fourth derivative is \(O(nR^3)\). For \(B\), the phase displacement from \(\pi\) is \(O(R/j)\), and \(H(z_*)/H(R)=1+O(R/j^2)\) by the logarithmic derivative. Its extra loss is \(O(nR^2/j^3)=o(nR/j^2)\).

For \(2\pi/j\le|\theta|\le c/R\), the loss from \(A\) alone is at least \(0.4\,\mu n(1+R)\theta^2\), by the same Taylor estimate for sufficiently small fixed \(c>0\). This exceeds (4) by \(\gg nR/j^2\). For \(c/R\le|\theta|\le\pi\), use \(\Re e^{Re^{i\theta}}\le e^{R\cos\theta}\). The loss is \(\gg n/R^2\), again larger than (4) because \(R^3=o(j^2)\). On \(0\le\theta\le2\pi/j\) outside \(|\theta-\theta_*|\le c_1/j\) for a small fixed \(c_1>0\), the angle of \(B\) stays a fixed distance from \(\pi\) modulo \(2\pi\); thus its loss is \(\gg xB(R)\asymp n/j\). Conjugation gives the negative half. On each retained neighborhood \(\Re S''\le-c_2nj\), by \(\Re K\asymp nj\) at its center and \(\sup|S'''|\ll nj^2\). Outside them the relative integrand is \(O(\exp(-c_3nR/j^2))\). This is smaller than every fixed power of \(n^{-1}\) since \(j=o(\sqrt n)\).

For a multiplier \(M(\theta)\) with conjugate values at opposite angles, let \(I[M]=(2\pi R^n)^{-1}\int_{-\pi}^{\pi}e^{S(\theta)}M(\theta)\,d\theta\). Let \(M_*,M_1,M_2\) denote its value at \(\theta_*\) and supremum bounds for its first and second derivatives in the retained neighborhood. For all the multipliers below \(\|M\|_\infty=O(1)\). There is a common \(C_n>0\) such that
\[
 \frac{I[M]}{C_n}=\Re(e^{i\Psi}M_*)+
 O\!\left(\frac jn|M_*|+\frac{M_1}{n}+\frac{M_2}{nj}+n^{-10}\right).
                                                                    \tag{5}
\]
Indeed put \(\sigma=(nj)^{-1/2}\). Extending the symmetric central region to the Gaussian line costs a negligible amount. To verify the error precisely, restrict first to \(|\theta-\theta_*|\le \sigma\log n\), where the cubic is \(O(\sqrt{j/n}\log^3 n)=o(1)\), with a Gaussian tail on the remaining neighborhood. After expanding the exponential, the odd cubic and the linear term of \(M\) each integrate to zero against the centered complex Gaussian. Its normalized absolute moments of order \(q\) are \(O_q(\sigma^q)\) since \(\Re K\asymp|K|\asymp nj\). The fourth-order exponent remainder and squared cubic cost \(O(nj^3\sigma^4+(nj^2)^2\sigma^6)=O(j/n)\). The mixed term from the first derivative of \(M\) and the cubic costs \(O(M_1nj^2\sigma^4)=O(M_1/n)\), while the second derivative costs \(O(M_2\sigma^2)\). These bounds also follow by splitting \(M=M_*+(M-M_*)\) and bounding the latter by its linear and quadratic Taylor terms. The other saddle is its conjugate; the Gaussian factor supplies \(-\arg K/2\) in (3).

## Counting simple roots and signs throughout the \(j\)-row window

For \(0\le l\le j\) take \(M_l=e^{-il\theta}\). Then \(I[M_l]=R^lP_{n+l,j}(-x)/(n+l)!\), and (5) gives
\[
     I[M_l]/C_n=\cos(\Psi-l\theta_*)+O(j/n).
\]
Each phase \(\Psi-l\theta_*\) is strictly increasing by (3) and the bound on \(\theta_*'\). On each of its complete cells between two consecutive multiples of \(\pi\) the endpoints have alternating signs, and all zeros are within \(O(j/n)\) in phase of the single half-integer multiple therein. Every zero in such a cell is simple, with derivative in \(x\) having the sign of \(\sin(\Psi-l\theta_*)\). Indeed insert
\[
  -e^{-il\theta}\,[B(Re^{i\theta})-\Re B(z_*)]/B(R).
\]
At the zero, the subtraction vanishes from the integral, and the positive \(R^l\) can be held fixed when differentiating the coefficient integral with respect to \(x\). This multiplier has \(M_*=-i e^{-il\theta_*} b_*\), \(M_1=O(j), M_2=O(j^2)\), and bounded supremum on the circle. Thus (5) gives the required derivative sign because \(j/n=o(b_*)\) by (2). All zeros in a given cell have the same crossing direction, so there is exactly one. This also proves uniqueness on partial cells whenever a root exists there.

Finally \(0<l\theta_*<\pi\) for \(1\le l\le j\). Its distance to either endpoint is \(\gg1/j\): at the lower end use \(\theta_*\asymp1/j\), at the upper end \(\pi-j\theta_*\asymp R/j\). Both dominate \(j/n\). At a root of the base row with phase \((q+1/2)\pi+O(j/n)\), the shifted phase therefore lies strictly between the consecutive half-integer multiples \((q-1/2)\pi\) and \((q+1/2)\pi\), at a distance much greater than the uniform root-location error. For consecutive base roots in the interval, monotone traversal of the shifted phase passes exactly one of its simple roots between them. One may omit the bounded number of boundary cells to keep both shifted and unshifted cells complete for every \(l\). By (3) the base phase traverses \((1-2\epsilon+o(1))n/j\) cells. Returning to \(t=-x\) proves the asserted real-root count and strict interlacing throughout this interval.
