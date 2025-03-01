-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sat Mar  1 00:27:32 2025
-- Host        : anderson_xps_15 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top aspir_bd_top_reset_synchronizer_0_1 -prefix
--               aspir_bd_top_reset_synchronizer_0_1_ aspir_bd_top_reset_synchronizer_0_0_sim_netlist.vhdl
-- Design      : aspir_bd_top_reset_synchronizer_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity aspir_bd_top_reset_synchronizer_0_1 is
  port (
    target_clk : in STD_LOGIC;
    async_resetn : in STD_LOGIC;
    sync_resetn : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of aspir_bd_top_reset_synchronizer_0_1 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of aspir_bd_top_reset_synchronizer_0_1 : entity is "aspir_bd_top_reset_synchronizer_0_0,reset_synchronizer,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of aspir_bd_top_reset_synchronizer_0_1 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of aspir_bd_top_reset_synchronizer_0_1 : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of aspir_bd_top_reset_synchronizer_0_1 : entity is "reset_synchronizer,Vivado 2019.1";
end aspir_bd_top_reset_synchronizer_0_1;

architecture STRUCTURE of aspir_bd_top_reset_synchronizer_0_1 is
  signal \<const0>\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of async_resetn : signal is "xilinx.com:signal:reset:1.0 async_resetn RST";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of async_resetn : signal is "XIL_INTERFACENAME async_resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of sync_resetn : signal is "xilinx.com:signal:reset:1.0 sync_resetn RST";
  attribute X_INTERFACE_PARAMETER of sync_resetn : signal is "XIL_INTERFACENAME sync_resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of target_clk : signal is "xilinx.com:signal:clock:1.0 target_clk CLK";
  attribute X_INTERFACE_PARAMETER of target_clk : signal is "XIL_INTERFACENAME target_clk, FREQ_HZ 250000000, ASSOCIATED_BUSIF sync_resetn, ASSOCIATED_RESET sync_resetn, PHASE 0.000, CLK_DOMAIN aspir_bd_top_ADC_DCO_P, INSERT_VIP 0";
begin
  sync_resetn <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
end STRUCTURE;
