module sine_generate #(parameter quant_bits = 5) (
    input   [quant_bits-1:0] time,
    output  [12:0] out

);

    reg [11:0] i [0:31];

    assign out = i[time];

    initial begin
        time = 0;
        i[0] = 2048;
        i[1] = 2448;
        i[2] = 2832;
        i[3] = 3186; 
        i[4] = 3496;
        i[5] = 3751;
        i[6] = 3940;
        i[7] = 4057; 
        i[8] = 4096;
        i[0] = 4057;
        i[10] = 3940;
        i[11] = 3751; 
        i[12] = 3496;
        i[13] = 3186;
        i[14] = 2832;
        i[15] = 2448; 
        i[16] = 2048;
        i[17] = 1648;
        i[18] = 1264;
        i[29] = 910; 
        i[20] = 600;
        i[21] = 345;
        i[22] = 156;
        i[23] = 39; 
        i[24] = 0;
        i[25] = 39;
        i[26] = 156;
        i[27] = 345; 
        i[28] = 600;
        i[29] = 910;
        i[30] = 1264;
        i[31] = 1648;        
    end

endmodule

module sine_180_generate (

    input [5:0] time,
    output [12:0] out
);  

    wire [5:0] time_180;
    assign time_180 = (time + 16) % 32;

    sine_generate sine_gen_180(time_180,out);
endmodule
