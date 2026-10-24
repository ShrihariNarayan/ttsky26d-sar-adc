load decap
flatten decap_flat
load decap_flat
select top cell
drc check
drc catchup
puts "DRC_COUNT [drc list count total]"
foreach {rule boxes} [drc listall why] {puts "DRC_RULE [llength $boxes] x $rule"}
load decap
cellname delete decap_flat
extract do local
extract all
ext2spice lvs
ext2spice -o decap_lay.spice
