module dm_control (
    input       [2:0]   dop,                    // deside how many bytes (funct3)
    input               we,                     // enable write to memory
    input               rst,                    // form rst key
    input               clk,                    // for SAVE till next clock
    input       [31:0]  dm_addr,                // from ALU output
    input       [31:0]  data_in,                // from register rs2
    output reg  [31:0]  data_out                // to mux_wb
);

    reg  [7:0]  mem [0:1024];
    wire [31:0] addr;
    assign addr = dm_addr;
    

    always @(*) begin
        if (!rst) begin
            data_out = 32'b0;
        end
        else begin
            if (we) begin
                data_out = 32'b0;
                case (dop)
                    'h0: //sb
                        {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]} = data_in[7:0]; 
                    'h1: //sh
                        {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]} = data_in[15:0]; 
                    'h2: //s2
                        {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]}  = {data_in}; 
                    default: 
                        {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]}  = {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]};
                endcase
            end 
            else begin
                case (dop)
                    'h0: //lb
                        data_out = {{24{mem[addr+3][7]}},    mem[addr+3]};
                    'h1: //lh 
                        data_out = {{16{mem[addr+2][7]}},   mem[addr+2],mem[addr+3]};
                    'h2: //lw 
                        data_out = {mem[addr],mem[addr+1],     mem[addr+2],mem[addr+3]};
                    'h4: //lbu 
                        data_out = {{24{1'b0}},                mem[addr+3]}; 
                    'h5: //lhu 
                        data_out = {{16{1'b0}},                mem[addr+2],mem[addr+3]}; 
                    default: 
                        data_out = 'b0;
                endcase
            end
        end
    end
endmodule