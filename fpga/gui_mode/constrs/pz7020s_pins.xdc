# bank 13 -> 2.5
# bank 34 -> 3.3
# bank 35 -> 1.8
############ DAC ##############
# all dac pins are 3.3v

# clock to DAC, bank 13
set_property IOSTANDARD LVDS_25 [get_ports {DAC_CLK_P DAC_CLK_N}]
set_property PACKAGE_PIN T9 [get_ports DAC_CLK_P]
set_property PACKAGE_PIN U10 [get_ports DAC_CLK_N]

# spi, bank 34
set_property IOSTANDARD LVCMOS33 [get_ports DAC_SPI_SCLK]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_SPI_MOSI]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_SPI_MISO]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_SPI_SS]
set_property PACKAGE_PIN N18 [get_ports DAC_SPI_SCLK]
# SDI
set_property PACKAGE_PIN R18 [get_ports DAC_SPI_MOSI]
# SDO
set_property PACKAGE_PIN T17 [get_ports DAC_SPI_MISO]
set_property PACKAGE_PIN P20 [get_ports DAC_SPI_SS]

# data, 12 single ended bits, bank 34
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DATA[0]]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DATA[1]]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DATA[2]]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DATA[3]]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DATA[4]]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DATA[5]]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DATA[6]]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DATA[7]]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DATA[8]]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DATA[9]]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DATA[10]]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DATA[11]]
set_property PACKAGE_PIN W15 [get_ports DAC_DATA[0]]
set_property PACKAGE_PIN V15 [get_ports DAC_DATA[1]]
set_property PACKAGE_PIN U15 [get_ports DAC_DATA[2]]
set_property PACKAGE_PIN U14 [get_ports DAC_DATA[3]]
set_property PACKAGE_PIN R14 [get_ports DAC_DATA[4]]
set_property PACKAGE_PIN P14 [get_ports DAC_DATA[5]]
set_property PACKAGE_PIN W13 [get_ports DAC_DATA[6]]
set_property PACKAGE_PIN V12 [get_ports DAC_DATA[7]]
set_property PACKAGE_PIN T10 [get_ports DAC_DATA[8]]
set_property PACKAGE_PIN T11 [get_ports DAC_DATA[9]]
set_property PACKAGE_PIN U12 [get_ports DAC_DATA[10]]
set_property PACKAGE_PIN T12 [get_ports DAC_DATA[11]]

# dco from DAC, single ended clk, bank 34
set_property IOSTANDARD LVCMOS33 [get_ports DAC_DCO]
set_property PACKAGE_PIN P19 [get_ports DAC_DCO]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets DAC_DCO_IBUF]

############ ADC ##############
# all adc digital pins are 1.8v

# clock to ADC, bank 13
set_property IOSTANDARD LVDS_25 [get_ports {ADC_CLK_P ADC_CLK_N}]
set_property PACKAGE_PIN Y9 [get_ports ADC_CLK_P]
set_property PACKAGE_PIN Y8 [get_ports ADC_CLK_N]

# spi, bank 35
set_property IOSTANDARD LVCMOS18 [get_ports ADC_SPI_SCLK]
set_property IOSTANDARD LVCMOS18 [get_ports ADC_SPI_SDIO]
set_property IOSTANDARD LVCMOS18 [get_ports ADC_SPI_SS]
set_property PACKAGE_PIN K18 [get_ports ADC_SPI_SCLK]
set_property PACKAGE_PIN K17 [get_ports ADC_SPI_SS]
set_property PACKAGE_PIN L14 [get_ports ADC_SPI_SDIO]

# data, 6 diff pairs, bank 13
set_property IOSTANDARD LVDS_25 [get_ports {ADC_DATA_0_P ADC_DATA_0_N}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC_DATA_1_P ADC_DATA_1_N}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC_DATA_2_P ADC_DATA_2_N}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC_DATA_3_P ADC_DATA_3_N}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC_DATA_4_P ADC_DATA_4_N}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC_DATA_5_P ADC_DATA_5_N}]
set_property PACKAGE_PIN U9 [get_ports ADC_DATA_0_P]
set_property PACKAGE_PIN V8 [get_ports ADC_DATA_1_P]
set_property PACKAGE_PIN V6 [get_ports ADC_DATA_2_P]
set_property PACKAGE_PIN W11 [get_ports ADC_DATA_3_P]
set_property PACKAGE_PIN U5 [get_ports ADC_DATA_4_P]
set_property PACKAGE_PIN V7 [get_ports ADC_DATA_5_P]
set_property PACKAGE_PIN U8 [get_ports ADC_DATA_0_N]
set_property PACKAGE_PIN W8 [get_ports ADC_DATA_1_N]
set_property PACKAGE_PIN W6 [get_ports ADC_DATA_2_N]
set_property PACKAGE_PIN Y11 [get_ports ADC_DATA_3_N]
set_property PACKAGE_PIN T5 [get_ports ADC_DATA_4_N]
set_property PACKAGE_PIN U7 [get_ports ADC_DATA_5_N]

# overange bit, 1 diff pair, bank 13
set_property IOSTANDARD LVDS_25 [get_ports {ADC_OVERRANGE_P ADC_OVERRANGE_N}]
set_property PACKAGE_PIN Y12 [get_ports ADC_OVERRANGE_P]
set_property PACKAGE_PIN Y13 [get_ports ADC_OVERRANGE_N]

# dco from adc, 1 diff pair, bank 13
set_property IOSTANDARD LVDS_25 [get_ports {ADC_DCO_P ADC_DCO_N}]
set_property PACKAGE_PIN Y6 [get_ports ADC_DCO_P]
set_property PACKAGE_PIN Y7 [get_ports ADC_DCO_N]

############ util ##############
# 50 mhz oscillator, bank 34
set_property IOSTANDARD LVCMOS33 [get_ports CLK_50MHZ]
set_property PACKAGE_PIN U18 [get_ports CLK_50MHZ]

# reset button on som, bank 34
set_property IOSTANDARD LVCMOS33 [get_ports GRST_N]
set_property PACKAGE_PIN U19 [get_ports GRST_N]