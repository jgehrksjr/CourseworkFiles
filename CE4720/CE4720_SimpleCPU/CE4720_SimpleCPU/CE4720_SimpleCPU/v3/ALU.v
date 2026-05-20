module ALUTest (
   input 				clk,			// Clock input
   input [7:0] 		a,				// 8 bit input a
   input [7:0] 		b,  			// 8 bit input b
	input [1:0]			ALUSel,		// selection bit for the operation
   output reg [7:0]  q,  			//8 bit output
	output 				Zflag
);

	localparam ALU_ADD = 2'b00;
	localparam ALU_SUB = 2'b01;
	
    always @(*) begin
        case (ALUSel)
            ALU_ADD: q = a + b;   // AC + DR
            ALU_SUB: q = a - b;   // AC - DR

            default: q = 8'b00000000;
        endcase
    end

    assign Zflag = (q == 8'b00000000);

endmodule