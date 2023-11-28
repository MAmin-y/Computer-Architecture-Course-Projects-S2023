module register_file(input [4:0] A1, A2, A3, input[31:0] WD3, input clk, WE3, output [31:0] RD1, RD2);

reg [31:0] reg_memory [0:31];
initial reg_memory[0] = 32'b0;

always@(negedge clk)begin // because of the bubble in datapath
	if(WE3) begin
		if(A3 != 0) reg_memory[A3] = WD3;
	end
end

assign RD1 = reg_memory[A1];
assign RD2 = reg_memory[A2];

endmodule