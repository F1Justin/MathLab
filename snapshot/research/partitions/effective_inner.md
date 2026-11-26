# An explicit interval free of negative real zeros in every row

Let $r+r^2+r^3/2=n$, $s=(15/r)^{1/3}$, $d=1-s/5$, and $c_*=3/(2e)$. For each integer $n\ge1$,
$$
  P_n(-x)>0,\qquad 0\le x\le \tfrac32 d e^{-d}\, r e^{-r}.
$$
For $n\le2004$ the stronger upper endpoint $c_* r e^{-r}$ works. For $n\ge2000$ the displayed coefficient differs from $c_*$ by at most $c_* e^{1/5}(15/r)^{2/3}/50$. This locates the edge to one side on its natural scale. It gives a real interval, without a claim about complex zeros inside the corresponding disk.

## Real saddle

Put $a(R)=R+R^2+R^3/2$, $A(z)=z+z^2/2+z^3/6$, $B=e^z-1-A$, and $F=A-xB$. For $n\ge2000$, $r>15$ and $4/5\le d<1$. Since $a(r+d)-a(r)\ge(3/2)d r(r+d)\ge x(r+d)e^{r+d}$, continuity gives $R\in[r,r+d]$ with $F_1(R)=n$, where subscripts denote powers of the Euler derivative. Put $\beta=xe^R/R\le 3d/2$ and $v=F_2(R)/R^3$. The identity
$$
 v=(1+x)(3/2+2/R+1/R^2)-\beta(1+1/R)
$$
and $F_2\le A_2$ give $0.3s\le v<1.64$.

On the coefficient circle set $L=(R^3v)^{1/2}$, $y=L\theta$, $H=F(Re^{i\theta})-F(R)-in\theta$. The sign of $P_n(-x)$ is the sign of $\int_0^{\pi L}\Re(e^H)\,dy$. In the following estimates every terminating decimal denotes its exact rational value.
$$
 |\Im H|\le0.56y^3,\qquad
 \Re H\ge-y^2/2-0.07y^4,\qquad
 \Re H\le-0.42y^2\quad (0\le\theta\le\sqrt{s}/5).
$$
For the first use $|\sin t-t|\le |t|^3/6$ and add the third moments of $A$ and $xe^z$. The constant is bounded by
$$
 \frac{(4.5+4/R+1/R^2)/R+\beta(1+3/R+1/R^2)}
 {6\sqrt{Rv^3}},
$$
where $Rv^3\ge15(0.3)^3$. For the lower real bound the fourth-order remainder of $\cos t$ costs only the negative part, of fourth moment at most $\beta R^5(1+6/R+7/R^2+1/R^3)$. Use $Rv^2\ge15(0.3)^2$. For the upper real bound only the $A$ fourth moment costs anything; it is $(13.5+8/R+1/R^2)R^3$. Use $\theta^2\le s/25$ and $v\ge0.3s$.

For $\sqrt{s}/5\le\theta\le\pi/3$ the loss $A(R)-\Re A(Re^{i\theta})$ from the cubic alone is at least $0.029sR^3\ge R^2/4$, by $1-\cos t\ge t^2/2-t^4/24$ at $t=3\sqrt{s}/5$. Up to $5\pi/6$ the quadratic term then gives $R^2/4$, and on the final arc the cubic gives $R^3/6$. The negative part adds at most $2\beta R\le3R$, hence $\Re H\le-R^2/20$ on the exterior.

The core runs beyond $y=4/3$ because $R^3s^2\ge15^3$. Its integrand is nonnegative up to $4/3$. On $[0,1]$ its integral exceeds $(1-0.56^2/2)(1-1/6-0.07/5)>2/3$. The intermediate tail has absolute integral at most $e^{-0.42(4/3)^2}/(0.84(4/3))<0.52$. The exterior costs at most $\pi\sqrt{1.64}R^{3/2}e^{-R^2/20}<1/50$, since this majorant decreases for $R\ge15$. The net positive margin exceeds $1/10$. For the deficit estimate use $1-(1-s/5)e^{s/5}=\int_0^{s/5}t e^t\,dt$.

## Finite rows and verification

For each $1\le n\le2004$ the checker constructs $P_n$ by the exact integer recurrence, brackets $r$ with strict inequalities on the increasing cubic, then forms $P_n(t-c_*r e^{-r})$ with outward-rounded Arb coefficients. Every coefficient is strictly positive, so $P_n(-x)>0$ on the full claimed interval, endpoints included. In these rows $d>0$ since $r(1)>1/2$, and $d e^{-d}\le1/e$.

[Independent numerical-inequality and finite-row checker](effective_inner.py) · [verification record](effective_inner.json) · [original model derivation](../../package1/api_runs/effective_inner_001/answer.md). The latter also proposes a two-sided first-root and next-row estimate for $r\ge10^{24}$. The checker verifies its rational Airy endpoint table. The two-sided estimate is recorded separately from the all-row result proved here.
