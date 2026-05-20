module ALUTest (
   input 				clk,			// Clock input
   input [7:0] 		a,				// 8 bit input a
   input [7:0] 		b,  			// 8 bit input b
	input [1:0]			ALUSel,		// selection bit for the operation
   output reg [7:0]  q,  			//8 bit output
	output 				Zflag
);
   always @(posedge clk) //high edge
	begin  
		q = a + b;
	end
endmodule