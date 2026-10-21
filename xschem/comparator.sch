v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -450 -30 -410 -30 {lab=inp}
N -450 -10 -410 -10 {lab=inn}
N -450 10 -410 10 {lab=clk}
N -110 -30 -70 -30 {lab=VDD}
N -110 -10 -70 -10 {lab=VSS}
N -110 10 -70 10 {lab=X}
N -110 30 -70 30 {lab=Y}
N 280 -340 280 -300 {lab=Yb}
N 280 -240 280 -200 {lab=VSS}
N 190 -270 240 -270 {lab=Y}
N 280 -380 280 -340 {lab=Yb}
N 190 -410 240 -410 {lab=Y}
N 280 -480 280 -440 {lab=VDD}
N 280 -410 370 -410 {lab=VDD}
N 370 -470 370 -410 {lab=VDD}
N 280 -470 370 -470 {lab=VDD}
N 190 -410 190 -270 {lab=Y}
N 150 -330 190 -330 {lab=Y}
N 280 -330 370 -330 {lab=Yb}
N 280 -270 370 -270 {lab=VSS}
N 370 -270 370 -220 {lab=VSS}
N 280 -220 370 -220 {lab=VSS}
N 280 300 280 340 {lab=Xb}
N 280 400 280 440 {lab=VSS}
N 190 370 240 370 {lab=X}
N 280 260 280 300 {lab=Xb}
N 190 230 240 230 {lab=X}
N 280 160 280 200 {lab=VDD}
N 280 230 370 230 {lab=VDD}
N 370 170 370 230 {lab=VDD}
N 280 170 370 170 {lab=VDD}
N 190 230 190 370 {lab=X}
N 150 310 190 310 {lab=X}
N 280 310 370 310 {lab=Xb}
N 280 370 370 370 {lab=VSS}
N 370 370 370 420 {lab=VSS}
N 280 420 370 420 {lab=VSS}
N 900 -450 940 -450 {lab=outn}
N 580 -450 620 -450 {lab=Yb}
N 660 -520 660 -480 {lab=VDD}
N 660 -520 760 -520 {lab=VDD}
N 760 -560 760 -520 {lab=VDD}
N 760 -520 860 -520 {lab=VDD}
N 860 -520 860 -480 {lab=VDD}
N 660 -420 660 -380 {lab=outp}
N 660 -380 860 -380 {lab=outp}
N 860 -420 860 -380 {lab=outp}
N 860 -380 1000 -380 {lab=outp}
N 760 -380 760 -300 {lab=outp}
N 680 -270 720 -270 {lab=Yb}
N 760 -240 760 -160 {lab=na}
N 680 -130 720 -130 {lab=outn}
N 760 -100 760 -60 {lab=VSS}
N 660 -450 740 -450 {lab=VDD}
N 740 -500 740 -450 {lab=VDD}
N 660 -500 740 -500 {lab=VDD}
N 780 -450 860 -450 {lab=VDD}
N 780 -500 780 -450 {lab=VDD}
N 780 -500 860 -500 {lab=VDD}
N 760 -130 840 -130 {lab=VSS}
N 840 -130 840 -80 {lab=VSS}
N 760 -80 840 -80 {lab=VSS}
N 760 -270 840 -270 {lab=VSS}
N 900 170 940 170 {lab=outp}
N 580 170 620 170 {lab=Xb}
N 660 100 660 140 {lab=VDD}
N 660 100 760 100 {lab=VDD}
N 760 60 760 100 {lab=VDD}
N 760 100 860 100 {lab=VDD}
N 860 100 860 140 {lab=VDD}
N 660 200 660 240 {lab=outn}
N 660 240 860 240 {lab=outn}
N 860 200 860 240 {lab=outn}
N 860 240 1000 240 {lab=outn}
N 760 240 760 320 {lab=outn}
N 680 350 720 350 {lab=Xb}
N 760 380 760 460 {lab=nb}
N 680 490 720 490 {lab=outp}
N 760 520 760 560 {lab=VSS}
N 660 170 740 170 {lab=VDD}
N 740 120 740 170 {lab=VDD}
N 660 120 740 120 {lab=VDD}
N 780 170 860 170 {lab=VDD}
N 780 120 780 170 {lab=VDD}
N 780 120 860 120 {lab=VDD}
N 760 490 840 490 {lab=VSS}
N 840 490 840 540 {lab=VSS}
N 760 540 840 540 {lab=VSS}
N 760 350 840 350 {lab=VSS}
C {comparator_sa.sym} -260 0 0 0 {name=x1}
C {lab_wire.sym} -450 -30 0 0 {name=p3 sig_type=std_logic lab=inp}
C {lab_wire.sym} -450 -10 0 0 {name=p8 sig_type=std_logic lab=inn
}
C {lab_wire.sym} -450 10 0 0 {name=p4 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -70 -30 2 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -70 -10 2 0 {name=p6 sig_type=std_logic lab=VSS}
C {lab_wire.sym} -70 10 2 0 {name=p7 sig_type=std_logic lab=X
}
C {lab_wire.sym} -70 30 2 0 {name=p9 sig_type=std_logic lab=Y}
C {sky130_fd_pr/nfet_01v8.sym} 260 -270 0 0 {name=MI1N
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
C {sky130_fd_pr/pfet_01v8.sym} 260 -410 0 0 {name=MI1P
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
C {lab_wire.sym} 280 -200 2 0 {name=p28 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} 150 -330 0 0 {name=p30 sig_type=std_logic lab=Y}
C {lab_wire.sym} 280 -480 0 0 {name=p32 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} 370 -330 2 0 {name=p27 sig_type=std_logic lab=Yb
}
C {sky130_fd_pr/nfet_01v8.sym} 260 370 0 0 {name=MI2N
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
C {sky130_fd_pr/pfet_01v8.sym} 260 230 0 0 {name=MI2P
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
C {lab_wire.sym} 280 440 2 0 {name=p1 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} 150 310 0 0 {name=p2 sig_type=std_logic lab=X}
C {lab_wire.sym} 280 160 0 0 {name=p10 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} 370 310 2 0 {name=p11 sig_type=std_logic lab=Xb
}
C {sky130_fd_pr/pfet_01v8.sym} 640 -450 0 0 {name=MA1
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
C {sky130_fd_pr/pfet_01v8.sym} 880 -450 0 1 {name=MA2
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
C {lab_wire.sym} 760 -560 0 0 {name=p12 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} 580 -450 0 0 {name=p13 sig_type=std_logic lab=Yb
}
C {lab_wire.sym} 940 -450 0 1 {name=p14 sig_type=std_logic lab=outn
}
C {sky130_fd_pr/nfet_01v8.sym} 740 -270 0 0 {name=MA3
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
C {lab_wire.sym} 680 -270 0 0 {name=p15 sig_type=std_logic lab=Yb
}
C {sky130_fd_pr/nfet_01v8.sym} 740 -130 0 0 {name=MA4
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
C {lab_wire.sym} 680 -130 0 0 {name=p16 sig_type=std_logic lab=outn
}
C {lab_wire.sym} 760 -60 2 0 {name=p17 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} 1000 -380 2 0 {name=p18 sig_type=std_logic lab=outp
}
C {lab_wire.sym} 760 -190 0 1 {name=p19 sig_type=std_logic lab=na
}
C {lab_wire.sym} 840 -270 2 0 {name=p20 sig_type=std_logic lab=VSS
}
C {sky130_fd_pr/pfet_01v8.sym} 640 170 0 0 {name=MB1
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
C {sky130_fd_pr/pfet_01v8.sym} 880 170 0 1 {name=MB2
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
C {lab_wire.sym} 760 60 0 0 {name=p21 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} 580 170 0 0 {name=p22 sig_type=std_logic lab=Xb
}
C {lab_wire.sym} 940 170 0 1 {name=p23 sig_type=std_logic lab=outp
}
C {sky130_fd_pr/nfet_01v8.sym} 740 350 0 0 {name=MB3
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
C {lab_wire.sym} 680 350 0 0 {name=p24 sig_type=std_logic lab=Xb
}
C {sky130_fd_pr/nfet_01v8.sym} 740 490 0 0 {name=MB4
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
C {lab_wire.sym} 680 490 0 0 {name=p25 sig_type=std_logic lab=outp
}
C {lab_wire.sym} 760 560 2 0 {name=p26 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} 1000 240 2 0 {name=p29 sig_type=std_logic lab=outn
}
C {lab_wire.sym} 760 430 0 1 {name=p31 sig_type=std_logic lab=nb
}
C {lab_wire.sym} 840 350 2 0 {name=p33 sig_type=std_logic lab=VSS
}
C {ipin.sym} -360 -430 0 0 {name=p34 lab=inp}
C {ipin.sym} -360 -400 0 0 {name=p35 lab=inn}
C {ipin.sym} -360 -370 0 0 {name=p36 lab=clk}
C {opin.sym} -360 -310 0 0 {name=p37 lab=outp}
C {opin.sym} -360 -280 0 0 {name=p38 lab=outn}
C {iopin.sym} -200 -400 0 0 {name=p39 lab=VDD}
C {iopin.sym} -200 -310 0 0 {name=p40 lab=VSS}
