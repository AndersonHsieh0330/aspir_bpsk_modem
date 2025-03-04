`include "params.vh"
module counter(
    input  wire clk,
    input  wire rst_n,
    output reg  [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] out
);

always @(posedge clk) begin
    if (~rst_n) begin
        out <= {$clog2(`CARRIER_SAMPLES_PER_PERIOD){1'b0}};
    end else begin
        // intentionally overflow
        out <= out + (`CARRIER_SAMPLES_PER_PERIOD / (`SAMPLING_FREQ / `CARRIER_FREQ));
    end
end

endmodule
