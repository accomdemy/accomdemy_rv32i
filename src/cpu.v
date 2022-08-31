module cpu(
    input       clk,
    input       reset
);
    // alu
    wire [31:0] DATA1;
    wire [31:0] DATA2;
    // alu - register
    wire [31:0] ALU_OUTPUT;

    // decoder - program counter
    wire        JUMP_ENABLE;

    // program counter - inst fetch - decoder
    wire [31:0] PC_NEXT;
    wire [31:0] PC;
    
    // decoder - register
    wire [31:0] INST;
    wire [4:0]  RS1_ADDR;
    wire [4:0]  RS2_ADDR;
    wire [4:0]  WADDR;
    wire [31:0] IMM_NUMBER;
    wire        RS1_ENABLE;
    wire        RS2_ENABLE;
    wire        W_ENABLE;
    wire        IMM_ENABLE;
    wire        PC_ENABLE;

    // decoder - alu
    wire [7:0]  OPCODE;
    
    // register - alu
    wire [31:0] RS1;
    wire [31:0] RS2;
    wire [31:0] WB_DATA;

    // decoder - branch
    wire BRANCH_MODULE_EN;
    wire [2:0] BRANCH_OP;
    
    // branch - pc
    wire BRANCH_EN;

    pc pc(
        .clk(clk),                  // input external clock signal
        .reset(reset),              // input external reset signal
        .jmp_en(JUMP_ENABLE),       // input switch pc between pc_next and jmp
        .branch_en(BRANCH_EN),      // input switch pc between pc_next and jmp
        .jmp(ALU_OUTPUT),           // input caculate new pc from alu
        .pc(PC),                    // output program counter
        .pc_next(PC_NEXT)           // output PC+4
    );

    instr_memory instr_memory(
        .addr(PC),          // input current program address
        .prog(INST)         // output current opcode
    );
    
    decoder decoder(
        // instr_memory
        .prog(INST),            // input current opcode
        
        // register
        .ra1(RS1_ADDR),         // output register source 1 address
        .ra2(RS2_ADDR),         // output register source 2 address
        .wa(WADDR),             // output register destination address
        .re1(RS1_ENABLE),       // output register source 1 request
        .re2(RS2_ENABLE),       // output register source 2 request
        .we(W_ENABLE),          // output register destination request

        //alu
        .imm(IMM_NUMBER),       // output immediate number
        .imme(IMM_ENABLE),      // output switch alu-data2 between register source 2 and immediate number
        .pce(PC_ENABLE),        // output switch alu-data1 between register source 1 and program counter
        .aluop(OPCODE),         // output alu opcode

        // program counter
        .jmpe(JUMP_ENABLE),     // output switch pc between pc_next and jmp

        // branch
        .be(BRANCH_MODULE_EN),  // output enable branch when b-type
        .bop(BRANCH_OP)         // output opcode funct3 for branch
    );

    regfile register(
        // self
        .clk(clk),          // input external clock signal
        .reset(reset),      // input external reset signal

        // decoder
        .we(W_ENABLE),      // input register destination request
        .re1(RS1_ENABLE),   // input register source 1 request
        .re2(RS2_ENABLE),   // input register source 2 request

        .ra1(RS1_ADDR),     // input register source 1 address
        .ra2(RS2_ADDR),     // input register source 2 address
        .wa(WADDR),         // input register destination address
        
        // alu
        .wdata(WB_DATA),    // input register destination value  (not implemented)
        .rs1(RS1),        // output register source 1 value
        .rs2(RS2)         // output register source 2 value
    );

    // pc - alu_data1
    MUX2to1_32bit mux_data1(
        .I0(RS1),           // input register source 1 value
        .I1(PC),            // input current program counter
        .s(PC_ENABLE),      // input switch alu-data1 between register source 1 and program counter
        .f(DATA1)           // output for alu-data1
    );

    // imm
    MUX2to1_32bit mux_data2(
        .I0(RS2),           // input register source 2 value
        .I1(IMM_NUMBER),    // input immediate number
        .s(IMM_ENABLE),     // input switch alu-data2 between register source 2 and immediate number
        .f(DATA2)           // output for alu-data2
    );

    MUX4to1_32bit mux_wb(
        .I0(ALU_OUTPUT),
        .I1(PC_NEXT),
        .I2(0),
        .I3(0),
        .s({1'b0,JUMP_ENABLE}),
        .f(WB_DATA)
    );


    alu alu0(
        .data1(DATA1),      // input from mux_data1
        .data2(DATA2),      // input from mux_imm
        .op(OPCODE),        // input alu opcode
        .res(ALU_OUTPUT)    // output executed value
    );
    
    branch branch0(
        .en(BRANCH_MODULE_EN),  // input enable by decoder when b-type
        .op(BRANCH_OP),         // opcode funct3
        .data1(RS1),            // register source 1 value
        .data2(RS2),            // register source 2 value
        .out(BRANCH_EN)         // output jump to new address
    );

endmodule
