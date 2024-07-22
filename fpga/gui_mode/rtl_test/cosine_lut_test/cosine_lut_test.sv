`timescale 1ps/1ps
`include "params.svh"
`default_nettype none
module cosine_lut_test ();
    reg  [8:0]  in  [0:0];
    wire [17:0] out [0:0];

    cosine_lut #(
        .READ_PORTS(1)
    ) cosine_lut_inst (
        .in({in}),
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
    in[0] = 8'b0000_0000;
    #1;
    for (int i = 0 ; i < 512 ; i = i + 1) begin
        in[0] = in[0] + 1;
        #2;
    end
    $finish;
end

endmodule