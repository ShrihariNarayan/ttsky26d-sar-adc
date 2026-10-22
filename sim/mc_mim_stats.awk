# sigma/mean of each column of "mc c1 c16 cm16" lines
/^mc /{n++; for(i=2;i<=4;i++){s[i]+=$i; q[i]+=$i*$i}}
END{split("c1_unit c16_separate cm16_m=16",nm," ");
 for(i=2;i<=4;i++){m=s[i]/n; sd=sqrt(q[i]/n-m*m); printf "%-14s mean %8.3f fF  sigma %6.3f %%\n",nm[i-1],m,100*sd/m}
 printf "samples %d\n",n}
