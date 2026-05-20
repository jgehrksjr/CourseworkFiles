module microcode_rom (
    input [4:0] uaddr,

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
    output reg PCloadAR,

    output reg BUS_PC,
    output reg BUS_DR,
    output reg BUS_AC,
    output reg BUS_MEM,
    output reg BUS_ALU,

    output reg [1:0] ALUsel
);

    localparam ALU_ADD = 2'b00;
    localparam ALU_SUB = 2'b01;

    always @(*) begin

        // --------------------------------------------------
        // Default all control signals OFF
        // --------------------------------------------------

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
        PCloadAR = 1'b0;

        BUS_PC   = 1'b0;
        BUS_DR   = 1'b0;
        BUS_AC   = 1'b0;
        BUS_MEM  = 1'b0;
        BUS_ALU  = 1'b0;

        ALUsel   = ALU_ADD;

        case (uaddr)

            // --------------------------------------------------
            // FETCH SEQUENCE
            // --------------------------------------------------

            5'b00000: begin
                // FETCH1: AR <- PC
                BUS_PC = 1'b1;
                ARload = 1'b1;
            end

            5'b00001: begin
                // FETCH_WAIT1: begin memory read early
                BUS_MEM = 1'b1;
                MemRead = 1'b1;
            end

            5'b00010: begin
                // FETCH_WAIT2: keep memory read active
                BUS_MEM = 1'b1;
                MemRead = 1'b1;
            end

            5'b00011: begin
                // FETCH_READ: DR <- MEM_OUT, PC <- PC + 1
                BUS_MEM = 1'b1;
                MemRead = 1'b1;
                DRload  = 1'b1;
                PCinc   = 1'b1;
            end

            5'b10000: begin
                // FETCH_LATCH: IR <- DR[7:5], AR <- DR[4:0]
                BUS_DR = 1'b1;
                IRload = 1'b1;
                ARload = 1'b1;
            end

            5'b11110: begin
                // DECODE
                // No control signals. map_logic uses opcode here.
            end

            // --------------------------------------------------
            // LOAD
            // --------------------------------------------------

            5'b00100: begin
                // LOAD_WAIT: begin memory read from operand address
                BUS_MEM = 1'b1;
                MemRead = 1'b1;
            end

            5'b00101: begin
                // LOAD_READ: DR <- MEM_OUT
                BUS_MEM = 1'b1;
                MemRead = 1'b1;
                DRload  = 1'b1;
            end

            5'b10001: begin
                // LOAD_AC: AC <- DR
                BUS_DR = 1'b1;
                ACload = 1'b1;
            end

            // --------------------------------------------------
            // STORE
            // --------------------------------------------------

            5'b00110: begin
                // STORE1: DR <- AC
                BUS_AC = 1'b1;
                DRload = 1'b1;
            end

            5'b00111: begin
                // STORE2: M[AR] <- DR
                BUS_DR   = 1'b1;
                MemWrite = 1'b1;
            end

            // --------------------------------------------------
            // ADD
            // --------------------------------------------------

            5'b01000: begin
                // ADD_WAIT: begin memory read from operand address
                BUS_MEM = 1'b1;
                MemRead = 1'b1;
            end

            5'b01001: begin
                // ADD_READ: DR <- MEM_OUT
                BUS_MEM = 1'b1;
                MemRead = 1'b1;
                DRload  = 1'b1;
            end

            5'b10010: begin
                // ADD_AC: AC <- AC + DR
                BUS_ALU = 1'b1;
                ALUsel  = ALU_ADD;
                ACload  = 1'b1;
            end

            // --------------------------------------------------
            // SUB
            // --------------------------------------------------

            5'b01010: begin
                // SUB_WAIT: begin memory read from operand address
                BUS_MEM = 1'b1;
                MemRead = 1'b1;
            end

            5'b01011: begin
                // SUB_READ: DR <- MEM_OUT
                BUS_MEM = 1'b1;
                MemRead = 1'b1;
                DRload  = 1'b1;
            end

            5'b10011: begin
                // SUB_AC: AC <- AC - DR, update Zflag
                BUS_ALU = 1'b1;
                ALUsel  = ALU_SUB;
                ACload  = 1'b1;
                Zload   = 1'b1;
            end

            // --------------------------------------------------
            // JUMP
            // --------------------------------------------------

            5'b01100: begin
                // JUMP: PC <- AR
                PCloadAR = 1'b1;
            end

            // --------------------------------------------------
            // JEQ
            // --------------------------------------------------

            5'b01110: begin
                // JEQ: if Zflag = 1, PC <- AR
                PCloadZ = 1'b1;
            end

            // --------------------------------------------------
            // HALT / END
            // --------------------------------------------------

            5'b11111: begin
                // HALT
                // No control signals.
                // IR_OUT should remain 111 so MDenable can stay active.
            end

            default: begin
                // Defaults already turn everything off.
            end

        endcase
    end

endmodule