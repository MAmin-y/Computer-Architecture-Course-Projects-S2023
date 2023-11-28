module data_path (
    input clk, rst, RegWrite, ALUSrc, MemWrite, 
    input [1:0] ResultSrc, PCSrc,
    input [2:0] ImmSrc, ALUControl,
    output Zero, ALUResult_sign,
    output [6:0] op, func7,
    output [2:0] func3
);

    wire[31:0] PCNext, PC, PCPlus4, Inst, SrcA, RD2, SrcB, Imm_Ext, ALUResult, PCTarget, ReadData, Result;

    three_to_one_mux next_pc(PCPlus4, PCTarget, ALUResult, PCSrc, PCNext);
    pc_register pc_reg(PCNext, clk, rst, PC);
    instruction_memory inst_mem({2'b00,PC[31:2]}, clk, rst, Inst);
    register_file reg_file(Inst[19:15], Inst[24:20], Inst[11:7], Result, clk, RegWrite, SrcA, RD2);
    two_to_one_mux alu_op(RD2, Imm_Ext, ALUSrc, SrcB);
    adder pc_add_four(PC, {{29{1'b0}},3'b100}, PCPlus4);
    immidiate_extend imm(Inst[31:7], ImmSrc, Imm_Ext);
    alu t_alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
    adder pc_imm(PC, Imm_Ext, PCTarget);
    data_memory dm(clk, rst, {2'b00,ALUResult[31:2]}, RD2, MemWrite, ReadData);
    four_to_one_mux result_mux(ALUResult, ReadData, PCPlus4, Imm_Ext, ResultSrc, Result);

    assign ALUResult_sign = ALUResult[31];
    assign op = Inst[6:0];
    assign func3 = Inst[14:12];
    assign func7 = Inst[31:25];

endmodule
