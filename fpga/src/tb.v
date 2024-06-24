module tb;

reg [4:0] t;
reg [11:0] o;
reg clk;
reg reset;

sine_generate #(quant_bits = 5) sine(.time(t),.out(o));
counter #(quant_bits = 5) count(.clk(clk), .reset(reset), .out(t));

initial begin
    clk = 0;
    reset = 1;
    #4;
    reset = 0;
    #40;
    $finish;
end

always begin
    #4 clk = ~clk;
end

$monitor("time=%t, t=%t, out=%t",$time t,o);

endmodule