`include "params.svh"
`include "fixdt_rounder.sv"
module fixdt_conversion_test ();
    FixdtRounder rounder = new();

    // 32 to 16 test 
    bit signed [31:0] val_32t16_a = 32'b0_00000001_00000000000000000000000;
    bit signed [31:0] val_32t16_b = 32'b0_11111111_11111111111111111111111;
    bit signed [31:0] val_32t16_c = 32'b1_00000000_00000000000000000000000;
    bit signed [31:0] val_32t16_d = 32'b0_00000000_00001001000100000000000;
    bit signed [31:0] val_32t16_e = 32'b1_11111011_11011101111111111111111;

    bit signed [17:0] val_32t16_a_result = rounder.fixdt_32_to_16(val_32t16_a);
    bit signed [15:0] val_32t16_a_num = val_32t16_a_result[15:0];
    bit val_32t16_a_result_overflow = val_32t16_a_result[17];
    bit val_32t16_a_result_underflow = val_32t16_a_result[16];

    bit signed [17:0] val_32t16_b_result = rounder.fixdt_32_to_16(val_32t16_b);
    bit signed [15:0] val_32t16_b_num = val_32t16_b_result[15:0];
    bit val_32t16_b_result_overflow = val_32t16_b_result[17];
    bit val_32t16_b_result_underflow = val_32t16_b_result[16];

    bit signed [17:0] val_32t16_c_result = rounder.fixdt_32_to_16(val_32t16_c);
    bit signed [15:0] val_32t16_c_num = val_32t16_c_result[15:0];
    bit val_32t16_c_result_overflow = val_32t16_c_result[17];
    bit val_32t16_c_result_underflow = val_32t16_c_result[16];

    bit signed [17:0] val_32t16_d_result = rounder.fixdt_32_to_16(val_32t16_d);
    bit signed [15:0] val_32t16_d_num = val_32t16_d_result[15:0];
    bit val_32t16_d_result_overflow = val_32t16_d_result[17];
    bit val_32t16_d_result_underflow = val_32t16_d_result[16];

    bit signed [17:0] val_32t16_e_result = rounder.fixdt_32_to_16(val_32t16_e);
    bit signed [15:0] val_32t16_e_num = val_32t16_e_result[15:0];
    bit val_32t16_e_result_overflow = val_32t16_e_result[17];
    bit val_32t16_e_result_underflow = val_32t16_e_result[16];

    // 64 to 32 test
    bit signed [63:0] val_64t32_a = 64'b0_00000000001_0000000000000000000000000000000000000000000000000000;
    bit signed [63:0] val_64t32_b = 64'b0_11111111111_1111111111111111111111111111111111111111111111111111;
    bit signed [63:0] val_64t32_c = 64'b1_00000000000_0000000000000000000000000000000000000000000000000000;
    bit signed [63:0] val_64t32_d = 64'b0_00000000000_0000100100010000000000100000000000001111000000000000;
    bit signed [63:0] val_64t32_e = 64'b1_11111101011_1101110111111111111111111111111111110000111111111111;

    bit signed [33:0] val_64t32_a_result = rounder.fixdt_64_to_32(val_64t32_a);
    bit signed [31:0] val_64t32_a_num = val_64t32_a_result[31:0];
    bit val_64t32_a_result_overflow = val_64t32_a_result[33];
    bit val_64t32_a_result_underflow = val_64t32_a_result[32];

    bit signed [33:0] val_64t32_b_result = rounder.fixdt_64_to_32(val_64t32_b);
    bit signed [31:0] val_64t32_b_num = val_64t32_b_result[31:0];
    bit val_64t32_b_result_overflow = val_64t32_b_result[33];
    bit val_64t32_b_result_underflow = val_64t32_b_result[32];

    bit signed [33:0] val_64t32_c_result = rounder.fixdt_64_to_32(val_64t32_c);
    bit signed [31:0] val_64t32_c_num = val_64t32_c_result[31:0];
    bit val_64t32_c_result_overflow = val_64t32_c_result[33];
    bit val_64t32_c_result_underflow = val_64t32_c_result[32];

    bit signed [33:0] val_64t32_d_result = rounder.fixdt_64_to_32(val_64t32_d);
    bit signed [31:0] val_64t32_d_num = val_64t32_d_result[31:0];
    bit val_64t32_d_result_overflow = val_64t32_d_result[33];
    bit val_64t32_d_result_underflow = val_64t32_d_result[32];

    bit signed [33:0] val_64t32_e_result = rounder.fixdt_64_to_32(val_64t32_e);
    bit signed [31:0] val_64t32_e_num = val_64t32_e_result[31:0];
    bit val_64t32_e_result_overflow = val_64t32_e_result[33];
    bit val_64t32_e_result_underflow = val_64t32_e_result[32];

endmodule