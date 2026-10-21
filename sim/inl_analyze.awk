# inl_analyze.awk -- input "vin code" lines from inl_scan.sh (8 points per test voltage, LSB/8 apart).
# error = code - floor(256*vin); its mean over 8 sub-LSB points = shift of the code transitions (LSB).
# A straight line (offset + gain) is fitted to the means; the residuals are the INL at those points.
NF>=2 && $2!="" { v=$1; c=$2; p=int(v*20+0.5)/20; e=c-int(v*256); s[p]+=e; n[p]++ }
END {
  k=0; for (p in s) { m[p]=s[p]/n[p]; P[++k]=p }
  for (i=1;i<=k;i++) for (j=i+1;j<=k;j++) if (P[j]<P[i]) { t=P[i]; P[i]=P[j]; P[j]=t }
  sx=sy=sxx=sxy=0
  for (i=1;i<=k;i++) { x=P[i]; y=m[x]; sx+=x; sy+=y; sxx+=x*x; sxy+=x*y }
  b=(k*sxy-sx*sy)/(k*sxx-sx*sx); a=(sy-b*sx)/k; mx=0
  for (i=1;i<=k;i++) { x=P[i]; r=m[x]-(a+b*x); ar=(r<0)?-r:r; if (ar>mx) mx=ar
    printf "vin~%.2f  mean_err %+.3f LSB  (n=%d)  INL %+.3f LSB\n", x, m[x], n[x], r }
  printf "line fit: offset %+.3f LSB, slope %+.3f LSB/V   ->  max |INL| %.3f LSB\n", a, b, mx
}
