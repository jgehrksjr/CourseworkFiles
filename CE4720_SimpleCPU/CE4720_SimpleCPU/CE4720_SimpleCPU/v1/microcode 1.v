module microcode_rom (
    input [3:0] uaddr,

    output reg ARload,
    output reg PCinc,
    output reg PCload,
    output reg PCloadZ,
    output reg DRload,
    output reg IRload,
    output reg ACload,
    output reg Zload,
    output reg MemRead,
    output reg MemWrite,

    output reg [2:0] BusSrc,
    output reg ALUsel,
    output reg Select,
    output reg [3:0] NextAddr
);

localparam BUS_NONE = 3'b000;		// for bussSrc
localparam BUS_PC   = 3'b001;
localparam BUS_DR   = 3'b010;
localparam BUS_AC   = 3'b011;
localparam BUS_MEM  = 3'b100;
localparam BUS_ALU  = 3'b101;
localparam BUS_AR   = 3'b110;
localparam ALU_ADD = 1'b0;
localparam ALU_SUB = 1'b1;

always @(*) begin						// load in initial vals
    ARload   = 1'b0;
    PCinc    = 1'b0;
    PCload   = 1'b0;
    PCloadZ  = 1'b0;
    DRload   = 1'b0;
    IRload   = 1'b0;
    ACload   = 1'b0;
    Zload    = 1'b0;
    MemRead  = 1'b0;
    MemWrite = 1'b0;

    BusSrc   = BUS_NONE;
    ALUsel   = ALU_ADD;
    Select   = 1'b0;
    NextAddr = 4'b0000;

    case (uaddr)

        4'b0000: begin            // Fetch1: AR <- PC
            BusSrc   = BUS_PC;
            ARload   = 1'b1;
            NextAddr = 4'b0001;
        end

        4'b0001: begin            // Fetch2: DR <- M[AR], PC <- PC + 1
            BusSrc   = BUS_MEM;
            MemRead  = 1'b1;
            DRload   = 1'b1;
            PCinc    = 1'b1;
            NextAddr = 4'b0010;
        end

        4'b0010: begin            // Fetch3: IR <- DR[7:5], AR <- DR[4:0]
            BusSrc   = BUS_DR;
            IRload   = 1'b1;
            ARload   = 1'b1;
            Select   = 1'b1;      // use MAP instead of the nextaddr
            NextAddr = 4'b0000;   // ignor if sel = 1
        end

        4'b0100: begin            // Load1: DR <- M[AR]
            BusSrc   = BUS_MEM;
            MemRead  = 1'b1;
            DRload   = 1'b1;
            NextAddr = 4'b0101;
        end

        4'b0101: begin            // Load2: AC <- DR
            BusSrc   = BUS_DR;
            ACload   = 1'b1;
            NextAddr = 4'b0000;
        end

        4'b0110: begin            // Store1: DR <- AC
            BusSrc   = BUS_AC;
            DRload   = 1'b1;
            NextAddr = 4'b0111;
        end

        4'b0111: begin					// store2: M[AR] <- DR
            BusSrc   = BUS_DR;
            MemWrite = 1'b1;
            NextAddr = 4'b0000;
        end
		  
		   4'b1000: begin            // Add1: DR <- M[AR
            BusSrc   = BUS_MEM;
            MemRead  = 1'b1;
            DRload   = 1'b1;
            NextAddr = 4'b1001;
        end

        4'b1001: begin            // Add2: AC <- AC + DR
            BusSrc   = BUS_ALU;
            ALUsel   = ALU_ADD;
            ACload   = 1'b1;
            NextAddr = 4'b0000;
        end

        4'b1010: begin            // Sub1: DR <- M[AR]
            BusSrc   = BUS_MEM;
            MemRead  = 1'b1;
            DRload   = 1'b1;
            NextAddr = 4'b1011;
        end

        4'b1011: begin            // Sub2: AC <- AC - DR, Z <- zero_detect
            BusSrc   = BUS_ALU;
            ALUsel   = ALU_SUB;
            ACload   = 1'b1;
            Zload    = 1'b1;
            NextAddr = 4'b0000;
        end

        4'b1100: begin            // Jump: PC <- AR
            BusSrc   = BUS_AR;
            PCload   = 1'b1;
            NextAddr = 4'b0000;
        end

        4'b1110: begin            // JEQ: if Z = 1, PC <- AR
            BusSrc   = BUS_AR;
            PCloadZ  = 1'b1;
            NextAddr = 4'b0000;
        end

        default: begin            // return to Fetch1
            NextAddr = 4'b0000;
        end

    endcase
end

endmodule
