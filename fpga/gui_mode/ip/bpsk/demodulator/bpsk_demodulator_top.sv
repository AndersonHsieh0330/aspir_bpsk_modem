`include "params.svh"
`default_nettype none
module bpsk_demodulator_top (
    input  wire                        clk,
    input  wire                        rst,
    input  wire signed [`ADC_BITS-1:0] data_in, // from ADC, 2s complement
    output wire                        data_out // 1 or 0
);

wire signed [(`FIXED_PT_WIDTH+`ADC_BITS)-1:0] i_mixer_out_fifo [0:(`LPF_TAPS)-1];
wire signed [(`FIXED_PT_WIDTH+`ADC_BITS)-1:0] q_mixer_out_fifo [0:(`LPF_TAPS)-1];
wire signed [(`FIXED_PT_WIDTH+`ADC_BITS)-1:0] i_mixer_out, q_mixer_out;
wire signed [`FIXED_PT_WIDTH-1:0] nco_carrier [0:1]; // [0] = cosine zero shift carrier(i), [1] = quadrature sine carrier(q)
wire signed [2*(`FIXED_PT_WIDTH+`ADC_BITS)-1:0] fb_mixer_out;
wire [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] nco_i_lu_angle, nco_q_lu_angle;
wire signed [`FIXED_PT_WIDTH+`ADC_BITS-1:0] i_lpf_out, q_lpf_out;

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
    .FIFO_SIZE(`LPF_TAPS),
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
    .FIFO_SIZE(`LPF_TAPS),
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
    .in(i_lpf_out[`FIXED_PT_WIDTH+`ADC_BITS-1]^q_lpf_out[`FIXED_PT_WIDTH+`ADC_BITS-1]), 
    //.in(fb_mixer_out[2*(`FIXED_PT_WIDTH+`ADC_BITS-10)-1]), 
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
    .ARRAY_SIZE(`LPF_TAPS+1),
    .DATA_WIDTH(`FIXED_PT_WIDTH + `ADC_BITS)
) lpf_inst_i (
    .input_array({i_mixer_out, i_mixer_out_fifo}),
    .out(i_lpf_out)
);

lpf_integrator #(
    .ARRAY_SIZE(`LPF_TAPS+1),
    .DATA_WIDTH(`FIXED_PT_WIDTH + `ADC_BITS)
) lpf_inst_q (
    .input_array({q_mixer_out, q_mixer_out_fifo}),
    .out(q_lpf_out)
);

mixer #(
    .IN_A_BITS(`FIXED_PT_WIDTH+`ADC_BITS),
    .IN_B_BITS(`FIXED_PT_WIDTH+`ADC_BITS)
) mixer_inst_fb (
    .in_a(i_lpf_out[`FIXED_PT_WIDTH+`ADC_BITS-1:0]), // get rid of all the decimal points in lpf outputs
    .in_b(q_lpf_out[`FIXED_PT_WIDTH+`ADC_BITS-1:0]),
    .out(fb_mixer_out)
);

endmodule