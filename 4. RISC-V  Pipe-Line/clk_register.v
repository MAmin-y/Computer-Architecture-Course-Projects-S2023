module pc_register(input [31:0] Pc, input clk, rst, EN, output reg[31:0] out);

	always@(posedge clk)begin
		if(rst)
			out <= 32'b0;
		else if(~EN) // because of the bubble in the datapath
			out <= Pc;
		else
			out <= out;
	end
		
endmodule	