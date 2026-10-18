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
node="vin
vhold
phi"
color="4 19 5"
dataset=-1
unitx=1
logx=0
logy=0
}
N 50 -90 110 -90 {lab=phi}
N 50 -70 110 -70 {lab=vin}
N 410 -90 440 -90 {lab=VDD}
N 410 -70 440 -70 {lab=VSS}
N 410 -50 440 -50 {lab=vhold}
N 270 70 310 70 {lab=vin}
N 170 70 210 70 {lab=vsrc}
N 440 -50 570 -50 {lab=vhold}
N 570 -50 570 -20 {lab=vhold}
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
 * ngspice commands
 .options savecurrents
 vvin vsrc 0 dc 0.5
 vphi  phi   0 pulse 0   1.8 10n 0.2n 0.2n 100n 1u

 .control
foreach v 0 0.2 0.4 0.6 0.8 1.0 1.2
 alter vvin dc = $v
 tran 0.1n 1u
 meas tran vx_s find v(x1.x) at=90n
 meas tran vb_s find v(x1.b) at=90n
 meas tran hpre find v(vhold) at=105n
 meas tran hend find v(vhold) at=0.9u
 meas tran hmid find v(vhold) at=150n
 let droop_uv = (hend - hmid)*1e6
 meas tran vi find v(vin) at=0.9u
 let boost = vx_s - vb_s
 let pre_uv = (hpre - vi)*1e6
 let p_uv = (hend - vi)*1e6
 print vi pre_uv p_uv droop_uv
end
.endc
"}
C {devices/launcher.sym} -350 -160 0 0 {name=h17 
descr="Load waves" 
tclcommand="
xschem raw_read $netlist_dir/[file tail [file rootname [xschem get current_name]]].raw tran
"
}
C {sample_hold_bootstrap.sym} 260 -70 0 0 {name=x1}
C {res.sym} 240 70 3 0 {name=R1
value=500
footprint=1206
device=resistor
m=1}
C {capa.sym} 570 10 0 0 {name=C1
m=1
value=0.5p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 570 40 0 0 {name=l3 lab=GND}
C {lab_wire.sym} 50 -70 0 0 {name=p8 sig_type=std_logic lab=vin
}
C {lab_wire.sym} 50 -90 0 0 {name=p3 sig_type=std_logic lab=phi}
C {lab_wire.sym} 440 -90 2 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 440 -70 2 0 {name=p6 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 440 -50 2 0 {name=p7 sig_type=std_logic lab=vhold}
C {lab_wire.sym} 170 70 0 0 {name=p9 sig_type=std_logic lab=vsrc}
C {lab_wire.sym} 310 70 2 0 {name=p10 sig_type=std_logic lab=vin}
