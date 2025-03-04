// this module handles moving data from the AXI4-Stream Data FIFO (came from ps) to the modulator(pl)
`include "params.vh"
module ps2pl_stream_ctrl (
    input wire clk,
    input wire rst_n,

    // from ps2pl AXI4-Stream Data FIFO
    input  wire [31:0] m_axis_tdata,
    input  wire [3:0]  m_axis_tkeep,
    input  wire        m_axis_tlast,
    output wire        m_axis_tready,
    input  wire        m_axis_tvalid,

    // to modulator
    output wire data_out_en,
    output wire data_out
);
endmodule