// convert radians to step for cosine look up table
`include "params.vh"
module phase_converter #(
    parameter signed PHASE_STEP = `M_2_PI_64B_A / `CARRIER_SAMPLES_PER_PERIOD,
    parameter INPUT_WIDTH = `FIXDT_64_A_WIDTH,
    parameter signed M_2_PI = `M_2_PI_64B_A
) (
    input  wire signed [INPUT_WIDTH-1:0] input_value,
    output wire        [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] phase_in_step // phase in the unit of steps
);

//    assign phase_in_step = (input_value * 2186160243) >> 24;
    // Scaling factor in Q16: 85406613 (0x0516DD55)
    localparam signed SCALE_FACTOR = 32'd85406613; 

    wire signed [47:0] product;
    assign product = input_value * SCALE_FACTOR; // Full precision multiplication

    wire signed [31:0] shifted;
    assign shifted = product[47:16]; // Extract upper 32 bits after shift

    // Ensure output is non-negative (clamp negative values to zero)
    assign phase_in_step = (shifted < 0) ? 13'd0 : shifted[12:0];
endmodule