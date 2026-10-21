v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 480 -620 1280 -220 {flags=graph
y1=0
y2=2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=1e-6
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
legendmag=1.0
node=vin
color=4
dataset=-1
unitx=1
logx=0
logy=0
}
N 50 -90 110 -90 {lab=dn5}
N 50 -70 110 -70 {lab=dn4}
N 410 -130 440 -130 {lab=VDD}
N 410 -110 440 -110 {lab=VSS}
N 50 -50 110 -50 {lab=dn3}
N 410 -70 440 -70 {lab=Vref}
N 410 -90 440 -90 {lab=vtop}
N 50 -130 110 -130 {lab=dn7}
N 50 -110 110 -110 {lab=dn6}
N 50 -30 110 -30 {lab=dn2}
N 50 -10 110 -10 {lab=dn1}
N 50 10 110 10 {lab=dn0}
C {devices/code.sym} -320 -340 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt
"
spice_ignore=false}
C {vsource.sym} -320 -490 0 0 {name=V1 value=1.8 savecurrent=false}
C {vsource.sym} -220 -490 0 0 {name=V2 value=0 savecurrent=false}
C {lab_wire.sym} -320 -520 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -220 -520 0 0 {name=p2 sig_type=std_logic lab=VSS
}
C {gnd.sym} -320 -460 0 0 {name=l1 lab=GND}
C {gnd.sym} -220 -460 0 0 {name=l2 lab=0}
C {simulator_commands_shown.sym} -430 80 0 0 {name=COMMANDS
simulator=ngspice
only_toplevel=false 
value="
* CDAC settling: vtop floats after 50 ns, then two worst-type transitions
.options savecurrents
vrx vrefx 0 dc 1.0
rpin vrefx Vref 500
vvt vt0 0 dc 0.5
vsw ctl 0 pwl 0 1.8 50n 1.8 51n 0
svt vt0 vtop ctl 0 swm
.model swm sw vt=0.9 vh=0.1 ron=10 roff=1e15
vd7 dn7 0 pwl 0 0 100n 0 100.2n 1.8 400n 1.8 400.2n 0
vd6 dn6 0 pwl 0 1.8 100n 1.8 100.2n 0
vd5 dn5 0 dc 1.8
vd4 dn4 0 dc 1.8
vd3 dn3 0 dc 1.8
vd2 dn2 0 dc 1.8
vd1 dn1 0 dc 1.8
vd0 dn0 0 dc 1.8
.control
tran 0.01n 700n
meas tran v0 find v(vtop) at=95n
meas tran va45 find v(vtop) at=145n
meas tran vaend find v(vtop) at=395n
meas tran vb45 find v(vtop) at=445n
meas tran vbend find v(vtop) at=695n
let stepa_mV = (vaend - v0)*1000
let erra_uV = (va45 - vaend)*1e6
let stepb_mV = (vbend - vaend)*1000
let errb_uV = (vb45 - vbend)*1e6
print stepa_mV erra_uV stepb_mV errb_uV
.endc
"}
C {devices/launcher.sym} -350 -160 0 0 {name=h17 
descr="Load waves" 
tclcommand="
xschem raw_read $netlist_dir/[file tail [file rootname [xschem get current_name]]].raw tran
"
}
C {lab_wire.sym} 50 -70 0 0 {name=p8 sig_type=std_logic lab=dn4
}
C {lab_wire.sym} 50 -90 0 0 {name=p3 sig_type=std_logic lab=dn5}
C {lab_wire.sym} 440 -130 2 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 440 -110 2 0 {name=p6 sig_type=std_logic lab=VSS}
C {cdac.sym} 260 -60 0 0 {name=x1}
C {lab_wire.sym} 50 -50 0 0 {name=p4 sig_type=std_logic lab=dn3}
C {lab_wire.sym} 440 -90 2 0 {name=p7 sig_type=std_logic lab=vtop
}
C {lab_wire.sym} 440 -70 2 0 {name=p9 sig_type=std_logic lab=Vref}
C {lab_wire.sym} 50 -130 0 0 {name=p10 sig_type=std_logic lab=dn7}
C {lab_wire.sym} 50 -110 0 0 {name=p11 sig_type=std_logic lab=dn6}
C {lab_wire.sym} 50 -30 0 0 {name=p12 sig_type=std_logic lab=dn2}
C {lab_wire.sym} 50 -10 0 0 {name=p13 sig_type=std_logic lab=dn1}
C {lab_wire.sym} 50 10 0 0 {name=p14 sig_type=std_logic lab=dn0}
