load comparator
flatten comparator_flat
load comparator_flat
select top cell
drc check
drc catchup
puts "DRC_COUNT [drc list count total]"
foreach {rule boxes} [drc listall why] {puts "DRC_RULE [llength $boxes] x $rule"}
load comparator
cellname delete comparator_flat
extract do local
extract all
ext2spice lvs
ext2spice -o comparator_lay.spice
