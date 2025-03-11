# oscillator, overwrites bd geenerate create clock from clock wizard
create_clock -name clk_osc_50mhz -period 20 [get_ports CLK_50MHZ] -quiet

# adc
create_clock -name adc_dco -period 4 [get_nets aspir_bd_top_i/adc_dco_diff_buf/IBUF_OUT[0]]
# constraint only applied on P side of diff clock, this should be ok
create_clock -name adc_dco_p -period 4 [get_ports ADC_DCO_P]
create_clock -name adc_clk_p -period 4 [get_ports ADC_CLK_P]

# dac
create_clock -name dac_dco -period 4 [get_ports DAC_DCO]
create_clock -name dac_clk_p -period 4 [get_ports DAC_CLK_P]

# generated clocks
# create_generated_clock -name clock_wizard_out1_dac -source [get_ports CLK_50MHZ] -divide_by 0.2 [get_nets aspir_bd_top_i/clk_wiz_0/clk_out1]
# create_generated_clock -name clock_wizard_out2_adc -source [get_ports CLK_50MHZ] -divide_by 0.2 [get_nets aspir_bd_top_i/clk_wiz_0/clk_out2]

# ps generated clock, overwrites bd generated create clock
# commented for now since this clock's frequency may change
# create_clock -name ps_fclk_clk0 -period 5 [get_nets aspir_bd_top_i/processing_system7_0/FCLK_CLK0] -quiet