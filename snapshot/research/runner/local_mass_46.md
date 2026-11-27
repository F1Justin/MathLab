# A sharp 23-track lower bound for the primitive-row local test through speed 46

For a local affine replacement of the even-speed baseline, suppose that every removed or rephased even speed is at most 46. Allow arbitrary distinct positive odd integer speeds and real phases of the form \(a+h\delta\). If the replacement satisfies the primitive-row witness test, its net saving is at most zero. Indeed, exactly 23 charged tracks are necessary and sufficient to serve the rows of the first 23 even speeds. This rules out a positive local saving at every even cutoff through 46. The first cutoff left open by this certificate is 48.

Here the baseline contains all even speeds through the cutoff. We count each retained or rephased even speed through 46 and each inserted odd speed once. Unchanged even speeds above 46 may help for free. A smaller cutoff embeds by padding with unchanged even speeds, including when the original baseline was shorter. The conclusion concerns a sufficient construction test. A circle covering at one specific radius need not admit its witnesses at the same rational centers.

## A finite weighted test

For each even \(q\le 46\) the test has rows \(c=k/q\), where \(\gcd(k,q/2)=1\). At every point \(x=z/q\), \(-1\le z\le1\), a witness of speed \(v\) and phase coefficients \(a,h\) must satisfy
\[
vc+a\in\mathbb Z,\qquad |vx+h|\le1.
\]
Retaining an original speed at zero phase serves all of its own rows.

The [certificate](local_mass_46.json) contains 34 quadruples \((q,d,z,w)\). Each places mass \(w/(2\varphi(d))\) at both slopes \(x=\pm z/q\) and at each reduced center of denominator \(d\). The verifier checks that every such center belongs to a required row and that \(z>1/(1+\lfloor46/q\rfloor)\).

An unchanged even helper can hit the center only if its speed is divisible by \(d\). Here \(d=q\), or \(d=q/2\) with \(d\) odd, so the even multiples of \(d\) are exactly multiples of \(q\). Above 46 their speeds are at least \(q(1+\lfloor46/q\rfloor)\). At either signed slope such a helper has \(|vx|>1\). Consequently all 578 probes must be served by charged tracks.

At a fixed speed and intercept, the accessible probes have one common residue \(vc\bmod1\). Within that residue class the accessible slopes lie in one closed interval of width \(2/v\), whatever real offset \(h\) is chosen. For speeds below 2689 the [integer verifier](local_mass_46.py) groups probes by residue, orders the slopes, and computes the heaviest closed window with two moving endpoints. It includes every positive odd speed below the threshold and all chargeable even speeds. From 2689 on, ignoring the residue restriction altogether gives maximum mass one at 2689. Increasing the speed can only shorten the window. The [complete Lean project](../../../certificates/primitive-row-46/primitive46-lean.zip) proves the bound for the full primitive-row model, including free even-speed helpers, every finite representative and the infinite tail. A separate integer verifier reproduces the same inputs.

The total mass is \(45/2\). Each track collects mass at most one, with the following permitted excesses per distinct speed.

| Speed | Excess |
| ---: | ---: |
| 6 | 1/4 |
| 18 | 3/16 |
| 315 | 5/96 |

If \(m\) tracks cover all probes, summing their capacities gives
\[
m\ \ge\ \frac{45}{2}-\frac14-\frac3{16}-\frac5{96}
=22+\frac1{96}.
\]
Hence \(m\ge23\). The 23 original zero-phase even tracks attain this bound. In particular, a 58-runner construction pursued by a uniform saving in this class must remove or rephase at least one even speed of 48 or greater.

Run `python3 research/runner/local_mass_46.py` from the project root. The certificate arithmetic uses only Python integers and exact fractions. The verifier requires assertions enabled.
