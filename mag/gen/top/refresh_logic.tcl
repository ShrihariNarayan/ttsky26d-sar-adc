# refresh_logic.tcl -- rebuild mag/sar_logic.mag from the re-hardened gds/sar_logic.gds (run from mag/)
gds readonly true
gds rescale false
gds read ../gds/sar_logic.gds
writeall force sar_logic
puts "sar_logic refreshed"
quit -noprompt
