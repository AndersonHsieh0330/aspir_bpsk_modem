`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2024 12:01:48 AM
// Design Name: 
// Module Name: counter
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


module counter(clk,rst,out);

    input rst;
    input clk;
    output reg [8:0] out;

    always @ (posedge clk) begin
        if (rst)
            out <= 0;
        else begin
            if (out < 513)
                out <= out + 128;
            else
                out <= 0;
        end
    end
endmodule
