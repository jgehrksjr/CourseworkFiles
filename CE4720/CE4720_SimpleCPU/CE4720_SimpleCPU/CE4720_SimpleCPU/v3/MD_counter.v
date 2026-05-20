module MD_counter(
    input clk,
    input reset,
    input MDenable,

    output reg [4:0] MD_addr
);

always @(posedge clk) begin
    if (reset)
        MD_addr <= 5'b00000;
    else if (MDenable)
        MD_addr <= MD_addr + 1;
end

endmodule