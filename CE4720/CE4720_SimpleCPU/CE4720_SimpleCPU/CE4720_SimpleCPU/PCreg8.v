module PCreg8 (
    input        clk,
    input        reset,         // PC <- 0
    input        PCinc,         // PC <- PC + 1
    input        PCload,        // PC <- d
    input        PCloadZ,       // JEQ
    input        Zflag,         // zero flag from SUB
    input        PCloadAR,      // JUMP load
    input [4:0]  ARLOAD,        // address to load from AR

    input  [7:0] d,
    output reg [7:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 8'b00000000;
        end
        else begin

            if (PCload) begin
                q <= {3'b000, d[4:0]};
            end

            else if (PCloadAR) begin
                // JUMP: load PC directly from AR address.
                q <= {3'b000, ARLOAD};
            end

            else if (PCloadZ && Zflag) begin
                // JEQ: load PC directly from AR address if Zflag is set.
                q <= {3'b000, ARLOAD};
            end

            else if (PCinc) begin //increment
                q <= q + 8'd1;
            end
        end
    end

endmodule