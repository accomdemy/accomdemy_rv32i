`timescale 1ns/1ps

module cpu_tb;
    reg        clk;
    reg        reset;
    reg [31:0] inst;

    cpu cpu0 (
        .clk(clk),
        .reset(reset),
        .INST(inst)
    );

    initial begin
        clk     = 0;
        
        reset   = 1;
        #5 reset = 0; 
        
        forever #1 clk = ~clk; 
    end

    initial begin
        #10 inst = 32'h00300513;
        #10 inst = 32'h00500593;
        #10 inst = 32'h00b50633;
        #10 inst = 32'h00800693;
        #10 inst = 32'h40b68733;
        #10 $stop;
        #10 $finish;
    end

endmodule