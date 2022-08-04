`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/21 20:19:11
// Design Name: 
// Module Name: decode
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decode(
    input [31:0] INST,
    output [15:0] opcode,
	output [4:0] rd,
	output [4:0] rs1,
	output [4:0] rs2,
	output [31:0] imm
	
    );

    reg [4:0] rd_buf;
    reg [4:0] rs1_buf;
    reg [4:0] rs2_buf;
    reg [31:0] imm_buf;
    reg [15:0] opcode_buf;
    
    always @(*)
    begin 
        case(INST[6:0])
        7'b0110011 : //R-TYPE
            begin
                opcode_buf  = {INST[30:25],INST[14:12],INST[6:0]};
                rd_buf      = INST[11:7];
                rs1_buf     = INST[19:15];
                rs2_buf     = INST[24:20];
                imm_buf     = 32'hdeadbeef;
            end
        7'b0010011 : //I-TYPE-1
            begin
                opcode_buf  = {6'b000000,INST[14:12],INST[6:0]};
                rd_buf      = INST[11:7];
                rs1_buf     = INST[19:15];
                rs2_buf     = 5'b00000;
                imm_buf     = {21'b000000000000000000000,INST[31:20]};    //?��?��要�?�兩種在??�確�?
            end
        7'b0000011 : //Itype-2
            begin
                opcode_buf  = {6'b000000,INST[14:12],INST[6:0]};
                rd_buf      = INST[11:7];
                rs1_buf      = INST[19:15];
                rs2_buf     = 5'b00000;
                imm_buf     = {21'b000000000000000000000,INST[31:20]};
            end
        7'b0100011 : //S-TYPE
            begin
                opcode_buf  = {6'b000000,INST[14:12],INST[6:0]};
                rd_buf      = 5'b00000;
                rs1_buf     = INST[19:15];
                rs2_buf     = INST[24:20];
                imm_buf     = {21'b000000000000000000000,INST[31:25],INST[11:7]};
            end
        7'b1100011 : //B-TYPE
            begin
                opcode_buf  = {6'b000000,INST[14:12],INST[6:0]};
                rd_buf      = 5'b00000;
                rs1_buf     = INST[19:15];
                rs2_buf     = INST[24:20];
                imm_buf     ={20'b00000000000000000000,INST[31],INST[7],INST[30:25],INST[11:8],1'b0};

            end
        7'b0110111 : //U-TYPE lui
            begin
                opcode_buf  = {9'b000000000,INST[6:0]};
                rd_buf      = INST[11:7];
                rs1_buf     = 5'b00000;
                rs2_buf     = 5'b00000;
                imm_buf     = {INST[31:12],12'b000000000000};
            end
        7'b0010111 : //U-TYPE auipc
            begin
                opcode_buf  = {9'b000000000,INST[6:0]};
                rd_buf      = INST[11:7];
                rs1_buf     = 5'b00000;
                rs2_buf     = 5'b00000;
                imm_buf     = {INST[31:12],12'b000000000000};
            end
        7'b1101111 : //J-TYPE jal
            begin
                opcode_buf  = {9'b000000000,INST[6:0]};
                rd_buf      = INST[11:7];
                rs1_buf     = 5'b00000;
                rs2_buf     = 5'b00000;
                imm_buf     = {11'b00000000000,INST[31],INST[19:12],INST[20],INST[30:21],1'b0};
            end
        7'b1100111 : //I-TYPE jalr
            begin
                opcode_buf  = {9'b000000000,INST[6:0]};
                rd_buf      = INST[11:7];
                rs1_buf     = INST[19:15];
                rs2_buf     = 5'b00000;
                imm_buf     = {20'b00000000000000000000,INST[31:20]};
            end
		default : opcode_buf =16'b0000000000000000;
	    endcase
    end

    assign opcode   = opcode_buf;
    assign rd       = rd_buf;       
    assign rs1      = rs1_buf;
    assign rs2      = rs2_buf;
    assign imm      = imm_buf;
    
endmodule


    