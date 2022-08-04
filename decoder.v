module decoder(
    input       [31:0]      instr,

    output reg  [4:0]       rs1_addr,
    output reg  [4:0]       rs2_addr,
    output reg  [31:0]      imm_number,
    output reg  [4:0]       w_addr,
    output reg  [7:0]       aluop,

    output reg              r1_enable,
    output reg              r2_enable,
    output reg              w_enable,
    output reg              imm_enable
);

    // ALU OP
    // ----------------
    // 0x00: nop
    // 0x01: add
    // 0x02: sub
    // 0x03: sll
    // 0x04: slt
    // 0x05: sltu
    // 0x06: xor
    // 0x07: srl
    // 0x08: sra
    // 0x09: or
    // 0x0a: and

    localparam  _enable     = 1'b1;
    localparam  _disable    = 1'b0;
   
    
    always@(*) begin

        case(instr[6:0])                    // Type
            7'b0110011: begin               // R Type

                rs1_addr    = instr[19:15]; // rs1
                rs2_addr    = instr[24:20]; // rs2
                w_addr      = instr[11:7];  // rd
                r1_enable   = _enable;
                r2_enable   = _enable;
                w_enable    = _enable;
                imm_enable  = _disable;     // not r2_enable

                case(instr[14:12])          // Func3
                    3'b000:                 // add / sub
                        case(instr[31:25])  // Func7
                            7'b0000000:     // add
                                aluop = 8'h1;
                            7'b0100000:     // sub
                                aluop = 8'h2;
                            default: 
                                aluop = 8'h0;
                        endcase
                    3'b001:                 // sll
                        aluop = 8'h3;
                    3'b010:                 // slt
                        aluop = 8'h4;   
                    3'b011:                 // sltu
                        aluop = 8'h5;
                    3'b100:                 // xor
                        aluop = 8'h6;
                    3'b101:                 // srl / sra
                        case(instr[31:25])  // Func7
                            7'b0000000:     // srl
                                aluop = 8'h7;
                            7'b0100000:     // sra
                                aluop = 8'h8;
                            default: 
                                aluop = 8'h0;
                        endcase
                    3'b110:                 // or
                        aluop = 8'h9;
                    3'b111:                 // and
                        aluop = 8'ha;
                    default:  
                        aluop = 8'h0;
                endcase
            end
            /*
             * ========================================================
             */
            7'b0010011: begin               // I Type

                rs1_addr    = instr[19:15]; // rs1
                imm_number  = {{20{instr[31]}}, instr[31:20]};  // imm
                w_addr      = instr[11:7];  // rd
                r1_enable   = _enable;
                r2_enable   = _disable;
                w_enable    = _enable;
                imm_enable  = _enable;      // r2_enable

                case(instr[14:12])          // Func3
                    3'b000:                 // addi
                        aluop = 8'h1;
                    3'b001:                 // slli
                        aluop = 8'h3;
                    3'b010:                 // slti
                        aluop = 8'h4;   
                    3'b011:                 // sltiu
                        aluop = 8'h5;
                    3'b100:                 // xori
                        aluop = 8'h6;
                    3'b101:                 // srli / srai
                        case(instr[31:25])  // Func7
                            7'b0000000:     // srli
                                aluop = 8'h7;
                            7'b0100000:     // srai
                                aluop = 8'h8;
                            default: 
                                aluop = 8'h0;
                        endcase
                    3'b110:                 // ori
                        aluop = 8'h9;
                    3'b111:                 // andi
                        aluop = 8'ha;
                    default:  
                        aluop = 8'h0;
                endcase
            end
            /*
             * ========================================================
             */
            default: 
                aluop = 8'h0;
        endcase
    end

endmodule