`timescale 1ns/1ps
`include "params.svh"
`default_nettype none
module bpsk_demodulator_top (
    input  wire clk,
    input  wire rst,
    input  wire [`ADC_BITS-1:0] data_in, // from ADC
    output wire data_out // 1 or 0
);

wire [(`FIXED_PT_WIDTH+`ADC_BITS)-1:0] i_mixer_out_fifo [0:(`ADC_SAMPLING_FREQ/`CARRIER_FREQ)-1];
wire [(`FIXED_PT_WIDTH+`ADC_BITS)-1:0] q_mixer_out_fifo [0:(`ADC_SAMPLING_FREQ/`CARRIER_FREQ)-1];
wire [(`FIXED_PT_WIDTH+`ADC_BITS)-1:0] i_mixer_out, q_mixer_out;
wire [`FIXED_PT_WIDTH-1:0] nco_carrier [0:1]; // [0] = cosine zero shift carrier(i), [1] = quadrature sine carrier(q)
wire [2*(`FIXED_PT_WIDTH+`ADC_BITS-10)-1:0] fb_mixer_out;
wire [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] nco_i_lu_angle, nco_q_lu_angle;
wire [`FIXED_PT_WIDTH+`ADC_BITS-1:0] i_lpf_out, q_lpf_out;

assign data_out = i_lpf_out[`FIXED_PT_WIDTH+`ADC_BITS-1];

mixer #(
    .IN_A_BITS(`ADC_BITS),
    .IN_B_BITS(`FIXED_PT_WIDTH)
) mixer_inst_i (
    .in_a(data_in),
    .in_b(nco_carrier[0]),
    .out(i_mixer_out)
);

fifo #(
    .FIFO_SIZE(`ADC_SAMPLING_FREQ/`CARRIER_FREQ),
    .DATA_WIDTH(`ADC_BITS+`FIXED_PT_WIDTH)
) fifo_inst_mixer_i (
    .clk(clk),
    .rst(rst),
    .data_in(i_mixer_out),
    .fifo_out(i_mixer_out_fifo)
);

mixer #(
    .IN_A_BITS(`ADC_BITS),
    .IN_B_BITS(`FIXED_PT_WIDTH)
) mixer_inst_q (
    .in_a(data_in),
    .in_b(nco_carrier[1]),
    .out(q_mixer_out)
);

fifo #(
    .FIFO_SIZE(`ADC_SAMPLING_FREQ/`CARRIER_FREQ),
    .DATA_WIDTH(`ADC_BITS+`FIXED_PT_WIDTH)
) fifo_inst_mixer_q (
    .clk(clk),
    .rst(rst),
    .data_in(q_mixer_out),
    .fifo_out(q_mixer_out_fifo)
);

nco nco_inst (
    .clk(clk),
    .rst(rst),
    // the sign bit of feedback mixer output decides whether we have too much 
    // phase shift or too little
    .in(fb_mixer_out[2*(`FIXED_PT_WIDTH+`ADC_BITS-10)-1]), 
    .i_cosine_lu_angle(nco_i_lu_angle),
    .q_cosine_lu_angle(nco_q_lu_angle)
);

cosine_lut #(
    .READ_PORTS(2)
) cosine_lut_inst (
    .in({
        nco_i_lu_angle,
        nco_q_lu_angle
    }),
    .out(nco_carrier)
);

lpf_integrator #(
    .ARRAY_SIZE(`ADC_SAMPLING_FREQ/`CARRIER_FREQ),
    .DATA_WIDTH(`FIXED_PT_WIDTH + `ADC_BITS)
) lpf_inst_i (
    .clk(clk),
    .rst(rst),
    .input_array(i_mixer_out_fifo),
    .out(i_lpf_out)
);

lpf_integrator #(
    .ARRAY_SIZE(`ADC_SAMPLING_FREQ/`CARRIER_FREQ),
    .DATA_WIDTH(`FIXED_PT_WIDTH + `ADC_BITS)
) lpf_inst_q (
    .clk(clk),
    .rst(rst),
    .input_array(q_mixer_out_fifo),
    .out(q_lpf_out)
);

mixer #(
    .IN_A_BITS(`FIXED_PT_WIDTH+`ADC_BITS-10),
    .IN_B_BITS(`FIXED_PT_WIDTH+`ADC_BITS-10)
) mixer_inst_fb (
    .in_a(i_lpf_out[`FIXED_PT_WIDTH+`ADC_BITS-1:10]), // get rid of all the decimal points in lpf outputs
    .in_b(q_lpf_out[`FIXED_PT_WIDTH+`ADC_BITS-1:10]),
    .out(fb_mixer_out)
);

endmodule