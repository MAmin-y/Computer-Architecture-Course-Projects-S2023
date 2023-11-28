module register(input [31:0] Input, input clk, rst, output reg[31:0] out);

	always@(posedge clk)begin
		if(rst)
			out <= 32'b0;
		else
			out <= Input;
	end
		
endmodule	