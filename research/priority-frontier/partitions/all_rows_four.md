# Real-rootedness of every threshold-four partition polynomial

Let \(P_n(t)\) count the set partitions of \([n]\) by their number of blocks of size at least four, so
\[
 P_n(t)=n![z^n]\exp\{A(z)+tB(z)\},\qquad
 A=z+z^2/2+z^3/6,\qquad B=e^z-1-A .
\]
For every nonnegative integer \(n\), **all \(\lfloor n/4\rfloor\) zeros of \(P_n\) are simple, real and negative**. This is a computer-assisted proof of the threshold-four real-root assertion in [Alexandersson's question](https://mathoverflow.net/questions/462360/set-partitions-with-big-blocks-real-rooted-polynomials). The [finite interlacing certificates](../../../snapshot/research/partitions/four_row_window.md) cover \(n\le2004\). The following sign argument applies to \(n\ge2000\) and proves real-rootedness. The [middle sign tests](effective_bulk.md) also give strict interlacing of consecutive rows through their common outer and middle intervals. The [directed row-gap theorem](interlacing_four.md) gives the separate inner sign tests and proves strict interlacing at every gap from one through four.

## The count left to prove

Write \(m=\lfloor n/4\rfloor,\ t=-x<0\), and \(E(z)=A(z)-xB(z)-n\log z\); choose the principal log for upper saddles in the right half-plane. The [effective outer-to-middle argument](effective_bulk.md) identifies the fifth root from the left in the exact action cell
\[
             (-m+4)\pi<\Theta<(-m+5)\pi,\qquad
             \Theta=\Im E(z),\quad E'(z)=0 .
\]
On that initial part of the real \(t\)-axis the action increases, each complete cell contains precisely one simple real root, and at integral phases the sign of \(P_n(-x)\) is \((-1)^{\Theta/\pi}\). In particular there are five distinct negative real roots strictly before the anchor \(\Theta=(-m+5)\pi\). This anchor lies before the cut at \(|z|=13\), by the endpoint phase bound and \(m\ge500\).

The [continuation and vertical curvature lemma](effective_bulk.md#the-exact-branch-extending-to-the-double-saddle) gives the following exact parametrization after that cut. Write \(z=a+iy\) for the upper saddle, \(a\ge12,\ 0<y<\pi\), and put
\[
 \begin{split}
 s_0&=\sin(y)/y,\quad K=1+2a+(3a^2-y^2)/2,\quad
 d=(\cos y+a s_0)/K,\\
 \Lambda&=xe^a,\quad \beta=1/\Lambda=d-e^{-a}>0,\quad Q=s_0-(1+a)d,\qquad
 n=(a^2+y^2)Q/\beta .
 \end{split}                                                        \tag{1}
\]
In particular \(0<Q\le1\). The branch is continuous in increasing \(t\) from the cut to its real double saddle, where \(\Theta=0\). We will prove that at every point of this continuation with \(|\Theta|\ge\pi\) and \(\Theta\in\pi\mathbb Z\), the sign is again \((-1)^{\Theta/\pi}\). Then successive first hits of \((-m+6)\pi,\ldots,-\pi\), followed by \(t=0\) where \(P_n(0)>0\), force \(m-5\) more distinct negative roots after the anchor. No monotonicity of \(\Theta\) is needed for this last count. There are \(\lfloor n/4\rfloor\) roots in total since the leading coefficient counts partitions with that many large blocks and is positive. Saturation proves simplicity and leaves no complex zeros.

## The normalized local integral

In (1) set \(p=1/a,\ Z=1+ipy,\ \eta=\sqrt{\beta/y},\ k=\eta/y\). For any displacement \(b\) on the contour below, define
\[
 \begin{split}
 C&=E''(z)/\Lambda,\qquad
 C/y=y\left[\frac{s_0-\cos y}{y^2}-\frac{2Qp^2}{1+p^2y^2}\right]
       +i\left[d-s_0-\frac{2pQ}{1+p^2y^2}\right],\\
 G(b)&=\frac d6-
       e^{iy}\frac{e^b-1-b-b^2/2}{b^3}
       -\frac{pQ\overline Z}{Z^2}
         \frac{\log(1+w)-w+w^2/2}{w^3},\qquad w=pb/Z .
 \end{split}                                                         \tag{2}
\]
All quotients at zero are evaluated by continuation. Expanding the polynomial and removing the linear term by stationarity gives the exact difference
\[
 [E(z+b)-E(z)]/\Lambda= C b^2/2+b^3G(b).
\]
The expression for \(C/y\) in (2) avoids cancellation even at \(y=0\). At \(b=-iy\) the point \(z+b=a\) is real, and therefore
\[
             \Theta k^2=\tfrac12\Im(C/y)-\Re G(-iy).
\]
In particular \(|\Theta|\ge\pi\) implies \(0<k<0.52\). Indeed \(d\le (a+1)/(1+2a+3a^2/2-\pi^2/2)<0.07\) for \(a\ge12\), so \(|\Im(C/y)|\le 1+1/6\). For imaginary \(b\) the exponential remainder quotient has modulus at most \(1/6\), by the integral Taylor formula. The logarithmic quotient has modulus at most \(1/[3(1-\pi/12)]\) here. Thus \(|\Theta|k^2\le(1+1/6)/2+0.07/6+1/6+1/[36(1-\pi/12)]<0.81<\pi(0.52)^2\).

Choose \(0\le v\le6\), write \(D=v-y\), and let the top path run along \(z'=z+b\), where
\[
 b=iD-\delta\,\operatorname{sgn}(D)\min\{|D|,(2-|D|)_+\},\qquad
 \delta=\tfrac12(1-y/2.8)_+ .
\]
It starts at a positive real point and ends at \(a+6i\) because \(6-y>2\). Close the upper contour by a horizontal segment from there to \(\xi+6i\), \(\xi=\sqrt{a^2+y^2-36}\), and the circle of radius \(\sqrt{a^2+y^2}\) from that point to the negative real axis. Conjugation closes a positively oriented contour around zero. Deformation from the ordinary coefficient circle is valid: the modified portion and the join lie in the open right half-plane, and \(e^{E(z)}/z\) is single-valued away from zero. Consequently the sign at an integral action is \((-1)^{\Theta/\pi}\) times the sign of the real part of
\[
         \frac{a}{\eta}\int_{\rm upper}e^{E(z')-E(z)}
                                    \frac{dz'}{i z'} .                \tag{3}
\]
There is no curvature phase in this sign test.

On the top path set \(s=D/\eta,\ T=b/\eta\). The exact exponent and amplitude in (3), with \(ds\) as measure, are
\[
 \mathcal H=(C/y)T^2/2+kT^3G(b),\qquad
 \mathcal A=\frac{1+i\delta\sigma}{Z+pb},\qquad
 \sigma=\begin{cases}1& |D|<1,\\-1&1<|D|<2,\\0&|D|>2.\end{cases}
\]
The permitted range is \(1+ks\ge0,\ y+\eta s\le6\).

The [Arb verifier](check_all_rows_four.py), run with python-flint 0.9.0, establishes the following two strict rational bounds:
\[
 \Re\mathcal H\le-s^2/40,\qquad
 \Re\int_{\substack{|s|\le12\\1+ks\ge0}}\mathcal A e^{\mathcal H}\,ds>\tfrac12 ,
                                                                    \tag{4}
\]
and \(y+12\eta<6\) on the feasible domain. Equality in the first bound is allowed at \(s=0\).

For reproducibility, the envelope check uses \(0\le p\le1/12,\ 0\le y\le\pi\). For \(D\le0\) write \(D=-yx\), \(0\le x\le1\); for \(D\ge0\) take \(0\le D\le6\) and omit boxes with \(D+y>6\) throughout. Put \(\omega=b/D\) by continuation. The expression tested for negative \(D\) is
\[
 \Re[(C/y)\omega^2/2]-x\Re[\omega^3G(b)]<-1/40.
\]
For positive \(D\), multiply the inequality by \(y\), obtaining \((\Re[(C/y)\omega^2/2]+1/40)y+D\Re[\omega^3G(b)]<0\). The two terms may also be bounded separately. This proves the first estimate using 479 accepted boxes.

For the integral bound, subdivide \(0\le k\le0.52\) together with \(p,y\). Exclude boxes where \(\beta=d-e^{-1/p}\) is negative throughout or where its enclosure is disjoint from \(y^3 k^2\); interpret \(e^{-1/p}=0\) at \(p=0\). Each remaining accepted box gives a lower Riemann sum on \([-12,12]\) with width \(1/8\). If \(1+ks\) can have either sign, the integrand enclosure includes zero. The first bound in (4) caps the real exponent when an interval evaluation is wider. This exhaustive cover accepts 318 integral boxes and discards 360 infeasible boxes. The program bounds \(\sin y/y\) and \((\sin(y)/y-\cos y)/y^2\) by alternating series, and the entire exponential and analytic logarithmic quotients in (2) by Taylor polynomials through degrees 24 and 29 with explicit geometric tail bounds. Every use checks \(|b|<7,\ |pb/Z|<11/20\) on its box. The reported box counts are for 72-bit Arb arithmetic.

On the portion beyond \(|s|=12\) use \(|\mathcal A|\le(24/23)\sqrt{5/4}\) since \(\Re(z+b)\ge a-1/2\). The omitted absolute integral is bounded by
\[
       (24/23)\sqrt{5/4}\,(40/12)e^{-144/40}<0.11 .                  \tag{5}
\]

## Closing the contour

On both the connector and circle, \(|z'|\ge|z|\); the logarithmic term in the real phase difference is nonpositive. The exponential term contributes at most \(\Lambda(e^{\xi-a}+\cos y)\): on the circle \(\Re z'\le\xi\), while on the horizontal segment \(\cos 6>0\). Let \(b_y=2\) if \(y\le2.3\) and \(b_y=1.1\) otherwise. Since \(y\cot(y/2)\) decreases, \(1+\cos y\le b_y s_0\). Moreover
\[
 a(1-e^{\xi-a})\ge a(1-e^{-13/a})\ge12(1-e^{-13/12})>7.8,\qquad
 e^{-a}K\le241e^{-12}<0.002 .
\]
Using \(a s_0=K\beta+e^{-a}K-\cos y\) gives
\[
          \Lambda(e^{\xi-a}+\cos y)\le b_y K/a-5\Lambda/a .
\]

On the horizontal segment the polynomial loss \(\Re A(z)-\Re A(z')\) exceeds \(10a\), since \(\Re A(\zeta+6i)=A(\zeta)-18(1+\zeta)\) and \(\sqrt3\,a/2\le\xi\le\zeta\le a\). On the circle up to angle \(\pi/3\), all three cosine terms in \(\Re A\) are nonincreasing, so the same loss holds. On \(\pi/3\le t\le\pi\), put \(w=\sqrt{1+p^2y^2}\). Expanding \(\Re A(z)-\Re A(|z|e^{it})\) and dividing by \(a\) gives the lower bound
\[
 \begin{split}
 &(1-\cos t)+6(1-\cos 2t)+24(1-\cos 3t)-y^2U,\\
 U&=\tfrac12+\frac{w^2+w+1}{6(w+1)}\cos 3t
                    +\tfrac p2(1+\cos 2t)+\frac{p^2}{w+1}\cos t .
 \end{split}
\]
This uses only \(a\ge12\) in the three nonnegative terms. On 1,600 equal angle intervals the verifier proves that the lower bound is greater than 6 for \(y\le2.3\), and greater than \(5/2\) throughout \(0\le y\le\pi\). The polynomial loss in the exponent is multiplied by \(1+x\ge1\). As \(K/a^2\le 3/2+2/12+1/144\), in both ranges the entire closing contour has real exponent difference at most \(-0.6a-5\Lambda/a\). Its contribution to (3) is bounded by
\[
 (\pi+1)a\sqrt{\Lambda y}\,e^{-0.6a-5\Lambda/a}
 \le(\pi+1)\sqrt\pi\,12^{3/2}e^{-7.2}/\sqrt{10e}<0.05 ,
\]
using the decrease of \(a^{3/2}e^{-0.6a}\) and \(\sup_{v>0}\sqrt v\,e^{-5v}=1/\sqrt{10e}\).

The real part in (3) is strictly greater than \(1/2-0.11-0.05>0\). This verifies the required integer-phase signs and completes the degree count.
