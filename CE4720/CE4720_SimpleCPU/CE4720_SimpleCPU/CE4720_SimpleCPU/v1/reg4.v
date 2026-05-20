module reg4 (
   input 				clk,
   input 	  [3:0]  d, 	 		//4 bit register
   output reg [3:0]  q  	 		//4 bit output
);
   always @(posedge clk) begin  	//rising edge
      q <= d;
   end
endmodule