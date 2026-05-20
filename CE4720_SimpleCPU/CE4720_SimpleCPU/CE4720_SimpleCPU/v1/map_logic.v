module map_logic (
	input       clock,
   input [2:0] opcode, 				// This will come from the instruction register. What ever the user has placed in their code.
	input       SelectPath,  		// When the state Machine gets to Fetch3, and we need to branch to something else, set SelectPath.
	input [3:0] next_addr, 			// This is the default flow for the state machine. How we move through fetch states and within each op-path.
	
   output reg [3:0] map_addr 		// This is the next microoperation.
);

always @(posedge clock)
begin
		if (SelectPath)
		begin
			case (opcode)
				 3'b000: map_addr = 4'b0100; 	// Load1
				 3'b001: map_addr = 4'b0110; 	// Store1
				 3'b010: map_addr = 4'b1000; 	// Add1
				 3'b011: map_addr = 4'b1010; 	// Sub1
				 3'b100: map_addr = 4'b1100; 	// Jump
				 3'b101: map_addr = 4'b1110; 	// JEQ
				default: map_addr = 4'b0000; 	// return to Fetch1
			endcase
		end
		else
		begin
			map_addr = next_addr;
		end
end

endmodule