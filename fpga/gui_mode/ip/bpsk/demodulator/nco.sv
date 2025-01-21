/* 
 * numerically controlled oscillator
 * 
 * This module computes the address that feeds into cosine_lut
 * which generates our cosine carrier(I) signal and quadrature 
 * carrier(Q).
 */
`include "params.svh"
`default_nettype none
module nco (
    input  wire clk,
    input  wire rst,
    input  wire signed   [`FIXDT_64_A_WIDTH-1:0]                   phase_adjust, // this is feedback signal to control nco_phase. 0 => positive, 1 => negative
    output wire unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] i_cosine_lu_angle_steps,
    output wire unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] q_cosine_lu_angle_steps
);

reg  signed [`FIXDT_64_A_WIDTH-1:0] i_cosine_lu_angle_rads, i_cosine_lu_angle_rads_prev;
reg  signed [`FIXDT_64_A_WIDTH-1:0] q_cosine_lu_angle_rads, q_cosine_lu_angle_rads_prev;
wire signed [`FIXDT_64_A_WIDTH-1:0] i_cosine_lu_angle_rads_temp, q_cosine_lu_angle_rads_temp;

assign i_cosine_lu_angle_rads_temp = i_cosine_lu_angle_rads_prev + (`M_2_PI_64B_A / (`SAMPLING_FREQ / `CARRIER_FREQ)) - phase_adjust;
assign q_cosine_lu_angle_rads_temp = q_cosine_lu_angle_rads_prev + (`M_2_PI_64B_A / (`SAMPLING_FREQ / `CARRIER_FREQ)) - phase_adjust;

always_comb begin
    if (rst) begin
        i_cosine_lu_angle_rads <= {`FIXDT_64_A_WIDTH{1'b0}};
        q_cosine_lu_angle_rads <= (`M_2_PI_64B_A / 4) * 3; // sin(x) = cos(x + 3pi/2)
    end else begin
        if (i_cosine_lu_angle_rads_temp >= `M_2_PI_64B_A) begin
            i_cosine_lu_angle_rads <= i_cosine_lu_angle_rads_temp - `M_2_PI_64B_A;
        end else begin
            i_cosine_lu_angle_rads <= i_cosine_lu_angle_rads_temp;
        end
        if (i_cosine_lu_angle_rads_temp >= `M_2_PI_64B_A) begin
            q_cosine_lu_angle_rads <= q_cosine_lu_angle_rads_temp - `M_2_PI_64B_A;
        end else begin
            q_cosine_lu_angle_rads <= q_cosine_lu_angle_rads_temp;
        end
    end
end

always_ff @ (posedge clk) begin
    if (rst) begin
        i_cosine_lu_angle_rads_prev <= {`FIXDT_64_A_WIDTH{1'b0}};
        q_cosine_lu_angle_rads_prev <= (`M_2_PI_64B_A / 4) * 3; // sin(x) = cos(x + 3pi/2)
    end else begin
        i_cosine_lu_angle_rads_prev <= i_cosine_lu_angle_rads;
        q_cosine_lu_angle_rads_prev <= q_cosine_lu_angle_rads;
    end
end

phase_converter #(
    .PHASE_STEP(`M_2_PI_64B_A/`CARRIER_SAMPLES_PER_PERIOD),
    .INPUT_WIDTH(`FIXDT_64_A_WIDTH),
    .M_2_PI(`M_2_PI_64B_A)
) phase_converster_inst_i (
    .input_value(i_cosine_lu_angle_rads),
    .phase_in_step(i_cosine_lu_angle_steps)
);

phase_converter #(
    .PHASE_STEP(`M_2_PI_64B_A/`CARRIER_SAMPLES_PER_PERIOD),
    .INPUT_WIDTH(`FIXDT_64_A_WIDTH),
    .M_2_PI(`M_2_PI_64B_A)
) phase_converster_inst_q (
    .input_value(q_cosine_lu_angle_rads),
    .phase_in_step(q_cosine_lu_angle_steps)
);

endmodule