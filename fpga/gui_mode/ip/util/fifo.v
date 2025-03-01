/* 
 * every clock cycle shift the last index out and 
 * and put the new data into first index, like a fifo
 */
`include "params.vh"
`default_nettype none
module fifo #(
    parameter FIFO_SIZE = 1,
    parameter DATA_WIDTH = 8
) (
    input  wire                         clk,
    input  wire                         rst_n,
    input  wire signed [DATA_WIDTH-1:0] data_in,
    output reg  signed [DATA_WIDTH*FIFO_SIZE-1:0] fifo_out
);

integer i;
always @(posedge clk) begin
    if (~rst_n) begin
        for (i = 0 ; i < FIFO_SIZE ; i = i + 1) begin
            fifo_out <= {DATA_WIDTH*FIFO_SIZE{1'b0}};
        end
    end else begin
        for (i = 0 ; i < FIFO_SIZE ; i = i + 1) begin
            fifo_out[(i*DATA_WIDTH)+:DATA_WIDTH] <= i == 0 ? data_in : fifo_out[((i-1)*DATA_WIDTH)+:DATA_WIDTH];
        end
    end
end

endmodule