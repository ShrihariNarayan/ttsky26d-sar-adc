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
N 50 -90 110 -90 {lab=inp}
N 50 -70 110 -70 {lab=inn}
N 410 -90 440 -90 {lab=VDD}
N 410 -70 440 -70 {lab=VSS}
N 410 -50 440 -50 {lab=X}
N 50 -50 110 -50 {lab=clk}
N 410 -30 440 -30 {lab=Y}
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
* comparator CM sweep
.options savecurrents
vclk clk 0 pulse 0 1.8 50n 0.1n 0.1n 49.8n 100n
vcm cm 0 dc 0.5
vd d 0 dc 0.0004
einp inp cm d 0 0.5
einn inn cm d 0 -0.5
cx x 0 5f
cy y 0 5f
.control
foreach c 0 0.3 0.6 0.9 1.0 1.1 1.2
 alter vcm dc = $c
 alter vd dc = 0.0004
 tran 0.01n 100n
 meas tran tdy trig v(clk) val=0.9 rise=1 targ v(y) val=0.9 rise=1
 meas tran xlo find v(x) at=99n
 alter vd dc = -0.0004
 tran 0.01n 100n
 meas tran tdx trig v(clk) val=0.9 rise=1 targ v(x) val=0.9 rise=1
 meas tran ylo find v(y) at=99n
end
.endc
"}
C {devices/launcher.sym} -350 -160 0 0 {name=h17 
descr="Load waves" 
tclcommand="
xschem raw_read $netlist_dir/[file tail [file rootname [xschem get current_name]]].raw tran
"
}
C {lab_wire.sym} 50 -70 0 0 {name=p8 sig_type=std_logic lab=inn
}
C {lab_wire.sym} 50 -90 0 0 {name=p3 sig_type=std_logic lab=inp}
C {lab_wire.sym} 440 -90 2 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 440 -70 2 0 {name=p6 sig_type=std_logic lab=VSS}
C {comparator_sa.sym} 260 -60 0 0 {name=x1}
C {lab_wire.sym} 50 -50 0 0 {name=p4 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 440 -50 2 0 {name=p7 sig_type=std_logic lab=X
}
C {lab_wire.sym} 440 -30 2 0 {name=p9 sig_type=std_logic lab=Y}
