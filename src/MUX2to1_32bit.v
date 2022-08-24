module MUX2to1_32bit(
    input [31:0] I0,
    input [31:0] I1,
    input s,
    output reg [31:0] f
    );
    
    always @(*) begin
        (s ? f = I0 : f = I1);
    end
    
endmodule
