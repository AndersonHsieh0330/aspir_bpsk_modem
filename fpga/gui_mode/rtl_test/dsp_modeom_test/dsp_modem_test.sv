// main purpose of this tb is just to make sure dsp_modem_top compiles and elaborates without error
`include "params.vh"
module dsp_modem_test ();

reg mod_resetn;
reg demod_resetn;

wire adc_dco_clk;
wire adc_overrange;
wire signed [`ADC_BITS/2-1:0] adc_data_in;

wire [31:0] pl2ps_fifo_s_axis_tdata;
wire [3:0]  pl2ps_fifo_s_axis_tkeep;
wire        pl2ps_fifo_s_axis_tlast;
wire        pl2ps_fifo_s_axis_tready;
wire        pl2ps_fifo_s_axis_tvalid;

wire                        dac_dco_clk;
wire signed [`DAC_BITS-1:0] dac_data_out;

wire [31:0] ps2pl_fifo_m_axis_tdata;
wire [3:0]  ps2pl_fifo_m_axis_tkeep;
wire        ps2pl_fifo_m_axis_tlast;
wire        ps2pl_fifo_m_axis_tready;
wire        ps2pl_fifo_m_axis_tvalid;

initial begin
    mod_resetn <= 1'b0;
    demod_resetn <= 1'b0;
    #100;
end

dsp_modem_top dsp_modem_top_inst (
    .mod_resetn(mod_resetn),
    .demod_resetn(demod_resetn),
    .adc_dco_clk(adc_dco_clk), 
    .adc_overrange(adc_overrange),
    .adc_data_in(adc_data_in),
    .pl2ps_fifo_s_axis_tdata(pl2ps_fifo_s_axis_tdata),
    .pl2ps_fifo_s_axis_tkeep(pl2ps_fifo_s_axis_tkeep),
    .pl2ps_fifo_s_axis_tlast(pl2ps_fifo_s_axis_tlast),
    .pl2ps_fifo_s_axis_tready(pl2ps_fifo_s_axis_tready),
    .pl2ps_fifo_s_axis_tvalid(pl2ps_fifo_s_axis_tvalid),
    .dac_dco_clk(dac_dco_clk), 
    . dac_data_out(dac_data_out),
    .ps2pl_fifo_m_axis_tdata(ps2pl_fifo_m_axis_tdata),
    .ps2pl_fifo_m_axis_tkeep(ps2pl_fifo_m_axis_tkeep),
    .ps2pl_fifo_m_axis_tlast(ps2pl_fifo_m_axis_tlast),
    .ps2pl_fifo_m_axis_tready(ps2pl_fifo_m_axis_tready),
    .ps2pl_fifo_m_axis_tvalid(ps2pl_fifo_m_axis_tvalid)
);

endmodule
