`timescale 10ns/10ns
`include "params.vh"
`default_nettype none
module bpsk_demodulation_test ();

reg clk, rst;
reg [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] lu_angle;
reg modulated_signal_select; // toggle between 1 and 0
wire signed   [`FIXDT_64_A_WIDTH-1:0] out [0:0];
wire signed   [`FIXDT_64_A_WIDTH-1:0] bpsk_data_in;
wire unsigned                         bpsk_data_out;

// generate random phase offset and convert to radians for easy comparison in waveform viewer
int unsigned INITIAL_PHASE_OFFSET_STEPS = 1235; // [`CARRIER_SAMPLES_PER_PERIOD, 0]
real M_2_PI = 6.283185307179586476925286766559;
real TOTAL_STEPS = `CARRIER_SAMPLES_PER_PERIOD-1;
real INITIAL_PHASE_OFFSET_RADS = (INITIAL_PHASE_OFFSET_STEPS / TOTAL_STEPS) * M_2_PI;

initial begin
    clk <= 1'b1;
    rst <= 1'b1;
    modulated_signal_select <= 1'b0;
    #100;
    rst <= 1'b0;
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
    if (rst) begin
        lu_angle <= {$clog2(`CARRIER_SAMPLES_PER_PERIOD){1'b0}} + INITIAL_PHASE_OFFSET_STEPS;
    end else begin
        lu_angle <= lu_angle + `CARRIER_SAMPLES_PER_PERIOD / (`SAMPLING_FREQ / `CARRIER_FREQ);
    end
end

cosine_lut # (
    .READ_PORTS(1)
) cosine_lut_inst (
   .in({lu_angle}),
   .out(out) 
);

assign bpsk_data_in = modulated_signal_select? -1*out[0] : out[0];

bpsk_demodulator_top bpsk_demod_inst (
    .clk(clk),
    .rst(rst),
    .data_in(bpsk_data_in),
    .data_out(bpsk_data_out)
);

endmodule