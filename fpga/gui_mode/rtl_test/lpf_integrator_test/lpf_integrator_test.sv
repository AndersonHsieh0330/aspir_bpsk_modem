`timescale 1ps/1ps
`include "params.svh"
`default_nettype none
module lpf_integrator_test ();

reg         clk;
reg  [17:0] input_array [0:7];
wire [17:0] out;

initial begin
    clk <= 1'b0;
    for (integer i = 0 ; i < 8 ; i = i + 1) begin
        input_array[i] <= {17{1'b0}};
    end
    for (integer i = 0 ; i < 8 ; i = i + 1) begin
        input_array[i] <= {i, {10{1'b0}}};
        #2;
    end
    #2;
    $finish;
end

always begin
    #1 clk <= ~clk;
end

lpf_integrator #(
    .ARRAY_SIZE(8),
    .DATA_WIDTH(18)
) lpf_integrator_inst (
    .input_array(input_array),
    .out(out)
);

endmodule