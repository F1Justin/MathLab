# The first real roots and their row shifts at a growing block threshold

Let \(P_{n,j}\) enumerate set partitions by the number of blocks of size at least \(j\). Suppose \( (\log n)^{3/2}=o(j)\) and \(j=o(\sqrt n)\). Denote the positive magnitudes of the negative **real** roots by \(x_{n,1}<x_{n,2}<\cdots\), using the same threshold \(j\) throughout the window \(n,\ldots,n+j\). At each fixed index the roots below are simple. There exists an exact positive double saddle \((r_c,x_c)\) such that, for every fixed \(i\),
\[
 x_{n,i}-x_{n+l,i}=(1+o(1))\,\frac{l}{D B(r_c)}
       \qquad(1\le l\le j),                                         \tag{1}
\]
uniformly in \(l\), where \(D=z\,d/dz\) and \(B(z)=\sum_{a\ge j}z^a/a!\). The first finitely many real roots of the two rows strictly alternate in the directed order. This includes the region below every prescribed positive power of \(n\). Complex roots away from the real axis are outside the ranking in this statement. The [bulk theorem](growing_bulk_interlacing.md) treats the long central interval by a different pair of saddles.

Put \(A=e^z-1-B\). Let \(r>0\) solve \(DA(r)=n\), and set
\[
 d=\frac{D^2A(r)}{j^2},\qquad f(v)=
 \frac{A(r e^{v/j})-A(r)-nv/j}{d},\qquad b(v)=\frac{B(r e^{v/j})}{B(r)} .
\]
We have \(r\sim\log n,\ d\sim n(1+r)/j^2\to\infty\). Indeed \(DA\) is increasing and the omitted exponential tail and every fixed number of its angular derivatives are \(o(n^{-M})\) on \(|z|\le 2\log n\) for every fixed \(M\). This follows from Stirling's lower bound and \(j/\log n\to\infty\). In particular \(r=W(n)+o(1)\). On every fixed complex disk in \(v\), with all fixed-order derivatives,
\[
                     f(v)\longrightarrow v^2/2,\qquad b(v)\longrightarrow e^v.
\]
For the first convergence \(f(0)=f'(0)=0,\ f''(0)=1\), and \(f'''(v)=O(r/j)\). For the second use \(B=z^jH(z)/j!\) with \(D^a(H-1)=O_a(r/j)\) for \(a\ge0,\ |z|\le 2r\).

Write \(E_\lambda=f-\lambda b,\ x=d\lambda/B(r)\). The real saddle level is \(\lambda(u)=f'(u)/b'(u)\) for \(0\le u\le2\), approaching \(u e^{-u}\) with all fixed derivatives. Thus \(\lambda\) increases strictly from zero to its unique nearby maximum at \(u_c=1+o(1)\); here and below only the branch up to \(u_c\) is used. Indeed outside a fixed neighborhood of 1 its derivative has the signs of \(1-u\), and inside that neighborhood its second derivative is strictly negative. Put
\[
 \lambda_c=\lambda(u_c),\quad r_c=r e^{u_c/j},\quad x_c=d\lambda_c/B(r),
 \quad b_1=b'(u_c),\quad \kappa=-E_{\lambda_c}'''(u_c),\quad q=(d\kappa/2)^{1/3}.
\]
Thus \(\lambda_c\to1/e,\ b_1\to e,\ \kappa\to1\), and \(E'_{\lambda_c}(u_c)=E''_{\lambda_c}(u_c)=0\). Equivalently \(DA(r_c)-x_cDB(r_c)=n\) and \(D^2 A(r_c)-x_cD^2 B(r_c)=0\).

## Positivity before the turning point

For the old row integrate at \(z=r e^{(u+iy)/j}\), \(|y|\le\pi j\). Up to a positive factor its value is the integral of \(\exp(d E_\lambda(u+iy))\). For row \(n+l\) the additional factor, up to a positive constant, is \(e^{-i(l/j)y}\). First let \(\lambda=\lambda(u),\ 0\le u<u_c\), and put \(w=u_c-u\). Then \(E_\lambda''(u)=b'(u)\lambda'(u)\asymp w\), uniformly, by the derivative convergence and the negative second derivative of \(\lambda\) near \(u_c\).

On \(|y|\le c_0\) for a sufficiently small absolute \(c_0>0\), the loss in \(\Re E_\lambda\) from \(y=0\) is at least \(c w y^2\), and near \(u_c\) it is at least \(c(w y^2+y^4)\). To see this use the real even Taylor expansion for the loss through degree four with remainder \(O(y^6)\); near \(u_c\), \(E_\lambda''''(u)\) tends to \(-1\) as \(u\to1\), whereas away from it the second derivative is bounded below. For \(c_0\le |y|\le4\) there is a fixed positive loss: uniformly its limiting lower bound is \(y^2/2-(1-\cos y)>0\). Here \(\lambda(u)b(u)=u+o(1)\). For \(4\le |y|\le c_1j/r\), the loss in \(\Re A\) is at least \(0.4d y^2\), by its fourth-order angular Taylor bound \(O(nr^3(y/j)^4)\) on choosing \(c_1\) small. At the shifted radius \(D^2 A(r e^{u/j})/(dj^2)\to1\), uniformly. The loss can be offset in \(-xB\) by at most \(2xB(r e^{u/j})\le(2+o(1))d\). On the remaining arc the loss in \(\Re A\) is \(\gg n/r^2\gg d\), using \(\Re e^{z}\le e^{|z|\cos(y/j)}\) and \(r^3=o(j^2)\).

Relative to the positive central Gaussian integral the absolute error is at most
\[
                   O\big((d w^3)^{-1/2}+(dw)^{-1/2}\big)+o(1)     \tag{2}
\]
whenever \(w\ge T d^{-1/3}\), uniformly in \(0\le l\le j\). Indeed both the exact central exponential divided by its positive saddle value and its quadratic approximation have moduli \(\le e^{-cdw y^2}\). Since the remainder after their log quadratic is \(O(d|y|^3)\), the inequality \(|e^a-e^b|\le|a-b|\max(e^{\Re a},e^{\Re b})\) gives the first error by integration. Replacing \(e^{-i(l/j)y}\) by one costs at most \(|y|\), giving the second. Outer arcs have total contribution \(O(j e^{-c d})\) relative to the unnormalized peak, negligible since \(d/\log n\to\infty\). Thus every row is strictly positive on the entire real interval of \(x\) corresponding to \(0\le u\le u_c-Td^{-1/3}\), for an absolute fixed sufficiently large \(T\). Near \(u_c\) we have \(\lambda_c-\lambda(u)\asymp w^2\).

## Airy limit and the row difference

Use the analytic parameter \(\xi\) defined by
\[
           \lambda=\lambda_c+\frac{q\,\xi}{d b_1},\qquad
           x=x_c+\frac{q\,\xi}{B(r)b_1}.
\]
Write \(H_l(\xi)\) for \(P_{n+l,j}(-x)/(n+l)!\), multiplied by the common factor \(jq\, r^n\exp[-A(r)-d E_\lambda(u_c)]\) and the further positive factor \(r_c^l\). In the coefficient integral choose \(u=u_c-1/q\), put \(z_0=-1+it\), \(t=qy\), and \(v=u_c+z_0/q\). Then
\[
 H_l(\xi)=\frac1{2\pi}\int_{-\pi jq}^{\pi jq}
       \exp\{d[E_\lambda(v)-E_\lambda(u_c)]\}
       \exp[-(l/j) z_0/q]\,dt .
\]
On compact complex \(\xi\)-sets, for bounded \(t\) the first exponent is
\[
       -z_0^3/3-\xi z_0+O\big(q^{-1}(|z_0|^4+|z_0|^2)\big),
\]
by the exact stationarity and fold-curvature cancellation at \(u_c\).

For domination, \(E_{\lambda_c}''(u_c-1/q)=\kappa/q+O(q^{-2})\), its fourth derivative there is strictly negative, and \(d|E_{\lambda_c}(u)-E_{\lambda_c}(u_c)|=O(1)\). The preceding real-part bounds therefore give a bound \(C\exp[-c t^2+C_\xi |t|]\) on \(|y|\le c_0\); the \(\xi\)-term here is controlled by \(b(u+iy)-b(u_c)=O(1/q+|y|)\). On all remaining arcs the loss is \(\gg d\), since the compact-arc limit and larger-angle bounds used above still hold for \(u=u_c-1/q,\lambda=\lambda_c\). The complex perturbation costs only \(O_\xi(q)\), using \(|b(u+iy)|\le b(u)\). The length \(O(jq)\) and all fixed polynomial factors are absorbed since \(d/\log n\to\infty\). All bounds are uniform in \(0\le l\le j\). On the central line \(|\exp[-(l/j) z_0/q]|\le e^{1/q}\).

The Airy integral on \(\Re z_0=-1\) now gives locally uniform analytic convergence
\[
 H_l(\xi)\longrightarrow F(\xi):=\mathrm{Ai}(-\xi),\qquad
 \frac{jq}{l}\,[H_l(\xi)-H_0(\xi)]\longrightarrow F'(\xi)
                         \quad(1\le l\le j).                        \tag{3}
\]
For the second limit the extra multiplier tends to \(-z_0\) and is bounded by \(e^{1/q}|z_0|\) along the entire vertical line, from the integral remainder for the complex exponential. This is also the multiplier obtained by differentiating the limiting integral in \(\xi\). Compact convergence implies \(H_l'\to F'\) locally uniformly.

Let \(0<a_1<a_2<\cdots\) denote the positive zeros of \(\mathrm{Ai}(-\xi)\); they are simple, and there are no real zeros to their left. On any compact segment extending strictly past \(a_i\), (3) and small conjugation-invariant disks isolate one simple real zero of every \(H_l\) near each of its first \(i\) limiting zeros, with no other real zeros in that segment. Its left endpoint can be taken at a sufficiently large negative constant depending on \(T\): by \(\lambda_c-\lambda(u)\asymp w^2\) this overlaps the zero-free region in (2). Hence these are the first real roots of each row from the origin. In particular
\[
            x_{n,i}=x_c+\frac{q}{B(r)b_1}(a_i+o(1)).
\]

At the old rescaled zero \(\xi_{0,i}\), (3) yields \(H_l(\xi_{0,i})=(l/(jq))(F'(a_i)+o(1))\). The mean-value theorem between the old and new rescaled zeros and \(H_l'(\xi)=F'(a_i)+o(1)\) there give \(\xi_{0,i}-\xi_{l,i}=(1+o(1))l/(jq)\). Both errors are uniform in the full row window. Multiplying by \(q/[B(r)b_1]\) and using \(jB(r)b_1=DB(r_c)\) proves (1). Neighboring Airy gaps have strictly positive limiting \(\xi\)-length, while \(l/(jq)\to0\), so \(x_{n+l,i}<x_{n,i}<x_{n+l,i+1}\) for every fixed \(i\) and large \(n\).

## Uniformity over a growing initial run of roots

In fact (1) and the strict ordering hold uniformly for **all \(1\le i\le I_n\)** for any sequence \(I_n=o(d^{2/11})\). This strengthens the fixed-index statement even when the new row shift is a single element.

For real \(\xi\ge0\) put \(X=1+\xi,\ a=X^{-1}\), and now integrate along \(u=u_c-a/q\), equivalently \(z_0=-a+it\). For \(X^{11/4}=o(q)\), in particular \(X^2=o(q)\). Thus
\[
 E_\lambda''(u)=(\kappa+o(1))a/q,\qquad E_\lambda''''(u)=-1+o(1),
\]
because \(\lambda-\lambda_c=O(X/q^2)=o(a/q)\). At the center of integration \(d(E_\lambda(u)-E_\lambda(u_c))=O(a^3+Xa)=O(1)\). Therefore on \(|t|\le c_0q\) both the true normalized exponential and \(\exp(-z_0^3/3-\xi z_0)\) have modulus at most \(C e^{-c a t^2}\). Their exponent difference is bounded by \(C(|z_0|^4+X|z_0|^2)/q\), from fourth-order Taylor control on this fixed \(v\)-disk. On the remaining arcs the earlier loss \(\gg d\) absorbs the perturbation \(O(q X)=o(d)\). The discarded tails of the model on the whole infinite line also decay faster than any fixed power of \(q^{-1}\), since \(a q^2\gg q\).

Comparing the integrands by the exponential difference bound used in (2) gives, uniformly including all \(l\),
\[
 \begin{split}
 H_l(\xi)&=F(\xi)+O(X^{5/2}/q),\\
 H_l'(\xi)&=F'(\xi)+O(X^3/q),\\
 (jq/l)(H_l(\xi)-H_0(\xi))&=F'(\xi)+O(X^3/q)\qquad(l\ge1).
 \end{split}                                                       \tag{4}
\]
Indeed \(\int |z_0|^m e^{-ca t^2}\,dt\ll_m X^{(m+1)/2}\). The additional exponential in \(H_l\) has modulus \(\le e^{a/q}\) and differs from one by \(O(|z_0|/q)\). For the derivative, hold the contour fixed at the point in question; its multiplier is \(-q(b(v)-b(u_c))/b_1=-z_0+O(|z_0|^2/q)\) on the central arc. The scaled difference in the last line has the same approximation by the integral Taylor formula for the exponential. The first error in (4) therefore uses moments through order four, the other two through order five. Outside this arc all extra factors grow at most polynomially in \(n\), absorbed by \(d/\log n\to\infty\).

At consecutive positive extrema of \(F(\xi)=\mathrm{Ai}(-\xi)\), meaning extrema at positive arguments \(\xi\), \(|F|\asymp X^{-1/4}\). Where \(|F|=o(X^{-1/4})\) between these nodes, \(F'\) has their intervening crossing direction and \(|F'|\asymp X^{1/4}\). More precisely the distance to that cell's Airy zero \(a_i\) is \(o(X^{-1/2})\), and \(F'(\xi)/F'(a_i)=1+o(1)\) there for growing \(i\). These facts follow directly from the sine and cosine asymptotics with phase \(2\xi^{3/2}/3+\pi/4\), and \(a_i\asymp i^{2/3}\). [Airy expansions](https://dlmf.nist.gov/9.7#E9) · [Airy zero locations](https://dlmf.nist.gov/9.9#iv)

For the indicated ranks \(X^{11/4}/q=o(1)\) out to the next extremum, uniformly. Thus (4) gives the extremum signs for every \(H_l\), and at any of its zeros in each Airy cell it gives the same strict derivative sign. There is exactly one simple real root per cell, adjoining the first bounded cells already handled. At the old root the last line of (4) divided by \(F'(a_i)\) tends uniformly to one; throughout the segment between the old and new roots the same is true of \(H_l'/F'(a_i)\). Applying the same mean-value argument proves (1) uniformly through these growing ranks. Their neighboring Airy gaps have size \(\asymp X^{-1/2}\gg 1/q\), so the full sequence of adjacent-row inequalities also persists.
