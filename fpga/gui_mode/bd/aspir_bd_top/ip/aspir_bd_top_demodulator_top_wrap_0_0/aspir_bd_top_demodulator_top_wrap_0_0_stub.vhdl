-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Wed Feb  5 20:54:40 2025
-- Host        : anderson_xps_15 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/andy1/repos/award-winning-fydp/fpga/gui_mode/bd/aspir_bd_top/ip/aspir_bd_top_demodulator_top_wrap_0_0/aspir_bd_top_demodulator_top_wrap_0_0_stub.vhdl
-- Design      : aspir_bd_top_demodulator_top_wrap_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity aspir_bd_top_demodulator_top_wrap_0_0 is
  Port ( 
    rst_n : in STD_LOGIC;
    dco : in STD_LOGIC;
    overrange : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    data_out : out STD_LOGIC
  );

end aspir_bd_top_demodulator_top_wrap_0_0;

architecture stub of aspir_bd_top_demodulator_top_wrap_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "rst_n,dco,overrange,data_in[5:0],data_out";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "demodulator_top_wrapper,Vivado 2019.1";
begin
end;
