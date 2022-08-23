module pc(
    input clk,
    input reset,
    input [31:0] jump_addr,
    input jump_enable,
    output reg [31:0] pc_next,
    output reg [31:0] pc
);
    always @(posedge clk or negedge reset) begin
        if(!reset) begin
            pc      <= 0;
            pc_next <= 0;
        end
        else if (jump_enable) begin
            pc      <= jump_addr;
            pc_next <= jump_addr + 3'h4;
        end
        else begin
            pc      <= pc_next;
            pc_next <= pc_next + 3'h4;
        end
    end

endmodule
