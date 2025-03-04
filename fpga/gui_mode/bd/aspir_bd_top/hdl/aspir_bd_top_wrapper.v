//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Sat Mar  1 03:30:19 2025
//Host        : anderson_xps_15 running 64-bit major release  (build 9200)
//Command     : generate_target aspir_bd_top_wrapper.bd
//Design      : aspir_bd_top_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module aspir_bd_top_wrapper
   (ADC_CLK_N,
    ADC_CLK_P,
    ADC_DATA_0_N,
    ADC_DATA_0_P,
    ADC_DATA_1_N,
    ADC_DATA_1_P,
    ADC_DATA_2_N,
    ADC_DATA_2_P,
    ADC_DATA_3_N,
    ADC_DATA_3_P,
    ADC_DATA_4_N,
    ADC_DATA_4_P,
    ADC_DATA_5_N,
    ADC_DATA_5_P,
    ADC_DCO_N,
    ADC_DCO_P,
    ADC_OVERRANGE_N,
    ADC_OVERRANGE_P,
    ADC_SPI_SCLK,
    ADC_SPI_SDIO,
    ADC_SPI_SS,
    CLK_50MHZ,
    DAC_CLK_N,
    DAC_CLK_P,
    DAC_DATA,
    DAC_DCO,
    DAC_SPI_MISO,
    DAC_SPI_MOSI,
    DAC_SPI_SCLK,
    DAC_SPI_SS,
    DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    GRST_N);
  output [0:0]ADC_CLK_N;
  output [0:0]ADC_CLK_P;
  input ADC_DATA_0_N;
  input ADC_DATA_0_P;
  input ADC_DATA_1_N;
  input ADC_DATA_1_P;
  input ADC_DATA_2_N;
  input ADC_DATA_2_P;
  input ADC_DATA_3_N;
  input ADC_DATA_3_P;
  input ADC_DATA_4_N;
  input ADC_DATA_4_P;
  input ADC_DATA_5_N;
  input ADC_DATA_5_P;
  input ADC_DCO_N;
  input ADC_DCO_P;
  input ADC_OVERRANGE_N;
  input ADC_OVERRANGE_P;
  output ADC_SPI_SCLK;
  inout ADC_SPI_SDIO;
  output ADC_SPI_SS;
  input CLK_50MHZ;
  output [0:0]DAC_CLK_N;
  output [0:0]DAC_CLK_P;
  output [11:0]DAC_DATA;
  input DAC_DCO;
  input DAC_SPI_MISO;
  output DAC_SPI_MOSI;
  output DAC_SPI_SCLK;
  output DAC_SPI_SS;
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input GRST_N;

  wire [0:0]ADC_CLK_N;
  wire [0:0]ADC_CLK_P;
  wire ADC_DATA_0_N;
  wire ADC_DATA_0_P;
  wire ADC_DATA_1_N;
  wire ADC_DATA_1_P;
  wire ADC_DATA_2_N;
  wire ADC_DATA_2_P;
  wire ADC_DATA_3_N;
  wire ADC_DATA_3_P;
  wire ADC_DATA_4_N;
  wire ADC_DATA_4_P;
  wire ADC_DATA_5_N;
  wire ADC_DATA_5_P;
  wire ADC_DCO_N;
  wire ADC_DCO_P;
  wire ADC_OVERRANGE_N;
  wire ADC_OVERRANGE_P;
  wire ADC_SPI_SCLK;
  wire ADC_SPI_SDIO;
  wire ADC_SPI_SS;
  wire CLK_50MHZ;
  wire [0:0]DAC_CLK_N;
  wire [0:0]DAC_CLK_P;
  wire [11:0]DAC_DATA;
  wire DAC_DCO;
  wire DAC_SPI_MISO;
  wire DAC_SPI_MOSI;
  wire DAC_SPI_SCLK;
  wire DAC_SPI_SS;
  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire GRST_N;

  aspir_bd_top aspir_bd_top_i
       (.ADC_CLK_N(ADC_CLK_N),
        .ADC_CLK_P(ADC_CLK_P),
        .ADC_DATA_0_N(ADC_DATA_0_N),
        .ADC_DATA_0_P(ADC_DATA_0_P),
        .ADC_DATA_1_N(ADC_DATA_1_N),
        .ADC_DATA_1_P(ADC_DATA_1_P),
        .ADC_DATA_2_N(ADC_DATA_2_N),
        .ADC_DATA_2_P(ADC_DATA_2_P),
        .ADC_DATA_3_N(ADC_DATA_3_N),
        .ADC_DATA_3_P(ADC_DATA_3_P),
        .ADC_DATA_4_N(ADC_DATA_4_N),
        .ADC_DATA_4_P(ADC_DATA_4_P),
        .ADC_DATA_5_N(ADC_DATA_5_N),
        .ADC_DATA_5_P(ADC_DATA_5_P),
        .ADC_DCO_N(ADC_DCO_N),
        .ADC_DCO_P(ADC_DCO_P),
        .ADC_OVERRANGE_N(ADC_OVERRANGE_N),
        .ADC_OVERRANGE_P(ADC_OVERRANGE_P),
        .ADC_SPI_SCLK(ADC_SPI_SCLK),
        .ADC_SPI_SDIO(ADC_SPI_SDIO),
        .ADC_SPI_SS(ADC_SPI_SS),
        .CLK_50MHZ(CLK_50MHZ),
        .DAC_CLK_N(DAC_CLK_N),
        .DAC_CLK_P(DAC_CLK_P),
        .DAC_DATA(DAC_DATA),
        .DAC_DCO(DAC_DCO),
        .DAC_SPI_MISO(DAC_SPI_MISO),
        .DAC_SPI_MOSI(DAC_SPI_MOSI),
        .DAC_SPI_SCLK(DAC_SPI_SCLK),
        .DAC_SPI_SS(DAC_SPI_SS),
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .GRST_N(GRST_N));
endmodule
