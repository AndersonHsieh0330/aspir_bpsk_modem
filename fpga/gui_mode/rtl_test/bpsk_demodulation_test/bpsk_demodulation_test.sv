`timescale 1ps/1ps
`include "params.svh"
`default_nettype none
module bpsk_demodulation_test ();
// clk gen
reg clk, rst;

reg [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] one_angle, zero_angle;
reg modulated_signal_select; // toggle between 1 and 0
wire signed [`FIXED_PT_WIDTH-1:0] out [0:1]; 
wire [`ADC_BITS-1:0] bpsk_data_in;
wire bpsk_data_out;

initial begin
    clk <= 1'b0;
    rst <= 1'b1;
    modulated_signal_select <= 1'b0;
    #6;
    rst <= 1'b0;
    for (integer i = 0 ; i < 5 ; i = i + 1) begin
        // toggle 5 times
        #60;
        modulated_signal_select <= ~modulated_signal_select;
    end
    $finish;
end

always begin
    #1 clk <= ~clk;
end

always @(posedge clk) begin
    if (rst) begin
        one_angle <= `CARRIER_SAMPLES_PER_PERIOD / 2;
        zero_angle <= {$clog2(`CARRIER_SAMPLES_PER_PERIOD){1'b0}};
    end else begin
        one_angle <= one_angle + `CARRIER_SAMPLES_PER_PERIOD / (`ADC_SAMPLING_FREQ / `CARRIER_FREQ);
        zero_angle <= zero_angle + `CARRIER_SAMPLES_PER_PERIOD / (`ADC_SAMPLING_FREQ / `CARRIER_FREQ);
    end
end

cosine_lut # (
    .READ_PORTS(2)
) cosine_lut_inst (
   .in({zero_angle, one_angle}),
   .out(out) 
);

assign bpsk_data_in = modulated_signal_select?out[1][11:0]:out[0][11:0];

bpsk_demodulator_top bpsk_demod_inst (
    .clk(clk),
    .rst(rst),
    .data_in(bpsk_data_in),
    .data_out(bpsk_data_out)
);

endmodule
