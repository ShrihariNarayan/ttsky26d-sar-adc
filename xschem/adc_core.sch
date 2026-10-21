v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 340 -130 400 -130 {lab=dn5}
N 340 -110 400 -110 {lab=dn4}
N 700 -170 730 -170 {lab=VDD}
N 700 -150 730 -150 {lab=VSS}
N 340 -90 400 -90 {lab=dn3}
N 700 -110 730 -110 {lab=Vref}
N 700 -130 730 -130 {lab=vtop}
N 340 -170 400 -170 {lab=dn7}
N 340 -150 400 -150 {lab=dn6}
N 340 -70 400 -70 {lab=dn2}
N 340 -50 400 -50 {lab=dn1}
N 340 -30 400 -30 {lab=dn0}
N -210 130 -150 130 {lab=vtop}
N -210 150 -150 150 {lab=vcm}
N 150 130 180 130 {lab=VDD}
N 150 150 180 150 {lab=VSS}
N 150 170 180 170 {lab=comp}
N -210 170 -150 170 {lab=clk}
N 150 190 180 190 {lab=compn}
N 150 -10 180 -10 {lab=Vref}
N 150 10 180 10 {lab=vcm}
N 150 30 180 30 {lab=VSS}
N 150 -170 180 -170 {lab=VDD}
N 150 -150 180 -150 {lab=VSS}
N 150 -130 180 -130 {lab=vtop}
N -210 -170 -150 -170 {lab=phi}
N -210 -150 -150 -150 {lab=vin}
C {bootstrap_switch.sym} 0 -150 0 0 {name=x2}
C {vcm_gen.sym} 0 10 0 0 {name=x4}
C {lab_wire.sym} 340 -110 0 0 {name=p8 sig_type=std_logic lab=dn4
}
C {lab_wire.sym} 340 -130 0 0 {name=p3 sig_type=std_logic lab=dn5}
C {lab_wire.sym} 730 -170 2 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 730 -150 2 0 {name=p6 sig_type=std_logic lab=VSS}
C {cdac.sym} 550 -100 0 0 {name=x1}
C {lab_wire.sym} 340 -90 0 0 {name=p4 sig_type=std_logic lab=dn3}
C {lab_wire.sym} 730 -130 2 0 {name=p7 sig_type=std_logic lab=vtop
}
C {lab_wire.sym} 730 -110 2 0 {name=p9 sig_type=std_logic lab=Vref}
C {lab_wire.sym} 340 -170 0 0 {name=p10 sig_type=std_logic lab=dn7}
C {lab_wire.sym} 340 -150 0 0 {name=p11 sig_type=std_logic lab=dn6}
C {lab_wire.sym} 340 -70 0 0 {name=p12 sig_type=std_logic lab=dn2}
C {lab_wire.sym} 340 -50 0 0 {name=p13 sig_type=std_logic lab=dn1}
C {lab_wire.sym} 340 -30 0 0 {name=p14 sig_type=std_logic lab=dn0}
C {lab_wire.sym} -210 150 0 0 {name=p1 sig_type=std_logic lab=vcm
}
C {lab_wire.sym} -210 130 0 0 {name=p2 sig_type=std_logic lab=vtop}
C {lab_wire.sym} 180 130 2 0 {name=p15 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 180 150 2 0 {name=p16 sig_type=std_logic lab=VSS}
C {comparator.sym} 0 160 0 0 {name=x5}
C {lab_wire.sym} -210 170 0 0 {name=p17 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 180 170 2 0 {name=p18 sig_type=std_logic lab=comp
}
C {lab_wire.sym} 180 190 2 0 {name=p19 sig_type=std_logic lab=compn}
C {lab_wire.sym} 180 10 2 0 {name=p20 sig_type=std_logic lab=vcm
}
C {lab_wire.sym} 180 30 2 0 {name=p21 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 180 -10 2 0 {name=p22 sig_type=std_logic lab=Vref}
C {lab_wire.sym} 180 -130 2 0 {name=p23 sig_type=std_logic lab=vtop}
C {lab_wire.sym} 180 -170 2 0 {name=p24 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 180 -150 2 0 {name=p25 sig_type=std_logic lab=VSS}
C {lab_wire.sym} -210 -170 0 0 {name=p26 sig_type=std_logic lab=phi}
C {lab_wire.sym} -210 -150 0 0 {name=p27 sig_type=std_logic lab=vin}
C {ipin.sym} -170 -640 0 0 {name=p43 lab=dn7}
C {ipin.sym} -170 -600 0 0 {name=p44 lab=dn6}
C {ipin.sym} -170 -560 0 0 {name=p45 lab=dn5}
C {ipin.sym} -170 -520 0 0 {name=p46 lab=dn4}
C {ipin.sym} -170 -480 0 0 {name=p47 lab=dn3}
C {ipin.sym} -170 -440 0 0 {name=p48 lab=dn2}
C {ipin.sym} -170 -400 0 0 {name=p49 lab=dn1}
C {ipin.sym} -170 -360 0 0 {name=p50 lab=dn0}
C {iopin.sym} 140 -640 0 0 {name=p51 lab=VDD}
C {iopin.sym} 140 -550 0 0 {name=p52 lab=VSS}
C {iopin.sym} 140 -360 0 0 {name=p54 lab=Vref}
C {opin.sym} 460 -640 0 0 {name=p28 lab=comp}
C {ipin.sym} -170 -780 0 0 {name=p29 lab=phi}
C {ipin.sym} -170 -740 0 0 {name=p30 lab=clk}
C {ipin.sym} -170 -690 0 0 {name=p31 lab=vin}
