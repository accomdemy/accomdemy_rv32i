`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/09/2022 08:32:04 PM
// Design Name: 
// Module Name: MUX2to1_32bit
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


module MUX2to1_32bit(
    input [31:0] I0,
    input [31:0] I1,
    input s,
    output [31:0] f
    );
    assign f = (s =0)? I0 :I1;
endmodule
