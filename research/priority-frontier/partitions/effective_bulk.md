# A two-thirds real-root bound in every threshold-four row

Let \(P_n(t)=n![z^n]\exp(A(z)+tB(z))\), with \(A(z)=z+z^2/2+z^3/6\), \(B=e^z-1-A\), and \(m=\lfloor n/4\rfloor\). For **every \(n\)** at least \(\lceil 2m/3\rceil\) zeros of \(P_n\) are distinct, simple and negative. For \(n\ge2000\) these roots are certified on a single explicit middle interval. Every complete phase cell there contains exactly one simple root. The roots of consecutive rows strictly alternate in the intersection of their middle intervals, apart from the freedom about which row supplies the first and last root. For \(n\le2004\) the [existing finite certificates](../../../snapshot/research/partitions/four_row_window.md) give the full row.

Here are the saddle and the interval. Write \(u=1/n,\ D=z\,d/dz,\ h=DA,\ H=DB\). For \(1/4\le R\le13\), put \(z=Re^{iq}\) and choose the continuous upper solution of
\[
    \tau=(uh(z)-1)/H(z)>0,\quad 0<q<\pi/2
\]
specified by the certified tube below. The middle interval in \(t=-n\tau\) runs from \(R=1/4\) to \(R=13\) in increasing order. Set
\[
 f(v)=uA(Re^{iv})-\tau B(Re^{iv})-iv,\quad C=uD^2A(z)-\tau D^2 B(z),
 \quad \Psi=n\Im f(q),\qquad G=\Psi-\tfrac12\arg C.
\]
Take the argument in \((-\pi/2,\pi/2)\). A complete phase cell is the portion of the interval between successive integer multiples of \(\pi\) in \(\Psi\).

## Three sign tests at the true saddle

All integrals in this section are upper-semicircle integrals \(\int_0^\pi e^{nf(v)} V(v)\,dv\), followed by taking the real part. Conjugation gives the full coefficient integral up to a positive scalar when \(V\) is one of the stated insertions. Normalize them by the positive number \(e^{n\Re f(q)}\sqrt{2\pi/(n|C|)}\).

For \(V=1\), the normalized integral differs from \(\cos G\) by less than \(1/2\). For \(V(v)=(e^{\pm iv}-\cos q)/\sin q\), the respective normalized integrals differ from \(\mp\sin G\) by less than \(4/5\). For the derivative test let
\[
 J(z')=\tau[B(z')-\lambda DB(z')]+\lambda u DA(z'),\qquad
 \lambda=1/4\ (R\le4),\qquad \lambda=1/(4+R)\ (R>4).
\]
Use \(V(v)=[J(Re^{iv})-\Re J(z)]/\Im J(z)\). Its normalized integral differs from \(-\sin G\) by less than \(4/5\). The denominator is positive: at the saddle, \(uh-\tau H=1\), so that \(\Im J(z)=\tau\Im B(z)>0\). Integration of the angular derivative around the closed contour gives the exact identity \(I[uh-\tau H]=I[1]\), with \(I\) denoting the full coefficient integral. Thus at a zero of \(P_n\) the real derivative in \(\tau\) has the sign opposite to the \(J\) test. The two fixed-angle shifts at such a zero give the actual signs of rows \(n-1,n+1\) up to positive factors. No derivative of the chosen radius is taken in a coefficient integral.

Here and below the rigorous numerical inequalities are implemented in [check_effective_bulk.py](check_effective_bulk.py). The verification works on the continuous parameter rectangle \(R\in[1/4,13],\ v_0=2000/n\in[0,1]\). Endpoints at \(v_0=0\) are used to close the parameter bounds.

First construct a continuous reference angle \(Q(R,v_0)\) by bilinear interpolation on radius nodes \(1/4,1/2,1,2,\ldots,13\) and at \(v_0=0,1\). Its vertex ordinates are binary numbers approximating the smallest positive zero in angle of \(\Im[(1-uh)\overline H]\); their status as approximations is immaterial. On each accepted parameter box Arb proves that this expression has opposite strict signs at \(Q-0.012,Q+0.012\), in that order. It also proves
\[
 -\Re\!\left(\frac{D H(1-uh)+uH\,D h}{(1-uh)^2}\right)>0
\]
on a common tube containing both endpoints. This is the negative angular derivative of \(\Im(H/(1-uh))\). The tests thus select the unique root in the continuous tube, consistently over shared boundaries. Two one-sided interval bisections sharpen its enclosure. The certificate tests \(\tau>0,\ \Re C>0,\ \Re(H/C)<0,\ \Im J(z)>0\). The implicit saddle equation gives \(d\log z/d\tau=H/C\) for fixed \(u\), so \(R\) increases as \(\tau\) decreases. Since \(\Psi=n\Im[uA(z)-\tau B(z)-\log z]\), stationarity gives \(d\Psi/d\tau=-n\Im B(z)<0\). The phase is strictly increasing in \(R\).

## Integral bounds on a parameter box

Take \(\eta=\min(0.116,0.54/R_{\max})\) in a box, using the binary floating-point value as the exact positive width in the subsequent interval calculations. All three tests use the same estimates. For \(|d|\le\eta\) the certificate obtains positive \(\kappa\) and finite \(M,S\) such that
\[
 \Re[-f''(q+d)]\ge\kappa,\qquad |f'''(q+d)|\le M,\qquad
 |V'(q+d)|\le S .
\]
Eight interval subdivisions suffice. For the last inequality one may take the maximum of \(1/\sin q\) and \(\sup|DJ|/\Im J(z)\). Also \(|V(q)|=1\) for each insertion. Put \(D_n=\sqrt{n|C|/(2\pi)}\). In peak units the scalar core error on replacing \(e^{n[f(q+d)-f(q)]}\) by \(e^{-nCd^2/2}\) is at most
\[
 D_n\frac{4M}{6n\kappa^2}.
\]
Indeed the pointwise error is at most \(nM|d|^3 e^{-n\kappa d^2/2}/6\). For a varying insertion, compare it first to its central value within the true integral; this costs at most \(D_n\,2S/(n\kappa)\). The omitted Gaussian extension costs at most \(D_n\,2e^{-n\kappa\eta^2/2}/(n\kappa\eta)\).

On either side of the core the verifier may extend the interval by contiguous radial-in-angle steps where \(\Re f(q+d)\) is certified monotone outward decreasing, using the sign of \(\Im(u DA-\tau DB)\). Throughout those steps the loss is at least \(\kappa\eta^2/2\). On the rest of the upper semicircle adaptive interval bisection proves \(\Re[f(q)-f(q+d)]>1/200\). Thus the remaining true tail costs at most \(D_n\pi U e^{-n\gamma}\), where \(\gamma=\min(1/200,\kappa\eta^2/2)\), \(U=1\) for the scalar test and \(U\ge\sup|V|\) otherwise. For the shifts use \(U=2/\sin q\). For \(J\) take the sum of the absolute-coefficient bounds for \(\tau(B-\lambda DB),\lambda u h\) and \(|\Re J(z)|\), then divide by \(\Im J(z)\). When \(\lambda=1/4\), all coefficients of \(B-DB/4\) are nonpositive, so its exact absolute-coefficient majorant is \(|B(R)-DB(R)/4|\). The zeros of its leading coefficient cause no difficulty. On each box the estimates decrease as functions of \(n\) above the least allowed value, using \(n\gamma>1\) for the exponential tails. The three inequalities follow by summing the core, Gaussian-extension and actual-tail bounds. The angular Gaussian contributes \(e^{-i\arg C/2}\), giving exactly the phases claimed above.

For \(R\le4\) the verifier divides \(D^kB(Re^{iv})\) by \(R^4/24\) before interval evaluation. The terms of index \(0\) through \(31\) after this division are evaluated by Horner's rule and multiplied by \(e^{4iv}\). For \(k\le3\) and for \(B-DB/4,D(B-DB/4)\) the absolute tail is bounded by \(2\cdot24\cdot4^{32}36^3/36!<10^{-13}\). For \(R>4\) a positive factor \(e^{-R_{\rm mid}}\) is used instead, with elementary polynomial and exponential evaluations. The tested \(\tau\) carries the reciprocal compensation, so all products \(\tau D^kB\) are invariant under these numerical rescalings.

## Root count and interlacing

At \(\Psi=a\pi\), the main cosine has sign \((-1)^a\) and magnitude greater than \(1/\sqrt2\) because \(\Re C>0\). Whenever \(P_n(-n\tau)=0\) in the succeeding phase cell, \(|\cos G|<1/2\). Since \(|G-\Psi|<\pi/4\), the sign of \(\sin G\) is \((-1)^a\) and \(|\sin G|>\sqrt3/2\). The derivative test is therefore nonzero and has the same sign at every root in that cell. The opposite endpoint signs force a root; two consecutive simple real roots would have opposite derivative signs. This proves existence and uniqueness on each complete cell. The same reasoning gives simplicity at roots in a partially covered boundary cell, with at most one root there.

In a fixed row every pair of consecutive roots in the middle interval has opposite signs of \(\sin G\), since it meets the ordered phase cells with exactly one root in each complete cell. The forward and backward shift tests force an intervening root of each neighboring row. Applied in both directions to neighboring rows in the intersection of their certified intervals, this gives strict alternation there. Endpoint cells cannot insert an extra root because all cells strictly between them are complete.

At \(R=1/4\) the certificate proves \(1+4\Psi/(n\pi)<0.013\); at \(R=13\) it proves \(1+4\Psi/(n\pi)>0.685\). Thus the number of complete cells exceeds \(0.672\,n/4-2\). For \(n\ge2000\), this is at least \(2\lfloor n/4\rfloor/3\). The rank ordering here concerns the negative real axis in the stated middle interval. The effective full-row bridge also requires treating the roots between this interval and each extreme.

## Joining the middle interval to minus infinity

For every \(n\ge2000\), the same sign and simplicity tests hold from \(R=250/n\) through \(R=13\). This overlaps the fourth and fifth roots of the [effective outer windows](../../../snapshot/research/partitions/effective_outer.md) for every row. In particular, **every real zero from minus infinity to \(t(13)\) is simple**, and after the fifth root the phase gives the absolute real rank. If \(n=4m+s\), the \(k\)-th negative real root from the left lies in
\[
       (k-1)\pi < \Psi+m\pi < k\pi
\]
whenever \(k\ge5\) and \(k\le\lfloor0.685m-0.315s/4\rfloor\). Consecutive rows strictly alternate on their common half-line ending at the earlier of their two \(t(13)\) values. This removes the gap between the effective outer and middle arguments. The unresolved part of the real-root count is on the side towards zero.

For \(0\le R\le1/4\) set \(B_0(v)=24B(Re^{iv})/R^4\), \(H_0(v)=24H(Re^{iv})/R^4\), and \(t_0=\tau R^4/24\); the normalized functions at zero are defined by continuation. Here \(nR\ge250\) is required when applying the inequalities to a row. The same predictor tube and core estimates work on the closed auxiliary parameter rectangle including \(R=0\). For the derivative insertion use \(J/R\) in place of \(J\); its normalized value is unchanged. The factors \((B_0-H_0/4)/R,\ (D B_0-D H_0/4)/R\), written with \(D\) acting on the original angular functions before division by radius powers, have convergent series at zero because the degree-four term cancels. The same holds for \(A/R\) and \(h/R\).

Besides the primary core \(|v-q|\le\eta\) there is a secondary core with \(|v-q-\pi/2|\le\eta\). For \(\psi\) in the primary core the verifier proves
\[
                  \Re[f(\psi)-f(\psi+\pi/2)]>R/25
                  \qquad (R>0).
\]
It tests the quotient by \(R\) without dividing by a parameter interval containing zero. With \(z=Re^{i\psi}\), that quotient is the real part of
\[
 u e^{i\psi}\!\left[(1-i)+(1-i^2)z/2+(1-i^3)z^2/6\right]
 +t_0 e^{5i\psi}\sum_{k\ge1}\frac{24(i^k-1)}{(k+4)!}z^{k-1}.
\]
The secondary core therefore costs at most \(Ue^{-250/25}\sqrt{|C|/\kappa}\) in normalized peak units. This estimate retains its Gaussian width, uniformly up to \(n=\infty\). Outside both cores the original remote tests apply. The resulting scalar and insertion errors still satisfy \(1/2\) and \(4/5\).

It remains to match the count. On this small-radius branch \(0.21<t_0<0.29\). At physical argument \(-n\tau\) define the reciprocal coordinate \(X>0\) by \(n\tau=(24/625)m^5/(4X^4)\). Then
\[
 \frac{X}{nR}=\frac{[(1-su)/4]^{5/4}}{5\sqrt2\,t_0^{1/4}} .
\]
At \(R=250/n\) this gives \(X<9.3\); at \(R=1/4\) it gives \(X>16.9\). The first endpoint is below the left endpoint of every fourth-root window and the second exceeds the right endpoint of every fifth-root window, for each residue. The monotonicity of \(-\tau\) gives the required overlap.

For the absolute labels the additional bound checked on this same rectangle is
\[
             0.97 < \frac{\Psi+n\pi/4}{X} < 1.04 .                    \tag{*}
\]
To evaluate it also at \(R=0\), let \(h_1(z)=6H(z)/z^4\). The argument equation gives
\(4q=\pi-\Im\log h_1(z)+\Im\log(1-uh(z))\).
Both logarithms use their analytic branches from one, with the integer fixed at \(R=0\). Hence \((\Psi/n+\pi/4)/R\) equals
\[
 u\,\Im [A(z)/R]-\Im[J(z)/R]+
       \tfrac14\,\Im\!\left[\frac{\log h_1(z)-\log(1-uh(z))}{R}\right] .
\]
Each logarithmic quotient is evaluated by factoring out its argument minus one and using the convergent series of \(\log(1+v)/v\), with absolute remainder at most \(|v|^{10}/[11(1-|v|)]\).

The four fifth-root windows in \(X\) are respectively \((13.74,14.30),(14.52,15.08),(15.31,15.87),(16.09,16.65)\). Inequality (*) places the fifth root strictly in \(4\pi<\Psi+m\pi<5\pi\) in each case, after subtracting \(s\pi/4\). The earlier theorem counts that root in complex modulus. The one-root-per-cell test now supplies all subsequent real indices in order until \(R=13\), including uniqueness in a partial final cell. The upper endpoint phase bound gives the stated run of complete indexed cells. For adjacent rows, changing \(m\) by one rescales \(X\) at fixed physical \(t\) by at most \((501/500)^{5/4}\). Even after this factor, both fourth-root lower endpoints exceed both small-radius cuts \(X<9.3\); both fourth and fifth roots are inside the new tested intervals. The existing strict alternation of the first five roots and the two signed one-row insertions thus give strict alternation over the entire common half-line.

With python-flint 0.9.0 the combined verifier uses 3,272 accepted boxes for \(1/4\le R\le13\), and eight more for the small-radius extension.

## The exact branch extending to the double saddle

For the remaining interval the exact stationary equation has a real two-parameter solution without root finding in the complex plane. Write \(z=a+iy,\ a\ge12,\ 0<y<\pi\), and put
\[
 s_0=\sin(y)/y,\qquad c=y\cot y,\qquad K=1+2a+(3a^2-y^2)/2,
 \quad d=\frac{\cos y+a s_0}{K},\qquad \beta=d-e^{-a},\quad Q=s_0-(1+a)d .
\]
On the branch \(\beta>0\), define
\[
 \Lambda=\beta^{-1},\qquad x=\Lambda e^{-a},\qquad
 n=\frac{(a^2+y^2)Q}{\beta}
   = (a^2+y^2)
      \frac{1+a+(a^2-y^2)/2-(1+a)c}{a+c-e^{-a}K/s_0}.                \tag{6}
\]
Then \(E(z)=A(z)-xB(z)-n\log z\) has \(E'(z)=0\), and these formulas are necessary at every stationary point in this strip. Indeed the imaginary part of \((1+x)A'(z)-\Lambda e^{iy}-n/z=0\), divided by \(y\), gives \(n/(a^2+y^2)=\Lambda s_0-(1+x)(1+a)\). Substituting in the real part gives \(\Lambda(\cos y+a s_0)=(1+x)K\). Solving yields (6), including \(Q>0\).

For each \(a\ge12\) there is a unique \(y_\infty(a)\in(0,\pi)\) such that \(\beta>0\) precisely on \(0\le y<y_\infty(a)\). On that interval \(n(a,y)\) increases strictly from
\[
       n_{\rm fold}(a)=\frac{a^4}{2[a+1-e^{-a}(1+2a+3a^2/2)]}
\]
to infinity. To see this, \(c'\le-2y/3\) and \(1-c\ge y^2/3\) by the partial fraction expansion of \(y\cot y\), or its power series with strictly negative nonconstant coefficients. Therefore
\[
 (K/s_0)'=\frac{-y+K(1-c)/y}{s_0}>0 .
\]
The denominator of (6) decreases from a positive number to a negative value before \(\pi\), while the numerator factor \(1+a+(a^2-y^2)/2-(1+a)c\) increases from \(a^2/2\). The function \(n_{\rm fold}(a)\) also increases strictly for \(a\ge12\): for \(J=1+2a+3a^2/2\) the sign of its derivative is that of \(3a+4-e^{-a}[(4+a)J-aJ']>0\). Thus for \(n\ge2000\) there is one branch \(y(a)>0\) from \(a=12\) up to the unique \(a_{\rm fold}\) satisfying \(n_{\rm fold}(a)=n\), where \(y=0\). Moreover, \(\Im H=e^a y(\cos y+a s_0-e^{-a}K)>0\) on the open branch. For fixed \(n\) write \(X(z)=(h(z)-n)/H(z)\). The identity
\[
     \Im X(a+iy)=\frac{\Im H}{|H|^2}\,[n-n(a,y)]
\]
shows at a real saddle that \(\Re X'(z)=\partial_y\Im X<0\). Hence \(dx/da=|X'|^2/\Re X'<0\) along this entire branch. At the previously certified \(R=13\) endpoint, \(a>12,\ 0<y<\pi\) (the same angle tube gives \(0<q<0.24\) there). The saddle is therefore on this unique continuation. At the endpoint \(y=0\) it merges with its conjugate at the exact double saddle.

The real part on the vertical line through \(a\) admits an exact global curvature estimate on this branch. For real \(v\), \(s=v^2\),
\[
    \mathcal F(s)=\Re E(a+iv)
       =\mathrm{constant}-(1+x)(1+a)s/2-\Lambda\cos\sqrt{s}
                         -(n/2)\log(a^2+s).
\]
For \(0\le v\le\pi\),
\[
 \frac{d^2}{ds^2}\cos\sqrt{s}
   =\frac{\sin(v)/v-\cos v}{4v^2}\ \ge\ \frac1{4\pi^2}.
\]
Indeed the ratio in the numerator divided by \(v^2\) is \(\int_0^1 t^2\sin(tv)/(tv)\,dt\), nonincreasing up to \(\pi\) and equal to \(1/\pi^2\) there. At the stationary parameters, \(0<Q\le1\), and therefore
\[
 \frac{n}{2\Lambda(a^2+s)^2}\le\frac{a^2+\pi^2}{2a^4}
 \le\frac{12^2+\pi^2}{2\cdot12^4}<0.00372 .
\]
It follows that \(\mathcal F''(s)<-0.0215\Lambda\) on \([0,\pi^2]\). The unique maximum there is \(s=y^2\), with
\[
 \mathcal F(v^2)-\mathcal F(y^2)
          \le -0.01075\Lambda(v^2-y^2)^2 .
\]
For \(v>\pi\), reflecting \(v\) modulo \(2\pi\) into \([0,\pi]\) preserves \(\cos v\) and strictly increases the other two terms of \(\mathcal F\). Thus the whole vertical line has exactly the two global maxima \(a\pm iy\). At the fold the same inequality gives quartic decay at its unique maximum.

On a complex displacement \(b\) from the upper saddle the normalized full phase is also exact:
\[
 \frac{E(z+b)-E(z)}{\Lambda}
   =d[(1+z)b^2/2+b^3/6]
     -e^{iy}(e^b-1-b)
     -(a^2+y^2)Q[\log(1+b/z)-b/z].
                                                                    \tag{7}
\]
In particular \(e^{-a}\) cancels from this shape function. The exponential rate is solely the positive prefactor \(\Lambda\). The curvature estimate supplies localization and the stationary branch supplies the continuous action. [The all-row proof](all_rows_four.md) controls the oscillatory integral at integer action levels on a deformed vertical segment and bounds the contribution from its closing arc.
