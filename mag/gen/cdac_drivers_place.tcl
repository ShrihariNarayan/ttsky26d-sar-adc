# place the 16 CDAC driver pcells above the array (PMOS LVT row abutted -> one Vref nwell; NMOS row below)
proc fet {type inst w l nf x y} {
    box ${x}um ${y}um ${x}um ${y}um
    magic::gencell sky130::sky130_fd_pr__$type $inst w [expr {double($w)/$nf}] l $l nf $nf guard 1
}
# 8 aligned driver columns: MP_i directly above MN_i, 2.1 um between columns (separate nwells, all on Vref)
foreach {k w nf hw xc} {7 32 8 3.13 17.13 6 16 4 1.85 24.21 5 8 2 1.21 29.37 4 4 1 .89 33.57 3 1 1 .89 37.45 2 1 1 .89 41.33 1 1 1 .89 45.21 0 1 1 .89 49.09} {
    fet pfet_01v8_lvt MP$k $w 0.35 $nf [expr {$xc-$hw}] 80.0 }
foreach {k w nf hw xc} {7 16 4 1.53 17.13 6 8 2 1.05 24.21 5 4 1 .79 29.37 4 2 1 .79 33.57 3 0.5 1 .79 37.45 2 0.5 1 .79 41.33 1 0.5 1 .79 45.21 0 0.5 1 .79 49.09} {
    fet nfet_01v8 MN$k $w 0.15 $nf [expr {$xc-$hw}] 72.5 }
