`timescale 1ps/1ps
`include "params.vh"
`default_nettype none
module cosine_lut_test ();
    reg  [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] in;
    wire [`FIXDT_64_A_WIDTH-1:0] out;

    cosine_lut #(
        .READ_PORTS(1)
    ) cosine_lut_inst (
        .in(in),
        .out(out)      
    /*
     *   declaring in to be "reg [8:0] in [0:1]"
     *   and not using curly brackets when connecting to module
     *   also works
     *   .in(in)
     *   
     *   however out must be declared as unpacked array,
     *   using curly brakcets won't work
     *   wire [17:0] out_1, out_2;
     *   .out({out_1, out_2}) <= won't work     
     */
    );

initial begin
    in = {$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1{1'b0}};
    #1;
    for (int i = 0 ; i < `CARRIER_SAMPLES_PER_PERIOD; i = i + 1) begin
        in = in + 1;
        #2;
    end
    $finish;
end

endmodule