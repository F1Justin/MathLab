# Extreme zeros of the four-element block statistic

Let P_n(t) count all set partitions of [n] by the number of blocks of size at least four. Put n=4m+r, 0<=r<=3, and c=24/625. For each fixed K, for sufficiently large m the K zeros of largest modulus are simple negative real numbers. If indexed in decreasing modulus, their asymptotics are

    t_(4m+r,k) ~ -c m^5 / (4 x_(r,k)^4),    1 <= k <= K.

Here x_(0,k)=(k-1/2)pi, x_(2,k)=k*pi, x_(1,k) is the unique solution of tan x = -tanh x between x_(0,k) and x_(2,k), and x_(3,k) is the unique positive solution of tan x = tanh x between x_(2,k) and x_(0,k+1). These finite outer windows strictly interlace in the conjectured direction for all sufficiently large n, including the degree increase from 4m+3 to 4m+4.

## Coefficient limit

Write A(z)=z+z²/2+z³/6, H(z)=24(e^z-1-A(z))/z^4=1+z/5+O(z²), and a_(n,b)=[t^b]P_n(t). By the exponential formula,

    a_(n,m-l) = n! 24^(-(m-l))/(m-l)! [z^(4l+r)] exp(A(z)) H(z)^(m-l).

For fixed h and l the coefficient [z^h]exp(A) H^(m-l) is a polynomial in m with leading term m^h/(5^h h!). This follows by expanding in (H-1), whose lowest degree is one. The normalized reciprocal polynomial

    R_(m,r)(u) = sum_(l=0)^m (a_(n,m-l)/a_(n,m)) (u/(c m^5))^l

therefore converges coefficientwise to F_r(u)=sum_(l>=0) r! u^l/(4l+r)!. To get local uniform convergence, for M>0 use the circle |z|=M/m. The nonnegative coefficients of H are bounded termwise by those of exp(z), so exp(A(M/m))H(M/m)^(m-l) <= exp(A(M)+M) for m>=1. Cauchy's bound with h=4l+r gives (m/M)^h times this constant. The denominator coefficient [z^r]exp(A)H^m is >= d_r m^r for some d_r>0 and sufficiently large m, and m!/(m-l)! <= m^l. Consequently the absolute value of the l-th summand on |u|<=B is bounded by C_(M,r) (625 B/M^4)^l. Take M^4>625 B. The omitted tail for l>m is zero.

## Limiting zeros

Put G_r(x)=x^r F_r(-4x^4)/r!. Successive integration from zero gives G_0=cos(x)cosh(x), G_1=(sin(x)cosh(x)+cos(x)sinh(x))/2, G_2=sin(x)sinh(x)/2 and G_3=(sin(x)cosh(x)-cos(x)sinh(x))/4. For G_1 and G_3 the nonzero roots satisfy tan z = +/- tanh z. The poles of either side cannot be zeros of the original expressions. If z=x+iy and xy is nonzero, equating the real and imaginary parts of those equations implies

    sin(2x) sin(2y) = sinh(2x) sinh(2y),

which is impossible in absolute value. Thus all nonzero zeros are on the real and imaginary axes. Symmetry G_r(ix)=i^r G_r(x) identifies the axes after mapping by -4x^4. The elementary sine and cosine factors give the same axis property for r=0,2. The nonzero real roots are simple: for the tangent equations the relevant derivatives are sec²x +/- sech²x, strictly positive at positive zeros. The factors for r=0,2 have simple positive roots. Removing x^r at the origin leaves F_r(0)=1. Thus the zeros of F_r are precisely the simple negative numbers -4x_(r,k)^4.

Choose a circle centered at zero with radius strictly between the Kth and (K+1)st limiting moduli, and disjoint small disks centered at the K enclosed zeros. Uniform convergence and Rouché's theorem give exactly K zeros inside the large circle and exactly one, counted with multiplicity, in each small disk for all sufficiently large m. Real coefficients and conjugation force each single zero to be real. Reciprocation gives the K largest-modulus roots of P_n. The strict inequalities x_(0,k)<x_(1,k)<x_(2,k)<x_(3,k)<x_(0,k+1) transfer to each fixed window; at the degree jump (m+1)^5/m^5 tends to one. This proves the stated finite-window theorem. Uniformity up to K=floor(n/4) remains open.

Problem and prior work: Jack Zhan, *Real-rooted polynomials for set partitions* (2023), and the current SymCat big-block conjecture, https://www.symmetricfunctions.com/realRootedOpenProblems.htm . Related literature by Bóna and Mező studies partitions forbidding singleton blocks and their leftmost roots, https://people.clas.ufl.edu/bona/files/bigblocknew_asymp.pdf . No priority claim is made.

## Review request

Independently audit the proof, including all constants, multiplicities, the wraparound ordering and the quantifier on K. Then try to solve the full all-n threshold-four interlacing problem. Prefer a concrete new sufficient invariant or an exact obstruction to it. The short recurrence is P_(n+1)=(1+t d/dt)P_n + nP_(n-1) + binom(n,2)P_(n-2) + t binom(n,3)P_(n-3). The empty row is P_0=1 and negative rows vanish. Separate proven statements from unproven ones.
