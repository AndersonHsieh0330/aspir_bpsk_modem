`timescale 1ps/1ps
`include "params.vh"
`default_nettype none
module fifo_test ();

reg         clk, rst;
reg  [7:0]  data_incre;
reg  [17:0] fifo_out [0:3];

initial begin
    clk <= 1'b0;
    rst <= 1'b1;
    data_incre <= {18{1'b0}};
    #4;
    rst <= 1'b0;
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
    .DATA_WIDTH(18)
) fifo_inst (
    .clk(clk),
    .rst(rst),
    .data_in({data_incre,{10{1'b0}}}),
    .fifo_out(fifo_out)
);

endmodule