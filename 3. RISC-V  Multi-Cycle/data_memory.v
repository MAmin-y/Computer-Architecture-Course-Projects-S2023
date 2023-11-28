module data_memory(input clk, rst, input[31:0] adr, input[31:0] write_data, input We, output reg [31:0] read_data);

    reg[31:0] mem [0:31];
	initial $readmemh("code.dat", mem);
    always@(posedge clk)begin
        if(rst)
            $readmemh("code.dat", mem);
        else if(We)
            mem[adr] = write_data; 
    end

assign read_data = mem[adr];

endmodule
