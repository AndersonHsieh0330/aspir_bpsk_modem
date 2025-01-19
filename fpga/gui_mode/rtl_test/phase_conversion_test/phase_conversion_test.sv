`include "params.svh"
`include "phase_converter.sv"
module phase_conversion_test();
    PhaseConverter pc = new();

    /* 64 bit version 
    bit signed [63:0] val_a = 64'sh00323d70a3d70a3e; 
    bit signed [63:0] val_b = 64'sh00324189374bc6a8;
    bit signed [63:0] val_c = 64'sh0000000000000000;
    bit signed [63:0] val_d = -64'sh00323d70a3d70a3e;
    bit signed [63:0] val_e = -64'sh00324189374bc6a8;
    bit signed [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] val_a_result = pc.rad_to_step(val_a);
    bit signed [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] val_b_result = pc.rad_to_step(val_b);
    bit signed [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] val_c_result = pc.rad_to_step(val_c);
    bit signed [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] val_d_result = pc.rad_to_step(val_d);
    bit signed [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] val_e_result = pc.rad_to_step(val_e);
    */
    bit signed [31:0] val_a = 32'sh025b2f8e;
    bit signed [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] val_a_result = pc.rad_to_step(val_a);
endmodule