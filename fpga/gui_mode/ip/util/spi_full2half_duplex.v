module spi_full2half_duplex (
    input  wire sclk_in,
    input  wire ss_in,
    input  wire mosi_in,
    output wire miso_out,

    output wire sclk_out,
    output wire ss_out,
    inout  wire sdio_out
);

assign sclk_out = sclk_in;
assign ss_out = ss_in;
assign sdio_out = miso_in & mosi_in;

endmodule