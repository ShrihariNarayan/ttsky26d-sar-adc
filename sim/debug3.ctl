* debug3.ctl -- inside the comparator at the suspicious decisions (Vin = 0.1 V, steps 3..7):
* vtop/vcm 1 ns after the rising edge, the StrongARM outputs X/Y at +2/+5 ns, comp at +20 ns.
.control
alter vinx dc = 0.1
tran 0.05n 2.2u
let k = 3
while k < 8
  let t1 = 1.251e-6 + k*1e-7
  let t2 = 1.252e-6 + k*1e-7
  let t5 = 1.255e-6 + k*1e-7
  let t20 = 1.27e-6 + k*1e-7
  meas tran vt1 find v(xcore.vtop) at=$&t1
  meas tran vc1 find v(xcore.vcm) at=$&t1
  meas tran x2 find v(xcore.x5.x) at=$&t2
  meas tran y2 find v(xcore.x5.y) at=$&t2
  meas tran x5 find v(xcore.x5.x) at=$&t5
  meas tran y5 find v(xcore.x5.y) at=$&t5
  meas tran o20 find v(comp) at=$&t20
  let d1 = (vt1 - vc1)*1000
  echo step $&k diff1ns_mV $&d1 X2ns $&x2 Y2ns $&y2 X5ns $&x5 Y5ns $&y5 comp20ns $&o20
  let k = k + 1
end
.endc
.end
