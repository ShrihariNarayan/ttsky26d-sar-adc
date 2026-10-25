#!/bin/bash
# run from mag/:  bash gen/top/verify_top.sh
set -e
magic -dnull -noconsole gen/top/verify_top.tcl 2>&1 | grep -E "TOP_DRC_COUNT|DRC_RULE"
magic -dnull -noconsole gen/top/lvs_top.tcl > /dev/null 2>&1
cd ../lvs
netgen -batch lvs "tt_um_lay.spice tt_um_shriharinarayan_sar_adc" "sch_top.spice tt_um_shriharinarayan_sar_adc" $PDK_ROOT/sky130A/libs.tech/netgen/sky130A_setup.tcl lvs_top.out > /dev/null 2>&1
grep "Final result" lvs_top.out
