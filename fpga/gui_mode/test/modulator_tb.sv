`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2024 05:41:47 PM
// Design Name: 
// Module Name: modulator_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module modulator_tb();

    reg clk;
    reg rst;
    reg en;
    reg [11:0] out;
    reg in;

    //change to 5 for 200mhz
    localparam clkperiod = 5;

    always #(clkperiod/2) clk = ~clk;

    initial begin
        rst = 1;
        clk = 0;
        en = 1;
        in = 0;
        #5;
        rst = 0;
        #20;
        in = 1;
        #20;
        in = 0;
        #200;
        $finish;
    end

    modulator modulator_inst(.clk(clk),.rst(rst),.en(en),.in(in),.out(out));
endmodule
