`timescale 10ns/10ns
`include "params.vh"
`default_nettype none
module bpsk_demodulation_test ();

parameter DATA_WIDTH = `FIXDT_24_WIDTH;
reg clk, rst_n;
reg modulated_signal_select; // toggle between 1 and 0
reg signed [DATA_WIDTH-1:0] out;
reg unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] lu_angle;
wire unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] demod_cosine_lu_i, demod_cosine_lu_q;
wire signed [DATA_WIDTH-1:0] demod_nco_carrier_i, demod_nco_carrier_q;
wire signed [DATA_WIDTH-1:0] bpsk_data_in;
wire bpsk_data_out;

// generate random phase offset and convert to radians for easy comparison in waveform viewer
int unsigned INITIAL_PHASE_OFFSET_STEPS = 3235; // [`CARRIER_SAMPLES_PER_PERIOD, 0]
real M_2_PI = 6.283185307179586476925286766559;
real TOTAL_STEPS = `CARRIER_SAMPLES_PER_PERIOD-1;
real INITIAL_PHASE_OFFSET_RADS = (INITIAL_PHASE_OFFSET_STEPS / TOTAL_STEPS) * M_2_PI;

initial begin
    clk <= 1'b1;
    rst_n <= 1'b0;
    modulated_signal_select <= 1'b0;
    #100;
    rst_n <= 1'b1;
    for (integer i = 0 ; i < 1000 ; i = i + 1) begin
        #`SAMPLES_PER_SYMBOL;
        modulated_signal_select <= $urandom % 2;
    end
    $finish;
end

always begin
    // #1 is 10ns, period for 100 Mhz => 1e-8 seconds => 10 ns
    #0.5 clk <= ~clk;
end

always @(posedge clk) begin
    if (~rst_n) begin
        lu_angle <= {$clog2(`CARRIER_SAMPLES_PER_PERIOD){1'b0}} + INITIAL_PHASE_OFFSET_STEPS;
    end else begin
        lu_angle <= lu_angle + `CARRIER_SAMPLES_PER_PERIOD / (`SAMPLING_FREQ / `CARRIER_FREQ);
    end
end

cosine_lut # (
    .READ_PORTS(3)
) cosine_lut_inst (
    .clk(clk),
    .rst_n(rst_n),
    .in({lu_angle, demod_cosine_lu_i, demod_cosine_lu_q}),
    .out({out, demod_nco_carrier_i, demod_nco_carrier_q})
);

assign bpsk_data_in = modulated_signal_select? -1*out : out;

bpsk_demodulator_top #(
    .DATA_WIDTH(DATA_WIDTH),
    .DATA_FRAC_WIDTH(DATA_WIDTH),
    .LOOP_FILTER_KP(24'h000042),
    .LOOP_FILTER_KI(24'h000007),
    .M_2_PI(24'h03243f)
) bpsk_demod_inst (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(bpsk_data_in),
    .data_out(bpsk_data_out),
    .nco_i_cosine_lu_angle_steps(demod_cosine_lu_i),
    .nco_q_cosine_lu_angle_steps(demod_cosine_lu_q),
    .nco_carrier_i(demod_nco_carrier_i),
    .nco_carrier_q(demod_nco_carrier_q)
);

endmodule