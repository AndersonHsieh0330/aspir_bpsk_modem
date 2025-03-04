`include "params.vh"
module num_convert_tx (
    input  wire signed [`FIXDT_64_A_WIDTH-1:0] data_in,
    output wire signed [`DAC_BITS-1:0] data_out
);

parameter signed STEP = 64'h0000000100100100;

assign data_out = data_in / STEP;

endmodule