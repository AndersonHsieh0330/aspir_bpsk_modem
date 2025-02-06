-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Wed Feb  5 20:54:40 2025
-- Host        : anderson_xps_15 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/andy1/repos/award-winning-fydp/fpga/gui_mode/bd/aspir_bd_top/ip/aspir_bd_top_modulator_top_wrapper_0_0/aspir_bd_top_modulator_top_wrapper_0_0_sim_netlist.vhdl
-- Design      : aspir_bd_top_modulator_top_wrapper_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity aspir_bd_top_modulator_top_wrapper_0_0 is
  port (
    rst_n : in STD_LOGIC;
    en : in STD_LOGIC;
    data_in : in STD_LOGIC;
    dco : in STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of aspir_bd_top_modulator_top_wrapper_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of aspir_bd_top_modulator_top_wrapper_0_0 : entity is "aspir_bd_top_modulator_top_wrapper_0_0,modulator_top_wrapper,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of aspir_bd_top_modulator_top_wrapper_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of aspir_bd_top_modulator_top_wrapper_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of aspir_bd_top_modulator_top_wrapper_0_0 : entity is "modulator_top_wrapper,Vivado 2019.1";
end aspir_bd_top_modulator_top_wrapper_0_0;

architecture STRUCTURE of aspir_bd_top_modulator_top_wrapper_0_0 is
  signal \^rst_n\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of rst_n : signal is "xilinx.com:signal:reset:1.0 rst_n RST";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of rst_n : signal is "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
  \^rst_n\ <= rst_n;
  data_out(0) <= \^rst_n\;
  data_out(1) <= 'Z';
  data_out(2) <= 'Z';
  data_out(3) <= 'Z';
  data_out(4) <= 'Z';
  data_out(5) <= 'Z';
  data_out(6) <= 'Z';
  data_out(7) <= 'Z';
  data_out(8) <= 'Z';
  data_out(9) <= 'Z';
  data_out(10) <= 'Z';
  data_out(11) <= 'Z';
end STRUCTURE;
