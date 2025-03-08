//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Wed Mar  5 14:26:03 2025
//Host        : anderson_xps_15 running 64-bit major release  (build 9200)
//Command     : generate_target axi4_stream_data_fifo_wrapper.bd
//Design      : axi4_stream_data_fifo_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module axi4_stream_data_fifo_wrapper
   (M_AXIS_0_tdata,
    M_AXIS_0_tkeep,
    M_AXIS_0_tlast,
    M_AXIS_0_tready,
    M_AXIS_0_tvalid,
    S_AXIS_0_tdata,
    S_AXIS_0_tkeep,
    S_AXIS_0_tlast,
    S_AXIS_0_tready,
    S_AXIS_0_tvalid,
    m_axis_aclk_0,
    s_axis_aclk_0,
    s_axis_aresetn_0);
  output [31:0]M_AXIS_0_tdata;
  output [3:0]M_AXIS_0_tkeep;
  output M_AXIS_0_tlast;
  input M_AXIS_0_tready;
  output M_AXIS_0_tvalid;
  input [31:0]S_AXIS_0_tdata;
  input [3:0]S_AXIS_0_tkeep;
  input S_AXIS_0_tlast;
  output S_AXIS_0_tready;
  input S_AXIS_0_tvalid;
  input m_axis_aclk_0;
  input s_axis_aclk_0;
  input s_axis_aresetn_0;

  wire [31:0]M_AXIS_0_tdata;
  wire [3:0]M_AXIS_0_tkeep;
  wire M_AXIS_0_tlast;
  wire M_AXIS_0_tready;
  wire M_AXIS_0_tvalid;
  wire [31:0]S_AXIS_0_tdata;
  wire [3:0]S_AXIS_0_tkeep;
  wire S_AXIS_0_tlast;
  wire S_AXIS_0_tready;
  wire S_AXIS_0_tvalid;
  wire m_axis_aclk_0;
  wire s_axis_aclk_0;
  wire s_axis_aresetn_0;

  axi4_stream_data_fifo axi4_stream_data_fifo_i
       (.M_AXIS_0_tdata(M_AXIS_0_tdata),
        .M_AXIS_0_tkeep(M_AXIS_0_tkeep),
        .M_AXIS_0_tlast(M_AXIS_0_tlast),
        .M_AXIS_0_tready(M_AXIS_0_tready),
        .M_AXIS_0_tvalid(M_AXIS_0_tvalid),
        .S_AXIS_0_tdata(S_AXIS_0_tdata),
        .S_AXIS_0_tkeep(S_AXIS_0_tkeep),
        .S_AXIS_0_tlast(S_AXIS_0_tlast),
        .S_AXIS_0_tready(S_AXIS_0_tready),
        .S_AXIS_0_tvalid(S_AXIS_0_tvalid),
        .m_axis_aclk_0(m_axis_aclk_0),
        .s_axis_aclk_0(s_axis_aclk_0),
        .s_axis_aresetn_0(s_axis_aresetn_0));
endmodule
