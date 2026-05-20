module map_logic (
    input            clock,
    input      [2:0] opcode,
    input            reset,
    input      [4:0] next_addr,   // Kept but not used in this version.

    output reg [4:0] map_addr
);

    reg [4:0] next_map_addr;

    // --------------------------------------------------
    // Microstate names
    // --------------------------------------------------

    localparam FETCH1       = 5'b00000; // AR <- PC
    localparam FETCH_WAIT1  = 5'b00001; // wait for memory/address
    localparam FETCH_WAIT2  = 5'b00010; // extra wait
    localparam FETCH_READ   = 5'b00011; // DR <- MEM, PC++
    localparam FETCH_LATCH  = 5'b10000; // IR <- DR, AR <- DR[4:0]

    localparam DECODE       = 5'b11110;

    localparam LOAD_WAIT    = 5'b00100; // wait for M[AR]
    localparam LOAD_READ    = 5'b00101; // DR <- MEM
    localparam LOAD_AC      = 5'b10001; // AC <- DR

    localparam STORE1       = 5'b00110; // DR <- AC
    localparam STORE2       = 5'b00111; // M[AR] <- DR

    localparam ADD_WAIT     = 5'b01000; // wait for M[AR]
    localparam ADD_READ     = 5'b01001; // DR <- MEM
    localparam ADD_AC       = 5'b10010; // AC <- AC + DR

    localparam SUB_WAIT     = 5'b01010; // wait for M[AR]
    localparam SUB_READ     = 5'b01011; // DR <- MEM
    localparam SUB_AC       = 5'b10011; // AC <- AC - DR

    localparam JUMP1        = 5'b01100; // PC <- AR
    localparam JEQ1         = 5'b01110; // if Zflag, PC <- AR

    localparam HALT         = 5'b11111;

    // --------------------------------------------------
    // Opcode names
    // --------------------------------------------------

    localparam OP_LOAD      = 3'b000;
    localparam OP_STORE     = 3'b001;
    localparam OP_ADD       = 3'b010;
    localparam OP_SUB       = 3'b011;
    localparam OP_JUMP      = 3'b100;
    localparam OP_JEQ       = 3'b101;
    localparam OP_END       = 3'b111;

    // --------------------------------------------------
    // Next-state logic
    // --------------------------------------------------

    always @(*) begin
        next_map_addr = FETCH1;

        case (map_addr)

            // ----------------------------
            // Fetch sequence
            // ----------------------------

            FETCH1: begin
                next_map_addr = FETCH_WAIT1;
            end

            FETCH_WAIT1: begin
                next_map_addr = FETCH_WAIT2;
            end

            FETCH_WAIT2: begin
                next_map_addr = FETCH_READ;
            end

            FETCH_READ: begin
                next_map_addr = FETCH_LATCH;
            end

            FETCH_LATCH: begin
                next_map_addr = DECODE;
            end

            // ----------------------------
            // Decode
            // ----------------------------

            DECODE: begin
                case (opcode)
                    OP_LOAD:  next_map_addr = LOAD_WAIT;
                    OP_STORE: next_map_addr = STORE1;
                    OP_ADD:   next_map_addr = ADD_WAIT;
                    OP_SUB:   next_map_addr = SUB_WAIT;
                    OP_JUMP:  next_map_addr = JUMP1;
                    OP_JEQ:   next_map_addr = JEQ1;
                    OP_END:   next_map_addr = HALT;
                    default:  next_map_addr = FETCH1;
                endcase
            end

            // ----------------------------
            // LOAD
            // ----------------------------

            LOAD_WAIT: begin
                next_map_addr = LOAD_READ;
            end

            LOAD_READ: begin
                next_map_addr = LOAD_AC;
            end

            LOAD_AC: begin
                next_map_addr = FETCH1;
            end

            // ----------------------------
            // STORE
            // ----------------------------

            STORE1: begin
                next_map_addr = STORE2;
            end

            STORE2: begin
                next_map_addr = FETCH1;
            end

            // ----------------------------
            // ADD
            // ----------------------------

            ADD_WAIT: begin
                next_map_addr = ADD_READ;
            end

            ADD_READ: begin
                next_map_addr = ADD_AC;
            end

            ADD_AC: begin
                next_map_addr = FETCH1;
            end

            // ----------------------------
            // SUB
            // ----------------------------

            SUB_WAIT: begin
                next_map_addr = SUB_READ;
            end

            SUB_READ: begin
                next_map_addr = SUB_AC;
            end

            SUB_AC: begin
                next_map_addr = FETCH1;
            end

            // ----------------------------
            // JUMP / JEQ
            // ----------------------------

            JUMP1: begin
                next_map_addr = FETCH1;
            end

            JEQ1: begin
                next_map_addr = FETCH1;
            end

            // ----------------------------
            // HALT
            // ----------------------------

            HALT: begin
                next_map_addr = HALT;
            end

            default: begin
                next_map_addr = FETCH1;
            end

        endcase
    end

    // --------------------------------------------------
    // Registered micro-address
    // --------------------------------------------------

    always @(posedge clock) begin
        if (reset == 1'b1) begin
            map_addr <= FETCH1;
        end
        else begin
            map_addr <= next_map_addr;
        end
    end

endmodule