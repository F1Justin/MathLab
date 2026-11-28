# Strict directed interlacing of every threshold-four row at lags one through four

For the set-partition polynomials \(P_n\) of [the all-row real-root theorem](all_rows_four.md), the zeros of \(P_n\) and \(P_{n+l}\) strictly interlace for every \(n\ge0\) and \(1\le l\le4\). In increasing order on the negative axis, the later row starts if the degree increases and the earlier row starts if the degrees are equal. Empty root lists are interpreted in the usual vacuous sense. The [finite certificates](https://github.com/F1Justin/MathLab/tree/04e5e9ec4469c236e13615fba3d17ee20c2d6bf8/certificates/partitions) include the comparisons through row 2004. We prove the direction and the strict signs for every \(n\ge2000\). Both [the bulk program](check_effective_bulk.py) and [the four-gap verifier](check_interlacing_four.py) use outward-rounded Arb arithmetic.

Write \(m=\lfloor n/4\rfloor\). At the \(k\)-th root \(t_k\) in increasing order it suffices to prove
\[
                    \operatorname{sgn}P_{n+l}(t_k)=(-1)^{m-k+1}.       \tag{1}
\]
This gives one later-row root between successive old roots and one between the last old root and zero. If the degree increases, the leading sign gives the additional root before the first. Since \(l\le4\) the degree increases by at most one. The [outer five-rank theorem](../../../snapshot/research/partitions/effective_outer.md) gives (1) at the first four roots. In fact, at the old \(k\)-th root for \(k\le4\), exactly \(k-1\) later roots lie to its left at equal degree, and exactly \(k\) at a degree increase. In the latter case the later \((k+1)\)-st root, which bounds this count from above, still lies in the five-rank list.

## The other rows on the middle contour

Retain the notation of [the effective bulk signs](effective_bulk.md): \(u=1/n,\ z=Re^{iq}\), \(D=z\,d/dz,\ h=DA,\ H=DB\), \(t=-n\tau\), and \(\Theta=\Im E(z)\) is the increasing uncorrected action. An insertion \(e^{-ilv}\) on the circle gives the actual later row up to a positive factor. The centered weight \((e^{-ilv}-\cos(lq))/\sin(lq)\) has value \(-i\) at the saddle, derivative bounded by \(l/\sin(lq)\), and circle bound \(2/\sin(lq)\). For \(l=2,3\) throughout and for \(l=4,R>4\), the verifier directly tests the denominator is positive and includes these two additional bounds in the same Gaussian flux estimates as for \(l=1\).

For \(l=4,\ R\le4\) let \(h_1(z)=6H(z)/z^4=\sum_{k\ge0}6z^k/(k+3)!\) and \(t_0=\tau R^4/24\). Integration of the angular derivative with an extra factor \(e^{-4iv}\) gives
\[
 (1+4u)I[e^{-4iv}]=I[e^{-4iv}(u h-\tau H)].
\]
Here the integrals are on the full coefficient circle. Subtract the real constant at the saddle and divide by \(R\) before testing. Up to an additional real constant, the regular weight is
\[
 L(v)=u e^{-4iv}\frac{h(Re^{iv})}{R}
       -4t_0 e^{iv}\sum_{k\ge1}\frac{6(Re^{iv})^{k-1}}{(k+3)!}.
\]
At the saddle \(uh-\tau H=1\), so \(-\Im L(q)=\sin(4q)/R>0\), including its positive limiting interpretation. The centered weight \([L(v)-\Re L(q)]/[-\Im L(q)]\) has value \(-i\) there. The verifier differentiates the displayed series once with respect to angle, and bounds its absolute coefficients at radius \(R\) for the whole-circle bound. At an actual zero all subtracted real constants disappear. Conjugation exchanges the two semicircles of the integral with its angular multiplier.

The extended check on 3,280 boxes verifies errors less than \(4/5\) for these three additional sine tests. At a root in the cell \((k-1-m)\pi<\Theta<(k-m)\pi\), the corrected phase \(G\) has \(\operatorname{sgn}\sin G=(-1)^{k-1-m}\), with \(|\sin G|>\sqrt3/2\). To start at \(k=5\), use the reciprocal coordinate \(X\) of the [outer-to-middle comparison](effective_bulk.md). For all four residues the entire old fifth-root window lies between \(X=13.74\) and \(X=16.65\), inside the tested interval from \(R=250/n\) (where \(X<9.3\)) to \(R=1/4\) (where \(X>16.9\)). The residue-specific bounds in that comparison place the old fifth root in \(4\pi<\Theta+m\pi<5\pi\). Applying the four shift tests to that root proves (1) at \(k=5\); the successive cells continue the same signs to \(R=13\).

## Four insertions on the inner contour

We use the notation, envelope and closing estimates of [the fold certificate](all_rows_four.md). Write \(q=\arg z,\ z=a+iy,\ p=1/a,\ Z=1+ipy,\ \Lambda=xe^a,\ \eta=1/\sqrt{\Lambda y},\ k_0=\eta/y\). The index \(k\) above is a root rank; \(k_0\) is the dimensionless scale called \(k\) in the fold certificate. Let
\[
 U=\frac{a}{\eta}\int_{\rm upper} e^{E(z')-E(z)}\,\frac{dz'}{iz'},
\]
and let \(U_l\) insert \((|z|/z')^l\) in the same integral. This choice makes the later polynomial a positive constant times \(\Re(e^{i\Theta}U_l)\). Set
\[
 V_l=\frac{U_l-\cos(lq)U}{\sin(lq)},\qquad B_l=-V_l-iU.
\]
The last integral has the insertion \([e^{-ilq}-(|z|/z')^l]/\sin(lq)\). On the top path \(z'=z+b,\ T=b/\eta\) it equals
\[
  M_l(s)=\frac{\overline Z^{\,l}}{Z S_l(py)}\, k_0 T
                   \sum_{j=1}^{l}(1+pb/Z)^{-j},                    \tag{2}
\]
where \(S_1=1,\ S_2=2,\ S_3(v)=3-v^2,\ S_4(v)=4(1-v^2)\). Indeed
\(1-(1+w)^{-l}=w\sum_{j=1}^l(1+w)^{-j}\) and \(\sin(lq)=py S_l(py)/|Z|^l\). Formula (2) stays regular as \(p\) or \(y\) tends to zero.

On the entire inner branch subset \(\Theta\le-1\), the four-gap verifier establishes
\[
                 \Re U>0,\qquad \Re(e^{-i}U)>0,\qquad
                 |B_l|<\Re U,\quad l=1,2,3,4 .                      \tag{3}
\]
Here are the details of this extra certificate. From \(|\Theta|k_0^2<0.81\) in the fold proof, \(k_0<0.9\). Use the same \((p,y,k_0)\) box test for the exact stationary relation. Additionally exclude a box if
\(\Re G(-iy)-\Im(C/y)/2<k_0^2\) throughout; by the exact phase identity of that proof, it cannot meet \(\Theta\le-1\). On each remaining box, interval Riemann sums now enclose both components of \(U\) and the four integrals \(B_l\) on \(|s|\le16\), with width \(1/8\). The intervals include zero wherever the conditions \(1+k_0s\ge0,\ y+\eta s\le6\) have uncertain sign. The Gaussian envelope \(e^{-s^2/40}\) remains valid. The certificate verifies the strict inequalities in (3) after adding modulus errors \(1/40\) to the scalar integral and \(1/5\) to each \(B_l\). There are 1,868 accepted integral boxes and 1,822 excluded boxes.

For the tail constants, put \(r=\sqrt{1+(\pi/12)^2}\) and \(J_0=(24/23)\sqrt{5/4}\). On the top path \(|\mathcal A|\le J_0\) for the scalar amplitude, \(|T|\le\sqrt{5/4}|s|\), \(|Z|\le r\), \(|1+pb/Z|^{-1}\le24r/23\), and \(S_l(py)\ge l[1-(\pi/12)^2]\). Thus \(|M_l(s)|\le k_0 |s|D_0\) where
\[
 D_0=\frac{r^3}{1-(\pi/12)^2}(24r/23)^4\sqrt{5/4}.
\]
The omitted two top-path tails for \(U,B_l\) cost at most \(J_0(40/16)e^{-256/40}\) and \(J_0D_0(0.9)40e^{-256/40}\), respectively.

On the connector and circle \(|z'|\ge|z|\), so the last insertion has modulus at most \(2/\sin(lq)\le 2r a/y\). Here \(4q<\pi/2\). Also \(1/y=k_0^{2/3}\Lambda^{1/3}<\Lambda^{1/3}\) and \(t_0'=\Lambda/a\ge18/13\) by (1) of the fold proof and \(K\ge3a^2/2\). The scalar closing bound before maximizing in the fold proof is \((\pi+1)\sqrt\pi\,a^{3/2}e^{-0.6a}\sqrt{t_0'}\,e^{-5t_0'}\). For \(B_l\) it is at most \(2r(\pi+1)\sqrt\pi\,a^{17/6}e^{-0.6a}(t_0')^{5/6}e^{-5t_0'}\). Both decrease separately in \(a\ge12\) and \(t_0'\ge18/13\). Substitution and addition of the omitted top tails give the stated \(1/40,1/5\) bounds. The verifier checks the numerical inequalities with Arb.

## From the determinant sign to every root

The exact action \(\Theta\) increases all the way from the common radius cut to zero at the fold. In fact \(d(\Im E)/dx=-\Im B(z)\) and \(\Im B(z)/y=e^a\sin(y)/y-(1+a+a^2/2-y^2/6)>0\). For \(y\le2\pi/3\), \(\sin(y)/y\ge\sin(2\pi/3)/(2\pi/3)\). For larger \(y\) the condition \(\cos y+a\sin(y)/y>0\) gives \(\sin(y)/y>1/(2a)\). In both cases use \(e^a/(2a)>1+a+a^2/2\) for \(a\ge12\). At \(R=13\) the checked phase is still less than \(-1\). Hence the terminal cut \(\Theta=-1\) is reached on the inner branch, where (3) makes the polynomial strictly positive. We may use that cut instead of zero as the final positive test in the degree-saturation argument. The last root is in \(-\pi<\Theta<-1\); all preceding roots after the fifth lie in their previously specified integer cells before this cut.

At a root in the inner interval write \(e^{i\Theta}U=iY\) with real \(Y\). Since \(\Re U=Y\sin\Theta>0\), \(\operatorname{sgn} Y=\operatorname{sgn}\sin\Theta=(-1)^{k-1-m}\) for the \(k\)-th root. The identity \(V_l=-iU-B_l\) and (3) imply
\[
 \Im(V_l\overline U)\le-|U|^2+|B_l||U|<0.
\]
Thus \(\Re(e^{i\Theta}V_l)=-Y\Im(V_l/U)\) has the sign of \(Y\). Because \(\sin(lq)>0\) and the scalar term vanishes, \(\Re(e^{i\Theta}U_l)\) has that same sign. This proves (1) throughout the inner interval and establishes all four directed interlacings.
