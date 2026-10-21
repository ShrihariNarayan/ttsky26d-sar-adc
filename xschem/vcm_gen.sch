v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 -150 80 -150 {lab=VSS}
N 100 100 100 180 {lab=VSS}
N 20 70 80 70 {lab=VSS}
N 20 70 20 140 {lab=VSS}
N 20 140 100 140 {lab=VSS}
N 100 -120 100 40 {lab=vcm}
N 100 -260 100 -180 {lab=Vref}
N 100 -40 460 -40 {lab=vcm}
N 280 -40 280 40 {lab=vcm}
N 280 100 280 180 {lab=VSS}
C {sky130_fd_pr/res_xhigh_po_1p41.sym} 100 -150 0 0 {name=R1
L=36
model=res_xhigh_po_1p41
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_1p41.sym} 100 70 0 0 {name=R2
L=36
model=res_xhigh_po_1p41
spiceprefix=X
mult=1}
C {lab_wire.sym} 40 -150 0 0 {name=p36 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} 100 180 2 0 {name=p2 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} 460 -40 2 0 {name=p1 sig_type=std_logic lab=vcm
}
C {lab_wire.sym} 100 -260 0 0 {name=p3 sig_type=std_logic lab=Vref
}
C {sky130_fd_pr/cap_mim_m3_1.sym} 280 70 0 0 {name=Ccm model=cap_mim_m3_1 W=22 L=22 MF=2 spiceprefix=X}
C {lab_wire.sym} 280 180 2 0 {name=p4 sig_type=std_logic lab=VSS
}
C {iopin.sym} -310 -330 0 0 {name=p51 lab=Vref}
C {iopin.sym} -310 -240 0 0 {name=p52 lab=vcm}
C {iopin.sym} -310 -140 0 0 {name=p53 lab=VSS}
