#!/bin/bash
# fft_iso3.sh -- comparator isolation (512-point FFT, tt 27C), 2 runs in parallel:
#   ic2 : post-layout v2 + smooth ideal comparator (tanh, 50 uV) -> removes the comparator entirely
#   sc  : post-layout v2 + SCHEMATIC comparator                   -> comparator's own layout vs its surroundings
cd "$(dirname "$0")"
export N=512 M=37
bash fft_test.sh adc_core_pex_v2_ic2.spice ic2 > fft_iso_ic2.log 2>&1 &
bash fft_test.sh adc_core_pex_v2_sc.spice  sc  > fft_iso_sc.log  2>&1 &
wait
for v in sch vref vin ic2 sc; do echo "== $v: $(grep -h 'SNDR\|ENOB' fft_iso_$v.log | tr '\n' ' ')"; done > fft_iso_summary.txt
cat fft_iso_summary.txt
