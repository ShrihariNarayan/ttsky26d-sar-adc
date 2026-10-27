#!/bin/bash
# fft_v3r.sh -- re-run of the v3 512-point FFT, which aborted at 421.6 us ("timestep too small" on the clock
# source, a numerical event). Uses the Gear integration method, which damps such step-size collapses.
cd "$(dirname "$0")"
N=16 M=3 OPTS=".options method=gear" timeout 600 bash fft_test.sh adc_core_pex_v3.spice v3gq > fft_v3gq.log 2>&1
grep -q ENOB fft_v3gq.log || { echo "gear sanity FAILED" >> fft_v3gq.log; exit 1; }
N=512 M=37 OPTS=".options method=gear" bash fft_test.sh adc_core_pex_v3.spice v3g > fft_v3g.log 2>&1
