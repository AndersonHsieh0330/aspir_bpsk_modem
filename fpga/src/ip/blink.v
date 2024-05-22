`default_nettype none
module blink (
    input  wire clk,
    output reg out
);

reg [23:0] counter;
always @(posedge clk) begin
    if (counter >= 12000000) begin
        counter <= 24'h000000;
        out <= ~out;
    end else begin
        counter <= counter + 1;
    end
end

endmodule