/* 
 * numerically controlled oscillator
 * 
 * This module computes the address that feeds into cosine_lut
 * which generates our cosine carrier(I) signal and quadrature 
 * carrier(Q).
 */
`include "params.svh"
`include "phase_converter.sv"
`default_nettype none
module nco (
    input  wire clk,
    input  wire rst,
    input  wire signed   [`FIXDT_32_WIDTH-1:0] phase_adjust, // this is feedback signal to control nco_phase. 0 => positive, 1 => negative
    output wire unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] i_cosine_lu_angle_steps,
    output wire unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] q_cosine_lu_angle_steps
);

reg  signed [`FIXDT_32_WIDTH-1:0] i_cosine_lu_angle_rads, i_cosine_lu_angle_rads_prev;
reg  signed [`FIXDT_32_WIDTH-1:0] q_cosine_lu_angle_rads, q_cosine_lu_angle_rads_prev;
wire signed [`FIXDT_32_WIDTH-1:0] i_cosine_lu_angle_rads_temp, q_cosine_lu_angle_rads_temp;
reg  signed [`FIXDT_32_WIDTH-1:0] phase_adjust_prev;
PhaseConverter pc = new();

assign i_cosine_lu_angle_steps = pc.rad_to_step(i_cosine_lu_angle_rads);
assign q_cosine_lu_angle_steps = pc.rad_to_step(q_cosine_lu_angle_rads);
assign i_cosine_lu_angle_rads_temp = i_cosine_lu_angle_rads_prev + (`M_2_PI_32B / (`SAMPLING_FREQ / `CARRIER_FREQ)) + phase_adjust_prev - phase_adjust;
assign q_cosine_lu_angle_rads_temp = q_cosine_lu_angle_rads_prev + (`M_2_PI_32B / (`SAMPLING_FREQ / `CARRIER_FREQ)) + phase_adjust_prev - phase_adjust;

always_comb begin
    if (rst) begin
        i_cosine_lu_angle_rads <= {`FIXDT_32_WIDTH{1'b0}};
        q_cosine_lu_angle_rads <= (`M_2_PI_32B / 4) * 3; // sin(x) = cos(x + 3pi/2)
    end else begin
        if (i_cosine_lu_angle_rads_temp >= `M_2_PI_32B) begin
            i_cosine_lu_angle_rads <= i_cosine_lu_angle_rads_temp - `M_2_PI_32B;
        end else begin
            i_cosine_lu_angle_rads <= i_cosine_lu_angle_rads_temp;
        end
        if (i_cosine_lu_angle_rads_temp >= `M_2_PI_32B) begin
            q_cosine_lu_angle_rads <= q_cosine_lu_angle_rads_temp - `M_2_PI_32B;
        end else begin
            q_cosine_lu_angle_rads <= q_cosine_lu_angle_rads_temp;
        end
    end
end

always_ff @ (posedge clk) begin
    if (rst) begin
        i_cosine_lu_angle_rads_prev <= {`FIXDT_32_WIDTH{1'b0}};
        q_cosine_lu_angle_rads_prev <= (`M_2_PI_32B / 4) * 3; // sin(x) = cos(x + 3pi/2)
        phase_adjust_prev <= {`FIXDT_32_WIDTH{1'b0}};
    end else begin
        i_cosine_lu_angle_rads_prev <= i_cosine_lu_angle_rads;
        q_cosine_lu_angle_rads_prev <= q_cosine_lu_angle_rads;
        phase_adjust_prev <= phase_adjust;
    end
end

endmodule