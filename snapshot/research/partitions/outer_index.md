# Absolute numbering of the negative real zeros from the outer edge

Let t_(n,k) be the k-th negative real zero of P_n in increasing order, counted from minus infinity. Set n=4m+s, 0<=s<=3. Use the upper saddle z=r exp(i theta), tau=-1/H(z), psi=-tau Im B(z)-theta, and fix the previously arbitrary phase branch by

    phi = Im A(z) - (1/2) arg(-tau K(z)),    -pi/2 < arg(-tau K(z)) < pi/2.
    W_n(r) = m pi + n psi(r) + phi(r).

Here K=z H', H=zB', and the global-saddle certificate gives Re(-tau K)>0. The point on the negative real axis is t=-n tau(r), increasing with r.

**Index formula.** Fix R>0. For any sequence of radii 0<r_n<=R with n r_n tending to infinity and distance from W_n(r_n) to pi(Z+1/2) bounded below, the exact number of negative real zeros strictly to the left of -n tau(r_n), for all sufficiently large n, is

    floor(W_n(r_n)/pi + 1/2).

All real zeros counted here are simple. The restriction on the cut avoids ambiguity immediately next to a zero. For a complete cell at index k tending to infinity and radius at most R the root satisfies W_n(r_(n,k))=(k-1/2)pi+o(1). This counts real roots on a half-line and makes no assumption on complex roots elsewhere.

**Growth of outer ranks.** Whenever k tends to infinity and k=o(n), that negative real zero exists and

    t_(n,k) ~ -3 n^5 / (320000 pi^4 k^4).

For k=o(sqrt(n)) with k tending to infinity the sharper absolute phase estimate is

    (3 n^5/(320000 |t_(n,k)|))^(1/4) = (k-1/2+s/4)pi + o(1).

### Proof

At small r the analytic expansions in the saddle calculation give

    tau=6 r^(-4)(1+O(r)),  psi=-pi/4 + r/(20 sqrt(2)) + O(r²),  phi=O(r).

In fact psi'=-(Im B) tau', with Im B~r⁵/(480 sqrt(2)), and the analytic small-radius branch gives differentiated expansions. Thus W_n increases with derivative n/(20 sqrt(2))+O(nr+1) near zero. On the remainder of (0,R] it increases for n large by compactness and psi'>0.

Fix a large integer J, independent of n, and use the cut

    r_J=(20 sqrt(2)/n)(J+s/4)pi.

At this cut W_n(r_J)=J pi+o(1) for fixed J. In the outer-edge variable u=(24/625)m⁵/t, it tends to -4 X^4 with X=(J+s/4)pi. The limiting roots in that variable are -4 x_(s,k)^4. Exactly J lie above this cut. Indeed x_(0,k)=(k-1/2)pi, x_(2,k)=k pi, x_(1,k) lies between (k-1/2)pi and k pi, and x_(3,k) between k pi and (k+1/2)pi. In all four cases x_(s,J)<X<x_(s,J+1). Compact convergence of the reciprocal polynomial and two fixed circles with radii just below and above 4 X^4 show that the moving cut has exactly J exterior roots in the original modulus, all simple and on the negative axis. This also rules out any extra real root to its left.

The two-saddle estimates and centered derivative estimate in outer_transition.md have error o_n(1)+O(exp(-c n r)) uniformly on (0,r_0] for fixed sufficiently small r_0. To see the uniform o_n(1), the upper saddle has uniformly nonzero curvature and bounded angular derivatives of the normalized exponent and amplitudes all the way to r=0. A common Gaussian cutoff and Taylor estimate give the same o_n(1) there. The other local maximum contributes the displayed O(exp(-c n r)); all constants are independent of J. For r>=r_J that term is at most C exp(-c' J). Choose J so large that sign tests on the two edges of every small phase neighborhood of (i+1/2)pi succeed, the sine term of the centered derivative fixes the sign throughout each such neighborhood, and the cosine bound excludes other real zeros. On [r_0,R] use the compact bulk estimates. This covers the whole interval, including the joins. At r_J the cut is within o(1) of the integer phase J pi, outside every zero neighborhood. Thus the next zero has phase near (J+1/2)pi and index J+1, fixing the integer offset. For a sequence of upper cuts a fixed positive distance from half-integer phases choose phase neighborhoods narrower than that distance before choosing J. At cells with nr tending to infinity the phase error tends to zero since the subdominant pair then vanishes. This proves the index formula.

For the second assertion, cuts at r equal to fixed multiples of k/n straddling 20 sqrt(2) pi k/n enclose the k-th real zero, by the cell count (the cut may be moved by O(1/n) to an integer phase). At that zero expand the exact indexed phase:

    n r/(20 sqrt(2)) = (k-1/2+s/4)pi + O(k²/n) + o(1).

Inserting tau=6r^(-4)(1+O(r)) gives the claimed equivalent. Passing to the fourth root gives the more precise estimate since the O(r) relative error causes an additive O(k²/n) error.
