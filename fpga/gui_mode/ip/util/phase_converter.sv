`include "params.svh"
class PhaseConverter;
    const bit signed [31:0] phase_step = `M_2_PI_32B / `CARRIER_SAMPLES_PER_PERIOD; // 2pi / `CARRIER_SAMPLES_PER_PERIOD

    function bit unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] rad_to_step (bit signed [31:0] input_value);
        bit signed [31:0] true_phase, true_phase_remainder;

        true_phase = input_value % `M_2_PI_32B;
        true_phase = true_phase / phase_step;
        true_phase_remainder = input_value % phase_step;
        if (true_phase[31] == 1'b1) begin
            if (true_phase_remainder <= -(phase_step >> 1)) begin
                true_phase = true_phase - 1'b1;
            end
            // if the phase is negative, rotate it by 2pi so it becomes positive
            true_phase = true_phase + `CARRIER_SAMPLES_PER_PERIOD;
        end else begin
            if (true_phase_remainder >= (phase_step >> 1)) begin
                true_phase = true_phase + 1'b1;
            end
        end

        return true_phase[$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0];
    endfunction
    
    // 64 bit version
    //const bit signed [63:0] phase_step = `M_2_PI / `CARRIER_SAMPLES_PER_PERIOD; // 2pi / `CARRIER_SAMPLES_PER_PERIOD

    //function bit unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] rad_to_step (bit signed [63:0] input_value);
    //    bit signed [63:0] true_phase, true_phase_remainder;

    //    true_phase = input_value % `M_2_PI;
    //    true_phase = true_phase / phase_step;
    //    true_phase_remainder = input_value % phase_step;
    //    if (true_phase[63] == 1'b1) begin
    //        if (true_phase_remainder <= -(phase_step >> 1)) begin
    //            true_phase = true_phase - 1'b1;
    //        end
    //        // if the phase is negative, rotate it by 2pi so it becomes positive
    //        true_phase = true_phase + `CARRIER_SAMPLES_PER_PERIOD;
    //    end else begin
    //        if (true_phase_remainder >= (phase_step >> 1)) begin
    //            true_phase = true_phase + 1'b1;
    //        end
    //    end

    //    return true_phase[$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0];
    //endfunction
endclass