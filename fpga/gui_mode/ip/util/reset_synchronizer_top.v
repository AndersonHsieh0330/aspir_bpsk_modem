// output resetn has async assertion, sync de-assertion to the target clk
// https://www.edaboard.com/threads/why-is-a-reset-with-asynchronous-assert-safe.403789/#post-1739577
// https://semiconshorts.com/2022/07/30/reset-synchronizer/
module reset_synchronizer_top (
    input  wire target_clk,
    input  wire async_resetn,
    output wire sync_resetn
);

reg Q1, Q2;

assign sync_resetn = Q2;

always @ (posedge target_clk, negedge async_resetn) begin
    if(!async_resetn) begin
        Q1 <= 1'b0;
        Q2 <= 1'b0;
    end else begin
        Q1 <= 1'b1;
        Q2 <= Q1;
    end
end
endmodule