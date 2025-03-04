// this module handles moving data from the AXI4-Stream Data FIFO (came from ps) to the modulator(pl)
`include "params.vh"
module axis_fifo_ctrl_ps2pl (
    input wire clk,
    input wire rst_n,

    // from ps2pl AXI4-Stream Data FIFO
    input  wire [31:0] s_axis_tdata,
    input  wire [3:0]  s_axis_tkeep,
    input  wire        s_axis_tlast,
    output wire        s_axis_tready,
    input  wire        s_axis_tvalid,

    // to modulator
    output reg  data_out_en,
    output wire data_out
);

/*
    state machine states (rough description)
    1. idle : ----> 2 when s_axis_tvalid asserted
    2. stream data_reg_0 & load data_reg_1
       stream data_reg_1 & load data_reg_0 : ----> stay if s_axis_tvalid asserted, else 3
*/
parameter IDLE = 0;
parameter PING_PONG = 1;

reg        state;
reg [4:0]  counter; // 0 ~ 31
reg [31:0] data_reg_0, data_reg_1; // ping pong stream out
reg        data_reg_0_full, data_reg_1_full, data_reg_sel; // 0 -> data_reg_0, 1 -> data_reg_1

assign data_out = data_reg_sel ? data_reg_1[counter] : data_reg_0[counter];
assign s_axis_tready = ~data_reg_0_full | ~data_reg_1_full;

// stream out data to modulator
always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        data_reg_0 <= 32'h00000000;
        data_reg_1 <= 32'h00000000;
        data_reg_0_full <= 1'b0;
        data_reg_1_full <= 1'b0;
        data_reg_sel <= 1'b0;
        counter <= 5'b00000;
        data_out_en <= 1'b0;

        // ---- state ctrl ----//
        state <= IDLE;
    end else begin
        case (state) 
            IDLE : begin 
                data_reg_0 <= s_axis_tdata;
                data_reg_1 <= 32'h00000000;
                data_reg_0_full <= 1'b0;
                data_reg_1_full <= 1'b0;
                data_reg_sel <= 1'b0;
                counter <= 5'b00000;
                data_out_en <= 1'b0;

                if (s_axis_tvalid) begin
                    data_out_en <= 1'b1; // start sending right away in the next clk cycle
                    data_reg_0_full <= 1'b1;

                    // ---- state ctrl ----//
                    state <= PING_PONG;
                end
            end
            PING_PONG : begin
                if (s_axis_tvalid) begin
                    if (~data_reg_sel & ~data_reg_1_full) begin
                        // reg_1 idling and it's not full
                        data_reg_1 <= s_axis_tdata;
                        data_reg_1_full <= 1'b1;
                    end else if (data_reg_sel & ~data_reg_0_full) begin
                        // reg_0 idling and it's not full
                        data_reg_0 <= s_axis_tdata;
                        data_reg_0_full <= 1'b1;
                    end 
                end else begin
                    if (((~data_reg_sel & ~data_reg_1_full) || (data_reg_sel & ~data_reg_0_full)) && counter == 31) begin
                        data_reg_0 <= s_axis_tdata;
                        data_reg_1 <= 32'h00000000;
                        data_reg_1_full <= 1'b0;
                        data_reg_0_full <= 1'b0;
                        data_reg_sel <= 1'b0;
                        counter <= 5'b00000;
                        data_out_en <= 1'b0;

                        // ---- state ctrl ----//
                        state <= IDLE;
                    end else begin
                        // stay in this state and keep pingponging
                        data_out_en <= 1'b1;
                        if (counter == 31) begin
                            counter <= 5'b00000;
                            // stream the non_streaming reg
                            // and mark the streaming reg available for fill
                            data_reg_sel <= ~data_reg_sel;
                            if (data_reg_sel) begin
                                data_reg_1_full <= 1'b0;
                            end else begin
                                data_reg_0_full <= 1'b0;
                            end
                        end else begin
                            counter <= counter + 1;
                        end
                    end
                end
            end
        endcase
    end
end

endmodule