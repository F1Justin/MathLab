Act as an independent adversarial mathematics referee on both claimed theorems. Work from the definitions, try to falsify every sign, bound and quantifier, inspect the p=7, p=13 boundary cases and the strict inequalities. Identify any necessary repairs, give complete replacement arguments if needed, critique the literature positioning with sources only if known. Distinguish conditional from global results. Return an explicit verdict for each theorem. Manuscript below.

\documentclass[11pt]{article}
\usepackage[T1]{fontenc}
\usepackage{lmodern,amsmath,amssymb,amsthm,microtype}
\usepackage[margin=1.08in]{geometry}
\usepackage[hidelinks]{hyperref}
\newtheorem{theorem}{Theorem}
\newcommand{\dist}[1]{\left\lVert #1\right\rVert}
\title{A sharp phase neighbourhood for consecutive lonely runners}
\author{\href{https://orcid.org/0009-0006-1237-7763}{Chengyi Fang}}
\date{November 2026}
\begin{document}
\maketitle
\begin{abstract}
For the speeds $1,\ldots,p-1$, with $p\ge7$ prime, we determine the
loneliness as a function of all initial phases on the largest centred
cube supporting the local formula. It equals $1/p$ plus the maximum
of the absolute values of $(p-1)/2$ explicit linear forms. The first
competing peaks arise at Farey denominator sum $p+1$. An obstruction
on doubling orbits yields a larger tube in which loneliness cannot
fall below $1/p$ whenever doubling modulo sign has odd order.
\end{abstract}

\section{The phase function}
Write $\dist{x}=\min_{m\in\mathbb Z}|x-m|$. For phases
$u=(u_1,\ldots,u_{p-1})\in\mathbb R^{p-1}$ put
\[
 F(u)=\max_{t\in\mathbb R/\mathbb Z}\min_{1\le j<p}\dist{jt+u_j},
 \qquad
 M(u)=\max_{1\le a<p/2}\left|\frac{(p-a)u_a-au_{p-a}}p\right|.
\]
The maximum exists by compactness. Blanco, Criado and Santos
\cite{bcs} studied the minimum over all phases, including for consecutive
speeds. Already for $1,\ldots,6$ that minimum is $9/67<1/7$
\cite{bcs,zhang}. Poliakova \cite{pol} gives large systems with a small
gap by changing the speeds as well. Here we fix the speeds and ask
exactly what phase changes near the common start can accomplish.

\begin{theorem}\label{main}
Let $p\ge7$ be prime. Take $Q=(p-1)/2$ if $p\equiv3\pmod4$ and
$Q=(p-3)/2$ otherwise. Set $r_0=1/(2Q(p+1))$. On
$\max_j|u_j|\le r_0$ one has $F(u)=1/p+M(u)$.
Every larger centred cube contains a point where the equality fails.
\end{theorem}

In particular the common start is a local minimum. Within this cube
its level set is the linear section $u_a/a=u_{p-a}/(p-a)$ for each
complementary pair. This allows a different common time shift for
each pair. Both $F$ and the linear forms are unchanged by replacing
$u_j$ by $u_j+j\tau$ for a common $\tau$.

\begin{proof}
Write $d=1/p$, $r=\max_j|u_j|\le r_0$. Choose $a$ attaining $M$,
put $b=p-a$, and take $k$ with $ka\equiv1\pmod p$. At
$t=\pm k/p-(u_a+u_b)/p$, the two phase corrections relative to
$\pm k/p$ are $X=(bu_a-au_b)/p$ and $-X$. Take the sign making
the two distances $d+|X|$ (here $d+r<1/2$). All the remaining
speeds had distance at least $2d$ before the correction and change
by at most $(1+2(p-1)/p)r$. Since $4r_0\le d$, they still have
distance at least $d+r$. This proves the lower bound.

Decompose $[0,1]$ using the reduced fractions of denominator at most
$p-1$. Consecutive terms $P/q<R/h$ satisfy $qR-hP=1$ and $q+h\ge p$,
by the standard Farey neighbour identities \cite[Ch.~III]{hw}.
For $t$ in this interval put $A=qt-P+u_q$ and $B=R-ht-u_h$.
If either is negative its absolute value is at most $r$.
Otherwise the distance to the nearer of these two runners is at most
\[
 \min(A,B)\le\frac{hA+qB}{q+h}
 =\frac{1+hu_q-qu_h}{q+h}.
\]
When $q+h=p$ the last quantity is at most $d+M$; when
$q+h\ge p+2$ it is at most $1/(p+2)+r_0\le d$.

Suppose $q+h=p+1$, and now denote the smaller denominator by $q$.
Regardless of endpoint order the numerator of the phase contribution
is bounded by $h|u_q|+qr$. One has $q\le Q$. Indeed the two
denominators are coprime, and if $p=4m+1$ the candidate $2m$ is even.
Using $M\ge((p-q)|u_q|-qr)/p$, we obtain
\[
 \frac{h|u_q|+qr}{p+1}-M
 \le \frac{q|u_q|}{p(p+1)}+
 qr\left(\frac1p+\frac1{p+1}\right)\le\frac{2qr}{p}.
\]
Thus the peak lies below or at $1/(p+1)+2Qr_0/p+M=d+M$.

For sharpness fix $q=Q$ and $h=p+1-q$. We have
$\gcd(q,p+1)=1$: the odd number $q$ differs from $(p+1)/2$ by one
or two. Give indices $q,p-q$ phase $r$, index $h$ phase $-r$, and index
$p-h$ phase $-(p-h)r/h$. The four indices are distinct; set
all other phases to zero. Then $M=(p-2q)r/p$. At $t=k/(p+1)$,
$kq\equiv1\pmod{p+1}$, the two distances for $q,h$ are
$1/(p+1)+r$, while all others are at least $2/(p+1)-r$.
For $r_0<r\le1/(2(p+1))$ the former is strictly greater than
$d+M$ and the latter at least as large as the former. Such points
occur arbitrarily close to the boundary.
\end{proof}

\section{An obstruction on a wider tube}
Let $G=(\mathbb Z/p\mathbb Z)^*/\{\pm1\}$ and
$R(u)=\min_{\tau\in\mathbb R/\mathbb Z}\max_j\dist{u_j+j\tau}$.
The order of $2$ in $G$ is odd for every $p\equiv3\pmod4$ since
$|G|=(p-1)/2$ is then odd.

\begin{theorem}
If the order of $2$ in $G$ is odd, then
\[
 R(u)\le \frac{2(p+1)}{3p-1}\,\frac1p
 \quad\Longrightarrow\quad F(u)\ge1/p .
\]
\end{theorem}
\begin{proof}
Translate time, take real phase representatives, and put
$r=\max_j|u_j|$ equal to the attained minimum $R(u)$.
Suppose $F(u)<d$. Even with lifts of magnitude at most $d$, at the
two times $\pm k/p$, $ka\equiv1\pmod p$, only the speeds $a,p-a$
can have distance strictly below $d$. At positive $k/p$ this requires
$u_a<0$ or $u_{p-a}>0$; at negative $k/p$ the signs reverse.
Consequently both phases in the pair have the same strict sign.
For any $|z|\le(d-r)/(p-1)$ the phases $u_j+jz$ still have magnitude
at most $d$. Hence no such phase vanishes, which implies
\begin{equation}\label{slack}
 |u_j|>j(d-r)/(p-1).
\end{equation}

Take $1\le a<p/2$, $h=p-a$. At $t=\pm k/p-u_h/h$ the runner
$h$ is at distance $d$, and at one sign runner $a$ is at distance
at least $d$ (its correction has size at most $2r<2d$ and $3d<1/2$).
Every correction $u_j-ju_h/h$ has magnitude at most
$(1+(p-1)/h)r\le2d$, by $h\ge(p+1)/2$ and the assumed radius.
A runner attaining distance less than $d$ must therefore have had
nominal distance exactly $2d$, so its class in $G$ is $[2a]$ and
its correction has magnitude greater than $d$.
If its phase had the same sign as $u_h$, one signed difference
would be at most $|u_j|<d$ and the other, by \eqref{slack}, would satisfy
\[
 j|u_h|/h-|u_j|<
 \frac{j}{p-1}\big[(1+(p-1)/h)r-d\big]\le d .
\]
Thus the signs attached to the classes $[a]$ and $[2a]$ must be
opposite. This is impossible around an odd cycle of doubling.
\end{proof}

For $p=59$ the exact formula holds on the cube of radius $1/3480$,
and the obstruction holds on a tube of radius $15/(22\cdot59)$.
Determining the distance from the common-start orbit to the first
strict improvement is open here, even when the order is odd.
For composite moduli the nonunit speeds can introduce further
active constraints, and the argument does not give the same formula.

\paragraph{Verification and contributions.}
Both proofs above are elementary. The accompanying Python file
\texttt{check.py} independently evaluates the complete piecewise-linear
envelope for rational examples using integer arithmetic. At a maximum,
opposite active slopes occur, including a cusp of a single runner.
Consequently $(i+j)t+u_i+u_j$ is integral for some $i,j$ (possibly
equal), and enumeration on one period suffices. These tests are
supplementary. The statements in this note have no Lean formalization
in this release. Chengyi Fang, an undergraduate outside mathematics, initiated the project, set the goals, supervised
the work and supplied the reasoning budget. AI systems produced the
mathematics, programs and manuscript. OpenAI GPT-6.2-Astra supplied
the $p=59$ precursor; the general argument was developed in MathLab
and reconstructed during preparation of this version. The contributor reports no personal verification or understanding of the proofs. Source and executable checks accompany the versioned project at \url{https://github.com/F1Justin/MathLab}.
\begin{thebibliography}{9}
\bibitem{bcs} M. Blanco, F. Criado and F. Santos,
\emph{Coloopless zonotopes and counterexamples to the Shifted Lonely
Runner Conjecture}, \href{https://arxiv.org/abs/2603.24784v4}{arXiv:2603.24784v4}.
\bibitem{pol} D. Poliakova, \emph{More (shifted) runners, less loneliness},
\href{https://arxiv.org/abs/2609.23952}{arXiv:2609.23952}.
\bibitem{zhang} Y. Zhang, \emph{Tight instances of the Lonely Runner Conjecture:
one-entry modifications and the growth of speeds},
\href{https://arxiv.org/abs/2608.13599v3}{arXiv:2608.13599v3}, Appendix A.
\bibitem{hw} G. H. Hardy and E. M. Wright, \emph{An Introduction to
the Theory of Numbers}, 6th ed., Oxford University Press, 2008.
\end{thebibliography}
\end{document}
