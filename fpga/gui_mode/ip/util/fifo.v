/* 
 * every clock cycle shift the last index out and 
 * and put the new data into first index, like a fifo
 */
module fifo #(
    FIFO_SIZE = `ADC_SAMPLING_FREQ / `CARRIER_FREQ,
    DATA_WIDTH = `ADC_BITS + `FIXED_PT_WIDTH
) (
    input  wire                                 clk,
    input  wire                                 rst,
    input  wire signed [$clog2(DATA_WIDTH)-1:0] data_in,
    output reg  signed [$clog2(DATA_WIDTH)-1:0] fifo_out [0:FIFO_SIZE-1]
);

always @ (posedge clk) begin
    if (rst) begin
        for (genvar i = 0 ; i < FIFO_SIZE ; i = i + 1) begin
            fifo[i] <= {$clog2(DATA_WIDTH){1'b0}};
        end
    end else begin
        for (genvar i = 0 ; i < FIFO_SIZE ; i = i + 1) begin
            fifo[i] <= i == 0 ? data_in : fifo[i-1];
        end
    end
end

endmodule