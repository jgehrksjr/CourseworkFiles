module reg4 (
   input 				clk,
   input 	  [4:0]  d, 	 		//4 bit register
   output reg [4:0]  q  	 		//4 bit output
);
   always @(posedge clk) begin  	//rising edge
		q = d;
   end
endmodule