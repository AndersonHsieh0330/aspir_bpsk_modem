//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Tue Mar  4 17:53:50 2025
//Host        : anderson_xps_15 running 64-bit major release  (build 9200)
//Command     : generate_target axi4_stream_data_fifo.bd
//Design      : axi4_stream_data_fifo
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "axi4_stream_data_fifo,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=axi4_stream_data_fifo,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "axi4_stream_data_fifo.hwdef" *) 
module axi4_stream_data_fifo
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
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_0 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_0, CLK_DOMAIN axi4_stream_data_fifo_m_axis_aclk_0, FREQ_HZ 100000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [31:0]M_AXIS_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_0 TKEEP" *) output [3:0]M_AXIS_0_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_0 TLAST" *) output M_AXIS_0_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_0 TREADY" *) input M_AXIS_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_0 TVALID" *) output M_AXIS_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_0 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_0, CLK_DOMAIN axi4_stream_data_fifo_s_axis_aclk_0, FREQ_HZ 100000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_0 TKEEP" *) input [3:0]S_AXIS_0_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_0 TLAST" *) input S_AXIS_0_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_0 TREADY" *) output S_AXIS_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_0 TVALID" *) input S_AXIS_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.M_AXIS_ACLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.M_AXIS_ACLK_0, ASSOCIATED_BUSIF M_AXIS_0, CLK_DOMAIN axi4_stream_data_fifo_m_axis_aclk_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input m_axis_aclk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.S_AXIS_ACLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.S_AXIS_ACLK_0, ASSOCIATED_BUSIF S_AXIS_0, ASSOCIATED_RESET s_axis_aresetn_0, CLK_DOMAIN axi4_stream_data_fifo_s_axis_aclk_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input s_axis_aclk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.S_AXIS_ARESETN_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.S_AXIS_ARESETN_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input s_axis_aresetn_0;

  wire [31:0]S_AXIS_0_1_TDATA;
  wire [3:0]S_AXIS_0_1_TKEEP;
  wire S_AXIS_0_1_TLAST;
  wire S_AXIS_0_1_TREADY;
  wire S_AXIS_0_1_TVALID;
  wire [31:0]axis_data_fifo_0_M_AXIS_TDATA;
  wire [3:0]axis_data_fifo_0_M_AXIS_TKEEP;
  wire axis_data_fifo_0_M_AXIS_TLAST;
  wire axis_data_fifo_0_M_AXIS_TREADY;
  wire axis_data_fifo_0_M_AXIS_TVALID;
  wire m_axis_aclk_0_1;
  wire s_axis_aclk_0_1;
  wire s_axis_aresetn_0_1;

  assign M_AXIS_0_tdata[31:0] = axis_data_fifo_0_M_AXIS_TDATA;
  assign M_AXIS_0_tkeep[3:0] = axis_data_fifo_0_M_AXIS_TKEEP;
  assign M_AXIS_0_tlast = axis_data_fifo_0_M_AXIS_TLAST;
  assign M_AXIS_0_tvalid = axis_data_fifo_0_M_AXIS_TVALID;
  assign S_AXIS_0_1_TDATA = S_AXIS_0_tdata[31:0];
  assign S_AXIS_0_1_TKEEP = S_AXIS_0_tkeep[3:0];
  assign S_AXIS_0_1_TLAST = S_AXIS_0_tlast;
  assign S_AXIS_0_1_TVALID = S_AXIS_0_tvalid;
  assign S_AXIS_0_tready = S_AXIS_0_1_TREADY;
  assign axis_data_fifo_0_M_AXIS_TREADY = M_AXIS_0_tready;
  assign m_axis_aclk_0_1 = m_axis_aclk_0;
  assign s_axis_aclk_0_1 = s_axis_aclk_0;
  assign s_axis_aresetn_0_1 = s_axis_aresetn_0;
  axi4_stream_data_fifo_axis_data_fifo_0_0 axis_data_fifo_0
       (.m_axis_aclk(m_axis_aclk_0_1),
        .m_axis_tdata(axis_data_fifo_0_M_AXIS_TDATA),
        .m_axis_tkeep(axis_data_fifo_0_M_AXIS_TKEEP),
        .m_axis_tlast(axis_data_fifo_0_M_AXIS_TLAST),
        .m_axis_tready(axis_data_fifo_0_M_AXIS_TREADY),
        .m_axis_tvalid(axis_data_fifo_0_M_AXIS_TVALID),
        .s_axis_aclk(s_axis_aclk_0_1),
        .s_axis_aresetn(s_axis_aresetn_0_1),
        .s_axis_tdata(S_AXIS_0_1_TDATA),
        .s_axis_tkeep(S_AXIS_0_1_TKEEP),
        .s_axis_tlast(S_AXIS_0_1_TLAST),
        .s_axis_tready(S_AXIS_0_1_TREADY),
        .s_axis_tvalid(S_AXIS_0_1_TVALID));
endmodule
