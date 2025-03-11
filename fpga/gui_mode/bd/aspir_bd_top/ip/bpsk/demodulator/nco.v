/* 
 * numerically controlled oscillator
 * 
 * This module computes the address that feeds into cosine_lut
 * which generates our cosine carrier(I) signal and quadrature 
 * carrier(Q).
 */
`include "params.vh"
module nco #(
    parameter DATA_WIDTH = `FIXDT_64_A_WIDTH,
    parameter DATA_FRAC_WIDTH = `FIXDT_64_A_FRAC_WIDTH,
    parameter M_2_PI = `M_2_PI_64B_A
) (
    input  wire clk,
    input  wire rst_n,
    input  wire signed [DATA_WIDTH-1:0]                          phase_adjust, // this is feedback signal to control nco_phase. 0 => positive, 1 => negative
    output wire        [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] i_cosine_lu_angle_steps,
    output wire        [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] q_cosine_lu_angle_steps
);

reg  signed [DATA_WIDTH-1:0] i_cosine_lu_angle_rads, i_cosine_lu_angle_rads_reg;
reg  signed [DATA_WIDTH-1:0] q_cosine_lu_angle_rads, q_cosine_lu_angle_rads_reg;
wire signed [DATA_WIDTH-1:0] i_cosine_lu_angle_rads_temp, q_cosine_lu_angle_rads_temp;

assign i_cosine_lu_angle_rads_temp = i_cosine_lu_angle_rads_reg + phase_adjust;
assign q_cosine_lu_angle_rads_temp = q_cosine_lu_angle_rads_reg + phase_adjust;

always @(*) begin
    if (~rst_n) begin
        i_cosine_lu_angle_rads = {DATA_WIDTH{1'b0}};
        q_cosine_lu_angle_rads = (M_2_PI / 4) * 3; // sin(x) = cos(x + 3pi/2)
    end else begin
        if (i_cosine_lu_angle_rads_temp >= M_2_PI) begin
            i_cosine_lu_angle_rads = i_cosine_lu_angle_rads_temp - M_2_PI;
        end else begin
            i_cosine_lu_angle_rads = i_cosine_lu_angle_rads_temp;
        end
        if (i_cosine_lu_angle_rads_temp >= M_2_PI) begin
            q_cosine_lu_angle_rads = q_cosine_lu_angle_rads_temp - M_2_PI;
        end else begin
            q_cosine_lu_angle_rads = q_cosine_lu_angle_rads_temp;
        end
    end
end

always @(posedge clk) begin
    if (~rst_n) begin
        i_cosine_lu_angle_rads_reg <= {DATA_WIDTH{1'b0}};
        q_cosine_lu_angle_rads_reg <= (M_2_PI / 4) * 3; // sin(x) = cos(x + 3pi/2)
    end else begin
        i_cosine_lu_angle_rads_reg <= i_cosine_lu_angle_rads_reg + (M_2_PI / (`SAMPLING_FREQ / `CARRIER_FREQ));
        q_cosine_lu_angle_rads_reg <= q_cosine_lu_angle_rads_reg + (M_2_PI / (`SAMPLING_FREQ / `CARRIER_FREQ));
    end
end

phase_converter #(
    .PHASE_STEP(M_2_PI/`CARRIER_SAMPLES_PER_PERIOD),
    .INPUT_WIDTH(DATA_WIDTH),
    .M_2_PI(M_2_PI)
) phase_converter_inst_i (
    .input_value(i_cosine_lu_angle_rads),
    .phase_in_step(i_cosine_lu_angle_steps)
);

phase_converter #(
    .PHASE_STEP(M_2_PI/`CARRIER_SAMPLES_PER_PERIOD),
    .INPUT_WIDTH(DATA_WIDTH),
    .M_2_PI(M_2_PI)
) phase_converter_inst_q (
    .input_value(q_cosine_lu_angle_rads),
    .phase_in_step(q_cosine_lu_angle_steps)
);

endmodule