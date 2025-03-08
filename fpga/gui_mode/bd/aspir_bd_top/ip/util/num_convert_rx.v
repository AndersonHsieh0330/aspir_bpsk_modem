`include "params.vh"
module num_convert_rx (
    input  wire signed [`ADC_BITS-1:0] data_in,
    output wire signed [`FIXDT_64_A_WIDTH-1:0] data_out
);

parameter signed STEP = 64'h0000000100100100;

assign data_out = STEP * data_in;


endmodule