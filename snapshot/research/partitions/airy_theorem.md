# The Airy edge and adjacent-row spacing at zero

Let P_n(t)=n![z^n] exp(A(z)+t B(z)), A(z)=z+z²/2+z³/6, B(z)=exp(z)-1-A(z). Let r+r²+r³/2=n, r>0, c₀=3/(2e), a=(3/4)^(1/3), b=3/(2a). Let 0<d₁<d₂<... be the positive numbers for which Ai(-d_k)=0. For each fixed K and sufficiently large n, the K zeros of P_n nearest to zero in complex modulus are simple negative real numbers. Write them as -x_(n,k), in increasing order of positive magnitude. Then for fixed k,

    x_(n,k) = c₀ r exp(-r) [1+(d_k/b)r^(-2/3)+O_k(r^(-1))],
    x_(n,k)-x_(n+1,k) ~ exp(-r)/(e r).

In particular the nearest fixed windows in adjacent rows strictly interlace: x_(n+1,k)<x_(n,k)<x_(n+1,k+1). The spacing between neighbors in one row is of order r^(1/3) exp(-r), much greater than the shift to the next row.

## Local integral

Put x=c r exp(-r). Integrate the coefficient at radius R=r+u₀ for bounded real u₀, with angle v/R; the integral from -pi R to pi R then uses dv/(2pi R). After factoring out exp(A(r))r^(-n), the exponent for bounded (possibly complex) c and bounded real v is

    r S_c(w)+T(v)+O(1/r),     w=u₀+iv,
    S_c(w)=3w²/4-c exp(w),    T(v)=w²-(v²/2) S'_c(w).

Indeed h=R exp(iv/R)-r=w-v²/(2r)+O(r^(-2)). In A(r+h)-A(r)-n log(1+h/r), the linear coefficient vanishes, the quadratic coefficient is 3r/4+1+1/(2r), the cubic coefficient is O(1/r), and the higher-order remainder on bounded h is O(1/r). The B term is c r exp(h)+O(r⁴ exp(-r)). All errors are uniform on bounded parameter sets.

The part with |v|>M is exponentially small relative to any saddle used below, for a sufficiently large fixed M. In the logarithm of the integrand modulus the B term at any angle contributes at most |x|B(R)=O(r). For |v/R| less than fixed small delta, A(R)-Re A(R exp(iv/R)) >= c₁ r v² by the cubic term. Outside this arc the quadratic and cubic terms of A have no common maximum, so the same difference is at least c₂ r². The overall exponential at angle zero relative to the chosen prefactor has logarithmic modulus O(r). Polynomial factors, including the O(r) integration length, preserve the tail bound.

## Compact Airy windows

Set c=c₀(1+lambda r^(-2/3)), take u₀=1-r^(-1/3), and write v=s r^(-1/3), q=-1+is. Factor out exp(-3r/4-(3/2)lambda r^(1/3)); multiply by r^(1/3) to change variables and by R to cancel the measure factor. The normalized integral F_n(lambda) is entire in lambda and has the same zeros as P_n(-x). On compact s,lambda sets, the remaining integrand tends to

    e exp(-q³/4-(3/2)lambda q).

This uses S'_(c₀)(1)=S''_(c₀)(1)=0 and S'''_(c₀)(1)=-3/2. An integrable majorant on |v|<=M is C exp(-d s²+C|s|) for bounded complex lambda. In fact the drop for c=c₀ from angle v=0 in Re S is at most
-3v²/4+c₀ exp(u₀)(1-cos v) <= -(3/4)(1-exp(-r^(-1/3)))v².
The change due to lambda, after subtracting its value at v=0, is bounded by C r^(-2/3)|v| before multiplying by r. The normalized integrand at v=0 stays bounded, and the preceding tail estimate handles the rest of the circle. Consequently F_n converges locally uniformly in complex lambda, with its derivatives, to

    F(lambda)=(e/a) Ai(-b lambda).

The error in this convergence, on each fixed complex compact set and for each fixed derivative, is O(r^(-1/3)). On |v|<=M, Taylor expansion at w=1 bounds the difference of the exact and limiting normalized exponents by C r^(-1/3)(1+|s|^4). Both exponentials have the preceding Gaussian majorant, so integrating the exponent difference times the maximum modulus of the two exponentials gives the rate. For derivatives use Cauchy on a larger compact disk. Since the limiting zeros are simple, the lambda coordinates differ from d_k/b by O_k(r^(-1/3)). The last identity is the vertical-contour Airy integral with t=-a q, Re t=a. Rouché's theorem near each simple limit zero gives one simple zero, real by conjugation. On compact sets disjoint from the limit zeros there are none for large n.

## Excluding zeros closer in complex modulus

It remains to exclude zeros escaping every compact Airy window on the inner side; compact convergence alone would not suffice. Consider a prospective sequence of zeros with |c|<=c₀(1+L r^(-2/3)) for fixed L and with |lambda| divergent. Pass to a subsequence on which c converges to a point in the closed critical disk. Solve (3/2)u exp(-u)=c on the branch through u=0. For |c|<c₀, the map u ↦ (2/3)c exp(u) contracts the closed disk of radius rho<1 solving rho exp(-rho)=(2/3)|c|. At a boundary point other than c₀ the branch continues with |u|<1: an inner radial limit exists along a subsequence, and equality |u|=1 would force Re u=1 in the modulus equation, hence c=c₀. The inverse function theorem at this limit gives a saddle in a neighborhood, which is all that is required.

At a sequence tending to c₀, set delta=c/c₀-1. Then Re delta<=L r^(-2/3), and |delta| r^(2/3) tends to infinity. The local inverse with h=1-u has h=sqrt(-2 delta)+O(delta), choosing the square root of positive real part. Indeed (1-h)exp(h)=1-h²/2+O(h³) is analytically invertible in the square-root parameter. Since Re delta/|delta| is bounded above by o(1), Re h is at least a fixed positive multiple of |h|. Thus 1-|u| is also at least a fixed positive multiple of |h| and r|h|³ tends to infinity.

Choose R=r+Re u, so the vertical w line passes through u at v=Im u. For every real t,

    Re[S_c(u+it)-S_c(u)]
      = Re[-3t²/4-(3/2)u(exp(it)-1-it)]
      <= -(3/4)(1-|u|)t²,

using the integral Taylor bound |exp(it)-1-it|<=t²/2. On scaling t=s/sqrt(r|1-u|), the saddle integral relative to exp(r S_c(u)+T(Im u)) has a nonvanishing complex Gaussian main term, with relative error o(1). Explicitly the limiting quadratic coefficient along any subsequence on which h/|h| converges is -(3/4)h/|h|, with real part uniformly negative. The scaled cubic remainder is O(|s|³/sqrt(r|h|³)) on bounded s, the displayed bound gives a Gaussian majorant, and the remote tails were already excluded. The same argument applies when u stays strictly inside the unit disk and |h| is bounded below. This contradicts a zero for every such sequence. Taking L strictly between d_K/b and d_(K+1)/b now proves the asserted count in the entire disk: for bounded lambda the disk condition implies Re lambda<=L+o(1), and the Airy function's zeros are all simple and negative in its argument.

## Direction and size of the shift to the next row

On the same circle and at the same x, form F_(n,1) from the identical integral with extra factor (r+1)/z. It differs from P_(n+1)(-x) by a nonzero analytic normalization. For fixed s,

    r^(4/3) [(r+1)/z-1] → -q.

On |v|<=M the left-hand side is bounded by C(1+|s|) since z=R exp(iv/R). On the remaining arc a polynomial loss is absorbed by the exponential tail. The same dominated convergence now gives, uniformly on compact lambda sets,

    r^(4/3) [F_(n,1)-F_n] → (2/3) F'(lambda).

This computation cancels all common errors before expanding. Let lambda_n be the k-th root parameter and mu_n the nearby zero of F_(n,1), both expressed using r(n). They have the same simple limit. For the adjacent row the preceding zero count labels this root as the k-th one: r(n+1)-r(n)=O(r^(-2)) changes its scaled parameter by o(1). The real mean value theorem and local uniform derivative convergence give mu_n-lambda_n=-(2/3)r^(-4/3)(1+o(1)). Multiplying by c₀ r exp(-r) r^(-2/3) yields the stated adjacent-row gap.

The numerical programs near_zero_pilot.py and airy_pilot.py use independent methods. The former isolates polynomial roots; the latter evaluates a floating-point angular integral and provides scale diagnostics only.
