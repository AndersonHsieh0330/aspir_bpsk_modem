`timescale 1ps/1ps
`include "params.vh"
module bpsk_demodulation_test ();
// clk gen
reg clk;
assign #1 clk = ~clk;

reg [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] one_angle, zero_angle;
reg modulated_signal_select; // toggle between 1 and 0

initial begin
    clk <= 1'b0;
    rst <= 1'b1;
    modulated_signal_select <= 1'b0;
    #6;
    rst <= 1'b0;
    for (integer i = 0 ; i < 5 ; i = i + 1) begin
        // toggle 5 times
        #6;
        modulated_signal_select <= ~modulated_signal_select;
    end
    $finish
end

always @(posedge clk) begin
    if (rst) begin
        one_angle <= `CARRIER_SAMPLES_PER_PERIOD / (`CARRIER_FREQ / `ADC_SAMPLING_FREQ) / 2;
        zero_angle <= {$clog2(`CARRIER_SAMPLES_PER_PERIOD){1'b0}};
    end else begin
        one_angle <= one_angle + `CARRIER_SAMPLES_PER_PERIOD / (`CARRIER_FREQ / `ADC_SAMPLING_FREQ);
        zero_angle <= zero_angle + `CARRIER_SAMPLES_PER_PERIOD / (`CARRIER_FREQ / `ADC_SAMPLING_FREQ);
    end
end

wire signed [`FIXED_PT_WIDTH-1:0] one_out, zero_out; 
wire bpsk_data_out;
cosine_lut cosine_lut_inst #(
    .READ_PORTS(2)
) (
   .in({one_angle, zero_angle}),
   .out({one_out, zero_out}) 
);

bpsk_demodulator_top bpsk_demod_inst (
    .clk(clk),
    .rst(rst),
    .data_in(modulated_signal_select?one_out[17:6]:zero_out[17:6]),
    .data_out(bpsk_data_out)
);

endmodule