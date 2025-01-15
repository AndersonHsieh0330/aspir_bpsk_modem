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
    input  wire in, // this is feedback signal to control nco_phase. 0 => positive, 1 => negative
    output reg unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] i_cosine_lu_angle,
    output reg unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] q_cosine_lu_angle
);

reg  signed [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] nco_phase;
wire signed [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] nco_phase_next;

assign nco_phase_next = in ? nco_phase + 1 : nco_phase - 1;
//assign nco_phase_next = 0;

always_ff @ (posedge clk) begin
    if (rst) begin
        nco_phase = {$clog2(`CARRIER_SAMPLES_PER_PERIOD){1'b0}};
        i_cosine_lu_angle <= {$clog2(`CARRIER_SAMPLES_PER_PERIOD){1'b0}};
        // sin(x) = cos(x + 3pi/2)
        q_cosine_lu_angle <= (`CARRIER_SAMPLES_PER_PERIOD / 4) * 3;
    end else begin
        /* 
         * each step = carrier samples per period / (carrier period / adc sampling period)
         *           = carrier samples per period / (adc sampling frequency / carrier frequency)
         *
         * example with default numbers :
         * each step = 1024 / (100 Mhz / 25 Mhz) 
         *           = 256
         */
        i_cosine_lu_angle <= i_cosine_lu_angle + (`CARRIER_SAMPLES_PER_PERIOD / (`SAMPLING_FREQ / `CARRIER_FREQ)) + nco_phase;
        q_cosine_lu_angle <= q_cosine_lu_angle + (`CARRIER_SAMPLES_PER_PERIOD / (`SAMPLING_FREQ / `CARRIER_FREQ)) + nco_phase;
        nco_phase = nco_phase_next; // each step is 2pi / 1024 = 0.00613592315 rad
    end
end

endmodule