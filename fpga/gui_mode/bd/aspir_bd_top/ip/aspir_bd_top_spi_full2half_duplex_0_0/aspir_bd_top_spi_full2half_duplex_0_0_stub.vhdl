-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Thu Feb  6 00:19:08 2025
-- Host        : anderson_xps_15 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/andy1/repos/award-winning-fydp/fpga/gui_mode/bd/aspir_bd_top/ip/aspir_bd_top_spi_full2half_duplex_0_0/aspir_bd_top_spi_full2half_duplex_0_0_stub.vhdl
-- Design      : aspir_bd_top_spi_full2half_duplex_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity aspir_bd_top_spi_full2half_duplex_0_0 is
  Port ( 
    sclk_in : in STD_LOGIC;
    ss_in : in STD_LOGIC;
    mosi_in : in STD_LOGIC;
    miso_in : out STD_LOGIC;
    sclk_out : out STD_LOGIC;
    ss_out : out STD_LOGIC;
    sdio_out : inout STD_LOGIC
  );

end aspir_bd_top_spi_full2half_duplex_0_0;

architecture stub of aspir_bd_top_spi_full2half_duplex_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "sclk_in,ss_in,mosi_in,miso_in,sclk_out,ss_out,sdio_out";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "spi_full2half_duplex,Vivado 2019.1";
begin
end;
