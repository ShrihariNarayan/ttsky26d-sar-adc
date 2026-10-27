# gds_drc_ext.tcl -- sign-off on the SUBMITTED GDS (run from mag/gen/signoff/work):
#   full LVS extraction (all standard cells included) + flattened DRC
gds read ../../../../gds/tt_um_shriharinarayan_sar_adc.gds
load tt_um_shriharinarayan_sar_adc
select top cell
extract do local
extract all
ext2spice lvs
ext2spice -o lay_gds.spice
puts "EXTRACTED"
flatten tflat
load tflat
select top cell
drc euclidean on
drc style drc(full)
drc check
drc catchup
puts "GDS_DRC_COUNT [drc list count total]"
foreach {rule boxes} [drc listall why] {puts "DRC_RULE [llength $boxes] x $rule"}
quit -noprompt
