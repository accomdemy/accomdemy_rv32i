module alu(
    input      [31:0] data1,
    input      [31:0] data2,
    input      [7:0]  op,
    output reg [31:0] res
);

    always@(*) begin
        case(op)                  
            8'h1:           // add / addi
                res = $signed(data1) + $signed(data2);      
            8'h2:           // sub
                res = $signed(data1) - $signed(data2);
            8'h3:           // sll / slli
                res = data1 << data2;
            8'h4:           // slt / slti
                res = ($signed(data1) < $signed(data2)) ? 32'h1 : 32'h0;
            8'h5:           // sltu / sltui 
                res = (data1 < data2) ? 32'h1 : 32'h0;          
            8'h6:           // xor / xori
                res = data1 ^ data2;
            8'h7:           // srl / srli
                res = data1 >> data2;
            8'h8:           // sra / srai
                res = $signed(data1) >>> data2;
            8'h9:           // or / ori
                res = data1 | data2;
            8'ha:           // and / andi
                res = data1 & data2;
            default:        // nop
                res = 0;      
        endcase
    end
endmodule
