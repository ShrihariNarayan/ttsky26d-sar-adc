#!/bin/bash
# signoff.sh -- run from mag/gen/signoff/ in the foss container (after sak-pdk sky130A):
#   1) DRC on the flattened GDS  2) antenna  3) full-chip transistor-level LVS from the GDS
#   (SAR logic compared against verilog/gl/sar_logic.v via the sky130_fd_sc_hd SPICE models)
#   4) licon/urpm GDS checks
set -e
export PDK_ROOT=${PDK_ROOT:-/foss/pdks} PDK=sky130A
RC=$PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc
LIB=$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
mkdir -p work && cd work
magic -dnull -noconsole -rcfile $RC ../gds_drc_ext.tcl > drc_ext.log 2>&1; grep -E "GDS_DRC_COUNT|DRC_RULE" drc_ext.log
magic -dnull -noconsole -rcfile $RC ../gds_ant.tcl > ant.log 2>&1; echo "antenna errors: $(grep -ci 'antenna error\|antenna violation' ant.log)"; grep ANT_DONE ant.log
# schematic = std-cell library (+ the ef decap_12 physical cell) + GL logic in the black-box pin order + analog top
cp $LIB lib.spice
printf '\n.subckt sky130_ef_sc_hd__decap_12 VGND VNB VPB VPWR\nX0 VPWR VGND VPWR VPB sky130_fd_pr__pfet_01v8_hvt w=0.87 l=4.73\nX1 VGND VPWR VGND VNB sky130_fd_pr__nfet_01v8 w=0.55 l=4.73\n.ends\n' >> lib.spice
ORDER="VGND VPWR clk code[0] code[1] code[2] code[3] code[4] code[5] code[6] code[7] comp dn[0] dn[1] dn[2] dn[3] dn[4] dn[5] dn[6] dn[7] done phi rst_n"
python3 ../gl2spice.py ../../../../verilog/gl/sar_logic.v lib.spice "$ORDER" sar_logic_gl.spice
python3 - << 'PY'
s=open('../../../../lvs/sch_top.spice').read()
i=s.index('.subckt sar_logic '); j=s.index('.ends',i)+5
open('sch_full.spice','w').write(open('lib.spice').read()+'\n'+s[:i]+open('sar_logic_gl.spice').read()+s[j:])
PY
netgen -batch lvs "lay_gds.spice tt_um_shriharinarayan_sar_adc" "sch_full.spice tt_um_shriharinarayan_sar_adc" $PDK_ROOT/sky130A/libs.tech/netgen/sky130A_setup.tcl lvs_gds.out > netgen.log 2>&1
grep "Final result" lvs_gds.out
python3 ../../top/gdschk.py ../../../../gds/tt_um_shriharinarayan_sar_adc.gds
