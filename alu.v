module alu(input [31:0] a, input [31:0] b, input [31:0] op, output reg [31:0] y);
  always@(*) begin
    case(op)                  
      3'b000: y = a + b;     
      3'b001: y = a - b;      
      3'b010: y = a * b;    // RV32I規範中未包含乘法
      3'b011: y = a / b;    // RV32I規範中未包含除法
      3'b100: y = a & b;      
      3'b101: y = a | b;      
      3'b110: y = ~a;       // RV32I規範中未包含NOT
      3'b111: y = a ^ b;
      default: y = 0;      
    endcase
  end
endmodule