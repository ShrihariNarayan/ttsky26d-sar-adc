# histogram DNL: hits per code vs average hits (codes 1..254; end codes absorb overrange)
{ if ($2=="") miss_run++; else n[$2]++ }
END{
  for(c=1;c<=254;c++){tot+=n[c]} avg=tot/254
  for(c=1;c<=254;c++){d=n[c]/avg-1; if(n[c]==0){mc++; list=list" "c}
    if(d>mx)mx=d; if(d<mn)mn=d; if(d>0.5||d<-0.5)printf "code %d hits %d DNL %+.2f\n",c,n[c],d}
  printf "avg hits/code %.2f | DNL max %+.2f min %+.2f LSB | missing codes %d%s | failed runs %d\n",avg,mx,mn,mc+0,list,miss_run+0
}
