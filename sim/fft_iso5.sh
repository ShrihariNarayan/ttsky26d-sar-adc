#!/bin/bash
# fft_iso5.sh -- kb: post-layout v2, real extracted comparator, but its inputs are ideal buffered copies of
# vtop / vcm (kickback onto vtop/vcm removed). 1-minute sanity run first; full 512-point run only if it works.
cd "$(dirname "$0")"
N=16 M=3 timeout 600 bash fft_test.sh adc_core_pex_v2_kb.spice kbq > fft_iso_kbq.log 2>&1
if ! grep -q ENOB fft_iso_kbq.log; then echo "kb sanity run FAILED -- full run not started" >> fft_iso_kbq.log; exit 1; fi
N=512 M=37 bash fft_test.sh adc_core_pex_v2_kb.spice kb > fft_iso_kb.log 2>&1
for v in sch vref vin kb; do echo "== $v: $(grep -h 'SNDR\|ENOB' fft_iso_$v.log | tr '\n' ' ')"; done > fft_iso_summary.txt
cat fft_iso_summary.txt
