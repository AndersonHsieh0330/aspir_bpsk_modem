//assume 200Mhz input clk
`timescale 1ns/1ps
`include "params.svh"
`default_nettype none
module bpsk_modulator_top (
    input  wire                clk,
    input  wire                rst,
    input  wire                en,
    input  wire                in,
    output reg [`ADC_BITS-1:0] out
);

    wire [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] count_0, count_180;
    wire [`FIXED_PT_WIDTH-1:0] wave_out [0:1];
    
    always @ (posedge clk) begin
        if (en) begin
            out <= wave_out[in][`ADC_BITS-1:0];
        end else begin
            out <= 0;
        end
    end

    counter counter_inst (
        .clk(clk),
        .rst(rst),
        .out_0(count_0),
        .out_180(count_180)
    );

    cosine_lut #(
        .READ_PORTS(2)
    ) cosine_lut_inst (
        .in({count_180,count_0}),
        .out(wave_out)
    );

endmodule
