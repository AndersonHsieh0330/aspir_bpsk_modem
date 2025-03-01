// (c) Copyright 1995-2025 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:user:dsp_modem:1.0
// IP Revision: 11

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "package_project" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module aspir_bd_top_dsp_modem_0_2 (
  mod_resetn,
  demod_resetn,
  adc_dco_clk,
  adc_overrange,
  adc_data_in,
  pl2ps_fifo_s_axis_tdata,
  pl2ps_fifo_s_axis_tkeep,
  pl2ps_fifo_s_axis_tlast,
  pl2ps_fifo_s_axis_tready,
  pl2ps_fifo_s_axis_tvalid,
  dac_dco_clk,
  dac_data_out,
  ps2pl_fifo_m_axis_tdata,
  ps2pl_fifo_m_axis_tkeep,
  ps2pl_fifo_m_axis_tlast,
  ps2pl_fifo_m_axis_tready,
  ps2pl_fifo_m_axis_tvalid
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME mod_resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 mod_resetn RST" *)
input wire mod_resetn;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME demod_resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 demod_resetn RST" *)
input wire demod_resetn;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME adc_dco_clk, FREQ_HZ 250000000, ASSOCIATED_BUSIF pl2ps_fifo_s_axis, ASSOCIATED_RESET demod_resetn, PHASE 0.000, CLK_DOMAIN aspir_bd_top_ADC_DCO_P, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 adc_dco_clk CLK" *)
input wire adc_dco_clk;
input wire adc_overrange;
input wire [5 : 0] adc_data_in;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 pl2ps_fifo_s_axis TDATA" *)
output wire [31 : 0] pl2ps_fifo_s_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 pl2ps_fifo_s_axis TKEEP" *)
output wire [3 : 0] pl2ps_fifo_s_axis_tkeep;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 pl2ps_fifo_s_axis TLAST" *)
output wire pl2ps_fifo_s_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 pl2ps_fifo_s_axis TREADY" *)
input wire pl2ps_fifo_s_axis_tready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME pl2ps_fifo_s_axis, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 250000000, PHASE 0.000, CLK_DOMAIN aspir_bd_top_ADC_DCO_P, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 pl2ps_fifo_s_axis TVALID" *)
output wire pl2ps_fifo_s_axis_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME dac_dco_clk, FREQ_HZ 250000000, ASSOCIATED_BUSIF ps2pl_fifo_m_axis, ASSOCIATED_RESET mod_resetn, PHASE 0.000, CLK_DOMAIN aspir_bd_top_DAC_DCO, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 dac_dco_clk CLK" *)
input wire dac_dco_clk;
output wire [11 : 0] dac_data_out;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 ps2pl_fifo_m_axis TDATA" *)
input wire [31 : 0] ps2pl_fifo_m_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 ps2pl_fifo_m_axis TKEEP" *)
input wire [3 : 0] ps2pl_fifo_m_axis_tkeep;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 ps2pl_fifo_m_axis TLAST" *)
input wire ps2pl_fifo_m_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 ps2pl_fifo_m_axis TREADY" *)
output wire ps2pl_fifo_m_axis_tready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ps2pl_fifo_m_axis, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 250000000, PHASE 0.000, CLK_DOMAIN aspir_bd_top_DAC_DCO, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 ps2pl_fifo_m_axis TVALID" *)
input wire ps2pl_fifo_m_axis_tvalid;

  dsp_modem inst (
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
    .dac_data_out(dac_data_out),
    .ps2pl_fifo_m_axis_tdata(ps2pl_fifo_m_axis_tdata),
    .ps2pl_fifo_m_axis_tkeep(ps2pl_fifo_m_axis_tkeep),
    .ps2pl_fifo_m_axis_tlast(ps2pl_fifo_m_axis_tlast),
    .ps2pl_fifo_m_axis_tready(ps2pl_fifo_m_axis_tready),
    .ps2pl_fifo_m_axis_tvalid(ps2pl_fifo_m_axis_tvalid)
  );
endmodule
