module decoder(
    input       [31:0]      prog,   // risc-v opcode

    output reg  [4:0]       ra1,    // rs1 address
    output reg  [4:0]       ra2,    // rs2 address
    output reg  [31:0]      imm,    // reconstructed imm value
    output reg  [4:0]       wa,     // rd address
    output reg  [7:0]       op,     // alu opcode

    output reg              re1,    // rs1 enable
    output reg              re2,    // rs2 enable
    output reg              we,     // rd enable
    output reg              pce,    // mux_data1
    output reg              imme,   // mux_data2
    output reg              jmpe    // pc jump
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

        case(prog[6:0])                    // Type
            7'b0110011: begin               // R-Type

                ra1         = prog[19:15];  // rs1 implied
                ra2         = prog[24:20];  // rs2 implied
                wa          = prog[11:7];   // rd implied
                imm         = 32'b0;        // imm not implied
                re1         = _enable;      // rs1 required
                re2         = _enable;      // rs2 required
                we          = _enable;      // rd required
                pce         = _disable;     // use rs1 on ALU-data1
                imme        = _disable;     // use rs2 on ALU-data2
                jmpe        = _disable;     // use pc+4 on PC

                case(prog[14:12])           // Func3
                    3'b000:                 // add / sub
                        case(prog[31:25])   // Func7
                            7'b0000000:     // add
                                op = 8'h1;
                            7'b0100000:     // sub
                                op = 8'h2;
                            default: 
                                op = 8'h0;
                        endcase
                    3'b001:                 // sll
                        op = 8'h3;
                    3'b010:                 // slt
                        op = 8'h4;   
                    3'b011:                 // sltu
                        op = 8'h5;
                    3'b100:                 // xor
                        op = 8'h6;
                    3'b101:                 // srl / sra
                        case(prog[31:25])  // Func7
                            7'b0000000:     // srl
                                op = 8'h7;
                            7'b0100000:     // sra
                                op = 8'h8;
                            default: 
                                op = 8'h0;
                        endcase
                    3'b110:                 // or
                        op = 8'h9;
                    3'b111:                 // and
                        op = 8'ha;
                    default:  
                        op = 8'h0;
                endcase
            end
            /*
             * ========================================================
             */
            7'b0010011: begin               // I-Type
                ra1         = prog[19:15];  // rs1 implied
                ra2         = 5'b0;         // rs2 not implied
                wa          = prog[11:7];   // rd implied
                imm         = {{20{prog[31]}}, prog[31:20]};  // imm implied
                re1         = _enable;      // rs1 required
                re2         = _disable;     // rs2 not used
                we          = _enable;      // rd required
                pce         = _disable;     // use rs1 on ALU-data1
                imme        = _enable;      // use imm on ALU-data2
                jmpe        = _disable;     // use pc+4 on PC

                case(prog[14:12])          // Func3
                    3'b000:                 // addi
                        op = 8'h1;
                    3'b001:                 // slli
                        op = 8'h3;
                    3'b010:                 // slti
                        op = 8'h4;   
                    3'b011:                 // sltiu
                        op = 8'h5;
                    3'b100:                 // xori
                        op = 8'h6;
                    3'b101:                 // srli / srai
                        case(prog[31:25])  // Func7
                            7'b0000000:     // srli
                                op = 8'h7;
                            7'b0100000:     // srai
                                op = 8'h8;
                            default: 
                                op = 8'h0;
                        endcase
                    3'b110:                 // ori
                        op = 8'h9;
                    3'b111:                 // andi
                        op = 8'ha;
                    default:  
                        op = 8'h0;
                endcase
            end
            /*
             * ========================================================
             */
            7'b1101111:   begin             // J-Type : JAL
                ra1         = 5'b0;         // rs1 not implied
                ra2         = 5'b0;         // rs2 not implied
                wa          = prog[11:7];   // rd implied
                imm         = { {11{prog[31]}}, prog[31], prog[19:12], prog[20], prog[30:21], 1'b0 };  // imm implied
                re1         = _disable;     // rs1 not used
                re2         = _disable;     // rs2 not used
                we          = _enable;      // rd required
                pce         = _enable;      // use pc on ALU-data1
                imme        = _enable;      // use imm on ALU-data2
                jmpe        = _enable;      // use jmp on PC
                op          = 8'h1;         // data1 + data2
            end

            7'b1100111: begin               // I-Type : JALR
                ra1         = prog[19:15];  // rs1 implied
                ra2         = 5'b0;         // rs2 not implied
                wa          = prog[11:7];   // rd implied
                imm         = { {20{prog[31]}}, prog[31:20] };  // imm implied
                re1         = _enable;      // rs1 used
                re2         = _disable;     // rs2 not used
                we          = _enable;      // rd required
                pce         = _disable;     // use pc on ALU-data1
                imme        = _enable;      // use imm on ALU-data2
                jmpe        = _enable;      // use jmp on PC
                op          = 8'h1;         // data1 + data2
            end

            default: begin
                ra1         = 5'b0;         // rs1 not implied
                ra2         = 5'b0;         // rs2 not implied
                wa          = 5'b0;         // rd not implied
                imm         = 32'b0;        // imm not implied
                re1         = _disable;     // rs1 not used
                re2         = _disable;     // rs2 not used
                we          = _disable;     // rd not used
                pce         = _disable;     // use rs1 on ALU-data1
                imme        = _disable;     // use rs2 on ALU-data2
                jmpe        = _disable;     // use pc+4 on PC
                op          = 8'h0;         // do nothing
            end
        endcase
    end

endmodule
