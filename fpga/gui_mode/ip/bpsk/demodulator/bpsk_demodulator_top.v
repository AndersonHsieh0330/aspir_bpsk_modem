`include "params.vh"
`default_nettype none
module bpsk_demodulator_top (
    input  wire                                clk,
    input  wire                                rst,
    input  wire signed [`FIXDT_64_A_WIDTH-1:0] data_in, // from ADC, 2s complement
    output wire                                data_out // 1 or 0
);

wire signed   [`FIXDT_64_A_WIDTH-1:0] i_mixer_out_fifo [0:`LPF_TAPS-1];
wire signed   [`FIXDT_64_A_WIDTH-1:0] q_mixer_out_fifo [0:`LPF_TAPS-1];
wire signed   [`FIXDT_64_A_WIDTH-1:0] i_mixer_out, q_mixer_out;
wire signed   [`FIXDT_64_A_WIDTH-1:0] nco_carrier [0:1]; // [0] = cosine zero shift carrier(i), [1] = quadrature sine carrier(q)
wire signed   [`FIXDT_64_A_WIDTH-1:0] fb_mixer_out;
wire signed   [`FIXDT_64_A_WIDTH-1:0] i_lpf_out, q_lpf_out;
wire unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] nco_i_cosine_lu_angle_steps, nco_q_cosine_lu_angle_steps;
wire signed   [`FIXDT_64_A_WIDTH-1:0] phase_adjust;
wire clk;

assign data_out = i_lpf_out[`FIXDT_64_A_WIDTH-1];
assign clk = dco;

mixer #(
    .DATA_WIDTH(`FIXDT_64_A_WIDTH),
    .DATA_FRAC_WIDTH(`FIXDT_64_A_FRAC_WIDTH)
) mixer_inst_i (
    .in_a(data_in),
    .in_b(nco_carrier[0]),
    .out(i_mixer_out)
);

fifo #(
    .FIFO_SIZE(`LPF_TAPS),
    .DATA_WIDTH(`FIXDT_64_A_WIDTH)
) fifo_inst_mixer_i (
    .clk(clk),
    .rst(rst),
    .data_in(i_mixer_out),
    .fifo_out(i_mixer_out_fifo)
);

mixer #(
    .DATA_WIDTH(`FIXDT_64_A_WIDTH),
    .DATA_FRAC_WIDTH(`FIXDT_64_A_FRAC_WIDTH)
) mixer_inst_q (
    .in_a(data_in),
    .in_b(nco_carrier[1]),
    .out(q_mixer_out)
);

fifo #(
    .FIFO_SIZE(`LPF_TAPS),
    .DATA_WIDTH(`FIXDT_64_A_WIDTH)
) fifo_inst_mixer_q (
    .clk(clk),
    .rst(rst),
    .data_in(q_mixer_out),
    .fifo_out(q_mixer_out_fifo)
);

loop_filter #(
    .Kp(64'sh000000020c49ba5e), // 0.001
    .Ki(64'sh00000000346dc5d6),// 0.0001
    .DATA_WIDTH(`FIXDT_64_A_WIDTH),
    .DATA_FRAC_WIDTH(`FIXDT_64_A_FRAC_WIDTH)
) loop_filter_inst (
    .clk(clk),
    .rst(rst),
    .phase_error_next(fb_mixer_out),
    .phase_adjust(phase_adjust)
);

nco nco_inst (
    .clk(clk),
    .rst(rst),
    .phase_adjust(phase_adjust), 
    .i_cosine_lu_angle_steps(nco_i_cosine_lu_angle_steps),
    .q_cosine_lu_angle_steps(nco_q_cosine_lu_angle_steps)
);

cosine_lut #(
    .READ_PORTS(2)
) cosine_lut_inst (
    .in({
        nco_i_cosine_lu_angle_steps,
        nco_q_cosine_lu_angle_steps
    }),
    .out(nco_carrier)
);

lpf_integrator #(
    .ARRAY_SIZE(`LPF_TAPS+1),
    .DATA_WIDTH(`FIXDT_64_A_WIDTH)
) lpf_inst_i (
    .input_array({i_mixer_out, i_mixer_out_fifo}),
    .out(i_lpf_out)
);

lpf_integrator #(
    .ARRAY_SIZE(`LPF_TAPS+1),
    .DATA_WIDTH(`FIXDT_64_A_WIDTH)
) lpf_inst_q (
    .input_array({q_mixer_out, q_mixer_out_fifo}),
    .out(q_lpf_out)
);

mixer #(
    .DATA_WIDTH(`FIXDT_64_A_WIDTH),
    .DATA_FRAC_WIDTH(`FIXDT_64_A_FRAC_WIDTH)
) mixer_inst_fb (
    .in_a(i_lpf_out),
    .in_b(q_lpf_out),
    .out(fb_mixer_out)
);

endmodule