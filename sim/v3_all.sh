#!/bin/bash
# v3_all.sh -- full verification of v3 (vtop/vcm re-routed off the comparator):
# 1-minute sanity run -> 512-point FFT (+ analog power) -> tt INL -> 15 corners -> DNL ramp (pl3_verify.log)
cd "$(dirname "$0")"
N=16 M=3 timeout 600 bash fft_test.sh adc_core_pex_v3.spice v3q > fft_v3q.log 2>&1
if ! grep -q ENOB fft_v3q.log; then echo "v3 sanity run FAILED" >> fft_v3q.log; exit 1; fi
N=512 M=37 bash fft_test.sh adc_core_pex_v3.spice v3 > fft_v3.log 2>&1
bash pl_verify3.sh
