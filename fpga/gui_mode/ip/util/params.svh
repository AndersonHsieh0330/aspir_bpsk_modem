`define CARRIER_SAMPLES_PER_PERIOD 512 
`define CARRIER_FREQ 25 // Mhz
`define ADC_SAMPLING_FREQ 200 // Mhz, 2*(Fc * baudrate)

/*
 * bit width of the fixed point decimal number
 * note that we use 18 bits because the dsp blocks in zynq-7000
 * is 25 X 18 bits
 * [17, 16:10, 9:0] 17th bit is sign bit, decimal point between 9th and 10th bit
 */
`define FIXED_PT_WIDTH 18 
`define ADC_BITS 12