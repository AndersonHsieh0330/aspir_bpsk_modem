`include "params.vh"
module demodulator_top (
    input  wire clk,
    input  wire rst,
    input  wire [`ADC_BITS-1:0] data_in, // from ADC
    output wire data_out // 1 or 0
);

wire [`FIXED_PT_WIDTH+`ADC_BITS-1:0] i_mixer_out_fifo, q_mixer_out_fifo [0:(`ADC_SAMPLING_FREQ/`CARRIER_FREQ)-1]; // 3 is temporary
wire [`FIXED_PT_WIDTH+`ADC_BITS-1:0] i_mixer_out, q_mixer_out;

mixer mixer_inst_i #(
    .IN_A_BITS(`ADC_BITS),
    .IN_B_BITS(`FIXED_PT_WIDTH)
) (
    in_a(data_in),
    in_b(i_carrier),
    out(i_mixer_out)
);

fifo fifo_inst_mixer_i #(
    .FIFO_SIZE(`ADC_SAMPLING_FREQ/`CARRIER_FREQ),
    .DATA_WIDTH(`ADC_BITS+`FIXED_PT_WIDTH)
) (
    .clk(clk),
    .rst(rst),
    .data_in(i_mixer_out),
    .fifo_out(i_mixer_out_fifo)
);

mixer mixer_inst_q #(
    .IN_A_BITS(`ADC_BITS),
    .IN_B_BITS(`FIXED_PT_WIDTH)
) (
    in_a(data_in),
    in_b(q_carrier),
    out(q_mixer_out)
);

fifo fifo_inst_mixer_q #(
    .FIFO_SIZE(`ADC_SAMPLING_FREQ/`CARRIER_FREQ),
    .DATA_WIDTH(`ADC_BITS+`FIXED_PT_WIDTH)
) (
    .clk(clk),
    .rst(rst),
    .data_in(q_mixer_out),
    .fifo_out(q_mixer_out_fifo)
);

wire [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] nco_i_lu_angle, nco_q_lu_angle;
nco nco_inst (
    .clk(clk),
    .rst(rst),
    // the sign bit of feedback mixer output decides whether we have too much 
    // phase shift or too little
    .in(fb_mixer_out[2*(`FIXED_PT_WIDTH+`ADC_BITS-10)-1]), 
    .i_cosine_lu_angle(nco_i_lu_angle),
    .q_cosine_lu_angle(nco_q_lu_angle)
);

cosine_lut cosine_lut_inst #(
    .READ_PORTS(2)
) (
    .in({
        nco_i_lu_angle,
        nco_q_lu_angle
    }),
    .out({
        i_carrier,
        q_carrier
    })
);

wire [`FIXED_PT_WIDTH+`ADC_BITS-1:0] i_lpf_out, q_lpf_out;
lpf_integrator lpf_inst_i #(
    .ARRAY_SIZE(`ADC_SAMPLING_FREQ/`CARRIER_FREQ)
) (
    .clk(clk),
    .rst(rst),
    .input_array(i_mixer_out_fifo),
    .out(i_lpf_out)
);

lpf_integrator lpf_inst_q #(
    .ARRAY_SIZE(`ADC_SAMPLING_FREQ/`CARRIER_FREQ)
) (
    .clk(clk),
    .rst(rst),
    .input_array(q_mixer_out_fifo),
    .out(q_lpf_out)
);

wire [2*(`FIXED_PT_WIDTH+`ADC_BITS-10)-1:0] fb_mixer_out;
mixer mixer_inst_fb #(
    .IN_A_BITS(`FIXED_PT_WIDTH+`ADC_BITS-10),
    .IN_B_BITS(`FIXED_PT_WIDTH+`ADC_BITS-10)
) (
    .in_a(i_lpf_out[`FIXED_PT_WIDTH+`ADC_BITS-1:10]), // get rid of all the decimal points in lpf outputs
    .in_a(i_lpf_out[`FIXED_PT_WIDTH+`ADC_BITS-1:10]),
    .out(fb_mixer_out)
);

endmodule