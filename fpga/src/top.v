`default_nettype none
module top (
    input  wire       CLK12MHZ,
    output wire [3:0] led
);

blink (
    .clk(CLK12MHZ),
    .out(led[0])
);

endmodule