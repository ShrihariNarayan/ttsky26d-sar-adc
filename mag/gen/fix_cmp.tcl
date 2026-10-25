load comparator
proc refet {type inst w l nf x y extra} {
    select cell $inst; delete; select clear
    box ${x}um ${y}um ${x}um ${y}um
    eval magic::gencell sky130::sky130_fd_pr__$type $inst w [expr {double($w)/$nf}] l $l nf $nf guard 1 $extra
}
# SR-latch inverters abut NAND devices of a different height: drop the inverter's guard-ring
# contacts on the shared side so only one cell draws tap cuts there (precheck licon.2 / licon.1)
refet nfet_01v8 MI2N 1 0.15 1 17.8 0 {grc 0}
refet pfet_01v8 MI2P 2 0.15 1 17.8 5.6 {grc 0}
refet nfet_01v8 MI1N 1 0.15 1 25.7 0 {glc 0}
refet pfet_01v8 MI1P 2 0.15 1 25.7 5.6 {glc 0}
select clear
save comparator
# NOTE: also save the 4 new pcell variants one by one (cellname list children comparator); never "writeall":
# it re-wrote the shared pcells at half scale and broke them (poly.1a, licon.1, li.1 ...)
puts FIXED
quit -noprompt
