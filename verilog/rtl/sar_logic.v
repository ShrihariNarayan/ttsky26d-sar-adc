// sar_logic.v -- control logic for the 8-bit top-plate-sampling SAR ADC
// (tt_um_shriharinarayan_sar_adc, TTSKY26d)
//
// Conversion = 10 clocks: 1 sample + 8 bit decisions + 1 output/done.
// Timing: the comparator evaluates on the clk RISING edge (its SR latch then
// holds the result); this logic acts on the clk FALLING edge, so comp is stable.
//
// CDAC convention (cdac.sch): dn[i] is ACTIVE-LOW. dn[i]=0 -> bottom plate of
// group i at Vref; dn[i]=1 -> at GND. During sampling the DAC sits at
// half-scale: MSB group at Vref, others at GND -> dn = 8'b0111_1111.
// For each decided bit, cap_i = ~b_i, so dn[i] = b_i: the dn register IS the code.
//
// Comparator wiring at top level: inp = vtop, inn = Vcm, so
// comp (= outp) = 1  <=>  vtop > Vcm  <=>  Vin above the trial level  <=>  bit = 1.
`default_nettype none

module sar_logic (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       comp,   // comparator output (outp): 1 = bit is 1
    output reg        phi,    // 1 = sampling (bootstrapped switch closed)
    output reg  [7:0] dn,     // active-low CDAC bottom-plate controls
    output reg  [7:0] code,   // result of the last completed conversion
    output reg        done    // high for the one clock after a conversion completes
);
    localparam [1:0] S_SAMPLE = 2'd0,
                     S_CONV   = 2'd1,
                     S_DONE   = 2'd2;

    reg [1:0] state;
    reg [7:0] sel;   // one-hot: the bit being decided in the current cycle

    always @(negedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_SAMPLE;
            phi   <= 1'b1;
            dn    <= 8'b0111_1111;
            sel   <= 8'b0000_0000;
            code  <= 8'd0;
            done  <= 1'b0;
        end else begin
            case (state)
                // End of the sample cycle: open the switch. The DAC is already at
                // half-scale, so the first comparison (MSB) needs no switching.
                S_SAMPLE: begin
                    phi   <= 1'b0;
                    sel   <= 8'b1000_0000;
                    state <= S_CONV;
                end

                // End of a decision cycle: store this bit (dn[i] <- comp) and
                // put the next bit on trial (dn[i-1] <- 0, i.e. its cap to Vref).
                S_CONV: begin
                    dn  <= (dn & ~sel & ~(sel >> 1)) | ({8{comp}} & sel);
                    sel <= sel >> 1;
                    if (sel[0]) begin
                        code  <= (dn & ~sel) | ({8{comp}} & sel);
                        done  <= 1'b1;
                        state <= S_DONE;
                    end
                end

                // End of the output cycle: back to sampling, DAC to half-scale.
                S_DONE: begin
                    done  <= 1'b0;
                    phi   <= 1'b1;
                    dn    <= 8'b0111_1111;
                    state <= S_SAMPLE;
                end

                default: state <= S_SAMPLE;
            endcase
        end
    end
endmodule

`default_nettype wire
