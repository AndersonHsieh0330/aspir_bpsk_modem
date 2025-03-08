module differential_decoder (
    input  wire clk,
    input  wire rst_n,
    input  wire data_in,
    output wire data_out
);

reg prev_data_in;

// data_in's real value depends on the difference with the previous symbol
assign data_out = data_in ^ prev_data_in;

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        prev_data_in = 1'b0;
    end else begin
        prev_data_in <= data_in;
    end
end
endmodule