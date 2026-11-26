The theorem survives. The fixed-parameter one- and two-saddle arguments suffice for the stated limit: the first gives a zero-free interval bounded away from the transition, and the second gives arbitrarily many sign changes just above it. Neither estimate needs to be uniform up to saddle coalescence for that conclusion.

There is also a sharper result. Set
\[
a=\frac32,\qquad c_*=\frac{a}{e},\qquad \alpha=(a/2)^{1/3}=(3/4)^{1/3},
\]
and let \(0<b_1<b_2<\cdots\) be the positive solutions of \(\operatorname{Ai}(-b)=0\). For each fixed \(k\), the first \(k\) real zeros in the ordering of the question exist and are simple for all sufficiently large \(n\), and
\[
\boxed{\displaystyle
\frac{x_{(n,k)}}{r e^{-r}}
=c_*+\frac{\alpha}{e}\,b_k\,r^{-2/3}+O_k(r^{-1}).
}
\]
The indexing here is part of the result: there are no additional smaller positive \(x\) with \(P_n(-x)=0\). Its proof needs two different uniform estimates.

## Integral estimates and audit of the proposed proof

Use the normalization
\[
H_n(c)=r^n e^{-A(r)}\,\frac{P_n(-c r e^{-r})}{n!}.
\]
For \(R=r+u,\ z=R e^{iv/R}\), write
\[
H_n(c)=\frac{1}{2\pi R}\int_{-\pi R}^{\pi R}e^{E(v)}\,dv,\qquad
E(v)=A(z)-A(r)-n\big(\log(R/r)+iv/R\big)-c r e^{-r}B(z).
\]
The proposed expansion is correct, also for bounded complex \(c\):
\[
E(v)=rS_c(w)+T(v)+O(r^{-1}),\qquad
S_c(w)=\frac a2 w^2-c e^w,\qquad
T(v)=w^2-\frac{v^2}{2}S'_c(w),\qquad w=u+iv. \tag{1}
\]
The error is uniform for \(|u|\le U,\ |c|\le C,\ |v|\le M\) with fixed bounds. Indeed, \(n=r+r^2+r^3/2\), so for bounded \(h=z-r\),
\[
A(r+h)-A(r)-n\log(1+h/r)=(3r/4+1)h^2+O(r^{-1}).
\]
Here the cubic coefficient is \(O(r^{-1})\), not of constant order. Also \(cr e^{-r}B(r+h)=cr e^h+O(r^4e^{-r})\). Inserting \(h=w-v^2/(2r)+O(r^{-2})\) gives (1).

A useful form of the tail estimate is that for any \(D>0\) one can choose \(M=M(U,C,D)\) so that
\[
\int_{M<|v|\le\pi R}|e^{E(v)}|\,dv=O_{U,C,D}(e^{-Dr}). \tag{2}
\]
In fact, \(A(R)-A(r)-n\log(R/r)=O_U(r)\) and \(|cr e^{-r}B(z)|=O_{U,C}(r)\). For \(|v/R|\le\delta\) with fixed small \(\delta\), the cubic monomial gives \(A(R)-\Re A(z)\ge c_1 r v^2\). For \(\delta\le |v/R|\le\pi\), the quadratic and cubic monomials together give a lower bound \(c_2r^2\), since \(1-\cos(2\theta)\) and \(1-\cos(3\theta)\) have no common zero there. These bounds absorb the \(O(r)\) integration length and give (2).

For the proposed above-transition argument, on a fixed compact interval of sufficiently small **positive** \(y\), the two maxima are indeed the only ones. The derivative of \(\Re S_c(u+iv)\) is \(a((y/\sin y)\sin v-v)\), and at \(w=u+iy\) one has \(S'_c(w)=0\) and \(\Re S''_c(w)=a(1-u)>0\). Thus the local Gaussian amplitudes are nonzero conjugates, with the square root branch specified in the question. The strict gap off the two neighborhoods on bounded \(v\), followed by (2), gives the claimed uniform cosine formula. Since \(d\,\Im S_c(w)/dc=-e^u\sin y\) is bounded away from zero on such an interval, evaluating at successive integer multiples of \(\pi\) in the total phase gives the sign changes claimed. Together with the below-transition positivity on each \([0,c_0]\), \(c_0<c_*\), this proves the original ratio limit. It does not count the roots in the coalescence region; in particular the cosine error on those fixed intervals gives no simplicity assertion there.

## Subcritical estimate when the Airy parameter diverges

For \(0\le c<c_*\), take \(u\in[0,1)\) with \(c=a u e^{-u}\), and put \(d=1-u\). Then, uniformly for \(r d^3\ge 1\),
\[
H_n(c)=
\frac{e^{r S_c(u)+u^2}}{(r+u)\sqrt{2\pi a r d}}\,
\left(1+O\big((r d^3)^{-1/2}\big)\right). \tag{3}
\]
The implied constant is independent of \(n,c\). Thus the estimate gives positivity when \(rd^3\) exceeds a sufficiently large absolute constant; it is not used to infer positivity at \(rd^3\) of order one.

To prove (3), let \(Z=r(S_c(u+iv)-S_c(u))\) and \(W=-a r d v^2/2\). The saddle equation gives
\[
\Re Z=r\big(-a v^2/2+a u(1-\cos v)\big)\le W .
\]
On \(|v|\le M\), Taylor's formula gives \(|Z-W|\le C_M r|v|^3\), so that \(|e^Z-e^W|\le C_M r|v|^3 e^W\) by interpolation along the segment from \(W\) to \(Z\). Also \(T(0)=u^2\) and the exponential of \(T(v)-u^2+O(r^{-1})\) differs from 1 by \(O_M(|v|+r^{-1})\). Consequently the relative integrated error against the leading Gaussian is
\[
O_M\!\left(r(rd)^{-3/2}+(rd)^{-1/2}+r^{-1}\right)
=O_M\big((rd^3)^{-1/2}\big).
\]
Here \(M\) can be fixed using (2) with \(D>\sup_{0\le c<c_*}|S_c(u)|+1\); the omitted Gaussian tail is negligible as well since \(rd\ge r^{2/3}\). This proves (3), including the normalization.

The link to the transition coordinate is exact up to simple uniform bounds:
\[
c_*-c=c_*\big(1-(1-d)e^d\big)=c_*\int_0^d h e^h\,dh,\qquad
\frac{c_*}{2}d^2\le c_*-c\le\frac{e c_*}{2}d^2. \tag{4}
\]
In particular, \(r^{2/3}(c_*-c)\to+\infty\) is precisely the subcritical zone \(rd^3\to\infty\). More usefully for counting, (3)–(4) give positivity on the *whole* range \(0\le c\le c_*-L r^{-2/3}\) for a sufficiently large fixed \(L\) and all large \(n\).

## A compact-window Airy lemma

Write
\[
c=c_r(s)=c_*+\frac{\alpha}{e}r^{-2/3}s,\qquad
u_n=1-\frac{1}{\alpha r^{1/3}},\qquad R_n=r+u_n.
\]
Then the entire function
\[
F_n(s)=R_n\alpha r^{1/3}\exp\{-rS_{c_r(s)}(1)-1\}\, H_n(c_r(s))
\]
satisfies, for every fixed \(L<\infty\) and integer \(j\ge0\),
\[
\sup_{|s|\le L}
\left|\frac{d^j}{ds^j}\big(F_n(s)-\operatorname{Ai}(-s)\big)\right|
=O_{L,j}(r^{-1/3}). \tag{5}
\]
The disk in (5) is complex. For real \(s\) the normalization multiplying \(H_n\) is positive.

**Proof.** The inward shift in \(u_n\) makes the Airy integral absolutely convergent, and gives a Gaussian majorant even for complex \(s\) in a fixed disk. Put
\[
\tau=\alpha r^{1/3}v,\qquad \eta=-1+i\tau,\qquad w=1+\frac{\eta}{\alpha r^{1/3}}.
\]
At \(c=c_*\) both \(S'_{c_*}(1)\) and \(S''_{c_*}(1)\) vanish, while \(S'''_{c_*}(1)=-a\). For \(|v|\le M,\ |s|\le L\), Taylor's formula and (1) give
\[
E(v)-rS_c(1)-1
=-s\eta-\frac{\eta^3}{3}
+O_{M,L}\!\left(r^{-1/3}(1+|\tau|^4)\right). \tag{6}
\]
In detail, the linear unfolding comes from \(-r(c-c_*)e(e^{w-1}-1)\), and the cubic coefficient uses \(\alpha^3=a/2\). The constant \(1\) subtracted on the left is the limiting value of \(T\); on this interval \(T(v)-1=O_{M,L}(r^{-1/3}(1+|\tau|))\).

For uniform integration, the polynomial error in (6) alone is not a majorant. Instead, on the chosen circle use
\[
\Re\big(S_c(u_n+iv)-S_c(u_n)\big)
\le -\tfrac12(a-e^{u_n}\Re c)v^2+e^{u_n}|\Im c|\,|v|.
\]
Here \(\Re c>0\) for large \(r\), and
\[
a-e^{u_n}\Re c\ \ge\ \frac{a}{2\alpha r^{1/3}}
\]
uniformly on the disk for large \(r\). Also \(r(S_c(u_n)-S_c(1))=O_L(1)\). Thus the real part of the left side of (6) is at most \(C_{M,L}-\kappa\tau^2\) with an absolute \(\kappa>0\), for instance \(\kappa=1/4\). The same bound holds for \(-s\eta-\eta^3/3\). The inequality
\[
|e^p-e^q|\le |p-q|\max(e^{\Re p},e^{\Re q})
\]
now makes the integrated difference of the two exponentials \(O_{M,L}(r^{-1/3})\) in \(d\tau\). The exact tail outside \(|v|\le M\) is negligible after normalization by (2) with \(D\) sufficiently large. The limiting Gaussian-damped tail outside \(|\tau|\le M\alpha r^{1/3}\) is negligible too.

Including the integral prefactor, the leading expression for \(F_n\) is therefore
\[
\frac{1}{2\pi}\int_{\mathbb R}\exp\{-s\eta-\eta^3/3\}\,d\tau
=\operatorname{Ai}(-s).
\]
Indeed, upon reversing \(\tau\) this is the vertical-line formula
\[
\operatorname{Ai}(x)=\frac1{2\pi}\int_{\mathbb R}
\exp\big((b+it)^3/3-x(b+it)\big)\,dt,\qquad b>0,
\]
with \(b=1\); the formula is independent of \(b>0\) by contour displacement and Gaussian decay. This proves (5) for \(j=0\), and Cauchy's formula on a larger disk gives it for each fixed \(j\). \(\square\)

## Counting and indexing

For clarity, the Airy facts needed for this step follow from the same integral. Its real solution \(f(x)=\operatorname{Ai}(x)\) satisfies \(f''=xf\) by integration by parts. Taking \(b=\sqrt{x}\) and applying Gaussian rescaling gives
\[
f(x)\sim \frac{e^{-2x^{3/2}/3}}{2\sqrt{\pi}\,x^{1/4}}\qquad(x\to+\infty).
\]
There can be no last zero at \(x\ge0\): to its right the solution would be positive and convex, incompatible with starting at zero and tending to zero. All real zeros are simple by ODE uniqueness. And \(g(s)=f(-s)\) has infinitely many positive zeros: if, up to sign, it were eventually positive, then \(g''=-sg<0\) would force it to cross zero once \(g'\) became negative, while \(g'\ge0\) forever is impossible since then \(g\) is bounded below by a positive constant. This justifies the ordering \(b_1,b_2,\dots\).

Now take \(T\in(b_k,b_{k+1})\). By (3)–(4), there is a fixed \(L_0\) such that \(H_n(c_r(s))>0\) for \(s\le-L_0\) whenever \(c_r(s)\ge0\) and \(n\) is large. On \([-L_0,T]\), (5) gives real \(C^1\) convergence. Outside disjoint small neighborhoods of \(b_1,\dots,b_k\), the limit is bounded away from zero. In each neighborhood its derivative is bounded away from zero and its endpoint signs are opposite. The same then holds for \(F_n\), giving exactly one zero there, simple, with coordinate \(s=b_j+O_k(r^{-1/3})\) by (5) and the mean value theorem. Returning to \(c_r(s)\) gives the boxed expansion.

Thus the fixed nearest zeros are separated on the \(r^{1/3}e^{-r}\) scale in \(x\). The compact Airy estimate identifies and separates them; the subcritical relative estimate prevents smaller stray roots where an absolute Airy error would not control the sign. Neither estimate establishes global real-rootedness or interlacing for adjacent \(n\).
