module regfile(
    input               clk,
    input               reset,
    input               we,
    input               re1,
    input               re2,

    input       [4:0]   ra1,
    input       [4:0]   ra2,
    input       [4:0]   wa,

    input      [31:0]   wdata,
    output reg [31:0]   rs1,
    output reg [31:0]   rs2
);

    reg        [31:0]   regfile [31:0];

    initial begin
        for(integer idx=0;idx<32;idx=idx+1) begin
            regfile[idx] = 32'b0;
        end
    end

    always @(posedge(clk)) begin
        if (reset) begin                // when reset is HIGH, enable write ability
            if (we && wa != 0) begin
                regfile[wa] <= wdata;
            end
        end
    end

    always @(*) begin
        if(!re1)
            rs1 = 0;
        else if (re1 && ra1 != 0) begin
            /*if(we && ra1 == wa)
                rs1 = wdata;
            else*/
                rs1 = regfile[ra1];
        end
        else
            rs1 = 0;
    end

    always @(*) begin
        if(!re2)
            rs2 = 0;
        else if (re2 && ra2 != 0) begin
            /*if(we && ra2 == wa)
                rs2 = wdata;
            else*/
                rs2 = regfile[ra2];
        end
        else
            rs2 = 0;
    end

endmodule
