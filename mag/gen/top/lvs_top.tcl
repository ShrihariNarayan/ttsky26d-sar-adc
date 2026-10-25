# lvs_top.tcl -- extract the tile with sar_logic as a LEF black box (sar_logic was LVS-checked by LibreLane)
lef read ../lef/sar_logic.lef
load tt_um_shriharinarayan_sar_adc
extract all
ext2spice lvs
ext2spice -o ../lvs/tt_um_lay.spice
puts EXTRACTED
quit -noprompt
