`include "params.vh"
module demodulator_top_wrapper (
    // global reset on som, active low
    input  wire                            rst_n,

    // to or from adc
    input  wire                            dco,
    input  wire                            overrange,
    input  wire signed [(`ADC_BITS/2)-1:0] data_in, // 2s complement

    // to ps
    output wire data_out
);

assign data_out = rst_n;

endmodule