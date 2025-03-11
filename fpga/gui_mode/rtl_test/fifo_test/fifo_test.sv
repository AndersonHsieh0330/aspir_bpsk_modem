`timescale 1ps/1ps
`include "params.vh"
`default_nettype none
module fifo_test ();

reg         clk, rst_n;
reg  [7:0]  data_incre;
reg  [8*4-1:0] fifo_out;

initial begin
    clk <= 1'b0;
    rst_n <= 1'b0;
    data_incre <= {8{1'b0}};
    #4;
    rst_n <= 1'b1;
    for (integer i = 0 ; i < 4 ; i = i + 1) begin
        data_incre = data_incre + 1; 
        #2;
    end
    $finish;
end

always begin
    #1 clk <= ~clk;
end
fifo #(
    .FIFO_SIZE(4),
    .DATA_WIDTH(8)
) fifo_inst (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_incre),
    .fifo_out(fifo_out)
);

endmodule