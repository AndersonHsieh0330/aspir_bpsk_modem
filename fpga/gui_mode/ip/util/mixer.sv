`default_nettype none
module mixer #(
    parameter IN_A_BITS = 1,
    parameter IN_B_BITS = 1
) (
    input wire  signed [IN_A_BITS-1:0]           in_a,
    input wire  signed [IN_B_BITS-1:0]           in_b,
    output wire signed [IN_A_BITS+IN_B_BITS-1:0] out
);

(* use_dsp = "yes" *) assign out = in_a * in_b;

endmodule