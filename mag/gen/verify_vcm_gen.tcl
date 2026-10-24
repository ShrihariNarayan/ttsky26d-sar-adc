load vcm_gen
flatten vcm_gen_flat
load vcm_gen_flat
select top cell
drc check
drc catchup
puts "DRC_COUNT [drc list count total]"
foreach {rule boxes} [drc listall why] {puts "DRC_RULE [llength $boxes] x $rule"}
load vcm_gen
cellname delete vcm_gen_flat
extract do local
extract all
ext2spice lvs
ext2spice -o vcm_gen_lay.spice
