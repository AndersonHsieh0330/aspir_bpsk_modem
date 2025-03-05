/*
    this testbench tests the modulation -> demoduoation with the intermediate number
    conversion to 12b 2s complement supported by the ADC and DAC of choice
*/
`timescale 1ns/1ps
`include "params.vh"
`default_nettype none
module bpsk_modem_test ();

reg  clk, rst_n, bit_data;
wire bit_data_out;
wire signed [11:0] adc_dac;
wire signed [`FIXDT_64_A_WIDTH-1:0] modulator_out;
wire signed [`FIXDT_64_A_WIDTH-1:0] demodulator_data_in;
wire [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] mod_cosine_lu, demod_cosine_lu_i, demod_cosine_lu_q;
wire signed [`FIXDT_64_A_WIDTH-1:0] mod_carrier, demod_nco_carrier_i, demod_nco_carrier_q;
int unsigned INITIAL_PHASE_OFFSET_STEPS = 1235; // [`CARRIER_SAMPLES_PER_PERIOD, 0]

initial begin
    clk <= 1'b0;
    rst_n <= 1'b0;
    bit_data <= 1'b0;
    #15;
    rst_n <= 1'b1;
    for (integer i = 0 ; i < 100 ; i = i + 1) begin
        // toggle 5 times
        #100;
        bit_data <= ~bit_data;
    end
    $finish;
end

always #2.5 clk <= ~clk;

cosine_lut #(
    .READ_PORTS(3)
) cosine_lut_inst (
    .in({mod_cosine_lu+INITIAL_PHASE_OFFSET_STEPS, demod_cosine_lu_i, demod_cosine_lu_q}),
    .out({mod_carrier, demod_nco_carrier_i, demod_nco_carrier_q})
);

bpsk_modulator_top bpsk_modulator_inst (
    .clk(clk),
    .rst_n(rst_n),
    .en(1'b1),
    .in(bit_data),
    .out(modulator_out),
    .cosine_lu(mod_cosine_lu),
    .carrier(mod_carrier)
);

num_convert_tx num_convert_tx_inst (
    .data_in(modulator_out),
    .data_out(adc_dac)
);

num_convert_rx num_convert_rx_inst (
    .data_in(adc_dac),
    .data_out(demodulator_data_in)
);

bpsk_demodulator_top bpsk_demodulator_inst (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(demodulator_data_in),
    .data_out(bit_data_out),
    .nco_i_cosine_lu_angle_steps(demod_cosine_lu_i),
    .nco_q_cosine_lu_angle_steps(demod_cosine_lu_q),
    .nco_carrier_i(demod_nco_carrier_i),
    .nco_carrier_q(demod_nco_carrier_q)
);

endmodule