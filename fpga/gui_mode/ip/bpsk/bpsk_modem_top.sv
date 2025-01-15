`include "params.svh"
`default_nettype none
module bpsk_modem_top (
    input  wire                 clk,
    input  wire                 rst,
    
    // demodulator
    input  wire [`ADC_BITS-1:0] adc_in, // input from adc
    output wire                 bit_data_out,

    // modulator
    input  wire                 bit_data_in,
    input  wire                 bit_data_in_en,
    output wire [`ADC_BITS-1:0] dac_out // output to dac
);

bpsk_demodulator_top bpsk_demodulator_inst (
    .clk(clk),
    .rst(rst),
    .data_in(adc_in),
    .data_out(bit_data_out)
);

bpsk_modulator_top bpsk_modulator_inst (
    .clk(clk),
    .rst(rst),
    .en(bit_data_in_en),
    .in(bit_data_in),
    .out(dac_out)
);

endmodule