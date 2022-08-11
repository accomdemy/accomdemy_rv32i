`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/09/2022 08:57:20 PM
// Design Name: 
// Module Name: pc
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


module pc(
    input clk,
    input res,
    input En,
    output [31:0] pc,
    output [31:0] pc_old
   
    );
    reg [31:0] pc_reg =32'h00000000;
    reg [31:0] pc_old_reg;

    always @(posedge clk or negedge res)
    begin
        if(res==1'b1)
        begin
            pc_reg =0;
            pc_old_reg =0;
        end
        else if(En==1'b1)
        begin
            pc_reg<=pc_reg+3'b100;
            pc_old_reg<=pc_reg;
        end
        else
        begin
            pc_reg=pc_reg;
        end

    end
    assign pc=pc_reg;
    assign pc_old =pc_old_reg;


endmodule
