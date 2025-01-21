`include "params.svh"
module phase_conversion_test();

    reg signed   [`FIXDT_64_A_WIDTH-1:0] val;
    reg unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] phase_in_step;

    initial begin
        val = 64'sh00003243f6a8885a; // 2pi
        #10;
        val = 64'sh0000000000000000; // 0 
        #10;
        val = 64'sh00002de31f8a0903; // 5.7359
        #10;
        val = 64'shffffea1ce075f6fd; // -2.7359
        #10;
        $finish;
    end

    phase_converter #(
        .PHASE_STEP(`M_2_PI_64B_A/`CARRIER_SAMPLES_PER_PERIOD),
        .INPUT_WIDTH(`FIXDT_64_A_WIDTH),
        .M_2_PI(`M_2_PI_64B_A)
    ) phase_converter_inst (
        .input_value(val),
        .phase_in_step(phase_in_step)
    );
endmodule