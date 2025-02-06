/*
*   20250119 
*   all the rounders in this page follows traditional number of fraction bits
*   aka 32 bit number has 23 fraction bits
*   64 bit number has 52 fraction bits
*   any other customized fixed point format is not suittable for the rounders
*   in this file
*/
`include "params.vh"
class FixdtRounder;
// https://chummersone.github.io/qformat.html
// useful website for debugging number format

    function bit [17:0] fixdt_32_to_16 (bit signed [31:0] input_value);
        bit signed [31:0] rounded_value; // 32-bit input
        bit signed [31:0] rounded_value_shifted; // 32-bit input
        bit signed [15:0] result; // 32-bit input
        bit overflow = 1'b0;
        bit underflow = 1'b0;

        // add rounding factor and check over/underflow
        // rounding factor is 2^(23-10-1) = 4096
        if (input_value > 32'sd2147483647 - 32'sd4096) begin
            rounded_value = 32'sd2147483647; // Clamp to max
            overflow = 1'b1;
        end else if (input_value < -32'sd2147483648 + 32'sd4096) begin
            rounded_value = -32'sd2147483648; // Clamp to min
            underflow = 1'b1;
        end else begin
            rounded_value = input_value + 32'sd4096; // Add rounding factor
        end

        // right shift by 23-10 = 13 bits (reduce fractional bits), sign extend
        rounded_value_shifted = rounded_value >>> 13;

        // clamp to 16-bit range, 32 bit number must compare with 32 bit numbers
        if (rounded_value_shifted > 32'sd32767) begin
            result = 16'sd32767; // Clamp to max
            overflow = 1'b1;
        end else if (rounded_value_shifted < -32'sd32768) begin
            result = -16'sd32768; // Clamp to min
            underflow = 1'b1;
        end else begin
            result = rounded_value_shifted[15:0]; // Assign result
        end

        return {overflow, underflow, result};
    endfunction

    function bit [33:0] fixdt_64_to_32 (bit signed [63:0] input_value);
        bit signed [63:0] rounded_value, rounded_value_shifted; 
        bit signed [31:0] result; // 32-bit input
        bit overflow = 1'b0;
        bit underflow = 1'b0;

        // add rounding factor and check over/underflow
        // rounding factor is 2^(52-23-1) = 268435456
        if (input_value > 64'sh7fffffffffffffff - 64'sd268435456) begin
            rounded_value = 64'h7fffffffffffffff; // Clamp to max
            overflow = 1'b1;
        end else if (input_value < -64'sh7fffffffffffffff + 64'sd268435456) begin
            rounded_value = -64'sh7fffffffffffffff; // Clamp to min
            underflow = 1'b1;
        end else begin
            rounded_value = input_value + 64'sd268435456; // Add rounding factor
        end

        // right shift by 52-23 = 29 bits (reduce fractional bits), sign extend
        rounded_value_shifted = rounded_value >>> 29;

        // clamp to 16-bit range, 32 bit number must compare with 32 bit numbers
        if (rounded_value_shifted > 64'sh7fffffff) begin
            result = 32'sh7fffffff; // Clamp to max
            overflow = 1'b1;
        end else if (rounded_value_shifted < -64'sh80000000) begin
            result = -32'sh80000000; // Clamp to min
            underflow = 1'b1;
        end else begin
            result = rounded_value_shifted[31:0]; // Assign result
        end

        return {overflow, underflow, result};
    endfunction

endclass