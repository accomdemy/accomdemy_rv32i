module regfile(
                input clk,
                input w_enable,
                input r1_enable,
                input r2_enable,
                input rst,

                input [4:0] rs1_addr,
                input [4:0] rs2_addr,
                input [4:0] wb_addr,

                input [31:0] wb_data,
                output reg [31:0] rs1,
                output reg [31:0] rs2
);
    reg [31:0] regfile[31:0];
    always@(posedge(clk)) begin
        if (!rst) begin
            if (w_enable && wb_addr!=0) begin
                regfile[wb_addr] <= wb_data;
            end
        end
    end

    always@(*) begin
        if(r1_enable && rs1_addr==0)
            rs1=0;
        else if(w_enable && r1_enable && rs1_addr!=0)
            rs1 = wb_data;
        else if(r1_enable && rs1_addr!=0)
            rs1= regfile[rs1_addr];
        else
            rs1 = 0;
    end
    always@(*) begin
        if(r2_enable && rs2_addr==0)
            rs2=0;
        else if(w_enable && r2_enable && rs2_addr!=0)
            rs2 = wb_data;
        else if(r2_enable && rs2_addr!=0)
            rs2= regfile[rs2_addr];
        else
            rs2 = 0;
    end

endmodule