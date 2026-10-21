#!/bin/bash
# dnl_ramp.sh [core] -- 4 points/LSB ramp over 0..1 V (1024 runs), then histogram DNL.
core=${1:-../xschem/simulation/adc_core.spice}
V=$(awk 'BEGIN{for(i=0;i<1024;i++)printf "%.6f ",(i+0.5)/1024}')
DECAP=1f ./inl_scan.sh $core ramp $V > scan_ramp.txt
awk -f dnl_analyze.awk scan_ramp.txt
