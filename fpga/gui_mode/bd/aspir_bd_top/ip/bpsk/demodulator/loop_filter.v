`include "params.vh"
module loop_filter #(
    parameter Kp = 64'sh000000020c49ba5e, // 0.001
    parameter Ki = 64'sh00000000346dc5d6, // 0.0001
    parameter DATA_WIDTH = `FIXDT_64_A_WIDTH,
    parameter DATA_FRAC_WIDTH = `FIXDT_64_A_FRAC_WIDTH
) (
    input  wire clk,
    input  wire rst_n,
    input  wire signed [DATA_WIDTH-1:0] phase_error_next,
    output wire signed [DATA_WIDTH-1:0] phase_adjust
);

reg  signed [DATA_WIDTH-1:0] integral_error_reg, phase_error_reg;
wire signed [DATA_WIDTH-1:0] p_gain_product, i_gain_product;
wire signed [DATA_WIDTH-1:0] control_signal;
reg  signed [DATA_WIDTH-1:0] phase_adjust_reg;
wire                         p_gain_overflow, p_gain_underflow, i_gain_overflow, i_gain_underflow;

mixer #(
    .DATA_WIDTH(DATA_WIDTH),
    .DATA_FRAC_WIDTH(DATA_FRAC_WIDTH)
) p_gain_mixer_inst (
    .in_a(Kp),
    .in_b(phase_error_reg),
    .out(p_gain_product),
    .overflow(p_gain_overflow),
    .underflow(p_gain_underflow)
);

mixer #(
    .DATA_WIDTH(DATA_WIDTH),
    .DATA_FRAC_WIDTH(DATA_FRAC_WIDTH)
) i_gain_mixer_inst (
    .in_a(Ki),
    .in_b(integral_error_reg),
    .out(i_gain_product),
    .overflow(i_gain_overflow),
    .underflow(i_gain_underflow)
);

// data type should have enough range to not have over/under flow happening here
// TODO : investigate whether we need explicit over/underflow controlled adder instantiated here
assign control_signal = p_gain_product + i_gain_product;
assign phase_adjust = phase_adjust_reg - control_signal;

always @(posedge clk) begin
    if (~rst_n) begin
        integral_error_reg <= {DATA_WIDTH{1'b0}};
        phase_error_reg <= {DATA_WIDTH{1'b0}}; 
        phase_adjust_reg <= {DATA_WIDTH{1'b0}}; 
    end else begin
        integral_error_reg <= integral_error_reg + phase_error_next;
        phase_error_reg <= phase_error_next;
        phase_adjust_reg <= phase_adjust; 
    end
end

endmodule