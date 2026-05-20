module BusBufferSigs (
   input clk,
   input [2:0] BusSrc,
   output reg BUS_PC,
   output reg BUS_DR,
   output reg BUS_AC,
   output reg BUS_MEM,
   output reg BUS_ALU,
   output reg BUS_AR
);

always @(posedge clk) 
	begin  //high edge
		case (BusSrc)
		
			3'b000: //None
			begin
				BUS_PC = 	1'b0;
				BUS_DR = 	1'b0;
				BUS_AC = 	1'b0;
				BUS_MEM = 	1'b0;
				BUS_ALU = 	1'b0;
				BUS_AR = 	1'b0;
         end
		
			3'b001: //PC Bus
			begin
				BUS_PC = 	1'b1;
				BUS_DR = 	1'b0;
				BUS_AC = 	1'b0;
				BUS_MEM = 	1'b0;
				BUS_ALU = 	1'b0;
				BUS_AR = 	1'b0;
         end
			
			3'b010: //DR Bus
			begin
				BUS_PC = 	1'b0;
				BUS_DR = 	1'b1;
				BUS_AC = 	1'b0;
				BUS_MEM = 	1'b0;
				BUS_ALU = 	1'b0;
				BUS_AR = 	1'b0;
         end
			
			3'b011: //AC BUS
			begin
				BUS_PC = 	1'b0;
				BUS_DR = 	1'b0;
				BUS_AC = 	1'b1;
				BUS_MEM = 	1'b0;
				BUS_ALU = 	1'b0;
				BUS_AR = 	1'b0;
         end
			
			3'b100: //MEM Bus
			begin
				BUS_PC = 	1'b0;
				BUS_DR = 	1'b0;
				BUS_AC = 	1'b0;
				BUS_MEM = 	1'b1;
				BUS_ALU = 	1'b0;
				BUS_AR = 	1'b0;
         end
			3'b100: //ALU Bus 
			begin
				BUS_PC = 	1'b0;
				BUS_DR = 	1'b0;
				BUS_AC = 	1'b0;
				BUS_MEM = 	1'b0;
				BUS_ALU = 	1'b1;
				BUS_AR = 	1'b0;
         end
			
			3'b110: //AR BUS
			begin
				BUS_PC = 	1'b0;
				BUS_DR = 	1'b0;
				BUS_AC = 	1'b0;
				BUS_MEM = 	1'b0;
				BUS_ALU = 	1'b0;
				BUS_AR = 	1'b1;
         end
			
			default: //all off
			begin
				BUS_PC = 	1'b0;
				BUS_DR = 	1'b0;
				BUS_AC = 	1'b0;
				BUS_MEM = 	1'b0;
				BUS_ALU = 	1'b0;
				BUS_AR = 	1'b0;
         end
		endcase
   end
endmodule