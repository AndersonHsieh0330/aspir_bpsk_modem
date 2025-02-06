-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Wed Feb  5 18:33:52 2025
-- Host        : anderson_xps_15 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top aspir_bd_top_clk_wiz_0_0 -prefix
--               aspir_bd_top_clk_wiz_0_0_ aspir_bd_top_clk_wiz_0_0_stub.vhdl
-- Design      : aspir_bd_top_clk_wiz_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity aspir_bd_top_clk_wiz_0_0 is
  Port ( 
    clk_out1 : out STD_LOGIC;
    clk_out2 : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end aspir_bd_top_clk_wiz_0_0;

architecture stub of aspir_bd_top_clk_wiz_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,clk_out2,resetn,locked,clk_in1";
begin
end;
