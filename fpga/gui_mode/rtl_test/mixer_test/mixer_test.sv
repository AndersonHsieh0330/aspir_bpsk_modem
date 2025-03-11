`timescale 1ns/1ns
`include "params.vh"
module mixer_test();
    parameter DATA_WIDTH = `FIXDT_24_WIDTH;
    parameter DATA_FRAC_WIDTH = `FIXDT_24_FRAC_WIDTH;

    bit overflow, underflow;
    reg signed [DATA_WIDTH-1:0] in_a, in_b, out;

    initial begin
        in_a = 24'sh000016; // 0.0003399848937988281
        in_b = 24'sh01100e; // 1.062713623046875
        #300
        // overflow
        in_a = 24'sh7fffff; // 127.99998474121094
        in_b = 24'sh010001; // 1.0000152587890625...
        #300
        // underflow
        in_a = 24'sh800000; // -128
        in_b = 24'sh010001; // 1.0000152587890625...
        #300
        // no overflow
        in_a = 24'sh7fffff; // 255.9999998807907
        in_b = 24'sh010000; // 1.0
        #300
        // no underflow
        in_a = 24'sh800000; // -128
        in_b = 24'sh010000; // 1.0
        $finish();
    end

    mixer #(
        .DATA_WIDTH(DATA_WIDTH),
        .DATA_FRAC_WIDTH(DATA_FRAC_WIDTH)
    ) mixer_inst (
        .in_a(in_a),
        .in_b(in_b),
        .out(out),
        .overflow(overflow),
        .underflow(underflow)
    );
endmodule