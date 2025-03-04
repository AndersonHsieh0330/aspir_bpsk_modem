module ddr_to_sdr (
    input wire clk,
    input wire rst_n,
    input wire [`ADC_BITS/2-1:0] data_in,
    input wire [`ADC_BITS-1:0] data_out
);

// even bits are sent on rising edge
// odd bits are sent on falling edge
reg [`ADC_BITS/2-1:0] r, f;

assign data_out = {f[5], r[5], f[4], r[4], f[3], r[3], f[2], r[2], f[1], r[1], f[0], r[0]};

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        r <= 6'b000000;
    end else begin
        r <= data_in;
    end
end

always @ (negedge clk or negedge rst_n) begin
    if (~rst_n) begin
        f <= 6'b000000;
    end else begin
        f <= data_in;
    end
end

endmodule