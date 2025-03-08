// DSP algorithm
`define BPSK 1

// modem
`define SYMBOL_RATE 2500000 // 2.5 Mhz
`define BITS_PER_SYMBOL 1 // 1 for BPSK, change in the future
`define BIT_RATE (`BITS_PER_SYMBOL*`SYMBOL_RATE)
`define SAMPLING_FREQ 200000000 // 200 Mhz
`define CARRIER_FREQ 25000000 // 25 Mhz
`define LPF_TAPS 10
`define SAMPLES_PER_SYMBOL (`SAMPLING_FREQ/`SYMBOL_RATE)
`define CARRIER_SAMPLES_PER_PERIOD 8192 // number of entries in the cosine look up table
`define ADC_BITS 12 
`define DAC_BITS 12 

/* 
* Data Types 
* 16 bit fixed point floating point = 1, 5, 10
* 32 bit fixed point floating point = 1, 8, 23
* 64 bit fixed point floating point = 1, 11, 52
* 64 bit A fixed point floating point = 1, 20, 43
* 20 bit fixed point floating point = 1, 6, 13 
*/
`define FIXDT_16_WIDTH 16
`define FIXDT_16_FRAC_WIDTH 10
`define FIXDT_32_WIDTH 32
`define FIXDT_32_FRAC_WIDTH 23
`define FIXDT_64_WIDTH 64
`define FIXDT_64_FRAC_WIDTH 52
`define FIXDT_64_A_WIDTH 64
`define FIXDT_64_A_FRAC_WIDTH 43
`define FIXDT_24_WIDTH 24
`define FIXDT_24_FRAC_WIDTH 16

// Math Constants
`define M_2_PI_64B 64'sh006487ed5110b460
`define M_2_PI_64B_A 64'sh00003243f6a8885a
`define M_2_PI_32B 32'sh03243f6b

// peripherals
`define AXI4_STREAM_DATA_FIFO_TDATA_WIDTH 32
`define ETHERNET_SFD 8'b10101011