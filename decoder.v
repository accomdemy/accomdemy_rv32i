module decoder(
    input [31:0] instr,
    output reg [4:0] rs1_addr,
    output reg [4:0] rs2_addr,
    output reg [4:0] w_addr,
    output reg [2:0] aluop,
    output reg r1_enable,
    output reg r2_enable,
    output reg w_enable,
    output reg imm_enable
);
    
    always@(*) begin

        case(instr[6:0]) //type
            7'b0110011: begin //Rtype

                rs1_addr = instr[19:15]; //rs1
                rs2_addr = instr[24:20]; //rs2
                w_addr = instr[11:7]; //rd
                r1_enable = 1'b1;
                r2_enable = 1'b1;
                w_enable = 1'b1;
                imm_enable = 1'b0; // not r2_enable

                case(instr[14:12]) //Func3
                    3'b000: //add / sub

                        case(instr[31:25]) //Func7

                            7'b0000000:  //add
                                aluop = 3'h0;


                            7'b0100000:  //sub
                                aluop = 3'h1;

                            default:  aluop = 3'h0;

                        endcase

                    3'b111:  //and
                        aluop = 3'h4;

                    3'b110:  //or
                        aluop = 3'h5;

                    3'b100:  //xor
                        aluop = 3'h7;

                    default:  aluop = 3'h0;
                endcase
            end
            
            default:  aluop = 3'h0;
        endcase

    end

endmodule