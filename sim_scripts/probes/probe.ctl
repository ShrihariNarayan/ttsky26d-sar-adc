.control
alter vcm dc = 0.6
alter vd dc = 0.02
tran 0.01n 100n
meas tran y51 find v(y) at=51n
meas tran y55 find v(y) at=55n
meas tran y70 find v(y) at=70n
meas tran y99 find v(y) at=99n
meas tran x70 find v(x) at=70n
meas tran t70 find v(x1.t) at=70n
meas tran ckb70 find v(x1.ckb) at=70n
meas tran clk70 find v(clk) at=70n
print y51 y55 y70 y99 x70 t70 ckb70 clk70
.endc
.end
