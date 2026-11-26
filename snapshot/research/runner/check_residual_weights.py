"""Independent exact verification via prefix integrals on the phase circle."""
import json
from fractions import Fraction
from math import ceil, floor
import numpy as np
from frozen_extension import ROOT
from weighted_residual import intervals, period, width, folder

def verify():
    base=json.loads((ROOT/'package1/results/known_slr_57.json').read_text())
    weights=np.array(json.loads((folder/'residual_weights.json').read_text()),dtype=np.int64)
    cert=json.loads((folder/'weighted_residual.json').read_text())
    lo,hi=intervals()
    selected=weights>0
    lo,hi,weights=lo[selected],hi[selected],weights[selected]
    assert len(lo)==cert['positive_intervals'] and np.all(hi>lo)
    assert np.all(lo[1:]>=hi[:-1])
    for a,b in zip(lo,hi):
        for v,shift in zip(base['speeds'],base['shift_num']):
            s=Fraction(shift,base['shift_den'])
            left=s+Fraction(v*int(a),period)
            right=s+Fraction(v*int(b),period)
            j=floor(left)
            assert left>=j+Fraction(1,59) and right<=j+1-Fraction(1,59)
    total=int((hi-lo)@weights)
    wsum=int(weights.sum())
    limit=cert['tested_through_speed']
    assert total==cert['total_weighted_length_units'] and wsum==cert['total_weight']
    assert 0<limit*total<2**62 and 8*period*wsum<2**62
    best=Fraction(0)
    for v in range(1,limit+1):
        a=(v*lo)%period
        whole,rem=np.divmod(v*(hi-lo),period)
        end=(a+rem)%period
        wrap=int(weights[a>end].sum())
        coords=np.concatenate(([0],a,end,[period]))
        increments=np.concatenate(([wrap],weights,-weights,[0]))
        order=coords.argsort()
        points,starts=np.unique(coords[order],return_index=True)
        density=np.add.reduceat(increments[order],starts).cumsum()
        integral=np.concatenate(([0],np.cumsum(np.diff(points)*density[:-1])))
        assert integral[-1]==rem@weights
        def primitive(t):
            cycles,t=np.divmod(t,period)
            pos=np.searchsorted(points,t,side='right')-1
            return cycles*integral[-1]+integral[pos]+(t-points[pos])*density[pos]
        cuts=np.concatenate((points[:-1],(points[:-1]-width)%period))
        mass=int((primitive(cuts+width)-primitive(cuts)).max())+width*int(whole@weights)
        best=max(best,Fraction(mass,v*total))
    tail=Fraction(width,period)+Fraction(width*wsum,(limit+1)*total)
    assert best==Fraction(cert['finite_speed_max'])
    assert tail==Fraction(cert['high_speed_upper_bound'])
    necessary=ceil(1/max(best,tail))
    assert necessary==cert['minimum_extra_runners']
    return dict(exact_fraction=str(best),necessary=necessary,verified_intervals=len(lo))

if __name__=='__main__':
    print(json.dumps(verify(),indent=2))
