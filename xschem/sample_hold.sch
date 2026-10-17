v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -1060 -530 -1020 -530 {lab=phi_b}
N -1060 -360 -1020 -360 {lab=phi}
N -690 -360 -660 -360 {lab=phi_b}
N -700 -540 -660 -540 {lab=phi}
N -980 -500 -980 -390 {lab=vin}
N -1150 -450 -980 -450 {lab=vin}
N -620 -510 -620 -390 {lab=vhold}
N -980 -590 -980 -560 {lab=vhold}
N -980 -530 -890 -530 {lab=VDD}
N -980 -360 -880 -360 {lab=VSS}
N -980 -330 -980 -290 {lab=vhold}
N -980 -290 -800 -290 {lab=vhold}
N -800 -590 -800 -290 {lab=vhold}
N -980 -590 -800 -590 {lab=vhold}
N -800 -450 -620 -450 {lab=vhold}
N -620 -540 -540 -540 {lab=VDD}
N -620 -360 -540 -360 {lab=VSS}
N -620 -590 -620 -570 {lab=vhold}
N -620 -590 -460 -590 {lab=vhold}
N -460 -590 -460 -470 {lab=vhold}
N -620 -330 -620 -290 {lab=vhold}
N -620 -290 -460 -290 {lab=vhold}
N -460 -420 -460 -290 {lab=vhold}
N -460 -470 -460 -420 {lab=vhold}
N -460 -450 -440 -450 {lab=vhold}
N -360 -450 -360 -230 {lab=vhold}
N -460 -450 -360 -450 {lab=vhold}
N -360 -450 -320 -450 {lab=vhold}
N -360 -170 -360 -100 {lab=VSS}
C {sky130_fd_pr/pfet_01v8.sym} -1000 -530 0 0 {name=M2
W=8
L=0.15
nf=2
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
C {sky130_fd_pr/pfet_01v8.sym} -640 -540 0 0 {name=M4
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
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -1000 -360 0 0 {name=M1
W=4
L=0.15
nf=2
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
C {sky130_fd_pr/nfet_01v8.sym} -640 -360 0 0 {name=M3
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
C {iopin.sym} -1410 -550 0 0 {name=p1 lab=VDD}
C {iopin.sym} -1410 -460 0 0 {name=p2 lab=VSS}
C {lab_wire.sym} -890 -530 2 0 {name=p3 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -360 -100 0 0 {name=p5 sig_type=std_logic lab=VSS
}
C {opin.sym} -320 -450 0 0 {name=p7 lab=vhold}
C {lab_wire.sym} -1060 -530 0 0 {name=p8 sig_type=std_logic lab=phi_b}
C {lab_wire.sym} -1060 -360 0 0 {name=p9 sig_type=std_logic lab=phi}
C {lab_wire.sym} -700 -540 0 0 {name=p10 sig_type=std_logic lab=phi}
C {lab_wire.sym} -690 -360 0 0 {name=p11 sig_type=std_logic lab=phi_b}
C {ipin.sym} -1330 -640 0 0 {name=p12 lab=phi_b}
C {ipin.sym} -1330 -690 0 0 {name=p13 lab=phi}
C {ipin.sym} -1150 -450 0 0 {name=p14 lab=vin}
C {lab_wire.sym} -980 -590 0 0 {name=p15 sig_type=std_logic lab=vhold}
C {lab_wire.sym} -880 -360 2 0 {name=p17 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} -540 -540 2 0 {name=p18 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -540 -360 2 0 {name=p19 sig_type=std_logic lab=VSS
}
C {sky130_fd_pr/cap_mim_m3_1.sym} -360 -200 0 0 {name=C1 model=cap_mim_m3_1 W=22 L=22 MF=2 spiceprefix=X}
