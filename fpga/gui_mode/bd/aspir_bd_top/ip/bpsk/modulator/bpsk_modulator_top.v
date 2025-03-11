`include "params.vh"
module bpsk_modulator_top #(
    parameter DATA_WIDTH = `FIXDT_64_A_WIDTH,
    parameter DATA_FRAC_WIDTH = `FIXDT_64_A_FRAC_WIDTH
) (
    input  wire                  clk,
    input  wire                  rst_n,
    input  wire                  en,
    input  wire                  in,
    output wire [DATA_WIDTH-1:0] out,

    // cosine lu
    output wire        [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] cosine_lu,
    input  wire signed [DATA_WIDTH-1:0]                          carrier
);

    assign out = en ? (in ? carrier : ~carrier) : 0;

    counter counter_inst (
        .clk(clk),
        .rst_n(rst_n),
        .out(cosine_lu)
    );

endmodule
