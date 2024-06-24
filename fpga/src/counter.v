module counter #(parameter quant_bits = 5) (
    input clk,
    input reset,
    output reg [quant_bits-1:0] out
);

    always @ (posedge clk) begin
        if (reset)
            out <= 0;
        else begin
            if (out < 32)
                out <= out + 1;
            else 
                out <= 0;
        end
    end
endmodule