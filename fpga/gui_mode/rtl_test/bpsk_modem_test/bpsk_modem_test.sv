`timescale 1ns/1ps
`include "params.svh"
`default_nettype none
module bpsk_modem_test ();

reg  clk, rst, bit_data;
wire bit_data_out;
wire signed [`ADC_BITS-1:0] adc_dac;

initial begin
    clk <= 1'b0;
    rst <= 1'b1;
    bit_data <= 1'b0;
    #15;
    rst <= 1'b0;
    for (integer i = 0 ; i < 10 ; i = i + 1) begin
        // toggle 5 times
        #100;
        bit_data <= ~bit_data;
    end
    $finish;
end

always #2.5 clk <= ~clk;

bpsk_modem_top bpsk_modem_inst (
    .clk(clk),
    .rst(rst),
    .adc_in(adc_dac),
    .bit_data_in(bit_data),
    .bit_data_in_en(1'b1),
    .bit_data_out(bit_data_out),
    .dac_out(adc_dac)
);

endmodule