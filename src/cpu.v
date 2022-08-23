module cpu(
    input       clk,
    input       reset
);
    // alu
    wire [31:0] DATA1;
    wire [31:0] ALU_OUTPUT;

    // decoder - program counter
    wire        JUMP_ENABLE;
    // wire [31:0] JUMP_ADDR;

    // program counter - inst fetch - decoder
    wire [31:0] PC_NEXT;
    wire [31:0] PC;
    
    // decoder - register
    wire [31:0] INST;
    wire [4:0]  RS1_ADDR;
    wire [4:0]  RS2_ADDR;
    wire [4:0]  WADDR;
    wire [7:0]  OPCODE;
    wire [31:0] IMM_NUMBER;
    wire        RS1_ENABLE;
    wire        RS2_ENABLE;
    wire        W_ENABLE;
    wire        IMM_ENABLE;

    // register - alu
    wire [31:0] RS1;
    wire [31:0] RS2;
    wire [31:0] WB_DATA;

    // decoder - selecter - alu
    wire [31:0] DATA2;

    pc pc(
        .clk(clk),
        .reset(reset),
        .jump_enable(JUMP_ENABLE),
        .pc(PC),
        .pc_next(PC_NEXT)
    );

    instr_memory instr_memory(
        .Addr(PC),
        .INST(INST)
    );
    
    decoder decoder(
        // instr_memory
        .instr(INST),
        
        // register
        .rs1_addr(RS1_ADDR),
        .rs2_addr(RS2_ADDR),
        .w_addr(WADDR),
        .r1_enable(RS1_ENABLE),
        .r2_enable(RS2_ENABLE),
        .w_enable(W_ENABLE),

        //alu
        .imm_number(IMM_NUMBER),
        .imm_enable(IMM_ENABLE),
        .aluop(OPCODE),

        // program counter
        .jump_enable(JUMP_ENABLE)
    );

    regfile register(
        // self
        .clk(clk),
        .rst(reset),

        // decoder
        .w_enable(W_ENABLE),
        .r1_enable(RS1_ENABLE),
        .r2_enable(RS2_ENABLE),

        .rs1_addr(RS1_ADDR),
        .rs2_addr(RS2_ADDR),
        .wb_addr(WADDR),
        
        // alu
        .wb_data(WB_DATA),
        .rs1(RS1),
        .rs2(RS2)
    );

    // pc - alu_data1
    MUX2to1_32bit mux_data1(
        .I0(RS1),
        .I1(PC),
        .s(JUMP_ENABLE), // need to change while B/U Type
        .f(DATA1)
    );

    // imm
    MUX2to1_32bit mux_imm(
        .I0(RS2),
        .I1(IMM_NUMBER),
        .s(IMM_ENABLE),
        .f(DATA2)
    );
    MUX4to1_32bit mux_wb(
        .I0(ALU_OUTPUT),
        .I1(PC_NEXT),
        .I2(0),
        .I3(0),
        .s(2'h0),
        .f(WB_DATA)
    );

    alu alu0(
        .a(RS1),
        .b(DATA2),
        .op(OPCODE),
        .y(ALU_OUTPUT)
    );

endmodule