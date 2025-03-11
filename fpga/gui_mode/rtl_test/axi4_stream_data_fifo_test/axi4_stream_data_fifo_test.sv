`include "params.vh"
module axi4_stream_data_fifo_test ();
// input to fifo (from demod)
wire [31:0] m_axis_tdata;
wire [3:0]  m_axis_tkeep;
wire        m_axis_tlast;
wire        m_axis_tready;
wire        m_axis_tvalid;
reg         in_clk;
reg         aresetn;
reg         demod_data_out;

// output of fifo (to mod)
wire [31:0] s_axis_tdata;
wire [3:0]  s_axis_tkeep;
wire        s_axis_tlast;
wire        s_axis_tready;
wire        s_axis_tvalid;
reg         out_clk;
wire        mod_data_in;
wire        mod_data_en;

parameter SFD = `ETHERNET_SFD;
parameter DATA1 = 32'h76543210;
parameter DATA2 = 32'hfedcba98;

initial begin
    // reset and initialize
    aresetn = 1'b0;
    in_clk = 1'b0;
    out_clk = 1'b0;
    demod_data_out <= 1'b0;
    #130;
    aresetn = 1'b1;
    #10;

    // first write transaction
    // send 8 bit preamble
    for(integer i = 0 ; i < 8 ; i = i + 1) begin
        demod_data_out = SFD[7-i];
        #10;
    end

    // send the 32 bit data
    for(integer i = 0 ; i < 32 ; i = i + 1) begin
        demod_data_out = DATA1[i];
        #10;
    end

    // wait for m_axis_tready to go high
    #260

    // second write transaction
    // send 8 bit preamble
    for(integer i = 0 ; i < 8 ; i = i + 1) begin
        demod_data_out = SFD[7-i];
        #10;
    end

    // send the 32 bit data
    for(integer i = 0 ; i < 32 ; i = i + 1) begin
        demod_data_out = DATA2[i];
        #10;
    end

    // wait for m_axis_tready to go high
    #260

    // read transaction, ping pong and stream out the 64 bits
    #1664;

    // third write transaction, test single transaction write + read 
    // no ping pong
    // send 8 bit preamble
    for(integer i = 0 ; i < 8 ; i = i + 1) begin
        demod_data_out = SFD[7-i];
        #10;
    end

    // send the 32 bit data
    for(integer i = 0 ; i < 32 ; i = i + 1) begin
        demod_data_out = DATA1[i];
        #10;
    end

    // read transaction, stream out the 32 bits
    #1200;

    $finish();
end

// clock gen, different frequency
always begin
    #5 in_clk <= ~in_clk;
end

always begin
    #13 out_clk <= ~out_clk;
end

axis_fifo_ctrl_pl2ps axis_fifo_ctrl_pl2ps_inst (
    .clk(in_clk),
    .rst_n(aresetn),
    .data_in(demod_data_out),
    .m_axis_tdata(m_axis_tdata),
    .m_axis_tkeep(m_axis_tkeep),
    .m_axis_tlast(m_axis_tlast),
    .m_axis_tready(m_axis_tready),
    .m_axis_tvalid(m_axis_tvalid)
);

axis_fifo_ctrl_ps2pl axis_fifo_ctrl_ps2pl_inst (
    .clk(out_clk),
    .rst_n(aresetn),
    .s_axis_tdata(s_axis_tdata),
    .s_axis_tkeep(s_axis_tkeep),
    .s_axis_tlast(s_axis_tlast),
    .s_axis_tready(s_axis_tready),
    .s_axis_tvalid(s_axis_tvalid),
    .data_out_en(mod_data_en),
    .data_out(mod_data_in)
);

axi4_stream_data_fifo_wrapper axi4_stream_data_fifo_inst (
    // input to fifo
    .s_axis_aclk_0(in_clk),
    .s_axis_aresetn_0(aresetn),
    .S_AXIS_0_tdata(m_axis_tdata),
    .S_AXIS_0_tkeep(m_axis_tkeep),
    .S_AXIS_0_tlast(m_axis_tlast),
    .S_AXIS_0_tready(m_axis_tready),
    .S_AXIS_0_tvalid(m_axis_tvalid),

    // output of fifo
    .M_AXIS_0_tdata(s_axis_tdata),
    .M_AXIS_0_tkeep(s_axis_tkeep),
    .M_AXIS_0_tlast(s_axis_tlast),
    .M_AXIS_0_tready(s_axis_tready),
    .M_AXIS_0_tvalid(s_axis_tvalid),
    .m_axis_aclk_0(out_clk)
);

endmodule