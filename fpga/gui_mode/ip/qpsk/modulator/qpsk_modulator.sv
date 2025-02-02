module qpsk_modulator (
    input wire                      clk,
    input wire                              rst,
    input wire [1:0]                         in,
    output reg [`FIXDT_64_A_WIDTH-1:0]  out

);

    wire unsigned [$clog2(`CARRIER_SAMPLES_PER_PERIOD)-1:0] nco_i_cosine_lu_angle_steps, nco_q_cosine_lu_angle_steps;
    wire unsigned [`FIXDT_64_A_WIDTH-1:0] wave_out [1:0];

    wire unsigned [`FIXDT_64_A_WIDTH-1:0] wave_45, wave_135, wave_225, wave_315;
    
    assign wave_45 =  wave_out[0] + wave_out[1];
    assign wave_135 = wave_out[0] + ~wave_out[1];
    assign wave_225 = ~wave_out[0] + ~wave_out[1];
    assign wave_315 = ~wave_out[0] + wave_out[1];

    assign out = (in == 2'b00) ? wave_45 :
                (in == 2'b01) ? wave_135 :
                (in == 2'b11) ? wave_225 :
                wave_315;

    nco nco_inst (
        .clk(clk),
        .rst(rst),
        .phase_adjust('0),
        .i_cosine_lu_angle_steps(nco_i_cosine_lu_angle_steps),
        .q_cosine_lu_angle_steps(nco_q_cosine_lu_angle_steps)
    );

    cosine_lut #(
        .READ_PORTS(2)
    ) cosine_lut_inst (
        .in({
            nco_i_cosine_lu_angle_steps,
            nco_q_cosine_lu_angle_steps
        }),
        .out(wave_out)
    );
    
endmodule
