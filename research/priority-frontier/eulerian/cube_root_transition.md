# Eventual real-rootedness of the ordinary Eulerian square

**Main theorem.** There is an \(n_0\) such that for every \(n\ge n_0\), all \(n\) zeros of row \(H_n(x)=\sum_{j,k}A(n,j)A(j,k)x^k\) are simple and real. One is zero and the other \(n-1\) are strictly negative. The convention is \(A(n,j)=E(n,j-1)\) with \(E(n,k)\) the number of permutations of \(n\) letters with \(k\) descents. This proves the eventual form of the ordinary-square question. The proof gives no numerical cutoff joining the theorem to the verified small rows.

Suppose there were an unbounded sequence of rows with a nonreal or multiple zero. The constant term of \(H_n\) vanishes and its linear coefficient is \(n!\), so none of the offending zeros can be zero. Their moduli must tend to infinity by the [fixed-disk theorem](left_disk.md), passing to a subsequence if necessary. Write \(T=\log|x|\). If \(T\le n^{2/5}\) infinitely often, the [factorial-row variance and two-pole theorem](positive_middle.md) with \(\epsilon=1/10\) excludes that subsequence. On the remaining sequence \(T>n^{2/5}\ge n^{1/3}\), the transition theorem below excludes it as well. Finally the coefficients in every positive degree are positive, so the simple real zeros other than zero are negative.

## The cube-root transition

**Theorem.** For every \(c>0\), all sufficiently large \(n\) have only simple negative zeros of \(H_n\) in \(\log|x|\ge c n^{1/3}\). Here \(H_n\) is row \(n\) of the ordinary matrix square of the shifted Eulerian triangle in [Mao–Wang, §4](https://arxiv.org/html/2607.01572v1#S4). At \(\log|x|\sim\tau n^{1/3}\) the two central lattice frequencies in each of two indices give a limiting equation
\[
 \cos(a+b+2\pi\xi)=-e^{-2\pi^2/\tau^3}\cos(a-b).
\]
The factor on the right is strictly less than one in absolute value, uniformly in the two phases for fixed \(\tau>0\).

We use the [exterior theorem](exterior.md) for sequences with \((\log|x|)/\sqrt n\) bounded below. It remains to exclude sequences of nonreal or multiple zeros with \(T=\log|x|\ge cn^{1/3}\) and \(T/\sqrt n\to0\). Below, \(d=T^2/n\to0\) and \(s=n/T\).

## Exact two-index formula

Put \(R_n(q)=q^n H_n(1/q)\). For the ordinary descent numerator \(E_m(u)=\sum_{j=1}^m E(m,j-1)u^{j-1}\) we have \(E_m(u)=(1-u)^{m+1}\sum_{k\ge1}k^m u^{k-1}\). Apply this identity first to the inner Eulerian row in \(R_n\), then to the outer one. For \(|q|\) small this gives the absolutely convergent identity
\[
 R_n(q)=\sum_{A,B\ge1} A^n B^{n-A+1}q^{A+B-2}
 (1-q)^{n+2-A}\left(1-\frac{q}{B(1-q)}\right)^{n+1}.                 \tag{1}
\]
Indeed the intermediate sum is \((1-q)^{n+1}\sum_{B\ge1} B^n q^{B-1}E_n(q/[B(1-q)])\). Extending the indices in (1) uses this exact transformation. A pointwise replacement of Eulerian numbers by powers alone can be too inaccurate after cancellation at the transition.

At \(q=e^{-T}z\) take a global integer maximum \((P,Q)\) of \(W(A,B)=A^n B^{n-A+1}e^{-T(A+B-2)}\). Each maximizing coordinate is at most \(s+1\), by comparing one step backwards (if \(n-A+1<0\) the best \(B\) is one). The one-coordinate continuous maxima of the powers times exponentials are consequently positive and lie within one of the corresponding integer modes, for large \(n\). In particular
\[
 P=n/(T+\log Q)+O(1),\qquad Q=(n-P+1)/T+O(1),\qquad P,Q\sim s.
\]
Define \(\eta=1/(Qd^2)\sim n/T^3\), so \(\eta\) stays bounded in the present regime. Write \(i=A-P,\ j=B-Q\) and let
\[
 u_i=(1+i/P)^n e^{-(T+\log Q)i},\qquad
 v_j=(1+j/Q)^{n-P+1} e^{-Tj},\qquad U(z)=\sum_i u_i z^i,\quad V(z)=\sum_j v_j z^j.
\]
The sums start at \(1-P,1-Q\), and both coefficient sequences have their maximum one at zero. Set \(F=R_n(e^{-T}z)/(W(P,Q)z^{P+Q-2})\). In (1) the reference term \(u_i v_j z^{i+j}\) has multiplier
\[
 E(i,j)\,B_q(i,j),\qquad
 E(i,j)=\exp[-i\log(1+j/Q)],\quad
 B_q(i,j)=(1-q)^{n+2-P-i}\left(1-\frac{q}{(Q+j)(1-q)}\right)^{n+1}.
                                                                    \tag{2}
\]
Here \(i,j\) are integer offsets, and \(\mathrm i=\sqrt{-1}\) denotes the imaginary unit.

## Bounds on the two scalar sums

Work about \(z=e^{\mathrm i\theta}\), \(0\le\theta\le\pi\), with \(z=e^{\mathrm i\theta+d\xi}\) and \(\xi\) in any fixed compact disk. Conjugation covers the lower semicircle. Each scalar sum has, for a positive constant \(C_m\) independent of \(y\), the form
\[
 U(e^y)= C_m e^{-Py}\sum_{\ell\in\mathbb Z}
                 (L-y+2\pi\mathrm i\ell)^{-m-1},\qquad (L,m)=(T+\log Q,n).
                                                                    \tag{3}
\]
The formula for \(V\) replaces \((P,L,m)\) by \((Q,T,n-P+1)\). This is the differentiated partial fraction expansion of the geometric series. For example, \(\sum_{k\ge1} k^m e^{-bk}=m!\sum_\ell(b+2\pi\mathrm i\ell)^{-m-1}\), by differentiating the squared-cosecant identity or Poisson summation.

Let \(A_U,A_V\) denote the absolute values of the \(\ell=0\) terms at \(y=\mathrm i\theta\), with the respective constants included. Uniformly in \(\theta\) they satisfy \(A_U\ge c_1 e^{-C_1/d}U(1)\) and \(A_V\ge c_1 e^{-C_1/d}V(1)\). In fact at zero the sum of moduli is at most a constant times its nearest pole, and the change in that pole modulus is \((1+\theta^2/L^2)^{-(m+1)/2}\). More generally for \(|y-\mathrm i\theta|\le2\), the sum of moduli is at most a constant times a nearest pole. For the proof reduce the imaginary part modulo \(2\pi\) to \([-\pi,\pi]\). Apart from at most three poles, the ratio to the nearest is at most \(\exp(-c_2\ell^2/d)\) up to \(|\ell|\le L\), by squaring the denominators and taking logarithms. For \(L<|\ell|\le 2L\) there are \(O(L)\) terms bounded by \(e^{-c_3m}\), and for \(|\ell|>2L\) comparison with \((2L/(2\pi|\ell|-\pi))^{m+1}\) gives an exponentially small sum. The estimates also show that on bounded \(\xi\)-disks only the nearest pole survives in relative size if \((\pi-\theta)/d\to\infty\). Indeed for the next pole the gap of the squared imaginary parts is \(4\pi(\pi-\theta)\) at the center.

For each potentially nearest pole \(\ell=0,\pm1\), its logarithmic derivative at such \(y\) is \(-P+(m+1)/(L-y+2\pi\mathrm i\ell)=O(1/d)\), since \(P=m/L+O(1)\); the same holds for the second factor. Along a segment from \(\mathrm i\theta\) to \(y\) this bounds its growth by \(\exp(C_4|y-\mathrm i\theta|/d)\) times \(A_U\). Hence with \(D=z\,d/dz\), Cauchy's inequality at radius \(\min(1,pd)\) yields, for \(p\ge1\),
\[
 |D^p U(z)|\le C_H A_U[C_5\max(p,d^{-1})]^p,\qquad
 |D^p V(z)|\le C_H A_V[C_5\max(p,d^{-1})]^p,\quad |\xi|\le H .       \tag{4}
\]
The corresponding bounds for \(p=0\) hold with the bracket replaced by one. The constants are uniform in \(\theta\), and \(H\) is fixed.

## Transporting the analytic multiplier through cancellation

Put \(M=d^{-1}+\log n,\ J=\lceil K M\rceil,\ R=B M\), with \(K\) and then \(B\) sufficiently large fixed constants. We have \(R/Q=o(1)\) and \(R^2/Q=O_B(1)\). Thus on the complex bidisk of radius \(R\), \(E\) is analytic and bounded by a fixed constant, while \(|B_q-1|=O_B(n e^{-T})\). These assertions apply uniformly to the indicated \(z\)-disks. Let \(c_{ab}\) be the Taylor coefficients of \(E\) at zero. Then
\[
 \frac{F(z)-\displaystyle\sum_{a+b\le J} c_{ab}\,D^a U(z)D^b V(z)}
 {A_U A_V}=O(n^{-3}) .                                               \tag{5}
\]
We detail the error estimate because an absolute approximation to the positive radial sums loses an exponential factor at negative arguments.

First Taylor-expand the full multiplier in (2) through total degree \(J\). Inside \(|i|,|j|\le J\), the discarded series costs at most \(C_B(J+2)(J/R)^{J+1}/(1-J/R)^2\) per reference term. The positive radial sums on \(|\xi|\le H\) are at most \(O_H(n^2)\): in a rectangle of side \(O(s)\), the integer log-curvatures give \(u_i\le e^{-c d |i|(|i|-1)}\) and likewise for \(v_j\), absorbing \(|z|^{i+j}\le e^{Hd(|i|+|j|)}\). Their exterior tails satisfy the stronger bounds below. Since \(A_U A_V\ge c_1^2 e^{-2C_1/d}\), the central Taylor error is \(O(n^{-4} A_U A_V)\) by increasing \(K,B\).

For the exact and polynomial tails first stay in \(s/2\le A,B\le2s\). The curvature bounds follow here from the second derivatives of the scalar logarithms and the mode inequalities. The exact mixed exponent in (2) costs at most \(C|ij|/Q\), absorbed by the Gaussian because \(dQ\sim T\to\infty\). For the polynomial, Cauchy's estimates give the bound \(C_B(J+1)^2\max(1,(\max(|i|,|j|)/R)^J)\). On \(\max(|i|,|j|)\ge J\) this too is absorbed by a fixed part of the Gaussian, using \(dJ\ge K\) and \(\log_+(t/R)\le t/J\). The remaining sum is \(O_H(n^{C_6}e^{-c_6 dJ^2})\) with absolute \(C_6,c_6>0\), and \(dJ^2\ge K^2 M\).

Outside that rectangle the exact sum is exponentially small in \(n\). To see this discard \(B^{1-A}\le1\) and bound the two extra factors in (1) by \(\exp(C(n+A)|q|)\). After the \(|z|\) multiplier, both scalar envelopes are of the form \(a^n e^{-T'a}\) with \(T'=T-O_H(1)\) and an index-independent factor. Moving \(T\) to \(T'\) changes their logarithmic maxima by \(O_H(s+1)\). For \(a\) outside the rectangle the logarithmic loss is \(n(a/s'-1-\log(a/s'))\ge c_7 n\), \(s'=n/T'\). Normalize by evaluating \(W\) at both indices nearest to \(s\), costing \(O(n/s^2+s\log(2s))=o(n)\) relative to the two continuous maxima at \(T\), with the common \(e^{2T}\) included. The scalar tails beyond \(2s\) have outward ratios at most \(e^{-c_8 T}\), so extending either sum to infinity introduces at most a polynomial factor. For the polynomial approximation the separate scalar sequences \(u,v\) lose \(\Omega(n)\) at the rectangle boundary by curvature and have outward ratios at most \(e^{-c_9T}\) beyond it by scalar log-concavity and the logarithmic slope there. Polynomial factors of total degree \(J\) cost only \(O(J\log n)=o(n)\) in the logarithm for offsets at most \(n\); beyond \(n\) one can use \(\log t\le\log n+t/n\) and absorb the remaining linear term into the geometric tail. These bounds also apply if only one index is outside. Increasing \(K\), and then \(B\), now makes both tails \(O_H(n^{-4}A_U A_V)\).

The finite Taylor polynomial sums exactly to the corresponding expression in \(D^a U D^b V\), by absolute convergence. For the part arising from \(E(B_q-1)\), its coefficients at fixed \(q\) are \(O_B(n e^{-T})R^{-a-b}\). Apply (4) termwise with \(B>4 C_5(K+2)\); their total is \(O_H(n e^{-T}A_U A_V)\). The derivatives here act on the scalar sums only. This proves (5). The same estimates give the uniform geometric majorant \(C_{B,H}2^{-a-b}\) for the individual normalized terms of (5).

## The transition profiles and the sign at collisions

Pass to a subsequence with \(\eta\to\eta_0\). First take \(\eta_0>0\). Then \(d\asymp n^{-1/3}\), \(M\sim d^{-1}\), and on every fixed bidisk in \(I,J'\) one has
\[
 E(I/d,J'/d)\ \longrightarrow\ e^{-\eta_0 IJ'} .
\]
This follows by expanding \(\log(1+J'/(dQ))\), since \(dQ\to\infty\). In particular \(c_{ab}d^{-a-b}\) converges coefficientwise to the indicated entire-function coefficients.

At the negative point take \(\theta=\pi\). The normalized scalar factors at \(z=-e^{d\xi}\) have, after subsequence extraction of two unit phases, the limits
\[
 U/A_U\longrightarrow e^{\mathrm i(a+\pi\xi)}+e^{-\mathrm i(a+\pi\xi)},\qquad
 V/A_V\longrightarrow e^{\mathrm i(b+\pi\xi)}+e^{-\mathrm i(b+\pi\xi)}.       \tag{6}
\]
Indeed the poles \(\ell=0,1\) are conjugate at the center, including the integer shift \((-1)^P\), and each normalized pole has logarithmic derivative in \(\xi\) tending uniformly to \(+\mathrm i\pi\) or \(-\mathrm i\pi\). For example \(d[-P+(m+1)/(L-\mathrm i\pi-d\xi)]\to\mathrm i\pi\), by the mode estimate and \(dm/L^2\to1\). The other poles tend to zero locally uniformly. Thus (6) also holds after any number of \(\xi\)-derivatives, namely applications of \(dD\).

The geometric majorant in (5) permits passage to the limit in the differential series. On a product of two waves with signs \(\sigma_1,\sigma_2\in\{-1,1\}\), it supplies the factor \(\exp(\eta_0\pi^2\sigma_1\sigma_2)\). Hence \(F/(A_U A_V)\) tends locally uniformly to
\[
 2e^{\eta_0\pi^2}\cos(a+b+2\pi\xi)
 +2e^{-\eta_0\pi^2}\cos(a-b).                                         \tag{7}
\]
For \(\eta_0>0\) all zeros of this limit are real and simple, since the corresponding real level of the cosine lies strictly between \(-1\) and \(1\).

For angles with \((\pi-\theta)/d\to\infty\) pass also to \(\theta\to\theta_0\), and normalize each scalar factor by its own complex nearest-pole term at the center. Only that pole survives, with limiting wave \(e^{\mathrm i\theta_0\xi}\) by the same derivative calculation. Formula (5) gives a nonzero limiting value \(e^{\eta_0\theta_0^2}\) at \(\xi=0\). This excludes zeros there. For bounded \((\pi-\theta)/d\), the candidate point lies on a bounded imaginary segment of the \(\xi\) plane based at \(\theta=\pi\). Every limit point must be a zero of (7). A small conjugation-invariant disk about such a zero contains just one simple real zero of the actual polynomial, by Rouché and reality in \(\xi\).

It remains to treat \(\eta\to0\). Now (5) has a first-order refinement, uniformly on the same disks:
\[
 F=UV-\eta\,(\partial_\xi U)(\partial_\xi V)+o(\eta)A_U A_V .            \tag{8}
\]
For a proof use the larger bidisk radius \(R_0=\sqrt Q/2\) to bound the coefficients of \(E\) by \(C R_0^{-a-b}\). All nonconstant terms other than \(c_{11}=-1/Q\) have total degree at least three. As \(M/\sqrt Q\to0\), (4) bounds their total contribution through degree \(J\) by \(O_H((M/\sqrt Q)^3)A_U A_V\). Dividing by \(\eta\), this error is \(O(\sqrt\eta+d^2(\log n)^3/\sqrt Q)=o(1)\) using \(Q\sim n/T\gg\sqrt n\). Also \(n^{-3}=o(\eta)\). This proves (8).

Away from the negative ray in the preceding scaled sense, the single-wave argument now applies directly to (8). About \(\theta=\pi\) its unperturbed limit is the product in (6). A zero of just one limiting factor remains simple and real by Rouché. At a common zero \(\xi_*\) the finite factors have unique simple real zeros \(a_n,b_n\to\xi_*\) in a small fixed disk, and their \(\xi\)-derivatives at these zeros divided by their respective amplitudes tend to nonzero real numbers. Divide (8) by the product of the finite derivatives there. At \(\xi=(a_n+b_n)/2\) this gives
\[
 -\tfrac14(a_n-b_n)^2(1+o(1))-\eta(1+o(1))+o(\eta)<0 .
\]
At two fixed nearby real endpoints on opposite sides of \(\xi_*\) the normalized product is positive. The two real crossings exhaust the two zeros counted by Rouché in the disk, giving two distinct simple roots. All possibilities for an offending sequence have been excluded. With \(T/n^{1/3}\to\tau\in(0,\infty)\) we have \(\eta_0=\tau^{-3}\), giving the stated transition equation.
