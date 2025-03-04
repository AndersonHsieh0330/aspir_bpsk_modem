`include "params.vh"
module fixdt_64_A_to_12b_test ();
reg  signed [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] cosine_lut_counter;
wire signed [`FIXDT_64_WIDTH-1:0] fixdt_64_a_out_tx, fixdt_64_a_out_rx;
wire signed [11:0] twos_comp_12_out;

initial begin
    cosine_lut_counter = {$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1{1'b0}};
    #2;
    for(integer i = 0 ; i < `CARRIER_SAMPLES_PER_PERIOD; i = i + 1) begin
        cosine_lut_counter = cosine_lut_counter + 1;
        #2;
    end
    $finish();
end

cosine_lut #(
    .READ_PORTS(1)
) cosine_lut_ist (
    .in(cosine_lut_counter),
    .out(fixdt_64_a_out_tx)
);

num_convert_tx num_convert_tx_inst (
    .data_in(fixdt_64_a_out_tx),
    .data_out(twos_comp_12_out)
);

num_convert_rx num_convert_rx_inst (
    .data_in(twos_comp_12_out),
    .data_out(fixdt_64_a_out_rx)
);

endmodule