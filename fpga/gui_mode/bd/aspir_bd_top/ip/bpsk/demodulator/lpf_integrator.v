/*
 * use integrator was a low pass filter
 */
`include "params.vh"
module lpf_integrator #(
    parameter ARRAY_SIZE = 5,
    parameter DATA_WIDTH = `FIXDT_64_A_WIDTH
) (
    input  wire signed [DATA_WIDTH*ARRAY_SIZE-1:0] input_array,
    output wire signed [DATA_WIDTH-1:0] out
);

wire signed [DATA_WIDTH-1:0] temp_out [0:ARRAY_SIZE-2];

for (genvar i = 0 ; i < ARRAY_SIZE-1 ; i = i + 1) begin
    // over/under flow not explicitly taken cared of here
    // since output of first stage mixer are between [-1, 1]
    // over/under flow will never happen
    if (i == 0) begin
        assign temp_out[i] = input_array[DATA_WIDTH-1:0] + input_array[(DATA_WIDTH*2)-1:DATA_WIDTH];
    end else begin
        assign temp_out[i] = temp_out[i-1] + input_array[(DATA_WIDTH*(i+2)-1):(DATA_WIDTH*(i+1))];
    end
end

assign out = temp_out[ARRAY_SIZE-2];

endmodule