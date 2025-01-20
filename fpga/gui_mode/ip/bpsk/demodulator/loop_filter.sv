`include "params.svh"
module loop_filter #(
    parameter Kp = 64'sh000000020c49ba5e, // 0.001
    parameter Ki = 64'sh00000000346dc5d6  // 0.0001
) (
    input  wire clk,
    input  wire rst,
    input  wire signed [`FIXDT_64_A_WIDTH-1:0] phase_error,
    output wire signed [`FIXDT_64_A_WIDTH-1:0] phase_adjust
);

reg  signed [`FIXDT_64_A_WIDTH-1:0] integral_error;
wire signed [`FIXDT_64_A_WIDTH-1:0] p_gain_product, i_gain_product;
wire                                p_gain_overflow, p_gain_underflow, i_gain_overflow, i_gain_underflow;

mixer #(
    .DATA_WIDTH(`FIXDT_64_A_WIDTH),
    .DATA_FRAC_WIDTH(`FIXDT_64_A_FRAC_WIDTH)
) p_gain_mixer_inst (
    .in_a(Kp),
    .in_b(phase_error),
    .out(p_gain_product),
    .overflow(p_gain_overflow),
    .underflow(p_gain_underflow)
);

mixer #(
    .DATA_WIDTH(`FIXDT_64_A_WIDTH),
    .DATA_FRAC_WIDTH(`FIXDT_64_A_FRAC_WIDTH)
) i_gain_mixer_inst (
    .in_a(Ki),
    .in_b(integral_error),
    .out(i_gain_product),
    .overflow(i_gain_overflow),
    .underflow(i_gain_underflow)
);

// data type should have enough range to not have over/under flow happening here
assign phase_adjust = p_gain_product + i_gain_product;

always_ff @(posedge clk) begin
    if (rst) begin
        integral_error <= {`FIXDT_64_A_WIDTH{1'b0}};
    end else begin
        integral_error <= integral_error + phase_error;
    end
end

endmodule