`timescale 1ns/1ps
`include "params.vh"
`default_nettype none
module bpsk_modulation_test ();

reg clk;
reg rst_n;
reg in;
wire [`FIXDT_64_A_WIDTH-1:0] out;
wire [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] mod_cosine_lu;
wire [`FIXDT_64_A_WIDTH-1:0] mod_carrier;

localparam clkperiod = 5; // 200 Mhz clk = 5ns clock period

always #(clkperiod/2) clk = ~clk;

initial begin
    clk <= 1'b0;
    rst_n <= 1'b0;
    in <= 1'b0;
    #15;
    rst_n <= 1'b1;
    for (integer i = 0 ; i < 10 ; i = i + 1) begin
        // toggle 5 times
        #100;
        in <= ~in;
    end
    $finish;
end

cosine_lut #(
    .READ_PORTS(1)
) cosine_lut_inst (
    .clk(clk),
    .rst_n(rst_n),
    .in(mod_cosine_lu),
    .out(mod_carrier)
);

bpsk_modulator_top modulator_inst (
    .clk(clk),
    .rst_n(rst_n),
    .en(1'b1),
    .in(in),
    .out(out),
    .cosine_lu(mod_cosine_lu),
    .carrier(mod_carrier)
);

endmodule
