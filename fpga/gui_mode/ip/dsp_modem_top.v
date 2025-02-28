`include "params.vh"
module dsp_modem_top (
    // global reset on som, active low
    input wire rst_n,

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
    input  wire                 dac_dco_clk, // clock from dac that clocks out the data
    output wire [`DAC_BITS-1:0] dac_data_out,

    // from ps to pl AXI4-Stream Data FIFO
    input  wire [31:0] ps2pl_fifo_m_axis_tdata,
    input  wire [3:0]  ps2pl_fifo_m_axis_tkeep,
    input  wire        ps2pl_fifo_m_axis_tlast,
    output wire        ps2pl_fifo_m_axis_tready,
    input  wire        ps2pl_fifo_m_axis_tvalid
);

`ifdef BPSK

// TODO : make modulator and demodulator share a cosine lut!!

// -------- TX -------- //
wire                         modulator_en;
wire                         modulator_in;
wire [`FIXDT_64_A_WIDTH-1:0] modulator_out;

// TODO : FIXDT_64_A to 12 bit 2s complement!
assign dac_data_out = modulator_out[`DAC_BITS:0];

ps2pl_stream_ctrl ps2pl_stream_ctrl_inst (
    .clk(dac_dco_clk),
    .rst_n(rst_n),
    .m_axis_tdata(ps2pl_fifo_m_axis_tdata),
    .m_axis_tkeep(ps2pl_fifo_m_axis_tkeep),
    .m_axis_tlast(ps2pl_fifo_m_axis_tlast),
    .m_axis_tready(ps2pl_fifo_m_axis_tready),
    .m_axis_tvalid(ps2pl_fifo_m_axis_tvalid),
    .data_out_en(modulator_en),
    .data_out(modulator_in)
);

bpsk_modulator_top bpsk_modulator_inst (
    .clk(dac_dco_clk),
    .rst_n(rst_n),
    .en(modulator_en),
    .in(modulator_in),
    .out(modulator_out)
);

// -------- RX -------- //
wire [`FIXDT_64_A_WIDTH-1:0] demodulator_data_in;
wire                         demodulator_data_out;

// TODO : 12 bit 2s complement from adc to FIXDT_64_A
assign demodulator_data_in = 64'b0;

bpsk_demodulator_top bpsk_demodulatorinst (
    .clk(adc_dco_clk),
    .rst_n(rst_n),
    .data_in(demodulator_data_in),
    .data_out(demodulator_data_out)
);

pl2ps_stream_ctrl pl2ps_stream_ctrl_inst (
    .clk(adc_dco_clk),
    .rst_n(rst_n),
    .data_in(demodulator_data_out),
    .s_axis_tdata(pl2ps_fifo_s_axis_tdata),
    .s_axis_tkeep(pl2ps_fifo_s_axis_tkeep),
    .s_axis_tlast(pl2ps_fifo_s_axis_tlast),
    .s_axis_tready(pl2ps_fifo_s_axis_tready),
    .s_axis_tvalid(pl2ps_fifo_s_axis_tvalid)
);
`endif 

endmodule