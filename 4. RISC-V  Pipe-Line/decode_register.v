module decode_register(input luiD,
				input [31:0] PCPlus4D, PCD, ExtImmD, RD1D, RD2D,
		       input [4:0] RS1D, RS2D, RDD, 
		       input clk, CLR, RegWriteD, MemWriteD, ALUSrcD,
		       input [1:0] ResultSrcD, jumpD,
		       input [2:0] ALUControlD, branchD,
		       output reg RegWriteE, MemWriteE, ALUSrcE,
		       output reg[1:0] ResultSrcE, jumpE,
		       output reg[2:0] ALUControlE,branchE,
		       output reg[31:0] PCE, 
		       output reg[4:0] RS1E, RS2E, RDE, 
		       output reg[31:0] ExtImmE, PCPlus4E, RD1E, RD2E,
			   output reg luiE);

	always@(posedge clk)begin

		if(CLR)begin
			PCE = 32'b0;
			RS1E = 32'b0;
			RS2E = 32'b0;
			RDE = 32'b0;
			ExtImmE = 32'b0;
			PCPlus4E = 32'b0;
			RD1E = 32'b0;
			RD2E = 32'b0;
			RegWriteE = 1'b0;
			MemWriteE = 1'b0;
			ALUSrcE = 1'b0;
			ResultSrcE = 2'b0;
			jumpE = 2'b0;
			branchE = 3'b0;
			ALUControlE = 3'b0;
			luiE = 1'b0;
		end
		else begin
			PCE = PCD;
			RS1E = RS1D;
			RS2E = RS2D;
			RDE = RDD;
			ExtImmE = ExtImmD;
			PCPlus4E = PCPlus4D;
			RD1E = RD1D;
			RD2E = RD2D;
			RegWriteE = RegWriteD;
			MemWriteE = MemWriteD;
			ALUSrcE = ALUSrcD;
			ResultSrcE = ResultSrcD;
			jumpE = jumpD;
			branchE = branchD;
			ALUControlE = ALUControlD;
			luiE = luiD;
		end
	end

endmodule