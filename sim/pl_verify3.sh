#!/bin/bash
# pl_verify.sh -- POST-LAYOUT verification of the full ADC (C-only PEX netlist adc_core_pex.spice):
#   1) tt 27C INL (48 points)  2) 15 corners INL  3) full-ramp DNL (1024 points, tt)
# Same method as full_verify.sh; results go to pl_* files so the schematic results are kept.
cd "$(dirname "$0")"
core=${CORE:-adc_core_pex_v3.spice}; P=${P:-pl3}
log=${P}_verify.log; : > $log
V=$(awk 'BEGIN{split("0.05 0.2 0.4 0.6 0.8 0.95",p," ");for(i=1;i<=6;i++)for(j=0;j<8;j++)printf "%.6f ",p[i]+j/2048}')
echo "$(date +%H:%M) [1/3] tt INL start (post-layout)" >> $log
DECAP=1f ./inl_scan.sh $core ${P}tt $V > ${P}_scan_tt.txt
echo "$(date +%H:%M) [1/3] tt: $(grep -c ' $' ${P}_scan_tt.txt) missing | $(awk -f inl_analyze.awk ${P}_scan_tt.txt | tail -1)" >> $log
echo "$(date +%H:%M) [2/3] corners start" >> $log
for c in tt ss ff sf fs; do for t in -40 27 85; do
  f=${P}_scan_c_${c}_${t}.txt
  CORNER=$c TEMP=$t DECAP=1f ./inl_scan.sh $core ${P}${c}${t} $V > $f
  echo "      $c ${t}C  $(grep -c ' $' $f) missing | $(awk -f inl_analyze.awk $f | tail -1)" >> $log
done; done
echo "$(date +%H:%M) [3/3] DNL ramp start" >> $log
R=$(awk 'BEGIN{for(i=0;i<1024;i++)printf "%.6f ",(i+0.5)/1024}')
DECAP=1f ./inl_scan.sh $core ${P}ramp $R > ${P}_scan_ramp.txt
awk -f dnl_analyze.awk ${P}_scan_ramp.txt >> $log
echo "$(date +%H:%M) ALL DONE" >> $log
