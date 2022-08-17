module pc(
    input clk,
    input res,
    input En,
    output [31:0] pc,
    output [31:0] pc_old
);

    reg [31:0] pc_reg = 32'h0;
    reg [31:0] pc_old_reg;

    always @(posedge clk or negedge res) begin
        if(res == 1'b1) begin
            pc_reg = 0;
            pc_old_reg = 0;
        end
        else if(En == 1'b1) begin
            pc_reg <= pc_reg + 3'b100;
            pc_old_reg <= pc_reg;
        end
        else begin
            pc_reg = pc_reg;
        end
    end

    assign pc= pc_reg;
    assign pc_old = pc_old_reg;


endmodule
