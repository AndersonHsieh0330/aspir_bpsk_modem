module reset_synchronizer (
    input  wire target_clk,
    input  wire async_resetn,
    output wire sync_resetn
);

reset_synchronizer_top reset_synchronizer_top_inst (
    .target_clk(clk),
    .async_resetn(async_resetn),
    .sync_resetn(sync_resetn)
);

endmodule