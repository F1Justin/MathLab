# Split products at extrema of normalized Gegenbauer polynomials

Write \(P_i=C_i^\lambda/C_i^\lambda(1)\) for \(\lambda>0\). For every \(1\le\lambda\le3/2\), every \(n\ge2\), every zero \(x\) of \(P_n'\), and every \(1\le j<n\),
\[
                         P_j(x)P_{n-j}(x)/P_n(x)<1 .                 \tag{1}
\]
There is a counterexample at every \(\lambda\ge3.84422\). On \(3.84422\le\lambda\le14\) counterexamples occur at every sufficiently large \(n\) for that parameter. On \(\lambda\ge14\) degree \(16\) suffices for the entire interval. For \(-1/2<\lambda<0\) a degree-four counterexample suffices throughout the orthogonal range of negative parameters. The ranges \(0<\lambda<1\) and \(3/2<\lambda<3.84422\) remain open here.

The [Schubert one-column theorem](single_cut.md) uses the endpoint \(\lambda=3/2\). The derivative nodes in (1) belong to degree \(n\), while the factors on the left have degrees adding to \(n\). This differs from the classical Turán determinant \(P_k^2-P_{k-1}P_{k+1}\) and its higher-order extensions. Existing Bernstein estimates control the individual factors. The parameter-uniform step here couples a Bernstein bound to a discrete energy controlled at the derivative node. [Krasikov's Turán inequalities](https://arxiv.org/abs/2310.10459) · [Gautschi on Bernstein's inequality](https://www.cs.purdue.edu/homes/wxg/selected_works/section_02/193.pdf) · [Normalized ultraspherical inequalities](https://arxiv.org/abs/1201.0495)

## The parameter interval

Put \(M_i=i+\lambda,\ L=\lambda(\lambda-1),\ x=\cos\phi\ge0,\ u=\sin\phi\). As in the [proof for \(\lambda=3/2\)](single_cut.md), by parity and symmetry assume \(j\le k=n-j\). At a derivative node \(P_{n-1}=xP_n\), which gives (1) for \(j=1\). Take \(k\ge j\ge2\) and set \(T=(22\lambda+29)/20\).

The symmetric recurrence \(xv_i=a_{i+1}v_{i+1}+a_i v_{i-1}\) now uses
\[
 v_i=\sqrt{d_i}P_i,\quad d_i=M_i(2\lambda)_i/(\lambda i!),\qquad
 4a_i^2=1-L/[M_i(M_i-1)] .
\]
Thus \(a_i\le1/2\) and \(a_i\) is nondecreasing. The same discrete energy telescopes, with \(a_n v_{n-1}/v_n=nx/(2M_n)\). At positive denominator this gives
\[
 \left|P_k/P_n\right|^2
 \le \frac{d_n}{d_k}\frac{1+\lambda^2/(M_n u)^2}
                 {1-L/[M_k(M_k-1)u^2]}.                             \tag{2}
\]
Both \(d_i\) and \(d_i/M_i^2\) increase, since \(d_{i+1}/d_i=(M_{i+1}/M_i)(i+2\lambda)/(i+1)\) and \((i+2\lambda)/(i+1)\ge M_{i+1}/M_i\). The same quotient is at most \(((i+1)/i)^{2\lambda}\) for \(i\ge1\), by Bernoulli's inequality with exponent \(2\lambda-1\ge1\). We may replace \(n\) by \(2k\) in the numerator of (2) and use \(d_{2k}/d_k\le2^{2\lambda}\). Also \(M_{2k}/M_k\ge11/7\) and \(M_k/(M_k-1)\le3/2\).

For \(M_j u\ge T\), set \(g=u^\lambda P_j(\cos\phi)\) and \(V=M_j^2-L/u^2>0\). Its equation \(g''+Vg=0\) makes \(H=g'^2+Vg^2\) nondecreasing up to \(\pi/2\). For \(j=2s+e\), \(e\in\{0,1\}\), put \(c=(1/2)_s/(\lambda+1/2)_s\). At the center \(P_{2s}(0)=(-1)^s c\), \(P'_{2s+1}(0)=(2s+1)P_{2s}(0)\). Consequently \(M_j^{2\lambda-2}H(\pi/2)\) equals
\[
 c^2 M_j^{2\lambda-2}
 \begin{cases} j^2+(2j+1)\lambda,&e=0,\\ j^2,&e=1.\end{cases}
\]
This expression is logarithmically convex in \(\lambda\in[1,3/2]\). The factor \(c^2\) has convex logarithm. The second logarithmic derivative of the other factors is at least \(4/M_j-(2\lambda-2)/M_j^2-4/M_j^2>0\), using \((2j+1)/(j^2+(2j+1)\lambda)\le2/M_j\) in the even case. At \(\lambda=1\) the center expression is exactly one by \(P_j(\cos\phi)=\sin((j+1)\phi)/[(j+1)u]\). At \(\lambda=3/2\) the exact central binomial estimate in the [single-cut proof](single_cut.md#the-larger-angle-range) bounds it by \(8/\pi\). Therefore
\[
 |P_j|^2\le\frac{(8/\pi)^{2\lambda-2}}
                   {(M_j u)^{2\lambda}[1-L/(M_j u)^2]}.
\]
Combining the two energies bounds \(|P_jP_k/P_n|^2\) by
\[
 W=(2/T)^{2\lambda}(8/\pi)^{2\lambda-2}
     \frac{1+(7\lambda/(11T))^2}{(1-L/T^2)(1-3L/(2T^2))}<967/1000.  \tag{3}
\]
For a short rational certificate partition \([1,3/2]\) at the points \(1+i/40\), \(0\le i\le20\). On each interval \([a,b]\) the two exponents are bounded using \(a\) in the base below one and \(b\) in the base above one. Use \(T(a)\) for that first base. Evaluate the final rational factor at \(b\) since \(\lambda/T\) and \(L/T^2\) increase. The [exact verifier](verify_gegenbauer_range.py) replaces \(\pi\) by \(157/50\) and checks the twentieth powers as rational numbers.

For \(M_j u<T\), we use the same positive initial lobe and Dirichlet argument as for the Schubert parameter. Here are the details of uniformity. Set \(d=\lambda+1/2\), \(h=s+e+\lambda\). The polynomial \(P_j(x)/x^e={}_2F_1(-s,h;d;u^2)\) is one at zero in \(u^2\) and has \(s\) positive roots. The sum of their inverse squares equals
\[
 S_2=\frac{s^2h^2(d+1)-s(s-1)h(h+1)d}{d^2(d+1)}.
\]
We have \(M_j^4>T^4 S_2\) uniformly. Multiply the difference by \(d^2(d+1)\), substitute \(s=1+q,\ \lambda=(1+3v/2)/(1+v)\), and multiply by \((1+v)^7\). For each parity all 40 coefficients of the resulting bivariate polynomial are positive. Their least values are \(524799/16000\) for \(e=0\) and \(7634799/160000\) for \(e=1\). The leading coefficient in \(v\) includes the right endpoint. Thus \(0<P_j(x)<1\), by the root bound and the Gegenbauer integral for the strict upper bound.

Finally \(j\phi<\pi\). For \(j=2\), \(M_j\ge3\) and \(M_j>T\), so \(x>0\). For \(j\ge3\), \((j+1)\sin(\pi/j)\ge\pi\) follows from \(\sin t\ge t-t^3/6\), \(\pi^2<10\). Use \(T\le31/10<\pi\). The ratios \(R_l=P_{n-l}/P_n\) start at \(1,x\) and decrease until the first nonpositive term because the backward recurrence for differences is
\[
 R_l-R_{l-1}=(1+h_l)(R_{l-1}-R_{l-2})-(2+h_l)(1-x)R_{l-1},
 \qquad h_l=2\lambda/(n-l+1).
\]
A negative segment followed by \(R_j>0\) would force \(x\le\cos(\pi/j)\) by the Dirichlet path comparison for \(a_i\le1/2\). This proves (1) in the smaller-angle range.

## Failure for positive and negative parameters

Define \(f_\lambda(t)={}_0F_1(;\lambda+1/2;-t^2/4)\). At fixed positive \(\lambda\), the Mehler–Heine formula gives \(P_n(\cos(t/n))\to f_\lambda(t)\) uniformly on compact complex \(t\)-sets. The derivative of \(P_n\), normalized at one, is the normalized Gegenbauer polynomial of degree \(n-1\) and parameter \(\lambda+1\). If \(f_{\lambda+1}\) has a zero \(c>0\) at which \(0<f_\lambda(c)<f_\lambda(c/2)^2\), simple Bessel zeros and the limit therefore give a failure of (1) with \(j=\lfloor n/2\rfloor\) in every sufficiently large rank. [Mehler–Heine formula](https://dlmf.nist.gov/18.11.E5)

Take \(\lambda=77/20\), \(a=11513567/10^6,\ b=11513568/10^6\). Then \(f_{\lambda+1}(a)<0<f_{\lambda+1}(b)\). For every \(a\le t\le b\),
\[
  6/1000<f_\lambda(t)<61/10000,\qquad f_\lambda(t/2)>783/10000 .
\]
The squared lower bound exceeds \(61/10000\). These rational inequalities follow from degree-60 and degree-61 alternating series at the rational endpoints and \(|f_\lambda'|\le1\) from the probability integral on \([-1,1]\); the [verifier](verify_gegenbauer_range.py) uses only exact arithmetic. All bounds persist in a neighborhood of \(77/20\) by continuity. This construction uses an actual derivative node for each sufficiently large finite degree.

The [interval verifier](verify_gegenbauer_obstruction.py) proves the same obstruction uniformly on the entire parameter segment \([192211/50000,14]\). It uses the real function
\[
 F(\lambda,t)=\int_{-1}^1(1-v^2)^{\lambda-1}\cos(tv)\,dv
 =\frac{\sqrt\pi\,\Gamma(\lambda)}{\Gamma(\lambda+1/2)} f_\lambda(t).
\]
On each parameter interval \([a,b]\) the verifier chooses rational \(l<h\) and proves \(F(\lambda+1,l)<0<F(\lambda+1,h)\). On the rectangle \(a\le\lambda\le b,\ l\le t\le h\) it proves \(F(\lambda,t)>0,\ F(\lambda,t/2)>0\), and \(F(\lambda,t/2)^2>F(\lambda,0)F(\lambda,t)\). This supplies the required zero without presuming a root index or its location as the parameter varies. Adaptive bisection uses 280 verified parameter intervals. The lower endpoint \(3.84422\) gives an explicit upper bound for a possible first loss of (1); the equation at half of the second positive derivative-profile zero numerically changes sign near \(3.8442113\).

Here are the interval error bounds. For real \(\lambda\ge3.84422\), the pure fourth derivative in \(t\) has absolute value at most two. The pure fourth derivative in \(\lambda\) has absolute value at most \(2[4/(e(\lambda-1))]^4<2\), by differentiating the integral and maximizing \(y^{\lambda-1}|\log y|^4\) on \(0<y\le1\). Cubic interpolation at four equally spaced nodes on an interval of length \(d\) therefore has absolute error at most \(d^4/12\). Given data \(y_0,\ldots,y_3\), the four interpolant Bernstein coefficients are \(y_0,B(y_0,y_1,y_2,y_3),B(y_3,y_2,y_1,y_0),y_3\), where
\[
 B(a,b,c,d)=3b-\tfrac32 c-\tfrac56 a+\tfrac13 d .
\]
The coefficients enclose the polynomial range and the interpolation operator has norm at most \(17/3\). Interpolating on a rectangle of widths \(d_\lambda,d_t\) therefore adds at most \([d_\lambda^4+(17/3)d_t^4]/12\) to the range of its tensor Bernstein coefficients, by first applying the one-variable error in \(\lambda\) and then its interpolation operator to the error in \(t\). No mixed derivative estimate is needed. All function values at the interpolation nodes use outward-rounded 96-bit Arb balls.

For \(\lambda\ge14\) put \(J=C_8^\lambda(x)\), \(N=C_{16}^\lambda(x)\). Use their primitive parts in \(x\), a rescaling which leaves normalization at one invariant. Set \(z=x^2\) and take primitive parts in \(z\) of
\[
 D(z,\lambda)=N'(x)/x,\qquad
 G(z,\lambda)=\frac{J(x)^2N(1)-N(x)J(1)^2}{1-x^2}.
\]
The [exact polynomial verifier](verify_gegenbauer_range.py) checks that the removed contents are positive throughout \(\lambda\ge14\), and all coefficients of \(\operatorname{Res}_z(D,G)(14+t)\) are strictly positive. This is a polynomial of degree 77 in \(t\). At \(\lambda=14\), \(D\) changes sign between \(z=4600706/10^7\) and \(4600707/10^7\); \(N,G\) are both positive on that whole interval, by their exact Bernstein signs. Thus \(P_8^2/P_{16}>1\) there at a derivative node. Following the same ordered positive derivative node as \(\lambda\) grows is valid by the simplicity of Jacobi zeros. \(P_{16}\) at that node cannot vanish by its simple zeros, and the resultant prevents equality. This proves the degree-16 obstruction for the entire unbounded parameter range.

For \(-1/2<\lambda<0\), take \(n=4,j=2,x=0\). Then \(P_2(0)^2/P_4(0)=(2\lambda+3)/(3(2\lambda+1))>1\). At the Chebyshev limit \(\lambda=0\), the same example gives equality.
