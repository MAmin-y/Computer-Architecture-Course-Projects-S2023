module fetch_register(input [31:0] InstrF, PCF, PCPlus4F, 
		      input clk, EN, CLR, 
		      output reg[31:0] InstrD, PCD, PCPlus4D);

	always@(posedge clk)begin

		if(CLR)begin
			InstrD = 32'b0;
			PCD = 32'b0;
			PCPlus4D = 32'b0;
		end
		else if(~EN)begin
			InstrD = InstrF;
			PCD = PCF;
			PCPlus4D = PCPlus4F;
		end
		else begin
			InstrD = InstrD;
			PCD = PCD;
			PCPlus4D = PCPlus4D;
		end
	end

endmodule