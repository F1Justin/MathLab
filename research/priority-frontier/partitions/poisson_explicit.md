# An explicit mean threshold for the dominant conjugate pair

Let \(X\) have a log-concave probability mass function on an interval of nonnegative integers, with mean \(\mu\ge128\) and variance \(0<V\le\mu\). Put \(\phi(t)=\mathbb E e^{itX}\). The real part of \(\phi\) has a unique minimum on \([0,\pi]\). Its location \(t_*\) satisfies
\[
  \frac{4\pi}{5\mu}<t_*<\frac{6\pi}{5\mu},\qquad
  \Re\mathbb E X^s e^{it_*X}<0\ (s=1,2),\qquad \Im\phi(t_*)>0 .
\]
For a Poisson random variable conditioned on \(X\ge j\), \(t_*<\pi/j\) whenever its conditional mean is at least 128. In particular the angular hypothesis for [eventual row interlacing](fixed_threshold_rows.md) holds at every radius when \(j\ge128\). The [asymptotic version](poisson_saddle.md) also gives \(\mu t_*\to\pi\).

## The modulus away from the first minimum

Let \(Y=X-X'\) for an independent copy. Its symmetric mass function is log-concave by convolution, and \(v=\mathbb EY^2=2V\). We first prove \(\mathbb EY^4\le v+6v^2\). Take the symmetric two-sided geometric mass function \(g_k=(1-a)a^{|k|}/(1+a)\), choosing \(0<a<1\) so that \(v=2a/(1-a)^2\). Its characteristic function is \([1+v(1-\cos t)]^{-1}\), so its fourth moment is \(v+6v^2\). On \(k\ge0\) the ratio \(\Pr(Y=k)/g_k\) is log-concave. Consequently the positive part of the mass difference is supported on an interval and the difference is nonpositive on either side. Unless the laws coincide, equality of mass and second moment forces negative differences on both sides. Choose \(u,w\ge0\) between the squared indices at the two sign changes. Multiply the difference at \(k\) by \((k^2-u)(k^2-w)\), sum with multiplicity two off zero, and use the matched first two even moments. Every summand is nonpositive, which gives the fourth moment comparison. Finite support causes no change. All moments exist by the geometric decay of summable log-concave tails. Expanding the fourth moment of \(X-X'\) gives \(\mathbb E(X-\mu)^4\le V+9V^2\).

The symmetric law of \(Y\) is a mixture of discrete uniform laws on \([-k,k]\), with weights \((2k+1)(\Pr(Y=k)-\Pr(Y=k+1))\). Write \(W=k(k+1)/3\) for the component variance. Its fourth moment is \((9W^2-W)/5\), so
\[
 \mathbb EW=2V,\qquad \frac{\mathbb EW^2}{\mathbb EW}\le \frac23+\frac{20}3 V.
\]
Put \(a_0=2/\pi^2\). For \(kt\le\pi\), the component satisfies \(1-\mathbb E\cos(tY)\ge a_0 Wt^2\), by the quadratic lower bound for \(1-\cos\). For \(kt\ge\pi,\ 0<t\le\pi\), its normalized Dirichlet kernel has modulus at most \(\pi/((2k+1)t)<1/2\). These bounds dominate \(a_0 Wt^2/(1+2a_0 Wt^2)\) in both ranges. Cauchy–Schwarz applied to the mixture yields
\[
 1-|\phi(t)|^2\ge \frac{2a_0 Vt^2}{1+2a_0t^2(2/3+20V/3)} .
\]
Take \(b=23/10\). At \(t_0=\pi/\mu\) one has \(1+\Re\phi(t_0)\le V\pi^2/(2\mu^2)\). For \(t\ge b\pi/\mu\), the displayed lower bound increases with \(t\), and \(1+\Re\phi(t)\ge(1-|\phi(t)|^2)/2\). At the left endpoint its ratio to the trial upper bound is at least
\[
 \frac{4b^2/\pi^2}{1+4b^2(2+20\mu)/(3\mu^2)}>1 .
\]
The denominator decreases for \(\mu\ge128\), and at 128 it is below \(2.104\), while the numerator exceeds \(2.14\).

## Location, uniqueness and signs

Taylor's inequality gives \(|\phi(t)-e^{it\mu}|\le Vt^2/2\). Outside the claimed interval, split \(u=\mu t\) into \([0,4\pi/5]\), \([6\pi/5,3\pi/2]\), and \([3\pi/2,23\pi/10]\). On the first two intervals \(\cos u\ge-\cos(\pi/5)\) and \(Vt^2/2\le(3\pi/2)^2/(2\mu)\). On the third \(\cos u\ge0\) and \(Vt^2/2\le(23\pi/10)^2/(2\mu)\). Each resulting lower bound for \(\Re\phi(t)\) exceeds \(-1+\pi^2/(2\mu)\) at \(\mu\ge128\).

On the remaining interval \(\cos(\mu t)\le-\cos(\pi/5)\). For \(s=1,2\) we have
\[
 \left|\mu^{-s}\mathbb E[X^s e^{itX}]-e^{it\mu}\right|
 \le 2/\sqrt{\mu}+1/\mu+(6\pi/5)^2/(2\mu)<1/4.
\]
Indeed \(\mathbb E|(X/\mu)^2-1|\le 2\sqrt V/\mu+V/\mu^2\), and the corresponding linear bound is smaller. This proves strict convexity and both real-part signs. Write \(\delta=X-\mu\). At the minimum \(\mathbb EX\sin(t_*X)=0\). From \(|e^{ix}-1-ix|\le x^2/2\) and Cauchy–Schwarz,
\[
 \big|\mathbb E\delta e^{it\delta}-itV\big|
 \le t^2 V\sqrt{1+9V}/2 .
\]
For \(t=t_*\) the last bound divided by \(tV\) is at most \((6\pi/5)\sqrt{1+9\mu}/(2\mu)<0.51\). Thus \(\mathbb E\delta\sin(t_*X)<0\), and stationarity gives \(\mu\Im\phi(t_*)>0\).

## The endpoint \(\pi/j\)

For the conditioned Poisson law at positive radius, the previous note proves \(V\le\mu\). Put \(U=X-j,\ m=\mathbb EU>0\). If \(m\ge j/5\) the location bound gives \(t_*<\pi/j\). Otherwise \(j>\mu/(6/5)\ge106\). The tails \(q_i=\Pr(U\ge i)\) are log-concave, hence \(q_{i_1+\dots+i_k}\le\prod q_{i_h}\) for positive indices. Summing over ordered \(k\)-tuples gives \(\mathbb E\binom Uk\le m^k\). In particular \(\mathbb EU^3\le6m^3+6m^2+m\) and \(\mathbb EU^4\le24m^4+36m^3+14m^2+m\). With \(\mathbb E[XU]\ge jm\) this implies
\[
  \frac{\mathbb E[XU^3]}{j^2\mathbb E[XU]}
  \le 0.432+2.64/j+3.8/j^2+1/j^3<6/\pi^2 .
\]
Hence \(\mathbb E[X\sin(\pi U/j)]>0\) by \(\sin x\ge x-x^3/6\) for \(x\ge0\). This is the derivative of \(\Re\phi\) at \(\pi/j\). This point lies within the interval of strict convexity and therefore to the right of \(t_*\).
