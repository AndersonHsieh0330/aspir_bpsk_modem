`timescale 1ns/1ps
module qpsk_modulator_tb();

    reg clk;
    reg rst;
    reg [1:0] in;
    reg [`FIXDT_64_A_WIDTH-1:0] out;

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        in  = 2'b00;

        #15;

        rst = 1'b0;

        for (integer i = 0 ; i < 10 ; i = i + 1) begin
            // cycle through all inputs
            #100;
            in = in + 1;
        end
        $finish;
    end
        

    localparam clkperiod = 5;

    always #(clkperiod/2) begin
        clk = ~clk;
    end

    qpsk_modulator qpsk_modulator_inst (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out)
    );


endmodule