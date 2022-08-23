module MUX4to1_32bit(
    input [31:0] I0,
    input [31:0] I1,
    input [31:0] I2,
    input [31:0] I3,
    input [ 1:0]  s,
    output reg [31:0] f
    );
    always @(*) begin
        case (s)
            2'b00: f = I0;
            2'b01: f = I1;
            2'b10: f = I2;
            2'b11: f = I3;
        endcase
    end    
    // assign f = (s == 0) ? I0 : I1;
    
endmodule
