module cpu(
    input clk,
    input reset
);

    // program counter - inst fetch - decoder
    wire pc_en;
    wire [31:0] pc_dt;
    wire [31:0] pc_old;
    
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
        .res(res),
        .En(pc_en),
        .pc(pc_dt),
        .pc_old(pc_old)
    );

    instr_memory instr_memory(
        .Addr(pc_dt),
        .pc_en(pc_en),
        .INST(INST)
    );
    
    decoder decoder(
        // register
        .instr(INST),
        .rs1_addr(RS1_ADDR),
        .rs2_addr(RS2_ADDR),
        .w_addr(WADDR),
        .imm_number(IMM_NUMBER),
        .r1_enable(RS1_ENABLE),
        .r2_enable(RS2_ENABLE),
        .w_enable(W_ENABLE),

        //alu
        .imm_enable(IMM_ENABLE),
        .aluop(OPCODE)
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

    // imm
    MUX2to1_32bit mux_imm(
        .I0(RS2),
        .I1(IMM_NUMBER),
        .s(IMM_ENABLE),
        .f(DATA2)
    );

    alu alu0(
        .a(RS1),
        .b(DATA2),
        .op(OPCODE),
        .y(WB_DATA)
    );

endmodule