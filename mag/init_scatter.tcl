# init_scatter.tcl -- L1 precheck-first pcell scatter (unwired).
# Creates the TT 1x2 analog top cell from the official DEF, draws met4 power
# stripes, drops one of every device type we use, writes .mag/.gds/.lef.
# Run from mag/:  magic -dnull -noconsole -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc init_scatter.tcl
set TOP tt_um_shriharinarayan_sar_adc

def read tt_analog_1x2.def
cellname rename tt_um_template $TOP
load $TOP
cellname delete ${TOP}_flat

# --- power stripes (met4, >=1.2um wide, bottom 10um -> top 10um) ---
proc stripe {name x} {
    box $x 5um $x 220.76um
    box width 2um
    paint met4
    label $name FreeSans 0.25u -met4
    port make
    port use [expr {$name eq "VGND" ? "ground" : "power"}]
    port class bidirectional
    port connections n s e w
}
stripe VDPWR 1um
stripe VGND  4um

# --- pcell scatter: one of each device type in the ADC ---
proc put {x y type inst args} {
    box ${x}um ${y}um ${x}um ${y}um
    magic::gencell sky130::$type $inst {*}$args
}
put  20  20 sky130_fd_pr__cap_mim_m3_1   c_unit  w 1.8 l 1.8
put  40  20 sky130_fd_pr__cap_mim_m3_1   c_cm    w 22 l 22
put  90  20 sky130_fd_pr__res_xhigh_po_1p41 r_vcm l 36   ;# 0p35 fails urpm width (rpm.1 >= 1.27um)
put  20  80 sky130_fd_pr__nfet_01v8      n_dec   w 10 l 5 nf 24
put  20 130 sky130_fd_pr__pfet_01v8_lvt  p_lvt   w 4 l 0.35 nf 8
put  60 130 sky130_fd_pr__pfet_01v8      p_in    w 2 l 0.5 nf 4
put 100 130 sky130_fd_pr__nfet_01v8      n_sw    w 2 l 0.6
put 100 170 sky130_fd_pr__nfet_01v8      n_min   w 1 l 0.15

# DRC on a flattened copy -- same view the TT precheck has (counts errors inside pcells too)
flatten ${TOP}_flat
load ${TOP}_flat
select top cell
drc check
drc catchup
puts "DRC_COUNT [drc list count total]"
foreach {rule boxes} [drc listall why] {puts "DRC_RULE [llength $boxes] x $rule"}
load $TOP
cellname delete ${TOP}_flat

writeall force   ;# saves the top cell AND the generated device subcells
file mkdir ../gds ../lef
gds write ../gds/$TOP.gds
lef write ../lef/$TOP.lef -hide -pinonly
puts "DONE"
quit -noprompt
