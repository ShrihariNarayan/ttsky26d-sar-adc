#!/bin/bash
# fft_iso2.sh -- re-run of the isolation variants that were killed (out of memory) in fft_iso.sh.
# fft_test.sh now saves only the 9 vectors the analysis needs. Runs 3 in parallel.
cd "$(dirname "$0")"
export N=512 M=37
# stop the old ic run (if still alive) before restarting it
pkill -f "fft_iso.sh" 2>/dev/null; pkill -f "fft_test.sh adc_core_pex_v2_ic" 2>/dev/null; pkill -f "run_ic.cir" 2>/dev/null; sleep 2
bash fft_test.sh ../xschem/simulation/adc_core.spice sch > fft_iso_sch.log 2>&1 &
bash fft_test.sh adc_core_pex_v2_ic.spice ic          > fft_iso_ic.log 2>&1 &
RREF=1m bash fft_test.sh adc_core_pex_v2.spice vref   > fft_iso_vref.log 2>&1 &
wait
for v in sch ic vref vin; do echo "== $v: $(grep -h 'SNDR\|ENOB' fft_iso_$v.log | tr '\n' ' ')"; done > fft_iso_summary.txt
cat fft_iso_summary.txt
