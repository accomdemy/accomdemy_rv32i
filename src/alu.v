`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/07 22:50:51
// Design Name: 
// Module Name: alu
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


module alu(
    input [31:0] rs1,
    input [31:0] rs2,
    input [15:0] op,
    input [31:0] imm,
    output [31:0] out
    );
    reg [31:0] buff;
    reg [63:0] re_sra;

    wire  signed [31:0] signed_rs1;
    wire  signed [31:0] signed_rs2;

    assign signed_rs1=rs1;
    assign signed_rs2=rs2;
    
    always @(*)
    begin
        case(op)
        16'h0033 : buff = rs1+rs2;                                           //add
        16'h8033 : buff = rs1-rs2;                                           //sub
        16'h00b3 : buff = rs1 << rs2[4:0];                                   //sll
        16'h0133 : buff = (signed_rs1 < signed_rs2)? 32'h0001 : 32'h0000;    //slt
        16'h01b3 : buff = (rs1 < rs2)? 32'h0001 : 32'h0000;                  //sltu
        16'h0233 : buff = rs1^rs2;                                           //xor 
        16'h02b3 : buff = rs1 >> rs2[4:0];                                   //srl
        16'h82b3 :                                                           //sra
            begin
                if(rs1[31]==1'b1)
                    begin
                        re_sra  = {32'hffffffff,rs1};
                        buff    = re_sra >> rs2[4:0];
                    end
                else
                    begin
                        buff =rs1 >> rs2[4:0];
                    end
            end
        16'h0333 : buff = rs1|rs2;                                           //or       
        16'h03b3 : buff = rs1&rs2;                                           //and 
        16'h0013 : buff = rs1 +imm[11:0];
        
    
        default :buff=32'h0000;
        endcase
    end 
    assign out=buff;
endmodule
