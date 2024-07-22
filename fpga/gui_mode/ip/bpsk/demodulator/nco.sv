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
    
    // cosine look up (lu stands for look up)
    output reg [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] i_cosine_lu_angle,
    output reg [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] q_cosine_lu_angle
);

// this is an unsigned number, underflow loops around
reg [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] nco_phase;

// feedback phase control
always @ (posedge clk) begin
    if (rst) begin
        nco_phase <= {$clog2(`CARRIER_SAMPLES_PER_PERIOD){1'b0}};
    end else begin
        nco_phase <= in ? nco_phase + 1 : nco_phase - 1;
    end
end

// i_out, compute the output cosine
always @ (posedge clk) begin
    if (rst) begin
        i_cosine_lu_angle <= {$clog2(`CARRIER_SAMPLES_PER_PERIOD){1'b0}};
    end else begin
        /* 
         * each step = carrier samples per period / (carrier period / adc sampling period)
         *           = carrier samples per period / (adc sampling frequency / carrier frequency)
         *
         * example with default numbers :
         * each step = 512 / (200 / 50) 
         *           = 128
         */
        i_cosine_lu_angle <= i_cosine_lu_angle + `CARRIER_SAMPLES_PER_PERIOD / (`ADC_SAMPLING_FREQ / `CARRIER_FREQ) + nco_phase;
    end
end

// q_out, compute the output quadrature sine
always @ (posedge clk) begin
    if (rst) begin
        // sin(x) = cos(x - pi/2)
        q_cosine_lu_angle <= `CARRIER_SAMPLES_PER_PERIOD * 3 / 4;
    end else begin
        /* 
         * each step = carrier samples per period / (carrier period / adc sampling period)
         *           = carrier samples per period / (adc sampling frequency / carrier frequency)
         *
         * example with default numbers :
         * each step = 512 / (200 / 50) 
         *           = 128
         */
        q_cosine_lu_angle <= q_cosine_lu_angle + `CARRIER_SAMPLES_PER_PERIOD / (`ADC_SAMPLING_FREQ / `CARRIER_FREQ) + nco_phase;
    end
end

endmodule