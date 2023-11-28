module pc_register(input [31:0] Pc, input clk, rst, output reg[31:0] out);

	always@(posedge clk)begin
		if(rst)
			out <= 32'b0;
		else
			out <= Pc;
	end
		
endmodule	