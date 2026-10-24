# comparator_place.tcl -- L3: device placement for cell "comparator" (StrongARM + SR latch).
# Every device is a sky130 pcell with EXACTLY the schematic W/L/nf (so LVS properties match)
# and its own guard ring (= body tap). Wiring is done by hand afterwards.
# Run inside Magic (GUI) from mag/:   source comparator_place.tcl
#
# Stack (PMOS-input StrongARM, VDD on top):     row3  M7 tail (ckb)              VDD nwell
#                                                row2  M1 | M2  input pair          nwell = T (own island!)
#                                                row1  M3 | M4  cross-coupled PMOS  VDD nwell
#                                                row0  S1 S3 M5 | M6 S4 S2         NMOS
# Left column: clock inverter MIP/MIN.  Right: SR latch (inverters MI1/MI2 + NAND pair A/B).
load comparator
select top cell
box -50um -50um 200um 200um
catch {select area; delete}
# Real pcell sizes (from FIXED_BBOX, um): M1/M2 4.30x3.66 | pfet w2 1.58x3.66 | pfet w1 1.58x2.66
# M7 1.58x5.66 | nfet w1 1.58x2.57 | nfet w2 1.58x3.57 | S (L=0.6) 2.03x3.57.  (x,y) = lower-left.
# Rows: NMOS y=0 | VDD-PMOS y=5.6 | T-nwell pair y=11.26 | M7 y=16.92 (2 um between different nwells).
# Core mirror axis x = 9.39. Same-net PMOS pcells ABUT so their nwells merge (nwell.2a needs 1.27 um otherwise).
proc fet {type inst w l nf x y} {
    box ${x}um ${y}um ${x}um ${y}um
    magic::gencell sky130::sky130_fd_pr__$type $inst w [expr {double($w)/$nf}] l $l nf $nf guard 1
}
# clock inverter (left column)
fet nfet_01v8 MIN 1 0.15 1 0    0
fet pfet_01v8 MIP 2 0.15 1 0    5.6
# row 0: S1 S3 M5 | M6 S4 S2
fet nfet_01v8 S1  2 0.6  1 2.5  0
fet nfet_01v8 S3  2 0.6  1 5.03 0
fet nfet_01v8 M5  1 0.15 1 7.56 0
fet nfet_01v8 M6  1 0.15 1 9.64 0
fet nfet_01v8 S4  2 0.6  1 11.72 0
fet nfet_01v8 S2  2 0.6  1 14.25 0
# row 1: M3 | M4 (cross-coupled PMOS, VDD nwell)
fet pfet_01v8 M3  2 0.15 1 7.81 5.6
fet pfet_01v8 M4  2 0.15 1 9.39 5.6
# row 2: input pair M1 | M2 (nwell = T)
fet pfet_01v8 M1  8 0.5  4 5.09 11.26
fet pfet_01v8 M2  8 0.5  4 9.39 11.26
# row 3: tail M7
fet pfet_01v8 M7  4 0.15 1 8.6 16.92
# SR latch, right of the core: NMOS row 0, PMOS row 1, pitch 1.58 (abutted -> nwells merge)
set x 17.8
foreach {n p} {MI2N MI2P MA3 MA1 MA4 MA2 MB4 MB2 MB3 MB1 MI1N MI1P} {
    if {[string match MI* $n]} {set wn 1; set wp 2} else {set wn 2; set wp 1}
    fet nfet_01v8 $n $wn 0.15 1 $x 0
    fet pfet_01v8 $p $wp 0.15 1 $x 5.6
    set x [expr {$x + 1.58}]
}
select clear
# DRC on a flattened copy (pcell-internal errors included)
flatten comparator_flat
load comparator_flat
select top cell
drc check
drc catchup
puts "DRC_COUNT [drc list count total]"
foreach {rule boxes} [drc listall why] {puts "DRC_RULE [llength $boxes] x $rule"}
load comparator
cellname delete comparator_flat
writeall force   ;# top cell + generated pcell subcells
puts "PLACED 25 devices in cell comparator"
