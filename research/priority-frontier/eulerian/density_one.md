# A density-one theorem for zeros of the ordinary Eulerian matrix square

Write \(A_j(x)=\sum_{k=1}^j E(j,k-1)x^k\), where \(E(j,k)\) counts permutations with \(k\) descents, and let \(H_n(x)=\sum_{j=1}^n E(n,j-1)A_j(x)\). This is the original ordinary matrix square of [Mao and Wang, §4](https://arxiv.org/html/2607.01572v1).

**Theorem.** Let \(N_n(I)\) count the distinct strictly negative real zeros \(x\) of \(H_n\) with \(\log|x|\in I\). For every bounded open interval \(I=(a,b)\),
\[
 N_n(I)/n\ \longrightarrow\ \int_a^b \frac{dt}{\pi^2+t^2}.
\]
In particular \(n-o(n)\) distinct roots are strictly negative. Equivalently, the normalized distribution of their logarithmic magnitudes converges weakly to the centered Cauchy law of scale \(\pi\). Counting multiplicities instead gives the same limit. The result leaves room for \(o(n)\) nonreal roots. It controls the bulk, complementing the individual extreme pairs in the companion note.

For ordinary Eulerian rows the same limiting law is classical. The argument here obtains the law for the matrix square directly from real sign changes without a premise that its rows are real-rooted. [Melotti, Distribution of the roots of Eulerian polynomials](https://arxiv.org/abs/2507.15908)

### The dominant conjugate pair

For \(t\in\mathbb R\), put \(z_k(t)=-(1+e^t)/(t+(2k+1)\pi i)\), \(k\in\mathbb Z\), and write \(z=z_0\), \(r=|z|\), \(\theta=\arg z=\pi/2+\arctan(t/\pi)\). The Eulerian power-sum identity gives
\[
 A_j(-e^t)=j!\sum_{k\in\mathbb Z} z_k(t)^{j+1},\qquad j\ge1.
\]
Indeed, differentiate \(1/(1-e^s)\) \(j\) times at \(s=t+i\pi\), then multiply by \((1-e^s)^{j+1}\). The derivative partial fraction formula follows at order one from \(\sum_{k\in\mathbb Z}(s+2\pi i k)^{-2}=e^s/(1-e^s)^2\), the classical partial fractions of the squared cosecant, and then by locally uniform differentiation. This proof also holds for \(t\ge0\) by continuation. The two poles \(k=0,-1\) are conjugate. Uniformly on a fixed \(I\) and its endpoints all other moduli are at most \(\eta r\) for a constant \(\eta<1\). In addition \(\sum_k |z_k/z|^2=O_I(1)\).

Put \(c_{n,j}=E(n,j-1)j!\). Let \(m=\lceil 3n\log\log n/\log n\rceil\), \(J=n-m\), and consider sufficiently large \(n\), for which \(1\le J<n\). Define
\[
 P(z)=\sum_{j=J}^n c_{n,j}z^{j-J},\qquad S=P(1).
\]
The coefficients discarded from the bottom satisfy
\[
 \sum_{j<J} c_{n,j}/S \le \exp[-(2+o(1))n\log\log n]. \tag{1}
\]
For a proof choose \(h=\lfloor n/(3\log n)\rfloor\); symmetry gives \(E(n,n-h-1)=E(n,h)\ge(h+1)^n/2\). This follows by assigning values to \(h+1\) ordered bins and sorting within bins. At most \(h(n+1)h^n\) assignments have a boundary across which the bins concatenate in increasing order, including an empty bin, by merging this pair and recording the cut. Every other assignment represents a unique permutation with \(h\) descents. The discarded sum is at most \(nn!(n-m)!\), whereas \(S\ge (n-h)!(h+1)^n/2\ge n! n^{-h}(h+1)^n/2\). Taking logarithms proves (1).

Since \(r\) stays in a compact positive interval on \(\overline I\), the dominant-pair formula and (1) imply uniformly
\[
 H_n(-e^t)=2\Re\big[z^{J+1}P(z)\big]+O_I\!\left(Sr^{J+1}e^{-\kappa n}\right) \tag{2}
\]
for some \(\kappa=\kappa(I)>0\). In detail the low-degree terms on all poles have total magnitude at most \(O_I(1)\exp(O_I(n))\sum_{j<J}c_{n,j}\) after division by \(r^{J+1}\). For \(j\ge J\) the sum of the nonleading powers after the same division is at most \(O_I(1)\eta^{J-1}\exp(O_I(m))\) times \(S\). Here \(m=o(n)\).

### Exceptional intervals for the short polynomial

The map \(t\mapsto z(t)\) is bi-Lipschitz on \(\overline I\). Indeed \(r>0\), \(\theta'>0\) there, \(\theta\) ranges over an interval shorter than \(\pi\), and
\[
 |z(t)-z(u)|^2\ge 4\min_{\overline I}r^2\sin^2\big((\theta(t)-\theta(u))/2\big).
\]
Factor \(P(z)/S=\prod_{\lambda}(z-\lambda)/(1-\lambda)\) using its \(m\) roots with multiplicity; \(P(1)>0\). For roots with \(|\lambda|>2+2\max r\) each quotient has modulus bounded below by an absolute positive constant. For the remaining roots let \(t_\lambda\in\overline I\) minimize \(|z(t)-\lambda|\). The triangle inequality and bi-Lipschitz estimate give \(|z(t)-\lambda|\ge |z(t)-z(t_\lambda)|/2\ge c_I|t-t_\lambda|\). Also \(|1-\lambda|\) is bounded above. With \(D=1+b-a\), a constant \(C_I>0\) consequently gives
\[
 |P(z(t))|/S\ \ge\ e^{-C_I m}p(t),\qquad
 p(t)=\prod_{\lambda\ {\rm bounded}}\frac{|t-t_\lambda|}{D}
\]
with empty product one.

Delete the set \(p(t)<e^{-\kappa n/3}\). It is a union of \(O(m+1)\) intervals because the sublevel condition can be squared to a real polynomial inequality of degree at most \(2m\). Its length is \(O_I(m/n)\): the integral of \(-\log(|t-t_\lambda|/D)\) on \(I\) is bounded by a constant depending only on \(I\), uniformly in \(t_\lambda\), and the integrands are nonnegative. On the remaining closed components the amplitude \(|z^{J+1}P(z)|\) exceeds the error in (2) for sufficiently large \(n\).

### Phase and sign count

Each straight line meets the open arc \(z(t)\) at at most four parameter values. Indeed a line equation after multiplication by \(t^2+\pi^2\) has form \(p_2(t)+(c t+d)e^t=0\) with \(\deg p_2\le2\). If \(c=d=0\), the remaining polynomial is nonzero for a genuine line. Otherwise the third derivative is \(e^t\) times a nonzero polynomial of degree at most one, and Rolle's theorem gives the claim. No line contains the arc.

For any fixed \(\lambda\), the total variation of \(\arg(z(t)-\lambda)\) over the disjoint retained intervals is at most \(8\pi\). Indeed the integral of its absolute derivative equals the integral over angles \(0\le\alpha<2\pi\) of the number of intersections with the ray from \(\lambda\) at angle \(\alpha\). This elementary one-dimensional change of variables follows by splitting into monotone pieces of the argument. On retained intervals \(z(t)\ne\lambda\); its analytic argument derivative has finitely many zeros on each closed interval, as a constant argument on any segment would place the arc on a line. Each ray has at most four intersections. Summing the variations of all factors bounds the variation of \(\arg P(z(t))\) over retained intervals by \(8\pi m\).

On each nontrivial retained interval choose a continuous phase \(\Phi=(J+1)\theta+\arg P(z)\). If its endpoint increment is \(\Delta\Phi\), there are at least \(\Delta\Phi/\pi-2\) sign changes of \(H_n(-e^t)\) strictly inside the interval. For a positive increment, select in order first hits of the multiples of \(\pi\) strictly between the endpoint phases. At each such sample (2) has the sign of \(\cos\Phi\); consecutive signs are opposite. A nonpositive lower bound needs no samples.

The retained intervals cover all but length \(O_I(m/n)\), and \(\theta'\) is bounded. Summing gives
\[
 N_n(I)\ \ge\ \frac{n}{\pi}(\theta(b)-\theta(a))-O_I(m+1). \tag{3}
\]
Since \(\theta'/\pi=1/(\pi^2+t^2)\) integrates to one on the entire real line, (3) applied to \((-M,a)\) and \((b,M)\) also gives the corresponding upper limit on \(I\) by the degree bound. Let \(M\to\infty\). This proves the interval limit, tightness, and the density-one assertion. The number of extra multiplicities and the number of nonreal zeros together are \(o(n)\).

### All fixed ordinary matrix powers

For every fixed integer $p\ge2$, the same negative-root counting measure and limiting Cauchy distribution hold for the rows of $A^p$. In fact the analytic argument only used factorial concentration of the last matrix multiplication. Now its coefficients are $c_{n,j}=(A^{p-1})_{n,j}\,j!$. Let $m=\lceil(p+2)n\log\log n/\log n\rceil$, and keep $j\ge n-m$. Each entry of each factor is at most $n!$. Counting all choices of intermediate indices bounds the discarded sum by $n^{p-1}(n!)^{p-1}(n-m)!$.

To lower bound the retained sum choose $h=\lfloor n/(3\log n)\rfloor$ and the single path through the indices $u_i=n-ih$, $0\le i\le p-1$. Its Eulerian factors are $E(u_{i-1},h)\ge(h+1)^{u_{i-1}}/2$ by the bin argument above, since $h(u_{i-1}+1)\exp[-u_{i-1}/(h+1)]=o(1)$ uniformly over this fixed number of steps. The logarithm of the product of these factors and $u_{p-1}!$ is at least $pn\log n-(p-1)n\log\log n-O_p(n)$. The logarithm of the discarded upper bound is at most $pn\log n-m\log n+O_p(n)$. The discarded-to-retained ratio is thus at most $\exp[-(3+o(1))n\log\log n]$. The last ordinary multiplication uses exactly the same Eulerian pole expansion, so the sign-counting proof applies without further changes.

### A quantitative global deficit

For any fixed \(p\ge2\) the number of roots left over after counting each distinct strictly negative root once is
\[
 O_p\!\left(n\left(\frac{\log\log n}{\log n}\right)^{1/3}\right).
\]
Here the degree counts all multiplicities including the root at zero.

Use the first truncation for \(p=2\), or the fixed-power version above, and put \(B=\epsilon(n/m)^{1/3}\) for an absolute, sufficiently small \(\epsilon>0\). Work on \(-B\le t\le B\), taking \(n\) sufficiently large that \(B\ge2\). Uniformly there \(c/B\le r\le C e^B\) for absolute \(c,C>0\). The nearest competing modulus ratio is at most \(((B^2+\pi^2)/(B^2+9\pi^2))^{1/2}\le e^{-c'/B^2}\). The sum \(\sum_k |z_k/z|^2=O(B^2)\) follows termwise from the squared denominators. Thus high-degree competing poles contribute at most \(S r^{J+1} O(B^2)\exp(O(Bm)-c'(J-1)/B^2)\). For discarded terms with \(j<J\), the worst relative weight \(r^{j-J}\) is at most \((CB)^n\), and \(\log B\le(\log\log n)/3+O_p(1)\). The factorial concentration bound (1) absorbs this loss. Since \(mB^3=\epsilon^3 n\), taking \(\epsilon\) small gives (2) with relative error at most \(e^{-c_0n/B^2}\) for an absolute \(c_0>0\).

It is helpful to delete exceptional intervals in the **angle** coordinate directly. Parametrize \(z\) by \(\vartheta=\theta(t)\) in the interval \(\Theta=\theta([-B,B])\subset(0,\pi)\). Its lower distance bound is \(|z(\vartheta)-z(\psi)|\ge c''|\vartheta-\psi|/B\), by the sine inequality already used. For each bounded root \(|\lambda|\le 2+2\max r\) choose the angle \(\vartheta_\lambda\) of a nearest arc point. The product estimate now reads
\[
 |P(z)|/S\ \ge\ \exp(-C_1Bm)
 \prod_{\lambda\ {\rm bounded}}\frac{|\vartheta-\vartheta_\lambda|}{\pi}.
\]
Indeed the bounds for the normalized factors cost \(O(B+\log B)\) per root, using \(1+|\lambda|=O(e^B)\); the far roots cost only a constant each. Reduce \(\epsilon\) if necessary so that \(C_1Bm\le c_0 n/(4B^2)\). Delete angles for which the product is below \(e^{-c_0n/(2B^2)}\). The deleted set has \(O(m+1)\) components and total angular length \(O(m B^2/n)\), since \(\int_0^\pi\log(\pi/|\vartheta-u|)\,d\vartheta\le 2\pi\) for any \(u\in[0,\pi]\). The phase-sign argument gives at least \((J+1)|\Theta|/\pi-O(mB^2+m)\) distinct negative roots. Finally \(|\Theta|=\pi-O(1/B)\), so the deficit is \(O(n/B+mB^2+m)=O(n^{2/3}m^{1/3})\), as stated.
