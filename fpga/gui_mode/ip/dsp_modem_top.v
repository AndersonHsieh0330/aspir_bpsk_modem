`include "params.vh"
module dsp_modem_top (
    // global reset on som, active low
    input wire mod_resetn,
    input wire demod_resetn,

    // -------- RX --------- //
    // adc
    input wire                          adc_dco_clk, // clock from adc that the data is clock out on 
    input wire                          adc_overrange,
    input wire signed [`ADC_BITS/2-1:0] adc_data_in, // 2s complement

    // to pl to ps AXI4-Stream Data FIFO
    // note : the s_axis_aresetn signal is not instantiated here
    // bc we want to let the ps processing reset ip to control the reset 
    // of the AXI4-Stream Data FIFO
    output wire [31:0] pl2ps_fifo_s_axis_tdata,
    output wire [3:0]  pl2ps_fifo_s_axis_tkeep,
    output wire        pl2ps_fifo_s_axis_tlast,
    input  wire        pl2ps_fifo_s_axis_tready,
    output wire        pl2ps_fifo_s_axis_tvalid,

    // -------- TX --------- //
    // dac
    input  wire                        dac_dco_clk, // clock from dac that clocks out the data
    output wire signed [`DAC_BITS-1:0] dac_data_out,

    // from ps to pl AXI4-Stream Data FIFO
    input  wire [31:0] ps2pl_fifo_m_axis_tdata,
    input  wire [3:0]  ps2pl_fifo_m_axis_tkeep,
    input  wire        ps2pl_fifo_m_axis_tlast,
    output wire        ps2pl_fifo_m_axis_tready,
    input  wire        ps2pl_fifo_m_axis_tvalid
);

`ifdef BPSK

// -------- Shared -------- //
wire [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] mod_cosine_lu, demod_cosine_lu_i, demod_cosine_lu_q;
wire signed [`FIXDT_64_A_WIDTH-1:0] mod_carrier, demod_nco_carrier_i, demod_nco_carrier_q;

cosine_lut #(
    .READ_PORTS(3)
) cosine_lut_inst (
    .in({mod_cosine_lu, demod_cosine_lu_i, demod_cosine_lu_q}),
    .out({mod_carrier, demod_nco_carrier_i, demod_nco_carrier_q})
);

// -------- TX -------- //
wire                                modulator_en;
wire                                modulator_in;
wire                                encoded_modulator_in;
wire signed [`FIXDT_64_A_WIDTH-1:0] modulator_out;

axis_fifo_ctrl_ps2pl axis_fifo_ctrl_ps2pl_inst (
    .clk(dac_dco_clk),
    .rst_n(mod_resetn),
    .m_axis_tdata(ps2pl_fifo_m_axis_tdata),
    .m_axis_tkeep(ps2pl_fifo_m_axis_tkeep),
    .m_axis_tlast(ps2pl_fifo_m_axis_tlast),
    .m_axis_tready(ps2pl_fifo_m_axis_tready),
    .m_axis_tvalid(ps2pl_fifo_m_axis_tvalid),
    .data_out_en(modulator_en),
    .data_out(modulator_in)
);

differential_encoder differential_encoder_inst (
    .clk(dac_dco_clk),
    .rst_n(mod_resetn),
    .data_in(modulator_in),
    .data_in(encoded_modulator_in),
);

bpsk_modulator_top bpsk_modulator_inst (
    .clk(dac_dco_clk),
    .rst_n(mod_resetn),
    .en(modulator_en),
    .in(encoded_modulator_in),
    .out(modulator_out),
    .cosine_lu(mod_cosine_lu),
    .carrier(mod_carrier)
);

num_convert_tx num_convert_tx_inst (
    .data_in(modulator_out),
    .data_out(dac_data_out)
);

// -------- RX -------- //
wire signed [`FIXDT_64_A_WIDTH-1:0] demodulator_data_in;
wire                                demodulator_data_out;
wire                                decoded_demodulator_data_out;
wire signed [`ADC_BITS-1:0]         sdr_data;

ddr_to_sdr ddr_to_sdr_inst (
    .clk(adc_dco_clk),
    .rst_n(demod_resetn),
    .data_in(adc_data_in),
    .data_out(sdr_data)
);

num_convert_rx num_convert_rx_inst (
    .data_in(sdr_data),
    .data_out(demodulator_data_in)
);

bpsk_demodulator_top bpsk_demodulator_inst (
    .clk(adc_dco_clk),
    .rst_n(demod_resetn),
    .data_in(demodulator_data_in),
    .data_out(demodulator_data_out),
    .nco_i_cosine_lu_angle_steps(demod_cosine_lu_i),
    .nco_q_cosine_lu_angle_steps(demod_cosine_lu_q),
    .nco_carrier_i(demod_nco_carrier_i),
    .nco_carrier_q(demod_nco_carrier_q)
);

differential_decoder differential_decoder_inst (
    .clk(adc_dco_clk),
    .rst_n(demod_resetn),
    .data_in(demodulator_data_out),
    .data_in(decoded_demodulator_data_out),
);

axis_fifo_ctrl_pl2ps axis_fifo_ctrl_pl2ps_inst (
    .clk(adc_dco_clk),
    .rst_n(demod_resetn),
    .data_in(decoded_demodulator_data_out),
    .s_axis_tdata(pl2ps_fifo_s_axis_tdata),
    .s_axis_tkeep(pl2ps_fifo_s_axis_tkeep),
    .s_axis_tlast(pl2ps_fifo_s_axis_tlast),
    .s_axis_tready(pl2ps_fifo_s_axis_tready),
    .s_axis_tvalid(pl2ps_fifo_s_axis_tvalid)
);

`endif 

endmodule