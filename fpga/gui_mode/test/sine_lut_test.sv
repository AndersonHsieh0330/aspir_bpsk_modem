/*
 *  This module shows basic waveform of the sine lock up table
 *  not too much going on, just a sanity check
 */
`timescale 1ns/100ps
module sine_lut_test ();
    reg  [8:0] in;
    wire [11:0]  out;

    sine_lut #(
        .SAMPLES(512),
        .BITS(12)
    ) sine_lut_inst (
        .in(in),
        .out(out)      
    );

initial begin
    in = 8'b0000_0000;
    #1;
    for (int i = 0 ; i < 512 ; i = i + 1) begin
        in = in + 1;
        #2;
    end
    $finish;
end

endmodule