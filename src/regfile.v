`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/28/2022 08:21:13 PM
// Design Name: 
// Module Name: regfile
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


module regfile(
    input clk,
    input rest,
    input we,
    input [4:0] rs1_a,
    input [4:0] rs2_a,
    input [4:0] rd_a,
    input [31:0] rd_dt,
    output [31:0] rs1_dt,
    output [31:0] rs2_dt
    );

    reg [31:0] memorydt[0:1024];

    reg [31:0] rs1_buf;
    reg [31:0] rs2_buf;

   

    always @(*)
    begin
        if (we ==1'b1 && (rd_a != 5'b0000))
            begin
                memorydt[rd_a] =rd_dt;
            end
        else
            begin
                memorydt[rd_a] =memorydt[rd_a];
            end
    end

    always @(*)
    begin
        if(rs1_a !=5'b00000)
            begin
                rs1_buf =memorydt[rs1_a];
            end
        else
            begin
                rs1_buf= 32'h00000000;
            end

    end

    always @(*)
    begin
        if(rs2_a !=5'b00000)
            begin
                rs2_buf =memorydt[rs2_a];
            end
        else
            begin
                rs2_buf= 32'h00000000;
            end
    end
    assign rs1_dt = rs1_buf;
    assign rs2_dt = rs2_buf;

endmodule
