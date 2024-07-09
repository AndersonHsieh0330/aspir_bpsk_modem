/*
 *  This file has the behavioral code of the sine look up table
 *  The number of bits and samples are dynamic so we can easily
 *  change in the future.
 *
 *  Ideally the memory get sythesized into a lookup table wthout 
 *  any extra combinational logic, which is why the ramstyle 
 *  attribute is used. But if that's not the case, we can type 
 *  out all the entries of the lookup table with assign
 *  statements later.
 *
 *  Note that we use distributed ram isntead of block ram cuz 
 *  we want asychronous access, aka no clock delay on read. 
 */
`include "params.vh"
module cosine_lut #(
    SAMPLES = 512, // samples per period
    BITS = 12 // our adc/dac uses 12 bits 2s complement
) (
    input  wire [$clog2(SAMPLES)-1:0] in,
    output wire [BITS-1:0] out
);

(* ramstyle = "distributed" *) wire signed [BITS-1:0] lut [0:SAMPLES-1];

// theoritically real number will not be synthesized
// it'll be calcuated during elaboration(? and used as constants
real x_step = `PI*2/SAMPLES;

for (genvar i = 0 ; i < SAMPLES; i = i + 1) begin
    assign lut[i] = $pow(2,(BITS-1))*$cos(x_step*i);
end

assign out = lut[in];

endmodule