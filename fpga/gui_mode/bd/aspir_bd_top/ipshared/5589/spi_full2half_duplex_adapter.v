module spi_full2half_duplex_adapter (
    input  wire sclk_in,
    input  wire ss_in,
    input  wire mosi_in,
    output wire miso_out,

    output wire sclk_out,
    output wire ss_out,
    inout  wire sdio_out
);

spi_full2half_duplex spi_full2half_duplex_inst (
    .sclk_in(sclk_in),
    .ss_in(ss_in),
    .mosi_in(mosi_in),
    .miso_out(miso_out),
    .sclk_out(sclk_out),
    .ss_out(ss_out),
    .sdio_out(sdio_out)
);

endmodule