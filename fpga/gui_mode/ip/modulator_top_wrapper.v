`include "params.vh"
module modulator_top_wrapper (
    // global reset on som, active low
    input  wire                 rst_n,

    // from ps
    input  wire                 en,
    input  wire                 data_in,

    // to or from dac
    input  wire                 dco,     // input clock from dac that clocks out the data
    output wire [`DAC_BITS-1:0] data_out
);

assign data_out[0] = rst_n;
endmodule