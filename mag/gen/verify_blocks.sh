#!/bin/bash
# verify_blocks.sh -- run from mag/:  ./gen/verify_blocks.sh
# DRC (flattened, same as the TT precheck) + extraction + netgen LVS for each finished analog block.
# Schematic references: xschem LVS netlist adc_core.spice (contains comparator, vcm_gen, cdac subckts); decap from gen/decap.spice.
cd "$(dirname "$0")/.."
RC=$PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc
SETUP=$PDK_ROOT/sky130A/libs.tech/netgen/sky130A_setup.tcl
SCH=../xschem/simulation/adc_core.spice
for b in comparator vcm_gen cdac decap; do
  v=gen/verify_$b.tcl
  magic -dnull -noconsole -rcfile $RC <<EOT > verify_$b.log 2>&1
source $v
quit -noprompt
EOT
  d=$(grep -m1 DRC_COUNT verify_$b.log)
  ref=$SCH; [ $b = decap ] && ref=gen/decap.spice
  netgen -batch lvs "${b}_lay.spice $b" "$ref $b" $SETUP lvs_$b.out > /dev/null 2>&1
  echo "$b: $d | LVS: $(grep 'Final result' lvs_$b.out)"
done
