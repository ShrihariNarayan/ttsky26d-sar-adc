# vcm_gen_build.tcl -- scripted layout of vcm_gen (R1,R2 res_xhigh_po_1p41 L=36 + Ccm 2x MiM 22x22).
# Run in Magic from mag/:  source gen/vcm_gen_build.tcl
load vcm_gen
box -100um -100um 200um 200um
select area; delete; erase *
proc stack {x y from to} {
    # via stack centred at (x,y) from metal 'from' (1..3) up to metal 'to' (2..4); metals expanded 0.08 um
    set v {0 via1 via2 via3}
    for {set m $from} {$m < $to} {incr m} {
        box [expr {$x-0.2}]um [expr {$y-0.2}]um [expr {$x+0.2}]um [expr {$y+0.2}]um
        paint [lindex $v $m]
        box [expr {$x-0.28}]um [expr {$y-0.28}]um [expr {$x+0.28}]um [expr {$y+0.28}]um
        paint metal$m; paint metal[expr {$m+1}]
    }
}
proc rect {l x1 y1 x2 y2} { box ${x1}um ${y1}um ${x2}um ${y2}um; paint $l }
# resistors: identical orientation, SEPARATE guard rings (pitch 4.0 um; abutted rings made the urpm
# regions merge over the shared tap column -> precheck MR_licon.CON.xx); centres y = 23.6
box 0um 2.955um 0um 2.955um
magic::gencell sky130::sky130_fd_pr__res_xhigh_po_1p41 R1 l 36
box 4.0um 2.955um 4.0um 2.955um
magic::gencell sky130::sky130_fd_pr__res_xhigh_po_1p41 R2 l 36
# caps: one 2x1 array (ny=2), tops tied (C1 = vcm), bottoms tied (C2 = VSS); centre (20.08, 23.2)
box 8um 0um 8um 0um
magic::gencell sky130::sky130_fd_pr__cap_mim_m3_1 Ccm w 22 l 22 ny 2
select cell Ccm
move n 24.4um
select clear
# Cap centre now (20.08, 23.6): top-plate met4 (C1) x 8.4..30.0, lower cap y 1.2..22.8; bottom-plate strip (C2, met4) x 31.64..32.16, stub tops y 47.6
# R pads (met1): R1 top x 0.615..1.925 y 41.545..43.65 (Vref), bottoms y 3.55..5.655 (vcm); R2 top x 4.615..5.925 (VSS)
# --- vcm: strap both bottom pads, stack to met4, run into the lower cap's top plate ---
rect metal1 0.615 3.55 5.925 5.655
stack 2.54 4.6 1 4
rect metal4 2.26 4.3 9.0 4.9
# --- Vref: R1 top pad -> met2 pin ---
stack 1.27 42.6 1 2
# --- VSS: R2 top pad + guard ring (mcon) -> met4 over the top -> caps' bottom-plate strip ---
rect metal1 4.615 41.545 5.925 44.5
rect metal1 1.1 44.12 5.925 44.5

box 5.185um 44.16um 5.355um 44.33um
paint mcon
box 1.185um 44.16um 1.355um 44.33um
paint mcon
stack 5.27 43.0 1 4
rect metal4 4.99 42.72 5.55 48.8
rect metal4 4.99 48.2 32.16 48.8
rect metal4 31.64 47.4 32.16 48.8
# --- ports ---
box 2.4um 4.5um 2.5um 4.6um;    label vcm c metal1;  port make
box 1.22um 42.55um 1.32um 42.65um; label Vref c metal2; port make
box 20um 48.45um 20.1um 48.55um; label VSS c metal4;  port make

save vcm_gen
puts VCMBUILT
