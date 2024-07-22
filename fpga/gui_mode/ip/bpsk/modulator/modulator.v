`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2024 05:09:45 PM
// Design Name: 
// Module Name: modulator
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

//assume 200Mhz input clk

module modulator(clk,rst,en,in,out);

    input clk;
    input rst;
    input en;
    input in;
    output reg [11:0] out;

    wire [8:0] count;
    wire [11:0] wave_out_0;
    wire [11:0] wave_out_180;

    
    always @ (posedge clk) begin
        if (en) begin
            if (in == 1'b1)
                out <= wave_out_0;
            else    
                out <= wave_out_180;
        end else begin
            out <= 0;
        end
    end

    counter counter_inst(.clk(clk),.rst(rst),.out(count));
    cos_gen_lut cos_gen_0(.index(count),.cos_wave_out(wave_out_0));
    cos_gen_lut cos_gen_180(.index((count+256)%512),.cos_wave_out(wave_out_180));

endmodule
