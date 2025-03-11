// this module handles sending data from demodulator(pl) into the AXI4-Stream Data FIFO that eventual goes to ps
`include "params.vh"
module axis_fifo_ctrl_pl2ps #(
    parameter PACKET_START_SEQUENCE = `ETHERNET_SFD
) (
    input  wire clk,
    input  wire rst_n,

    // from demodulator
    input  wire signed data_in, // single bit data

    // to pl2ps AXI4-Stream Data FIFO
    output wire [31:0] m_axis_tdata,
    output wire [3:0]  m_axis_tkeep,
    output wire        m_axis_tlast,
    input  wire        m_axis_tready,
    output reg         m_axis_tvalid
);

reg [4:0]  counter; // 0 ~ 31
reg [31:0] data_reg;
reg [7:0]  preamble_reg;
reg        preamble_detected;

assign m_axis_tlast = 1'b0; // held low for unpacketized stream
assign m_axis_tdata = data_reg;
assign m_axis_tkeep = 4'b1111; // all bytes are valid data

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        counter <= 5'b00000;
        preamble_reg <= 8'h00;
        preamble_detected <= 1'b0;
        m_axis_tvalid <= 1'b0;
        data_reg <= 8'h00;
    end else if (preamble_detected) begin
        if (counter == 31 && m_axis_tvalid) begin
            if (m_axis_tready & m_axis_tvalid) begin
                // transaction done
                counter <= 5'b00000;
                preamble_reg <= 8'h00;
                preamble_detected <= 1'b0;
                m_axis_tvalid <= 1'b0;
                data_reg <= 8'h00;
            end else begin
                // wait for m_axis_tready to go HIGH
                m_axis_tvalid <= 1'b1;
                data_reg <= data_reg;
            end
        end else begin
            data_reg[counter] <= data_in;
            if (counter == 31) begin
                m_axis_tvalid <= 1'b1; // last bit is loaded in the current cycle, start sending right away
            end else begin
                counter <= counter + 1;
            end
        end
    end else begin
        preamble_reg <= {preamble_reg[6:0], data_in};
        if ({preamble_reg[6:0], data_in} == PACKET_START_SEQUENCE) begin
            preamble_detected <= 1'b1;
        end else begin
            preamble_detected <= 1'b0;
        end
    end
end

endmodule