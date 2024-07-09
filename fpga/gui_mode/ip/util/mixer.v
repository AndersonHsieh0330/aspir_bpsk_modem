module mixer #(
    IN_A_BITS = 1,
    IN_B_BITS = 1
) (
    input wire  [IN_A_BITS-1:0]           in_a,
    input wire  [IN_B_BITS-1:0]           in_b,
    output wire [IN_A_BITS+IN_B_BITS-1:0] out
);

(* use_dsp = “yes” *) assign out = in_a * in_b;

endmodule