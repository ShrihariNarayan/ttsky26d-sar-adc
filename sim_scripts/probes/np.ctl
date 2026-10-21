.control
alter vd dc = 0
foreach c 0.5 0.6
 alter vcm dc = $c
 tran 0.005n 60n
 meas tran tp trig v(clk) val=0.9 rise=1 targ v(x1.p) val=0.5 rise=1
 meas tran vt find v(x1.t) when v(x1.p)=0.25 rise=1
end
.endc
.end
