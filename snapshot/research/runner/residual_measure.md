# The published 57-runner configuration requires at least eight extra runners at radius 1/59

Keep all speeds and phases of the 57-runner certificate credited to tomdif in the public collection. Allow the extra runners arbitrary positive integer speeds and arbitrary real phases, even repeated speeds. At radius d=1/59, **seven extra runners still cannot cover the time circle**. In particular, deriving a 58-runner cover from this specific configuration by changing old runners and adding one requires **changing at least seven of the original runners**. Indeed if m originals were replaced, restoring them in addition to the proposed cover leaves the 57 originals and only m+1 new runners.

## A probability measure on uncovered times

Use Q=59,000,000. For each of the seed's 207 open holes (a,b) form the integer range [ceil(Qa),floor(Qb)] and give its interior the constant density listed in residual_weights.json (in increasing order of a). Divide coordinates by Q to return to the time circle. Endpoint choices have measure zero. Of these intervals 121 have positive density; the sum of the densities is W=303345. The sum of density times integer interval length is T=153120431. Normalize to total mass one. A second verifier checks that for each supported interval and each of the 57 original runners, the entire affine phase lies between j+d and j+1-d for one integer j. Thus the original cover has mass zero. Linear programming was used only to propose the integer densities.

For a new speed v and arbitrary phase, write U=2dQ=2000000. The allowed residues of v times the integer-grid time coordinate, modulo Q, lie in a sliding window of length U. Under this change of variable a component [a,b] becomes [va,vb] with a Jacobian 1/v. Each full period contributes exactly U units. The remaining arc on the circle contributes its intersection length with the window. Multiply each contribution by its corresponding integer density, sum and divide by vT.

The maximum over all continuous window positions is attained at a grid integer. Indeed the intersection length is piecewise affine and its only slope changes occur when either end of the sliding window meets a residual arc endpoint. All these coordinates are integers. For 1<=v<=59940 the exact maximum over all speeds and phases is

    beta = 20159589 / 153120431 = 0.1316583872...

It is attained at speed 160 with window starting at integer 9192800. The programs compute it by different operations: weighted_residual.py accumulates slope jumps in the sliding window, while check_residual_weights.py builds the phase-density prefix integral and subtracts it at each pair of window endpoints. The interval endpoints and comparisons use integer arithmetic. The declared 64-bit bounds cover all products in both procedures.

For v>=59941, each component's remaining partial period contributes at most U units. The mass is bounded by

    U/Q + U W/(vT) <= 7735870501306 / 77359044788527 < beta.

Every extra runner therefore covers at most beta of this probability mass. The union of seven has mass at most 7 beta = 141117123/153120431 < 1. This proves the claim. The calculation gives a necessary number of changes only. It supplies no 58-runner configuration and does not prove that eight extras would suffice.

Reproduce at the MathLab root with Python and NumPy:

    python3 research/runner/weighted_residual.py
    python3 research/runner/check_residual_weights.py

The optional --design flag additionally needs SciPy; it searches for weights and is unnecessary to check the stored certificate.
