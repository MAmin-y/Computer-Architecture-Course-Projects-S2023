module write_back_register(input [31:0] PCPlus4M, ALUResultM,
							input [4:0] RDM,
							input [31:0] ExtImmM, DataMemoryOutM, 
		          			input clk, RegWriteM,
		          			input [1:0] ResultSrcM,
		         			output reg RegWriteW,
		          			output reg[1:0] ResultSrcW,
		          			output reg[4:0] RDW,
							output reg[31:0] ExtImmW, PCPlus4W, ALUResultW, DataMemoryOutW);

	always@(posedge clk)begin
		RDW = RDM;
		ExtImmW = ExtImmM;
		PCPlus4W = PCPlus4M;
		ALUResultW = ALUResultM;
		DataMemoryOutW = DataMemoryOutM;
		RegWriteW = RegWriteM;
		ResultSrcW = ResultSrcM;
	end

endmodule
