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
    input  wire signed [`FIXDT_32_WIDTH-1:0] phase_adjust, // this is feedback signal to control nco_phase. 0 => positive, 1 => negative
    output wire unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] i_cosine_lu_angle_steps,
    output wire unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] q_cosine_lu_angle_steps
);

reg signed [`FIXDT_32_WIDTH-1:0] i_cosine_lu_angle_rads, q_cosine_lu_angle_rads;
PhaseConverter pc = new();

assign i_cosine_lu_angle_steps = pc.rad_to_step(i_cosine_lu_angle_rads);
assign q_cosine_lu_angle_steps = pc.rad_to_step(q_cosine_lu_angle_rads);

always_ff @ (posedge clk) begin
    if (rst) begin
        i_cosine_lu_angle_rads <= {`FIXDT_32_WIDTH{1'b0}};
        q_cosine_lu_angle_rads <= (`M_2_PI_32B / 4) * 3; // sin(x) = cos(x + 3pi/2)
    end else begin
        /* 
         * each step = carrier samples per period / (carrier period / adc sampling period)
         *           = carrier samples per period / (adc sampling frequency / carrier frequency)
         *
         * example with default numbers :
         * each step = 1024 / (100 Mhz / 25 Mhz) 
         *           = 256
         */
        i_cosine_lu_angle_rads <= i_cosine_lu_angle_rads + (`M_2_PI_32B / (`SAMPLING_FREQ / `CARRIER_FREQ)) + phase_adjust;
        q_cosine_lu_angle_rads <= q_cosine_lu_angle_rads + (`M_2_PI_32B / (`SAMPLING_FREQ / `CARRIER_FREQ)) + phase_adjust;
    end
end

endmodule