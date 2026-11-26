# Eventual strict interlacing across all gaps of one through four rows

For all sufficiently large n, P_n strictly precedes P_(n+j) for every j=1,2,3,4 in the directed interlacing convention. Thus any five consecutive sufficiently large rows are pairwise strictly interlacing. This width is maximal for a statement uniform in n: for infinitely many starting rows a lag of five increases the degree by two.

Use the all-real-rootedness and absolute indexing from eventual_interlacing.md. We prove the sign of the later row at each earlier zero. On the common contour of radius R the multiplier for the j-th later row, up to a positive scalar, is (R/z)^j. At the two upper and lower angular saddles the centered weight

    ((R/z)^j-cos(j theta))/sin(j theta)

has values -i and +i. Whenever 0<j theta<pi this gives the same sign test as for the adjacent row. In the exact middle regime its arclength derivative at and near the saddle is O(1/y) for y=Im z comparable to pi. On the inner contour with theta=y/(r+u), the derivative is O(1/y) on the local complex arcs, exactly the bound in the coalescing-saddle proof. The remote arcs absorb the polynomial growth. On compact bulk radius ranges theta is strictly less than pi/4. For radii up to 1/16 this follows because Im H at upper angle pi/4, after normalization by 24/rho⁴, is -rho/sqrt(2)+O(rho²) with the same explicit tail <=2rho² as in density_one.md; Im H decreases across the certified core. For intermediate radii the angle enclosure in saddle_certificate.py verifies upper<1/4 in units of pi on every accepted slab. For radii above 32 the large-radius proof gives theta<1/8 radians. Thus on any compact positive radius interval the centered weight is uniformly smooth for j<=4. On intervals tending to zero this remains true for j<=3.

## Removing the degeneracy for a lag of four

Write I[f] for insertion of f into the coefficient integral for P_n(-x), x=n tau. Angular integration by parts gives the exact identity

    (n+4) I[(rho/z)^4]
       = I[(rho/z)^4 h(z)-x rho^4 g(z)],       g(z)=H(z)/z^4.

Indeed integrate the angular derivative of z^(-4) exp(A-xB) z^(-n). The right-hand insertion divided by n+4 defines a weight W. At a zero of I[1], subtracting the real constant Re W(z_*) makes no change. Divide this new weight by the positive rho. Since g(z)=1/6+z/24+O(z²), x rho^4/(n+4)=6(1+O(rho)+O(1/n)), and h(z)=O(rho) on the circle, its angular derivatives of fixed order are uniformly bounded. Its value at the upper saddle is purely imaginary and equals

    -i [1/(4 sqrt(2)) + O(rho+1/n)].

The constant term of g cancels before this normalization. Consequently the same dominant Gaussian estimate, with secondary-pair bound O(exp(-c n rho)), yields a positive multiple of sin G at each high-enough complete phase cell. This yields the prescribed later-row sign uniformly from the fixed outer cut to a small fixed radius. The discontinuity between the two choices of positive scale is harmless because the sign is taken at an actual zero of I[1]. At the two fixed transition cuts used in eventual_interlacing.md choose their integer ranks large enough for every one of the four weights.

## Fixed end ranks

At the near-zero end the already proved adjacent displacement can be summed j times. For fixed k and j the magnitudes decrease strictly with n, and the displacement O(exp(-r)/r) is of smaller order than the separation r^(1/3)exp(-r) between consecutive ranks. Hence for j=1,2,3,4 the k-th inner zero of the later row lies between the corresponding two inner zeros as required.

At the far end, for j=1,2,3 the four fixed-rank limits in edge_theorem.md are strictly ordered, including any single wrap of the residue mod four. For j=4 the same residue recurs, so a first-order refinement is needed. In the notation of that proof, on every compact u disk the reciprocal polynomial has an expansion

    R_(m,s)(u)=F_s(u)+G_s(u)/m+o(1/m)

for some entire G_s. Here is a uniform justification. Let b(z)=24B(z)/z⁴=1+z/5+O(z²). For |z|<=M and 0<=l<=m,

    exp(A(z/m)) b(z/m)^(m-l) = exp(z/5) + O_M((1+l)/m),
    0 <= 1-(m)_l/m^l <= l(l-1)/(2m).

The first estimate follows by taking the analytic logarithm near one and using a uniform exponential bound before comparing exponentials. The second follows from the product of 1-i/m. For each fixed l both factors have expansions through order 1/m by Taylor expansion. Apply Cauchy's bound on |z|=M to degree 4l+s; the denominator coefficient for degree s converges to 5^(-s)/s!>0 and has an expansion through order 1/m. After multiplying differences of the normalized coefficients by m, the l-th summands on |u|<=D are bounded by C_(M,s)(1+l²)(625D/M⁴)^l. For l>m the missing term in R has only the limiting coefficient and m<=l, covered by the same bound. Choosing M⁴>625D and applying dominated convergence proves the first-order locally uniform expansion.

Perturbing a simple zero gives its position in the original variable as -C_(s,k) m^5 [1+c_(s,k)/m+o(1/m)] with C_(s,k)>0. On replacing m by m+1 the magnitude for the same outer rank therefore has ratio 1+5/m+o(1/m)>1, while the next rank remains separated by its different leading constant. Thus fixed outer rank k of row n lies strictly between ranks k and k+1 of row n+4, as required for its degree jump.

The signs at all earlier-row roots are now (-1)^(floor(n/4)-k+1) in increasing root order, for each lag. Exactly as for adjacent rows the degree and signs at zero and minus infinity give the desired directed interlacing.
