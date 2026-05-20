module ALUTest (
   input                clk,       // Clock input
   input                Zload,     // Control signal to set flag
   input [7:0]          a,         // 8 bit input a (AC)
   input [7:0]          b,         // 8 bit input b (DR)
   input [1:0]          ALUSel,    // selection bit for the operation
   
   output reg [7:0]     q,         // 8 bit output
   output reg           Zflag      // Zero flag
);
    
    always @(*) begin
        case (ALUSel)
            2'b00: q = a + b;   //Add AC + DR
            2'b01: q = a - b;   //Subtract AC - DR
            default: q = 8'b00000000;
        endcase
    end

    always @(posedge clk) begin
        if (Zload) begin
            Zflag <= (q == 8'b00000000); //If q = 0, then set z flag
        end
    end

endmodule