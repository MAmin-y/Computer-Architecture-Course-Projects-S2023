`define IF 0
`define ID 1
`define EX1 2
`define EX2 3
`define EX3 4
`define EX4 5
`define EX5 6
`define EX6 7
`define EX7 8
`define EX8 9
`define mem1 10
`define mem2 11
`define mem3 12
`define mem4 13
`define mem5 14
`define mem6 15
`define WB1 16
`define WB2 17
`define WB3 18

module controller(input Zero, sign, clk, rst,
	input[2:0] func3, 
	input[6:0] op, func7,
	output reg MemWrite, AdrSrc, RegWrite, PcWrite, IrWrite, 
	output reg [1:0] ALUSrcA, ALUSrcB, ResultSrc, 
	output reg [2:0] ALUControl, ImmSrc
);

	reg[4:0] ns, ps;

	always@(posedge clk)begin
		$display(ps);
		if (rst) ps = 5'b0;
		else ps <= ns;
	end

	always@(ps, Zero, sign, func3, op, func7)begin
	    MemWrite = 1'b0; AdrSrc = 1'b0; RegWrite = 1'b0; PcWrite = 1'b0; IrWrite = 1'b0; ALUSrcA = 2'b00; ALUSrcB = 2'b00; ResultSrc = 2'b00; ALUControl = 3'b000; ImmSrc = 3'b000;
	    case(ps)

	        `IF: begin AdrSrc = 1'b0; IrWrite = 1'b1; ALUSrcA = 2'b00; ALUSrcB = 2'b10; ALUControl = 3'b000; ResultSrc = 2'b10; PcWrite = 1'b1; end
		
		`ID: begin ALUSrcA = 2'b01; ALUSrcB = 2'b01; ALUControl = 3'b000; ImmSrc = 3'b010; end

		`EX1:begin ALUSrcA = 2'b10; ALUSrcB = 2'b00; ALUControl = 3'b001; ResultSrc = 2'b00; 
			   if(func3 == 3'b000 && Zero) PcWrite = 1'b1; //beq
			   else if(func3 == 3'b001 && ~Zero) PcWrite = 1'b1; //bnq
			   else if(func3 == 3'b100 && sign) PcWrite = 1'b1; //blt
			   else if(func3 == 3'b101 && ~sign) PcWrite = 1'b1; //bge
		     end

		`EX2:begin ResultSrc = 2'b11; ImmSrc = 3'b011; RegWrite = 1'b1; end

		`EX3:begin ImmSrc = 3'b001; ALUSrcA = 2'b10; ALUSrcB = 2'b01; ALUControl = 3'b000; end

		`EX4:begin ALUSrcA = 2'b10; ALUSrcB = 2'b00; 
			   if(op == 7'b0110011 && func3 == 3'b000 && func7 == 7'b0000000) ALUControl = 3'b000; //add
			   else if(func3 == 3'b000 && func7 == 7'b0100000) ALUControl = 3'b001; //sub
			   else if(func3 == 3'b111 && func7 == 7'b0000000) ALUControl = 3'b010; //and
			   else if(func3 == 3'b110 && func7 == 7'b0000000) ALUControl = 3'b011; //or
			   else if(func3 == 3'b010 && func7 == 7'b0000000) ALUControl = 3'b100; //slt
		     end

		`EX5:begin ALUSrcA = 2'b10; ALUSrcB = 2'b01; ImmSrc = 3'b000;
			   if(func3 == 3'b000) ALUControl = 3'b000; //addi
			   else if(func3 == 3'b100) ALUControl = 3'b101; //xori
			   else if(func3 == 3'b110) ALUControl = 3'b011; //ori
			   else if(func3 == 3'b010) ALUControl = 3'b100; //slti
		     end

		`EX6:begin ALUSrcA = 2'b10; ALUSrcB = 2'b01; ALUControl = 3'b000; ImmSrc = 3'b000; end //lw

		`EX7:begin ALUSrcA = 2'b01; ALUSrcB = 2'b01; ALUControl = 3'b000; ImmSrc = 3'b100; end //jal

		`EX8:begin ALUSrcA = 2'b10; ALUSrcB = 2'b01; ALUControl = 3'b000; ImmSrc = 3'b000; end //jalr      

		`mem1:begin MemWrite = 1'b1; ResultSrc = 2'b00; AdrSrc = 1'b1; end

		`mem2:begin RegWrite = 1'b1; ResultSrc = 2'b00; end

		`mem3:begin RegWrite = 1'b1; ResultSrc = 2'b00; end

		`mem4:begin ResultSrc = 2'b00; AdrSrc = 1'b1; end

		`mem5:begin ResultSrc = 2'b00; PcWrite = 1'b1; ALUSrcA = 2'b01; ALUSrcB = 2'b10; ALUControl = 3'b000; end

		`mem6:begin ResultSrc = 2'b00; PcWrite = 1'b1; ALUSrcA = 2'b01; ALUSrcB = 2'b10; ALUControl = 3'b000; end

		`WB1:begin ResultSrc = 2'b01; RegWrite = 1'b1; end

		`WB2:begin ResultSrc = 2'b00; RegWrite = 1'b1; end

		`WB3:begin ResultSrc = 2'b00; RegWrite = 1'b1; end

		endcase

	end

	always@(ps)begin

	    case(ps)

	        `IF: ns = `ID;

		`ID:begin 
			  if(op == 7'b1100011) ns = `EX1; //B_type
			  else if(op == 7'b0110111) ns = `EX2; //lui
			  else if(op == 7'b0100011 && func3 == 3'b010) ns = `EX3; //sw
			  else if(op == 7'b0110011) ns = `EX4; //R_type
			  else if(op == 7'b0010011) ns = `EX5; //I_type: addi, xori, ori, slti
			  else if(op == 7'b0000011 && func3 == 3'b010) ns = `EX6; //lw
			  else if(op == 7'b1101111) ns = `EX7; //jal
			  else if(op == 7'b1100111 && func3 == 3'b000) ns = `EX8; //jalr

		end

		`EX1: ns = `IF;

		`EX2: ns = `IF;

		`EX3: ns = `mem1;

		`EX4: ns = `mem2;

		`EX5: ns = `mem3;

		`EX6: ns = `mem4;

		`EX7: ns = `mem5;

		`EX8: ns = `mem6;

		`mem1: ns = `IF;

		`mem2: ns = `IF;

		`mem3: ns = `IF;

		`mem4: ns = `WB1;

		`mem5: ns = `WB2;

		`mem6: ns = `WB3;

		`WB1: ns = `IF;

		`WB2: ns = `IF;

		`WB3: ns = `IF;

	    endcase

	end

endmodule