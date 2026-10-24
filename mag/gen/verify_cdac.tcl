load cdac
flatten cdac_flat
load cdac_flat
select top cell
drc check
drc catchup
puts "DRC_COUNT [drc list count total]"
foreach {rule boxes} [drc listall why] {puts "DRC_RULE [llength $boxes] x $rule"}
load cdac
cellname delete cdac_flat
extract do local
extract all
ext2spice lvs
ext2spice -o cdac_lay.spice
