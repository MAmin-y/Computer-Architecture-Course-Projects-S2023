module data_path(input luiD, RegWriteD, MemWriteD, ALUSrcD, clk, rst, StallF, StallD, FlushD, FlushE,    
		 input [1:0] ResultSrcD, jumpD, ForwardAE, ForwardBE, 
		 input [2:0] ALUControlD, ImmSrcD, branchD,
		 output ZeroE, ALUResult_sign, RegWriteM, RegWriteW, 
		 output [6:0] op, func7,
    	 output [2:0] func3,
		 output [4:0] Rs1DH, Rs2DH, RDE, RS1E, RS2E, RDM, RdW, 
		 output [1:0] PCSrcE, ResultSrcE);

	wire RegWriteE, MemWriteE, ALUSrcE, MemWriteM, luiE, luiM; 
	wire [1:0] ResultSrcM, ResultSrcW, jumpE;
	wire [2:0] ALUControlE, branchE;
	wire [31:0] PCPlus4F, PCTargetE, ALUResultM, PCFPrime, PCF, InstrF, InstrD, PCD, 
		    PCPlus4D, ExtImmD, PCE, ExtImmE, PCPlus4E, RD1E, RD2E, 
		    ResultW, RD1D, RD2D, SrcAE, SrcBE, WriteDataE, ALUResultE, 
		    ExtImmM, PCPlus4M, WriteDataM, ReadDataM, ExtImmW, PCPlus4W, ALUResultW, ReadDataW, ALUResultMPrime;

	three_to_one_mux M1(PCPlus4F, PCTargetE, ALUResultE, PCSrcE, PCFPrime);
	pc_register R1(PCFPrime, clk, rst, StallF, PCF);
	instruction_memory IM({2'b00,PCF[31:2]}, clk, rst, InstrF);
	adder A1(PCF, {{29{1'b0}},3'b100}, PCPlus4F);
	fetch_register FR(InstrF, PCF, PCPlus4F, clk, StallD, FlushD, InstrD, PCD, PCPlus4D);

	register_file RF(InstrD[19:15], InstrD[24:20], RdW, ResultW, clk, RegWriteW, RD1D, RD2D);
	immidiate_extend IE(InstrD[31:7], ImmSrcD, ExtImmD);
	decode_register DR(luiD, PCPlus4D, PCD, ExtImmD, RD1D, RD2D, InstrD[19:15], InstrD[24:20], InstrD[11:7], clk,
	 					FlushE, RegWriteD, MemWriteD, ALUSrcD, ResultSrcD, jumpD, ALUControlD, branchD, RegWriteE, MemWriteE, ALUSrcE, 
	 					ResultSrcE, jumpE, ALUControlE, branchE, PCE, RS1E, RS2E, RDE, ExtImmE, PCPlus4E, RD1E, RD2E, luiE);

	branch_jump_decider b_j_d( ZeroE, ALUResult_sign, jumpE, branchE, PCSrcE);
	three_to_one_mux M2(RD1E, ResultW, ALUResultMPrime, ForwardAE, SrcAE);
	three_to_one_mux M3(RD2E, ResultW, ALUResultMPrime, ForwardBE, WriteDataE);
	two_to_one_mux M4(WriteDataE, ExtImmE, ALUSrcE, SrcBE);
	adder A2(PCE, ExtImmE, PCTargetE);
	alu ALU(SrcAE, SrcBE, ALUControlE, ALUResultE, ZeroE);
	execution_register ER(luiE, PCPlus4E, ALUResultE, WriteDataE, RDE, ExtImmE, clk, RegWriteE, MemWriteE, ResultSrcE, RegWriteM, 
							MemWriteM, ResultSrcM, RDM, ExtImmM, PCPlus4M, ALUResultM, WriteDataM, luiM);


	two_to_one_mux forward_mux(ALUResultM, ExtImmM, luiM, ALUResultMPrime);
	data_memory DM(clk, rst, {2'b00, ALUResultM[31:2]}, WriteDataM, MemWriteM, ReadDataM);
	write_back_register WBR(PCPlus4M, ALUResultM, RDM, ExtImmM, ReadDataM, clk, RegWriteM, ResultSrcM, RegWriteW, ResultSrcW,
							 RdW, ExtImmW, PCPlus4W, ALUResultW, ReadDataW);

	four_to_one_mux M5(ALUResultW, ReadDataW, PCPlus4W, ExtImmW, ResultSrcW, ResultW);

	assign ALUResult_sign = ALUResultE[31];
    assign op = InstrD[6:0];
    assign func3 = InstrD[14:12];
    assign func7 = InstrD[31:25];
	assign Rs1DH = InstrD[19:15];
	assign Rs2DH = InstrD[24:20];	

endmodule