# Rising-factorial Eulerian rows and local spacing in the ordinary square

Let \(A(n,j)=E(n,j-1)\), where \(E(n,k)\) counts permutations of \(n\) letters with \(k\) descents. Write \(A_j(x)=\sum_k A(j,k)x^k\). The ordinary Eulerian matrix square has row polynomial \(H_n(x)=\sum_j A(n,j)A_j(x)\). Mao and Wang ask whether every \(H_n\) is real-rooted. [Original problem, §4](https://arxiv.org/html/2607.01572v1)

## Rising-factorial weights

**Theorem 1.** For \(a>0\) and \(n\ge1\), the polynomial
\[
 S_{n,a}(z)=\sum_{j=1}^n (a)_j A(n,j) z^j,\qquad
 (a)_j=a(a+1)\cdots(a+j-1),
\]
has a simple zero at zero and \(n-1\) simple strictly negative zeros. The statement also holds with weights \((j-1)!\). In particular \(S_n=S_{n,1}\) uses the weights \(j!\).

Put \(\vartheta=z\,d/dz\). The Eulerian insertion recurrence
\(A(n+1,j)=jA(n,j)+(n+2-j)A(n,j-1)\) gives
\[
 S_{n+1,a}=T_{n,a} S_{n,a},\qquad
 T_{n,a}=\vartheta+z(\vartheta+a)(n+1-\vartheta).
\]
The finite-degree algebraic-symbol theorem of Borcea and Brändén shows that a linear operator on polynomials of degree at most \(n\) preserves upper-half-plane stability when its symbol \(T[(z+w)^n]\) is stable. [Borcea and Brändén, The Lee–Yang and Pólya–Schur programs I](https://arxiv.org/abs/0809.0401)

For \(n\ge1\) direct differentiation gives
\[
 \frac{T_{n,a}[(z+w)^n]}{z(z+w)^{n-1}}
 = n+(n+a)z+a(n+1)w+n(n-1)\frac{zw}{z+w}.
\]
When \(z,w\) are in the upper half-plane, so is \(zw/(z+w)=1/(1/z+1/w)\). The right side has strictly positive imaginary part, including at \(a=0\). Thus \(T_{n,a}\) preserves stability. Induction starts at \(S_{1,a}=az\); the coefficients are real and positive in degrees \(1,\ldots,n\). For the weights \((j-1)!\), take the coefficientwise limit of \(S_{n,a}/a\) as \(a\downarrow0\). Its degree remains \(n\), its linear coefficient is 1 and the recurrence specializes to \(T_{n,0}\).

For simplicity, assume inductively that the input \(f\) has \(n\) simple real zeros. For any fixed real \(h\) of degree at most \(n\), both signs of a sufficiently small perturbation \(f+\epsilon h\) retain \(n\) real zeros, as can be seen using disjoint sign brackets. Thus \(T_{n,a}f+\epsilon T_{n,a}h\) also has only real zeros. A multiple root \(r\) of \(T_{n,a}f\) must be a common zero of all \(T_{n,a}h\). Indeed if \(T_{n,a}h(r)\ne0\), the local equation for the perturbed roots is \(T_{n,a}f/T_{n,a}h=-\epsilon\). At a zero of order \(s\ge2\) this real analytic quotient has no nearby real solution for one sign when \(s\) is even, and has exactly one simple nearby real solution for either sign when \(s\) is odd. Continuity of complex roots gives \(s\) nearby roots counted with multiplicity. This contradicts real-rootedness. For \(a>0\), \(T_{n,a}1=a(n+1)z\); zero itself is simple by the linear coefficient. For \(a=0,\ n\ge2\), \(T_{n,0}z=z(1+nz)\) and \(T_{n,0}z^2=2z^2(1+(n-1)z)\) have no common nonzero zero. The initial two limiting rows are \(z\) and \(z+z^2\).

One consequence is strict interlacing as \(a\) increases by one, after the shared zero at the origin is removed. Indeed \(S_{n,a+1}=S_{n,a}+z S'_{n,a}/a\). At a negative zero \(r\) its value is \(r S'_{n,a}(r)/a\). These signs alternate, and the remaining negative zero lies between the last negative zero of \(S_{n,a}\) and zero by the sign of its linear term there.

**Two-sided version.** For \(p,q\ge1\) and \(n\ge1\), all zeros of
\[
 B_{n,p,q}(z)=\sum_{k=0}^{n-1}(p)_k(q)_{n-1-k}E(n,k)z^k
\]
are strictly negative. Multiplicities are possible, for instance \(B_{3,1,1}=2(1+z)^2\). In particular the reciprocal polynomial with coefficients \(E(n,k)/\binom{n-1}{k}\) has only negative real zeros.

First put \(a=p-1>0,\ b=q\ge1\) and \(C_n=az B_{n,p,q}\). The insertion recurrence gives
\[
 C_{n+1}=\big[\vartheta(n+b-\vartheta)+z(\vartheta+a)(n+1-\vartheta)\big] C_n.
\]
For \(n\ge2\) the symbol of this operator is \(z(z+w)^{n-2}\) times
\[
 A z^2+B zw+E w^2+n\big(bz+(b+n-1)w\big),
\quad A=n+a,\quad B=n^2+an+2a,\quad E=a(n+1).
\]
To see stability, write \(v=bz+(b+n-1)w\). Division of the bracket by \(v\) gives
\[
 n+\frac A b z+\frac E{b+n-1}w+
 \left(B-\frac{A(b+n-1)}b-\frac{Eb}{b+n-1}\right)\frac{zw}{v}.
\]
The last coefficient multiplied by \(b(b+n-1)\) equals
\[
 (n-1)\big[n^2(b-1)+n\{a(b-1)+(b-1)^2\}+a\big]\ge0 .
\]
The reciprocal of \(zw/v\) is \(b/w+(b+n-1)/z\); thus every nonconstant term with positive coefficient lies in the upper half-plane when \(z,w\) do. The symbol theorem and the initial polynomials \(B_{1,p,q}=1,\ B_{2,p,q}=q+pz\) prove real-rootedness. Letting \(p\downarrow1\) proves the boundary case by continuity. All coefficients are positive, including both endpoints. The final specialization follows from \(k!(n-1-k)!=(n-1)!/\binom{n-1}{k}\).

This gives an exact reduction of the ordinary-square question. Put \(m=n-1\) and \(b_k=E(n,k)/\binom{m}{k}\); then \(b(z)=\sum b_k z^k\) is reciprocal and has only negative zeros. The required output is
\[
 H_n(x)=\sum_{k=0}^{m}\binom mk b_k A_{k+1}(x).
\]
This reduction still requires information about the individual Eulerian row. A [degree-30 counterexample](reciprocal_obstruction.md) shows that reciprocity, simple negative input roots and the prescribed multiplicity at −1 can all hold while the output has a nonreal pair. The analogous assertion without the reciprocity requirement already fails: for \(m=18\) and \(b(z)=(z+1024)^{18}\), the degree-19 output has only 17 real zeros, including zero, by exact root isolation. For descent in the row index, even the natural linear lowering operator \(L H_j=jH_{j-1}\) fails to preserve real-rootedness on general inputs. The first three rows give \(L(z^3)=3z^2-10z+10\).

The two-sided theorem admits an exact multiplicity statement. For \(p>1\), begin with the simple-rooted shifted row \(az(q+pz)\) at \(n=2\). By the perturbation argument above, a multiple nonzero root of the next shifted row would annihilate the whole range of its stability-preserving operator. The test polynomial \(1\) has image \(a(n+1)z\), excluding this possibility. The zero at the origin is simple by positivity of the constant term of \(B_{n,p,q}\). Induction gives simple roots throughout. If \(q>1\), the reciprocity \(z^{n-1}B_{n,p,q}(1/z)=B_{n,q,p}(z)\) gives the same conclusion.

At \(p=q=1\), write \(B_n=B_{n,1,1}\). In the Eulerian insertion recurrence, both contributions from index \(k\) in the preceding row acquire the same multiplier \((k+1)(n-k)\) after factorial weighting. Thus
\[
B_{n+1}=(1+z)(\vartheta+1)(n-\vartheta)B_n,\qquad B_1=1 .
\]
In homogeneous form this is \(\mathcal B_{n+1}=(z+w)\partial_z\partial_w(zw\mathcal B_n)\), where \(\mathcal B_n=w^{n-1}B_n(z/w)\). It gives an elementary proof and exact multiplicities for the inverse-binomial normalization used in the reduction. The operator \(\vartheta+1\) is \(f\mapsto(zf)'\), and \(n-\vartheta\) is its conjugate by degree-\((n-1)\) coefficient reversal. If a polynomial has only strictly negative roots and multiplicities at most two, the derivative of \(zf\) has only strictly negative simple roots by Rolle's theorem and the multiplicities at the original roots. Both commuting operators therefore give a simple-rooted polynomial \(R\) before multiplication by \(1+z\). Its coefficients are reciprocal, since \((k+1)(n-k)\) is invariant under \(k\mapsto n-1-k\). A reciprocal polynomial of degree \(n-1\) has multiplicity at \(-1\) congruent to \(n-1\) modulo two, by removing factors \(1+z\) until the quotient is nonzero at \(-1\). Hence the only possible multiple root of \(B_n\) is \(-1\). Its multiplicity is exactly two for odd \(n\ge3\) and exactly one for even \(n\ge2\).

The placement of the weight matters in comparing related transformations. The [weighted Euler transform](https://arxiv.org/abs/2611.17839) weights the terms of the infinite series before taking its numerator. Here \((a)_j\) weights the coefficients of the finite Eulerian numerator after it has been formed. The [Eulerian transformation](https://arxiv.org/abs/2103.00890) instead maps a monomial to the entire Eulerian row of that degree. The [finite-row project for the ordinary square](https://www.trureturing.org/knowledge/node/032d385e484df10c856ebfdfefc165b868e8afed832b6b845250afc08ee8eec6/) includes certified individual examples. We found no matching statement of Theorem 1 or the matrix-square spacing theorem in this targeted search. The [companion checker](check_factorial_symbol.py) verifies symbol identities and isolates rational examples exactly. It also checks that the operator \(z^j\mapsto A_j(z)/j!\) takes \(z(z+50)^9\) to a degree-ten polynomial with only eight real zeros. Thus applying that operator to a general factored input requires additional information to conclude real-rootedness.

## Local spacing for the ordinary matrix square

Let
\[
 z=z(t)=-\frac{1+e^t}{t+\pi i},\quad r=|z|,\quad
 \theta=\arg z=\frac{\pi}{2}+\arctan(t/\pi),\quad G_n(z)=z S_n(z).
\]
Write \(G_n(z)=n!\prod_{\ell=1}^{n+1}(z+\lambda_\ell)\), with all \(\lambda_\ell\ge0\), and choose the unwrapped phase
\(\Phi_n(t)=\sum_\ell\arg(z(t)+\lambda_\ell)\) using arguments in \((0,\pi)\).

**Theorem 2.** The phase \(\Phi_n\) is strictly increasing from \(0\) to \((n+1)\pi\). Fix a compact interval \(I\subset\mathbb R\). For all sufficiently large \(n\), every solution \(\tau\in I\) of \(\Phi_n(\tau)=(k+\tfrac12)\pi\) gives a unique simple zero \(H_n(-e^{t_*})=0\) within \(O_I(e^{-c_I n}/n)\) of \(\tau\) for some \(c_I>0\). Conversely every real log-zero in \(I\) arises in this way with its phase solution allowed the same endpoint tolerance. Uniformly for consecutive log-zeros \(t_*<t_{**}\) in \(I\),
\[
 t_{**}-t_*=\frac{t_*^2+\pi^2}{n}
 \left(1+O_I\left(\frac{\log\log n}{\log n}\right)\right).
\]
This concerns the actual zeros of the ordinary square. The classical log-Cauchy law for an ordinary Eulerian row is reviewed by [Melotti](https://arxiv.org/abs/2507.15908). A [companion proof](density_one.md) gives the limiting distribution for all fixed ordinary matrix powers.

To prove the phase assertion write \(y=\operatorname{Im}z\). Then \(\theta'=\pi/(t^2+\pi^2)>0\) and
\[
 y'=\frac{\pi[e^t(t^2-2t+\pi^2)-2t]}{(t^2+\pi^2)^2}>0.
\]
For \(t\le0\) positivity is immediate. For \(t>0\) the numerator divided by \(\pi\) is at least \((t-2)^2+\pi^2-4>0\). Thus
\[
 \frac{d}{dt}\arg(z+\lambda)=
 \frac{r^2\theta'+\lambda y'}{|z+\lambda|^2}>0 .
\]
At \(-\infty\), \(z\) approaches zero with argument tending to zero. At \(+\infty\), \(r\to\infty\) and \(\theta\to\pi\). The stated endpoint limits follow.

Work on a fixed enlargement of \(I\) by one unit at either end. Write \(c_j=j! A(n,j)\), \(m=\lceil 3n\log\log n/\log n\rceil\), \(J=n-m\). Equation (1) of the [companion proof](density_one.md) gives \(\sum_{j<J}c_j/\sum_{j\ge J}c_j\le\exp(-(2+o(1))n\log\log n)\). The radius \(r\) ranges in a compact subset of \((0,\infty)\). Multiplying each summand by \(r^j\) costs at most an \(\exp(O_I(n))\) factor in this bound. The logarithmic derivative of the factored polynomial therefore gives
\[
 \sum_\ell\frac{\lambda_\ell}{r+\lambda_\ell}
 =n+1-\frac{rG_n'(r)}{G_n(r)}
 =\frac{\sum_j(n-j)c_jr^j}{\sum_jc_j r^j}
 \le m+o(1).
\]
For \(u=\lambda/(r+\lambda)\) the squared factor ratio is
\[
 \frac{|z+\lambda|^2}{(r+\lambda)^2}
 = 1-4u(1-u)\sin^2(\theta/2).
\]
Over this compact interval it is bounded away from zero, and its negative logarithm is \(O_I(u)\). Hence
\[
 |G_n(z)|\ge e^{-C_I m}G_n(r).
\]
Also \(|z+\lambda|\gg_I r+\lambda\), so
\[
 \left|\frac{z'}{z+\lambda}-\frac{z'}z\right|
 \le C_I\frac{\lambda}{r+\lambda}.
\]
Summing the imaginary parts yields \(\Phi_n'=(n+1)\theta'+O_I(m)\); summing the absolute logarithmic derivatives bounds \(\left|d\log|G_n(z)|/dt\right|=O_I(n)\).

Let \(z_k=-(1+e^t)/(t+(2k+1)\pi i)\). The exact partial fraction expansion in the companion proof gives \(H_n(-e^t)=\sum_{k\in\mathbb Z}G_n(z_k)\). The pair \(k=0,-1\) contributes \(2\operatorname{Re}G_n(z)\). Denote the rest by \(R(t)\). Uniformly, the remaining \(|z_k|/r\) are at most \(\eta_I<1\) and the sum of their squares is bounded. Consequently, on degrees \(j\ge J\) the absolute sum of their powers \(j+1\) is \(O_I(\eta_I^{J-1}r^{j+1})\). For \(j<J\) it is \(O_I(r^{j+1})\), absorbed by the weighted concentration estimate. Moreover \(|z'_k/z_k|=O_I(1)\) uniformly in \(k\); differentiating each power costs at most \(O_I(n)\). The squared ratio bound justifies termwise differentiation. These estimates give \(|R|+|R'|\le e^{-c n}G_n(r)\) for some \(c=c(I)>0\). Dividing by \(2|G_n(z)|\) and using the logarithmic derivative bound proves
\[
 \frac{H_n(-e^t)}{2|G_n(z)|}=\cos\Phi_n(t)+\epsilon_n(t),\qquad
 |\epsilon_n|+|\epsilon_n'|\le e^{-c_I n}.
\]

Use phase as coordinate, since \(\Phi_n'\gg_I n\). Outside the phase intervals of radius \(\pi/4\) centered at half-integral multiples of \(\pi\), the cosine has absolute value at least \(1/\sqrt2\). Inside each such interval the derivative of cosine has absolute value at least \(1/\sqrt2\) and constant sign. For centers in \(I\), the entire interval lies inside the enlargement for large \(n\). The error preserves the opposite endpoint signs and strict monotonicity, giving exactly one simple zero. Each zero is within \(O_I(e^{-c_In})\) in phase and \(O_I(e^{-c_In}/n)\) in \(t\) of its center. The enlargement also covers phase intervals around all zeros originally in \(I\). Consecutive zero phases differ by \(\pi+O_I(e^{-c_In})\). The mean value theorem, the derivative estimate and smoothness of \(\theta'\) now give the displayed spacing.

The constants above depend on the compact interval. The proof leaves open the transition to the ranges \(|t|\to\infty\) required for all roots of \(H_n\).

### Every zero in a fixed complex annulus is eventually real

For every $0<a<b<\infty$, all zeros of $H_n$ in $a\le|x|\le b$ are simple and lie on the negative real axis once $n$ is sufficiently large. In particular any possible sequence of nonreal zeros eventually leaves every compact subset of $\mathbb C\setminus\{0\}$.

First exclude a fixed angular neighborhood of the negative ray. With the principal logarithm, the leading pole is $w=(x-1)/\operatorname{Log}x=\int_0^1 x^v\,dv$, including $w=1$ at $x=1$. On this compact region $|w|$ is bounded above and away from zero and its argument stays away from $\pm\pi$. Indeed for the upper half-plane all $x^v$ lie in the sector between arguments $0$ and $\arg x$, and the lower half-plane follows by conjugation. All other pole moduli $|(x-1)/(\operatorname{Log}x+2\pi i l)|$ are at most $\eta |w|$, $\eta<1$, uniformly by the squared denominators. Their squared normalized moduli have bounded sum. The radial concentration and factor estimates of Theorem 2 apply on any such compact set of $w$. They give $|G_n(w)|\ge e^{-O(m)}G_n(|w|)$ while the remaining poles contribute $O(e^{-cn})G_n(|w|)$. Hence this region has no zeros for large $n$.

In the excluded neighborhood use $x=-e^s$, with $s=t+iv$ in a thin complex strip whose real interval is $[\log a-1,\log b+1]$. Put $z_\pm(s)=-(1+e^s)/(s\pm i\pi)$. Take the strip sufficiently narrow that both stay in compact sets around their respective upper and lower arcs, bounded away from the nonpositive real axis and from zero. Choose analytic logarithms $L_\pm(s)=\log G_n(z_\pm(s))$ by summing the individual factor logarithms used in Theorem 2, with conjugate values on the real interval. Define $\Phi=(L_+-L_-)/(2i)$ and $D=\exp((L_++L_-)/2)$. The sum of the two leading terms is $2D\cos\Phi$.

Uniformly on the strip, the same concentration estimate yields
\[
 L_\pm'=(n+1)z_\pm'/z_\pm+O_{a,b}(m).
\]
Indeed the sum of the differences of the individual logarithmic derivatives from $z_\pm'/z_\pm$ is bounded by a constant times $\sum_\ell\lambda_\ell/(|z_\pm|+\lambda_\ell)=O(m)$. Consequently $\Phi'=(n+1)\pi/(s^2+\pi^2)+O_{a,b}(m)$, so on a narrow fixed strip $\operatorname{Re}\Phi'\ge c_1n$ and $|\Phi'|\le C_1 n$. All poles other than this pair have moduli at most a fixed $\eta<1$ times **both** $|z_+|$ and $|z_-|$, by continuity from the real interval and the squared-denominator formula. The previous concentration bound therefore gives a remainder $O(e^{-c_2n})\min(G_n(|z_+|),G_n(|z_-|))$. The radial factor bounds give $|D|\ge e^{-O(m)}\sqrt{G_n(|z_+|)G_n(|z_-|)}$, so after division by $2D$ the perturbation of $\cos\Phi$ is uniformly $O(e^{-c_3n})$.

If the perturbed function vanishes, $|\cos\Phi|^2=\cos^2(\operatorname{Re}\Phi)+\sinh^2(\operatorname{Im}\Phi)$ puts $\Phi$ within $O(e^{-c_3 n})$ of a real half-integral multiple of $\pi$. Since $\Phi$ is real on the real interval and $\operatorname{Re}\Phi'\ge c_1 n$, integration vertically shows $|v|=O(e^{-c_3 n}/n)$. The upper derivative bound then shows that the corresponding exact real phase center $t_0$ is within $O(e^{-c_3n}/n)$ of $s$, using the real interval enlargement at its ends. To count a center disk choose fixed small $\gamma>0$ with $C_1\gamma<1/4$. On $|s-t_0|=\gamma/n$, integrating the derivative on a straight segment gives $c_1\gamma\le|\Phi(s)-\Phi(t_0)|\le C_1\gamma$. The same segment argument shows $\Phi$ is injective on the disk, because its derivative has strictly positive real part. Hence $\cos\Phi$ has exactly one simple zero there and its boundary modulus is bounded below independently of $n$. Rouché gives the same count for $H_n(-e^s)$; conjugation makes its unique zero real. The two regions cover the annulus.
