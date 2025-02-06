// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Wed Feb  5 20:54:40 2025
// Host        : anderson_xps_15 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/andy1/repos/award-winning-fydp/fpga/gui_mode/bd/aspir_bd_top/ip/aspir_bd_top_demodulator_top_wrap_0_0/aspir_bd_top_demodulator_top_wrap_0_0_stub.v
// Design      : aspir_bd_top_demodulator_top_wrap_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "demodulator_top_wrapper,Vivado 2019.1" *)
module aspir_bd_top_demodulator_top_wrap_0_0(rst_n, dco, overrange, data_in, data_out)
/* synthesis syn_black_box black_box_pad_pin="rst_n,dco,overrange,data_in[5:0],data_out" */;
  input rst_n;
  input dco;
  input overrange;
  input [5:0]data_in;
  output data_out;
endmodule
