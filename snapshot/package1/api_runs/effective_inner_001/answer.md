Let \(c_* = 3/(2e)\). I get a one-sided certificate for **every \(n\ge 2000\)** whose cutoff approaches \(c_*\) to within an explicit multiple of \(r^{-2/3}\) in the \(c\) coordinate. I also get a two-sided, adjacent-row certificate with a much larger explicit threshold. The large threshold is only used for the two-sided result.

Specifically, put
\[
 s=(15/r)^{1/3},\qquad d=1-s/5,\qquad c_-(r)=\tfrac32 d e^{-d}.
\]
Then
\[
 \boxed{\quad P_n(-x)>0\qquad
       (0\le x\le c_-(r) r e^{-r},\quad n\ge 2000).\quad}                 \tag{1}
\]
In particular the multiplier is at least \((6/5)e^{-4/5}\), and its deficit satisfies
\[
 0<c_*-c_-(r)\le c_*\,\frac{e^{1/5}}{50}(15/r)^{2/3}.                 \tag{2}
\]

Here is the two-sided result. Use \(b=(3/4)^{1/3}\) and the affine coordinate \(u\) defined by
\[
 x=c_*r e^{-r}\left(1+\frac{2b}{3}u r^{-2/3}\right).
\]
For \(r\ge 10^{24}\), the nearest negative real zero is simple and its \(u\) is in \((2,5/2)\). The next row has exactly one real zero strictly between this zero and \(0\). Thus an explicit, albeit very conservative, row threshold for these conclusions is
\[
 N=10^{24}+10^{48}+10^{72}/2.
\]
The proof of (1) does **not** establish a sign change in the gap \(2000\le n<N\).

### 1. Real-saddle certificate

Write \(a(R)=R+R^2+R^3/2\), \(F=A-xB\), and use the moment notation
\[
 A_j(R)=(R\partial_R)^j A(R),\qquad F_j(R)=(R\partial_R)^j F(R).
\]
We only need \(r\ge 15\), which follows from \(n\ge 2000\). In the interval of (1) there exists \(R\in[r,r+d]\) with \(F_1(R)=n\). In fact \(F_1(r)\le n\), and at \(R=r+d\),
\[
 a(R)-a(r)
 =d\left[1+R+r+(R^2+Rr+r^2)/2\right]\ge \tfrac32 d rR
 \ge x R e^R.
\]
Choose any such saddle. Put \(q=xe^R/R\). Then \(q\le(3/2)d\), and the scaled variance \(v=F_2(R)/R^3\) satisfies
\[
 v=(1+x)(3/2+2/R+1/R^2)-q(1+1/R),
 \qquad 0.3s\le v<1.64.                                                \tag{3}
\]
For the upper bound use \(F_2\le A_2\).

Set \(L=\sqrt{R^3v}\), \(y=L\theta\), and
\[
 H=F(Re^{i\theta})-F(R)-in\theta .
\]
Up to the strictly positive factor \(n!e^{F(R)}R^{-n}/(\pi L)\), the coefficient in (1) is \(\int_0^{\pi L}\Re e^H\,dy\).

The following bounds give the core and intermediate tail:
\[
\begin{split}
 |\Im H|&\le 0.56 |y|^3,\\
 \Re H&\ge -y^2/2-0.07y^4,\\
 \Re H&\le -0.42 y^2\qquad (|\theta|\le \sqrt{s}/5).                  \tag{4}
\end{split}
\]
For verification, the linear imaginary term cancels exactly. Using \(|\sin t-t|\le |t|^3/6\), the coefficient bounding \(|\Im H|/|y|^3\) is at most
\[
 \frac{(4.5+4/R+1/R^2)/R+q(1+3/R+1/R^2)}{6\sqrt{R v^3}}
 \le \frac{2.13}{6\sqrt{15(0.3)^3}}<0.56.
\]
Here and below the absolute moments of the negative part \(xB\) can be bounded using those of \(x\exp(z)\). For the real part use \(0\le\cos t-1+t^2/2\le t^4/24\). Only the negative part costs anything in the lower bound; its fourth moment is at most
\[
 q R^5(1+6/R+7/R^2+1/R^3)<2.15 R^5.
\]
Thus its cost is at most \(2.15y^4/(24Rv^2)<0.07 y^4\), since \(Rv^2\ge 15(0.3)^2\). In the upper bound only \(A_4(R)\) costs anything. This is at most \(14.1R^3\), so the cost divided by \(y^2\) is at most \(14.1\theta^2/(24v)<0.08\) in the stated range.

For the exterior, put \(D_A=A(R)-\Re A(Re^{i\theta})\). On \([\sqrt{s}/5,\pi]\) one has \(D_A\ge R^2/4\):
* Up to \(\pi/3\), the cubic term alone is at least \((R^3/6)(1-\cos(3\sqrt{s}/5))\ge 0.029s R^3\), and \(Rs\ge15\).
* From \(\pi/3\) to \(5\pi/6\) the quadratic term supplies \(R^2/4\). From \(5\pi/6\) to \(\pi\) the cubic supplies \(R^3/6\).

In particular this deals with the lobes near \(2\pi/3\) without assuming cubic damping there. We have \(\Re H\le -D_A+2qR\le -R^2/20\) on this exterior. Its whole absolute contribution, in \(dy\), is less than \(1/50\): use
\[
 \pi\sqrt{1.64} R^{3/2} e^{-R^2/20}
 \le \pi\sqrt{1.64}\,15^{3/2} e^{-225/20}
 <312/(5/2)^{11}<1/50.
\]

Finally \(L\sqrt{s}/5>4/3\) by (3). On \([0,4/3]\) the cosine of the phase is nonnegative by (4). The integral on \([0,1]\) alone is at least
\[
 (1-0.56^2/2)\big(1-\tfrac{1}{6}-0.07/5\big)>2/3 .
\]
The intermediate tail past \(4/3\) has absolute integral at most
\[
 \frac{\exp(-0.42(4/3)^2)}{0.84(4/3)}<0.52.
\]
This leaves a positive margin greater than \(1/10\) in the scaled integral. This proves (1). For (2), \(c_-/c_*=(1-\delta)e^\delta\) with \(\delta=s/5\); the relative deficit is \(\int_0^\delta t e^t\,dt\).

### 2. A quantitative transition test

I give details of the larger-\(N\) certificate because there is a useful simplification for interlacing: **difference the two Cauchy integrands before doing the error estimate**. Then the tiny adjacent-row displacement does not require tiny relative error in either root location.

In this part put \(m=r^{1/3}\), \(h=1/m\), and assume \(h\le10^{-8}\). Use the *fixed* circle and scaling
\[
 R=r+1-h,\qquad \theta=h^4 y,\qquad
 \lambda=2bu/3,\qquad x=c_* r e^{-r}(1+\lambda h^2).
\]
We will only use \(-1/3\le u\le 13/5\), hence \(|\lambda|<2\). Retain the definition of \(H\) above with this new \(R,\theta\). Define
\[
 G=\exp\{-3y^2/4+i(y^3/4-(3/4+bu)y)\},\qquad
 J=\Re\int_0^\infty G\,dy,\qquad K=\Re\int_0^\infty (-iy)G\,dy.
\]
Use the following two exact integrals on \(0\le y\le\pi/h^4\):
\[
 J_n=\Re\int e^H\,dy,\qquad
 D_n=\Re\int e^H\,\frac{e^{-i\theta}-1}{h^4}\,dy.
\]
The signs of the two rows at the **same \(x\)** are the signs of \(J_n\) and \(J_n+h^4D_n\), respectively. Uniform bounds sufficient here are
\[
 \boxed{\quad |J_n-J|,\quad |D_n-K|,\quad
          |(\partial_u J_n)/b-K|\ \le 2000h .\quad}                    \tag{5}
\]

Here are derivation and constants for (5). With \(p=R/r=1+(1-h)h^3\) and \(g=(1+\lambda h^2)e^{-h}\), one has \(xe^R=(3/2)rg\). The first three moment enclosures are
\[
\begin{split}
 |h^4(F_1-n)+(3/4+bu)|&\le20h,\\
 |h^8 F_2-3/2|&\le20h,\\
 |h^{12}F_3+3/2|&\le20h.                                               \tag{6}
\end{split}
\]
For clarity, use \(0<g\le1\), \(|g-(1-h+(1/2+\lambda)h^2)|\le3h^3\) by Taylor's inequality, and \(x\le h^9\) by \(e^r\ge r^5/120\). For the first line, \(a(R)-a(r)\) differs from \((3/2)r^2(1-h)\) by at most \(5r\), \(x a(R)\le2\), and the term subtracted is \((3/2)r^2pg\). For the second, \(F_2\) differs from
\[
 (3/2)r^3[(1+x)p^3-p^2 g]
\]
by at most \(5r^2\), from the terms \((1+x)(2R^2+R)-(3/2)rgR\). The bracket differs from \(h\) by at most \(4h^2\), using \(1\le p\le1+h^3\). For the third, \(F_3\) differs from \(-(3/2)r^4 p^3 g\) by at most \(12r^3\), and \(|p^3g-1|\le3h\). These give (6).

The absolute fourth moment is at most
\[
 A_4(R)+xe^R(R^4+6R^3+7R^2+R)\le4 r^5,\qquad A_4(R)\le15r^3.
\]
Taylor's inequality in each Fourier mode therefore gives, with \(\log G\) denoting the displayed exponent,
\[
 |H-\log G|\le20h(y+y^2+y^3+y^4)\qquad(y\ge0).                       \tag{7}
\]
For \(\theta\le\sqrt h/5\), \(\Re H\le-y^2/2\). Indeed the upper real fourth-order cost is only \(A_4(R)\theta^4/24\), at most \((15/24)(\theta^2/h)y^2\), and the quadratic term is bounded by (6). For \(\theta\ge\sqrt h/5\) the same exterior argument as in part 1 gives \(\Re H\le -R^2/20\): replace \(s\) by \(h\) there and use \(Rh\ge15\), \(xe^R\le(3/2)R\).

For the derivative integral the extra multiplier is \(H_u=-x_u(B(Re^{i\theta})-B(R))\), with \(x_u=b r h^2 e^{-(r+1)}\). It satisfies
\[
 |H_u/b+iy|\le 4h(y+y^2),\qquad |H_u/b|\le 2y.
\]
In fact the scaled linear coefficient \(x_u h^4 B_1(R)/b\) is \(pe^{-h}-x_u h^4 A_1(R)/b\); the quadratic error costs at most \(x_u e^R(R^2+R)h^8y^2/(2b)\le h y^2\). For the difference integral the multiplier differs from \(-iy\) by at most \(h^4y^2/2\), and has modulus at most \(y\).

To see the slack in (5), on the inner arc multiply (7) by \(e^{-y^2/2}\) to bound \(|e^H-G|\), by interpolation along the straight segment between the exponents. Even with weight \(1+y\) the integral of this error is less than \(600h\), using the Gaussian moments up to degree five. The additional multiplier errors just given integrate to less than \(20h\). The exterior contributions for \(e^H\), including weights \(1\) or \(2y\), are at most \((1+4m^4)^3e^{-m^6/20}<h\) (use \(e^t\ge t^4/24\)). The omitted Gaussian tails, with weights \(1\) or \(y\), start past \(y=m\) and are less than \(2e^{-m^2/2}<h\). This proves (5).

### 3. Signs for the fixed limiting integrals

The required signs, with margins, are
\[
\begin{array}{ll}
 J>1/216 &(-1/3\le u\le2),\\
 J<-1/270 &(u=5/2),\\
 K<-1/216 &(2\le u\le13/5).
\end{array}                                                            \tag{8}
\]
Here is one verification that needs neither tabulated Airy zeros nor oscillatory numerical integration. Write
\[
 J=\frac{e^{-1/4-bu}}{b} H_0 f(u),\qquad
 K=\frac{e^{-1/4-bu}}{b} H_0\big(f'(u)/b-f(u)\big).
\]
These formulas follow by setting \(t=b(y+i)\) in the cubic exponential and using \(J'=bK\). More explicitly, \(H_0 f(u)\) is the real part of the integral of \(\exp(i(t^3/3-ut))\,dt\) on the horizontal ray starting at \(ib\). Integration by parts gives \(f''=-u f\) (the endpoint term has zero real part after division by \(i\)). Normalizing \(f(0)=1\), one obtains
\[
 H_0=(\sqrt3/2) I_0,\qquad f'(0)=I_1/I_0,\qquad
 I_j=\int_0^\infty v^j e^{-v^3/3}\,dv .
\]
For these initial data one can deform to the ray from \(0\) at angle \(\pi/6\); the connector on the imaginary axis has zero real part for both initial data. Now \(H_0>1/2\) by integration up to \(1\), and
\[
 1/3<f'(0)\le1 .
\]
Indeed \(I_3=I_0\) by parts, giving the upper bound by the power mean inequality. Also \(I_2=1\), \(I_1 I_3\ge I_2^2\), and \(I_0\le 1+e^{-1/3}<\sqrt3\) by bounding the tail beyond \(1\) with the \(v^2\)-weighted tail.

For reproducibility the only endpoint inequalities on this ODE needed are
\[
\begin{array}{c|cc}
 u & f(u) & f'(u)\\ \hline
 2 & >1/4 & <-1\\
 5/2 & <-1/5 & \\
 13/5 & (-3/4,0) & <-1 .
\end{array}
\]
One rational-arithmetic rule to verify the table is as follows. For each initial slope \(k=1/3,1\) add the series with starting monomials \(1,ku\); replace each monomial \(a u^\ell\) successively by \(-a u^{\ell+3}/((\ell+3)(\ell+2))\). Upper-bound each series by summing terms numbered \(0,\ldots,8\) and lower-bound by summing \(0,\ldots,9\); for the derivative do the same after differentiating the terms. These are alternating bounds since the magnitudes decrease past term 8, including after differentiation. The inequalities in the table hold with these bounds, and linearity fills the slope interval.

On \([-1/3,0]\), the series starting at \(1\) is at least \(1\), and the other has magnitude at most \((1/3)/(1-1/324)\). On \([0,2]\), \(f\) cannot have two zeros: multiplying the ODE by \(f\) between consecutive zeros and using the Dirichlet Poincaré inequality gives spacing at least \(\pi/\sqrt{2}\). Thus it is positive by its endpoint values and simplicity of ODE zeros, and concavity gives \(f>1/4\). On \([2,13/5]\) the same spacing argument with \(\pi/\sqrt{13/5}\) gives exactly one zero by the endpoint signs. Hence \(f''\) changes from negative to positive, and the maximum of \(f'\) is at an endpoint. It follows that \(f'<-1\) and \(f>-3/4\) except that the latter bound can equally be used non-strictly. In particular \(f'/b-f<-1/4\). The common positive prefactor in \(J,K\) is greater than \(1/54\) throughout (use \(b<1,\ 1/4+bu<3,\ e<3\)). This proves (8).

### 4. Joining the certificates and comparing rows

There is no gap from the real-saddle range to the transition test: at \(c=c_-(r)\) the coordinate is \(u\ge-1/3\) by (2), since
\[
 \frac{3}{2b}\,\frac{e^{1/5}15^{2/3}}{50}<1/3 .
\]
Now \(2000h\le 0.00002\). Equations (5) and (8) show strict positivity up to \(u=2\), a negative sign at \(5/2\), and strict decrease of the **normalized** integral \(J_n\) on \([2,13/5]\). Thus there is a unique, simple first zero in \((2,5/2)\). At this zero \(D_n<0\), so the next row is strictly negative.

For the count in the next row, its coordinate at the first row's zero is still less than \(13/5\). Indeed if \(r'=r+\Delta\) is the next radius then \(0<\Delta\le2/(3r^2)\). Its coordinate \(u'\) satisfies
\[
 u'\le (1+\Delta/r)\left[u(1+2\Delta)+\frac{3}{b}m^2\Delta\right]
 < 5/2+0.01 ,
\]
using \(e^\Delta\le1+2\Delta\) in the change of coordinates. Hence the positivity and strict-decrease tests for the next row account for every zero between this point and \(0\), proving the asserted ordering.

For sharpening or interval bridging, the exact sign tests behind the large \(N\) are just \(J_n>0\) from the one-sided cutoff to the left bracket, \(J_n<0\) at the right bracket, and \(\partial_u J_n,D_n<0\) across the bracket (extend the monotonicity bracket for the next-row count). They can be enclosed directly on boxes in \(h,u,y\) instead of using the loose \(2000h\) comparison. In particular the difference multiplier should be evaluated as \(-iy\int_0^1 e^{-it\theta}\,dt\), or by its Taylor enclosure, **not** by subtracting two interval-enclosed row coefficients. The uniform all-row claim here is (1); the transition tests outside the stated large-\(N\) range have not been assumed to pass.
