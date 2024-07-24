`timescale 1ns/1ps
`include "params.svh"
`default_nettype none
module counter(
    input wire clk,
    input wire rst,
    output reg [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] out_0,
    output reg [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] out_180
);

always @ (posedge clk) begin
    if (rst) begin
        out_0 <= {$clog2(`CARRIER_SAMPLES_PER_PERIOD){1'b0}};
        out_180 <= `CARRIER_SAMPLES_PER_PERIOD / 2;
    end else begin
        // intentionally overflow
        out_0 <= out_0 + `CARRIER_SAMPLES_PER_PERIOD / (`ADC_SAMPLING_FREQ / `CARRIER_FREQ);
        out_180 <= out_180 + `CARRIER_SAMPLES_PER_PERIOD / (`ADC_SAMPLING_FREQ / `CARRIER_FREQ);
    end
end

endmodule
