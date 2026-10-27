# gds_ant.tcl -- antenna check on the flattened SUBMITTED GDS (violations print as antenna errors)
gds read ../../../../gds/tt_um_shriharinarayan_sar_adc.gds
load tt_um_shriharinarayan_sar_adc
flatten tflat
load tflat
select top cell
extract do local
extract all
antennacheck
puts "ANT_DONE"
quit -noprompt
