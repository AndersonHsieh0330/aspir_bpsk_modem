/*
 * use integrator was a low pass filter
 */
`include "params.svh"
`default_nettype none
module lpf_integrator #(
    parameter ARRAY_SIZE = `ADC_SAMPLING_FREQ / `CARRIER_FREQ
) (
    input  wire                                        clk,
    input  wire                                        rst,
    input  wire signed [`FIXED_PT_WIDTH+`ADC_BITS-1:0] input_array [0:ARRAY_SIZE-1],
    output reg  signed [`FIXED_PT_WIDTH+`ADC_BITS-1:0] out
);

wire signed [`FIXED_PT_WIDTH+`ADC_BITS-1:0] temp_out [0:ARRAY_SIZE-2];

for (genvar i = 0 ; i < ARRAY_SIZE-1 ; i = i + 1) begin
    if (i == 0) begin
        assign temp_out[i] = input_array[i] + input_array[i+1];
    end else begin
        assign temp_out[i] = temp_out[i-1] + input_array[i+1];
    end
end

always @ (posedge clk) begin
    if (rst) begin
        out <= {`FIXED_PT_WIDTH+`ADC_BITS{1'b0}};
    end else begin
        out <= temp_out[ARRAY_SIZE-2];
    end
end

endmodule