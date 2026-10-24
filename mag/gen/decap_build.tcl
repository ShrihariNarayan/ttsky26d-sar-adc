# decap_build.tcl -- Vref decap: schematic MCdec nfet W=240 L=5 nf=24 = 3 x (W=80, nf=8, finger W=10) in parallel.
# Gate = Vref (top pads, joined by m1 bands + right m1 spine); D/S/body = VSS (m2 bars + left m2 spine).
load decap
box -100um -100um 200um 200um
select area; delete; erase *
proc rect {l x1 y1 x2 y2} { box ${x1}um ${y1}um ${x2}um ${y2}um; paint $l }
proc v1 {x y} {
    rect via1 [expr {$x-.13}] [expr {$y-.13}] [expr {$x+.13}] [expr {$y+.13}]
    rect metal1 [expr {$x-.13}] [expr {$y-.16}] [expr {$x+.13}] [expr {$y+.16}]
    rect metal2 [expr {$x-.13}] [expr {$y-.16}] [expr {$x+.13}] [expr {$y+.16}]
}
set H 11.57
for {set k 0} {$k < 3} {incr k} {
    set y0 [expr {$k*$H}]
    box 0um ${y0}um 0um ${y0}um
    magic::gencell sky130::sky130_fd_pr__nfet_01v8 MC$k w 10 l 5 nf 8 guard 1
    set cy [expr {$y0 + 5.785}]
    # VSS: via on all 9 strips + ring (left side), m2 bar
    for {set s 0} {$s < 9} {incr s} { v1 [expr {21.73 - 21.16 + 5.29*$s}] $cy }
    rect mcon -0.085 [expr {$cy-.085}] 0.085 [expr {$cy+.085}]
    rect metal1 -0.17 [expr {$cy-.19}] 0.17 [expr {$cy+.19}]
    v1 0 $cy
    rect metal2 -0.77 [expr {$cy-.2}] 43.0 [expr {$cy+.2}]
    # Vref: m1 band over the 8 top gate pads, out to the right spine
    rect metal1 0.73 [expr {$cy+5.16}] 44.08 [expr {$cy+5.39}]
}
rect metal1 43.68 [expr {5.785+5.16}] 44.08 [expr {2*$H+5.785+5.39}]
rect metal2 -0.77 5.585 -0.37 [expr {2*$H+5.985}]
box 43.83um 20um 43.93um 20.1um;  label Vref c metal1; port make
box -0.62um 12um -0.52um 12.1um; label VSS c metal2;  port make
