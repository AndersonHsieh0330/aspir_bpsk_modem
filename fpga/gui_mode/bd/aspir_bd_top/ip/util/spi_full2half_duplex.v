module spi_full2half_duplex (
    input  wire sclk_in,
    input  wire ss_in,
    input  wire mosi_in,
    output wire miso_out,

    output wire sclk_out,
    output wire ss_out,
    inout  wire sdio_out
);

// Andy's initial RTL, not tested
// added into synth & pnr so the module isn't a black box

// 0: master -> slave
// 1: slave -> master
wire direction_select;
reg [7:0] instruction_bit_counter; // keep track of instruction bit count
reg rw;                           // store rw of transfer to see determine direction of inout after instruction phase
reg instruction_done;             // store when instruction completes to assign a direction to the inout
parameter INSTRUCTION_LENGTH = 10; // temp, anderson added this to fix the syntax error. uneducated number

assign sclk_out = sclk_in;
assign ss_out = ss_in;
assign direction_select = instruction_done ? (rw ? 1'b1 : 1'b0) : 1'b0;
assign sdio_out = direction_select ? 'bz : mosi_in;
assign miso_out = sdio_out;

always @ (posedge sclk_in) begin

    if (ss_in == 1'b1) begin
        instruction_bit_counter <= 8'h00; 
        instruction_done <= 1'b1;
    end else if (!ss_in && instruction_bit_counter == 8'h00) begin  // conditions for start of transfer
        instruction_bit_counter <= 8'd1;
        rw <= mosi_in;         // rw bit is first bit in instruction. save it so we know which way the inout is after the 2 instruction bytes 
    end else if (!ss_in) begin // increment the instruction counter on every cycle
        instruction_bit_counter <= instruction_bit_counter + 1;
        if (instruction_bit_counter == INSTRUCTION_LENGTH) // condition for end of instruction phase (16 bits)
            instruction_done <= 1'b1;
    end

end

endmodule