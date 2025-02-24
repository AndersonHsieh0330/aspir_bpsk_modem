`include "params.vh"
`default_nettype none
module bpsk_modulator_top (
    input  wire                        clk,
    input  wire                        rst,
    input  wire                        en,
    input  wire                        in,
    output wire [`FIXDT_64_A_WIDTH-1:0] out
);

    wire          [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] count;
    wire signed   [`FIXDT_64_A_WIDTH-1:0] wave_out;
    
    assign out = en ? (in ? wave_out : ~wave_out) : 0;

    counter counter_inst (
        .clk(clk),
        .rst(rst),
        .out(count)
    );

    cosine_lut #(
        .READ_PORTS(1)
    ) cosine_lut_inst (
        .in(count),
        .out(wave_out)
    );

endmodule
