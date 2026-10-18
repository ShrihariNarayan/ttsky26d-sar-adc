v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -1050 -380 -1050 -340 {lab=X}
N -890 -210 -890 -140 {lab=VSS}
N -1050 -300 -1050 -200 {lab=VSS}
N -1020 -300 -950 -300 {lab=vhold}
N -1130 -300 -1080 -300 {lab=vin}
N -1170 -500 -1130 -500 {lab=vin}
N -1130 -500 -1130 -320 {lab=vin}
N -1130 -320 -1130 -300 {lab=vin}
N -1220 -300 -1130 -300 {lab=vin}
N -950 -300 -800 -300 {lab=vhold}
N -890 -300 -890 -270 {lab=vhold}
N -1050 -600 -1050 -380 {lab=X}
N -1200 -580 -1200 -540 {lab=X}
N -1200 -580 -1050 -580 {lab=X}
N -1450 -500 -1330 -500 {lab=B}
N -1330 -510 -1330 -500 {lab=B}
N -1330 -500 -1230 -500 {lab=B}
N -1200 -500 -1200 -430 {lab=VSS}
N -1480 -500 -1480 -430 {lab=VSS}
N -1050 -810 -1050 -600 {lab=X}
N -1170 -810 -1050 -810 {lab=X}
N -1330 -810 -1230 -810 {lab=P}
N -1450 -810 -1330 -810 {lab=P}
N -1330 -620 -1330 -510 {lab=B}
N -1330 -810 -1330 -680 {lab=P}
N -1590 -810 -1510 -810 {lab=VDD}
N -1480 -940 -1480 -850 {lab=X}
N -1480 -940 -1050 -940 {lab=X}
N -1050 -940 -1050 -810 {lab=X}
N -1480 -810 -1480 -720 {lab=P}
N -1480 -720 -1330 -720 {lab=P}
N -1330 -720 -1200 -720 {lab=P}
N -1200 -810 -1200 -720 {lab=P}
N -1050 -810 -810 -810 {lab=X}
N -810 -810 -800 -810 {lab=X}
N -740 -810 -610 -810 {lab=#net1}
N -770 -890 -770 -850 {lab=VDD}
N -1200 -890 -1200 -850 {lab=N}
N -1480 -570 -1480 -540 {lab=phi_b}
N -1590 -500 -1510 -500 {lab=VSS}
N -580 -890 -580 -850 {lab=phi_b}
N -550 -810 -480 -810 {lab=VSS}
N -770 -720 -680 -720 {lab=VSS}
N -770 -810 -770 -720 {lab=VSS}
N -680 -720 -580 -720 {lab=VSS}
N -580 -810 -580 -720 {lab=VSS}
N -680 -510 -680 -470 {lab=N}
N -680 -410 -680 -370 {lab=B}
N -770 -440 -720 -440 {lab=phi}
N -680 -440 -600 -440 {lab=VSS}
N -680 -550 -680 -510 {lab=N}
N -770 -580 -720 -580 {lab=phi}
N -680 -650 -680 -610 {lab=VDD}
N -680 -580 -590 -580 {lab=VDD}
N -590 -640 -590 -580 {lab=VDD}
N -680 -640 -590 -640 {lab=VDD}
N -770 -580 -770 -440 {lab=phi}
N -810 -500 -770 -500 {lab=phi}
N -340 -510 -340 -470 {lab=phi_b}
N -340 -410 -340 -370 {lab=VSS}
N -430 -440 -380 -440 {lab=phi}
N -340 -440 -260 -440 {lab=VSS}
N -340 -550 -340 -510 {lab=phi_b}
N -430 -580 -380 -580 {lab=phi}
N -340 -650 -340 -610 {lab=VDD}
N -340 -580 -250 -580 {lab=VDD}
N -250 -640 -250 -580 {lab=VDD}
N -340 -640 -250 -640 {lab=VDD}
N -430 -580 -430 -440 {lab=phi}
N -470 -500 -430 -500 {lab=phi}
N -340 -500 -250 -500 {lab=phi_b}
N -680 -500 -590 -500 {lab=N}
C {sky130_fd_pr/pfet_01v8.sym} -1200 -830 3 1 {name=M8
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -1050 -320 3 1 {name=M11
W=1
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {iopin.sym} -1720 -570 0 0 {name=p1 lab=VDD}
C {iopin.sym} -1720 -480 0 0 {name=p2 lab=VSS}
C {lab_wire.sym} -890 -140 0 0 {name=p5 sig_type=std_logic lab=VSS
}
C {opin.sym} -1690 -270 0 0 {name=p7 lab=vhold}
C {ipin.sym} -1640 -710 0 0 {name=p13 lab=phi}
C {ipin.sym} -1640 -330 0 0 {name=p14 lab=vin}
C {lab_wire.sym} -1050 -200 2 0 {name=p17 sig_type=std_logic lab=VSS
}
C {sky130_fd_pr/cap_mim_m3_1.sym} -890 -240 0 0 {name=C1 model=cap_mim_m3_1 W=22 L=22 MF=2 spiceprefix=X}
C {lab_wire.sym} -800 -300 2 0 {name=p4 sig_type=std_logic lab=vhold


}
C {lab_wire.sym} -1220 -300 0 0 {name=p6 sig_type=std_logic lab=vin
}
C {sky130_fd_pr/cap_mim_m3_1.sym} -1330 -650 0 0 {name=C2 model=cap_mim_m3_1 W=11 L=11 MF=2 spiceprefix=X}
C {sky130_fd_pr/nfet_01v8.sym} -1200 -520 3 1 {name=M9
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -1480 -520 3 1 {name=M12
W=1
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -770 -830 3 1 {name=M14
W=4
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -1480 -430 2 0 {name=p9 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} -1200 -430 2 0 {name=p16 sig_type=std_logic lab=VSS
}
C {sky130_fd_pr/pfet_01v8.sym} -1480 -830 3 1 {name=M3
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -1590 -810 0 0 {name=p20 sig_type=std_logic lab=VDD
}
C {sky130_fd_pr/nfet_01v8.sym} -580 -830 3 1 {name=M10
W=1
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -770 -890 0 0 {name=p3 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} -1200 -890 0 0 {name=p8 sig_type=std_logic lab=N
}
C {lab_wire.sym} -1480 -570 0 0 {name=p10 sig_type=std_logic lab=phi_b
}
C {lab_wire.sym} -1590 -500 0 0 {name=p11 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} -580 -890 0 0 {name=p15 sig_type=std_logic lab=phi_b
}
C {lab_wire.sym} -480 -810 2 0 {name=p18 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} -680 -720 2 0 {name=p19 sig_type=std_logic lab=VSS
}
C {sky130_fd_pr/nfet_01v8.sym} -700 -440 0 0 {name=M15
W=1
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -1330 -810 0 0 {name=p12 sig_type=std_logic lab=P}
C {lab_wire.sym} -1050 -810 0 0 {name=p21 sig_type=std_logic lab=X}
C {lab_wire.sym} -1330 -500 2 0 {name=p22 sig_type=std_logic lab=B}
C {sky130_fd_pr/pfet_01v8.sym} -700 -580 0 0 {name=M16
W=1
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -590 -500 2 0 {name=p23 sig_type=std_logic lab=N
}
C {lab_wire.sym} -680 -370 2 0 {name=p24 sig_type=std_logic lab=B}
C {lab_wire.sym} -810 -500 0 0 {name=p25 sig_type=std_logic lab=phi}
C {lab_wire.sym} -600 -440 2 0 {name=p26 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} -680 -650 0 0 {name=p29 sig_type=std_logic lab=VDD
}
C {sky130_fd_pr/nfet_01v8.sym} -360 -440 0 0 {name=MIN
W=1
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -360 -580 0 0 {name=MIP
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -340 -370 2 0 {name=p28 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} -470 -500 0 0 {name=p30 sig_type=std_logic lab=phi}
C {lab_wire.sym} -260 -440 2 0 {name=p31 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} -340 -650 0 0 {name=p32 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} -250 -500 2 0 {name=p27 sig_type=std_logic lab=phi_b
}
