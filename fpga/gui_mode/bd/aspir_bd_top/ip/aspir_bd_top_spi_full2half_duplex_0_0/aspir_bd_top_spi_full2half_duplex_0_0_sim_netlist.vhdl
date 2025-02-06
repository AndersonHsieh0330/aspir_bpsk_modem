-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Thu Feb  6 00:19:08 2025
-- Host        : anderson_xps_15 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/andy1/repos/award-winning-fydp/fpga/gui_mode/bd/aspir_bd_top/ip/aspir_bd_top_spi_full2half_duplex_0_0/aspir_bd_top_spi_full2half_duplex_0_0_sim_netlist.vhdl
-- Design      : aspir_bd_top_spi_full2half_duplex_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity aspir_bd_top_spi_full2half_duplex_0_0 is
  port (
    sclk_in : in STD_LOGIC;
    ss_in : in STD_LOGIC;
    mosi_in : in STD_LOGIC;
    miso_in : out STD_LOGIC;
    sclk_out : out STD_LOGIC;
    ss_out : out STD_LOGIC;
    sdio_out : inout STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of aspir_bd_top_spi_full2half_duplex_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of aspir_bd_top_spi_full2half_duplex_0_0 : entity is "aspir_bd_top_spi_full2half_duplex_0_0,spi_full2half_duplex,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of aspir_bd_top_spi_full2half_duplex_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of aspir_bd_top_spi_full2half_duplex_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of aspir_bd_top_spi_full2half_duplex_0_0 : entity is "spi_full2half_duplex,Vivado 2019.1";
end aspir_bd_top_spi_full2half_duplex_0_0;

architecture STRUCTURE of aspir_bd_top_spi_full2half_duplex_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^sclk_in\ : STD_LOGIC;
  signal \^ss_in\ : STD_LOGIC;
begin
  \^sclk_in\ <= sclk_in;
  \^ss_in\ <= ss_in;
  sclk_out <= \^sclk_in\;
  ss_out <= \^ss_in\;
  miso_in <= 'Z';
GND: unisim.vcomponents.GND
     port map (
      G => sdio_out
    );
end STRUCTURE;
