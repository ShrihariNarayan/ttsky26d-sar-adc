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
 * comparator kickback test v2: steady state before hold, both polarities
.options savecurrents
vclk clk 0 pulse 0 1.8 50n 0.1n 0.1n 49.8n 100n
vcm cm 0 dc 0.6
vd d 0 dc 0.0004
esp sp cm d 0 0.5
esn sn cm d 0 -0.5
vsw ctl 0 pwl 0 1.8 340n 1.8 341n 0
swp sp inp ctl 0 swm
swn sn inn ctl 0 swm
.model swm sw vt=0.9 vh=0.1 ron=10 roff=1e15
chold inp 0 2p
cdac inn 0 2p
cx x 0 5f
cy y 0 5f
.control
foreach s 0.0004 -0.0004
 alter vd dc = $s
 foreach c 0 0.6 1.0 1.2
  alter vcm dc = $c
  tran 0.02n 1150n
  meas tran y11 when v(y)=0.9 rise=11
  meas tran x11 when v(x)=0.9 rise=11
  meas tran p0 find v(inp) at=345n
  meas tran pend find v(inp) at=1145n
  meas tran n0 find v(inn) at=345n
  meas tran nend find v(inn) at=1145n
  meas tran pmax max v(inp) from=350n to=360n
  meas tran pmin min v(inp) from=350n to=360n
  let res_uv = ((pend - nend) - (p0 - n0))*1e6
  let cmd_uv = (pend - p0)*1e6
  let cmn_uv = (nend - n0)*1e6
  let pkp_uv = (pmax - p0)*1e6
  let pkn_uv = (pmin - p0)*1e6
  print res_uv cmd_uv cmn_uv pkp_uv pkn_uv
 end
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
