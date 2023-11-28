module new_top_level(input clk, rst);

wire RegWrite, ALUSrc, MemWrite;
wire [1:0] ResultSrc, PCSrc;
wire [2:0] ImmSrc, ALUControl;
wire Zero, ALUResult_sign;
wire [6:0] op, func7;
wire [2:0] func3;

data_path DP(clk, rst, RegWrite, ALUSrc, MemWrite, ResultSrc, PCSrc, ImmSrc, ALUControl, Zero, ALUResult_sign, op, func7, func3);
controller C(clk, Zero, ALUResult_sign, func3, op, func7, MemWrite, ALUSrc, RegWrite, PCSrc, ResultSrc, ALUControl, ImmSrc);

endmodule