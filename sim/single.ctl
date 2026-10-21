* single.ctl -- ONE transient per ngspice run (d_cosim's Verilog state does not reset between tran runs)
.control
tran 0.1n 2.2u
meas tran b7 find v(c7) at=2.15u
meas tran b6 find v(c6) at=2.15u
meas tran b5 find v(c5) at=2.15u
meas tran b4 find v(c4) at=2.15u
meas tran b3 find v(c3) at=2.15u
meas tran b2 find v(c2) at=2.15u
meas tran b1 find v(c1) at=2.15u
meas tran b0 find v(c0) at=2.15u
let code = (b7 gt 0.9)*128 + (b6 gt 0.9)*64 + (b5 gt 0.9)*32 + (b4 gt 0.9)*16 + (b3 gt 0.9)*8 + (b2 gt 0.9)*4 + (b1 gt 0.9)*2 + (b0 gt 0.9)
echo code $&code
.endc
.end
