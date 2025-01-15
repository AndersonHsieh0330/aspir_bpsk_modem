/* 
 * every clock cycle shift the last index out and 
 * and put the new data into first index, like a fifo
 */
`include "params.svh"
`default_nettype none
module fifo #(
    parameter FIFO_SIZE = 1,
    parameter DATA_WIDTH = 8
) (
    input  wire                         clk,
    input  wire                         rst,
    input  wire signed [DATA_WIDTH-1:0] data_in,
    output reg  signed [DATA_WIDTH-1:0] fifo_out [0:FIFO_SIZE-1]
);

integer i;
always @ (posedge clk) begin
    if (rst) begin
        for (i = 0 ; i < FIFO_SIZE ; i = i + 1) begin
            fifo_out[i] <= {$clog2(DATA_WIDTH){1'b0}};
        end
    end else begin
        for (i = 0 ; i < FIFO_SIZE ; i = i + 1) begin
            fifo_out[i] <= i == 0 ? data_in : fifo_out[i-1];
        end
    end
end

endmodule