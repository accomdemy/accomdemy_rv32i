module branch (
    input en,
    input [2:0] op,
    input [31:0] rs1,
    input [31:0] rs2,
    output reg out
);
localparam _enable = 1'b1;
localparam _disable = 1'b0;
    always@(*) begin
        if (en) begin // en = 1
            case (op)
                3'b000: // BEQ
                    if ($signed(data1) == $signed(data2)) begin
                        out = _enable;
                    end
                    else begin
                        out = _disable;
                    end
                3'b001: // BNE
                    if ($signed(data1) != $signed(data2)) begin
                        out = _enable;
                    end
                    else begin
                        out = _disable;
                    end
                3'b100: // BLT
                    if ($signed(data1) < $signed(data2)) begin
                        out = _enable;
                    end
                    else begin
                        out = _disable;
                    end
                3'b101: // BGE
                    if ($signed(data1) >= $signed(data2)) begin
                        out = _enable;
                    end
                    else begin
                        out = _disable;
                    end
                3'b110: // BLTU
                    if (data1 < data2) begin
                        out = _enable;
                    end
                    else begin
                        out = _disable;
                    end
                3'b111: // BGEU
                    if (data1 >= data2) begin
                        out = _enable;
                    end
                    else begin
                        out = _disable;
                    end
                default: 
                    out = _disable;
            endcase
        end
        else begin // en = 0
            out = _disable;
        end
    end
endmodule