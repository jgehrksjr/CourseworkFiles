module IRreg3 (
    input clk,
    input load,
    input [7:0] d,  //8 bit register
    output reg [2:0] q  //8 bit output
);
    always @(posedge clk) begin  //high edge
        if (load)
            q <= d[7:5];
    end
endmodule