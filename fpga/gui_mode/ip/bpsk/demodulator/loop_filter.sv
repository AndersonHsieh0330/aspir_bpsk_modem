`include "params.svh"
module loop_filter #(
    parameter Kp = 32'sb0_0000000000000000_00000000001010001110 // 0.01
    parameter Ki = 32'sb0_0000000000000000_00000000000001000001 // 0.001
) (
    input  wire clk,
    input  wire rst,
    input  wire signed [2*(`FIXED_PT_WIDTH+`ADC_BITS)-1:0] phase_error;
    output reg unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] i_cosine_lu_angle,
    output reg unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] q_cosine_lu_angle
);

reg signed [2*(`FIXED_PT_WIDTH+`ADC_BITS)-1:0] integral_error;
reg signed [2*(`FIXED_PT_WIDTH+`ADC_BITS)-1:0] control_signal;

assign control_signal = Kp * phase_error + Ki + integral_error;
always_ff @(posedge clk) begin
    if (rst) begin
        integral_error <=  {2*(`FIXED_PT_WIDTH+`ADC_BITS){1'b0}};
    end else begin
        integral_error <= integral_error + phase_error;
    end
end



endmodule