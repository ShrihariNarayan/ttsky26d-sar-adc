# decap2_build.tcl -- extra Vref decap (10 rows x nfet W=60 nf=6 L=5, finger W=10) with 3 x 30x30 MiM caps
# (vcm to VSS) stacked on top. Gate = Vref (m1 bands -> right m1 spine -> m2 tabs); D/S/body = VSS (m2 bars,
# left m2 spine); MiM bottom plates (m3) = VSS via via2 on the plate margins; MiM top plates (m4) = vcm.
load decap2
box -100um -100um 300um 300um
select area; delete; erase *
proc rect {l x1 y1 x2 y2} { box ${x1}um ${y1}um ${x2}um ${y2}um; paint $l }
proc v1 {x y} {
    rect via1 [expr {$x-.13}] [expr {$y-.13}] [expr {$x+.13}] [expr {$y+.13}]
    rect metal1 [expr {$x-.13}] [expr {$y-.16}] [expr {$x+.13}] [expr {$y+.16}]
    rect metal2 [expr {$x-.13}] [expr {$y-.16}] [expr {$x+.13}] [expr {$y+.16}]
}
set H 11.57; set NR 10; set XR 33.36
for {set k 0} {$k < $NR} {incr k} {
    set y0 [expr {$k*$H}]
    box 0um ${y0}um 0um ${y0}um
    magic::gencell sky130::sky130_fd_pr__nfet_01v8 MD$k w 10 l 5 nf 6 guard 1
    set cy [expr {$y0 + 5.785}]
    for {set s 0} {$s < 7} {incr s} { v1 [expr {0.57 + 5.29*$s}] $cy }
    rect mcon -0.085 [expr {$cy-.085}] 0.085 [expr {$cy+.085}]
    rect metal1 -0.17 [expr {$cy-.19}] 0.17 [expr {$cy+.19}]
    v1 0 $cy
    rect metal2 -0.77 [expr {$cy-.2}] 32.68 [expr {$cy+.2}]
    rect metal1 0.73 [expr {$cy+5.16}] [expr {$XR+0.4}] [expr {$cy+5.39}]
    # Vref m2 tab on the spine of every row (router access)
    v1 [expr {$XR+0.2}] [expr {$cy+5.275}]
    rect metal2 [expr {$XR+0.07}] [expr {$cy+5.115}] [expr {$XR+0.9}] [expr {$cy+5.435}]
}
rect metal1 $XR [expr {5.785+5.16}] [expr {$XR+0.4}] [expr {($NR-1)*$H+5.785+5.39}]
rect metal2 -0.77 5.585 -0.37 [expr {($NR-1)*$H+5.985}]
# MiM caps 30x30 (vcm top / VSS bottom), centred at x=16.9
set k 0
foreach yc {18.5 57.85 97.2} {
    box 0um 0um 0um 0um
    magic::gencell sky130::sky130_fd_pr__cap_mim_m3_1 CV$k w 30 l 30
    select cell CV$k
    set b [box values]
    set cx [expr {([lindex $b 0]+[lindex $b 2])/400.0}]; set cyy [expr {([lindex $b 1]+[lindex $b 3])/400.0}]
    move by [expr {16.9-$cx}]um [expr {$yc-$cyy}]um
    select clear
    incr k
}
# join the three top plates (vcm, m4 over the mimcap contact) and the three bottom-plate m4 strips (right edge)
rect metal4 7.6 18.5 8.4 97.2
rect metal4 31.66 3.36 32.06 112.34
box 8.0um 57.85um 8.0um 57.85um; label vcm c metal4; port make
box 31.86um 57.85um 31.86um 57.85um; label VSSB c metal4; port make
box [expr {$XR+0.6}]um [expr {5.785+5.275}]um [expr {$XR+0.6}]um [expr {5.785+5.275}]um; label Vref c metal2; port make
box -0.57um 12um -0.57um 12um; label VSS c metal2; port make
puts "CAPS PLACED"
save decap2
foreach c [cellname list children decap2] { if {![file exists $c.mag]} { load $c; save $c } }
load decap2
quit -noprompt
