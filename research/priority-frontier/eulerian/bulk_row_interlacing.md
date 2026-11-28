# Interlacing and relative displacements between genuine Eulerian square rows

Let \(H_n(x)=\sum_j A(n,j)A_j(x)\) be the ordinary matrix-square row for shifted Eulerian numbers. List the logarithms of the nonzero root moduli as \(t_{n,1}<\cdots<t_{n,n-1}\) for sufficiently large \(n\), using the [eventual simple-negative-root theorem](cube_root_transition.md). Put
\[
                      u(t)=\tfrac12+\pi^{-1}\arctan(t/\pi).
\]
For any fixed compact real interval \(I\), if \(t=t_{n,k}\) and \(t_{n,k+1}\) lie in \(I\), then for all sufficiently large \(n\)
\[
 t_{n,k}<t_{n+1,k+1}<t_{n,k+1},\qquad
 \frac{t_{n+1,k+1}-t_{n,k}}{t_{n,k+1}-t_{n,k}}
               =1-u(t)+o_I(1).
\]
There is exactly one row-\(n+1\) root in that gap. More generally, fix an integer lag \(p\ge1\) and an interval \(I\) where \(p u(t)\) stays a positive distance from the integers. The unique row-\(n+p\) root in each such gap has index \(k+1+\lfloor pu(t)\rfloor\), and its relative location tends to \(1-\{pu(t)\}\), uniformly on \(I\).

Consequently, for every fixed positive lag, a fraction tending to one of all row-\(n\) gaps contain exactly one row-\(n+p\) root. The relative positions in these gaps have the uniform limiting law on \([0,1]\). This is a cross-row statement for the actual ordinary square; single-row asymptotic spacing alone does not determine it.

## A ratio limit from the insertion recurrence

Write \(S_n(z)=\sum_j j!A(n,j)z^j\), \(G_n(z)=zS_n(z)\), and \(D=z\partial_z\). We first prove, locally uniformly on the slit plane \(\mathbb C\setminus(-\infty,0]\),
\[
           \frac{\log n}{n^2}\frac{G_{n+1}(z)}{G_n(z)}
                          \longrightarrow z.                       \tag{1}
\]
For real \(r\) in a compact subinterval of \((0,\infty)\), tilt the coefficients \(j!A(n,j)\) by \(r^j\) and put \(h=n-j\). Then uniformly
\[
              \mathbb Eh\sim n/\log n,qquad
              \operatorname{Var}(h)=O(n/(\log n)^2).                \tag{2}
\]
Here is the fixed-radius detail of the [tilted-row estimate](positive_middle.md). Up to a common factor the weights are \((n-h)!E(n,h)r^{-h}\), bounded by \(W_h=(n-h)!(h+1)^n r^{-h}\). Put \(b=\log(nr)\), \(s=\sqrt n/b\). The successive log-ratio \(L_h=n\log(1+1/(h+1))-\log(r(n-h))\) has a crossing mode \(J\sim n/b\), with \(L_{J-1}\ge0\ge L_J\). On \(J/2\le h\le2J\) the ratio differences \(L_h-L_{h+1}\asymp1/s^2\) follow by taking the difference of this displayed expression. In particular \(n/(J+1)=b+o(1)\), since \(L_J=O(s^{-2})\), \(J=o(n)\), and \(n/J^2=o(1)\). The same differences give an upper Gaussian envelope \(W_h/W_J\le C\exp[-c(h-J)^2/s^2]\) in this interval and a positive constant lower bound for \(|h-J|\le s\). Outside it \(W_h/W_J\le e^{-c' n}\) by the factorial upper and lower tail bounds in the tilted-row estimate. Those bounds use only \(J\sim n/b\), independent of whether \(r\) tends to infinity.

For \(|h-J|\le s\) we have \((n+1)e^{-n/(h+1)}=r^{-1}(1+o(1))\). Eulerian inclusion-exclusion gives \(E(n,h)/(h+1)^n=e^{-1/r}+o(1)\) there, uniformly in \(r\). Indeed its summand of fixed index \(a\) differs by \(o(1)\) from \((-1)^a r^{-a}/a!\) because \(n/h^2=o(1)\); its absolute value is at most \(((n+1)e^{-n/(h+1)})^a/a!\), a summable majorant on the compact radii. Thus the total true weight is at least \(c''s W_J\). Summing the Gaussian upper bound on centered second moments gives \(\mathbb E(h-J)^2=O(s^2)\). This proves (2).

By the [factorial-row theorem](factorial_symbol.md), write \(S_n(z)=n!\prod_{l=1}^n(z+\lambda_l)\) with \(\lambda_l\ge0\). Put \(T_n(z)=\sum_l \lambda_l/(z+\lambda_l)\). At \(r>0\) the positive tilt factors into independent Bernoulli factors, so
\[
 T_n(r)=\mathbb Eh,\qquad
 V_n(r)=\sum_l\frac{r\lambda_l}{(r+\lambda_l)^2}=\operatorname{Var}(h).
\]
For \(z\) in any fixed compact subset of the slit plane and \(r=|z|\), one has \(|z+\lambda|\ge c(r+\lambda)\) for all \(\lambda\ge0\). Subtracting the factors and differentiating them gives
\[
  |T_n(z)-T_n(r)|+|D T_n(z)|=O(V_n(r)).
\]
Thus \(T_n(z)\sim n/\log n\), with the error uniform and the asymptotic leading value real. Using \(DS_n/S_n=n-T_n\) in the exact recurrence \(S_{n+1}=DS_n+z(D+1)(n+1-D)S_n\) gives
\[
 \frac{S_{n+1}}{S_n}=n-T_n+z\big((n+1-T_n)(1+T_n)+D T_n\big).
\]
This proves (1). With the branch of each logarithm real at positive real \(z\), the imaginary part of \(\log G_{n+1}-\log G_n\) tends locally uniformly to \(\arg z\). Indeed (1) divided by \(z\) tends uniformly to 1 on a connected compact enlargement joining the chosen set to a positive real point, so its small analytic logarithm agrees there with the normalized branch.

## Matching the phases to absolute ranks

At \(z(t)=-(1+e^t)/(t+\pi i)\) we have \(\arg z(t)=\pi u(t)\). Write \(\Phi_n(t)=\arg G_n(z(t))\) with the argument continuously lifted from the positive axis. By (1), for fixed \(p\), uniformly on compact \(t\)-intervals,
\[
              \Phi_{n+p}(t)-\Phi_n(t)=p\pi u(t)+o(1).                \tag{3}
\]
The [compact phase theorem](factorial_symbol.md) gives \(\Phi'_n(t)\sim n\pi u'(t)>0\) and puts each true root exponentially close in phase to a unique center \((a+1/2)\pi\), with one root per center. Here the integer \(a\) is the absolute nonzero-root index. To see this, take a fixed real interval starting below both the compact set under study and \(-2\), and anchor on it at an integer phase \(a_0\pi\) below \(-1\) in the radius range of the [counted-disk theorem](left_disk.md). Such points exist there for large \(n\) since \(\Phi'_n\gg n\) on each fixed interval. The corresponding disk contains exactly \(a_0\) zeros including zero. Propagating through the ordered half-integral centers in the compact interval shows that the center \((a+1/2)\pi\) corresponds to the \(a\)-th nonzero root, counted from smallest modulus.

At both ends of the given gap the row-\(n+p\) phases thus equal the row-\(n\) center phase plus \(p\pi u(t)+o(1)\), since the gap is \(O_I(1/n)\). The hypothesis keeps these two phases strictly separated from every row-\(n+p\) center by a fixed positive margin. There is exactly one intervening center, at index \(k+1+\lfloor p u(t)\rfloor\). Its phase distance from the left endpoint is \(\pi(1-\{pu(t)\})+o(1)\). Dividing by the full gap's phase increment \(\pi+o(1)\), and using \(\Phi'_{n+p}(v)\sim n\pi u'(t)\) throughout this gap, proves the stated location.

Finally the [log-Cauchy law for the ordinary square](density_one.md) makes \(u(t_{n,k})\) asymptotically uniform on \([0,1]\). For fixed \(p\), discard small neighborhoods of the finitely many points \(a/p\), \(0\le a\le p\), in this unit interval. The remainder is a finite union of compact nonresonant intervals. The discarded proportion is arbitrarily small, and so is the loss from their finitely many gap endpoints. The stated gap count and the uniform distribution of relative positions follow since the map \(v\mapsto1-\{pv\}\) preserves the uniform law.
