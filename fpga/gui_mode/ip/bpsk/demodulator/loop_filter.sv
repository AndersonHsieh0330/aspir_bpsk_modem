`include "params.svh"
module loop_filter #(
    parameter Kp = 32'sb0_0000000000000010_100011110101110, // 0.01
    parameter Ki = 32'sb0_0000000000000000_010000011000101 // 0.001
) (
    input  wire clk,
    input  wire rst,
    input  wire signed [`FIXDT_32_WIDTH-1:0] phase_error,
    output wire signed [`FIXDT_32_WIDTH-1:0] phase_adjust
);

reg  signed [`FIXDT_32_WIDTH-1:0] integral_error;
wire signed [`FIXDT_32_WIDTH-1:0] control_signal, p_gain_product, i_gain_product;
bit                               p_gain_overflow, p_gain_underflow, i_gain_overflow, i_gain_underflow;

mixer #(
    .DATA_WIDTH(`FIXDT_32_WIDTH),
    .DATA_FRAC_WIDTH(`FIXDT_32_FRAC_WIDTH)
) p_gain_mixer_inst (
    .in_a(Kp),
    .in_b(phase_error),
    .out(p_gain_product),
    .overflow(p_gain_overflow),
    .underflow(p_gain_underflow)
);

mixer #(
    .DATA_WIDTH(`FIXDT_32_WIDTH),
    .DATA_FRAC_WIDTH(`FIXDT_32_FRAC_WIDTH)
) i_gain_mixer_inst (
    .in_a(Ki),
    .in_b(integral_error),
    .out(i_gain_product),
    .overflow(i_gain_overflow),
    .underflow(i_gain_underflow)
);
assign phase_adjust = p_gain_product + i_gain_product;

always_ff @(posedge clk) begin
    if (rst) begin
        integral_error <=  {`FIXDT_32_WIDTH{1'b0}};
    end else begin
        integral_error <= integral_error + phase_error;
    end
end

endmodule