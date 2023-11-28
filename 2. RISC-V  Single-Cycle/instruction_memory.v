module instruction_memory(input [31:0] Pc, input clk, rst, output[31:0] inst);
    
    reg [31:0] mem [0:31];
	initial $readmemh("code.dat", mem);
    always@(posedge clk)begin
        if(rst)
            $readmemh("code.dat", mem);
    end

    assign inst = mem[Pc];

endmodule