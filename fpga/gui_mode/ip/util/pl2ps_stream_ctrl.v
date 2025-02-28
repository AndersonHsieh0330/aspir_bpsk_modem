// this module handles sending data from demodulator(pl) into the AXI4-Stream Data FIFO that eventual goes to ps
`include "params.vh"
module pl2ps_stream_ctrl (
    input  wire clk,
    input  wire rst_n,

    // from demodulator
    input  wire signed data_in, // single bit data

    // to pl2ps AXI4-Stream Data FIFO
    output wire [31:0] s_axis_tdata,
    output wire [3:0]  s_axis_tkeep,
    output wire        s_axis_tlast,
    input  wire        s_axis_tready,
    output wire        s_axis_tvalid
);
endmodule