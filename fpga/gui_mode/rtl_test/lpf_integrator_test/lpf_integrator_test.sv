`timescale 1ps/1ps
`include "params.vh"
`default_nettype none
module lpf_integrator_test ();

reg              clk;
reg  [4:0]       temp_array [0:4];
reg  [(5*5)-1:0] input_array;
wire [4:0]       out;

initial begin
    clk = 1'b0;
    temp_array[0] = 5'b00001;
    temp_array[1] = 5'b00010;
    temp_array[2] = 5'b00011;
    temp_array[3] = 5'b00100;
    temp_array[4] = 5'b00101;
    input_array <= {24{1'b0}};
    for (integer i = 0 ; i < 5 ; i = i + 1) begin
        #2;
        input_array[(i*5) +: 5] = temp_array[i];
    end
    #2;
    $finish;
end

always begin
    #1 clk <= ~clk;
end

lpf_integrator #(
    .ARRAY_SIZE(5),
    .DATA_WIDTH(5)
) lpf_integrator_inst (
    .input_array(input_array),
    .out(out)
);

endmodule