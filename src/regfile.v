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
    output reg [31:0]   data1,
    output reg [31:0]   data2
);

    reg        [31:0]   regfile [31:0];

    always @(posedge(clk)) begin
        if (reset) begin                // when reset is HIGH, enable write ability
            if (we && wa != 0) begin
                regfile[wa] <= wdata;
            end
        end
    end

    always @(*) begin
        if(!re1)
            data1 = 0;
        else if (re1 && ra1 != 0) begin
            if(we && ra1 == wa)
                data1 = wdata;
            else
                data1 = regfile[ra1];
        end
        else
            data1 = 0;
    end

    always @(*) begin
        if(!re2)
            data2 = 0;
        else if (re2 && ra2 != 0) begin
            if(we && ra2 == wa)
                data2 = wdata;
            else
                data2 = regfile[ra2];
        end
        else
            data2 = 0;
    end

endmodule
