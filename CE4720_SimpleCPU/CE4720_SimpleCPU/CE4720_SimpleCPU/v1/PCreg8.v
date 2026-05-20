module PCreg8 (
    input        clk,
    input        reset,			// PC <- 0
    input        PCinc,      // PC <- PC + 1
    input        PCload,     // PC <- d
    input        PCloadZ,    // JEQ
    input        Zflag,      // zero flag from SUB

    input  [7:0] d,
    output reg [7:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 8'b00000000;
        end
        else if (PCload || (PCloadZ && Zflag)) begin
            q <= d;
        end
        else if (PCinc) begin
            q <= q + 8'b00000001;
        end
    end

endmodule