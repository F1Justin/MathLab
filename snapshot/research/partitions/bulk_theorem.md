# A linear number of strictly interlacing zeros for the threshold-four statistic

There exist absolute constants 0<a<b and c>0 such that for all sufficiently large n, P_n and P_(n+1) have at least c n consecutive simple real zeros apiece in (-bn,-an). On each closed interior subinterval, apart from the two boundary cells, the zeros of the two rows strictly alternate. Here “consecutive” refers to zeros on the real line in that interval. This assertion gives no information on nonreal zeros elsewhere. The argument below uses all four residue classes of n at once.

## The two dominant saddles

Write A(z)=z+z²/2+z³/6 and B(z)=exp(z)-1-A(z). For small r>0 choose theta(r) near pi/4 by Im(z B'(z))=0 where z=r exp(i theta). Indeed after dividing by r^4/6 this equation is sin(4 theta)+(r/4)sin(5 theta)+O(r²)=0. The implicit function theorem gives

    theta(r)=pi/4-r/(16 sqrt(2))+O(r²),
    tau(r)=-1/(z B'(z))=6 r^(-4)(1+O(r)).

The value of tau is real positive and strictly decreasing for small r, by the differentiable Laurent expansion. Fix any compact interval 0<r0<r1 sufficiently small and set a=tau(r1), b=tau(r0). Any smaller nondegenerate compact interval may be used.

On the circle of radius r, the real part of the exponential rate is -tau Re B(r exp(iu)). Its global maxima occur only at u=+theta and -theta. To see this, factor out the positive factor tau r^4/24. The remaining real function is

    -cos(4u) - (r/5)cos(5u) + O(r²)

in the C² norm of the circle. The four strict local maxima at r=0 persist near +/-pi/4 and +/-3pi/4. The simple critical points of the leading term persist uniquely in small neighborhoods and its derivative is bounded away from zero off those neighborhoods. The values of the perturbed maxima near +/-pi/4 are 1+r/(5 sqrt(2))+O(r²), and those near +/-3pi/4 are 1-r/(5 sqrt(2))+O(r²). The global pair is therefore the first pair. The angular stationarity condition is Im(z B'(z))=0, so this pair is the one specified above. On the chosen compact parameter interval all the separations away from fixed neighborhoods of the two global maxima, and their negative real curvatures, are bounded uniformly away from zero.

## Oscillation and the neighboring row

For j=0,1 use the same large exponent n and the same real argument t=-n tau in the coefficient integral for P_(n+j)(-n tau)/(n+j)!. The angular exponent is

    f(u)=-tau B(r exp(iu))-iu,

with prefactor exp(A(r exp(iu)))(r exp(iu))^(-j), and outside factor r^(-n)/(2 pi). At u=theta we have f'= -i(tau zB'(z)+1)=0 and Re f''<0. Denote psi(tau)=Im(-tau B(z)-log z). The stationary equation gives psi'=-Im B(z). Since zB'(z) is real and B(z)-zB'(z)/4=-z^5/480+O(z^6),

    Im B(z)=r^5/(480 sqrt(2))+O(r^6)>0.

This sign and its lower bound are uniform on the fixed compact interval. In particular there is a nonzero phase excursion across it.

Expanding the angular integral at the two conjugate maxima gives a positive normalization D_(n,j)(tau) such that, uniformly on [a,b],

    P_(n+j)(-n tau)/D_(n,j) = cos(H_j) + o(1),
    H_j=n psi(tau)+phi(tau)-j theta(tau),
    phi=arg(exp(A(z))/sqrt(-f''(theta))).

Take the square root with positive real part and any continuous phase. More explicitly D is (n+j)! times 2 r^(-n-j) exp(n Re f(theta)) |exp(A(z))/sqrt(-f''(theta))| /sqrt(2 pi n). For completeness, outside fixed neighborhoods of the maxima the integral is exponentially smaller. Inside use v=sqrt(n)(u-theta), Taylor expansion with a uniformly bounded cubic remainder and domination by exp(-c v²). Truncation at fixed |v| followed by dominated convergence gives a uniform o(1) relative to D. The conjugate saddle supplies the conjugate Gaussian. The same argument with the extra analytic prefactor -B gives, for the actual derivative with respect to tau,

    (d/dtau P_(n+j)(-n tau))/(n D_(n,j))
      = -Re B(z) cos H_j + Im B(z) sin H_j + o(1).

Here differentiation is of the coefficient before choosing the integration radius. This avoids differentiating an asymptotic error. Curvatures, amplitudes, phases and their derivatives are smooth on [a,b].

The phase H_j is strictly decreasing for n large because psi' is bounded above by a negative constant. Away from small fixed phase neighborhoods of pi/2+ell*pi, the cosine expansion rules out zeros. Choose these neighborhoods sufficiently small that the sine term dominates the cosine term in the derivative expansion throughout each one; this is possible because Im B has a positive minimum and Re B is bounded. Signs on the endpoints are opposite, and the derivative has constant nonzero sign inside. Each complete cell contains exactly one simple real zero. Their phases differ from pi/2+ell*pi by o(1) uniformly. Since H_1=H_0-theta, and theta stays in a compact subinterval of (0,pi), the two sequences of cells alternate strictly, with row n first in increasing t for the same phase index. Boundary cells account for only O(1) zeros. The number of zeros for each row on the interval is

    n |psi(b)-psi(a)|/pi + O(1).

This is an unconditional positive linear lower bound for the number of real zeros of this specific open-problem polynomial. Establishing an all-root result, or a priority claim in the literature, is separate.
