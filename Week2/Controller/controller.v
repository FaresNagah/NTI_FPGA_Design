module controller(
    input  wire       zero, 
    input  wire       rst,
    input  wire [2:0] opcode, 
    input  wire [2:0] phase,
    output reg        sel, 
    output reg        rd, 
    output reg        ld_ir, 
    output reg        halt, 
    output reg        inc_pc, 
    output reg        ld_ac, 
    output reg        ld_pc, 
    output reg        wr, 
    output reg        data_e
);

    // Opcodes
    localparam HLT = 3'b000;
    localparam SKZ = 3'b001;
    localparam ADD = 3'b010;
    localparam AND = 3'b011;
    localparam XOR = 3'b100;
    localparam LDA = 3'b101;
    localparam STO = 3'b110;
    localparam JMP = 3'b111;

    // Phases
    localparam INST_ADDR  = 3'b000;
    localparam INST_FETCH = 3'b001;
    localparam INST_LOAD  = 3'b010;
    localparam IDLE       = 3'b011;
    localparam OP_ADDR    = 3'b100;
    localparam OP_FETCH   = 3'b101;
    localparam ALU_OP     = 3'b110;
    localparam STORE      = 3'b111;

    // Internal condition flags
    wire aluop   = (opcode == ADD) || (opcode == AND) || (opcode == XOR) || (opcode == LDA);
    wire is_halt = (opcode == HLT);
    wire jmp     = (opcode == JMP);
    wire sto     = (opcode == STO);
    wire skz     = (opcode == SKZ);

    always @(*) begin
        // 1. تصفير كل الإشارات افتراضياً لمنع حدوث Latches
        sel    = 1'b0;
        rd     = 1'b0;
        ld_ir  = 1'b0;
        halt   = 1'b0;
        inc_pc = 1'b0;
        ld_ac  = 1'b0;
        ld_pc  = 1'b0;
        wr     = 1'b0;
        data_e = 1'b0;

        if (rst) begin
            sel = 1'b1;
        end else begin
            case (phase)
                INST_ADDR: begin
                    sel = 1'b1;
                end

                INST_FETCH: begin
                    sel = 1'b1;
                    rd  = 1'b1;
                end

                INST_LOAD: begin
                    sel   = 1'b1;
                    rd    = 1'b1;
                    ld_ir = 1'b1;
                end

                IDLE: begin
                    sel   = 1'b1;
                    rd    = 1'b1;
                    ld_ir = 1'b1;
                end

                OP_ADDR: begin
                    halt   = is_halt;
                    inc_pc = 1'b1;
                end

                OP_FETCH: begin
                    rd = aluop;
                end

                ALU_OP: begin
                    rd     = aluop;
                    inc_pc = (skz && zero);
                    ld_pc  = jmp;
                    data_e = sto;
                end

                STORE: begin
                    rd     = aluop;
                    ld_ac  = aluop;
                    ld_pc  = jmp;
                    wr     = sto;
                    data_e = sto;
                end

                default: ; // ستبقى كل الإشارات أصفاراً بفضل القيم الافتراضية
            endcase
        end
    end

endmodule