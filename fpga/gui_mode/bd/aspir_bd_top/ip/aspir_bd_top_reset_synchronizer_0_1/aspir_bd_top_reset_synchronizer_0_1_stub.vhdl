-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sat Mar  1 00:27:32 2025
-- Host        : anderson_xps_15 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top aspir_bd_top_reset_synchronizer_0_1 -prefix
--               aspir_bd_top_reset_synchronizer_0_1_ aspir_bd_top_reset_synchronizer_0_0_stub.vhdl
-- Design      : aspir_bd_top_reset_synchronizer_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity aspir_bd_top_reset_synchronizer_0_1 is
  Port ( 
    target_clk : in STD_LOGIC;
    async_resetn : in STD_LOGIC;
    sync_resetn : out STD_LOGIC
  );

end aspir_bd_top_reset_synchronizer_0_1;

architecture stub of aspir_bd_top_reset_synchronizer_0_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "target_clk,async_resetn,sync_resetn";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "reset_synchronizer,Vivado 2019.1";
begin
end;
