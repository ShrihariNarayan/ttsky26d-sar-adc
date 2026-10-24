#!/bin/bash
# inl_compare.sh -- E1/E2: dense tt INL (32 pts/group, 1/32-LSB resolution) for three netlist variants
#   c20    : current netlist (2.0 um unit caps)
#   c18    : same, CDAC unit caps back to 1.8 um
#   c20_ic : 2.0 um caps + ideal comparator (isolates kickback)
# Results -> inl_compare.log
cd "$(dirname "$0")"
src=../xschem/simulation/adc_core.spice
cp $src core_c20.spice
sed '/sky130_fd_pr__cap_mim_m3_1 W=2 L=2/s/W=2 L=2/W=1.8 L=1.8/' $src > core_c18.spice
sed 's/^x5 vtop VDD vcm clk VSS comp compn comparator$/bcmp comp VSS v = 1.8*u(v(vtop)-v(vcm))/' $src > core_c20_ic.spice
V=$(awk 'BEGIN{split("0.05 0.2 0.4 0.6 0.8 0.95",p," ");for(i=1;i<=6;i++)for(j=0;j<32;j++)printf "%.7f ",p[i]+j/8192}')
log=inl_compare.log; : > $log
echo "check: c18 caps=$(grep -c 'W=1.8 L=1.8' core_c18.spice) (expect 9), ic bsource=$(grep -c '^bcmp' core_c20_ic.spice) (expect 1)" >> $log
for v in c20 c18 c20_ic; do
  echo "$(date +%H:%M) $v start" >> $log
  NP=${NP:-4} DECAP=1f ./inl_scan.sh core_$v.spice $v $V > scan_dense_$v.txt
  echo "$(date +%H:%M) $v: $(awk -f inl_analyze.awk scan_dense_$v.txt | tail -1)" >> $log
  awk -f inl_analyze.awk scan_dense_$v.txt | head -6 | sed 's/^/      /' >> $log
done
echo "$(date +%H:%M) DONE" >> $log
