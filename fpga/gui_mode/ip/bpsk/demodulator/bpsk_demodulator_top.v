`include "params.vh"
module bpsk_demodulator_top #(
    parameter DATA_WIDTH = `FIXDT_64_A_WIDTH,
    parameter DATA_FRAC_WIDTH = `FIXDT_64_A_FRAC_WIDTH,
    parameter LOOP_FILTER_KP = 64'sh000000020c49ba5e, // decimal 0.001
    parameter LOOP_FILTER_KI = 64'sh00000000346dc5d6, // decimal 0.0001
    parameter M_2_PI = `M_2_PI_64B_A
) (
    input  wire                         clk,
    input  wire                         rst_n,
    input  wire signed [DATA_WIDTH-1:0] data_in,  // from ADC, 2s complement
    output wire                         data_out, // 1 or 0

    // cosine lu
    output wire        [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] nco_i_cosine_lu_angle_steps,
    output wire        [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] nco_q_cosine_lu_angle_steps,
    input  wire signed [DATA_WIDTH-1:0]                          nco_carrier_i,
    input  wire signed [DATA_WIDTH-1:0]                          nco_carrier_q
);

wire signed [DATA_WIDTH*`LPF_TAPS-1:0] i_mixer_out_fifo;
wire signed [DATA_WIDTH*`LPF_TAPS-1:0] q_mixer_out_fifo;
wire signed [DATA_WIDTH-1:0] i_mixer_out, q_mixer_out;
wire signed [(DATA_WIDTH*2)-1:0] nco_carrier; // [0] = cosine zero shift carrier(i), [1] = quadrature sine carrier(q)
wire signed [DATA_WIDTH-1:0] fb_mixer_out;
wire signed [DATA_WIDTH-1:0] i_lpf_out, q_lpf_out;
wire signed [DATA_WIDTH-1:0] phase_adjust;
wire signed [DATA_WIDTH-1:0] data_in_pip_reg_out;

assign data_out = i_lpf_out[DATA_WIDTH-1];

pip_reg #(
    .DATA_WIDTH(DATA_WIDTH)
) pip_reg_inst (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_in),
    .data_out(data_in_pip_reg_out)
);

mixer #(
    .DATA_WIDTH(DATA_WIDTH),
    .DATA_FRAC_WIDTH(DATA_FRAC_WIDTH)
) mixer_inst_i (
    .in_a(data_in_pip_reg_out),
    .in_b(nco_carrier_i),
    .out(i_mixer_out)
);

fifo #(
    .FIFO_SIZE(`LPF_TAPS),
    .DATA_WIDTH(DATA_WIDTH)
) fifo_inst_mixer_i (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(i_mixer_out),
    .fifo_out(i_mixer_out_fifo)
);

mixer #(
    .DATA_WIDTH(DATA_WIDTH),
    .DATA_FRAC_WIDTH(DATA_FRAC_WIDTH)
) mixer_inst_q (
    .in_a(data_in_pip_reg_out),
    .in_b(nco_carrier_q),
    .out(q_mixer_out)
);

fifo #(
    .FIFO_SIZE(`LPF_TAPS),
    .DATA_WIDTH(DATA_WIDTH)
) fifo_inst_mixer_q (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(q_mixer_out),
    .fifo_out(q_mixer_out_fifo)
);

loop_filter #(
    .Kp(LOOP_FILTER_KP),
    .Ki(LOOP_FILTER_KI),
    .DATA_WIDTH(DATA_WIDTH),
    .DATA_FRAC_WIDTH(DATA_FRAC_WIDTH)
) loop_filter_inst (
    .clk(clk),
    .rst_n(rst_n),
    .phase_error_next(fb_mixer_out),
    .phase_adjust(phase_adjust)
);

nco #(
    .DATA_WIDTH(DATA_WIDTH),
    .DATA_FRAC_WIDTH(DATA_FRAC_WIDTH),
    .M_2_PI(M_2_PI)
) nco_inst (
    .clk(clk),
    .rst_n(rst_n),
    .phase_adjust(phase_adjust), 
    .i_cosine_lu_angle_steps(nco_i_cosine_lu_angle_steps),
    .q_cosine_lu_angle_steps(nco_q_cosine_lu_angle_steps)
);

lpf_integrator #(
    .ARRAY_SIZE(`LPF_TAPS+1),
    .DATA_WIDTH(DATA_WIDTH)
) lpf_inst_i (
    .input_array({i_mixer_out_fifo, i_mixer_out}),
    .out(i_lpf_out)
);

lpf_integrator #(
    .ARRAY_SIZE(`LPF_TAPS+1),
    .DATA_WIDTH(DATA_WIDTH)
) lpf_inst_q (
    .input_array({q_mixer_out_fifo, q_mixer_out}),
    .out(q_lpf_out)
);

mixer #(
    .DATA_WIDTH(DATA_WIDTH),
    .DATA_FRAC_WIDTH(DATA_FRAC_WIDTH)
) mixer_inst_fb (
    .in_a(i_lpf_out),
    .in_b(q_lpf_out),
    .out(fb_mixer_out)
);

endmodule