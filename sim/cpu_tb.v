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
        
        reset   = 1;
        #5 reset = 0; 
        
        forever #1 clk = ~clk; 
       
    end
     initial begin
         #50 $stop;
        #1 $finish;
      end

  

endmodule