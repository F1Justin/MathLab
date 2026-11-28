# Real roots above the quarter-power block threshold

There is an absolute constant \(C>0\) such that for all sufficiently large \(N\) and all integers
\[
             C N^{1/4}(\log N)^{7/4}\le j\le N,
\]
the set-partition polynomial \(P_{N,j}(t)\), by the number of blocks of size at least \(j\), has \(\lfloor N/j\rfloor\) simple negative roots. In particular every fixed power \(j\ge N^{1/4+\epsilon}\) suffices. The argument models the cubic variation of a coefficient by repeated falling-factorial multipliers, while preserving real roots and quantitative separation in its reference polynomial.

Use the [factorial-moment coordinates and root-midpoint estimates](growing_threshold.md). Thus \(D=\lfloor N/j\rfloor,\ m=N-jk,\ a_k=[x^k]P_{N,j}(1+x)/N!=C(m,k)/(k!(j!)^k)\), and \(C(m,k)=[z^m]\exp(e^z-1)H(z)^k\) for \(H(z)=\sum_{l\ge0}j!z^l/(j+l)!\). The ratios \(a_{k-1}/a_k\) increase. The [uniform outer curvature theorem](uniform_outer_curvature.md) supplies a zero-free circle with count \(k\) if \(1\le k<D\) and \(m\le j^2/(20\log j)\). The large-ratio theorem covers \(j>2\sqrt{N\log N}\). It suffices to count each remaining \(k\) for \(j\le 2\sqrt{N\log N}\).

## A complex saddle including the excess-block factor

Write \(L=\log N,\ V=\max(1,N/j^2),\ U=\max(1,m/j^2)\). Now \(m>j^2/(20L)\), \(\log m\asymp L\), and
\[
   \epsilon_0=\frac{V L}{m}+\frac L{j^2}=o(1),\qquad
                 V L^3/m=o(1).
\]
These follow from \(N L^4/j^4=O(L^{-3})\) in the stated range. All constants below are independent of \(C\ge1\), except for the final choice of \(C\). For \(|s|\le m/(10j)\), set \(M=m-js,\ K=k+s,\ \mathcal D=z\,d/dz,\ \nu=\mathcal D\log H,\ w_H=\mathcal D\nu\). There is an analytic \(r=r(s)\) satisfying
\[
       r e^r+K\nu(r)=M,\qquad r=W(M)+O(VL/m).
\]
Indeed \(W(M)\) is analytic here and differs from \(W(m)\) by \(O(1)\), from the implicit equation \(W+\log W=\log M\). On \(|r-W(M)|\le1\), the defining power series gives \(|H-1|,|\nu|,|w_H|=O(L/j)\), \(|\nu'|=O(1/j)\). As \(|K|=O(N/j)\), the map \(r\mapsto W(M-K\nu(r))\) takes this disk into a concentric disk of radius \(O(VL/m)\) and has derivative \(O(V/m)<1/2\). Uniform iteration gives the analytic solution. It agrees with the positive real saddle at \(s=0\).

Put
\[
 \Lambda(s)=e^r-1+K\log H(r)-M\log r,\qquad
 \sigma^2=(1+r)r e^r+K w_H(r).
\]
All branches are obtained by continuation from \(s=0\). The saddle equation gives \(\sigma^2=M(1+W(M))(1+O(\epsilon_0))\) throughout the disk and
\[
  \Lambda'=j\log r+\log H(r),\qquad
  \Lambda''=-\frac{(j+\nu(r))^2}{\sigma^2}
        =-\frac{j^2}{M(1+W(M))}\big(1+O(\epsilon_0)\big).
\]
Write \(d_0=j^2/(m(1+W(m)))\), so \(1/(2UL)\le d_0\le 50\). Cauchy's estimates on the disk give
\[
\begin{split}
  \Lambda''(0)&=-(1+o(1))d_0,\\
  \Lambda'''(0)&=-(1+o(1))\frac{j^3}{m^2(1+W(m))},\\
  \sup_{|s|\le m/(20j)}|\Lambda''''(s)|
       &\ll \frac{j^4}{m^3 L}.
\end{split}                                                       \tag{1}
\]
For the middle line differentiate the explicit main term: the result differs from the stated leading term by the relative factor \(W(m)/(1+W(m))^2=o(1)\) and the differentiated error is \(O(\epsilon_0 d_0 j/m)\).

Choose fixed constants \(A>1\), then \(B>1\) large enough as specified below. Set \(J=P=\lceil A U L^2\rceil,\ R'=AB U L^2,\ R=R'L^2\). We have \(jR/m=O_{A,B}(L^5/j)=o(L^{-3})\) and \(D-k=\lfloor m/j\rfloor>R\). On \(|s|\le R\) interpolate \(C(m-js,k+s)\) by
\[
 C_*(s)=\frac{e^{\Lambda(s)}}{2\pi}
  \int_{-\pi}^{\pi}\exp\!\left[
   e^{r e^{i\theta}}-e^r+K\{\log H(re^{i\theta})-\log H(r)\}
                   -i M\theta\right]\,d\theta .
\]
This holomorphic function agrees with the exact coefficient at every integral \(s\) for which \(M,K\) are nonnegative integers, by the coefficient integral on the circle parametrized by \(re^{i\theta}\). Uniformly on the disk,
\[
             C_*(s)=e^{\Lambda(s)}(2\pi\sigma^2)^{-1/2}(1+o(1)).
                                                                    \tag{2}
\]
Indeed the linear term of the exponent vanishes exactly. On \(|\theta|\le c/L\) its quadratic term is \(-\sigma^2\theta^2/2\) with \(\Re\sigma^2\asymp mL\); its cubic remainder is \(O(mL^2|\theta|^3)\). Differentiating \(H\)'s logarithm three times angularly costs only \(O(VL)\), because \(|H(z)-1|=O(L/j)\) and each of the first three logarithmic derivatives of \(H(z)\) is \(O(L/j)\) for \(|z|\le 2L\). With \(\theta_0=L/\sqrt m\) the central remainder is \(o(1)\) and Gaussian integration gives (2). The arc \(\theta_0<|\theta|\le c/L\) has loss at least a constant times \(mL\theta^2\) on choosing \(c\) small. On the remaining arc, \(\Re(re^{i\theta})\le\Re r-c'/L\), since \(\Re r\asymp L\) and \(|\Im r|\ll jR/m+VL/m=o(1/L)\). Hence \(\Re(e^{r e^{i\theta}}-e^r)\le-c''m/L^2\). This dominates \(O(jR)+O(VL)\) from the other two terms. In particular
\[
          \log C_*(s)=\Lambda(s)+U_0(s),\qquad
          \sup_{|s|\le R}|U_0(s)|=O(L).
\]
The logarithm is taken using the explicit analytic prefactor in (2), and is real at real arguments near zero. On \(|s|\le R'\), the remainder of \(U_0\) beyond its linear part is \(O(L(R'/R)^2)=O(L^{-3})\).

## A separated real-rooted reference matching three derivatives

Let \(w=\lfloor m/(2j)\rfloor\), \(L_0=k+w\). For \(|s|<w/2\) define
\[
       g(s)=\log\Gamma(w+1)-\log\Gamma(w+1-s).
\]
Then \(g''(0)=-(1+O(1/w))/w,\ g'''(0)=-(1+O(1/w))/w^2,\)
and \(\sup_{|s|\le w/2}|g''''(s)|=O(w^{-3})\). For example \(g''(s)=-\sum_{l\ge0}(w+1-s+l)^{-2}\); differentiate and compare the sums with integrals. Here \(R\ll w\). Take \(\ell\) to be the nearest integer to \(\Lambda'''(0)/g'''(0)\), and set
\[
              d=\ell\,g''(0)-\Lambda''(0).
\]
By (1), \(\ell=(1+o(1))j/[4(1+W(m))]\to\infty\) and \(d=(1+o(1))d_0/2>0\). Also \(|\Lambda'''(0)-\ell g'''(0)|\ll w^{-2}\).

With \((L_0)_i=L_0(L_0-1)\cdots(L_0-i+1)\), use the finite reference polynomial
\[
       \sum_{i=0}^{L_0}\frac{((L_0)_i)^\ell}{i!}
                         e^{-d i(i-1)/2}z^i .                       \tag{3}
\]
It has simple negative roots whose consecutive moduli satisfy \(\rho_{i+1}>e^d\rho_i\). First, without the exponential multiplier and with \(\ell=1\) the polynomial is \((1+z)^{L_0}\). Multiplication of its \(i\)-th coefficient by \((L_0)_i\) preserves real nonpositive roots. In fact, if the input is \(\prod_l(1+c_l z)\), \(c_l>0\), apply \(\prod_l(1+c_l\partial_x)\) to \(x^{L_0}\), then reverse it in degree \(L_0\). Each first-order differential factor preserves real-rootedness by derivative interlacing and nonnegative coefficients keep the roots nonpositive. Iteration treats every integer \(\ell\ge1\). Finally, with \(q=e^{-d}\), adjoining a linear factor \(1+cz\) to an input replaces its \(q^{\binom i2}\)-modified output \(G(z)\) by \(G(z)+czG(qz)\). If the old positive root moduli are \(r_1<\cdots<r_h\) with \(r_i/q<r_{i+1}\), evaluation at \(0,r_i,r_i/q,\infty\) in the modulus variable gives a new root in \((0,r_1)\), in each \((r_i/q,r_{i+1})\), and in \((r_h/q,\infty)\). The degree exhausts these roots and preserves strict separation. This proves the assertion for (3).

Scale the argument and multiply (3) by a positive constant, calling the result \(F(z)=\sum b_i z^i\). Choose \(b_k=a_k\) and match the first derivative in \(h\) after removing the exact factorial denominator and the factor \((j!)^{-h}\) in \(a_{k+h}/a_k\). Such positive scaling adds an arbitrary real linear term in \(h\). More explicitly, if \(S=(\log C_*)'(0)\), the argument multiplier is
\[
                \exp(S-\ell g'(0)+d(k-1/2))/j! .
\]
Then \(a_{k+h}/b_{k+h}=\Phi(h)\) for every integer \(|h|\le R'\) inside the actual coefficient support, where \(\Phi(0)=1\) and
\[
 \log\Phi(s)=\log C_*(s)-\log C_*(0)-S s
            -\ell\{g(s)-g'(0)s\}+d s^2/2.
\]
Indeed \((L_0)_{k+h}/(L_0)_k=\exp g(h)\) for these integers, also for negative \(h\). Our choice of \(d\) cancels the quadratic term from \(\Lambda-\ell g\). By (1), the third-derivative rounding error, and the bound on \(U_0\)'s remainder, we have on the entire disk
\[
 |\log\Phi(s)|\ll L^{-3}
   +\frac{j^2(R')^3}{m^2}
   +\frac{j^4(R')^4}{m^3L}.                                       \tag{4}
\]
The fourth-derivative cost \(\ell/w^3\) is of order \(j^4/(m^3L)\). When \(m\ge j^2\) the last two terms in (4) are \(O_{A,B}(N L^7/j^4)\). When \(m<j^2\) they are \(O_{A,B}(L^{10}/j^2)\). Taking \(C\) sufficiently large after \(A,B\) yields \(\sup|\log\Phi|\le\log 2\).

## Counting the circles

We detail the finite-degree points in the comparison. At \(r_*=\sqrt{\rho_k\rho_{k+1}}\), the separation of (3) gives
\[
   \min_{|z|=r_*}|F(z)|/F(r_*)\ge e^{-\pi^2/(2d)} .
\]
The proof of (12) in the growing-threshold argument uses a product over the roots; deleting missing terms on the finite end only improves the lower bound. Its elementary-symmetric-function estimates (13) remain valid. In particular
\[
 |\log(r_*/\widetilde R_k)|\le c_0 L,\quad
 \widetilde R_i=b_{i-1}/b_i ,
\]
since \(\widetilde R_{k+1}/\widetilde R_k=(1+1/k)e^d(1+1/w)^\ell=O(1)\), and \(1/(1-e^{-d})\ll 1+UL\). The same product proof of (15), with only finitely many factors, bounds \(|(\mathcal D-k)^p F(z)|/|F(z)|\le[e\max(p,c_1 U L^2)]^p\) on the circle, now with \(\mathcal D=z\,d/dz\). All reference coefficient log-curvatures are at least \(d\).

Take \(A\) large relative to \(c_0,c_1\) and \(B\) large. If \(Q\) is the degree-\(P\) Taylor section of \(\Phi\), Cauchy's estimate at \(R'\) gives
\[
 |Q(\mathcal D-k)F(z)-F(z)|/|F(z)|
    \le 2\sum_{p=1}^{P}\bigl(e\max(P,c_1UL^2)/R'\bigr)^p<1/4 .
\]
On offsets \(|h|\le J\) the exact coefficient comparison costs \(O((J/R')^{P+1})F(r_*)\). There are enough indices on the right in both polynomials since \(D-k>R\) and \(L_0-k=w>R\); both supports start at zero on the left.

For \(|h|\ge J\), the unmodified reference terms relative to \(b_k r_*^k\) are at most \(\exp(c_0L|h|-d|h|(|h|-1)/2)\le\exp(-dh^2/3)\) since \(dJ\ge A L/5\). The factor \(|Q(h)|\le2(P+1)\max(1,(|h|/R')^P)\) still leaves the bound \(\exp(-dh^2/4)\) since \(P\log_+(|h|/R')\le2|h|/B\). At an actual cutoff and its inward neighbor, the exact multiplier and its reciprocal are bounded by two. Thus the actual outward ratio there is at most \(4\exp(c_0L-d(J-1))<1/2\). Global coefficient log-concavity controls the rest of each actual tail. An absent negative cutoff has no tail. The sum of all omitted terms, including the polynomially weighted reference tails, is \(O(e^{-dJ^2/5})F(r_*)\).

Both \(e^{-dJ^2/5}\) and \((J/R')^{P+1}\) are \(o(e^{-\pi^2/(2d)})\) because \(dJ\gg L\) and \(J/R'\le 2/B<1\). Rouché's theorem gives a zero-free circle with exactly \(k\) actual zeros at each \(1\le k<D\), including the high-curvature end handled above in the same shifted coordinate. The radii increase strictly because their counts increase. Including the origin and the total count at infinity isolates one simple real zero in each gap by conjugation. Translating back preserves simplicity, and the positive original polynomial on \(t\ge0\) puts all zeros on the negative real axis.
