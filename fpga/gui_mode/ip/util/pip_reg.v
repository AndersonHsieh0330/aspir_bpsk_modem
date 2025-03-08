// a simple pipline register
module pip_reg #(
    parameter DATA_WIDTH = 1
) (
    input  wire                  clk,
    input  wire                  rst_n,
    input  wire [DATA_WIDTH-1:0] data_in,
    output reg  [DATA_WIDTH-1:0] data_out
);

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        data_out <= {DATA_WIDTH{1'b0}};
    end else begin
        data_out <= data_in;
    end
end
endmodule