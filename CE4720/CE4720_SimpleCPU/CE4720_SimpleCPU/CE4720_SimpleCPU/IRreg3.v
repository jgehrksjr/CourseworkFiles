module IRreg3 (
    input clk,
    input load,
    input [7:0] d,
    output reg [2:0] q,
    output MDenable
);

    always @(posedge clk) begin
        if (load)
            q <= d[7:5];
    end

    assign MDenable = (q == 3'b111);

endmodule