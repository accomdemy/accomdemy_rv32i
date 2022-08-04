module alu(
    input      [31:0] a,
    input      [31:0] b,
    input      [7:0]  op,
    output reg [31:0] y
);

    always@(*) begin
        case(op)                  
            8'h1:           // add / addi
                y = a + b;      
            8'h2:           // sub
                y = a - b;
            8'h3:           // sll / slli
                y = a << b;
            8'h4:           // slt / slti
                y = ($signed(a) < $signed(b)) ? 32'h1 : 32'h0;      
            8'h5:           // sltu / sltui 
                y = (a < b) ? 32'h1 : 32'h0;          
            8'h6:           // xor / xori
                y = a ^ b;
            8'h7:           // srl / srli
                y = a >> b;
            8'h8:           // sra / srai
                y = $signed(a) >> b;
            8'h9:           // or / ori
                y = a | b;
            8'ha:           // and / andi
                y = a & b;
            default:        // nop
                y = 0;      
        endcase
    end
endmodule