`timescale 1ns/1ps

module cpu_tb;
    reg        clk;
    reg        reset;

    cpu cpu0 (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        clk     = 0;
        
        reset   = 0;
        #5 reset = 1; 
        
        forever #1 clk = ~clk; 
       
    end
    initial begin
        #100 $stop;
        #1 $finish;
    end
      
endmodule
