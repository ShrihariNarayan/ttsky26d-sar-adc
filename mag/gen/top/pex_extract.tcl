lef read ../lef/sar_logic.lef
load tt_um_shriharinarayan_sar_adc
extract do capacitance
extract do coupling
extract all
ext2spice hierarchy on
ext2spice scale off
ext2spice cthresh 0.01
ext2spice format ngspice
ext2spice -o ../sim/tt_um_pex.spice
puts PEXDONE
quit -noprompt
