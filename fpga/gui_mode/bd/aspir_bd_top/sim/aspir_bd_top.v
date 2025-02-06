//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Thu Feb  6 04:48:44 2025
//Host        : anderson_xps_15 running 64-bit major release  (build 9200)
//Command     : generate_target aspir_bd_top.bd
//Design      : aspir_bd_top
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "aspir_bd_top,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=aspir_bd_top,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=16,numReposBlks=16,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=3,numPkgbdBlks=0,bdsource=USER,da_axi4_cnt=4,da_ps7_cnt=1,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "aspir_bd_top.hwdef" *) 
module aspir_bd_top
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ADC_CLK_N CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ADC_CLK_N, CLK_DOMAIN /clk_wiz_0_clk_out1, FREQ_HZ 250000000, INSERT_VIP 0, PHASE 0.0" *) output [0:0]ADC_CLK_N;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ADC_CLK_P CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ADC_CLK_P, CLK_DOMAIN /clk_wiz_0_clk_out1, FREQ_HZ 250000000, INSERT_VIP 0, PHASE 0.0" *) output [0:0]ADC_CLK_P;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_DATA_0_N DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_DATA_0_N, LAYERED_METADATA undef" *) input ADC_DATA_0_N;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_DATA_0_P DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_DATA_0_P, LAYERED_METADATA undef" *) input ADC_DATA_0_P;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_DATA_1_N DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_DATA_1_N, LAYERED_METADATA undef" *) input ADC_DATA_1_N;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_DATA_1_P DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_DATA_1_P, LAYERED_METADATA undef" *) input ADC_DATA_1_P;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_DATA_2_N DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_DATA_2_N, LAYERED_METADATA undef" *) input ADC_DATA_2_N;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_DATA_2_P DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_DATA_2_P, LAYERED_METADATA undef" *) input ADC_DATA_2_P;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_DATA_3_N DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_DATA_3_N, LAYERED_METADATA undef" *) input ADC_DATA_3_N;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_DATA_3_P DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_DATA_3_P, LAYERED_METADATA undef" *) input ADC_DATA_3_P;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_DATA_4_N DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_DATA_4_N, LAYERED_METADATA undef" *) input ADC_DATA_4_N;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_DATA_4_P DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_DATA_4_P, LAYERED_METADATA undef" *) input ADC_DATA_4_P;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_DATA_5_N DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_DATA_5_N, LAYERED_METADATA undef" *) input ADC_DATA_5_N;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_DATA_5_P DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_DATA_5_P, LAYERED_METADATA undef" *) input ADC_DATA_5_P;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ADC_DCO_N CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ADC_DCO_N, CLK_DOMAIN aspir_bd_top_ADC_DCO_N, FREQ_HZ 250000000, INSERT_VIP 0, PHASE 0.000" *) input ADC_DCO_N;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ADC_DCO_P CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ADC_DCO_P, CLK_DOMAIN aspir_bd_top_ADC_DCO_P, FREQ_HZ 250000000, INSERT_VIP 0, PHASE 0.000" *) input ADC_DCO_P;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_OVERRANGE_N DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_OVERRANGE_N, LAYERED_METADATA undef" *) input ADC_OVERRANGE_N;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_OVERRANGE_P DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_OVERRANGE_P, LAYERED_METADATA undef" *) input ADC_OVERRANGE_P;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ADC_SPI_SCLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ADC_SPI_SCLK, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) output ADC_SPI_SCLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ADC_SPI_SDIO DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ADC_SPI_SDIO, LAYERED_METADATA undef" *) inout ADC_SPI_SDIO;
  output ADC_SPI_SS;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_50MHZ CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_50MHZ, CLK_DOMAIN aspir_bd_top_CLK_50MHZ, FREQ_HZ 50000000, INSERT_VIP 0, PHASE 0.000" *) input CLK_50MHZ;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.DAC_CLK_N CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.DAC_CLK_N, CLK_DOMAIN /clk_wiz_0_clk_out1, FREQ_HZ 250000000, INSERT_VIP 0, PHASE 0.0" *) output [0:0]DAC_CLK_N;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.DAC_CLK_P CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.DAC_CLK_P, CLK_DOMAIN /clk_wiz_0_clk_out1, FREQ_HZ 250000000, INSERT_VIP 0, PHASE 0.0" *) output [0:0]DAC_CLK_P;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.DAC_DATA DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.DAC_DATA, LAYERED_METADATA undef" *) output [11:0]DAC_DATA;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.DAC_DCO CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.DAC_DCO, CLK_DOMAIN aspir_bd_top_DAC_DCO, FREQ_HZ 250000000, INSERT_VIP 0, PHASE 0.000" *) input DAC_DCO;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.DAC_SPI_MISO DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.DAC_SPI_MISO, LAYERED_METADATA undef" *) input DAC_SPI_MISO;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.DAC_SPI_MOSI DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.DAC_SPI_MOSI, LAYERED_METADATA undef" *) output DAC_SPI_MOSI;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.DAC_SPI_SCLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.DAC_SPI_SCLK, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) output DAC_SPI_SCLK;
  output DAC_SPI_SS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR ADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DDR, AXI_ARBITRATION_SCHEME TDM, BURST_LENGTH 8, CAN_DEBUG false, CAS_LATENCY 11, CAS_WRITE_LATENCY 11, CS_ENABLED true, DATA_MASK_ENABLED true, DATA_WIDTH 8, MEMORY_TYPE COMPONENTS, MEM_ADDR_MAP ROW_COLUMN_BANK, SLOT Single, TIMEPERIOD_PS 1250" *) inout [14:0]DDR_addr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR BA" *) inout [2:0]DDR_ba;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR CAS_N" *) inout DDR_cas_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR CK_N" *) inout DDR_ck_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR CK_P" *) inout DDR_ck_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR CKE" *) inout DDR_cke;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR CS_N" *) inout DDR_cs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR DM" *) inout [3:0]DDR_dm;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR DQ" *) inout [31:0]DDR_dq;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR DQS_N" *) inout [3:0]DDR_dqs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR DQS_P" *) inout [3:0]DDR_dqs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR ODT" *) inout DDR_odt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR RAS_N" *) inout DDR_ras_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR RESET_N" *) inout DDR_reset_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR WE_N" *) inout DDR_we_n;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO DDR_VRN" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME FIXED_IO, CAN_DEBUG false" *) inout FIXED_IO_ddr_vrn;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO DDR_VRP" *) inout FIXED_IO_ddr_vrp;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO MIO" *) inout [53:0]FIXED_IO_mio;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO PS_CLK" *) inout FIXED_IO_ps_clk;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO PS_PORB" *) inout FIXED_IO_ps_porb;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO PS_SRSTB" *) inout FIXED_IO_ps_srstb;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.GRST_N RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.GRST_N, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input GRST_N;

  wire ADC_DATA_0_N_1;
  wire ADC_DATA_0_P_1;
  wire ADC_DATA_1_N_1;
  wire ADC_DATA_1_P_1;
  wire ADC_DATA_2_N_1;
  wire ADC_DATA_2_P_1;
  wire ADC_DATA_3_N_1;
  wire ADC_DATA_3_P_1;
  wire ADC_DATA_4_N_1;
  wire ADC_DATA_4_P_1;
  wire ADC_DATA_5_N_1;
  wire ADC_DATA_5_P_1;
  wire ADC_DCO_N_1;
  wire ADC_DCO_P_1;
  wire ADC_OVERRANGE_N_1;
  wire ADC_OVERRANGE_P_1;
  wire CLK_50MHZ_1;
  wire DAC_DCO_1;
  wire DAC_SPI_MISO_1;
  wire GRST_B_1;
  wire Net;
  wire Net1;
  wire [0:0]adc_clk_diff_buf_OBUF_DS_N;
  wire [0:0]adc_clk_diff_buf_OBUF_DS_P;
  wire [0:0]adc_data_diff_buf0_IBUF_OUT;
  wire [0:0]adc_data_diff_buf1_IBUF_OUT;
  wire [0:0]adc_data_diff_buf2_IBUF_OUT;
  wire [0:0]adc_data_diff_buf3_IBUF_OUT;
  wire [0:0]adc_data_diff_buf4_IBUF_OUT;
  wire [0:0]adc_data_diff_buf5_IBUF_OUT;
  wire [0:0]adc_dco_diff_buf_IBUF_OUT;
  wire clk_wiz_0_clk_out1;
  wire clk_wiz_0_clk_out2;
  wire [0:0]dac_clk_diff_buf_OBUF_DS_N;
  wire [0:0]dac_clk_diff_buf_OBUF_DS_P;
  wire demodulator_top_wrap_0_data_out;
  wire [11:0]modulator_top_wrapper_0_data_out;
  wire [14:0]processing_system7_0_DDR_ADDR;
  wire [2:0]processing_system7_0_DDR_BA;
  wire processing_system7_0_DDR_CAS_N;
  wire processing_system7_0_DDR_CKE;
  wire processing_system7_0_DDR_CK_N;
  wire processing_system7_0_DDR_CK_P;
  wire processing_system7_0_DDR_CS_N;
  wire [3:0]processing_system7_0_DDR_DM;
  wire [31:0]processing_system7_0_DDR_DQ;
  wire [3:0]processing_system7_0_DDR_DQS_N;
  wire [3:0]processing_system7_0_DDR_DQS_P;
  wire processing_system7_0_DDR_ODT;
  wire processing_system7_0_DDR_RAS_N;
  wire processing_system7_0_DDR_RESET_N;
  wire processing_system7_0_DDR_WE_N;
  wire processing_system7_0_FCLK_CLK0;
  wire processing_system7_0_FIXED_IO_DDR_VRN;
  wire processing_system7_0_FIXED_IO_DDR_VRP;
  wire [53:0]processing_system7_0_FIXED_IO_MIO;
  wire processing_system7_0_FIXED_IO_PS_CLK;
  wire processing_system7_0_FIXED_IO_PS_PORB;
  wire processing_system7_0_FIXED_IO_PS_SRSTB;
  wire [2:0]processing_system7_0_GPIO_O;
  wire [2:0]processing_system7_0_GPIO_T;
  wire processing_system7_0_SPI0_MOSI_O;
  wire processing_system7_0_SPI0_SCLK_O;
  wire processing_system7_0_SPI0_SS_O;
  wire processing_system7_0_SPI1_MOSI_O;
  wire processing_system7_0_SPI1_SCLK_O;
  wire processing_system7_0_SPI1_SS_O;
  wire spi_full2half_duplex_0_sclk_out;
  wire spi_full2half_duplex_0_ss_out;
  wire [0:0]util_ds_buf_0_IBUF_OUT1;
  wire [5:0]xlconcat_0_dout;

  assign ADC_CLK_N[0] = adc_clk_diff_buf_OBUF_DS_N;
  assign ADC_CLK_P[0] = adc_clk_diff_buf_OBUF_DS_P;
  assign ADC_DATA_0_N_1 = ADC_DATA_0_N;
  assign ADC_DATA_0_P_1 = ADC_DATA_0_P;
  assign ADC_DATA_1_N_1 = ADC_DATA_1_N;
  assign ADC_DATA_1_P_1 = ADC_DATA_1_P;
  assign ADC_DATA_2_N_1 = ADC_DATA_2_N;
  assign ADC_DATA_2_P_1 = ADC_DATA_2_P;
  assign ADC_DATA_3_N_1 = ADC_DATA_3_N;
  assign ADC_DATA_3_P_1 = ADC_DATA_3_P;
  assign ADC_DATA_4_N_1 = ADC_DATA_4_N;
  assign ADC_DATA_4_P_1 = ADC_DATA_4_P;
  assign ADC_DATA_5_N_1 = ADC_DATA_5_N;
  assign ADC_DATA_5_P_1 = ADC_DATA_5_P;
  assign ADC_DCO_N_1 = ADC_DCO_N;
  assign ADC_DCO_P_1 = ADC_DCO_P;
  assign ADC_OVERRANGE_N_1 = ADC_OVERRANGE_N;
  assign ADC_OVERRANGE_P_1 = ADC_OVERRANGE_P;
  assign ADC_SPI_SCLK = spi_full2half_duplex_0_sclk_out;
  assign ADC_SPI_SS = spi_full2half_duplex_0_ss_out;
  assign CLK_50MHZ_1 = CLK_50MHZ;
  assign DAC_CLK_N[0] = dac_clk_diff_buf_OBUF_DS_N;
  assign DAC_CLK_P[0] = dac_clk_diff_buf_OBUF_DS_P;
  assign DAC_DATA[11:0] = modulator_top_wrapper_0_data_out;
  assign DAC_DCO_1 = DAC_DCO;
  assign DAC_SPI_MISO_1 = DAC_SPI_MISO;
  assign DAC_SPI_MOSI = processing_system7_0_SPI0_MOSI_O;
  assign DAC_SPI_SCLK = processing_system7_0_SPI0_SCLK_O;
  assign DAC_SPI_SS = processing_system7_0_SPI0_SS_O;
  assign GRST_B_1 = GRST_N;
  aspir_bd_top_util_ds_buf_0_4 adc_clk_diff_buf
       (.OBUF_DS_N(adc_clk_diff_buf_OBUF_DS_N),
        .OBUF_DS_P(adc_clk_diff_buf_OBUF_DS_P),
        .OBUF_IN(clk_wiz_0_clk_out2));
  aspir_bd_top_adc_data_diff_buf1_4 adc_data_diff_buf0
       (.IBUF_DS_N(ADC_DATA_0_N_1),
        .IBUF_DS_P(ADC_DATA_0_P_1),
        .IBUF_OUT(adc_data_diff_buf0_IBUF_OUT));
  aspir_bd_top_adc_data_diff_buf_0 adc_data_diff_buf1
       (.IBUF_DS_N(ADC_DATA_1_N_1),
        .IBUF_DS_P(ADC_DATA_1_P_1),
        .IBUF_OUT(adc_data_diff_buf1_IBUF_OUT));
  aspir_bd_top_adc_data_diff_buf1_0 adc_data_diff_buf2
       (.IBUF_DS_N(ADC_DATA_2_N_1),
        .IBUF_DS_P(ADC_DATA_2_P_1),
        .IBUF_OUT(adc_data_diff_buf2_IBUF_OUT));
  aspir_bd_top_adc_data_diff_buf1_1 adc_data_diff_buf3
       (.IBUF_DS_N(ADC_DATA_3_N_1),
        .IBUF_DS_P(ADC_DATA_3_P_1),
        .IBUF_OUT(adc_data_diff_buf3_IBUF_OUT));
  aspir_bd_top_adc_data_diff_buf1_2 adc_data_diff_buf4
       (.IBUF_DS_N(ADC_DATA_4_P_1),
        .IBUF_DS_P(ADC_DATA_4_N_1),
        .IBUF_OUT(adc_data_diff_buf4_IBUF_OUT));
  aspir_bd_top_adc_data_diff_buf1_3 adc_data_diff_buf5
       (.IBUF_DS_N(ADC_DATA_5_P_1),
        .IBUF_DS_P(ADC_DATA_5_N_1),
        .IBUF_OUT(adc_data_diff_buf5_IBUF_OUT));
  aspir_bd_top_util_ds_buf_0_2 adc_dco_diff_buf
       (.IBUF_DS_N(ADC_DCO_P_1),
        .IBUF_DS_P(ADC_DCO_N_1),
        .IBUF_OUT(adc_dco_diff_buf_IBUF_OUT));
  aspir_bd_top_util_ds_buf_0_1 adc_overrange_diff_buf
       (.IBUF_DS_N(ADC_OVERRANGE_N_1),
        .IBUF_DS_P(ADC_OVERRANGE_P_1),
        .IBUF_OUT(util_ds_buf_0_IBUF_OUT1));
  aspir_bd_top_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(CLK_50MHZ_1),
        .clk_out1(clk_wiz_0_clk_out1),
        .clk_out2(clk_wiz_0_clk_out2),
        .resetn(GRST_B_1));
  aspir_bd_top_util_ds_buf_0_3 dac_clk_diff_buf
       (.OBUF_DS_N(dac_clk_diff_buf_OBUF_DS_N),
        .OBUF_DS_P(dac_clk_diff_buf_OBUF_DS_P),
        .OBUF_IN(clk_wiz_0_clk_out1));
  aspir_bd_top_demodulator_top_wrap_0_0 demodulator_top_wrap_0
       (.data_in(xlconcat_0_dout),
        .data_out(demodulator_top_wrap_0_data_out),
        .dco(adc_dco_diff_buf_IBUF_OUT),
        .overrange(util_ds_buf_0_IBUF_OUT1),
        .rst_n(GRST_B_1));
  aspir_bd_top_modulator_top_wrapper_0_0 modulator_top_wrapper_0
       (.data_in(processing_system7_0_GPIO_O[0]),
        .data_out(modulator_top_wrapper_0_data_out),
        .dco(DAC_DCO_1),
        .en(processing_system7_0_GPIO_T[0]),
        .rst_n(GRST_B_1));
  aspir_bd_top_processing_system7_0_0 processing_system7_0
       (.DDR_Addr(DDR_addr[14:0]),
        .DDR_BankAddr(DDR_ba[2:0]),
        .DDR_CAS_n(DDR_cas_n),
        .DDR_CKE(DDR_cke),
        .DDR_CS_n(DDR_cs_n),
        .DDR_Clk(DDR_ck_p),
        .DDR_Clk_n(DDR_ck_n),
        .DDR_DM(DDR_dm[3:0]),
        .DDR_DQ(DDR_dq[31:0]),
        .DDR_DQS(DDR_dqs_p[3:0]),
        .DDR_DQS_n(DDR_dqs_n[3:0]),
        .DDR_DRSTB(DDR_reset_n),
        .DDR_ODT(DDR_odt),
        .DDR_RAS_n(DDR_ras_n),
        .DDR_VRN(FIXED_IO_ddr_vrn),
        .DDR_VRP(FIXED_IO_ddr_vrp),
        .DDR_WEB(DDR_we_n),
        .FCLK_CLK0(processing_system7_0_FCLK_CLK0),
        .GPIO_I({demodulator_top_wrap_0_data_out,demodulator_top_wrap_0_data_out,demodulator_top_wrap_0_data_out}),
        .GPIO_O(processing_system7_0_GPIO_O),
        .GPIO_T(processing_system7_0_GPIO_T),
        .MIO(FIXED_IO_mio[53:0]),
        .M_AXI_GP0_ACLK(processing_system7_0_FCLK_CLK0),
        .M_AXI_GP0_ARREADY(1'b0),
        .M_AXI_GP0_AWREADY(1'b0),
        .M_AXI_GP0_BID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .M_AXI_GP0_BRESP({1'b0,1'b0}),
        .M_AXI_GP0_BVALID(1'b0),
        .M_AXI_GP0_RDATA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .M_AXI_GP0_RID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .M_AXI_GP0_RLAST(1'b0),
        .M_AXI_GP0_RRESP({1'b0,1'b0}),
        .M_AXI_GP0_RVALID(1'b0),
        .M_AXI_GP0_WREADY(1'b0),
        .PS_CLK(FIXED_IO_ps_clk),
        .PS_PORB(FIXED_IO_ps_porb),
        .PS_SRSTB(FIXED_IO_ps_srstb),
        .SPI0_MISO_I(DAC_SPI_MISO_1),
        .SPI0_MOSI_I(1'b0),
        .SPI0_MOSI_O(processing_system7_0_SPI0_MOSI_O),
        .SPI0_SCLK_I(1'b0),
        .SPI0_SCLK_O(processing_system7_0_SPI0_SCLK_O),
        .SPI0_SS_I(1'b0),
        .SPI0_SS_O(processing_system7_0_SPI0_SS_O),
        .SPI1_MISO_I(Net1),
        .SPI1_MOSI_I(1'b0),
        .SPI1_MOSI_O(processing_system7_0_SPI1_MOSI_O),
        .SPI1_SCLK_I(1'b0),
        .SPI1_SCLK_O(processing_system7_0_SPI1_SCLK_O),
        .SPI1_SS_I(1'b0),
        .SPI1_SS_O(processing_system7_0_SPI1_SS_O),
        .S_AXI_HP0_ACLK(processing_system7_0_FCLK_CLK0),
        .S_AXI_HP0_ARADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_ARBURST({1'b0,1'b1}),
        .S_AXI_HP0_ARCACHE({1'b0,1'b0,1'b1,1'b1}),
        .S_AXI_HP0_ARID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_ARLEN({1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_ARLOCK({1'b0,1'b0}),
        .S_AXI_HP0_ARPROT({1'b0,1'b0,1'b0}),
        .S_AXI_HP0_ARQOS({1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_ARSIZE({1'b0,1'b1,1'b0}),
        .S_AXI_HP0_ARVALID(1'b0),
        .S_AXI_HP0_AWADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_AWBURST({1'b0,1'b1}),
        .S_AXI_HP0_AWCACHE({1'b0,1'b0,1'b1,1'b1}),
        .S_AXI_HP0_AWID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_AWLEN({1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_AWLOCK({1'b0,1'b0}),
        .S_AXI_HP0_AWPROT({1'b0,1'b0,1'b0}),
        .S_AXI_HP0_AWQOS({1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_AWSIZE({1'b0,1'b1,1'b0}),
        .S_AXI_HP0_AWVALID(1'b0),
        .S_AXI_HP0_BREADY(1'b0),
        .S_AXI_HP0_RDISSUECAP1_EN(1'b0),
        .S_AXI_HP0_RREADY(1'b0),
        .S_AXI_HP0_WDATA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_WID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_WLAST(1'b0),
        .S_AXI_HP0_WRISSUECAP1_EN(1'b0),
        .S_AXI_HP0_WSTRB({1'b1,1'b1,1'b1,1'b1}),
        .S_AXI_HP0_WVALID(1'b0));
  aspir_bd_top_spi_full2half_duplex_0_0 spi_full2half_duplex_0
       (.miso_in(Net1),
        .mosi_in(processing_system7_0_SPI1_MOSI_O),
        .sclk_in(processing_system7_0_SPI1_SCLK_O),
        .sclk_out(spi_full2half_duplex_0_sclk_out),
        .sdio_out(ADC_SPI_SDIO),
        .ss_in(processing_system7_0_SPI1_SS_O),
        .ss_out(spi_full2half_duplex_0_ss_out));
  aspir_bd_top_xlconcat_0_0 xlconcat_0
       (.In0(adc_data_diff_buf0_IBUF_OUT),
        .In1(adc_data_diff_buf1_IBUF_OUT),
        .In2(adc_data_diff_buf2_IBUF_OUT),
        .In3(adc_data_diff_buf3_IBUF_OUT),
        .In4(adc_data_diff_buf4_IBUF_OUT),
        .In5(adc_data_diff_buf5_IBUF_OUT),
        .dout(xlconcat_0_dout));
endmodule
