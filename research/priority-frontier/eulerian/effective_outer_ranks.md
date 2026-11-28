# Effective interlacing thresholds for genuine outer ranks

Let \(q_{n,1},q_{n,2},\ldots\) denote increasing moduli of the zeros of the reciprocal polynomial \(R_n(w)=w^nH_n(1/w)\), including any nonreal ones when ordering by modulus. The following bounds do not use eventual real-rootedness.

* For every \(n\ge5\), the four smallest-modulus zeros of \(R_n\) are simple negative, and the first four ranks of rows \(n,n+1\) strictly alternate: \(q_{n+1,1}<q_{n,1}<q_{n+1,2}<q_{n,2}<q_{n+1,3}<q_{n,3}<q_{n+1,4}<q_{n,4}\).
* For every \(L\ge1\) the corresponding conclusion for the first \(2L\) ranks holds whenever
\[
                         n\ge24(L+1)^2\log(8(L+1)).                 \tag{1}
\]
Thus at every fixed exterior rank the range left by the proof is finite with a specified endpoint. In the original variable these ranks are the largest nonzero moduli in decreasing order. This does not bound the starting degree for full-row real-rootedness.

## All cluster indices

Write \(t=L+1,\ \rho=L/t,\ s=\rho^{L-1}\), \(Z=8t\), and \(e=1/(32t)\). The [paired-edge expansion](paired_edge.md) has model
\[
       S_{n,L} z^{2L-2} Q(z),\qquad Q(z)=1-(s+1/L)z+(s/t)z^2
\]
for \(R_n(-\rho^n z)\). Let \(z_-<z_+\) be the two positive roots of \(Q\). Since \(1/e_{\rm nat}<s\le1\), where \(e_{\rm nat}=\exp(1)\), the quadratic formula and sum of roots give \(z_-\ge1/2\), \(z_+\le4t\). For \(r=z_+/z_-\) one has \(r+r^{-1}+2=t(s+1/L)^2/s\ge4t/L\); thus \(r\ge1+2/L\) (in fact \(r-1>4/L\)).

On each of the four circles of radii \((1\pm e)z_\pm\), the minimum modulus of \(Q(z)=(1-z/z_-)(1-z/z_+)\) is attained at the positive radius. One factor has modulus exactly \(e\) there; the other has modulus at least \(1/t\), since \(r\ge1+2/L\) and \(e<1/(2t)\) with the chosen value. All four circles lie in the annulus \(1/Z\le |z|\le Z\).

Divide by \(S_{n,L}z^{2L-2}\). The absolute contribution on this annulus of all cells except \(\{L,L+1\}^2\) is at most \(4Z^2\sum_{h\ge1}(h+1)Y^h\), with \(Y=LZe^{-n/t^2}\), by the paired-edge tail bound. Under (1), \(Y\le Z^{-22}\), so the bound is at most \(12Z^{-20}\). In the four leading cells, each Eulerian number differs from its model power by relative error at most \(t(n+1)e^{-(n-L)/t}\), by the ordered-bin lower bound, for either row. The total model modulus in these cells is at most \((1+Z)^2\). Thus replacing them costs at most \(8 Z^2 n^2e^{-3n/(4t)}\), where \(n-L\ge3n/4\) and \(t(n+1)\le n^2\). For \(n\ge n_0=24t^2\log Z\), one has \(n^2\le e^{n/(4t)}\). Indeed \(n_0\le Z^4\) gives \(2\log n_0\le8\log Z\le n_0/(4t)\), and \(\log(n)/n\) decreases afterwards. The leading-cell error is therefore at most \(8Z^{2-12t}\). These two errors add to less than \(e/t=1/(32t^2)\).

Rouché on the four circles gives respectively \(2L-2,2L-1,2L-1,2L\) zeros of \(R_n(-\rho^n z)\) inside them. Each intervening one-zero annulus contains a real zero by conjugation, positive in the scaled variable by the positive coefficients in the original variable, and simple by the count. In particular
\[
 q_{n,2L-1}\in \rho^n z_-(1-e,1+e),\qquad
 q_{n,2L}\in \rho^n z_+(1-e,1+e).
\]
Since \(\rho(1+e)<1-e\) and \(\rho(1-e)r>1+e\), both ranks and their cross-comparison have the asserted ordering at \(n,n+1\). Across successive cluster indices \(j,j+1\le L\), the scale ratio \((\rho_{j+1}/\rho_j)^n\ge\exp(n/(j+1)^2)\) from \(\rho_j/\rho_{j+1}=1-1/(j+1)^2\). This separates the older upper radius \(\rho_j^n 4(j+1)(1+e_j)\) from the later lower radius \(\rho_{j+1}^{n+1}(1-e_{j+1})/2\). Condition (1) holds for every smaller index as well, proving the second assertion.

## Bridging the second cluster at every degree

For \(L=2\) take the four *fixed rational* radii \(1,6/5,4,22/5\) in the scale \((2/3)^n\). The model is \(Q(z)=1-7z/6+2z^2/9\), with alternating crossing signs \(+,-,-,+\) there. On \(1\le |z|\le5\) the discarded-cell error is at most \(100((1-Y)^{-2}-1)\), \(Y=10(8/9)^n\), by the exact largest outward scalar ratio \(8/9\). In each of the four principal cells, the two relative errors are bounded by \(3(n+1)(2/3)^{n-2}\); their ideal absolute sum on the annulus is less than 14 after normalization. The total of both bounds is less than \(1/100\) at \(n=128\) and decreases thereafter; all four boundary values have absolute value greater than \(1/100\). For \(46\le n\le127\), the [exact checker](check_effective_outer_ranks.py) evaluates on each circle the coefficientwise absolute sum for the difference between the actual polynomial and the model. This upper bound is strictly smaller than the boundary minimum of the model, with exclusively rational operations. Thus throughout \(n\ge46\) the four open disks again have counts \(2,3,3,4\).

The brackets \((1,6/5)\) and \((4,22/5)\) in the scale \((2/3)^n\) transfer across rows by the factor \(2/3\). The two smaller moduli are already bounded in the [first-cluster calculation](reciprocal_obstruction.md) by \((1/2,7/10)\) and \((16/5,18/5)\) in the scale \(2^{-n}\). These intervals are strictly ordered across both rows as stated. For \(5\le n<46\) the [joint rational isolation](check_bulk_row_interlacing.py) proves full row interlacing through rank 46, including simple real roots throughout. This completes the unrestricted first-four-rank result.
