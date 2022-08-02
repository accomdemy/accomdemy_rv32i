module cpu(
    input clk,
    input reset
);
    //decoder - register
    wire [31:0] INST;
    wire [4:0]  RS1_ADDR;
    wire [4:0]  RS2_ADDR;
    wire [4:0]  WADDR;
    wire [2:0]  OPCODE;
    wire        RS1_ENABLE;
    wire        RS2_ENABLE;
    wire        W_ENABLE;
    wire        IMM_ENABLE;

    //register - alu
    wire [31:0] RS1;
    wire [31:0] RS2;
    wire [31:0] WB_DATA;

    //decoder - selecter - alu
    wire [4:0] DATA2;

    decode decoder(
        //register
        .instr(INST),
        .rs1_addr(RS1_ADDR),
        .rs2_addr(RS2_ADDR),
        .w_addr(WADDR),
        .r1_enable(RS1_ENABLE),
        .r2_enable(RS2_ENABLE),
        .w_enable(W_ENABLE),

        //alu
        .imm_enable(IMM_ENABLE),
        .aluop(OPCODE)
    );

    regfile register(
        //self
        .clk(clk),
        .rst(reset),

        //decoder
        .w_enable(W_ENABLE),
        .r1_enable(RS1_ENABLE),
        .r2_enable(RS2_ENABLE),

        .rs1_addr(RS1_ADDR),
        .rs2_addr(RS2_ADDR),
        .wb_addr(WADDR),
        
        //alu
        .wb_data(WB_DATA),
        .rs1(RS1),
        .rs2(RS2)

    );
    alu alu1(
        .a(RS1),
        .b(DATA2),
        .op(OPCODE),
        .y(WB_DATA)
    );

    if (IMM_ENABLE)
        DATA2 = RS2_ADDR;
    else
        DATA2 = RS2;

endmodule