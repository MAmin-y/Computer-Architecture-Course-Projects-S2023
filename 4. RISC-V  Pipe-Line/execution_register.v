module execution_register(  input luiE,
							input [31:0] PCPlus4E, ALUResultE, WriteDataE, 
						    input[4:0] RDE,
						    input[31:0] ExtImmE, 
		          			input clk, RegWriteE, MemWriteE,
		          			input [1:0] ResultSrcE,
		          			output reg RegWriteM, MemWriteM,
		          			output reg[1:0] ResultSrcM,
		           			output reg [4:0] RDM,
				  	 		output reg[31:0] ExtImmM, PCPlus4M, ALUResultM, WriteDataM,
							output reg luiM);

	always@(posedge clk)begin
		RDM = RDE;
		ExtImmM = ExtImmE;	
		PCPlus4M = PCPlus4E;
		ALUResultM = ALUResultE;
		WriteDataM = WriteDataE;
		ResultSrcM = ResultSrcE; 
		RegWriteM = RegWriteE;
		MemWriteM = MemWriteE;
		luiM = luiE;
	end

endmodule
