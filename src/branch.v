`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/30 20:50:47
// Design Name: 
// Module Name: branch
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


module branch(
    input en,
    input [2:0] op,
    input [31:0] data1,
    input [31:0] data2,
    output reg out
    );
    
    always @(*) begin
        if(en)
            case(op)
                3'b000: // beq
                    out = (data1 == data2) ? 1 : 0;
                3'b001: // bne
                    out = (data1 == data2) ? 0 : 1;
                3'b100: // blt
                    out = ($signed(data1) < $signed(data2)) ? 1 : 0;
                3'b101: // bge
                    out = ($signed(data1) < $signed(data2)) ? 0 : 1;
                3'b110: // bltu
                    out = (data1 < data2) ? 1 : 0;
                3'b111: // bgeu
                    out = (data1 < data2) ? 0 : 1;
                default:
                    out = 0;
            endcase
        else out = 0;
    end
endmodule
