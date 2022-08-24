module MUX2to1_32bit(
    input [31:0] I0,
    input [31:0] I1,
    input s,
    output [31:0] f
    );
    
    assign f = (s == 0) ? I0 : I1;
    
endmodule
