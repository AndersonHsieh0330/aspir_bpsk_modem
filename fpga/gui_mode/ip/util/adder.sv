// this adder explicitly detects and signals over/under flow
`default_nettype none
`include "params.svh"
module adder (
    parameter DATA_WIDTH = `FIXDT_64_A_WIDTH,
    parameter DATA_FRAC_WIDTH = `FIXDT_64_A_FRAC_WIDTH
) (
    input  wire signed [DATA_WIDTH-1:0] in_a,
    input  wire signed [DATA_WIDTH-1:0] in_b,
    output reg  signed [DATA_WIDTH-1:0] out,
    output reg                          overflow,
    output reg                          underflow
);

localparam signed MAX = {1'b0, {(DATA_WIDTH-1){1'b1}}};
localparam signed MIN = {1'b1, {(DATA_WIDTH-1){1'b0}}};

wire [DATA_WIDTH-1:0] out_temp;
assign out_temp = in_a + in_b;

always_comb begin
    overflow = 1'b0;
    underflow = 1'b0;
    if (~(in_a[DATA_WIDTH-1] & in_b[DATA_WIDTH-1]) & out_temp[DATA_WIDTH-1]) begin
        // overflow
        overflow = 1'b1;
        out = MAX;
    end else if (in_a[DATA_WIDTH-1] & in_b[DATA_WIDTH-1] & ~out_temp[DATA_WIDTH-1]) begin
        // underflow
        underflow = 1'b1;
        out = MIN;
    end else begin
        out = out_temp;
    end
end

endmodule