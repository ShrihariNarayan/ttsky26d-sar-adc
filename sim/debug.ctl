* debug.ctl -- one conversion of Vin = 0.6 V, sampled late in each clock-high phase
* (comparator result settled, DAC still at the value it was compared against)
.control
alter vinx dc = 0.6
tran 0.1n 2.2u
foreach t 1.19u 1.29u 1.39u 1.49u 1.59u 1.69u 1.79u 1.89u 1.99u 2.09u
  meas tran vt find v(xcore.vtop) at=$t
  meas tran vc find v(xcore.vcm) at=$t
  meas tran cp find v(comp) at=$t
  meas tran ph find v(phi) at=$t
  meas tran d7 find v(dn7) at=$t
  meas tran d6 find v(dn6) at=$t
  meas tran d0 find v(dn0) at=$t
  echo t $t vtop $&vt vcm $&vc comp $&cp phi $&ph dn7 $&d7 dn6 $&d6 dn0 $&d0
end
.endc
.end
