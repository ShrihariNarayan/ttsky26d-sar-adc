#!/bin/bash
# full_verify.sh -- complete schematic-level verification of the full ADC, in sequence:
#   1) tt 27C INL (48 points)  2) 15 corners INL  3) full-ramp DNL (1024 points, tt)
# Writes progress to full_verify.log (one line per stage).
cd "$(dirname "$0")"
log=full_verify.log; : > $log
V=$(awk 'BEGIN{split("0.05 0.2 0.4 0.6 0.8 0.95",p," ");for(i=1;i<=6;i++)for(j=0;j<8;j++)printf "%.6f ",p[i]+j/2048}')
echo "$(date +%H:%M) [1/3] tt INL start" >> $log
DECAP=1f ./inl_scan.sh ../xschem/simulation/adc_core.spice real $V > scan_real.txt
echo "$(date +%H:%M) [1/3] tt: $(awk -f inl_analyze.awk scan_real.txt | tail -1)" >> $log
echo "$(date +%H:%M) [2/3] corners start" >> $log
./corners.sh > corners_summary.txt 2>&1
awk '{print "      " $0}' corners_summary.txt >> $log
echo "$(date +%H:%M) [3/3] DNL ramp start" >> $log
./dnl_ramp.sh >> $log 2>&1
echo "$(date +%H:%M) ALL DONE" >> $log
