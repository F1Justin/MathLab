# Positive quadrature for arbitrarily high coefficient jets of the partition rows

Write \(a_i=[x^i]P_{N,j}(1+x)/N!\), \(D=\lfloor N/j\rfloor\), \(L=\log N\), \(V=\max(1,N/j^2)\), and \(m=N-jk\). Fix an integer \(p\ge3\) and \(\alpha>0\). There is a \(c_{p,\alpha}>0\) such that for all sufficiently large \(N\), for every \(N^\alpha\le j\le 2\sqrt{NL}\) and \(1\le k<D\) satisfying
\[
 m\ge V L^2,\qquad m(\log N)^{2p+1}/j^{p+1}\le c_{p,\alpha},
                                                                    \tag{1}
\]
there is a zero-free circle centred at zero with exactly \(k\) zeros of \(P_{N,j}(1+x)\) inside. In particular, for **every** fixed \(\alpha>0\) and all sufficiently large \(N\), uniformly for \(N^\alpha\le j\le N\), all but at most \(O(1+NL^2/j^3)\) innermost-to-outermost ranks are already certified: the first \(D-O(1+NL^2/j^3)\) roots, ranked by absolute value, are simple negative. The [independent outer estimate](uniform_outer_curvature.md) also certifies the largest ranks.

When \(m\le j^2/(20\log j)\) the cited outer estimate already gives the required circle in the shifted coordinate. Assume \(m>j^2/(20\log j)\). We use the full saddle and its holomorphic coefficient interpolation from the [fifth-power proof](fifth_power_threshold.md). The facts used here hold under \(j\ge N^\alpha\) in (1), independent of that note's fifth-power conclusion. Explicitly,
\[
 a_k=\frac{C(m,k)}{k!(j!)^k},\quad C(m,k)=[z^m]\exp(e^z-1)H(z)^k,\quad
 H(z)=\sum_{l\ge0}\frac{j!z^l}{(j+l)!}.
\]
For \(M=m-js\), the complex saddle solves \(r e^r+(k+s)\mathcal D\log H(r)=M\), where \(\mathcal D=z\,d/dz\). Put \(\Lambda=e^r-1+(k+s)\log H(r)-M\log r\) and \(L_m=1+W(m)\). In this range \(L_m\asymp_\alpha L\). With \(U=\max(1,m/j^2)\), take \(J=P=\lceil A U L^2\rceil\), \(R'=AB U L^2\), \(R=R'L^2\); \(A,B\) are sufficiently large constants specified by the circle estimates. The interpolation has \(\log C_*(s)=\Lambda(s)+U_0(s)\), \(\sup_{|s|\le R}|U_0(s)|=O_\alpha(L)\), with \(C_*(h)=C(m-jh,k+h)\) at all supported integral offsets on that disk. This is the complex full-saddle estimate of the fifth-power proof: its local-error conditions use \(m>j^2/(20L)\) and \(jR/m=O_{A,B}(L^5/j)\), which hold here for every fixed \(\alpha>0\). Thus the error in \(U_0\) after subtracting its constant and linear terms on \(|s|\le R'\) is \(O(L^{-3})\).

On \(|s|\le c m/j\), the Bell-dominant saddle comparison gives
\[
 \Lambda''(s)=-\frac{j^2}{(m-js)(1+W(m-js))}\,(1+o(1)).
\]
Indeed \(r=W(M)+O(VL/m)\) by the contraction in the [quarter-power proof](quarter_power_threshold.md), since \(m\ge V L^2\) and \(\mathcal D^q\log H=O_q(L/j)\) there. The relative error in the curvature is \(O(VL/m+L/j^2)\). On a fixed smaller concentric disk, \(W(m-js)-W(m)=O(1)\). Cauchy's inequality for the analytic error relative to the geometric series \(1/(1-js/m)\) therefore shows, for every fixed \(2\le r\le p\),
\[
 -\Lambda^{(r)}(0)=(1+o(1))(r-2)!\frac{j^r}{m^{r-1}L_m},\qquad
 \sup_{|s|\le R'}|\Lambda^{(p+1)}(s)|
       =O_p\!\left(\frac{j^{p+1}}{m^p L_m}\right).               \tag{2}
\]

## Matching an arbitrary fixed number of derivatives

Set \(t=p-2\). Gaussian quadrature with the fixed left endpoint (Gauss–Radau) gives nodes \(x_0=0<x_1<\cdots<x_t<1\) and positive masses \(\lambda_l\) integrating every polynomial of degree at most \(2t\) on \([0,1]\). For completeness, the internal nodes are the zeros of the degree-\(t\) orthogonal polynomial for the weight \(x\,dx\). All are simple and internal by the usual sign-change argument against polynomials of degree \(<t\). Interpolating at the \(t+1\) nodes leaves a multiple of \(x\prod_{l=1}^t(x-x_l)\) times a polynomial of degree at most \(t-1\), of integral zero. The weight at each node equals the integral of the square of its cardinal Lagrange polynomial and is strictly positive. In particular
\[
 \sum_{l=1}^t\lambda_l x_l^a=\frac1{a+1}\quad(1\le a\le p-2),
 \qquad \sum_{l=1}^t\lambda_l=1-\lambda_0<1.                       \tag{3}
\]

The base reference is the true degree-\(D\) binomial. Put \(v_0=D-k\), \(g_0(s)=\log\Gamma(v_0+1)-\log\Gamma(v_0+1-s)\) and \(K_0=\Lambda-g_0\). The polygamma series gives \(|g_0^{(r)}(s)|\ll_p v_0^{1-r}\) for \(2\le r\le p+1,\ |s|<v_0/2\). Here \(v_0\sim m/j\gg R\). These derivatives are smaller than the corresponding scales in (2) by \(O_p(L_m/j)\).

Solve for real masses \(\nu_l\), \(1\le l\le t\), by
\[
 \sum_l\nu_l x_l^{r-2}
  =\frac{-K_0^{(r)}(0)\,m^{r-1}L_m}{(r-1)!\,j^r}
     \quad(3\le r\le p).
\]
The right side tends uniformly to \(1/(r-1)\). The fixed matrix is a Vandermonde matrix times a positive diagonal. Equation (3) shows that \(\nu_l=\lambda_l+o(1)>0\) and \(\sum_l\nu_l=1-\lambda_0+o(1)\). For each internal node take
\[
 w_l=\frac m{jx_l},\qquad M_l=\operatorname{round}\!\left(\frac{m\nu_l}{L_m x_l^2}\right),
 \qquad b_l(s)=\log(1-s/w_l).
\]
The unrounded powers exactly match the derivatives of \(K_0\) of orders 3 through \(p\), since \(b_l^{(r)}(0)=-(r-1)!w_l^{-r}\). Rounding costs \(O_p((j/m)^r)\) at order \(r\). Choose
\[
 d=\sum_l M_l b_l''(0)-K_0''(0)
     =(\lambda_0+o(1))\frac{j^2}{m L_m}>0.                        \tag{4}
\]
The positive weight at the fixed quadrature node supplies exactly the second-order curvature reserved for root separation.

Our reference has coefficients proportional, up to positive geometric scaling, to
\[
  \binom Di e^{-d i(i-1)/2}\prod_l (k+w_l-i)^{M_l},\qquad 0\le i\le D .
\]
It is real-rooted with consecutive root moduli separated by a factor greater than \(e^d\). Each multiplication by \(k+w_l-i\) on coefficient \(i\) preserves negative real roots: \(k+w_l>D\), and reversing in degree \(D\) turns the operator into \(k+w_l-D+z\,d/dz\), which preserves negative real roots by derivative interlacing (or by signs at the simple negative roots and then continuity). Begin with \((1+z)^D\). The final \(e^{-d\binom i2}\) multiplier and its strict separation follow from the factor recurrence in the quarter-power proof.

Scale the coefficient at \(k\) and its logarithmic first variation to match the true coefficient after both factorial denominators have been removed. Equivalently scale the argument by \(\exp[(\log C_*)'(0)-g_0'(0)-\sum_l M_l b_l'(0)+d(k-1/2)]/j!\). For the resulting coefficients \(b_i\) the ratios \(a_{k+h}/b_{k+h}\) interpolate to \(\Phi(s)\) with \(\Phi(0)=1\) and
\[
 \sup_{|s|\le R'}|\log\Phi(s)|
 \ll_{p,\alpha} L^{-3}+(jR'/m)^3+
                    \frac{j^{p+1}(R')^{p+1}}{m^p L_m}.           \tag{5}
\]
This is Taylor's formula using (2), the rounded derivatives, and (4). The derivatives of order \(p+1\) from the new factors are \(O_p(\sum_l M_l w_l^{-p-1})=O_p(j^{p+1}/(m^p L_m))\) throughout the smaller disk. When \(U>1\) the final term is \(O_{A,B,p,\alpha}(m L^{2p+1}/j^{p+1})\). When \(U=1\), it is \(O_{A,B,p,\alpha}(L^{3p+1}/j^{p-1})=o(1)\) using \(m>j^2/(20L)\). Choose \(c_{p,\alpha}\) in (1) after \(A,B\). Then \(\Phi,\Phi^{-1}\) are bounded in modulus by two.

For clarity, the existing reference-circle argument applies with this entire reference. Both polynomial supports end exactly at \(D\), all reference coefficient log-curvatures are at least \(d\) by log-concavity of the linear factors on \([0,D]\), and the centre log-curvature is
\[
 \log(1+1/k)+\log(1+1/v_0)+d+
         \sum_l M_l\log\big(w_l^2/(w_l^2-1)\big)=O_{p,\alpha}(1).
\]
Also \(d\gg_{p,\alpha}1/(UL)\), \(d=O_{p,\alpha}(1)\), and \(D-k\gg R\). At the geometric midpoint of reference roots \(k,k+1\), the [midpoint and derivative estimates](growing_threshold.md) therefore give minimum modulus at least the positive-radius value times \(\exp[-\pi^2/(2d)]\), and derivative parameter \(O_{p,\alpha}(U L^2)\). Choose \(A\), then \(B\), as in the fifth-power proof. Bounds (5) on the disk make its degree-\(P\) Taylor multiplier change the reference there by less than one quarter of its modulus. The central Taylor remainder \(O((J/R')^{P+1})\) and both coefficient tails \(O(e^{-dJ^2/5})\), in units of the positive-radius value, are smaller than the circle minimum by the same argument: \(dJ\gg L\), both cutoffs lie in the right support, any existing left cutoff has the true/reference ratio bounded at it and its inward neighbor, and the true coefficients are log-concave. Rouché proves the count \(k\).

Finally choose \(p\) with \(\alpha(p+1)>1\). Then the second condition in (1) holds for every \(m\le N\) eventually. The counts for successive \(k\) up to \(\lfloor(N-VL^2)/j\rfloor\), truncated at \(D-1\), give simple real roots by conjugation. In the original variable positivity forces these roots to be negative. Moreover, a more distant root \(x\) in the shifted coordinate has \(|1+x|\ge |x|-1\), while equality holds for every identified real root \(x<-1\), so the absolute ranks also hold in the original coordinate. For \(V=1\) at most \(O(1+L^2/j)\) ranks remain, and for \(j>2\sqrt{NL}\) the large-threshold theorem already includes all ranks. This proves the stated count.
