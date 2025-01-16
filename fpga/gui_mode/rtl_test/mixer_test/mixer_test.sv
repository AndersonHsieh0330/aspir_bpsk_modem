`timescale 1ns/1ns
`include "params.svh"
module mixer_test();

    bit overflow, underflow;
    reg signed [`FIXDT_32_WIDTH-1:0] in_a, in_b, out;

    initial begin
        in_a = 32'sh00000b24; // 0.0003399848937988281
        in_b = 32'sh00c80029; // 1.0000048875808716
        #300
        // overflow
        in_a = 32'sh7fffffff; // 255.9999998807907
        in_b = 32'sh00800001; // 1.00000011...
        #300
        // underflow
        in_a = 32'sh80000000; // 0.0003399848937988281
        in_b = 32'sh00800001; // 1.00000011...
        // no overflow
        in_a = 32'sh7ffffffE; // 255.9999998807907
        in_b = 32'sh00800000; // 1.0
        #300
        // no underflow
        in_a = 32'sh80000001; // 0.0003399848937988281
        in_b = 32'sh00800000; // 1.0
    end

    mixer #(
        .DATA_WIDTH(`FIXDT_32_WIDTH),
        .DATA_FRAC_WIDTH(`FIXDT_32_FRAC_WIDTH)
    ) mixer_inst (
        .in_a(in_a),
        .in_b(in_b),
        .out(out),
        .overflow(overflow),
        .underflow(underflow)
    );
endmodule