-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Wed Feb  5 18:33:52 2025
-- Host        : anderson_xps_15 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top aspir_bd_top_util_ds_buf_0_2 -prefix
--               aspir_bd_top_util_ds_buf_0_2_ aspir_bd_top_util_ds_buf_0_2_stub.vhdl
-- Design      : aspir_bd_top_util_ds_buf_0_2
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity aspir_bd_top_util_ds_buf_0_2 is
  Port ( 
    IBUF_DS_P : in STD_LOGIC_VECTOR ( 0 to 0 );
    IBUF_DS_N : in STD_LOGIC_VECTOR ( 0 to 0 );
    IBUF_OUT : out STD_LOGIC_VECTOR ( 0 to 0 )
  );

end aspir_bd_top_util_ds_buf_0_2;

architecture stub of aspir_bd_top_util_ds_buf_0_2 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "IBUF_DS_P[0:0],IBUF_DS_N[0:0],IBUF_OUT[0:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "util_ds_buf,Vivado 2019.1";
begin
end;
