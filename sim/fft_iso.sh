#!/bin/bash
# fft_iso.sh -- isolation test (option B): 512-point FFT, tt 27C, run in parallel (1 core each):
#   sch     : schematic adc_core (no layout parasitics)        -> architecture baseline
#   ic      : v2 post-layout + IDEAL comparator                -> comparator (kickback/memory) share
#   vref    : v2 post-layout + ideal Vref source (no 500 ohm)  -> Vref settling share
#   vin     : v2 post-layout + ideal Vin source (no 500 ohm)   -> input tracking share
# (v2 post-layout baseline already done: fft_v2n512.log, ENOB 7.30)
cd "$(dirname "$0")"
export N=512 M=37
bash fft_test.sh ../xschem/simulation/adc_core.spice sch > fft_iso_sch.log 2>&1 &
bash fft_test.sh adc_core_pex_v2_ic.spice ic          > fft_iso_ic.log 2>&1 &
RREF=1m bash fft_test.sh adc_core_pex_v2.spice vref   > fft_iso_vref.log 2>&1 &
RIN=1m bash fft_test.sh adc_core_pex_v2.spice vin     > fft_iso_vin.log 2>&1 &
wait
for v in sch ic vref vin; do echo "== $v: $(grep -h 'SNDR\|ENOB' fft_iso_$v.log | tr '\n' ' ')"; done > fft_iso_summary.txt
cat fft_iso_summary.txt
