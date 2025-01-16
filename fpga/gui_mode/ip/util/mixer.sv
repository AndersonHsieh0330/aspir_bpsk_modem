/*
*   multiply 2 X-bit numbers, get a X-bit number back
*   includes rounding to the correct fractional bit
*   and over/underflow detection
*/
`default_nettype none
`include "params.svh"
module mixer #(
    parameter DATA_WIDTH = `FIXDT_32_WIDTH,
    parameter DATA_FRAC_WIDTH = `FIXDT_32_FRAC_WIDTH
) (
    input  wire signed [DATA_WIDTH-1:0] in_a,
    input  wire signed [DATA_WIDTH-1:0] in_b,
    output reg  signed [DATA_WIDTH-1:0] out,
    output reg                          overflow,
    output reg                          underflow
);

wire signed [2*DATA_WIDTH-1:0] double_width_product; // this number will have 2*DATA_FRAC_WIDTH fractional bits
localparam signed ROUND_FACTOR = 2 ^ (DATA_FRAC_WIDTH - 1);
localparam signed POST_SHIFT_MAX = {1'b0, {(DATA_WIDTH-1){1'b1}}};
localparam signed POST_SHIFT_MIN = {1'b1, {(DATA_WIDTH-1){1'b0}}};
localparam signed POST_SHIFT_MAX_DOUBLE_WIDTH = {{(DATA_WIDTH+1){1'b0}}, {(DATA_WIDTH-1){1'b1}}};
localparam signed POST_SHIFT_MIN_DOUBLE_WIDTH = {{(DATA_WIDTH+1){1'b1}}, {(DATA_WIDTH-1){1'b0}}};
localparam signed MAX_DOUBLE_WIDTH = {1'b1, {(2*DATA_WIDTH-1){1'b0}}}; // true max of double width product
localparam signed MIN_DOUBLE_WIDTH = {1'b0, {(2*DATA_WIDTH-1){1'b1}}}; // true min of double width product
localparam signed PRE_SHIFT_MIN = MIN_DOUBLE_WIDTH + ROUND_FACTOR;
localparam signed PRE_SHIFT_MAX = MAX_DOUBLE_WIDTH - ROUND_FACTOR;

(* use_dsp = "yes" *) assign double_width_product = in_a * in_b;

always_comb begin
        bit signed [63:0] rounded_value, rounded_value_shifted; 
        overflow = 1'b0;
        underflow = 1'b0;

        // add rounding factor and check over/underflow
        // rounding factor is 2^(52-23-1) = 268435456
        if (double_width_product > PRE_SHIFT_MAX) begin
            rounded_value = {1'b0, {(2*DATA_WIDTH-1){1'b1}}}; // Clamp to max
            overflow = 1'b1;
        end else if (double_width_product < PRE_SHIFT_MIN) begin
            rounded_value = {1'b1, {(2*DATA_WIDTH-1){1'b0}}}; // Clamp to min
            underflow = 1'b1;
        end else begin
            rounded_value = double_width_product + ROUND_FACTOR; // Add rounding factor
        end

        // reduce fractional bits, sign extend
        rounded_value_shifted = rounded_value >>> DATA_FRAC_WIDTH;

        // clamp to DATA_WIDTH-bit range
        if (rounded_value_shifted > POST_SHIFT_MAX_DOUBLE_WIDTH) begin
            out = POST_SHIFT_MAX; // Clamp to max
            overflow = 1'b1;
        end else if (rounded_value_shifted < POST_SHIFT_MIN_DOUBLE_WIDTH) begin
            out  = POST_SHIFT_MIN; // Clamp to min
            underflow = 1'b1;
        end else begin
            out = rounded_value_shifted[DATA_WIDTH-1:0]; 
        end
end
endmodule