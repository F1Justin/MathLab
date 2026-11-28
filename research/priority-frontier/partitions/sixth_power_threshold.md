# Real zeros above a sixth-power block threshold

There is an absolute \(C>0\) such that for every sufficiently large \(N\) and every integer
\[
              C N^{1/6}(\log N)^2\le j\le N,
\]
all \(\lfloor N/j\rfloor\) zeros of the set-partition polynomial \(P_{N,j}(t)\) counting blocks of size at least \(j\) are simple and negative. The crossover comparison below uses the third cumulant of the complete tilt. The Bell-dominated region uses the positive four-point cubic quadrature rule with one node at zero.

Maintain \(L=\log N,\ V=\max(1,N/j^2),\ m=N-kj,\ U=\max(1,m/j^2),\ J=P=\lceil A U L^2\rceil,\ R'=AB U L^2,\ R=R'L^2\) for the fixed large constants of the [fifth-power comparison](fifth_power_threshold.md). Its large-ratio and [uniform outer](uniform_outer_curvature.md) estimates dispose of \(j>2\sqrt{NL}\) and \(m\le j^2/(20\log j)\). Throughout the rest, \(jR/m\ll_{A,B}L^5/j=o(L^{-3})\), \(\log m\asymp L\), and \(m>j^2/(20L)\). As before \(A,B\) are chosen absolutely before \(C\).

The complex full-saddle lemma in the fifth-power proof is independent of its fifth-power threshold: it uses only the displayed bounds on \(m,j,R\), with \(j\) growing at least as a positive power of \(N\). For the exact coefficient \(C(m,k)=[z^m]\exp(e^z-1)H(z)^k\) it supplies \(\log C_*(s)=\Lambda(s)+U_0(s)\) on \(|s|\le R\); beyond its constant and linear terms, the contribution of \(U_0\) on \(R'\) is \(O(L^{-3})\). At the real center \(r=r_0\), let \(\nu=\mathcal D\log H(r),\ w_H=\mathcal D\nu,\ E=j+\nu,\ B_2=(1+r)re^r+kw_H,\ B_3=\mathcal D B_2\) with \(\mathcal D=r\partial_r\) at fixed \(k\). Then \(c m\le B_2\le C_1 mL\) and \(\Lambda''=-E^2/B_2\).

## Matching the true third derivative in the crossover

The exact identity at zero is
\[
             \Lambda'''=3E^2w_H/B_2^2-E^3 B_3/B_2^3 .               \tag{1}
\]
It follows from \(d\log r/ds=-E/B_2\) and \(d B_2/ds=w_H-E B_3/B_2\) along \(M=m-js,\ K=k+s\). The Bell parts of \(B_3,B_2\) are \(r(1+3r+r^2)e^r\) and \(r(1+r)e^r\). For the excess law \(\mathcal D w_H=r/(j+1)+O((r/j)^2)\), just as for \(w_H\), uniformly even when \(r\to0\). Hence \(c B_2\le B_3\le C_2 L B_2\) and \(w_H=O(L/j)\). In particular
\[
 -\Lambda'''(0)=(1+o(1))E^3 B_3/B_2^3,\qquad
 \frac{c j^3}{m^2 L^2}\le-\Lambda'''(0)\le\frac{C_3j^3 L}{m^2}.
\]
Also \(|\Lambda''''(s)|\ll j^4 L^2/m^3\) on \(R'\), by the Cauchy bound for \(\Lambda''\) on \(|s|\le c m/(jL)\) from that lemma.

Take \(v=\lfloor m/(C_4 jL)\rfloor\), \(T=k+v,\ g(s)=\log\Gamma(v+1)-\log\Gamma(v+1-s)\), with an absolute \(C_4\) taken large below. Put \(K_0=\Lambda-g,\ \alpha_0=-K_0''(0),\ \alpha_1=-K_0'''(0)\). Since \(|g''(0)|=O(1/v),\ |g'''(0)|=O(1/v^2)\), both subtractions change the two leading derivatives by relative \(o(1)\). In particular
\[
       w=\alpha_0/\alpha_1=(1+o(1))B_2^2/(E B_3)\ge c_5m/(jL).
\]
Choose \(C_4>3/c_5\), permissible since \(c_5\) is obtained from the original saddle bounds and the relative errors tend to zero for every fixed \(C_4\). Thus \(w>v>R\). Put \(b(s)=\log(1-s/w)\), \(p=\operatorname{round}(\alpha_1 w^3/2)\); the number rounded is \(\alpha_0 w^2/2\gg m/L^3\). Then
\[
 |K_0'''(0)-p b'''(0)|\le w^{-3},\qquad
 d=p b''(0)-K_0''(0)=(1/2+o(1))\alpha_0>0.
\]
The fourth derivative of \(p b\) on \(R'\) costs \(O(\alpha_1/w+w^{-4})=O(j^4L^2/m^3)\), as does the fourth derivative of \(K_0\).

Use the finite reference \(\sum_{i=0}^T\binom Ti (k+w-i)^p e^{-d\binom i2}z^i\). Scale its center coefficient and first derivative as in the fifth-power proof. On \(R'\) the logarithm of the exact local coefficient multiplier \(\Phi\) is bounded by
\[
       O\!\left(L^{-3}+(R'/w)^3+
                           \frac{j^4L^2(R')^4}{m^3}\right).           \tag{2}
\]
The middle term is \(o(1)\) since \(R'/w\ll_{A,B}L^4/j\). Use this construction when \(m\le VL^2\). If \(m\ge j^2\), the last term in (2) is \(O_{A,B}(mL^{10}/j^4)=O_{A,B}(L^{12}/j^4+NL^{12}/j^6)\); for \(m<j^2\) it is \(O_{A,B}(L^{13}/j^2)\). The theorem's choice of \(C\) guarantees \(\sup|\log\Phi|\le\log2\).

## Matching five derivatives in the Bell-dominated region

Suppose \(m>VL^2\). Put \(L_m=1+W(m)\), and now take \(v=\lfloor m/(2j)\rfloor,\ T=k+v\), with \(g,K_0\) defined using this \(v\). The larger-disk Bell saddle of the fifth-power proof gives, for \(2\le q\le5\),
\[
 K_0^{(q)}(0)=-(1+o(1))(q-2)!\frac{j^q}{m^{q-1}L_m},\qquad
       \sup_{|s|\le R'} |K_0^{(6)}(s)|\ll\frac{j^6}{m^5 L}.
\]
Indeed \(\Lambda''=-j^2/[M(1+W(M))]\,(1+O(VL/m+L/j^2))\) on the complex disk of radius \(m/(10j)\). The analytic error can be differentiated there by Cauchy's estimates. For the main term, on a fixed fractional disk in \(M\) the ratio \((1+W(m))/(1+W(M))=1+O(1/L)\), also stable under any fixed number of scaled derivatives by Cauchy. The \(g^{(q)}=O_q(v^{1-q})\) contributions are of relative order \(L/j\).

Use nodes \(t_1=1/3,\ t_2=2/3,\ t_3=1\). Choose the three real \(\beta_i\) by the nonsingular linear system
\[
 \sum_{i=1}^3\beta_i t_i^{q-2}
        =-\frac{K_0^{(q)}(0)m^{q-1}L_m}{(q-1)!\,j^q},
                    \qquad q=3,4,5 .
\]
The right sides approach \(1/(q-1)=\int_0^1 x^{q-2}\,dx\). The limiting vector is \((3/8,3/8,1/8)\) by the cubic quadrature rule at \(0,1/3,2/3,1\) with weights \((1/8,3/8,3/8,1/8)\); the three monomials vanish at zero. Thus \(\beta_i>0\) and \(\sum_i\beta_i=7/8+o(1)\).

Put \(w_i=m/(j t_i)>v,\ b_i(s)=\log(1-s/w_i)\), and \(p_i=\operatorname{round}(m\beta_i/(L_m t_i^2))\). These integers are positive. Before rounding, the three derivatives of \(\sum_i p_i b_i\) in the system agree exactly with those of \(K_0\). After rounding their errors are \(O_q((j/m)^q)\). The leftover curvature is
\[
             d=\sum_i p_i b_i''(0)-K_0''(0)
                      =(1/8+o(1))j^2/(mL_m)>0 .
\]
Use the finite reference
\[
      \sum_{a=0}^T \binom Ta \prod_{i=1}^{3}(k+w_i-a)^{p_i}
                        e^{-d\binom a2}z^a .
\]
It is a succession of the reflected degree multipliers from the fifth-power proof. Each has parameter \(k+w_i>T\) and preserves real negative roots. The final \(q\)-modification gives strict \(e^d\)-separation. Scaling its constant factor and argument matches the center coefficient and linear variation exactly. The normalized log multiplier is \(\log C_*(s)-\log C_*(0)-S s -[g(s)-g'(0)s]-\sum_i p_i[b_i(s)-b_i'(0)s]+d s^2/2\), \(S=(\log C_*)'(0)\).

The sixth derivatives of the reference correction satisfy \(\sum_i p_i/w_i^6=O(j^6/(m^5L))\). Hence the local comparison on \(R'\) obeys
\[
       |\log\Phi|\ll L^{-3}+(jR'/m)^3+
                             \frac{j^6(R')^6}{m^5L}.
\]
For \(m\ge j^2\) the final term is \(O_{A,B}(N L^{11}/j^6)=o(1)\) in the stated range. For \(m<j^2\) it is \(O_{A,B}(L^{16}/j^4)=o(1)\) using \(m>j^2/(20L)\). This proves the needed multiplier bounds also in the Bell-dominated region.

## Comparing the actual roots

In either construction \(c_6/(UL)\le d\le C_6 L\). The finite center log-curvature is
\[
 \log(1+1/k)+\log(1+1/v)+d+
      \sum_i p_i\log\!\left(\frac{w_i^2}{w_i^2-1}\right)=O(L),
\]
with one factor in the crossover, because \(\sum_i p_i/w_i^2=O(j^2/m)\). All reference log-curvatures are at least \(d\). Also \(D-k>R\) and \(T-k=v>R\). Thus both finite supports, deformed separation, coefficient log-concavity, and the central Taylor bounds required by the [root-count comparison](quarter_power_threshold.md) hold. Choose \(A\) to dominate its absolute curvature and midpoint constants, then \(B\) to bound the differential Taylor perturbation by \(1/4\), and finally \(C\) to give \(\sup_{R'}|\log\Phi|\le\log2\) in (2). This counts exactly \(k\) shifted roots in a zero-free circle for every \(1\le k<D\). Conjugation, the degree count, and positivity on \(t\ge0\) give the theorem.
