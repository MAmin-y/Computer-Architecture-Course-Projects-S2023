module top_level(input clk, rst);

wire RegWrite, PcWrite, IrWrite, AdrSrc, MemWrite, Zero, sign;
wire [1:0] ResultSrc, ALUSrcA, ALUSrcB;
wire [2:0] ImmSrc, ALUControl, func3;
wire [6:0] op, func7;

data_path DP(clk, rst, RegWrite, PcWrite, IrWrite, AdrSrc, MemWrite, ResultSrc, ALUSrcA, ALUSrcB, ImmSrc, ALUControl, Zero, sign, op, func7, func3);
controller C(Zero, sign, clk, rst, func3, op, func7, MemWrite, AdrSrc, RegWrite, PcWrite, IrWrite, ALUSrcA, ALUSrcB, ResultSrc, ALUControl, ImmSrc);

endmodule
