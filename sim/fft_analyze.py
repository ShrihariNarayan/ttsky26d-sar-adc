# fft_analyze.py DAT N M -- codes from the sine test -> SNDR / SFDR / ENOB (coherent, no window)
import sys, cmath, math
fn=sys.argv[1]; N=int(sys.argv[2]); M=int(sys.argv[3])
rows=[]
for ln in open(fn):
    t=ln.split()
    try: rows.append([float(v) for v in t])
    except ValueError: continue          # header line
codes=[]; prev=0.0; pend=None
for r in rows:
    tm,done=r[0],r[1]
    if pend is not None and tm>=pend:
        codes.append(sum((1 if r[2+i]>0.9 else 0)<<(7-i) for i in range(8))); pend=None
    if prev<0.9<=done: pend=tm+50e-9      # code register is stable 50 ns after done rises
    prev=done
print(f"conversions captured: {len(codes)}")
if len(codes)<N+1: sys.exit("not enough conversions")
x=codes[1:N+1]                            # drop the first (power-up) conversion
mean=sum(x)/N
X=[sum((x[n]-mean)*cmath.exp(-2j*math.pi*k*n/N) for n in range(N)) for k in range(N//2+1)]
P=[abs(v)**2 for v in X]; P[0]=0.0
sig=P[M]; noise=sum(P)-sig
h=[P[(M*k)%N if (M*k)%N<=N//2 else N-(M*k)%N] for k in range(2,8)]
sndr=10*math.log10(sig/noise); sfdr=10*math.log10(sig/max(P[k] for k in range(1,N//2+1) if k!=M))
amp=2*math.sqrt(sig)/N; dbfs=20*math.log10(amp/128.0)
enob=(sndr-1.76)/6.02; enob_fs=(sndr-dbfs-1.76)/6.02
print(f"codes min {min(x)} max {max(x)}  | signal amplitude {amp:.1f} LSB ({dbfs:+.2f} dBFS)")
print(f"SNDR {sndr:.2f} dB | SFDR {sfdr:.2f} dB | THD(2..7) {10*math.log10(sum(h)/sig):.2f} dB")
print(f"ENOB {enob:.2f} bit  (normalised to full scale: {enob_fs:.2f} bit)")
