`include "params.vh"
module phase_conversion_test();

    parameter DATA_WIDTH = `FIXDT_24_WIDTH;
    parameter DATA_FRAC_WIDTH = `FIXDT_24_FRAC_WIDTH;

    reg signed   [DATA_WIDTH-1:0] val;
    reg unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] phase_in_step;

    initial begin
        val = 24'sh06487f; // 2pi
        #10;
        val = 24'sh000000; // 0 
        #10;
        val = 24'sh05bc64; // 5.7359
        #10;
        val = 24'shfd439c; // -2.7359
        #10;
        $finish;
    end

    phase_converter #(
        .PHASE_STEP(24'sh000032),
        .INPUT_WIDTH(DATA_WIDTH),
        .M_2_PI(24'sh06487f)
    ) phase_converter_inst (
        .input_value(val),
        .phase_in_step(phase_in_step)
    );
endmodule