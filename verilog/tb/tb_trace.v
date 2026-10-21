`timescale 1ns/1ps
module tb_trace;
    reg clk=0, rst_n=0, comp=0; wire phi, done; wire [7:0] dn, code;
    sar_logic dut(.clk(clk),.rst_n(rst_n),.comp(comp),.phi(phi),.dn(dn),.code(code),.done(done));
    always #50 clk=~clk;
    real vin=0.600, vh=0.600, vtop;
    always @(*) vtop=(phi?vin:vh)+1.0*($itor({24'd0,~dn})-128.0)/256.0;
    always @(negedge phi) vh=vin;
    always @(posedge clk) comp <= (vtop > 0.5);
    integer n=0;
    always @(negedge clk) if (rst_n) begin
        #1 $display("t=%5.0f ns  phi=%b  dn=%b  vtop=%0.4f V  comp(last)=%b  done=%b  code=%0d", $realtime, phi, dn, vtop, comp, done, code);
        n=n+1; if (n==12) $finish;
    end
    initial #120 rst_n=1;
endmodule
