#!/bin/bash
# corners.sh -- full-ADC INL at every corner/temp; summary line per run.
core=${1:-../xschem/simulation/adc_core.spice}
V=$(awk 'BEGIN{split("0.05 0.2 0.4 0.6 0.8 0.95",p," ");for(i=1;i<=6;i++)for(j=0;j<8;j++)printf "%.6f ",p[i]+j/2048}')
for c in ${CORNERS:-tt ss ff sf fs}; do for t in ${TEMPS:--40 27 85}; do
  f=scan_c_${c}_${t}.txt
  CORNER=$c TEMP=$t DECAP=1f ./inl_scan.sh $core c${c}${t} $V > $f
  echo "$c ${t}C  $(grep -c ' $' $f) missing | $(awk -f inl_analyze.awk $f | tail -1)"
done; done
