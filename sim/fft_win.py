# fft_win.py DAT [NS] -- windowed (4-term Blackman-Harris) SNDR/ENOB from the first NS conversions
# (used when a run aborted before 512 conversions; same method for every variant -> fair comparison)
import sys, numpy as np
fn=sys.argv[1]; NS=int(sys.argv[2]) if len(sys.argv)>2 else 400
codes=[];prev=0;pend=None
for ln in open(fn):
    t=ln.split()
    try: r=[float(v) for v in t]
    except: continue
    tm,d=r[0],r[1]
    if pend is not None and tm>=pend: codes.append(sum((1 if r[2+i]>0.9 else 0)<<(7-i) for i in range(8))); pend=None
    if prev<0.9<=d: pend=tm+50e-9
    prev=d
x=np.array(codes[1:NS+1],float); n=len(x)
a=[0.35875,0.48829,0.14128,0.01168]; k=np.arange(n)
w=a[0]-a[1]*np.cos(2*np.pi*k/n)+a[2]*np.cos(4*np.pi*k/n)-a[3]*np.cos(6*np.pi*k/n)
X=np.fft.rfft((x-x.mean())*w); P=np.abs(X)**2; P[:4]=0
s=np.argmax(P); sig=P[max(0,s-4):s+5].sum(); noise=P.sum()-sig
sndr=10*np.log10(sig/noise); print(f"{fn}: n={n} SNDR {sndr:.2f} dB ENOB {(sndr-1.76)/6.02:.2f} bit (windowed)")
