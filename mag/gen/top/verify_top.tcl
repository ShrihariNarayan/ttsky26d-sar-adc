# verify_top.tcl -- flat DRC of the full tile (run from mag/)
load tt_um_shriharinarayan_sar_adc
flatten tflat
load tflat
select top cell
drc euclidean on
drc style drc(full)
drc check
drc catchup
puts "TOP_DRC_COUNT [drc list count total]"
foreach {rule boxes} [drc listall why] {puts "DRC_RULE [llength $boxes] x $rule"}
quit -noprompt
