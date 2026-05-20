module ARreg8 (
    input clk,
    input load,
    input [7:0] d,  //8 bit register
    output reg [4:0] q  //8 bit output
);
    always @(posedge clk) begin  //high edge		  
		  if (load)
            q <= d[4:0];
    end
endmodule