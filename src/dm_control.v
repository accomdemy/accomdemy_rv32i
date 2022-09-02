module dm_control (
    input       [2:0]   dop,                    // deside how many bytes (funct3)
    input               we,                     // enable write to memory
    input               rst,                    // form rst key
    input               clk,                    // for SAVE till next clock
    input       [31:0]  dm_addr,                // from ALU output
    input       [31:0]  data_in,                // from register rs2
    output reg [31:0]  data_out_buff                 // to mux_wb
);

    reg  [31:0] data_in_buff ;
    wire [31:0] data_out_wire ;
    mem mem_U(
        .clk(clk),
        .we(we),
        .data_in(data_in_buff),
        .data_out(data_out_wire),
        .addr(dm_addr)
    );

    always @(*) begin
        if (!rst) begin
            data_in_buff  = 32'b0;
            data_out_buff = 32'b0;
        end
        else begin
            if (we) begin
                data_in_buff = data_out_wire;
                case (dop)
                    'h0: //sb
                        data_in_buff[7:0]  = data_in[7:0]; 
                    'h1: //sh
                        data_in_buff[15:0] = data_in[15:0]; 
                    'h2: //s2
                        data_in_buff  = {data_in}; 
                    default: 
                        data_in_buff  = 32'b0;
                endcase
            end 
            else begin
                case (dop)
                    'h0: //lb
                        data_out_buff = {{24{data_out_wire[7]}}, data_out_wire[7:0]};
                    'h1: //lh 
                        data_out_buff = {{16{data_out_wire[15]}}, data_out_wire[15:0]};
                    'h2: //lw 
                        data_out_buff = {data_out_wire};
                    'h4: //lbu 
                        data_out_buff = {{24{1'b0}},         data_out_wire[7:0]}; 
                    'h5: //lhu 
                        data_out_buff = {{16{1'b0}},         data_out_wire[15:0]}; 
                    default: 
                        data_out_buff = 32'b0;
                endcase
            end
        end
    end
endmodule

module mem(
    input               clk,
    input       [31:0]  addr,
    input       [31:0]  data_in,
    output reg  [31:0]  data_out,
    input               we
    );
    reg [7:0] mem [0:1024];
    always @(*) begin
        data_out <= {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]} ;
    end
    always @(posedge clk ) begin
        if (we) begin
            {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]} <= data_in;
        end else begin
            // data_out <= {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]} ;
        end
    end 
    integer i = 0;
    initial begin
        {mem[i],mem[i+1],mem[i+2],mem[i+3]} = 'h12345678;
        i = 4;
        {mem[i],mem[i+1],mem[i+2],mem[i+3]} = 'h87654321;
    end
endmodule
