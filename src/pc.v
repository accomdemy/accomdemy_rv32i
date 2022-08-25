module pc(
    input clk,
    input reset,
    input [31:0] jmp,
    input jpe,
    input brch_e,
    output reg [31:0] pc_next,
    output reg [31:0] pc
);
    always @(posedge clk or negedge reset) begin
        if(!reset) begin
            pc      <= 0;
            pc_next <= 0;
        end
        else if (jpe | brch_e) begin
            pc      <= jmp;
            pc_next <= jmp + 3'h4;
        end
        else begin
            pc      <= pc_next;
            pc_next <= pc_next + 3'h4;
        end
    end

endmodule
