# place_logic.tcl -- L2 start: clear the L1 scatter, place the hardened sar_logic block
# at the top right of the tile (x 75..145, y 148..218 um), under uo_out[7:0] / rst_n / clk.
# Run inside Magic (GUI) from mag/:   source place_logic.tcl
load tt_um_shriharinarayan_sar_adc
foreach i {c_unit c_cm r_vcm n_dec p_lvt p_in n_sw n_min} { catch {select cell $i; delete} }
select clear
gds readonly true
gds rescale false
gds read ../gds/sar_logic.gds
writeall force sar_logic
load tt_um_shriharinarayan_sar_adc
box 75um 148um 75um 148um
getcell sar_logic
select clear
save tt_um_shriharinarayan_sar_adc
gds write ../gds/tt_um_shriharinarayan_sar_adc.gds
lef write ../lef/tt_um_shriharinarayan_sar_adc.lef -hide -pinonly
puts "PLACED"
