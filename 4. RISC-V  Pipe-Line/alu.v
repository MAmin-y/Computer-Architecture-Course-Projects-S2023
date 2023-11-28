module alu(input [31:0] SrcA, SrcB, input [2:0] ALUControl, output reg[31:0] ALUResult, output Zero);
	
	always @(SrcA, SrcB, ALUControl)begin
		ALUResult = 32'b0;
		case (ALUControl)
			3'b000 : ALUResult = SrcA + SrcB;
			3'b001 : ALUResult = SrcA - SrcB;
			3'b010 : ALUResult = SrcA & SrcB;
			3'b011 : ALUResult = SrcA | SrcB;
			3'b100 : ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0; // slt
			3'b101 : ALUResult = SrcA ^ SrcB;
			default : ALUResult = 32'b0;
		endcase

	end
	assign Zero = ~|ALUResult;
endmodule