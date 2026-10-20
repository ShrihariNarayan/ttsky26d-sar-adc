v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 -200 0 -180 {lab=VDD}
N 0 -150 80 -150 {lab=VDD}
N 80 -200 80 -150 {lab=VDD}
N 0 -220 0 -200 {lab=VDD}
N 0 -200 80 -200 {lab=VDD}
N -80 -150 -40 -150 {lab=ckb}
N -0 -120 0 -80 {lab=T}
N 160 -80 160 -40 {lab=T}
N 0 -80 160 -80 {lab=T}
N -160 -80 -160 -40 {lab=T}
N -160 -80 -0 -80 {lab=T}
N 200 -10 240 -10 {lab=inn}
N -240 -10 -200 -10 {lab=inp}
N -160 -10 -80 -10 {lab=T}
N -80 -60 -80 -10 {lab=T}
N -160 -60 -80 -60 {lab=T}
N 80 -10 160 -10 {lab=T}
N 80 -60 80 -10 {lab=T}
N 80 -60 160 -60 {lab=T}
N 160 20 160 100 {lab=Q}
N -160 20 -160 100 {lab=P}
N -240 130 -160 130 {lab=VDD}
N 160 130 240 130 {lab=VDD}
N -160 210 -80 210 {lab=X}
N -80 210 70 130 {lab=X}
N 70 130 120 130 {lab=X}
N 70 210 160 210 {lab=Y}
N -60 130 70 210 {lab=Y}
N -120 130 -60 130 {lab=Y}
N -160 160 -160 320 {lab=X}
N 160 160 160 320 {lab=Y}
N 60 350 120 350 {lab=X}
N -80 270 60 350 {lab=X}
N -160 270 -80 270 {lab=X}
N 70 270 160 270 {lab=Y}
N -60 350 70 270 {lab=Y}
N -120 350 -60 350 {lab=Y}
N -160 380 -160 420 {lab=VSS}
N -160 420 -0 420 {lab=VSS}
N -0 420 0 460 {lab=VSS}
N 160 380 160 420 {lab=VSS}
N -0 420 160 420 {lab=VSS}
N -520 380 -520 420 {lab=VSS}
N -520 420 -160 420 {lab=VSS}
N -340 380 -340 420 {lab=VSS}
N 160 420 520 420 {lab=VSS}
N 520 380 520 420 {lab=VSS}
N 340 380 340 420 {lab=VSS}
N -620 350 -520 350 {lab=VSS}
N -620 350 -620 420 {lab=VSS}
N -620 420 -520 420 {lab=VSS}
N -440 350 -340 350 {lab=VSS}
N -440 350 -440 420 {lab=VSS}
N 160 350 260 350 {lab=VSS}
N 260 350 260 420 {lab=VSS}
N 340 350 440 350 {lab=VSS}
N 440 350 440 420 {lab=VSS}
N 520 350 620 350 {lab=VSS}
N 620 350 620 420 {lab=VSS}
N 520 420 620 420 {lab=VSS}
N -260 350 -160 350 {lab=VSS}
N -260 350 -260 420 {lab=VSS}
N -520 70 -520 320 {lab=P}
N -520 70 -160 70 {lab=P}
N 160 70 520 70 {lab=Q}
N 520 70 520 320 {lab=Q}
N -340 270 -340 320 {lab=X}
N -340 270 -160 270 {lab=X}
N 340 270 340 320 {lab=Y}
N 160 270 340 270 {lab=Y}
N -840 320 -840 360 {lab=ckb}
N -840 420 -840 460 {lab=VSS}
N -930 390 -880 390 {lab=clk}
N -840 280 -840 320 {lab=ckb}
N -930 250 -880 250 {lab=clk}
N -840 180 -840 220 {lab=VDD}
N -840 250 -750 250 {lab=VDD}
N -750 190 -750 250 {lab=VDD}
N -840 190 -750 190 {lab=VDD}
N -930 250 -930 390 {lab=clk}
N -970 330 -930 330 {lab=clk}
N -840 330 -750 330 {lab=ckb}
N -840 390 -750 390 {lab=VSS}
N -750 390 -750 440 {lab=VSS}
N -840 440 -750 440 {lab=VSS}
C {sky130_fd_pr/pfet_01v8.sym} -20 -150 0 0 {name=M7
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
C {lab_wire.sym} 0 -220 0 0 {name=p3 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} -80 -150 0 0 {name=p1 sig_type=std_logic lab=ckb
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} -180 -10 0 0 {name=M1
W=8
L=0.5
nf=4
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 180 -10 0 1 {name=M2
W=8
L=0.5
nf=4
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {lab_wire.sym} -240 -10 0 0 {name=p2 sig_type=std_logic lab=inp
}
C {lab_wire.sym} 240 -10 0 1 {name=p4 sig_type=std_logic lab=inn
}
C {sky130_fd_pr/pfet_01v8.sym} -140 130 0 1 {name=M3
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
C {sky130_fd_pr/pfet_01v8.sym} 140 130 0 0 {name=M4
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
C {lab_wire.sym} -240 130 0 0 {name=p5 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} 240 130 0 1 {name=p6 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} 0 -80 0 0 {name=p7 sig_type=std_logic lab=T
}
C {lab_wire.sym} -160 70 0 0 {name=p8 sig_type=std_logic lab=P
}
C {lab_wire.sym} 160 70 0 0 {name=p9 sig_type=std_logic lab=Q
}
C {sky130_fd_pr/nfet_01v8.sym} 140 350 0 0 {name=M6
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
C {sky130_fd_pr/nfet_01v8.sym} -140 350 0 1 {name=M5
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
C {lab_wire.sym} -160 210 0 0 {name=p10 sig_type=std_logic lab=X
}
C {lab_wire.sym} 160 210 0 0 {name=p11 sig_type=std_logic lab=Y
}
C {lab_wire.sym} -160 270 0 0 {name=p12 sig_type=std_logic lab=X
}
C {lab_wire.sym} 160 270 0 0 {name=p13 sig_type=std_logic lab=Y
}
C {lab_wire.sym} 0 460 2 1 {name=p14 sig_type=std_logic lab=VSS
}
C {sky130_fd_pr/nfet_01v8.sym} 320 350 0 0 {name=S4
W=0.5
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
C {sky130_fd_pr/nfet_01v8.sym} 500 350 0 0 {name=S2
W=0.5
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
C {sky130_fd_pr/nfet_01v8.sym} -320 350 0 1 {name=S3
W=0.5
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
C {sky130_fd_pr/nfet_01v8.sym} -500 350 0 1 {name=S1
W=0.5
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
C {lab_wire.sym} -480 350 0 1 {name=p15 sig_type=std_logic lab=ckb
}
C {lab_wire.sym} -300 350 0 1 {name=p16 sig_type=std_logic lab=ckb
}
C {lab_wire.sym} 300 350 0 0 {name=p17 sig_type=std_logic lab=ckb
}
C {lab_wire.sym} 480 350 0 0 {name=p18 sig_type=std_logic lab=ckb
}
C {sky130_fd_pr/nfet_01v8.sym} -860 390 0 0 {name=MIN
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
C {sky130_fd_pr/pfet_01v8.sym} -860 250 0 0 {name=MIP
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
C {lab_wire.sym} -840 460 2 0 {name=p28 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} -970 330 0 0 {name=p30 sig_type=std_logic lab=clk}
C {lab_wire.sym} -840 180 0 0 {name=p32 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} -750 330 2 0 {name=p27 sig_type=std_logic lab=ckb
}
C {ipin.sym} -850 -160 0 0 {name=p19 lab=inp}
C {ipin.sym} -850 -130 0 0 {name=p20 lab=inn}
C {ipin.sym} -850 -100 0 0 {name=p21 lab=clk}
C {opin.sym} -850 -40 0 0 {name=p22 lab=X}
C {opin.sym} -850 -10 0 0 {name=p23 lab=Y}
C {iopin.sym} -690 -130 0 0 {name=p24 lab=VDD}
C {iopin.sym} -690 -40 0 0 {name=p25 lab=VSS}
