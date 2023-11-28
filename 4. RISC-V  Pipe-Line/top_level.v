module top_level(input clk, rst);

	wire RegWriteD, MemWriteD, ALUSrcD, StallF, StallD, FlushD, FlushE ,ZeroE, ALUResult_sign, RegWriteM, RegWriteW, luiD;
	wire [1:0] ResultSrcD, jumpD, ForwardAE, ForwardBE ,PCSrcE, ResultSrcE;
	wire [2:0] ALUControlD, ImmSrcD, func3, branchD;
	wire [4:0] Rs1DH, Rs2DH, RDE, RS1E, RS2E, RDM, RdW;
	wire [6:0] op, func7;
	
	data_path DP(luiD, RegWriteD, MemWriteD, ALUSrcD, clk, rst, StallF, StallD, FlushD, FlushE, ResultSrcD, jumpD, ForwardAE,
				 ForwardBE, ALUControlD, ImmSrcD, branchD, ZeroE, ALUResult_sign, RegWriteM, RegWriteW, op, func7, func3, Rs1DH, Rs2DH,
				 																	 RDE, RS1E, RS2E, RDM, RdW, PCSrcE, ResultSrcE);

	controller C(clk, ZeroE, ALUResult_sign, func3, op, func7, MemWriteD, ALUSrcD, RegWriteD, jumpD, ResultSrcD, ALUControlD, ImmSrcD, branchD, luiD);

	hazard_unit HZ(
    rst, clk, Rs1DH, Rs2DH, RS1E, RS2E, RDE,
    PCSrcE, ResultSrcE,
    RDM,
    RegWriteM,
    RdW,
    RegWriteW,
    StallF, StallD, FlushD, FlushE, 
    ForwardAE, ForwardBE );


endmodule