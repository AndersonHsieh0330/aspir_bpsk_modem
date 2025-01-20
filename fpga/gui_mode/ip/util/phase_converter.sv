// convert radians to step for cosine look up table
`include "params.svh"
module phase_converter #(
    parameter PHASE_STEP = `M_2_PI_64B_A / `CARRIER_SAMPLES_PER_PERIOD,
    parameter INPUT_WIDTH = `FIXDT_64_A_WIDTH,
    parameter M_2_PI = `M_2_PI_64B_A
) (
    input  wire signed   [INPUT_WIDTH-1:0] input_value,
    output reg  unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] phase_in_step // phase in the unit of steps
);

    reg signed [INPUT_WIDTH-1:0] true_phase; // units: steps
    reg signed [INPUT_WIDTH-1:0] true_phase_in_2pi; // units: rads
    reg signed [INPUT_WIDTH-1:0] true_phase_remainder; // units: rads
    reg signed [INPUT_WIDTH-1:0] true_phase_rounded; // units: steps

    assign phase_in_step = true_phase_rounded[$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0];
    assign true_phase_in_2pi = input_value % M_2_PI;
    assign true_phase = true_phase_in_2pi / PHASE_STEP;
    assign true_phase_remainder = true_phase_in_2pi % PHASE_STEP;

    always_comb begin
        if (true_phase[INPUT_WIDTH-1] == 1'b1) begin
            // if the phase is negative, rotate it by 2pi so it becomes positive
            if (true_phase_remainder <= -(PHASE_STEP >> 1)) begin
                // round up
                true_phase_rounded = true_phase - 1 + `CARRIER_SAMPLES_PER_PERIOD;
            end else begin
                true_phase_rounded = true_phase + `CARRIER_SAMPLES_PER_PERIOD;
            end
        end else begin
            if (true_phase_remainder >= (PHASE_STEP >> 1)) begin
                // round up
                true_phase_rounded = true_phase + 1;
            end else begin
                true_phase_rounded = true_phase;
            end
        end
    end

endmodule