// numerically controlled oscillator
`include "params.vh"
module nco (
    input  wire rst,
    input  wire clk,
    output wire i_out, // sine wave
    output wire q_out  // cosine wave
);

reg [$clog2(`SAMPLES_PER_PERIOD)-1:0] phase;



endmodule