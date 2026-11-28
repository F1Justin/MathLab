# Strict cross-row interlacing through the positive square-root scale

For some absolute \(c>0\), for all sufficiently large \(n\), each nonzero root of the genuine ordinary Eulerian square row with log-modulus \(t_{n,k}\le c\sqrt n\) satisfies
\[
                  t_{n+1,k}<t_{n,k}<t_{n+1,k+1}.
\]
The [left-side theorem](left_row_interlacing.md) proves this up to every fixed upper bound. The new range is \(T=t_{n,k}\to+\infty\). The remaining outer regimes have \(T/\sqrt n\) bounded below by a larger positive constant.

We first work along every sequence \(T\to\infty,\ T/\sqrt n\to0\), where all the moments and estimates below are uniform in the sequential sense. Put \(N=1+e^T,\ z_l=-N/(T+i(2l+1)\pi),\ z=z_0,\ r=|z|,\ y=\Im z>0\). Write \(G_n=zS_n\), \(S_n=n!\prod_{j=1}^n(z+\lambda_j)\), and set \(b_j=\lambda_j/(z+\lambda_j)\), \(a_j=z/(z+\lambda_j)\). According to (1)–(3) of the [positive-middle estimates](positive_middle.md), with \(d=\log(nr)\), \(K=n/T^2\) and \(t_j=\lambda_j/(r+\lambda_j)\),
\[
 m=\sum_j t_j\sim n/d,\qquad V=\sum_jt_j(1-t_j)\sim n/d^2,qquad
 \sum_{l\ne0,-1}|G_n(z_l)/G_n(z)|\le e^{-\gamma K}.                 \tag{1}
\]
The proof there bounds in fact each ratio by \(\exp(-\gamma K l^2)\) when \(|l|\le T/100\) outside the nearest pair. On \(|l|>T/100\) the sum is \(O(T)e^{-\gamma'n}\). Both stronger bounds hold in the present sequential regime. Adding or deleting the extra zero factor for \(G_n\) affects neither \(m\) nor \(V\).

## Positive imaginary part of the row ratio

Write \(Q=G_{n+1}/G_n\). The [exact two-factor formula](left_row_interlacing.md) gives
\[
    Q=\sum_j a_j+z\big[n+1+(n-1)\sum_j b_j-\sum_{j\ne k}b_j b_k\big].
\]
Set \(B=\sum_j |b_j|^2,\ C=\sum_j\lambda_j/|z+\lambda_j|^2\).
Since \(|z+\lambda_j|\le r+\lambda_j\), one has \(B\ge m-V\sim m\). Direct multiplication gives
\[
 \frac{\Im a_j}{y}=\frac{\lambda_j}{|z+\lambda_j|^2},\quad
 \frac{\Im(z b_j)}{y}=|b_j|^2,\quad
 \frac{\Im(z b_j b_k)}{y}
  =\frac{\lambda_j\lambda_k(\lambda_j\lambda_k-r^2)}
         {|z+\lambda_j|^2 |z+\lambda_k|^2}.
\]
The sum of the last expression over *all* ordered pairs is \((B-rC)(B+rC)\). We claim
\[
 B+rC=O(B),\qquad |B-rC|=o(n),\qquad
 \left|\sum_j\frac{\Im(z b_j^2)}y\right|=O(TB).
 \tag{2}
\]
For \(\lambda<r/2\) the term \(r\lambda/|z+\lambda|^2\) is \(O(t_j)\); for \(\lambda\ge r/2\) it is at most \(2|b_j|^2\). This proves the first bound. The terms of \(B-rC\) equal \(\lambda(\lambda-r)/|z+\lambda|^2\). They are \(O(t_j)\) outside \([r/2,2r]\), and inside are \(O(T)\) because \(|z+\lambda|^2\gg (\lambda-r)^2+r^2/T^2\). There are \(O(V)\) near factors, giving \(O(m+TV)=o(n)\). Finally the absolute diagonal summand is at most \(|b_j|^2 |\lambda^2-r^2|/|z+\lambda|^2\ll T|b_j|^2\), by the same estimate inside the near range and the reverse triangle inequality outside it. The identities and (2) prove
\[
                    \Im Q(z)\ge y[n+1+(n-o(n))B]>0.                \tag{3}
\]

## Comparing the other poles without dividing by a small angle

For \(\beta=(2l+1)\pi\), the inverse pole is \(1/z_l=-T/N-i\beta/N\). In particular \(|1+\lambda/z_l|\ge|1+\lambda/z|\) for every \(l\), since the real parts are equal and \(|\beta|\ge\pi\). Along our sequence, (3) implies
\[
       |Q(z_l)-\Re Q(z)|\le C_0(1+|l|)\Im Q(z)                     \tag{4}
\]
with an absolute constant. Indeed \(a_{jl}=(1+\lambda_j/z_l)^{-1}\) satisfies \(|a_{jl}|\le |a_j|\) and
\[
          |a_{jl}-a_j|\le (2\pi |l|/N)\lambda_j |a_j|^2 .
\]
The middle term \((n+1)z_l\) in the two-factor formula differs from its value at \(z\) by at most \(2|l|(n+1)y\). For the terms \(\lambda_k a_{jl}a_{kl}\) telescope the two factors and sum the upper bounds, including diagonal terms harmlessly. Since \(\pi/N=y/r^2\), the total difference for the one- and two-factor terms is at most
\[
       2|l|y\big(C+C r\sum_k |b_k|+ B\sum_j |a_j|\big).
\]
One has \(\sum |b_j|=O(m+TV)=o(n)\): far terms are \(O(t_j)\) and near terms are \(O(T)\) each. Hence \(\sum|a_j|\le n+o(n)\); also \(rC=O(B)\), with \(r\to\infty\). Combining with (3) gives (4). For the far tail there is also a polynomial bound for the ratio on the left of (4) divided by \(\Im Q(z)\), independent of \(l\). Indeed \(|a_{jl}|\le |a_j|\ll T\), \(|\lambda_k a_{kl}|\le r|b_k|\ll rT\), and \(|z_l|\le r\). The two-factor formula bounds both moduli by \(O(n^2 r T^2)\); (3) gives \(\Im Q(z)\gg nr/T\).

We also record the derivative control needed to assign the exact root index in a phase cell. Put \(P_l=G_n(z_l)/G_n(z)\) and let \(\Phi_n=\arg G_n(z)\) be the lifted phase from the positive axis. Since \(z_l'/z_l=N'/N-1/(T+i\beta)\), its magnitude is \(O(1)\) and its difference from \(z'/z\) is \(O(|l|/T^2)\). Adding the extra \(a=1\) for the initial \(z\) in \(G_n\), logarithmic differentiation and the estimate for \(a_{jl}-a_j\) give
\[
                |P_l'|/|P_l|\ll |l|(y C + n/T^2)\ll |l|\Phi_n'(T).
\]
Indeed \(\Phi_n'=r^2\theta'\sum|z+\lambda|^{-2}+y'C\) with the extra zero factor included, \(\theta'=\pi/(T^2+\pi^2)\), and \(y'/y\to1\). The first summand is \(\gg n/T^2\) by \(\sum(1-t_j)^2\ge n-2m\). On the far tail one can bound the logarithmic derivative by \(O(nT)\), independently of \(l\), using \(|a_{jl}|\ll T\); this is at most a polynomial times \(\Phi_n'\).

Using the weighted Gaussian and far-tail bounds after (1), it follows that
\[
 \sum_{l\ne0,-1}\left( |P_l|+ |P_l'|/\Phi_n'
           + |P_l|\,|Q(z_l)-\Re Q(z)|/\Im Q(z)\right)=o(1).
 \tag{5}
\]
The derivatives are with respect to real \(T\), and the absolute tail estimates justify termwise differentiation. In particular \(H_n(-e^T)/(2|G_n(z)|)=\cos\Phi_n+E_n\), where \(|E_n|+|dE_n/d\Phi_n|=o(1)\); differentiation of the unit phase costs one in this coordinate. These conclusions hold also for row \(n+1\).

## Uniform range and signs

Because the preceding estimates hold along *every* sequence \(n\to\infty,T\to\infty,T/\sqrt n\to0\), there exist fixed \(M,n_0\) and \(c_1>0\) such that for \(n\ge n_0, M\le T\le c_1\sqrt n\), (3) is positive, the sum in (5) is less than \(1/20\), and \(\Phi'_n\gg n/T^2\). Otherwise one could choose a violating sequence with \(M\to\infty,c_1\to0,n_0\to\infty\). Enlarge the range into a fixed compact interval on its left by the [compact phase and rank theorem](bulk_row_interlacing.md). There the row ratio has argument strictly between 0 and \(\pi\). Since it continues through \(M\le T\le c_1\sqrt n\) with positive imaginary part, the lifted difference satisfies \(0<\Phi_{n+1}-\Phi_n<\pi\) throughout. The cosine and derivative error bounds in phase guarantee one simple root per full integral phase cell for both rows, of absolute index \(k\) in \((k\pi,(k+1)\pi)\) by continuation from the compact interval. Near the upper endpoint first shrink \(c_1\) by half to allow full neighboring cells; \(\Phi'_n\gg n/T^2\) supplies the required margin.

At a zero of rank \(k\) in row \(n\), its sine has sign \((-1)^k\), modulus exceeding \(0.99\). In \(H_{n+1}-(\Re Q(z))H_n\) the two principal terms now have sum \(-2|G_n(z)|\Im Q(z)\sin\Phi_n\); by (5) all other terms together have smaller modulus. Thus \(H_{n+1}(-e^T)\) has sign \((-1)^{k+1}\). The later phase lies either in the same integral cell or the next one, including their common boundary, because its increment is between zero and \(\pi\). In the former case the observed sign puts the point strictly after its unique root of rank \(k\); in the latter it puts the point strictly before its unique root of rank \(k+1\). At the common boundary the ordering is immediate as well. This proves the two strict inequalities.
