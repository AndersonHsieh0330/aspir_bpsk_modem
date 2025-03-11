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
    parameter signed M_2_PI = `M_2_PI_64B_A
) (
    input  wire clk,
    input  wire rst_n,
    input  wire signed [DATA_WIDTH-1:0]                          phase_adjust, // this is feedback signal to control nco_phase. 0 => positive, 1 => negative
    output wire        [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] i_cosine_lu_angle_steps,
    output wire        [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] q_cosine_lu_angle_steps
);

reg signed [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] i_cosine_lu_angle_steps_reg;
reg signed [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] q_cosine_lu_angle_steps_reg;
wire [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] phase_adjust_steps;

assign i_cosine_lu_angle_steps = i_cosine_lu_angle_steps_reg + phase_adjust_steps;
assign q_cosine_lu_angle_steps = q_cosine_lu_angle_steps_reg + phase_adjust_steps;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        i_cosine_lu_angle_steps_reg <= {`CARRIER_SAMPLES_PER_PERIOD{1'b0}};
        q_cosine_lu_angle_steps_reg <= (`CARRIER_SAMPLES_PER_PERIOD / 4) * 3; // sin(x) = cos(x + 3pi/2)
    end else begin
        if (i_cosine_lu_angle_steps_reg + (`CARRIER_SAMPLES_PER_PERIOD / (`SAMPLING_FREQ / `CARRIER_FREQ)) >= `CARRIER_SAMPLES_PER_PERIOD) begin
            i_cosine_lu_angle_steps_reg = {`CARRIER_SAMPLES_PER_PERIOD{1'b0}};
        end else begin
            i_cosine_lu_angle_steps_reg <= i_cosine_lu_angle_steps_reg + (`CARRIER_SAMPLES_PER_PERIOD / (`SAMPLING_FREQ / `CARRIER_FREQ));
        end
        if (q_cosine_lu_angle_steps_reg + (`CARRIER_SAMPLES_PER_PERIOD / (`SAMPLING_FREQ / `CARRIER_FREQ)) >= `CARRIER_SAMPLES_PER_PERIOD) begin
            q_cosine_lu_angle_steps_reg <= {`CARRIER_SAMPLES_PER_PERIOD{1'b0}};
        end else begin
            q_cosine_lu_angle_steps_reg <= q_cosine_lu_angle_steps_reg + (`CARRIER_SAMPLES_PER_PERIOD / (`SAMPLING_FREQ / `CARRIER_FREQ));
        end
    end
end

phase_converter #(
    .PHASE_STEP(M_2_PI/`CARRIER_SAMPLES_PER_PERIOD),
    .INPUT_WIDTH(DATA_WIDTH),
    .M_2_PI(M_2_PI)
) phase_converter_inst_i (
    .input_value(phase_adjust),
    .phase_in_step(phase_adjust_steps)
);

endmodule