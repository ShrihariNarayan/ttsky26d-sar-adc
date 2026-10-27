# nzgen.py RMS SEED TSTOP_us -- piecewise-constant Gaussian noise source, one new value per conversion.
# The value changes at k*1us + 625 ns (mid-conversion, switch open, 25 ns away from both clock edges), so the sampled value is exactly
# the drawn sample (sampling ends at k*1us + 200 ns). Prints an ngspice PWL source line "vnz vinn vinx ...".
import sys, numpy as np
rms=float(sys.argv[1].rstrip('m'))*(1e-3 if sys.argv[1].endswith('m') else 1); seed=int(sys.argv[2]); T=float(sys.argv[3].rstrip('u'))
rng=np.random.default_rng(seed); n=int(T)+2; v=rng.normal(0,rms,n)
pts=[(0.0,v[0])]
for k in range(1,n):
    t=(k-1)*1e-6+625e-9; pts+= [(t,v[k-1]),(t+20e-9,v[k])]
print('vnz vinn vinx pwl(')
for t,x in pts: print('+ %.4e %.6e'%(t,x))
print('+ )')
