* debug2.ctl -- read vtop/vcm just BEFORE each comparator rising edge (DAC settled,
* comparator in reset, no kickback), and the comparator result 40 ns after the edge.
.control
alter vinx dc = 0.1
tran 0.1n 2.2u
meas tran s1 find v(xcore.vtop) at=1.145u
meas tran s2 find v(xcore.vtop) at=1.195u
echo sampling: vtop at 1.145u $&s1  at 1.195u $&s2
let k = 0
while k < 9
  let tpre = 1.245e-6 + k*1e-7
  let tpost = 1.29e-6 + k*1e-7
  meas tran vt find v(xcore.vtop) at=$&tpre
  meas tran vc find v(xcore.vcm) at=$&tpre
  meas tran cp find v(comp) at=$&tpost
  let dmv = (vt - vc)*1000
  echo step $&k vtop $&vt vcm $&vc diff_mV $&dmv comp $&cp
  let k = k + 1
end
.endc
.end
