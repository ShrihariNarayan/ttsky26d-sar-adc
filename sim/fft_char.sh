#!/bin/bash
# fft_char.sh CORE [TAG] -- fft_test.sh plus characterization knobs: AMP (V, 0.48), VREF (V, 1.0), VDD (V, 1.8), CLKNS (clock period ns, 100)
# (original header of fft_test.sh follows)
# fft_test.sh CORE [TAG] -- sine-wave dynamic test (point 5): 128 back-to-back conversions at 1 MS/s,
# coherent input fin = 13/128 * 1 MHz = 101.5625 kHz, 0.5 V +- 0.48 V (Vref = 1.0 V, ~ -0.36 dBFS),
# through the 500 ohm pad model. Writes fft_<TAG>.dat (time, done, c7..c0); then run fft_analyze.py.
# env: NOISE SEED (input-referred noise in series with the sine source, see nzgen.py)
# env: OPTS (extra .options line, e.g. '.options method=gear')  RREF / RIN (500: pad model; 1m = ideal source)  CORNER (tt) TEMP (27) STEP (1n) DECAP (1f: the decap is already in the layout netlist) N (128) M (13)
core=$1; tag=${2:-fft}
CORNER=${CORNER:-tt}; TEMP=${TEMP:-27}; STEP=${STEP:-1n}; DECAP=${DECAP:-1f}; N=${N:-128}; M=${M:-13}
AMP=${AMP:-0.48}; VREF=${VREF:-1.0}; VDD=${VDD:-1.8}; CLKNS=${CLKNS:-100}
FS=$(awk -v p=$CLKNS 'BEGIN{printf "%.6f", 1e9/(10*p)}')
FIN=$(awk -v n=$N -v m=$M -v fs=$FS 'BEGIN{printf "%.6f", m/n*fs}')
TSTOP=$(awk -v n=$N -v p=$CLKNS 'BEGIN{printf "%.3fu", (n+4)*10*p/1000}')
VCM=$(awk -v r=$VREF 'BEGIN{printf "%.4f", r/2}')
HALF=$(awk -v p=$CLKNS 'BEGIN{printf "%.3fn", p/2}'); HIGH=$(awk -v p=$CLKNS 'BEGIN{printf "%.3fn", p/2-0.2}')
grep -i "^\.subckt adc_core" $core | sed 's/^\.subckt adc_core/xcore/I; s/$/ adc_core/' > xcore_${tag}.inc
sed -e "s#sky130.lib.spice tt\$#sky130.lib.spice $CORNER\n.temp $TEMP#" \
    -e "s#../xschem/simulation/adc_core.spice#$core#" \
    -e "s/^rref vrefx Vref 500/rref vrefx Vref 500\ncdec Vref 0 $DECAP/" \
    -e "s/^\.include xcore.inc/.include xcore_${tag}.inc/" \
    -e "s/^vinx vinx 0 dc 0.6/vinx vinx 0 sin($VCM $AMP $FIN 0 0 0)/" -e "s/^vrefx vrefx 0 dc 1.0/vrefx vrefx 0 dc $VREF/" -e "s/^vvdd VDD 0 1.8/vvdd VDD 0 $VDD/" -e "s/^vrst rst_n 0 pwl 0 0 120n 0 120.1n 1.8/vrst rst_n 0 pwl 0 0 120n 0 120.1n $VDD/" -e "s/out_high=1.8/out_high=$VDD/" -e "s/^vclk clk 0 pulse 0 1.8 50n 0.1n 0.1n 49.8n 100n/vclk clk 0 pulse 0 $VDD $HALF 0.1n 0.1n $HIGH ${CLKNS}n/" \
    -e "s/^rref vrefx Vref 500/rref vrefx Vref ${RREF:-500}/" \
    -e "s/^rin vinx vin 500/rin vinx vin ${RIN:-500}/" base.cir > run_${tag}.cir
[ -n "$OPTS" ] && echo "$OPTS" >> run_${tag}.cir
# optional input-referred noise (NOISE = rms volts, e.g. 1m; SEED): a new Gaussian value per conversion,
# applied in series with the sine source; the sampled noise is exactly NOISE rms (see nzgen.py)
if [ -n "$NOISE" ]; then
  python3 nzgen.py $NOISE ${SEED:-1} $TSTOP > nz_${tag}.inc
  sed -i "s/^rin vinx vin /rin vinn vin /" run_${tag}.cir
  sed -i "/^rin vinn vin /i .include nz_${tag}.inc" run_${tag}.cir
fi
cat >> run_${tag}.cir <<EOC
.control
set num_threads=1
save v(done) v(c7) v(c6) v(c5) v(c4) v(c3) v(c2) v(c1) v(c0) i(vvdd) i(vrefx)
tran $STEP $TSTOP
set wr_singlescale
set wr_vecnames
meas tran ivdd avg i(vvdd) from=2u to=$TSTOP
meas tran iref avg i(vrefx) from=2u to=$TSTOP
echo POWER vdd_uA $&ivdd vref_uA $&iref
wrdata fft_${tag}.dat v(done) v(c7) v(c6) v(c5) v(c4) v(c3) v(c2) v(c1) v(c0)
.endc
.end
EOC
echo "$(date +%H:%M) fft $tag start: $CORNER ${TEMP}C fin=${FIN} Hz fs=${FS} N=$N tstop=$TSTOP AMP=$AMP VREF=$VREF VDD=$VDD CLK=${CLKNS}ns"
ngspice -b run_${tag}.cir > run_${tag}.log 2>&1
echo "$(date +%H:%M) fft $tag sim done"
grep "^POWER" run_${tag}.log | awk '{printf "analog supply current: VDD %.1f uA, Vref %.1f uA (sign: source convention)\n", $3*1e6, $5*1e6}'
python3 fft_analyze.py fft_${tag}.dat $N $M
rm -f xcore_${tag}.inc
