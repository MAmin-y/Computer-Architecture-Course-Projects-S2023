module data_path(
    input clk, rst, RegWrite, PcWrite, IrWrite, AdrSrc, MemWrite,
    input [1:0] ResultSrc, ALUSrcA, ALUSrcB,
    input [2:0] ImmSrc, ALUControl,
    output Zero, sign,
    output [6:0] op, func7,
    output [2:0] func3
);
	
	wire [31:0] Result, PC, Adr, WriteData, ReadData, OldPc, Inst, RD1, RD2, A, SrcA, SrcB, ImmExt, ALUResult, ALUOut, Data;

	pc_register PR(Result, clk, PcWrite, rst, PC);
	two_to_one_mux TTOM(PC, Result, AdrSrc, Adr);
	data_memory IDM(clk, rst, {2'b00,Adr[31:2]}, WriteData, MemWrite, ReadData);
	instruction_reg IR(PC, ReadData, clk, rst, IrWrite, OldPc, Inst);
	register_file RF(Inst[19:15], Inst[24:20], Inst[11:7], Result, clk, RegWrite, RD1, RD2);
	register AR(RD1, clk, rst, A);
	register BR(RD2, clk, rst, WriteData);
	three_to_one_mux AM(PC, OldPc, A, ALUSrcA, SrcA);
	three_to_one_mux BM(WriteData, ImmExt, {{29{1'b0}},3'b100}, ALUSrcB, SrcB);
	alu ALU(SrcA, SrcB, ALUControl, ALUResult, Zero, sign);
	register ALUR(ALUResult, clk, rst, ALUOut);
	four_to_one_mux FTOM(ALUOut, Data, ALUResult, ImmExt, ResultSrc, Result);
	register MDR(ReadData, clk, rst, Data);
	immidiate_extend IE(Inst[31:7], ImmSrc, ImmExt);

	assign op = Inst[6:0];
    	assign func3 = Inst[14:12];
    	assign func7 = Inst[31:25];

endmodule