# Reciprocal counterexamples matching arbitrarily many true Eulerian coefficients

Let \(m=n-1\), \(E(n,i)\) count permutations with \(i\) descents, and \(A_j(x)=x\sum_i E(j,i)x^i\). The normalized Eulerian input is \(b_i^*=E(n,i)/\binom mi\). Its reciprocal generating polynomial is negative-rooted. At odd \(m\) its root at \(-1\) is simple, at positive even \(m\) it is double, and all other roots are simple by the [two-sided factorial theorem](factorial_symbol.md). Consider
\[
 \mathcal T_m[b](x)=\sum_{i=0}^m \binom mi b_i A_{i+1}(x).
\]

**Theorem.** Fix any integer \(K\ge0\). For all sufficiently large \(n\) there exists a reciprocal degree-\(m\) polynomial \(b\) with positive rational coefficients, having exactly the negative-root multiplicities just specified, such that
\[
 b_i=b_i^*,\quad b_{m-i}=b_{m-i}^* \qquad(0\le i\le K),
\]
but \(\mathcal T_m[b]\) has a nonreal conjugate pair. Its highest \(K+1\) coefficients also agree exactly with those of the genuine matrix-square row, because the Eulerian transformation is triangular. Thus even exact agreement on an arbitrarily prescribed fixed number of top and bottom coefficients does not suffice for an all-row criterion based on reciprocity and the real-rootedness of the normalized input. Choosing the matching depth to increase sufficiently slowly also gives one counterexample sequence agreeing eventually at every fixed coefficient index measured from either end. This follows by making the starting thresholds for successive fixed depths strictly increasing. The all-rank statement for the genuine ordinary square remains open. The [lower-rank obstruction](reciprocal_obstruction.md) gives a degree-30 example when only the endpoint coefficients are specified.

One explicit example matching the first nonconstant coefficient has \(n=50\). Set \(m=49\) and
\[
 b(z)=(1+z)(1+3z+z^2)(1+Dz+z^2)
       \prod_{i=0}^{21}\big(1+(3000000+i)z+z^2\big),
 \qquad D=\frac{2^{50}-51}{49}-4-\sum_{i=0}^{21}(3000000+i).
\]
Then \(b_1=(2^{50}-51)/49\) exactly, and the 49 negative input roots are simple. The degree-50 output has 48 real roots including zero. The [exact checker](check_reciprocal_obstruction.py) verifies the matched input and output coefficients, squarefreeness and the real-root count.

The counterexamples in the theorem can even be chosen with **non-log-concave output coefficients**. For an explicit instance matching both edges through degree one, let \(n=500,\ h=248,\ c=2^{219}\), set \(D=(2^{500}-501)/499-1-hc-\binom h2\), and take
\[
 b(z)=(1+z)(1+Dz+z^2)\prod_{i=0}^{h-1}(1+(c+i)z+z^2).
\]
Writing \(a_j=[y^j]y^{500}\mathcal T_{499}[b](1/y)\), exact integer arithmetic in the same checker gives \(1008a_{126}^2<1000a_{125}a_{127}<1009a_{126}^2\). All 499 input roots are simple negative because \(D>c+h\), and the sum of linear terms is \((2^{500}-501)/499\).

## A dilation of a Laguerre polynomial

Write \(L=K+1,\ \rho=L/(L+1)\). For an integer \(h>0\) put
\[
 Q(s)=\sum_{i=0}^h\binom hi\frac{K!}{(K+i)!}s^i
     =\frac{h!K!}{(h+K)!}L_h^{(K)}(-s).
\]
Its zeros are distinct and negative by Laguerre orthogonality on the positive axis after sign reversal. This also follows directly from the Rodrigues formula by integrating by parts \(h\) times against polynomials of degree less than \(h\) with the positive weight \(t^K e^{-t}\). Write their positive moduli as \(r_1<\cdots<r_h\). The two end coefficient ratios give
\[
 \sum_i r_i=h(h+K),\qquad \sum_i r_i^{-1}=h/(K+1).
\]
Hence \(r_h/r_1\le h^2(h+K)/(K+1)\). For all sufficiently large \(h\) there is an \(i\) with \(r_{i+2}/r_i<1/\rho\), because otherwise \(r_h/r_1\ge\rho^{-\lfloor(h-1)/2\rfloor}\).

There is also a coefficientwise choice that proves the stronger assertion directly. Put \(q_i=[s^i]Q,\ R(i)=q_i/q_{i-1}=(h-i+1)/(i(K+i))\), \(i=\lfloor h/2\rfloor\), and choose \(d=R(i)\rho^{1-i}>0\), rational. Let \(p_i=[s^i](Q(s)+dsQ(\rho s))\). The two summands at index \(i\) are equal. Hence
\[
 \frac{p_{i-1}p_{i+1}}{p_i^2}
 =\frac{R(i+1)}{4R(i)}
   \left(1+\frac{R(i)}{\rho R(i-1)}\right)
   \left(1+\frac{\rho R(i)}{R(i+1)}\right)
 \ \longrightarrow\ \frac{(1+\rho^{-1})(1+\rho)}{4}>1 .
\]
Indeed the adjacent ratios of \(R(i)\) tend to one as \(h\to\infty\) with \(K\) fixed. For example at \(K=1,h=174,i=87\) the ratio is exactly \(4182439/4182288\). Thus for a fixed large enough \(h\) the model fails ordinary log-concavity, an open condition on three coefficients. A positive-coefficient real-rooted polynomial is log-concave by Newton's inequalities, so this choice gives a nonreal zero as well. Take this \(h,d\) in the construction for the stronger version.

An alternative root-counting argument can detect instability even at smaller \(h\). Whenever \(r_{i+2}/r_i<1/\rho\), choose \(t>0\) with \(r_{i+2}<t<r_i/\rho\) and \(Q(-t)Q(-\rho t)\ne0\). Suppose every \(Q(s)+d sQ(\rho s)\) were real-rooted for \(d>0\). Count its roots of magnitude at most \(t\). As \(d\downarrow0\) their number is the count for \(Q\), since the one extra root escapes to infinity. As \(d\to\infty\) their number tends to \(1+\#\{j:r_j<\rho t\}\), including the root tending to zero. The difference is at least two by the choice of \(t\). Yet there is at most one parameter for which \(-t\) is a root. At such a positive parameter the root has to be simple: otherwise the local equation \(-Q(s)/(sQ(\rho s))=d\) has a critical point there of multiplicity at least two in the level equation. Perturbing the level to one side would leave fewer nearby real roots than its multiplicity (for an odd multiplicity greater than one either side suffices). Complex root continuity would give a nonreal pair. Under the supposition of real-rootedness the count can therefore change by at most one, a contradiction. All coefficients are positive, so no other part of the counting circle can be crossed under that supposition. Nonreal roots persist on an open parameter interval, allowing \(d\) rational. As a small example, \(K=1,\ h=15,\ d=8\) gives a degree-16 polynomial with 14 real roots by exact isolation.

## Matching the genuine edge coefficients exactly

Fix such \(h,d\) and let \(\Delta=d\rho^{-K}\). Define \(c_n=L\rho^{-n}/(m\Delta)\), and \(e=1\) for odd \(m\), \(e=2\) for even \(m\). Put \(p=(m-2K-2h-e)/2\), eventually a nonnegative integer. Form the rational polynomial
\[
 W_n(z)=(1+z)^e
 \prod_{a=1}^p \left(1+\left(2+\frac{a}{m+1}\right)z+z^2\right)
 \prod_{a=1}^h (1+(c_n+a)z+z^2).
\]
Its medium parameters are asymptotic to \(c_n\) and distinct. The parameters in the first product belong to \((2,3)\) and are also distinct.

Choose \(K\) additional quadratic factors via
\[
 U_n(z)=(1+z^2)^K\sum_{i=0}^{K} e_i
                  \left(\frac{z}{1+z^2}\right)^i,\qquad e_0=1 .
\]
There is a unique rational choice of \(e_1,\ldots,e_K\) for which \(b=W_nU_n\) equals the genuine input through order \(K\) at zero. Each \(e_i\) first appears with coefficient one at its own degree. All factors are reciprocal, so the matching at the other end is automatic.

For fixed \(i\le K\), write \(B_i=b_i^*\). The ordered-bin estimate \(E(n,i)=(i+1)^n(1+o(1))\) for fixed \(i\) yields
\[
 B_i\sim i!(i+1)^n/m^i,\qquad
 R_i=B_i/B_{i-1}\sim \frac{i}{m}\left(\frac{i+1}{i}\right)^n .
\]
In particular \(R_1\gg R_2\gg\cdots\gg R_K\gg c_n\gg m\), with each displayed successive ratio tending to infinity (the list \(R_i\) is absent when \(K=0\)). The coefficient of order \(s\le K\) of \(W_n\) or its reciprocal power series is \(O_{K,h}((m+c_n)^s)\), by multiplication of its factors or power-series inversion to a fixed order. Dividing the required coefficients by \(W_n\) hence changes \(B_i\) by \(o(B_i)\) for each \(1\le i\le K\). Changing coordinates from \([z^i]U_n\) to \(e_i\) next costs only bounded linear combinations of lower coefficients. Thus \(e_i\sim B_i\) for each of these fixed indices.

The polynomial \(1+e_1z+\cdots+e_Kz^K\) now has simple negative roots \(-(1+o(1))/R_i\), \(1\le i\le K\). At \(z=-s/R_i\) divide by \(e_{i-1}(-s/R_i)^{i-1}\); on a fixed small neighborhood of \(s=1\) only the consecutive terms of degrees \(i-1,i\) survive, with uniform limit \(1-s\), by the strict separation of the \(R_i\). The two real signs near one and the total degree prove the assertion. Equivalently the \(e_i\) are elementary symmetric coefficients of distinct parameters \(D_{i,n}\sim R_i>2\). It follows that \(U_n=\prod_{i=1}^K(1+D_{i,n}z+z^2)\). These parameters all exceed the medium parameters for large \(n\). The rational polynomial \(b\) therefore has exactly the prescribed multiplicity of \(-1\) and otherwise only simple negative roots. Individual \(D_{i,n}\) need not be rational.

## The transformed root cluster

Put \(a_i=\binom mi b_i\) and \(R(y)=y^n\mathcal T_m[b](1/y)\). By reciprocity and Eulerian row symmetry,
\[
 R(y)=\sum_{i=0}^{m}a_i y^i\sum_{\ell=0}^{n-i-1} E(n-i,\ell)y^\ell .
\]
Let \(v=\Delta\rho^n/L\), \(A_*=\binom mK e_K v^K\), with \(A_*=1\) when \(K=0\). The first factor has local profile
\[
 A_*^{-1}\sum_i a_i(vs)^i\longrightarrow s^K Q(s)
\tag{1}
\]
uniformly on bounded complex disks. At fixed degree \(K+l\) with \(0\le l\le h\), the dominant coefficient contribution uses the linear term of each of the \(K\) large factors and \(l\) of the \(h\) medium factors. In fact the large factors at the variable \(m v s=s/c_n\) divided by \(e_K/c_n^K\) converge coefficientwise to \(s^K\), the product of the medium factors tends to \((1+s)^h\), and the product of all bounded factors tends locally uniformly to one since \(m/c_n\to0\). All these polynomials have nonnegative coefficients. Consequently \(b(s/c_n)/(e_K/c_n^K)\to s^K(1+s)^h\) locally uniformly and coefficientwise. The additional factor \(\binom m{K+l}/(\binom mK\,m^l)\to K!/(K+l)!\) produces the coefficients in (1). For uniform tails use \(\binom mi\le m^i\) and \(e_K/c_n^K\sim K! A_*\). The tail beyond degree \(K+h\) of the nonnegative dominating polynomial just shown tends to zero on each bounded disk, by evaluating its total and first \(K+h+1\) terms at the positive radius. The same argument handles degrees below \(K\).

At \(y=\Delta\rho^n s\) the terms of the second sum with \(\ell=L-1,L\) are the two largest in exponential order. More precisely, on every bounded \(s\)-disk,
\[
 \frac{R(\Delta\rho^n s)}
 {[L\rho^{L-1}]^n A_*\Delta^{L-1}}
 \ \longrightarrow\
 s^{K+L-1}\big[Q(s)+d\,sQ(\rho s)\big]. \tag{2}
\]
For either of these fixed \(\ell\), \(E(n-i,\ell)/(\ell+1)^{n-i}\to1\) for fixed \(i\) by the Eulerian estimate, and the uniformly small \(i\)-tails after replacing by the upper bound \((\ell+1)^{n-i}\) follow from (1). The first value \(\ell=L-1\) therefore supplies \(s^{L-1}s^KQ(s)\). The next employs the argument \(\rho s\) in (1) and supplies the multiplier \(\Delta\rho^K=d\).

For every other \(\ell\) the normalized absolute sum at \(|s|\le R_0\) is bounded by a fixed constant times
\[
 (\Delta R_0)^\ell
 \left(\frac{(\ell+1)\rho^\ell}{L\rho^{L-1}}\right)^n.
\]
Here (1) at the fixed radius \(LR_0\) bounds the inner \(i\)-sum, since \(L/(\ell+1)\le L\). The scalar inside parentheses has its only maximizers \(L-1,L\), where it equals one. For \(\ell\ge L+1\) successive scalar ratios are bounded by \(\rho(L+3)/(L+2)<1\). Hence the sum over the other indices tends to zero by a geometric bound, including their growing upper limit. This proves (2). Small disks around a nonreal root and its conjugate give nonreal roots for all large \(n\) by Rouché. In the stronger version, compact convergence gives convergence of the three coefficients at offsets \(K+L-1+i-1,\ K+L-1+i,\ K+L-1+i+1\), so their strict reverse log-concavity inequality persists. Reversal, the argument scaling and the overall positive normalization all preserve that inequality. This completes the theorem.

## Following any fixed number of genuine insertion steps

**Theorem.** Fix integers \(K,r\ge0\). At every sufficiently large final rank \(n\), one can start a rational normalized input at rank \(n-r\) and follow exactly the ordinary Eulerian insertion recurrence for the last \(r\) steps, so that *every one of these rows* has the true endpoint coefficients through depth \(K\) and the true negative root multiplicities. The final binomially reweighted Eulerian transform nevertheless fails ordinary coefficient log-concavity. The same diagonal selection as above makes both depths \(K,r\) tend to infinity with \(n\).

Indeed write \(B_N(z)=\sum_{i=0}^{N-1}b_{N,i}z^i\), where the underlying ordinary row has coefficients \(\binom{N-1}i b_{N,i}\). For \(\vartheta=z\partial_z\) the normalized insertion recurrence is exactly
\[
 B_{N+1}(z)=(1+z)(\vartheta+1)(1-\vartheta/N)B_N(z).
 \tag{3}
\]
This follows by inserting \(E(N+1,i)=(i+1)E(N,i)+(N+1-i)E(N,i-1)\) into the normalization and applies to a general starting row. Preservation of coefficient agreement through order \(K\) follows from this lower triangular formula. The coefficient multiplier \((i+1)(N-i)/N\) is reciprocal in degree \(N-1\), so reciprocity preserves agreement at the upper end too. The starting polynomial has the prescribed negative root multiplicities. At every later step, \((\vartheta+1)B=(zB)'\) has simple negative roots by Rolle, counting the possible double root at \(-1\). The commuting factor \(1-\vartheta/N\) is, up to a positive constant, the degree-\((N-1)\) reversal of the same derivative operator conjugated by reversal, and consequently also produces simple negative roots. Their product operator outputs a reciprocal polynomial of degree \(N-1\) with simple negative roots. Its having a root at \(-1\) is equivalent to \(N-1\) being odd, by reciprocity and simplicity. The front factor \(1+z\) gives exactly the required multiplicity for rank \(N+1\).

Use the construction above at rank \(n-r\), with the scale parameters \(c_n,v,\Delta\) still taken at the *final* rank. Edge matching now uses the true coefficients at \(n-r\). This does not change the strict exponential separations \(R_1\gg\cdots\gg R_K\gg c_n\), since \(r\) is fixed. Denote the product of its \(K\) large parameters by \(e_K\). The proven local convergence of the initial polynomial reads
\[
 \frac{B_{n-r}(s/c_n)}{e_K/c_n^K}\longrightarrow s^K(1+s)^h .
\]
It is locally uniform on all disks and hence holds after any fixed number of derivatives. Under the substitution \(z=s/c_n\), (3) acts as
\((1+s/c_n)(D+1)(1-D/N)\), where \(D=s\partial_s\). Here \(N=n-r,\ldots,n-1\) tends to infinity and \(c_n\to\infty\), so after these \(r\) steps the limit is \((D+1)^r[s^K(1+s)^h]\). The polynomials before and after every step have nonnegative coefficients, and the resulting local polynomial limit still has degree \(K+h\). The same positive majorant and binomial limit used in (1) therefore give the new profile \(s^K Q_r(s)\), with the normalization \(A_*\) multiplied by \((K+1)^r\), where
\[
 Q_r(s)=\sum_{l=0}^h \binom hl\frac{K!}{(K+l)!}
 \left(\frac{K+l+1}{K+1}\right)^r s^l.
\]
The two second-layer peaks and the geometric bounds in (2) now give \(Q_r(s)+d sQ_r(\rho s)\). For its coefficients use the proof of reverse log-concavity above with
\[
 R_r(i)=\frac{h-i+1}{i(K+i)}
         \left(\frac{K+i+1}{K+i}\right)^r.
\]
The consecutive ratios of \(R_r(i)\) still tend to one at \(i=\lfloor h/2\rfloor\) as \(h\to\infty\) for fixed \(K,r\). Choosing \(d=R_r(i)\rho^{1-i}\) gives the same limit \((1+\rho)(1+\rho^{-1})/4>1\) in the three-coefficient test. Fix sufficiently large \(h\), then pass \(n\) to infinity as before. This gives the claimed counterexamples.
