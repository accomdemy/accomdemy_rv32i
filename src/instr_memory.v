module instr_memory(
    input [31:0] Addr,
    //output pc_en,
    output [31:0] INST
);

    reg [7:0] INST_memory [0:1023];

    // ./INST_rom.txt
    initial $readmemh("INST_rom.txt", INST_memory);
    
    /*initial begin
        {INST_memory[0],    INST_memory[1], INST_memory[2], INST_memory[3]} =32'h00900513;
        {INST_memory[4],    INST_memory[5], INST_memory[6], INST_memory[7]} =32'h00600593;
        {INST_memory[8],    INST_memory[9], INST_memory[10],INST_memory[11]}=32'h00b50633;
        {INST_memory[12],   INST_memory[13],INST_memory[14],INST_memory[15]}=32'h40b506b3;
        {INST_memory[16],   INST_memory[17],INST_memory[18],INST_memory[19]}=32'h00d67733;
        {INST_memory[20],   INST_memory[21],INST_memory[22],INST_memory[23]}=32'h00000000;
    end*/

    assign INST = { INST_memory[Addr], 
                    INST_memory[Addr+1],
                    INST_memory[Addr+2],
                    INST_memory[Addr+3] };

    //assign pc_en = (INST == 32'h0) ? 1'b0 : 1'b1;

endmodule
