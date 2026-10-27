#!/bin/bash
# fft_iso4.sh -- ic3: post-layout v2 + ideal CLOCKED comparator (samples sign(vtop-vcm) at the clk rising edge).
# Stops the stalled ic2 run first.
cd "$(dirname "$0")"
pkill -f "fft_iso3.sh" 2>/dev/null; pkill -f "fft_test.sh adc_core_pex_v2_ic2" 2>/dev/null; pkill -f "run_ic2.cir" 2>/dev/null; sleep 2
export N=512 M=37
# quick 16-point sanity run first (about 1 min), then the full run
N=16 M=3 bash fft_test.sh adc_core_pex_v2_ic3.spice ic3q > fft_iso_ic3q.log 2>&1
bash fft_test.sh adc_core_pex_v2_ic3.spice ic3 > fft_iso_ic3.log 2>&1
for v in sch vref vin ic3; do echo "== $v: $(grep -h 'SNDR\|ENOB' fft_iso_$v.log | tr '\n' ' ')"; done > fft_iso_summary.txt
cat fft_iso_summary.txt
