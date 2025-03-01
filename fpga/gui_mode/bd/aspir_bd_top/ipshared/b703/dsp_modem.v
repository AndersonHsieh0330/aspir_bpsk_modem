/*
    This module is just a wrapper for vivado packaging IP
    if you need to make changes to this file, make sure
    there is no flattened logic in this module level.
    put any logic you need to instantiate inside of the module
    that is under the /ip directory.

    Also demodulator and modulator are grouped because they 
    have to share a cosine LUT, and it's just easier to 
    instantiate it in the same verilog module instead of
    having to package it in vivado IP package flow and 
    instantiate it as a block design
*/
`include "params.vh"
module dsp_modem (
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
    input  wire                 dac_dco_clk, // clock from dac that clocks out the data
    output wire [`DAC_BITS-1:0] dac_data_out,

    // from ps to pl AXI4-Stream Data FIFO
    input  wire [31:0] ps2pl_fifo_m_axis_tdata,
    input  wire [3:0]  ps2pl_fifo_m_axis_tkeep,
    input  wire        ps2pl_fifo_m_axis_tlast,
    output wire        ps2pl_fifo_m_axis_tready,
    input  wire        ps2pl_fifo_m_axis_tvalid
);

dsp_modem_top dsp_modem_top_inst (
    .mod_resetn(mod_resetn),
    .demod_resetn(demod_resetn),

    // -------- RX --------- //
    // adc
    .adc_dco_clk(adc_dco_clk),
    .adc_overrange(adc_overrange),
    .adc_data_in(adc_data_in),

    // to pl2ps AXI4-Stream Data FIFO
    .pl2ps_fifo_s_axis_tdata(pl2ps_fifo_s_axis_tdata),
    .pl2ps_fifo_s_axis_tkeep(pl2ps_fifo_s_axis_tkeep),
    .pl2ps_fifo_s_axis_tlast(pl2ps_fifo_s_axis_tlast),
    .pl2ps_fifo_s_axis_tready(pl2ps_fifo_s_axis_tready),
    .pl2ps_fifo_s_axis_tvalid(pl2ps_fifo_s_axis_tvalid),

    // -------- TX --------- //
    // dac
    .dac_dco_clk(dac_dco_clk),
    .dac_data_out(dac_data_out),

    // from ps2pl AXI4-Stream Data FIFO
    .ps2pl_fifo_m_axis_tdata(ps2pl_fifo_m_axis_tdata),
    .ps2pl_fifo_m_axis_tkeep(ps2pl_fifo_m_axis_tkeep),
    .ps2pl_fifo_m_axis_tlast(ps2pl_fifo_m_axis_tlast),
    .ps2pl_fifo_m_axis_tready(ps2pl_fifo_m_axis_tready),
    .ps2pl_fifo_m_axis_tvalid(ps2pl_fifo_m_axis_tvalid)
);

endmodule