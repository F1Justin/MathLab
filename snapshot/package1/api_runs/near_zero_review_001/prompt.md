Review a proposed research note for the polynomial P_n(t)=n![z^n]exp(A(z)+tB(z)). Independently audit the below proof of the near-zero edge. The larger goal is all real zeros and adjacent interlacing. Decide if the theorem as stated survives, then, if possible, give a rigorous leading Airy transition for each fixed nearest simple real zero. In particular, to count zeros and to exclude stray roots on the subcritical side, distinguish compact Airy windows from the zone where the rescaled Airy parameter diverges. State constants and error uniformity precisely. A local, testable lemma with a proof is more valuable than a broad outline. No other tools or data are assumed.

# Scale of the nearest negative real zeros

Let A(z)=z+z²/2+z³/6 and B(z)=exp(z)-1-A(z). Define r=r(n)>0 by rA'(r)=n. For each fixed k, write x_(n,k) for the k-th distinct positive x such that P_n(-x)=0, in increasing order. Then

    x_(n,k) / (r exp(-r)) → 3/(2e).

This statement counts negative real zeros. It locates a different scale from the n and n⁵ scales in the other two notes. The following argument also explains the constant. It does not resolve the distances between the first k roots at the smaller transition scale.

## The rescaled integral

Write x=c r exp(-r) and absorb the factor n! into a positive normalization. Take the coefficient integral on the circle of radius R=r+u where u stays in a bounded interval. Parameterize the angle by v/R. Relative to exp(A(r)) r^(-n), its exponent on bounded v intervals is

    r S_c(w) + T_(c,u)(v) + O(1/r),
    w=u+iv,   S_c(w)=3w²/4-c exp(w).

Here T is bounded and smooth on compact real (c,u,v) sets and T(-v) is the conjugate of T(v). To check this expansion put h=R exp(iv/R)-r=w-v²/(2r)+O(r^(-2)). In A(r+h)-A(r)-n log(1+h/r), the linear term cancels exactly. The quadratic coefficient is 3r/4+1+1/(2r) and the cubic coefficient is 1/6-n/(3r³)=O(1/r). Quartic and higher terms contribute O(1/r) uniformly on bounded h. Since x B(r+h)=c r exp(h)+O(r⁴ exp(-r)), this gives T=w²-(v²/2)S'_c(w). The expansions also hold with any fixed finite number of v derivatives on compact sets by analyticity.

For the tails, the modulus at angle theta relative to its value at 0 is bounded by the exponential of

    -[A(R)-Re A(R exp(i theta))]+2x B(R).

The second term is O(r) for bounded c,u. On |theta|<=delta with fixed small delta, the cubic term of A alone bounds the first difference below by a positive constant times r³ theta². On delta<=|theta|<=pi the quadratic and cubic terms have no common angular maximum, so this difference is at least a constant times r² by compactness. Thus |v|>M contributes exponentially less than the bounded-v dominant saddle region, uniformly for compact sets of c,u, on choosing M sufficiently large. In this comparison the exponent at angle zero relative to the chosen overall normalization is O(r). The full remaining integration length in v is O(r).

## Below the transition

For 0<=c<=c_0<3/(2e) there is a unique u in [0,1) with (3/2)u exp(-u)=c, uniformly bounded away from one. Then S'_c(u)=0, S''_c(u)=(3/2)(1-u)>0 and

    Re[S_c(u+iv)-S_c(u)] = -3v²/4+(3/2)u(1-cos v)
                          <= -(3/4)(1-u)v².

The real saddle has a positive real amplitude exp(T(0)) and curvature. Gaussian integration after the substitution v=s/sqrt(r) gives a strictly positive coefficient uniformly on [0,c_0] for large n. The tail estimate and the displayed quadratic bound supply uniform domination. Thus the interval from zero to c_0 r exp(-r) contains no negative-real zero in magnitude.

## Above the transition

For small y>0 take u=y cot y and c=(3/2)(y/sin y)exp(-u). These give S'_c(u+iy)=0 and its conjugate. We have c=(3/(2e))(1+y²/2+O(y⁴)), with positive derivative for sufficiently small positive y. For fixed y the function Re S_c(u+iv) has precisely two strict global maxima at v=±y. In fact its derivative is (3/2)((y/sin y)sin v-v), sin v/v is strictly decreasing on (0,pi), and y/sin y<2 rules out additional stationary points for v>=pi. The angular curvature is strictly negative at y. All inequalities needed for the two-saddle approximation are uniform when y ranges in a fixed small compact subinterval of (0,pi).

Writing w=u+iy, the coefficient divided by a positive real normalization is

    cos(r Im S_c(w)+phi(c)) + o(1),

uniformly on the corresponding compact c interval. The smooth phase phi is the argument of exp(T(y))/sqrt(S''_c(w)); the square root uses positive real part. As above, Taylor-expand at ±y, set v=±y+s/sqrt(r), and use a Gaussian majorant locally; outside these neighborhoods the compact strict gap and the tail estimate apply. The leading phase derivative in c is -exp(u)sin y<0 by stationarity. Each fixed such interval therefore contains a number of sign changes tending to infinity. For any epsilon>0 an interval of that kind fits between 3/(2e) and 3/(2e)+epsilon. This proves the upper bound for each fixed k, while the single-saddle estimate proves the lower bound.
