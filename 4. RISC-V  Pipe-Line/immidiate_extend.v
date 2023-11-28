module immidiate_extend(input [24:0] imm_input, input [2:0] ImmSrc, output reg[31:0] imm_output);

always@(imm_input, ImmSrc)begin
	case(ImmSrc)
		3'b000 : imm_output = {{20{imm_input[24]}}, imm_input[24:13]}; // I type
		3'b001 : imm_output = {{20{imm_input[24]}}, imm_input[24:18], imm_input[4:0]}; // S type
		3'b010 : imm_output = {{19{imm_input[24]}}, imm_input[24], imm_input[0], imm_input[23:18], imm_input[4:1], 1'b0}; // B type
		3'b011 : imm_output = {imm_input[24:5], 12'b0}; // U type
		3'b100 : imm_output = {{12{imm_input[24]}}, imm_input[24], imm_input[12:5], imm_input[13], imm_input[23:14], 1'b0}; // J type
	endcase
end

endmodule