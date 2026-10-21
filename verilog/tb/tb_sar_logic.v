// tb_sar_logic.v -- behavioural test of sar_logic.v
// The CDAC + comparator are modelled ideally:
//   cap value  c = ~dn (as an 8-bit number)
//   vtop       = Vin_held + Vref*(c - 128)/256      (top-plate sampling, half-scale start)
//   comp       = (vtop > Vcm), Vcm = Vref/2, latched on the clk RISING edge
// Expected code = floor(Vin / LSB) for 0 <= Vin < Vref.
`timescale 1ns/1ps
module tb_sar_logic;
    reg        clk = 1'b0, rst_n = 1'b0;
    reg        comp = 1'b0;
    wire       phi, done;
    wire [7:0] dn, code;

    sar_logic dut (.clk(clk), .rst_n(rst_n), .comp(comp),
                   .phi(phi), .dn(dn), .code(code), .done(done));

    always #50 clk = ~clk;              // 10 MHz

    real vref = 1.0;
    real vin  = 0.0;
    real vin_held = 0.0;
    real vtop;
    always @(*) vtop = (phi ? vin : vin_held) + vref * ($itor({24'd0, ~dn}) - 128.0) / 256.0;
    always @(negedge phi) vin_held = vin;           // switch opens: top plate holds Vin
    always @(posedge clk) comp <= (vtop > vref/2.0); // comparator + SR latch

    integer k, expected, errors = 0, convs = 0;
    integer clocks = 0, last_clocks = 0, nperiod_err = 0, ndone = 0;
    real lsb;

    task convert_and_check(input real v, input integer exp_code);
        begin
            vin = v;
            @(posedge done);                     // wait for a conversion that sampled v
            // the conversion that just finished may have sampled the previous vin;
            // run one more so the result belongs to v
            @(posedge done);
            convs = convs + 1;
            if (code !== exp_code[7:0]) begin
                errors = errors + 1;
                $display("MISMATCH  vin=%0.6f  code=%0d  expected=%0d", v, code, exp_code);
            end
        end
    endtask

    initial begin
        lsb = vref / 256.0;
        $dumpfile("tb_sar_logic.vcd");
        $dumpvars(0, tb_sar_logic);
        #120 rst_n = 1'b1;

        // 1) worked example from the design doc: 0.600 V -> 153
        convert_and_check(0.600, 153);
        $display("Worked example: vin=0.600 V -> code %0d (expect 153)", code);

        // 2) every code: vin at the centre of each code bin
        for (k = 0; k < 256; k = k + 1)
            convert_and_check((k + 0.5) * lsb, k);

        // 3) edges: 0 V, just below full scale, above full scale (clips at 255)
        convert_and_check(0.0, 0);
        convert_and_check(vref - 0.1*lsb, 255);
        convert_and_check(1.1 * vref, 255);

        $display("Conversions checked: %0d   errors: %0d", convs, errors);
        $display("done pulses: %0d, intervals != 10 clocks: %0d", ndone, nperiod_err);
        if (errors == 0 && nperiod_err == 0) $display("PASS");
        else             $display("FAIL");
        $finish;
    end

    // timing check: count clocks between successive done pulses
    always @(negedge clk) clocks = clocks + 1;
    always @(posedge done) begin
        ndone = ndone + 1;
        if (ndone > 2 && (clocks - last_clocks) != 10) nperiod_err = nperiod_err + 1;
        last_clocks = clocks;
    end
endmodule
