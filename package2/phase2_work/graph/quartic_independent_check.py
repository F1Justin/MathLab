"""Independent exact audit starting from the quartic collision polynomial.

This checks algebra and elementary congruences. The accompanying review proves
the positivity, compactness, and quantifier steps by mathematical reasoning.
Run: python quartic_independent_check.py
"""
from pathlib import Path
import hashlib
import json
import sympy as s

a, u, q, k, t, r = s.symbols("a u q k t r")
# t represents v^2. This is eight times x^4+y^4-z^4-t_original^4.
original = (u+2*a)**4 + 6*(u+2*a)**2*q**2 + q**4 - u**4 - 6*u**2*t - t**2
trial = q**2 + s.Rational(4, 3)*a*(u+a)
positive_at_trial = s.factor(original.subs(t, trial))
assert positive_at_trial == s.Rational(64, 9)*a*(a+u)*(2*a**2+2*a*u+3*q**2)

D = 8*a*u + 9*a**2 - k
R = (9*k-25*a**2)*u**2 + 4*a*u*(k-9*a**2) + 2*k**2 - 18*a**4
substituted = original.subs(t, q**2+s.Rational(4, 3)*(a*u+k))
assert s.expand(substituted+s.Rational(8, 9)*(R-3*q**2*D)) == 0

F = 9*(k-a**2)*((k-a**2)**2+64*a**4)
# Derive the quotient polynomial, instead of assuming the draft's L1.
quotient, remainder = s.div(s.expand(F-64*a**2*R), D, u)
assert remainder == 0
J = s.expand(quotient+192*a**2*q**2)
assert s.expand(F-D*J-64*a**2*(R-3*q**2*D)) == 0

mod3_poly = s.Poly(s.expand(J-2*a**2*(a*u+k)), a, u, q, k)
mod8_poly = s.Poly(s.expand(J+(k-a**2)**2), a, u, q, k)
assert all(int(c) % 3 == 0 for c in mod3_poly.coeffs())
assert all(int(c) % 8 == 0 for c in mod8_poly.coeffs())
admissible = [j for j in range(1, 25) if j % 3 == 0 and j % 8 in (0, 4, 7)]
assert min(admissible) == 12

rewritten = (9*u**2+4*a*u+3*q**2)*k+2*k**2 - (25*a**2*u**2+36*a**3*u+18*a**4+24*a*u*q**2+27*a**2*q**2)
assert s.expand(rewritten-(R-3*q**2*D)) == 0

cubic = 9*r**3-24*r**2+1152*r-512
objective = ((16+9*r)/24)**5 * s.Rational(96, 9)/(r*(r**2+64))
objective_derivative = s.factor(s.diff(objective, r))
positive_factor = 2*(9*r+16)**4/(r**2*(r**2+64)**2) * s.Rational(96, 9)/24**5
assert s.factor(objective_derivative-positive_factor*cubic) == 0
assert s.expand(s.diff(cubic, r)-(27*(r-s.Rational(8, 9))**2+s.Rational(3392, 3))) == 0
endpoint = s.Rational(16, 9)
assert cubic.subs(r, endpoint) == s.Rational(122368, 81)
minimum = s.factor(objective.subs(r, endpoint))
assert minimum == s.Rational(32, 85)
assert minimum * 64 == s.Rational(2048, 85)
A5 = s.factor((s.Rational(96, 9)/(r*(r**2+64))).subs(r, endpoint))
assert A5 == s.Rational(243, 2720)

draft = Path(__file__).parents[1] / "erdos" / "quartic_constant_draft.md"
report = {
    "reviewed_draft_sha256": hashlib.sha256(draft.read_bytes()).hexdigest(),
    "independent_original_polynomial_check": True,
    "positive_at_k_equals_a_squared": str(positive_at_trial),
    "derived_J": str(J),
    "polynomial_and_congruence_checks": True,
    "positive_quotients_through_24_allowed_by_mod_3_8": admissible,
    "cubic_endpoint": str(cubic.subs(r, endpoint)),
    "A5_at_relaxed_minimum": str(A5),
    "V5_minimum": str(minimum),
    "H10_over_N6_lower_limit": str(minimum*64),
    "constant_decimal": str(s.N((minimum*64)**s.Rational(1, 10), 30)),
    "limits_checked_in": "quartic_independent_review.md",
}
output = Path(__file__).with_name("results") / "quartic_independent_check.json"
output.write_text(json.dumps(report, indent=2)+"\n")
print(json.dumps(report, indent=2))
