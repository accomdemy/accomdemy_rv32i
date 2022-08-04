`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/02/2022 08:13:39 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb();
    reg [31:0] INST;
    wire [31:0] a, b,rd_dt;        // = input
    
    wire [15:0] opcode;
    wire [4:0] rd_a ,rs1_a,rs2_a;
    wire [31:0] imm;
    reg clk;
    reg res;
    decode _decode(INST,opcode,rd_a,rs1_a,rs2_a,imm);
    regfile _regfile(.rest(res),.we(1'b1),.rs1_a(rs1_a),.rs2_a(rs2_a),.rd_a(rd_a),.rd_dt(rd_dt),.rs1_dt(a),.rs2_dt(b));
    alu _alu (a, b,opcode , imm,rd_dt);
    
    
    initial begin
        res =1'b0;                                            // initial
        
        #1 INST = 32'h00900513;
        #1 INST = 32'h00600593;
        #1 INST = 32'h00b50633;
        #1 INST = 32'h40b506b3;
        #1 INST = 32'h00d67733;
        #1 $stop;
        #1 $finish;
    end
    
endmodule
