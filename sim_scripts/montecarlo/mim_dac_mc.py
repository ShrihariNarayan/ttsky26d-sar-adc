# mim_dac_mc.py -- statistical (Python) Monte Carlo of CDAC unit-cap mismatch -> static DNL/INL.
# Sigma taken from the PDK MiM model: czero dev/gauss = 0.01*2.8*C/sqrt(W*L*mf). Ideal comparator/switches.
# Run: python3 mim_dac_mc.py   (2026-10-22: sigma_u 1.56%, DNL 3sigma +-0.68, |INL| 3sigma 0.45 LSB)
import numpy as np
rng=np.random.default_rng(1)
N=20000; w=l=1.8
sig_u=0.01*2.8/np.sqrt(w*l)          # PDK: dev/gauss = 0.028*C/sqrt(W*L*mf)  -> per-unit sigma
mf=np.array([1,2,4,8,16,32,64,128])   # C0..C7
codes=np.arange(256)
bits=((codes[:,None]>>np.arange(8))&1)
res=[]
for _ in range(N):
    C=np.array([rng.normal(1,sig_u,m).sum() for m in mf])   # each group = sum of its units
    Cd=rng.normal(1,sig_u)
    Ct=C.sum()+Cd
    T=bits@C/Ct            # transition levels (code k starts at T_k), units of Vref
    T=T[1:]                # 255 transitions
    st=np.diff(T); lsb=(T[-1]-T[0])/254
    dnl=st/lsb-1
    inl=(T-T[0])/lsb-np.arange(255)
    res.append((dnl.max(),dnl.min(),np.abs(inl).max()))
r=np.array(res)
print(f"unit sigma {sig_u*100:.2f}%  (C = {w}x{w} um)")
for name,col in (("DNL max",r[:,0]),("DNL min",r[:,1]),("|INL| max",r[:,2])):
    print(f"{name:9s} mean {col.mean():+.3f}  sigma {col.std():.3f}  99.7% {np.percentile(col if name!='DNL min' else -col,99.7)*(1 if name!='DNL min' else -1):+.3f} LSB")
print("missing-code risk (DNL<-0.9):",(r[:,1]<-0.9).mean()*100,"%;  DNL<-0.5:",(r[:,1]<-0.5).mean()*100,"%")
