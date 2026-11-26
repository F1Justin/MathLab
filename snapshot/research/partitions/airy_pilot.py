"""Floating-point check of the coalescing-saddle prediction, using coefficient integrals."""
from cmath import exp as cexp
from math import cos, exp, factorial, pi, sin
from scipy.integrate import quad
from scipy.optimize import brentq
from scipy.special import ai_zeros

critical = 1.5/exp(1)
b = 1.5/(0.75**(1/3))

def sin_minus_angle(t):
    if abs(t)>0.005:
        return sin(t)-t
    return t**3*(-1/6+t*t*(1/120-t*t/5040))

def wave(r, airy_argument, adjacent=False):
    c = critical*(1+airy_argument/(b*r**(2/3)))
    R = r+1
    x = c*r*exp(-r)
    h = 1.5*r*r+3.5*r+2.5 + x*(R+R*R+R**3/2)
    coeffs = [(1+x)*R**j/factorial(j) for j in (1,2,3)]
    def integrand(v):
        theta = v/R
        dz = R*complex(-2*sin(theta/2)**2,sin(theta))
        p = sum(coeff*complex(-2*sin(j*theta/2)**2,sin_minus_angle(j*theta))
                for j,coeff in enumerate(coeffs,1))
        phase = p + 1j*theta*h - c*r*exp(1)*(cexp(dz)-1)
        return exp(phase.real)*cos(phase.imag - adjacent*theta)
    # On small rows integrate the entire circle; large-r tails are exponentially suppressed.
    vmax = R*pi if r<16 else 8
    value, _ = quad(integrand,0,vmax,epsabs=2e-10,epsrel=1e-10,limit=400)
    return value

def sample(r):
    zeros = []
    left, f_left = 0., wave(r,0.)
    for i in range(1,260):
        right = i/8
        f_right = wave(r,right)
        if f_left*f_right<0:
            zeros.append(brentq(lambda q:wave(r,q),left,right))
            if len(zeros)==2:
                break
        left, f_left = right, f_right
    return zeros

if __name__ == '__main__':
    import warnings
    from scipy.integrate import IntegrationWarning
    with warnings.catch_warnings():
        warnings.simplefilter('error',IntegrationWarning)
        print('Airy predictions', *(-ai_zeros(2)[0]))
        for r in (12,24,48,96,192,384,768,1536,3072):
            n = r+r*r+r**3//2
            roots = sample(r)
            ratios = []
            for root in roots:
                # q is b times the lambda used in the proof.
                shift = (2/3)*b*r**(-4/3)
                adjacent = brentq(lambda q:wave(r,q,True),root-4*shift,root)
                ratios.append((root-adjacent)/shift)
            print(r,n,*roots,*ratios,flush=True)
