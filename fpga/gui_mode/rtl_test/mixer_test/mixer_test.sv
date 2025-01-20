`timescale 1ns/1ns
`include "params.svh"
module mixer_test();

    bit overflow, underflow;
    reg signed [`FIXDT_64_A_WIDTH-1:0] in_a, in_b, out;

    initial begin
        in_a = 64'sh00000000b2400000; // 0.0003399848937988281
        in_b = 64'sh0000080002640868; // 1.000456
        #300
        // overflow
        in_a = 64'sh7fffffffffffffff; // 255.9999998807907
        in_b = 64'sh0000080000000001; // 1.0000000000001137...
        #300
        // underflow
        in_a = 64'sh8000000000000000; // 0.0003399848937988281
        in_b = 64'sh0000080000000001; // 1.00000011...
        #300
        // no overflow
        in_a = 64'sh7ffffffffffffffE; // 255.9999998807907
        in_b = 64'sh0000080000000000; // 1.0
        #300
        // no underflow
        in_a = 64'sh8000000000000001; // 0.0003399848937988281
        in_b = 64'sh0000080000000000; // 1.0
    end

    mixer #(
        .DATA_WIDTH(`FIXDT_64_A_WIDTH),
        .DATA_FRAC_WIDTH(`FIXDT_64_A_FRAC_WIDTH)
    ) mixer_inst (
        .in_a(in_a),
        .in_b(in_b),
        .out(out),
        .overflow(overflow),
        .underflow(underflow)
    );
endmodule