#!/bin/bash
# inl_scan.sh CORE TAG VIN...  -- one ngspice run per Vin (d_cosim needs one transient per session).
# Adds the 10 pF Vref decap. Prints "vin code" lines sorted by vin.
# Speed: tran max step STEP (default 1n; edges are still refined automatically),
#        1 thread per run, NP parallel runs (default = nproc).
core=$1; tag=$2; shift 2
STEP=${STEP:-1n}
DECAP=${DECAP:-10p}   # on-chip Vref decap; DECAP=0 removes it
NP=${NP:-$(nproc)}
CORNER=${CORNER:-tt}   # tt ss ff sf fs
TEMP=${TEMP:-27}
# pin order follows the given netlist (xschem may reorder pins on re-netlist)
grep -i "^\.subckt adc_core" $core | sed 's/^\.subckt adc_core/xcore/I; s/$/ adc_core/' > xcore_${tag}.inc
for v in "$@"; do
  sed -e "s#sky130.lib.spice tt\$#sky130.lib.spice $CORNER\n.temp $TEMP#" \
      -e "s#../xschem/simulation/adc_core.spice#$core#" \
      -e "s/^rref vrefx Vref 500/rref vrefx Vref 500\ncdec Vref 0 $DECAP/" \
      -e "s/^\.include xcore.inc/.include xcore_${tag}.inc/" \
      -e "s/^vinx vinx 0 dc 0.6/vinx vinx 0 dc $v/" base.cir > run_${tag}_$v.cir
  sed -e "s/^tran 0.1n 2.2u/set num_threads=1\ntran $STEP 2.2u/" single.ctl >> run_${tag}_$v.cir
done
printf '%s\n' "$@" | xargs -P $NP -I{} sh -c "echo {} \$(ngspice -b run_${tag}_{}.cir 2>&1 | grep '^code' | awk '{print \$2}')" | sort -g
rm -f run_${tag}_*.cir xcore_${tag}.inc
